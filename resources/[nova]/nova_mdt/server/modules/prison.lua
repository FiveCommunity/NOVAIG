local prisonCache = {}
local adminPrisonCache = {}

---@param source number
---@param userId number
local function sendChatMessage(source, userId)
    if not userId then
        return 
    end 
    TriggerClientEvent('chatMessage', source, {
        prefix = 'PENINTÊNCIARIA:',
        prefixColor = '#000',
        title = 'PRISÃO',
        message = 'Ainda restam ' .. (prisonCache[userId] or adminPrisonCache[userId] or 0) .. ' mês(es) de prisão.'
    })
end

---@param source number
local function teleportToPrison(source)
    local playerPed = GetPlayerPed(source)
    local distanceToPrison = #(GetEntityCoords(playerPed) - Config.prisonCoord)
    if distanceToPrison > 140 and not Player(source).state.inPvP then
        SetEntityCoords(playerPed, Config.prisonCoord)
    end
end

---@param source number
local function teleportOutOfPrison(source)
    local playerPed = GetPlayerPed(source)
    SetEntityCoords(playerPed, Config.releaseCoord)
end

---@param source number
local function healIfNecessary(source)
    local playerPed = GetPlayerPed(source)
    if GetEntityHealth(playerPed) <= 101 then
        vRPclient._setHealth(source, 300)
    end
end

---@param source number
local function validateUserInValidArrestCoords(source)
    local playerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerPed)
    for _, coordsData in ipairs(Config.ArrestLocations) do 
        local distance = #(coordsData.coordinate - playerCoords)
        if distance <= coordsData.range then
            return true 
        end
    end

    return false
end

---@param userId number
---@return boolean
local function decrementPrisonTime(userId)
    if not prisonCache[userId] then return false end
    prisonCache[userId] = prisonCache[userId] - 1
    if prisonCache[userId] <= 0 then
        prisonCache[userId] = nil
        exports.oxmysql:execute('DELETE FROM vrp_user_data WHERE user_id = ? AND dkey = ?', { userId, 'mdt:prison' })
        return true
    end
    return false
end

---@param userId number
---@return boolean
local function decrementAdminPrisonTime(userId)
    if not adminPrisonCache[userId] then return false end
    adminPrisonCache[userId] = adminPrisonCache[userId] - 1
    if adminPrisonCache[userId] <= 0 then
        adminPrisonCache[userId] = nil
        exports.oxmysql:execute('DELETE FROM vrp_user_data WHERE user_id = ? AND dkey = ?', { userId, 'mdt:admin_prison' })
        return true
    end
    return false
end

---@param userId number
---@return void
local function startPrisonTimer(userId)
    CreateThread(function()
        while prisonCache[userId] and prisonCache[userId] > 0 do
            Wait(60000)
            local source = vRP.getUserSource(userId)
            if not source then
                return
            end

            if decrementPrisonTime(userId) then
                teleportOutOfPrison(source)
                TriggerClientEvent('Notify', source, 'sucesso', 'Você foi liberado da prisão.')
                Player(source).state:set("isInPrison", false, true)
                return
            end

            sendChatMessage(source, userId)
        end
    end)

    CreateThread(function()
        while prisonCache[userId] and prisonCache[userId] > 0 do
            local source = vRP.getUserSource(userId)
            if not source then
                return
            end

            teleportToPrison(source)
            healIfNecessary(source)
            Wait(10000)
        end
    end)
end

---@param userId number
---@return void
local function startAdminPrisonTimer(userId)
    CreateThread(function()
        while adminPrisonCache[userId] and adminPrisonCache[userId] > 0 do
            Wait(60000)
            local source = vRP.getUserSource(userId)
            if not source then
                return
            end

            if decrementAdminPrisonTime(userId) then
                teleportOutOfPrison(source)
                TriggerClientEvent('Notify', source, 'sucesso', 'Você foi liberado da prisão.')
                Player(source).state:set("isInAdminPrison", false, true)
                return
            end

            sendChatMessage(source, userId) 
        end
    end)

    CreateThread(function()
        while adminPrisonCache[userId] and adminPrisonCache[userId] > 0 do
            local source = vRP.getUserSource(userId)
            if not source then
                return
            end

            teleportToPrison(source)
            healIfNecessary(source)
            Wait(10000)
        end
    end)
end

