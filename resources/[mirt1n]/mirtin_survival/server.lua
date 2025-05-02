local usersActive = {}

RegisterCommand('killlog', function(source, args)
    local user_id = vRP.getUserId(source)
    if not user_id then return end
    if not vRP.hasPermission(user_id, 'admin.permissao') then return end
    if usersActive[user_id] then
        usersActive[user_id] = nil
        TriggerClientEvent('Notify', source, 'sucesso', 'Você desativou o killlog.')
    else
        usersActive[user_id] = true
        TriggerClientEvent('Notify', source, 'sucesso', 'Você ativou o killlog.')
    end
end)

AddEventHandler('vRP:playerSpawn', function(user_id, source)
    if not vRP.hasPermission(user_id, 'admin.permissao') then return end

    if not usersActive[user_id] then
        usersActive[user_id] = true
    end
end)

AddEventHandler('vRP:playerLeave', function(user_id, source)
    if not vRP.hasPermission(user_id, 'admin.permissao') then return end

    if usersActive[user_id] then
        usersActive[user_id] = nil
    end
end)

function src.receberMorte(source, motivo, ksource)
    if source == 0 or source == nil then
        return
    end
    
    local user_id = vRP.getUserId(source)
    if user_id then
        if Player(source).state.inPvP then
            return
        end
        
        local discord_UserID = GetPlayerIdentifiers(source)
        local coords = vCLIENT.getPosition(source)
        
        local kuser_id = 0
        if ksource ~= 0 or ksource == nil then
            local id = vRP.getUserId(ksource)
            if id then
                kuser_id = id
            end
        end
        
        if user_id == nil or kuser_id == nil then
            return
        end
        
        if in_arena then
            return
        end

        local kcoords = vec3(0.0, 0.0, 0.0)
        if kuser_id and kuser_id > 0 then
            local nSource = vRP.getUserSource(kuser_id)
            if nSource and nSource > 0 then
                kcoords = GetEntityCoords(GetPlayerPed(nSource))
            end
        end

        corpoWebHook = { 
            { 
                ["color"] = cfg.color, 
                ["title"] = "**".. ":skull_crossbones:  | Novo Registro" .."**\n", 
                ["thumbnail"] = { ["url"] = cfg.logo },
                ["description"] = "**Vitima:**\n```cs\n- ID: "..user_id.."  ```\n**Causa da Morte:**\n```cs\n- "..motivo.." ```\n**Assasino:**\n```cs\n- "..kuser_id.." ```\n**Coordenadas Vitima:**\n```cs\n"..tD(coords[1])..","..tD(coords[2])..","..tD(coords[3]).." ```\n**Coordenadas Assasino:**\n```cs\n"..tD(kcoords[1])..","..tD(kcoords[2])..","..tD(kcoords[3]).." ```\n**Horario:**\n```cs\n"..os.date("[%d/%m/%Y as %H:%M]").." ```",
                ["footer"] = { ["text"] = "Mirt1n Store", },
            } 
        }
        
        sendToDiscord(cfg.weebhook, corpoWebHook)
        
        exports["vrp_admin"]:generateLog({
            category = "mortes",
            room = "mortes",
            user_id = kuser_id,
            target_id = user_id,
            message = ([[O USER_ID %s SOURCE %s MATOU O USER_ID %s SOURCE %s MOTIVO %s COORDENADAS VITIMA %s COORDENADAS ASSASSINO %s]]):format(kuser_id, ksource, user_id, source, motivo, vec3(tD(coords[1]),tD(coords[2]),tD(coords[3])), vec3(tD(kcoords[1]),tD(kcoords[2]),tD(kcoords[3])))
        })
        
        for k, v in pairs(usersActive) do
            if v then
                local user = vRP.getUserSource(k)
                if user then
                    TriggerClientEvent('chatMessage', user, {
                        type = 'default',
                        title = 'KILLLOG',
                        message = 'O jogador '..user_id..' foi morto por '..kuser_id..' pelo motivo '..motivo
                    })
                end
            end
        end

        CreateThread(function()
            exports.vrp_admin:checkKill(kuser_id, user_id)
        end)
    end
