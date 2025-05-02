local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

ServerAPI = {}
Tunnel.bindInterface(GetCurrentResourceName(), ServerAPI)
ClientAPI = Tunnel.getInterface(GetCurrentResourceName())

local usersCooldown = {}
local trackers = {}

local function getRandomItem()
    local roll = math.random(100)

    if roll >= Config.ProbabilityRanges.NoItem.min and roll <= Config.ProbabilityRanges.NoItem.max then
        return nil
    elseif roll >= Config.ProbabilityRanges.RareItems.min and roll <= Config.ProbabilityRanges.RareItems.max then
        local rareItem = Config.ItemsToEscape.Rare[math.random(#Config.ItemsToEscape.Rare)]
        return rareItem.item
    elseif roll >= Config.ProbabilityRanges.CommonItems.min and roll <= Config.ProbabilityRanges.CommonItems.max then
        local commonItem = Config.ItemsToEscape.Common[math.random(#Config.ItemsToEscape.Common)]
        return commonItem.item
    end

    return nil
end

local function getUserName(userId)
    local identity = vRP.getUserIdentity(userId)
    if identity then
        if identity.nome and identity.sobrenome then
            return identity.nome .. ' ' .. identity.sobrenome
        end
        return identity.nome
    end
    return ''
end

local function notifyOffiers(message)
    CreateThread(function()
        local officers = vRP.getUsersByPermission('perm.disparo')
        for _, officer in ipairs(officers) do
            local officerUserId = tonumber(officer)
            if officerUserId and vRP.checkPatrulhamento(officerUserId) then
                local officerSource = vRP.getUserSource(officerUserId)
                if officerSource then
                    TriggerClientEvent('Notify', officerSource, 'aviso', message, 5000)
                    TriggerClientEvent('chatMessage', officerSource, {
                    prefix = 'PENINTÊNCIARIA:',
                    prefixColor = '#000',
                    title = 'PRISÃO',
                    message = message
                })
                end
            end
        end
    end)
end

local function updateTrackerToOfficer(coords)
    CreateThread(function()
        local officers = vRP.getUsersByPermission('perm.disparo')
        for _, officer in ipairs(officers) do
            local officerUserId = tonumber(officer)
            if officerUserId and vRP.checkPatrulhamento(officerUserId) then
                local officerSource = vRP.getUserSource(officerUserId)
                if officerSource then
                    ClientAPI.addTracker(officerSource, coords)
                end
            end
        end
    end)
end

local function addTrackerToOfficers(userId)
    CreateThread(function()
        local trackerActive = true
        print('Tracker adicionado para o usuário '..userId..' Tempo restante de tracker: '..trackers[userId].time - os.time())
        while (trackers[userId] and trackers[userId].time and trackers[userId].time > os.time() and trackerActive) or trackers[userId].pauseTime do
            local source = vRP.getUserSource(userId)
            if not source then
                Wait(30000)
            else
                if GetEntityHealth(GetPlayerPed(source)) <= 101 then
                    notifyOffiers('O prisioneiro '..userId..' | '..getUserName(userId)..' foi morto')
                    trackerActive = false
                else
                    local coords = GetEntityCoords(GetPlayerPed(source))
                    if coords then
                        updateTrackerToOfficer(coords)
                    end
                end
                Wait(30000)
            end
        end

        trackers[userId] = nil
        local source = vRP.getUserSource(userId)
        if source then
            TriggerClientEvent('Notify', source, 'sucesso', 'Você conseguiu escapar, a sua localização não está mais sendo rastreada.', 5000)
        end
    end)
end

local function addUserTracker(userId, time)
    trackers[userId] = trackers[userId] or {}
    local currentTime = os.time()

    if not trackers[userId].pauseTime then
        trackers[userId].time = (trackers[userId].time or currentTime) + (time * 60)
    else
        local pausedDuration = currentTime - trackers[userId].pauseTime
        trackers[userId].time = math.max(trackers[userId].time + pausedDuration, currentTime + (time * 60))
        trackers[userId].pauseTime = nil
    end

    local userName = getUserName(userId)
    local officers = vRP.getUsersByPermission('perm.disparo')
    for _, officer in ipairs(officers) do
        local officerUserId = tonumber(officer)
        if officerUserId and vRP.checkPatrulhamento(officerUserId) then
            local officerSource = vRP.getUserSource(officerUserId)
            if officerSource then
                TriggerClientEvent('Notify', officerSource, 'aviso', 'O prisioneiro '..userId..' | '..userName..' escapou da prisão, vá até o local indicado no mapa para capturá-lo', 5000)
                TriggerClientEvent('chatMessage', officerSource, {
                    prefix = 'PENINTÊNCIARIA:',
                    prefixColor = '#000',
                    title = 'PRISÃO',
                    message = 'O prisioneiro '..userId..' | '..userName..' escapou da prisão, vá até o local indicado no mapa para capturá-lo'
                })
            end
        end
    end

    addTrackerToOfficers(userId)
end

function ServerAPI.collectTrash(trashIndex)
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then return end

    if not Player(source).state.isInPrison then return end

    if usersCooldown[userId] and usersCooldown[userId][trashIndex] then
        if os.time() - usersCooldown[userId][trashIndex] < Config.TrashCooldown then
            TriggerClientEvent('Notify', source, 'negado', 'Aguarde ' .. Config.TrashCooldown - (os.time() - usersCooldown[userId][trashIndex]) .. ' segundos para coletar o lixo novamente.', 5000)
            return false
        end
    end

    usersCooldown[userId] = usersCooldown[userId] or {}
    usersCooldown[userId][trashIndex] = os.time()

    local coords = GetEntityCoords(GetPlayerPed(source))
    local trashCoords = Config.TrashLocations[trashIndex]
    local distance = #(coords - trashCoords)
    if distance > 3.0 then return end

    local item = getRandomItem()
    if not item then
        TriggerClientEvent('Notify', source, 'negado', 'Você não encontrou nada, mais sorte na próxima!', 5000)
        return false
    end

    vRP.giveInventoryItem(userId, item, 1, true)

    local hasAllItems = true
    for i = 1, #Config.CraftNecessaryItems do
        local craftItem = Config.CraftNecessaryItems[i]
        local amount = vRP.getInventoryItemAmount(userId, craftItem.item) or 0
        if craftItem.amount - amount > 0 then
            hasAllItems = false
            TriggerClientEvent('Notify', source, 'aviso', 'Faltam ' .. craftItem.amount - amount .. ' ' .. vRP.getItemName(craftItem.item) .. ' para você conseguir fabricar o item necessário para fugir da prisão.', 5000)
        end
    end

    if hasAllItems then
        TriggerClientEvent('Notify', source, 'sucesso', 'Você já possui todos os itens necessários! Procure um local para fabricar o item.', 5000)
    end

    return true
end

function ServerAPI.craftItem(craftIndex)
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then return end

    if not Player(source).state.isInPrison then return end
    
    local coords = GetEntityCoords(GetPlayerPed(source))
    local craftCoords = Config.CraftLocations[craftIndex]
    local distance = #(coords - craftCoords)
    if distance > 3.0 then return end

    for i = 1, #Config.CraftNecessaryItems do
        local item = Config.CraftNecessaryItems[i]
        if vRP.getInventoryItemAmount(userId, item.item) < item.amount then
            TriggerClientEvent('Notify', source, 'negado', 'Você não possui '..item.amount..' '..vRP.getItemName(item.item), 5000)
            return false
        end
    end

    for i = 1, #Config.CraftNecessaryItems do
        local item = Config.CraftNecessaryItems[i]
        vRP.tryGetInventoryItem(userId, item.item, item.amount, true, false)
    end

    vRP.giveInventoryItem(userId, Config.CraftItem, 1, true)
    return true
end

function ServerAPI.escapePrison(escapeIndex)
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then return end

    if not Player(source).state.isInPrison then return end
    
    local coords = GetEntityCoords(GetPlayerPed(source))
    local escapeCoords = Config.EscapeLocations[escapeIndex]
    local distance = #(coords - escapeCoords)
    if distance > 3.0 then return end

    if not vRP.tryGetInventoryItem(userId, Config.CraftItem, 1, true, false) then
        TriggerClientEvent('Notify', source, 'negado', 'Você não possui o item necessário para escapar.', 5000)
        return false
    end

    exports.nova_mdt:prisonEscape(userId)
    addUserTracker(userId, Config.PrisonEscapeTime)
    TriggerClientEvent('Notify', source, 'sucesso', 'Parabens, você conseguiu escapar da prisão! Fique atento pois o seu rastreador ainda está ativo para os policiais por '..Config.PrisonEscapeTime..' minutos.', 5000)
    return true
end

AddEventHandler('vRP:playerLeave',function(userId)
    local source = source
    local userId = vRP.getUserId(source)
    if userId and trackers[userId] then
        trackers[userId].pauseTime = os.time()
    end
end)

AddEventHandler('vRP:playerSpawn',function(userId)
    if userId and trackers[userId] then
        addUserTracker(userId, 0)
    end
end)

exports('removeTracker', function(userId)
    if not trackers[userId] then return end
    
    trackers[userId] = nil
    local officers = vRP.getUsersByPermission('perm.disparo')
    for _, officer in ipairs(officers) do
        local officerUserId = tonumber(officer)
        if officerUserId and vRP.checkPatrulhamento(officerUserId) then
            local officerSource = vRP.getUserSource(officerUserId)
            if officerSource then
                TriggerClientEvent('Notify', officerSource, 'sucesso', 'O prisioneiro '..userId..' | '..getUserName(userId)..' foi capturado.', 5000)
            end
        end
    end
end)