---@param source number
---@param userId number
---@return void
local function imprisonUser(source, userId)
    local playerPed = GetPlayerPed(source)
    local playerModel = GetEntityModel(playerPed)
    
    SetEntityCoords(playerPed, Config.prisonCoord)
    vRPclient._setHandcuffed(source, false)
    ClearPedTasksImmediately(playerPed)

    if Config.prisonClothes[playerModel] then
        for _, clothingItem in ipairs(Config.prisonClothes[playerModel]) do
            SetPedComponentVariation(playerPed, table.unpack(clothingItem))
        end
        SetPedPropIndex(playerPed, 0, -1, 0, 0)
        SetPedPropIndex(playerPed, 6, -1, 0, 0)
    end
end

---@param targetUserId number
---@return table|boolean
function ServerAPI.getUserForArrest(targetUserId)
    local source = source
    local userId = validateUserAndOrganization(source)
    if not userId then return false end

    local targetIdentity = vRP.getUserIdentity(targetUserId)
    if not targetIdentity then return false end

    return {
        name = getUserName(targetUserId),
        image = getInstagramImage(targetUserId),
    }
end

---@param crimes table
---@param targetUserId number
---@param userId number
---@return void
local function recordCrimes(crimes, targetUserId, userId)
    local currentTime = os.time()
    for _, crimeData in pairs(crimes) do
        exports.oxmysql:execute('INSERT INTO mdt_criminal_records(user_id, officer_id, description, date) VALUES (?, ?, ?, ?)', 
            { targetUserId, userId, crimeData.name, currentTime })
    end
end

---@param reason string
---@param targetUserId number
---@param userId number
---@return void
local function recordStaffCrimes(reason, targetUserId, userId)
    local currentTime = os.time()
    exports.oxmysql:execute('INSERT INTO mdt_staff_criminal_records(user_id, officer_id, description, date) VALUES (?, ?, ?, ?)', 
            { targetUserId, userId, reason, currentTime })
end

---@param tbl table
---@param func function
---@return table
function table.map(tbl, func)
    local newTable = {}
    for i, v in ipairs(tbl) do
        newTable[i] = func(v)
    end
    return newTable
end

---@param userId number
---@param targetUserId number
---@param crimes table
---@param mitigatingFactors table
---@param months number
---@param totalFine number
local function sendPrisonLog(userId, targetUserId, crimes, mitigatingFactors, months, totalFine)
    local crimeDescription = ""
    for i, c in ipairs(crimes) do
        crimeDescription = crimeDescription .. c.name
        if i < #crimes then
            crimeDescription = crimeDescription .. ', '
        end
    end

    local mitigatingDescription = ""
    for i, m in ipairs(mitigatingFactors) do
        mitigatingDescription = mitigatingDescription .. m.name
        if i < #mitigatingFactors then
            mitigatingDescription = mitigatingDescription .. ', '
        end
    end

    vRP.sendLog(Config.Webhooks.prison, string.format(
        '```prolog\n[ID]: %s\n[PRENDEU]: %s\n[MOTIVO]: %s\n[ATENUANTES]: %s\n[TEMPO]: %d Mês(es)\n[MULTAS]: R$%d```',
        userId, targetUserId, crimeDescription, mitigatingDescription, months, totalFine
    ))
end