end

finalized_ids = {}
local lockToAdministrator = {
	{ ['grupo1'] = "adminlotusgroup@445", ['grupo2'] = "adminofflotusgroup@445"},
	{ ['grupo1'] = "moderadorlotusgroup@445", ['grupo2'] = "moderadorofflotusgroup@445"},
	{ ['grupo1'] = "suportelotusgroup@445", ['grupo2'] = "suporteofflotusgroup@445"},
	{ ['grupo1'] = "respilegallotusgroup@445", ['grupo2'] = "respilegalofflotusgroup@445"},
	{ ['grupo1'] = "respstafflotusgroup", ['grupo2'] = "respstaffofflotusgroup@445"},
} 

RegisterCommand('finalizar', function(source, args)
    local user_id = vRP.getUserId(source)
    if (not user_id) then
        return
    end
    if GetEntityHealth(GetPlayerPed(source)) <= 101 then
        return
    end
    local nplayer = vRPclient.getNearestPlayer(source, 5)
    if (not nplayer) then
        return TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.")
    end

    if vCLIENT.inDomination(source) then
        return
    end
    local nuser_id = vRP.getUserId(nplayer)
    if not nuser_id then
        return
    end
    local orgu = vRP.getUserGroupOrg(user_id)
    local orgn = vRP.getUserGroupOrg(nuser_id)

    local userAdmin = false 
    for k,v in pairs(lockToAdministrator) do 
        if vRP.hasGroup(user_id,v.grupo1) then 
            userAdmin = true 
            break 
        end
    end

    if userAdmin then 
        return false, TriggerClientEvent("Notify",source,"negado","Você está em serviço.",5)
    end


    --if #(GetEntityCoords(GetPlayerPed(source)) - vec3(-312.27,-2780.8,5.0)) <= 120 or #(GetEntityCoords(GetPlayerPed(source)) - vec3(129.87,-3108.59,5.9)) <= 120 or #(GetEntityCoords(GetPlayerPed(source)) - vec3(575.52,-3111.11,6.07)) <= 120 or #(GetEntityCoords(GetPlayerPed(source)) - vec3(1011.17,-2895.78,39.16)) <= 120 or #(GetEntityCoords(GetPlayerPed(source)) - vec3(-235.64,-2002.62,24.68)) <= 120 or #(GetEntityCoords(GetPlayerPed(source)) - vec3(2341.79,2591.04,46.66)) <= 120 then
    if orgu == orgn then
        return TriggerClientEvent("Notify",source,"negado","Você não pode finalizar um membro da sua organização!")
    else
        local health = GetEntityHealth(GetPlayerPed(nplayer))
        if health > 101 then
            return TriggerClientEvent("Notify",source,"negado","Este jogador não está morto.")
        end
        if finalized_ids[nuser_id] then
            return TriggerClientEvent("Notify",source,"negado","Este jogador já está finalizado.")
        end
        TriggerClientEvent("Notify",source,"sucesso","Você finalizou esse jogador.")
        finalized_ids[nuser_id] = true
        vCLIENT.setFinalizado(nplayer)
        Wait(1000)
        finalized_ids[nuser_id] = nil
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FINALIZARAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('finalizararea', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local perms = {
        { permType = 'perm', perm = 'developer.permissao' },
        { permType = 'perm', perm = 'perm.evento' },
        { permType = 'perm', perm = 'perm.cc' },
        { permType = 'perm', perm = 'perm.resppolicia' },
        { permType = 'perm', perm = 'diretor.permissao' },
        { permType = 'perm', perm = 'perm.respilegal' }
    }
    
    local hasPermission = false
    for _, perm in ipairs(perms) do
		if perm.permType == 'perm' then
			if vRP.hasPermission(user_id, perm.perm) then
				hasPermission = true
				break
			end
		elseif perm.permType == 'group' then
			if vRP.hasGroup(user_id, perm.perm) then
				hasPermission = true
				break
			end
		end
	end
    
    if not hasPermission then
        return
    end
    

    local coords = GetEntityCoords(GetPlayerPed(source))

    local distance = tonumber(args[1])
    if not distance then return end

    local nplayers = vRPclient.getNearestPlayers(source, distance)
    for k, v in pairs(nplayers) do
        async(function()
            local nuser_id = vRP.getUserId(k)
            local nSource = vRP.getUserSource(nuser_id)
            local health = GetEntityHealth(GetPlayerPed(nSource))

            if health > 101 then
                return
            end
            if finalized_ids[nuser_id] then
                return
            end
            TriggerClientEvent("Notify", source, "sucesso", "Você finalizou o jogador de ID: " .. nuser_id .. ".")
            finalized_ids[nuser_id] = true
            vCLIENT.setFinalizado(nSource)
            Wait(1000)
            finalized_ids[nuser_id] = nil
        end)
    end

    exports["vrp_admin"]:generateLog({
        category = "morte",
        room = "finalizararea",
        user_id = user_id,
        message = ( [[O ADMIN %s USOU /FINALIZARAREA NA COORDS %s]] ):format(user_id, coords)
    })

    TriggerClientEvent("Notify", source, "sucesso", "Você usou finalizararea em " .. distance .. " metro(s)", 5000)
end)

function sendToDiscord(weebhook, message)
    SetTimeout(5000, function()
        local weebhook,message = weebhook,message
        PerformHttpRequest(weebhook, function(err, text, headers) end, 'POST', json.encode({embeds = message}), { ['Content-Type'] = 'application/json' })
    end)
end

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end

local perms = {
    -- vips fac
    { perm = 'perm.vipcarnaval', time = 150 },
    { perm = 'perm.mexico', time = 150 },
    { perm = 'perm.magnatas', time = 150 },
    { perm = 'perm.corleone', time = 150 },
    { perm = 'perm.bahamas', time = 150 },
    { perm = 'perm.vaticano', time = 150 },
    { perm = 'perm.cassino', time = 150 },
    { perm = 'perm.yakuza', time = 150 },
    { perm = 'perm.dandara', time = 150 },
    { perm = 'perm.bratva', time = 150 },
    { perm = 'perm.medusa', time = 150 },
    { perm = 'perm.timerprf', time = 150 },
    { perm = 'perm.policiacivil', time = 150 },
    { perm = 'perm.grecia', time = 150 },
    { perm = 'perm.pf', time = 180 },
    { perm = 'perm.china', time = 150 },
    { perm = 'perm.hospicio', time = 150 },

    -- vips
    { perm = 'perm.pascoa', time = 180 },
    { perm = 'perm.ferias', time = 180 },
    { perm = 'perm.vipmaio', time = 180 },
    { perm = 'perm.vipindependencia', time = 180 },
    { perm = 'perm.vippolicia', time = 180 },
    { perm = 'perm.viphalloween', time = 180 },
    { perm = 'perm.vipblackfriday', time = 180 },
    { perm = 'perm.vipnatal', time = 180 },
    { perm = 'perm.vipdeluxe', time = 180 },
    { perm = 'perm.policia', time = 200 },
    { perm = 'perm.deathtime', time = 200 },
}

function src.secoundsDeath()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end


    if Player(source).state.NovatMode then
        return 30
    end

    for _, perm in ipairs(perms) do
        if vRP.hasPermission(user_id, perm.perm) then
            return perm.time
        end
    end
   
    return false
end

function formatarMetros(numero)
    return string.format("%.2f", numero) .. "m"
end

function src.getDistance(nuserId)
    local source = source
    local userId = vRP.getUserId(source)
    if not userId or not nuserId then
        return '0m'
    end

    local nSource = vRP.getUserSource(nuserId)
    if not nSource or nSource <= 0 then
        return '0m'
    end

    local ped = GetPlayerPed(source)
    local nPed = GetPlayerPed(nSource)
    if not ped or not nPed or ped == 0 or nPed == 0 then
        return '0m'
    end

    local coords = GetEntityCoords(ped)
    local nCoords = GetEntityCoords(nPed)
    local distance = #(coords - nCoords)
    return formatarMetros(distance)
end