---@param targetUserId number
---@param months number
---@param bail number
---@param totalFine number
---@param totalBail number
---@param crimes table
---@param mitigatingFactors table
---@return boolean
function ServerAPI.arrestUser(targetUserId, months, bail, totalFine, totalBail, crimes, mitigatingFactors)
    local source = source
    local userId = validateUserAndOrganization(source)
    if not userId then return false end

    local organization = getUserOrganization(userId)
    if not organization then return false end

    local targetIdentity = vRP.getUserIdentity(targetUserId)
    if not targetIdentity then return false end

    if not validateUserInValidArrestCoords(source) then
        TriggerClientEvent('Notify', source, 'negado', 'Você não está em uma área válida para prender alguém.')
        return false
    end

    if months <= 0 or totalFine < 0 or totalBail < 0 then
        return false
    end

    if prisonCache[targetUserId] or adminPrisonCache[targetUserId] then
        TriggerClientEvent('Notify', source, 'negado', 'Este cidadão já está preso.')
        return false
    end

    if months > 360 then
        TriggerClientEvent('Notify', source, 'negado', 'A pena total não pode ser superior a 360 meses')
        return false
    end

    recordCrimes(crimes, targetUserId, userId)

    local currentFines = getUserFines(targetUserId)
    vRP.updateMultas(targetUserId, currentFines + totalFine)

    local targetSource = vRP.getUserSource(targetUserId)
    if targetSource and bail and totalBail > 0 then
        if vRP.request(targetSource, 'Você deseja pagar uma fiança de R$' .. totalBail .. '?', 30) then
            if vRP.tryFullPayment(targetUserId, totalBail) then
                return true
            end
        end
    end

    prisonCache[targetUserId] = (prisonCache[targetUserId] or 0) + months
    vRP.setUData(targetUserId, 'mdt:prison', json.encode(prisonCache[targetUserId]))

    if targetSource then
        imprisonUser(targetSource, targetUserId)
        startPrisonTimer(targetUserId)
        sendChatMessage(targetSource, targetUserId)
        Player(targetSource).state:set("isInPrison", true, true)

        vRP.clearInventory(targetUserId)
        vRP.clearWeapons(targetUserId)
        vRPclient._replaceWeapons(targetSource,{})
    end

    sendPrisonLog(userId, targetUserId, crimes, mitigatingFactors, months, totalFine)
    addLog(userId, organization, 'Prendeu o cidadão #'..targetUserId..' | '..getUserName(targetUserId)..' por ' .. months .. ' mês(es)')

    local nIdentity = vRP.getUserIdentity(targetUserId)
    if nIdentity then
        TriggerClientEvent('chatMessage', -1, {
            prefix = 'PENINTÊNCIARIA:',
            prefixColor = '#000',
            title = 'PRISÃO',
            message = 'O ' .. nIdentity.nome .. ' ' .. nIdentity.sobrenome .. ' foi preso(a) por ' .. months .. ' meses'
        })
    end

    TriggerClientEvent('Notify', source, 'sucesso', 'Cidadão preso com sucesso.')

    if GetResourceState('nova_escape') == 'started' then
        exports.nova_escape:removeTracker(targetUserId)
    end

    return false
end

AddEventHandler('vRP:playerSpawn', function(userId, source, firstSpawn)
    if prisonCache[userId] then
        imprisonUser(source, userId)
        startPrisonTimer(userId)
        sendChatMessage(source, userId)
        Player(source).state:set("isInPrison", true, true)
    end

    if adminPrisonCache[userId] then
        imprisonUser(source, userId)
        startAdminPrisonTimer(userId)
        sendChatMessage(source, userId)
        Player(source).state:set("isInAdminPrison", true, true)
    end
end)

AddEventHandler('vRP:playerLeave', function(userId, source)
    if prisonCache[userId] then
        exports.oxmysql:execute('UPDATE vrp_user_data SET dvalue = ? WHERE user_id = ? AND dkey = ?', 
            { json.encode(prisonCache[userId]), userId, 'mdt:prison' })
    end

    if adminPrisonCache[userId] then
        exports.oxmysql:execute('UPDATE vrp_user_data SET dvalue = ? WHERE user_id = ? AND dkey = ?', 
            { json.encode(adminPrisonCache[userId]), userId, 'mdt:admin_prison' })
    end
end)

RegisterCommand('prenderadm', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    local perms = {
        { permType = 'group', perm = 'TOP1' },
        { permType = 'group', perm = 'developerlotusgroup@445' },
        { permType = 'group', perm = 'respilegallotusgroup@445' },
        { permType = 'group', perm = 'resppolicialotusgroup@445' },
        { permType = 'perm', perm = 'admin.permissao' },
        { permType = 'perm', perm = 'moderador.permissao' },
        { permType = 'perm', perm = 'suporte.permissao' },
    }
    
    local hasPermission = false
    for _, perm in ipairs(perms) do
        if perm.permType == 'perm' then
            if vRP.hasPermission(userId, perm.perm) then
                hasPermission = true
                break
            end
        elseif perm.permType == 'group' then
            if vRP.hasGroup(userId, perm.perm) then
                hasPermission = true
                break
            end
        end
    end

    if not hasPermission then
        return
    end	

    local nuserId = tonumber(vRP.prompt(source, 'ID do cidadão:', ''))
    if not nuserId then return end

    if prisonCache[nuserId] or adminPrisonCache[nuserId] then
        TriggerClientEvent('Notify', source, 'negado', 'Este cidadão já está preso.')
        return
    end

    local months = tonumber(vRP.prompt(source, 'Meses:', ''))
    if not months then return end

    local reason = vRP.prompt(source, 'Motivo:', '')
    if not reason or reason == '' then return end

    local nSource = vRP.getUserSource(nuserId)
    adminPrisonCache[nuserId] = months
    vRP.setUData(nuserId, 'mdt:admin_prison', json.encode(adminPrisonCache[nuserId]))

    if nSource then
        imprisonUser(nSource, nuserId)
        startAdminPrisonTimer(nuserId)
        sendChatMessage(nSource, nuserId)
        Player(nSource).state:set("isInAdminPrison", true, true)
        
        vRP.clearInventory(nuserId)
        vRP.clearWeapons(nuserId)
        vRPclient._replaceWeapons(nSource,{})
    end
    
    TriggerClientEvent('Notify', source, 'sucesso', 'Cidadão preso com sucesso.')
    
    vRP.sendLog('https://discord.com/api/webhooks/1313516342288322570/TcxDd-PxcT0-yQYkuLAp-1VzYzFonDf4BNDnmtJpJ4BCfKiMD5oTjAhIJrxX-kZh74i0', '```prolog\n[ID]: '..userId..'\n[PRENDEU]: '..nuserId..'\n[MOTIVO]: '..reason..'\n[TEMPO]: '..months..' Mês(es)```')
    exports["vrp_admin"]:generateLog({
        category = "admin",
        room = "prenderadm",
        user_id = nuserId,
        message = 'O cidadão #'..nuserId..' foi preso por '..months..' mês(es) pelo administrador #'..userId..' pelo motivo: '..reason
    })
    recordStaffCrimes(reason, nuserId, userId)

    local nIdentity = vRP.getUserIdentity(nuserId)
    TriggerClientEvent('chatMessage', -1, {
        prefix = 'STAFF:',
        prefixColor = '#000',
        title = 'PRISÃO ADM',
        message = 'O ' .. nIdentity.nome .. ' ' .. nIdentity.sobrenome .. ' foi preso(a) por ' .. months .. ' meses pelo motivo: ' .. reason,
    })
    

    if GetResourceState('nova_escape') == 'started' then
        exports.nova_escape:removeTracker(nuserId)
    end
end)

RegisterCommand('revprisao', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    local allowedIds = {
        [979] = true,
        [66] = true,
    }
    local perms = {
        { permType = 'group', perm = 'TOP1' },
        { permType = 'group', perm = 'developerlotusgroup@445' },
    }
    
    local hasPermission = false
    for _, perm in ipairs(perms) do
        if perm.permType == 'perm' then
            if vRP.hasPermission(userId, perm.perm) then
                hasPermission = true
                break
            end
        elseif perm.permType == 'group' then
            if vRP.hasGroup(userId, perm.perm) then
                hasPermission = true
                break
            end
        end
    end

    if allowedIds[userId] then
        hasPermission = true
    end
    
    if not hasPermission then
        return
    end	

    local nuserId = tonumber(vRP.prompt(source, 'ID do cidadão:', ''))
    if not nuserId then return end

    prisonCache[nuserId] = nil
    adminPrisonCache[nuserId] = nil
    exports.oxmysql:execute('DELETE FROM vrp_user_data WHERE user_id = ? AND dkey = ?', { nuserId, 'mdt:prison' })
    exports.oxmysql:execute('DELETE FROM vrp_user_data WHERE user_id = ? AND dkey = ?', { nuserId, 'mdt:admin_prison' })

    local nSource = vRP.getUserSource(nuserId)
    if nSource then
        teleportOutOfPrison(nSource)
        TriggerClientEvent('Notify', nSource, 'sucesso', 'Você foi liberado da prisão.')
        Player(nSource).state:set("isInPrison", false, true)
        Player(nSource).state:set("isInAdminPrison", false, true)
    end

    TriggerClientEvent('Notify', source, 'sucesso', 'Cidadão liberado da prisão.')

    vRP.sendLog('https://discord.com/api/webhooks/1330659677658284153/A1T1WFqN3Cqz8QmDJJLOEihG6pL7H7qcs_8LHhjPe2KNgNg8IO9z-PVtZJSUJ5BRQ3Iz', '```prolog\n[ID]: '..userId..'\n[LIBEROU]: '..nuserId..'```')
    exports["vrp_admin"]:generateLog({
        category = "admin",
        room = "revprisao",
        user_id = userId,
        message = 'O cidadão #'..nuserId..' foi liberado da prisão pelo administrador #'..userId
    })
end)

exports('revprisao', function(userId)
    prisonCache[userId] = nil
    adminPrisonCache[userId] = nil
    exports.oxmysql:execute('DELETE FROM vrp_user_data WHERE user_id = ? AND dkey = ?', { userId, 'mdt:prison' })
    exports.oxmysql:execute('DELETE FROM vrp_user_data WHERE user_id = ? AND dkey = ?', { userId, 'mdt:admin_prison' })

    local nSource = vRP.getUserSource(userId)
    if nSource then
        teleportOutOfPrison(nSource)
        TriggerClientEvent('Notify', nSource, 'sucesso', 'Você foi liberado da prisão.')
        Player(nSource).state:set("isInPrison", false, true)
        Player(nSource).state:set("isInAdminPrison", false, true)
    end
end)

RegisterCommand('revprisaopm', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    local perms = {
        { permType = 'group', perm = 'TOP1' },
        { permType = 'group', perm = 'developerlotusgroup@445' },
        { permType = 'group', perm = 'resppolicialotusgroup@445' },
        { permType = 'group', perm = 'respilegallotusgroup@445' },
        { permType = 'group', perm = 'gestaolotusgroup@445' },
        { permType = 'group', perm = 'respstafflotusgroup@445' },
        { permType = 'group', perm = 'resploglotusgroup@445' },
    }

    local hasPermission = false
    for _, perm in ipairs(perms) do
        if perm.permType == 'perm' then
            if vRP.hasPermission(userId, perm.perm) then
                hasPermission = true
                break
            end
        elseif perm.permType == 'group' then
            if vRP.hasGroup(userId, perm.perm) then
                hasPermission = true
                break
            end
        end
    end

    if userId == 979 then
        hasPermission = true
    end
    
    if not hasPermission then
        return
    end	

    local nuserId = tonumber(vRP.prompt(source, 'ID do cidadão:', ''))
    if not nuserId then return end

    prisonCache[nuserId] = nil
    exports.oxmysql:execute('DELETE FROM vrp_user_data WHERE user_id = ? AND dkey = ?', { nuserId, 'mdt:prison' })

    local nSource = vRP.getUserSource(nuserId)
    if nSource then
        teleportOutOfPrison(nSource)
        TriggerClientEvent('Notify', nSource, 'sucesso', 'Você foi liberado da prisão.')
        Player(nSource).state:set("isInPrison", false, true)
    end

    TriggerClientEvent('Notify', source, 'sucesso', 'Cidadão liberado da prisão.')

    vRP.sendLog('', '```prolog\n[ID]: '..userId..'\n[LIBEROU]: '..nuserId..'```')
    exports["vrp_admin"]:generateLog({
        category = "admin",
        room = "revprisao",
        user_id = user_id,
        message = 'O cidadão #'..nuserId..' foi liberado da prisão pelo administrador #'..userId
    })
end)

RegisterCommand('pcheck', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    local perms = {
        { permType = 'group', perm = 'suportelotusgroup@445' },
        { permType = 'group', perm = 'moderadorlotusgroup@445' },
        { permType = 'group', perm = 'adminlotusgroup@445' },
        { permType = 'group', perm = 'respilegallotusgroup@445' },
        { permType = 'group', perm = 'resppolicialotusgroup@445' },
        { permType = 'group', perm = 'respstreamerlotusgroup@445' },
        { permType = 'group', perm = 'respeventoslotusgroup@445' },
        { permType = 'perm', perm = 'developer.permissao' },
    }

    local hasPermission = false
    for _, perm in ipairs(perms) do
        if perm.permType == 'perm' then
            if vRP.hasPermission(userId, perm.perm) then
                hasPermission = true
                break
            end
        elseif perm.permType == 'group' then
            if vRP.hasGroup(userId, perm.perm) then
                hasPermission = true
                break
            end
        end
    end

    if not hasPermission then
        return
    end

    local targetId = tonumber(args[1])
    if not targetId then
        TriggerClientEvent('Notify', source, 'negado', 'ID inválido.')
        return
    end

    local prisonData = prisonCache[targetId] or adminPrisonCache[targetId]
    if not prisonData then
        TriggerClientEvent('Notify', source, 'negado', 'Este jogador não está preso.')
        return
    end

    local targetIdentity = vRP.getUserIdentity(targetId)
    if not targetIdentity then
        TriggerClientEvent('Notify', source, 'negado', 'Jogador não encontrado.')
        return
    end

    local months = prisonCache[targetId] or adminPrisonCache[targetId]
    local isAdminPrison = adminPrisonCache[targetId] ~= nil
    
    local query
    if isAdminPrison then
        query = exports.oxmysql:executeSync('SELECT * FROM mdt_staff_criminal_records WHERE user_id = ? ORDER BY date DESC LIMIT 1', { targetId })
    else
        query = exports.oxmysql:executeSync('SELECT * FROM mdt_criminal_records WHERE user_id = ? ORDER BY date DESC LIMIT 1', { targetId })
    end

    if query and #query > 0 then
        local crime = query[1].description
        local officer = query[1].officer_id
        TriggerClientEvent('chatMessage', source, {
            type = 'staff',
            title = 'PRISAO',
            message = 'O cidadão #'..targetId..' está preso por '..months..' mês(es) por '..crime..' | Oficial: '..officer
        })
    else
        TriggerClientEvent('chatMessage', source, {
            type = 'staff',
            title = 'PRISAO',
            message = 'O cidadão #'..targetId..' está preso por '..months..' mês(es).'
        })
    end
end)

CreateThread(function()
    Wait(2000)
    local query = exports.oxmysql:executeSync('SELECT * FROM vrp_user_data WHERE dkey = ?', { 'mdt:prison' })
    if query and #query > 0 then
        for _, data in ipairs(query) do
            local userId = data.user_id
            local prisonTimeData = json.decode(data.dvalue)
            local prisonTime = type(prisonTimeData) == "number" and prisonTimeData or tonumber(prisonTimeData)
            if prisonTime and prisonTime > 0 then
                prisonCache[userId] = prisonTime
                local targetSource = vRP.getUserSource(userId)
                if targetSource then
                    imprisonUser(targetSource, userId)
                    startPrisonTimer(userId)
                    sendChatMessage(targetSource, userId)
                    Player(targetSource).state:set("isInPrison", true, true)
                end
            else
                exports.oxmysql:execute('DELETE FROM vrp_user_data WHERE user_id = ? AND dkey = ?', 
                    { userId, 'mdt:prison' })
            end
        end
    end

    local query = exports.oxmysql:executeSync('SELECT * FROM vrp_user_data WHERE dkey = ?', { 'mdt:admin_prison' })
    if query and #query > 0 then
        for _, data in ipairs(query) do
            local userId = data.user_id
            local prisonTimeData = json.decode(data.dvalue)
            local prisonTime = type(prisonTimeData) == "number" and prisonTimeData or tonumber(prisonTimeData)
            if prisonTime and prisonTime > 0 then   
                adminPrisonCache[userId] = prisonTime
                local targetSource = vRP.getUserSource(userId)
                if targetSource then
                    imprisonUser(targetSource, userId)
                    startAdminPrisonTimer(userId)
                    sendChatMessage(targetSource, userId)
                    Player(targetSource).state:set("isInAdminPrison", true, true)
                end
            else    
                exports.oxmysql:execute('DELETE FROM vrp_user_data WHERE user_id = ? AND dkey = ?', 
                    { userId, 'mdt:admin_prison' })
            end
        end
    end
end)

exports('prisonEscape', function(userId)
    if not prisonCache[userId] then return true end

    prisonCache[userId] = nil
    exports.oxmysql:execute('DELETE FROM vrp_user_data WHERE user_id = ? AND dkey = ?', { userId, 'mdt:prison' })

    local nSource = vRP.getUserSource(userId)
    if nSource then
        TriggerClientEvent('Notify', nSource, 'sucesso', 'Você foi liberado da prisão.')
        Player(nSource).state:set("isInPrison", false, true)
    end

    return true
end)

AddEventHandler("onResourceStop", function(resource)
    if resource ~= GetCurrentResourceName() then return end
    
    for nuserId, data in pairs(prisonCache) do
        exports.oxmysql:execute('UPDATE vrp_user_data SET dvalue = ? WHERE user_id = ? AND dkey = ?', 
            { json.encode(data), nuserId, 'mdt:prison' })
        -- print('Saved prison data for ' .. nuserId)
    end

    for nuserId, data in pairs(adminPrisonCache) do
        exports.oxmysql:execute('UPDATE vrp_user_data SET dvalue = ? WHERE user_id = ? AND dkey = ?', 
            { json.encode(data), nuserId, 'mdt:admin_prison' })
        -- print('Saved admin prison data for ' .. nuserId)
    end
end)