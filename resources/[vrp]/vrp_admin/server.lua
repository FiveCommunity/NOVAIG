local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_admin", src)
Proxy.addInterface("vrp_admin", src)
groups = module("cfg/groups").groups

vCLIENT = Tunnel.getInterface("vrp_admin")
bCLIENT = Tunnel.getInterface("vrp_barbearia")
local cfg = module("cfg/groups")
local groups = cfg.groups
local arena = Tunnel.getInterface("mirtin_arena")

vRP.prepare("APZ/getTime", "SELECT dvalue from vrp_user_data WHERE dkey = 'vRP:prisao:ADM' and user_id = @user_id")
vRP.prepare("APZ/getTime2", "SELECT dvalue from vrp_user_data WHERE dkey = 'vRP:prisao' and user_id = @user_id")

RegisterNetEvent("dk:removeItem")
AddEventHandler("dk:removeItem", function(user_id, itemName, amount)
    vRP.tryGetInventoryItem(user_id, itemName, amount)
end)



vRP.prepare("NVK/createWarrantTable", [[
    CREATE TABLE IF NOT EXISTS `drg_warrant` (
    `user_id` int(11) NOT NULL,
    `reason` longtext DEFAULT NULL,
    `timeCreated` varchar(100) DEFAULT NULL,
    PRIMARY KEY (`user_id`)
    )
]])

vRP.prepare("NVK/getWarrant", "SELECT * FROM drg_warrant WHERE user_id = @user_id")

vRP.prepare("NVK/insertOrUpdateWarrant", [[
    INSERT INTO drg_warrant (`user_id`, `reason`, `timeCreated`)
    VALUES (@user_id, @reason, @timeCreated)
    ON DUPLICATE KEY UPDATE `reason` = @reason, `timeCreated` = @timeCreated
]])

CreateThread(function()
    vRP.execute("NVK/createWarrantTable")
end)

local cacheWarrants = {}

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    if cacheWarrants[user_id] then
        NotifyWarrant(user_id)
        cacheWarrants[user_id] = nil
    end
end)

function NotifyWarrant(user_id)
    local source = vRP.getUserSource(user_id)

    if not source then return end

    local identity = vRP.getUserIdentity(user_id)

    local userName = identity.nome .. " " .. identity.sobrenome

    TriggerClientEvent('chatMessage', -1, {
        type = 'default',
        title = 'Mandado Registrado:',
        message = 'Foi expedido um madado para o cidadão'..userName..' do passaporte '..user_id..', o Tribunal da cidade solicita que ele vá até a Policia mais proxima para regularizar seu nome, do contrario será tratado como fugitivo.'
    })
end

RegisterCommand('mandado', function(source, args)
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    if not vRP.hasGroup(user_id, "Desembargador") then
        TriggerClientEvent("Notify", source, "negado", "Você não tem permissão para criar mandados.", 5)
        return
    end

    local status, time = exports['vrp']:getCooldown(user_id, "warrant")
    if not status then
        TriggerClientEvent("Notify", source, "negado", "Você não pode criar um mandado agora.", 5)
        return
    end

    if not args[1] then
        TriggerClientEvent("Notify", source, "negado", "Você precisa informar o passaporte que terá este mandado.", 5)
        return
    end

    local targetId = tonumber(args[1])
    if not targetId then
        TriggerClientEvent("Notify", source, "negado", "Passaporte inválido.", 5)
        return
    end

    local reason = table.concat(args, " ", 2)
    if reason == "" then
        TriggerClientEvent("Notify", source, "negado", "Você precisa informar o motivo do mandado.", 5)
        return
    end

    local function createWarrant()
        local timeCreated = os.date("%d-%m-%Y %H:%M:%S")
        vRP.execute("NVK/insertOrUpdateWarrant", {
            user_id = targetId,
            reason = reason,
            timeCreated = timeCreated
        })
        TriggerClientEvent("Notify", source, "sucesso", "Mandado criado com sucesso para o passaporte " .. targetId .. ".", 5)
        exports['vrp']:setCooldown(user_id, "warrant", 10)

        local targetSource = vRP.getUserSource(targetId)

        if targetSource then
            TriggerClientEvent("Notify", targetSource, "negado", "Foi expedido um mandado em seu passaporte.", 5)
            NotifyWarrant(targetId)
        else
            cacheWarrants[targetId] = true
        end
    end

    local getWarrant = vRP.query("NVK/getWarrant", { user_id = targetId })

    if not next(getWarrant) then
        createWarrant()
    else
        if vRP.request(source, "Este passaporte já possui um mandado, deseja atualizar?", 30) then
            createWarrant()
        end
    end
end, false)


RegisterCommand('donoveiculo', function (source, args)
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local perms = {
        { permType = 'perm', perm = 'developer.permissao' },
    }

    local hasPermission = false
    for _, perm in ipairs(perms) do
        if perm.permType == 'perm' and vRP.hasPermission(user_id, perm.perm) then
            hasPermission = true
            break
        elseif perm.permType == 'group' and vRP.hasGroup(user_id, perm.perm) then
            hasPermission = true
            break
        end
    end

    if not hasPermission then 
        return 
    end

    local choiceSearch = {
        ["placa"] = function()
            local PLATE_ID = vRP.prompt(source, "Digite a placa do veiculo: ", "")
            if not PLATE_ID or PLATE_ID == "" then
                return
            end
        
            local query = vRP.query("SELECT * FROM vrp_user_identities WHERE registro = @registro", { registro = PLATE_ID })
        
            if not next(query) then
                return TriggerClientEvent("Notify", source, "negado", "Placa inválida.", 5)
            end
        
            local userInfos = {
                ['username'] = query[1].nome .. " " .. query[1].sobrenome,
                ['user_id'] = query[1].user_id,
            }
        
            TriggerClientEvent("Notify", source, "sucesso", "Veiculo de " .. userInfos.username .. " # "..userInfos.user_id .. " é o dono do veiculo.", 5)
        end,

        ["id"] = function()
            local USER_ID = vRP.prompt(source, "Digite o ID do cidadão: ", "")
            if not USER_ID or USER_ID == "" then
                return
            end

            local query = vRP.query("SELECT * FROM vrp_user_identities WHERE user_id = @user_id", { user_id = USER_ID })

            if not next(query) then
                return TriggerClientEvent("Notify", source, "negado", "ID inválido.", 5)
            end

            local userInfos = {
                ['username'] = query[1].nome .. " " .. query[1].sobrenome,
                ['placa'] = query[1].registro,
            }

            TriggerClientEvent("Notify", source, "sucesso", "USER ID: "..USER_ID.. " É DONO DO VEICULO COM A PLACA: "..userInfos.placa, 5)
        end,
    }


    if choiceSearch[args[1]] then
        choiceSearch[args[1]]()
    else
        TriggerClientEvent("Notify", source, "negado", "Opção inválida. [ PLACA | ID ]", 5)
    end
end)

function limparItems(id)
    vRP.tryGetInventoryItem(id, "chave_algemas", vRP.getInventoryItemAmount(id, "chave_algemas"), true)
	vRP.tryGetInventoryItem(id, "radio", vRP.getInventoryItemAmount(id, "radio"), true)
end

RegisterCommand("remponto", function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)


    local perms = {
        { permType = 'perm', perm = 'developer.permissao' },
        { permType = 'group', perm = 'developerlotusgroup@445' },
        { permType = 'group', perm = 'resppolicialotusgroup@445' },
    }

    local hasPermission = false
    for _, perm in ipairs(perms) do
        if perm.permType == 'perm' and vRP.hasPermission(user_id, perm.perm) then
            hasPermission = true
            break
        elseif perm.permType == 'group' and vRP.hasGroup(user_id, perm.perm) then
            hasPermission = true
            break
        end
    end

    if not hasPermission then 
        return 
    end

    if user_id then 
        local targetId = parseInt(args[1])
        if targetId and targetId > 0 then 
            local targetSource = vRP.getUserSource(targetId)
            if not targetSource then 
                return false,TriggerClientEvent("Notify",source,"negado","Jogador fora da cidade.",5)
            end

            local inPatrolling = vRP.checkPatrulhamento(targetId)
            if not inPatrolling then 
                return false, TriggerClientEvent("Notify",source,"negado","O jogador não está em patrulhamento.",5)
            end

            vRP.removePatrulhamento(targetId)
            vRPclient._giveWeapons(targetSource, {}, true)
            limparItems(targetId)
            TriggerClientEvent("Notify",targetSource,"negado","Você saiu de patrulhamento..",6000)  
            TriggerClientEvent("Notify",source,"negado","Você removeu o jogador de patrulhamento",6000)  
            TriggerEvent('eblips:remove',targetSource)
            vRPclient.setArmour(targetSource,0)
        end
    end
end)


RegisterCommand('freezearea', function(source, args)
    local userId = vRP.getUserId(source)

    if not userId then
        return
    end

    local perms = {
        { permType = 'group', perm = 'TOP1' },
        { permType = 'group', perm = 'developerlotusgroup@445' },
        { permType = 'group', perm = 'respilegallotusgroup@445' },
        { permType = 'group', perm = 'respstafflotusgroup@445' },
        { permType = 'perm', perm = 'developer.permissao' },
    }
    

    local hasPermission = false
    for _, perm in ipairs(perms) do
        if perm.permType == 'group' then
            if vRP.hasGroup(userId, perm.perm) then
                hasPermission = true
                break
            end
        end
    end

    if not hasPermission then
        return
    end

    local distance = tonumber(args[1]) or 1.0
    local nplayers = vRPclient.getNearestPlayers(source, distance)

    for nSource, _ in pairs(nplayers) do
        vCLIENT.setFreeze(nSource)
    end
    TriggerClientEvent('Notify', source, 'sucesso', 'Jogadores congelados com sucesso!')
end)

local mutedPlayers = {}

RegisterCommand('calabocaarea', function(source, args)
    local userId = vRP.getUserId(source)

    if not userId then
        return
    end

    local perms = {
        { permType = 'group', perm = 'TOP1' },
        { permType = 'group', perm = 'developerlotusgroup@445' },
        { permType = 'group', perm = 'respilegallotusgroup@445' },
        { permType = 'group', perm = 'respstafflotusgroup@445' },
        { permType = 'perm', perm = 'developer.permissao' },
    }
    

    local hasPermission = false
    for _, perm in ipairs(perms) do
        if perm.permType == 'group' then
            if vRP.hasGroup(userId, perm.perm) then
                hasPermission = true
                break
            end
        end
    end

    if not hasPermission then
        return
    end

    local distance = tonumber(args[1]) or 1.0
    local nplayers = vRPclient.getNearestPlayers(source, distance)

    for nSource, _ in pairs(nplayers) do
        local nuserId = vRP.getUserId(nSource)
        if nuserId and not mutedPlayers[nuserId] then
            TriggerClientEvent('pma-voice:MutePlayer', nSource)
            mutedPlayers[nuserId] = true
            vRP.setUData(nuserId, "adm:muted", '1')
            TriggerClientEvent('Notify', source, 'sucesso', 'Jogador ID ' .. nuserId .. ' mutado com sucesso!')
            vRP.sendLog('', 'ID ' .. userId .. ' mutou o ID ' .. nuserId)
        elseif mutedPlayers[nuserId] then
            TriggerClientEvent('pma-voice:DesmutePlayer', nSource)
            mutedPlayers[nuserId] = nil
            vRP.setUData(nuserId, "adm:muted", '0')
            TriggerClientEvent('Notify', source, 'sucesso', 'Jogador ID ' .. nuserId .. ' desmutado com sucesso!')
            vRP.sendLog('', 'ID ' .. userId .. ' desmutou o ID ' .. nuserId)
        end
    end
end)



RegisterCommand("kitilha", function(source, args, rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if not user_id then return end 

	local coords = GetEntityCoords(GetPlayerPed(source))
	local distance = tonumber(args[1])

	if not distance then
		return
	end

    local groupList = {
        { permType = 'group', perm = 'TOP1' },  
        { permType = 'group', perm = 'developerlotusgroup@445' },
        { permType = 'group', perm = 'respilegallotusgroup@445' },
        { permType = 'group', perm = 'respstafflotusgroup@445' },
    }


    local hasPermission = false

    for _, perm in ipairs(groupList) do
        if perm.permType == 'group' then
            if vRP.hasGroup(user_id, perm.perm) then
                hasPermission = true
                break
            end
        end
        if perm.permType == 'perm' then
            if vRP.hasPermission(user_id, perm.perm) then
                hasPermission = true
                break
            end
        end
    end

	local affectedPlayerIds = {} 
	
    if hasPermission then
		local nplayers = vRPclient.getNearestPlayers(source, distance)
		for k, v in pairs(nplayers) do
            async(function()
                local userId = vRP.getUserId(k)
				if userId then 
					local nsource = vRP.getUserSource(parseInt(userId))
				
					vRP.giveInventoryItem(userId, "celular", 1, true)
					vRP.giveInventoryItem(userId, "radio", 1, true)
					vRP.giveInventoryItem(userId, "mochila", 3, true)
					vRP.giveInventoryItem(userId, "roupas", 1, true)
					vRP.giveInventoryItem(userId, "attachs", 1, true)

					table.insert(affectedPlayerIds, userId)
				end
            end)
        end

		TriggerClientEvent("Notify", source, "negado", "Você usou /kitilha em " .. distance .. " metro(s)", 5)
	end
end)


RegisterCommand('tempo', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        local perms = {
            { permType = 'group', perm = 'respstafflotusgroup@445' },
            { permType = 'perm', perm = 'developer.permissao' },
            { permType = 'group', perm = 'adminlotusgroup@445' },
            { permType = 'group', perm = 'respilegallotusgroup@445' },
            { permType = 'group', perm = 'resploglotusgroup@445' },
            { permType = 'group', perm = 'resppolicialotusgroup@445' },
            { permType = 'group', perm = 'respeventoslotusgroup@445' },
            { permType = 'group', perm = 'respstreamerlotusgroup@445' },
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

        if args[1] then
            local mensagem = vRP.prompt(source, "ADM | PM:", "ADM, PM")
            if mensagem == "" then
                return
            end
            if mensagem == "ADM" then
                local services = vRP.query("APZ/getTime", { user_id = tonumber(args[1]) })
                if #services > 0 then
                    if tonumber(services[1].dvalue) > 0 then
                        TriggerClientEvent("Notify", source, "importante", "Ele ainda tem " .. services[1].dvalue .. " minutos de prisão ADM!", 20000)
                    else
                        TriggerClientEvent("Notify", source, "importante", "Jogador não está preso.", 20000)
                    end
                end
            elseif mensagem == "PM" then
                local services = vRP.query("APZ/getTime2", { user_id = tonumber(args[1]) })
                if #services > 0 then
                    if tonumber(services[1].dvalue) > 0 then
                        TriggerClientEvent("Notify", source, "importante", "Ele ainda tem " .. services[1].dvalue .. " minutos de prisão PM!", 20000)
                    else
                        TriggerClientEvent("Notify", source, "importante", "Jogador não está preso.", 20000)
                    end
                end
            end
        end
    end
end)


local aExpediente2 = {{
    ['grupo1'] = "adminlotusgroup@445",
    ['grupo2'] = "adminofflotusgroup@445"
}, {
    ['grupo1'] = "developerlotusgroup@445",
    ['grupo2'] = "developerofflotusgroup@445"
}, {
    ['grupo1'] = "moderadorlotusgroup@445",
    ['grupo2'] = "moderadorofflotusgroup@445"
}, {
    ['grupo1'] = "suportelotusgroup@445",
    ['grupo2'] = "suporteofflotusgroup@445"
}, {
    ['grupo1'] = "respilegallotusgroup@445",
    ['grupo2'] = "respilegalofflotusgroup@445"
}, {
    ['grupo1'] = "resploglotusgroup@445",
    ['grupo2'] = "resplogofflotusgroup@445"
}}

RegisterCommand('getid', function(source, args)
    print(args[1])
    print(vRP.getUserId(tonumber(args[1])), 'bucket =>', GetPlayerRoutingBucket(tonumber(args[1])))
end)

RegisterCommand('dimensaosrc', function(source, args)
    if source > 0 then
        return
    end
    local target_src = vRP.getUserSource(tonumber(args[1]))
    SetPlayerRoutingBucket(target_src, tonumber(args[2]))
end)

RegisterCommand('rbl2', function(source, args)
    local user_id = vRP.getUserId(source)
    if user_id then

        local perms = {{
            permType = 'group',
            perm = 'TOP1'
        }, {
            permType = 'group',
            perm = 'developerlotusgroup@445'
        }, {
            permType = 'group',
            perm = 'respilegallotusgroup@445'
        }, {
            permType = 'group',
            perm = 'respstafflotusgroup@445'
        }}

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

        local id = tonumber(args[1])
        if id ~= nil then
            local nsource = vRP.getUserSource(parseInt(id))

            vRP.setUData(id, "Mirt1n:BlackList", 0)
            TriggerClientEvent("Notify", source, "sucesso", "Você tirou a blacklist do id: " .. id, 5)

            if nsource then
                TriggerClientEvent("Notify", nsource, "sucesso", "Sua blacklist foi removida!", 5)
            end
        end
    end
end)

vRP._prepare("vRP/get_leads", "SELECT * FROM leads")
RegisterCommand('leads', function(source)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "developer.permissao") then
            local total = 0
            local leads = vRP.query("vRP/get_leads", {})
            for findType, count in pairs(leads[1]) do
                total = total + count
            end

            local displayName = {
                tiktok = "Tiktok:",
                friends = "Amigos:",
                lastSeason = "Season Passada:",
                youtube = "Youtube:",
                fivemlist = "Lista do FiveM:"
            }

            local sortedLeads = {}
            for findType, count in pairs(leads[1]) do
                table.insert(sortedLeads, {
                    findType = findType,
                    count = count
                })
            end
            table.sort(sortedLeads, function(a, b)
                return a.count > b.count
            end)

            local message = ""
            for i, lead in ipairs(sortedLeads) do
                local percentage = (lead.count / total) * 100
                local progressLength = math.floor(percentage / 5)
                local remainingLength = 20 - progressLength
                message = message ..
                              string.format("%s [%s%s] %.2f%% (%d votos)\n",
                        displayName[lead.findType] or lead.findType, string.rep("|", progressLength),
                        string.rep("-", remainingLength), percentage, lead.count)
            end

            message = message .. string.format("\nTotal de Votos: %d", total)

            vRP.sendLog("https://discord.com/api/webhooks/1304882503043256468/CripAnJfHnYCgPUtDLi9m6NQzrL_xQRD4EccVPShTyTcgrgmguxYAncvxFf813WpROpk", string.format("```css\nLEADS REPORTS\n%s\n%s```", os.date("[%d/%m/%Y as %X]\n"), message))

            TriggerClientEvent("Notify", source, "sucesso", message)
        end
    end
end)

local usersBolinha = {}

-- RegisterCommand('bolinha', function(source,args,rawCommand)
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id and vRP.hasGroup(user_id, "developerlotusgroup@445") or vRP.hasGroup(user_id, "TOP1") then
-- 		usersBolinha[user_id] = true 
-- 		vRPclient._giveWeapons(source, { 
-- 			["WEAPON_RAYPISTOL"] = {ammo = 0},
-- 			["WEAPON_HEAVYSNIPER_MK2"] = {ammo = 50},
-- 			["WEAPON_SMG_MK2"] = {ammo = 250},
-- 			["WEAPON_STICKBOMB"] = {ammo = 250},
-- 			["WEAPON_MINIGUN"] = {ammo = 250},
-- 			["WEAPON_RAYMINIGUN"] = {ammo = 250},
-- 			["WEAPON_RPG"] = {ammo = 10},
-- 			["WEAPON_SPECIALCARBINE_MK2"] = {ammo = 250},
-- 			["WEAPON_PARAFAL"] = {ammo = 250},
-- 			["WEAPON_PISTOL_MK2"] = {ammo = 250},
-- 			["WEAPON_ASSAULTRIFLE"] = {ammo = 250},
-- 			["WEAPON_REVOLVER_MK2"] = {ammo = 250},
-- 			["WEAPON_MICROSMG"] = {ammo = 250},
-- 			["WEAPON_RAYCARBINE"] = {ammo = 250},
-- 			["WEAPON_PUMPSHOTGUN_MK2"] = {ammo = 250},
-- 			["WEAPON_SNIPERRIFLE"] = {ammo = 250},
-- 			["WEAPON_RAILGUN"] = {ammo = 250},
-- 			["WEAPON_RAILGUNXM3"] = {ammo = 250},
-- 			['WEAPON_ASSAULTRIFLE_MK2'] = {ammo = 250},
-- 			["WEAPON_SWITCHBLADE"] = {ammo = 250},
-- 			["WEAPON_GUSENBERG"] = {ammo = 250},
-- 			["WEAPON_COMBATPISTOL"] = {ammo = 250},
-- 			["WEAPON_STUNGUN"] = {ammo = 250},
-- 			["WEAPON_FLASHLIGHT"] = {ammo = 250},
-- 			["WEAPON_DOUBLEACTION"] = {ammo = 250},
-- 		}, true)
-- 	end
-- end)

RegisterCommand('bolinha2', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "developer.permissao") then
		usersBolinha[user_id] = true 
		vRPclient._giveWeapons(source, { 
			[("weapon_bottle"):upper()] = {ammo = 250},
			[("weapon_machete"):upper()] = {ammo = 250},
			[("weapon_switchblade"):upper()] = {ammo = 250},
			[("weapon_doubleaction"):upper()] = {ammo = 250},
			[("weapon_revolver_mk2"):upper()] = {ammo = 250},
			[("weapon_raypistol"):upper()] = {ammo = 250},
			[("weapon_raycarbine"):upper()] = {ammo = 250},
			[("weapon_musket"):upper()] = {ammo = 250},
			[("weapon_autoshotgun"):upper()] = {ammo = 250},
			[("weapon_tacticalrifle"):upper()] = {ammo = 250},
			[("weapon_heavysniper_mk2"):upper()] = {ammo = 250},
			[("weapon_rpg"):upper()] = {ammo = 250},
			[("weapon_railgun"):upper()] = {ammo = 250},
			[("weapon_rayminigun"):upper()] = {ammo = 250},
			[("weapon_emplauncher"):upper()] = {ammo = 250},
			[("weapon_snowball"):upper()] = {ammo = 250},
		}, true)
	end
end)

local userGroups = {
    ["respeventoslotusgroup@445"] = true,
    ["resploglotusgroup@445"] = true,
    ["resppolicialotusgroup@445"] = true,
    ["respstafflotusgroup@445"] = true,
    ["respkidslotusgroup@445"] = true
}

exports('getUserBolinha', function(user_id)
    return usersBolinha[user_id]
end)

AddEventHandler("vRP:playerLeave", function(user_id, source)
    if usersBolinha[user_id] then
        vRPclient._giveWeapons(source, {}, true)
        usersBolinha[user_id] = false
    end
end)

isPaulinho = function(source)
    local license
    local paulinho_license = 'license:194de0a4c51c26c88c8604fbb1a1e97f2e15ae70'

    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        end
    end
    if (paulinho_license == license) then
        return true
    end
    return false
end

RegisterCommand("abrirbaufac", function(source, args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "perm.resplog") or
            vRP.hasPermission(user_id, "perm.respilegal") then
            local TARGET_ID = vRP.prompt(source, "Digite o ID do cidadão: ", "")
            if not TARGET_ID or TARGET_ID == "" then
                return
            end

            TARGET_ID = parseInt(TARGET_ID)
            local TARGET_IDENTITY = vRP.getUserIdentity(TARGET_ID)

            if not TARGET_IDENTITY then
                TriggerClientEvent("Notify", source, "negado", "Id não encontrado.")
                return
            end

            local query = exports["oxmysql"]:executeSync(
                "SELECT * FROM vrp_srv_data WHERE dkey LIKE '%tmpChest:%' AND dkey LIKE CONCAT('%', ?, '%')",
                {TARGET_IDENTITY.registro})
            if #query == 0 then
                return
            end

            local t = ""
            for i = 1, #query do
                local dkey = query[i].dkey
                local _, _, vehicleName = string.find(dkey, "tmpChest:(%w+)")
                if vehicleName then
                    t = t .. vehicleName .. ", "
                end
            end

            local promptCar = vRP.prompt(source, "Escolha o veiculo do cidadao: ", t)
            if not promptCar or promptCar == "" then
                return
            end

            for i = 1, #query do
                local _, _, vehicleName = string.find(query[i].dkey, "tmpChest:(%w+)")
                if vehicleName == promptCar then
                    TriggerClientEvent("openCarChest", source, TARGET_IDENTITY.registro:gsub(" ", ""), promptCar)
                    vRP.sendLog("", "STAFF ID " .. user_id .. ' utilizou /abrirbaufac no veiculo : ' .. promptCar ..
                        " do passaporte:" .. TARGET_ID .. "")
                    return
                end
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADICIONAR CARRO NITRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cnitro', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") then
        if tonumber(args[1]) then
            vRP.execute("vRP/add_vehicle", {
                user_id = tonumber(args[1]),
                vehicle = "toyotasupra"
            })
            TriggerClientEvent("Notify", source, "Você deu o veiculo nitro para o [ID: " .. args[1] .. "]", 5)
        end
    end
end)

local pradio = {}
RegisterCommand('pradio', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") then
        if args[1] then
            local players = exports['pma-voice']:getPlayersInRadioChannel(parseInt(args[1]))
            for source2, isTalking in pairs(players) do
                local nid = vRP.getUserId(source2)
                table.insert(pradio, json.encode(nid))
            end

            TriggerClientEvent("Notify", source, "sucesso", "(Jogadores Conectados na Radio) : " .. pradio, 5)
            pradio = {}
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteped")
AddEventHandler("trydeleteped", function(index)

end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEOBJ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteobj")
AddEventHandler("trydeleteobj", function(index)
    local source = source
    local entity = NetworkGetEntityFromNetworkId(index)
    print("trydeleteobj", source, entity)
    if entity and entity ~= 0 then
        if GetEntityType(entity) == 2 then
            local user_id = vRP.getUserId(source)
            DropPlayer(source, "fracassou.")
            vRP.setBanned(user_id, true, 'trydeleteobj N DESBANIR', _, _, 2)
            return
        end
        DeleteEntity(entity)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
local fix_perms = {'admin.permissao', 'moderador.permissao', 'suporte.permissao', 'perm.cc', 'perm.spawner'}

RegisterCommand('fix', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    for k, v in pairs(fix_perms) do
        if vRP.hasPermission(user_id, v) then
            local vehicle = vRPclient.getNearestVehicle(source, 7)
            if vehicle then
                local coords = GetEntityCoords(GetPlayerPed(source))
                TriggerClientEvent('reparar', source, vehicle)
                vRP.sendLog('https://discord.com/api/webhooks/1313517184256835594/A9sxghjFWLOptYwxLtfpmO16slltJN-fBecStMz0wbj8feECYwP_sZ52UOt9qQJSS294', 'STAFF ID ' .. user_id .. ' utilizou /fix no veiculo ' .. coords.x..','..coords.y..','..coords.z)
                break
            end
        end
    end
end)

RegisterCommand('fixarea', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local range = tonumber(args[1]) or 7

    for _, perm in pairs(fix_perms) do
        if vRP.hasPermission(user_id, perm) then
            local vehicles = vRPclient.getNearestVehicles(source, range)
            local fixedCount = 0

            for vehicle, distance in pairs(vehicles) do
                TriggerClientEvent('reparar', source, vehicle)
                Wait(100)
                fixedCount = fixedCount + 1
            end

            TriggerClientEvent('Notify', source, 'sucesso', 'Você reparou ' .. fixedCount .. ' veículo(s) (range: ' .. range .. ')')

            if fixedCount > 0 then
                local coords = GetEntityCoords(GetPlayerPed(source))
                vRP.sendLog(
                    'https://discord.com/api/webhooks/1313517184256835594/A9sxghjFWLOptYwxLtfpmO16slltJN-fBecStMz0wbj8feECYwP_sZ52UOt9qQJSS294',
                    'STAFF ID ' .. user_id .. ' utilizou /fixarea em ' .. fixedCount ..
                    ' veículo(s) (range: ' .. range .. ') a partir de ' ..
                    coords.x .. ',' .. coords.y .. ',' .. coords.z
                )
            end

            break
        end
    end
end)

local fix_perms = {'perm.fixvip', 'perm.safira', 'perm.vipdeluxe', 'perm.rubi', 'perm.belarp', 'perm.altarj', 'perm.fixvip', 'perm.vipsaojoao', 'perm.viphalloween', 'perm.supremo021', 'perm.vipinicial'}
RegisterCommand('fixvip', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    for k, v in pairs(fix_perms) do
        if vRP.hasPermission(user_id, v) then
            local status, time = exports['vrp']:getCooldown(user_id, "fixvip")
            if status then
                exports['vrp']:setCooldown(user_id, "fixvip", 600)

                local vehicle = vRPclient.getNearestVehicle(source, 7)
                if vehicle then
                    vRPclient._playAnim(source, false, {{"mini@repair", "fixing_a_player"}}, true)
                    TriggerClientEvent("progress", source, 30)
                    exports["vrp"]:setBlockCommand(user_id, 35)
                    exports.vrp_player:addSeatCooldown(user_id, 35)
                    SetTimeout(30000, function()
                        TriggerClientEvent("reparar", source, vehicle)
                        vRPclient._stopAnim(source, false)
                        TriggerClientEvent("Notify", source, "sucesso", "Você reparou o veiculo.", 5)
                    end)
                end
                return
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUS 2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('status2', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local mensagem = ""
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") then
        if user_id then

            --[[ ADMINISTRADOR ]]
            local admin = vRP.getUsersByPermission("admin.permissao")
            local adminTotal = ""
            for k, v in pairs(admin) do
                if vRP.hasGroup(v, "cargomakakero") then
                    goto continue
                end
                adminTotal = adminTotal .. parseInt(v) .. ", "
                ::continue::
            end
            if adminTotal == "" then
                adminTotal = "Nenhum(a)"
            end
            mensagem = mensagem .. "<br><br> <b>👑 IDS de Admin em Serviço: </b>" .. adminTotal

            --[[ MODERADOR ]]
            local moderador = vRP.getUsersByPermission("moderador.permissao")
            local moderadorTotal = ""
            for k, v in pairs(moderador) do
                if vRP.hasGroup(v, "cargomakakero") then
                    goto continue
                end
                moderadorTotal = moderadorTotal .. parseInt(v) .. ", "
                ::continue::
            end
            if moderadorTotal == "" then
                moderadorTotal = "Nenhum(a)"
            end
            mensagem = mensagem .. "<br><b>🛡️ IDS de Moderador em Serviço: </b>" .. moderadorTotal

            --[[ SUPORTE ]]
            local suporte = vRP.getUsersByPermission("suporte.permissao")
            local suporteTotal = ""
            for k, v in pairs(suporte) do
                if vRP.hasGroup(v, "cargomakakero") then
                    goto continue
                end
                suporteTotal = suporteTotal .. parseInt(v) .. ", "
                ::continue::

            end
            if suporteTotal == "" then
                suporteTotal = "Nenhum(a)"
            end
            mensagem = mensagem .. "<br><b>📑 IDS de Suporte em Serviço: </b>" .. suporteTotal

            --[[ AJUDANTE ]]
            local ajudante = vRP.getUsersByPermission("perm.ajudante")
            local ajudanteTotal = ""
            for k, v in pairs(ajudante) do
                if vRP.hasGroup(v, "cargomakakero") then
                    goto continue
                end
                ajudanteTotal = ajudanteTotal .. parseInt(v) .. ", "
                ::continue::

            end
            if ajudanteTotal == "" then
                ajudanteTotal = "Nenhum(a)"
            end
            mensagem = mensagem .. "<br><b>📑 IDS de Ajudante em Serviço: </b>" .. ajudanteTotal

            --[[ STAFF FORA DE SERVICO ]]
            local adminFora = vRP.getUsersByPermission("staffoff.permissao")
            local adminForaTotal = ""
            for k, v in pairs(adminFora) do
                if vRP.hasGroup(v, "cargomakakero") then
                    goto continue
                end
                adminForaTotal = adminForaTotal .. parseInt(v) .. ", "
                ::continue::
            end
            if adminForaTotal == "" then
                adminForaTotal = "Nenhum(a)"
            end
            mensagem = mensagem .. "<br><b>👑 IDS de STAFFs fora de Serviço: </b>" .. adminForaTotal

            --[[ POLICIAIS ]]
            -- local policiais = vRP.getUsersByPermission("perm.policia")
            -- local totalPolicia = ""
            -- for k,v in pairs(policiais) do
            -- 	totalPolicia = totalPolicia.. parseInt(v)..", "
            -- end
            -- if totalPolicia == "" then totalPolicia = "Nenhum(a)" end
            -- mensagem = mensagem.."<br><br> <b>👮 IDS de Policiais: </b>"..totalPolicia

            -- local totalPoliciaPtr = ""
            -- for k,v in pairs(policiais) do
            -- 	local patrulhamento = vRP.checkPatrulhamento(parseInt(v))
            -- 	if patrulhamento then
            -- 		totalPoliciaPtr = totalPoliciaPtr.. parseInt(v)..", "
            -- 	end
            -- end
            -- if totalPoliciaPtr == "" then totalPoliciaPtr = "Nenhum(a)" end
            -- mensagem = mensagem.."<br> <b>👮 IDS de Policiais em PTR: </b>"..totalPoliciaPtr

            --[[ UNIZK ]]
            local unizk = vRP.getUsersByPermission("perm.unizk")
            local unizkTotal = ""
            for k, v in pairs(unizk) do
                unizkTotal = unizkTotal .. parseInt(v) .. ", "
            end
            if unizkTotal == "" then
                unizkTotal = "Nenhum(a)"
            end
            mensagem = mensagem .. "<br><br> <b>⛑️ IDS de HOSPITAL: </b>" .. unizkTotal

            local totalUnizkPtr = ""
            for k, v in pairs(unizk) do
                local patrulhamento = vRP.checkPatrulhamento(parseInt(v))
                if patrulhamento then
                    totalUnizkPtr = totalUnizkPtr .. parseInt(v) .. ", "
                end
            end
            if totalUnizkPtr == "" then
                totalUnizkPtr = "Nenhum(a)"
            end
            mensagem = mensagem .. "<br> <b>⛑️ IDS de HOSPITAL em PTR: </b>" .. totalUnizkPtr


            --[[ BOMBEIRO ]]
            local bombeiro = vRP.getUsersByPermission("perm.bombeiro")
            local bombeiroTotal = ""
            for k, v in pairs(bombeiro) do
                bombeiroTotal = bombeiroTotal .. parseInt(v) .. ", "
            end
            if bombeiroTotal == "" then
                bombeiroTotal = "Nenhum(a)"
            end
            mensagem = mensagem .. "<br><br> <b>⛑️ IDS de BOMBEIRO: </b>" .. bombeiroTotal

            local totalBombeiroPdr = ""
            for k, v in pairs(bombeiro) do
                local patrulhamento = vRP.checkPatrulhamento(parseInt(v))
                if patrulhamento then
                    totalBombeiroPdr = totalBombeiroPdr .. parseInt(v) .. ", "
                end
            end
            if totalBombeiroPdr == "" then
                totalBombeiroPdr = "Nenhum(a)"
            end
            mensagem = mensagem .. "<br> <b>⛑️ IDS de BOMBEIRO em PTR: </b>" .. totalBombeiroPdr


            --[[ MECANICO ]]
            local mec = vRP.getUsersByPermission("perm.mecanica")
            local mecTotal = ""
            for k, v in pairs(mec) do
                mecTotal = mecTotal .. parseInt(v) .. ", "
            end
            if mecTotal == "" then
                mecTotal = "Nenhum(a)"
            end
            mensagem = mensagem .. "<br><br> <b>🔧 IDS de MECANICO: </b>" .. mecTotal

            local totalMecPtr = ""
            for k, v in pairs(mec) do
                local patrulhamento = vRP.checkPatrulhamento(parseInt(v))
                if patrulhamento then
                    totalMecPtr = totalMecPtr .. parseInt(v) .. ", "
                end
            end
            if totalMecPtr == "" then
                totalMecPtr = "Nenhum(a)"
            end
            mensagem = mensagem .. "<br> <b>🔧 IDS de MECANICO em PTR: </b>" .. totalMecPtr

            --[[ DRIFTKING ]]
            local driftking = vRP.getUsersByPermission("perm.driftking")
            local driftkingTotal = ""
            for k, v in pairs(driftking) do
                mecTotal = mecTotal .. parseInt(v) .. ", "
            end
            if driftkingTotal == "" then
                driftkingTotal = "Nenhum(a)"
            end
            mensagem = mensagem .. "<br><br> <b>🔧 IDS de DRIFTKING: </b>" .. driftkingTotal

            local totalDriftkingPtr = ""
            for k, v in pairs(driftking) do
                local patrulhamento = vRP.checkPatrulhamento(parseInt(v))
                if patrulhamento then
                    totalDriftkingPtr = totalDriftkingPtr .. parseInt(v) .. ", "
                end
            end
            if totalDriftkingPtr == "" then
                totalDriftkingPtr = "Nenhum(a)"
            end
            mensagem = mensagem .. "<br> <b>🔧 IDS de DRIFTKING em PTR: </b>" .. totalDriftkingPtr


            --[[ RACE ]]
            local race = vRP.getUsersByPermission("perm.race")
            local raceTotal = ""
            for k, v in pairs(race) do
                raceTotal = raceTotal .. parseInt(v) .. ", "
            end
            if raceTotal == "" then
                raceTotal = "Nenhum(a)"
            end
            mensagem = mensagem .. "<br><br> <b>🔧 IDS de RACE: </b>" .. raceTotal

            local totalRacePtr = ""
            for k, v in pairs(race) do
                local patrulhamento = vRP.checkPatrulhamento(parseInt(v))
                if patrulhamento then
                    totalRacePtr = totalRacePtr .. parseInt(v) .. ", "
                end
            end
            if totalRacePtr == "" then
                totalRacePtr = "Nenhum(a)"
            end
            mensagem = mensagem .. "<br> <b>🔧 IDS de RACE em PTR: </b>" .. totalRacePtr

            --[[ REDLINE ]]
            local redline = vRP.getUsersByPermission("perm.redline")
            local redlineTotal = ""
            for k, v in pairs(redline) do
                redlineTotal = redlineTotal .. parseInt(v) .. ", "
            end
            if redlineTotal == "" then
                redlineTotal = "Nenhum(a)"
            end
            mensagem = mensagem .. "<br><br> <b>🔧 IDS de REDLINE: </b>" .. redlineTotal

            local totalRedlinePtr = ""
            for k, v in pairs(redline) do
                local patrulhamento = vRP.checkPatrulhamento(parseInt(v))
                if patrulhamento then
                    totalRedlinePtr = totalRedlinePtr .. parseInt(v) .. ", "
                end
            end
            if totalRedlinePtr == "" then
                totalRedlinePtr = "Nenhum(a)"
            end
            mensagem = mensagem .. "<br> <b>🔧 IDS de REDLINE em PTR: </b>" .. totalRedlinePtr



            local onlinePlayers = GetNumPlayerIndices()
            mensagem = mensagem .. "<br><br> <b>🏘️ Total de jogadores Online: </b>" .. onlinePlayers + 100

            TriggerClientEvent("Notify", source, "importante", "<b>IGUAÇU RJ:</b>" .. mensagem, 30)
        end
    end
end)

RegisterCommand('status3', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local mensagem = ""
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "developer.permissao") then
        if user_id then

            local policiais = vRP.getUsersByPermission("perm.policia")
            local totalPolicia = ""
            for k, v in pairs(policiais) do
                totalPolicia = totalPolicia .. parseInt(v) .. ", "
            end
            if totalPolicia == "" then
                totalPolicia = "Nenhum(a)"
            end
            mensagem = mensagem .. "<br><br> <b>👮 IDS de Policiais: </b>" .. totalPolicia

            local totalPoliciaPtr = ""
            for k, v in pairs(policiais) do
                local patrulhamento = vRP.checkPatrulhamento(parseInt(v))
                if patrulhamento then
                    totalPoliciaPtr = totalPoliciaPtr .. parseInt(v) .. ", "
                end
            end
            if totalPoliciaPtr == "" then
                totalPoliciaPtr = "Nenhum(a)"
            end
            mensagem = mensagem .. "<br><br> <b>👮 IDS de Policiais em PTR: </b>" .. totalPoliciaPtr

            TriggerClientEvent("Notify", source, "importante", "<b>IGUAÇU RJ:</b>" .. mensagem, 30)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PFARDA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pfarda', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasGroup(user_id, 'ajudantelotusgroup@445') then
        local custom = vRPclient.getCustomization(source, {})
        local content = ""
        for k, v in pairs(custom) do
            if tonumber(k) == 1 or tonumber(k) == 3 or tonumber(k) == 4 or tonumber(k) == 6 or tonumber(k) == 7 or
                tonumber(k) == 8 or tonumber(k) == 9 or tonumber(k) == 11 or k == "p0" or k == "p6" then
                content = content .. "\n[" .. k .. "] = { " .. json.encode(v) .. " }"
            end
        end

        vRP.prompt(source, "Farda: ", "[FARDA TAL] = { " .. content .. " \n} ")
    end
end)

vRP.prepare("APZ/getTime", "SELECT dvalue from vrp_user_data WHERE dkey = 'vRP:prisao:ADM' and user_id = @user_id")
vRP.prepare("APZ/getTime2", "SELECT dvalue from vrp_user_data WHERE dkey = 'vRP:prisao' and user_id = @user_id")

RegisterCommand('tempo', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        local perms = {{
            permType = 'group',
            perm = 'respstafflotusgroup@445'
        }, {
            permType = 'perm',
            perm = 'developer.permissao'
        }, {
            permType = 'group',
            perm = 'adminlotusgroup@445'
        }, {
            permType = 'group',
            perm = 'respilegallotusgroup@445'
        }, {
            permType = 'group',
            perm = 'resploglotusgroup@445'
        }, {
            permType = 'group',
            perm = 'resppolicialotusgroup@445'
        }, {
            permType = 'group',
            perm = 'respeventoslotusgroup@445'
        }, {
            permType = 'group',
            perm = 'respstreamerlotusgroup@445'
        }}

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

        if args[1] then
            local mensagem = vRP.prompt(source, "ADM | PM:", "ADM, PM")
            if mensagem == "" then
                return
            end
            if mensagem == "ADM" then
                local services = vRP.query("APZ/getTime", {
                    user_id = tonumber(args[1])
                })
                if #services > 0 then
                    if tonumber(services[1].dvalue) > 0 then
                        TriggerClientEvent("Notify", source, "importante",
                            "Ele ainda tem " .. services[1].dvalue .. " minutos de prisão ADM!", 20000)
                    else
                        TriggerClientEvent("Notify", source, "importante", "Jogador não está preso.", 20000)
                    end
                end
            elseif mensagem == "PM" then
                local services = vRP.query("APZ/getTime2", {
                    user_id = tonumber(args[1])
                })
                if #services > 0 then
                    if tonumber(services[1].dvalue) > 0 then
                        TriggerClientEvent("Notify", source, "importante",
                            "Ele ainda tem " .. services[1].dvalue .. " minutos de prisão PM!", 20000)
                    else
                        TriggerClientEvent("Notify", source, "importante", "Jogador não está preso.", 20000)
                    end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARTICULAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pm', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.permissao") then
        if args[1] then
            local mensagem = vRP.prompt(source, "Mensagem:", "")
            if mensagem == "" then
                return
            end
            local tplayer = vRP.getUserSource(parseInt(args[1]))

            if tplayer then
                TriggerClientEvent('chatMessage', tplayer, {
                    type = 'default',
                    title = 'Enviou:',
                    message = '(' .. user_id .. ') diz:  ' .. mensagem
                })
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limpararea', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local plyCoords = GetEntityCoords(GetPlayerPed(source))
    local x, y, z = plyCoords[1], plyCoords[2], plyCoords[3]

    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasGroup(user_id, 'ajudantelotusgroup@445') then
        TriggerClientEvent("syncarea", -1, x, y, z)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cleararea', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "perm.cconteudo") or
        vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasGroup(user_id, 'ajudantelotusgroup@445') then
        local plyCoords = GetEntityCoords(GetPlayerPed(source))
        local x, y, z = plyCoords[1], plyCoords[2], plyCoords[3]

        TriggerClientEvent("Notify", source, "Todos objetos dentro de um raio de 100 foram deletados.")
        TriggerClientEvent("cleararea", -1, x, y, z)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARPICKUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('clearpickup', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasGroup(user_id, 'ajudantelotusgroup@445') then
        local plyCoords = GetEntityCoords(GetPlayerPed(source))
        local x, y, z = plyCoords[1], plyCoords[2], plyCoords[3]

        TriggerClientEvent("Notify", source, "importante", "Todos objetos dentro de um raio de 100 foram deletados.")
        TriggerClientEvent("clearpickup", -1, x, y, z)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Limpar Inventario
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('clearinv', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        local perms = {{
            permType = 'perm',
            perm = 'admin.permissao'
        }, {
            permType = 'group',
            perm = 'resppolicialotusgroup@445'
        }, {
            permType = 'group',
            perm = 'respstreamerlotusgroup@445'
        }}

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

        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRP.clearInventory(parseInt(args[1]))

                vRP.sendLog("https://discord.com/api/webhooks/1304878881664139445/uZX_eWNTwwka27I3jpLO1HdC4eVs4x655xsI5I1jiimXEPE_P1957mqrDjv9XFugOFdp", "O ID: " .. user_id .. " limpou o inventario do ID: " .. args[1])

                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "clear-inv",
                    user_id = user_id,
                    message = ([[O USER_ID %s LIMPOU O INVENTARIO DO USER_ID %s]]):format(user_id, args[1])
                })
            end
        else
            vRP.clearInventory(user_id)
            vRP.sendLog("https://discord.com/api/webhooks/1304878881664139445/uZX_eWNTwwka27I3jpLO1HdC4eVs4x655xsI5I1jiimXEPE_P1957mqrDjv9XFugOFdp", "O ID: " .. user_id .. " limpou o inventario do ID: " .. user_id)

            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "clear-inv",
                user_id = user_id,
                message = ([[O USER_ID %s LIMPOU O INVENTARIO DO USER_ID %s]]):format(user_id, user_id)
            })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('god', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "perm.respilegal") or vRP.hasPermission(user_id, "perm.cc") or
        vRP.hasPermission(user_id, "paulinho.permissao") or vRP.hasPermission(user_id, "admin.permissao") or
        vRP.hasPermission(user_id, "perm.god") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasPermission(user_id, "streamer.permissao") or
        vRP.hasPermission(user_id, "perm.spawner") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            local nuser_id = vRP.getUserId(nplayer)
            if nplayer then
                vRPclient._DeletarObjeto(nplayer)
                vRPclient._stopAnim(nplayer)
                vRPclient._setHealth(nplayer, 300)
                vRP.sendLog("", "O ID " .. user_id .. " usou o /god no ID " .. parseInt(args[1]) .. "")

                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "god",
                    user_id = tonumber(user_id),
                    target_id = tonumber(nuser_id),
                    message = ([[O USER_ID %s USOU O GOD EM %s]]):format(user_id, parseInt(args[1]))
                })
            end
        else
            vRPclient._DeletarObjeto(source)
            vRPclient._stopAnim(source)

            vRPclient._setHealth(source, 300)
            vRP.sendLog("https://discord.com/api/webhooks/1304934039248965703/6woGsE0fmBanaRlArldIGpYLSWFfPM9tEWUs72ZiOV4Uy0vlMm5ffmKYXUEP47FtPYQ6", "O ID " .. user_id .. " usou o /god ")
            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "god",
                user_id = user_id,
                message = ([[O USER_ID %s USOU O GOD EM %s]]):format(user_id, user_id)
            })

        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GODD2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('godd2', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        local perms = {{
            permType = 'perm',
            perm = 'developer.permissao'
        }, {
            permType = 'group',
            perm = 'respeventoslotusgroup@445'
        }, {
            permType = 'group',
            perm = 'respstafflotusgroup@445'
        }, {
            permType = 'perm',
            perm = 'perm.resppolicia'
        }, {
            permType = 'perm',
            perm = 'perm.respilegal'
        }, {
            permType = 'group',
            perm = 'respeventoslotusgroup@445'
        }, {
            permType = 'group',
            perm = 'respstreamerlotusgroup@445'
        }}

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
        if not distance then
            return
        end

        local nplayers = vRPclient.getNearestPlayers(source, distance)
        for k, v in pairs(nplayers) do
            async(function()
                vRPclient._killGod(parseInt(k))
                vRPclient._setHealth(parseInt(k), 300)
                vRPclient.setArmour(parseInt(k), 100)
            end)
        end

        exports["vrp_admin"]:generateLog({
            category = "admin",
            room = "godd2",
            user_id = user_id,
            message = ([[O ADMIN %s USOU /GODD2 NA COORDS %s]]):format(user_id, coords)
        })

        TriggerClientEvent("Notify", source, "sucesso", "Você usou godarea em " .. distance .. " metro(s)", 5000)
        vRP.sendLog('', "O ADMIN " .. user_id .. " USOU /GODD2 NA COORDS " .. coords)
    end
end)

RegisterCommand('godd', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        local perms = {{
            permType = 'group',
            perm = 'respkidslotusgroup@445'
        }, {
            permType = 'group',
            perm = 'respstafflotusgroup@445'
        }, {
            permType = 'perm',
            perm = 'developer.permissao'
        }, {
            permType = 'group',
            perm = 'resppolicialotusgroup@445'
        }, {
            permType = 'group',
            perm = 'respilegallotusgroup@445'
        }, {
            permType = 'group',
            perm = 'respstreamerlotusgroup@445'
        }, {
            permType = 'perm',
            perm = 'perm.respilegal'
        }, {
            permType = 'perm',
            perm = 'perm.resplog'
        }}

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

        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            local nuser_id = vRP.getUserId(nplayer)
            if nplayer then
                vRPclient._killGod(nplayer)
                vRPclient._setHealth(nplayer, 300)
                vRPclient.setArmour(nplayer, 100)

                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "godd",
                    user_id = tonumber(user_id),
                    target_id = tonumber(nuser_id),
                    message = ([[O USER_ID %s USOU O GODD EM %s]]):format(user_id, parseInt(args[1]))
                })
            end
        else
            vRPclient._killGod(source)
            vRPclient._setHealth(source, 300)
            vRPclient.setArmour(source, 100)
            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "godd",
                user_id = user_id,
                message = ([[O USER_ID %s USOU O GODD EM %s]]):format(user_id, user_id)
            })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD ALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('godall', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.permissao") then
        local plyCoords = GetEntityCoords(GetPlayerPed(source))
        local x, y, z = plyCoords[1], plyCoords[2], plyCoords[3]

        local users = vRP.getUsers()
        for k, v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if id then
                vRPclient._killGod(id)
                vRPclient._setHealth(id, 300)
            end
        end
        vRP.sendLog("", "O ID " .. user_id .. " usou o /godall nas coordenadas: " .. x .. "," .. y .. "," .. z .. ".")
        TriggerClientEvent("Notify", source, "sucesso", "Godall utilizado com sucesso.", 5000)

    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cuff', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRPclient._toggleHandcuff(nplayer)
                vRP.sendLog('', 'ID ' .. user_id .. ' utilizou cuff no ' .. args[1])
            end
        else
            vRPclient._toggleHandcuff(source)
            vRP.sendLog('', 'ID ' .. user_id .. ' utilizou cuff no ' .. user_id)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CAPUZ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('capuz', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRPclient.setCapuz(nplayer, false)
            end
        else
            vRPclient.setCapuz(source, false)
            TriggerEvent("dk:removeItem", user_id, "capuz", 1)
        end
        vRP.sendLog('', 'ID ' .. user_id .. ' utilizou o capuz')
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- KILL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kill', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") then
        if args[1] then
            if parseInt(args[1]) == 2 or parseInt(args[1]) == 9 then
                return
            end
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRPclient._setHealth(nplayer, 0)
                SetTimeout(1000, function()
                    vRPclient._killComa(nplayer)
                end)

                vRP.sendLog("", "O ID " .. user_id .. " usou o /kill no ID " .. parseInt(args[1]) .. "")

                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "kill",
                    user_id = user_id,
                    target_id = parseInt(args[1]),
                    message = ([[O USER_ID %s USOU O KILL EM %s]]):format(user_id, parseInt(args[1]))
                })
            end
        else
            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "kill",
                user_id = user_id,
                message = ([[O USER_ID %s USOU O KILL NELE MESMO!]]):format(user_id)
            })
            vRPclient._setHealth(source, 0)
            SetTimeout(1000, function()
                vRPclient._killComa(source)
            end)
            vRP.sendLog('', 'O ID ' .. user_id .. ' utilizou o kill nele mesmo')
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Zerar fome e sede
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('zerarnec',function(source,args,rawCommand)
-- 	local user_id = vRP.getUserId(source)
-- 	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
-- 		if args[1] then
-- 			local nplayer = vRP.getUserSource(parseInt(args[1]))
-- 			if nplayer then
-- 				vRP.setHunger(parseInt(args[1]), 0)
-- 				vRP.setThirst(parseInt(args[1]), 0)
-- 			end
-- 		else
-- 			vRP.setHunger(user_id, 0)
-- 			vRP.setThirst(user_id, 0)
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('parall', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local player = vRP.getUserSource(user_id)
        if vRP.hasPermission(user_id, "admin.permissao") then
            TriggerClientEvent("nzk:giveParachute", -1)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- AA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('aa', function(source, args, raw)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    local text = string.sub(raw, 4)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasGroup(user_id, 'ajudantelotusgroup@445') then
        local admin = vRP.getUsersByPermission("ticket.permissao")
        for l, w in pairs(admin) do
            local player = vRP.getUserSource(parseInt(w))
            TriggerClientEvent("vrp_sound:source", player, 'novoaa', 0.2)
            TriggerClientEvent('chatMessage', player, {
                type = 'staff',
                title = 'Chat Admin:',
                message = '(' .. identity.nome .. ', #' .. user_id .. ') diz:  ' .. text
            })
            vRP.sendLog('https://discordapp.com/api/webhooks/1313516474157236224/Jd-Uywone5wBjlQn4lZY2v4JtcoJ_Efudh9vy-T_-CSfGqqoNHd6PxqJT7KUBp3mU5de', 'ID ' .. user_id .. ' enviou no chat aa: ' .. text)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpall', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local player = vRP.getUserSource(user_id)
        if vRP.hasPermission(user_id, "developer.permissao") then
            local plyCoords = GetEntityCoords(GetPlayerPed(player))
            local x, y, z = plyCoords[1], plyCoords[2], plyCoords[3]

            TriggerClientEvent("nzk:tpall", -1, x, y, z)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER DETENCAO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rdet', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local player = vRP.getUserSource(user_id)
        if vRP.hasPermission(user_id, "developer.permissao") then
            if tonumber(args[1]) and args[2] then
                vRP.execute("vRP/set_detido", {
                    user_id = tonumber(args[1]),
                    vehicle = args[2],
                    detido = 0
                })
                TriggerClientEvent("Notify", source, "sucesso",
                    "Você removeu o veiculo '..args[2]..' do [ID: '..tonumber(args[1])..'] da detencao/retencao.", 5)
            end
        end
    end
end)

local Spectate = {}
RegisterCommand('spec2', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local perms = {{
            permType = 'perm',
            perm = 'developer.permissao'
        }, {
            permType = 'group',
            perm = 'respstafflotusgroup@445'
        },
        {
            permType = 'group',
            perm = 'respeventoslotusgroup@445'
        },
    }

        local hasPermission = false
        for _, perm in ipairs(perms) do
            if perm.permType == 'perm' then
                if vRP.hasPermission(user_id, perm.perm) then
                    hasPermission = false
                    break
                end
            elseif perm.permType == 'group' then
                if vRP.hasGroup(user_id, perm.perm) then
                    hasPermission = false
                    break
                end
            end
        end

        if not hasPermission then
            return
        end

        if parseInt(args[1]) == 2 or parseInt(args[1]) == 9 then
            return
        end

        if Spectate[user_id] then
            local Ped = GetPlayerPed(Spectate[user_id])
            if DoesEntityExist(Ped) then
                SetEntityDistanceCullingRadius(Ped, 0.0)
            end

            TriggerClientEvent("admin:resetSpectate", source)
            Spectate[user_id] = nil
            vRP.sendLog('', 'ID ' .. user_id .. ' desativou o spectate')
        else
            local nsource = vRP.getUserSource(tonumber(args[1]))
            if nsource then
                if vRP.hasPermission(tonumber(args[1]), 'developer.permissao') then
                    return
                end
                local Ped = GetPlayerPed(nsource)
                if DoesEntityExist(Ped) then
                    SetEntityDistanceCullingRadius(Ped, 999999999.0)
                    Wait(1000)
                    TriggerClientEvent("admin:initSpectate", source, nsource)
                    Spectate[user_id] = nsource
                    vRP.sendLog('', 'ID ' .. user_id .. ' ativou o spectate no ID ' .. args[1])
                end
            end
        end
    end
end)
---------------------------------------------------------------------------------------------------------------------------------------
-- ACAO
---------------------------------------------------------------------------------------------------------------------------------------
local dimensionId = 666
local plysAction = {}
local facsInfo = {
    ["pmerj"] = "perm.militar",
    ["bope"] = "perm.bope",
    ["choque"] = "perm.choque",
    ["exercito"] = "perm.exercito",
    ["policiacivil"] = "perm.policiacivil",
    ["core"] = "perm.core",
    ["prf"] = "perm.prf",
    ["hospital"] = "perm.unizk",
    ["bombeiro"] = "perm.bombeiro",
    ["judiciario"] = "perm.judiciario",
    ["jornal"] = "perm.jornal",
    ["portugal"] = "perm.portugal",
    ["playboy"] = "perm.playboy",
    ["grota"] = "perm.grota",
    ["inglaterra"] = "perm.inglaterra",
    ["cv"] = "perm.cv",
    ["pcc"] = "perm.pcc",
    ["milicia"] = "perm.milicia",
    ["espanha"] = "perm.espanha",
    ["tequila"] = "perm.tequila",
    -- ["cartel"] = "perm.cartel",
    ["cdd"] = "perm.cdd",
    ["hellsangels"] = "perm.hellsangels",
    ["motoclube"] = "perm.motoclube",
    ["lacoste"] = "perm.lacoste",
    ['hellzera'] = "perm.hellzera",
    ["pedreira"] = "perm.pedreira",
    ["viladochaves"] = "perm.viladochaves",
    ["anonymous"] = "perm.anonymous",
    ["vanilla"] = "perm.vanilla",
    ["lux"] = "perm.lux",
    -- ["castelinho"] = "perm.castelinho",
    ["bahamas"] = "perm.bahamas",
    ["cassino"] = "perm.cassino",
    ["medusa"] = "perm.medusa",
    ["suecia"] = "perm.suecia",
    ["israel"] = "perm.israel",
    ["vermelhos"] = "perm.vermelhos",
    ["jacarezinho"] = "perm.jacarezinho",
    ["juramento"] = "perm.juramento",
    ["chapadao"] = "perm.chapadao",
    ["elements"] = "perm.elements",
    ["chatubademesquita"] = "perm.chatubademesquita",
    ["china"] = "perm.china",
    ["grecia"] = "perm.grecia",
    ["russia"] = "perm.russia",
    ["colombia"] = "perm.colombia",
    ["faveladorodo"] = "perm.faveladorodo",
    ["croacia"] = "perm.croacia",
    ["franca"] = "perm.franca",
    ["pantanal"] = "perm.pantanal",
    ["roxos"] = "perm.roxos",
    ["vagos"] = "perm.vagos",
    ["customs"] = "perm.customs",
    ["bennys"] = "perm.bennys",
    ["maisonette"] = "perm.maisonette"

}

RegisterCommand('acao', function(source, args)
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end
    if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "perm.resppolicia") or
        vRP.hasPermission(user_id, "perm.respilegal") or vRP.hasPermission(user_id, "diretor.permissao") then

        local prefix = args[1]
        if not prefix or prefix == "" then
            return
        end

        if prefix == "iniciar" or prefix == "finalizar" then
            local t = ""
            for k in pairs(facsInfo) do
                t = t .. k .. ", "
            end

            local fac = vRP.prompt(source, "Lista de Facções: ", t)
            if not fac or fac == "" then
                return
            end
            fac = fac:lower()

            if not facsInfo[fac] then
                TriggerClientEvent("Notify", source, "sucesso", "Organização/Facção não encontrada.", 5000)
                return
            end

            local plyList = ""
            for _, playerSrc in pairs(GetPlayers()) do
                async(function()
                    local playerId = vRP.getUserId(playerSrc)
                    if playerId and vRP.hasPermission(playerId, facsInfo[fac]) then
                        if prefix == "iniciar" then
                            TriggerClientEvent("Notify", playerSrc, "sucesso", "Você entrou na dimensão de ação.",
                                5000)
                            SetPlayerRoutingBucket(playerSrc, dimensionId)
                            plysAction[playerId] = true
                            plyList = plyList .. playerId .. ", "
                        else
                            TriggerClientEvent("Notify", playerSrc, "sucesso", "Você saiu da dimensão de ação.",
                                5000)
                            SetPlayerRoutingBucket(playerSrc, 0)
                            if plysAction[playerId] then
                                plyList = plyList .. playerId .. ", "

                                plysAction[playerId] = nil
                            end
                        end
                    end
                end)
            end

            if prefix == "iniciar" then
                if plyList == "" then
                    TriggerClientEvent("Notify", source, "sucesso", "Nenhum jogador online.", 5000)
                    return
                end

                TriggerClientEvent("Notify", source, "importante", "Você iniciou a ação para a facção: " ..
                    fac:upper() .. "<br><br>IDS: " .. plyList, 5000)
            else
                if plyList == "" then
                    TriggerClientEvent("Notify", source, "sucesso", "Nenhum jogador na acao.", 5000)
                    return
                end

                TriggerClientEvent("Notify", source, "importante", "Você finalizou a ação para a facção: " ..
                    fac:upper() .. "<br><br>IDS: " .. plyList, 5000)
            end
        end
    end
end)

RegisterCommand('sair', function(source, args)
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    if GetEntityHealth(GetPlayerPed(source)) <= 105 then
        TriggerClientEvent("Notify", source, "sucesso", "Você não pode usar esse comando morto.", 5000)
        return
    end

    if not plysAction[user_id] then
        TriggerClientEvent("Notify", source, "sucesso", "Você não está em uma ação.", 5000)
        return
    end

    TriggerClientEvent("Notify", source, "sucesso", "Você saiu da ação.", 5000)
    SetPlayerRoutingBucket(source, 0)
    plysAction[user_id] = nil
end)

local dimensionIdPerson = 798
local plysActionPerson = {}
RegisterCommand('acaoid', function(source, args)
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    local perms = {{
        permType = 'perm',
        perm = 'developer.permissao'
    }, {
        permType = 'perm',
        perm = 'perm.respilegal'
    }, {
        permType = 'perm',
        perm = 'respstreamer.permissao'
    }, {
        permType = 'perm',
        perm = 'perm.resppolicia'
    }, {
        permType = 'group',
        perm = 'respeventoslotusgroup@445'
    }, {
        permType = 'group',
        perm = 'respstafflotusgroup@445'
    }, {
        permType = 'group',
        perm = 'respkidsofflotusgroup@445'
    }, {
        permType = 'group',
        perm = 'respkidsofflotusgroup@445'
    }, {
        permType = 'group',
        perm = 'cconteudo'
    }}

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

    local prefix = args[1]
    if not prefix or prefix == "" then
        return
    end
    if prefix == "iniciar" or prefix == "finalizar" then
        local playerID = vRP.prompt(source, "Digite o ID do Jogador: ", "")
        if not playerID or playerID == "" then
            return
        end
        playerID = tonumber(playerID)
        local nplayer = vRP.getUserSource(parseInt(playerID))
        local nuser_id = vRP.getUserId(nplayer)
        if nplayer then
            async(function()
                if prefix == "iniciar" then
                    TriggerClientEvent("Notify", nplayer, "sucesso", "Você entrou na dimensão de ação.", 5000)
                    SetPlayerRoutingBucket(nplayer, dimensionIdPerson)
                    plysActionPerson[nuser_id] = true
                else
                    TriggerClientEvent("Notify", nplayer, "sucesso", "Você saiu da dimensão de ação.", 5000)
                    SetPlayerRoutingBucket(nplayer, 0)
                    if plysActionPerson[nuser_id] then
                        plysActionPerson[nuser_id] = nil
                    end
                end
            end)
        end
        if prefix == "iniciar" then
            TriggerClientEvent("Notify", source, "importante",
                "Você iniciou a ação para o ID: " .. nuser_id .. "<br><br>", 5000)
            vRP.sendLog('', 'ID ' .. user_id .. ' iniciou acaoid para o ' .. nuser_id)
        else
            TriggerClientEvent("Notify", source, "importante",
                "Você finalizou a ação para o ID: " .. nuser_id .. "<br><br>", 5000)
            vRP.sendLog('', 'ID ' .. user_id .. ' finalizou acaoid para o ' .. nuser_id)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Freeze
-----------------------------------------------------------------------------------------------------------------------------------------
local groupList = {
    -- ["resploglotusgroup@445"] = true,
    ["respilegallotusgroup@445"] = true,
    -- ["respstafflotusgroup@445"] = true,
    ["developerlotusgroup@445 "] = true
    -- ["TOP1"] = true,
}

RegisterCommand('freeze', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local userPermission = function()
            for k, v in pairs(groupList) do
                if vRP.hasGroup(user_id, k) then
                    return true
                end
            end
            return false
        end

        if userPermission() or vRP.hasPermission(user_id, 'developer.permissao') --[[ or vRP.hasPermission(user_id,"perm.resplog") or vRP.hasPermission(user_id,'admin.permissao') or vRP.hasPermission(user_id,'perm.respilegal') ]] then
            if args[1] then
                local nsource = vRP.getUserSource(tonumber(args[1]))
                if nsource then
                    local isFreeze = vCLIENT.setFreeze(nsource)
                    local messageFreeze = isFreeze and "Jogador de ID: " .. tonumber(args[1]) .. " congelado." or
                                              "Jogador de ID: " .. tonumber(args[1]) .. " descongelado."
                    TriggerClientEvent("Notify", source, "sucesso", messageFreeze)
                    vRP.sendLog('', 'STAFF ID ' .. user_id .. ' utilizou /freeze no ID ' .. tonumber(args[1]))

                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMENSAOAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dimensaoarea', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    local perms = {{
        permType = 'perm',
        perm = 'developer.permissao'
    }, {
        permType = 'group',
        perm = 'respilegallotusgroup@445'
    }, {
        permType = 'group',
        perm = 'respkidslotusgroup@445'
    }, {
        permType = 'group',
        perm = 'respeventoslotusgroup@445'
    }, {
        permType = 'group',
        perm = 'respstafflotusgroup@445'
    }, {
        permType = 'group',
        perm = 'resppolicialotusgroup@445' 
    }}

    local hasPerm = false
    for _, perm in ipairs(perms) do
        if perm.permType == 'perm' and vRP.hasPermission(user_id, perm.perm) then
            hasPerm = true
            break
        elseif perm.permType == 'group' and vRP.hasGroup(user_id, perm.perm) then
            hasPerm = true
            break
        end
    end

    if not hasPerm then
        return
    end

    local coords = GetEntityCoords(GetPlayerPed(source))
    local prefix = args[1]
    if not prefix or prefix == "" then
        return
    end

    local distance = tonumber(args[2])
    if not distance then
        return
    end

    if prefix == "iniciar" or prefix == "finalizar" then
        local nplayers = vRPclient.getNearestPlayers(source, distance)
        for k, v in pairs(nplayers) do
            async(function()
                local nuser_id = vRP.getUserId(k)
                if prefix == "iniciar" then
                    TriggerClientEvent("Notify", k, "sucesso", "Você entrou na dimensão de ação.", 5000)
                    SetPlayerRoutingBucket(k, dimensionIdPerson)
                    plysActionPerson[nuser_id] = true
                else
                    TriggerClientEvent("Notify", k, "sucesso", "Você saiu da dimensão de ação.", 5000)
                    SetPlayerRoutingBucket(k, 0)
                    plysActionPerson[nuser_id] = nil
                end
            end)
        end

        exports["vrp_admin"]:generateLog({
            category = "admin",
            room = "dimensaoarea",
            user_id = user_id,
            message = string.format("O ADMIN %s USOU /DIMENSAOAREA NA COORDS %s", user_id, coords)
        })
        TriggerClientEvent("Notify", source, "sucesso", "Você usou dimensaoarea em " .. distance .. " metro(s)", 5000)
        vRP.sendLog('', string.format("O ADMIN %s USOU /DIMENSAOAREA NA COORDS %s", user_id, coords))
    end
end)

RegisterCommand('dimensao', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    if not vRP.hasPermission(user_id, 'developer.permissao') then
        return
    end

    local coords = GetEntityCoords(GetPlayerPed(source))
    local prefix = args[1]
    if not prefix or prefix == "" then
        return
    end

    local distance = tonumber(args[2])
    if not distance then
        return
    end

    local dimension = tonumber(args[3])
    if not dimension then
        return
    end

    if prefix == "iniciar" or prefix == "finalizar" then
        local nplayers = vRPclient.getNearestPlayers(source, distance)
        for k, v in pairs(nplayers) do
            async(function()
                local nuser_id = vRP.getUserId(k)
                if prefix == "iniciar" then
                    TriggerClientEvent("Notify", k, "sucesso", "Você entrou na dimensão de ação.", 5000)
                    SetPlayerRoutingBucket(k, dimension)
                    plysActionPerson[nuser_id] = true
                else
                    TriggerClientEvent("Notify", k, "sucesso", "Você saiu da dimensão de ação.", 5000)
                    SetPlayerRoutingBucket(k, 0)
                    plysActionPerson[nuser_id] = nil
                end
            end)
        end

        exports["vrp_admin"]:generateLog({
            category = "admin",
            room = "dimensaoarea",
            user_id = user_id,
            message = string.format("O ADMIN %s USOU /DIMENSAOAREA NA COORDS %s", user_id, coords)
        })
        TriggerClientEvent("Notify", source, "sucesso", "Você usou dimensaoarea em " .. distance .. " metro(s)", 5000)
        vRP.sendLog('', string.format("O ADMIN %s USOU /DIMENSAOAREA NA COORDS %s", user_id, coords))
    end
end)

RegisterCommand('sairid', function(source, args)
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    if GetEntityHealth(GetPlayerPed(source)) <= 105 then
        TriggerClientEvent("Notify", source, "sucesso", "Você não pode usar esse comando morto.", 5000)
        return
    end

    if not plysActionPerson[user_id] then
        TriggerClientEvent("Notify", source, "sucesso", "Você não está em uma ação.", 5000)
        return
    end

    TriggerClientEvent("Notify", source, "sucesso", "Você saiu da ação.", 5000)
    SetPlayerRoutingBucket(source, 0)
    plysActionPerson[user_id] = nil
end)

RegisterCommand('vdm', function(source, args)
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    if vRP.hasPermission(user_id, "developer.permissao") then
        local dimID = args[1]
        if not dimID or dimID == "" then
            return
        end
        dimID = tonumber(dimID)

        local plyList = ""
        for _, playerSrc in pairs(GetPlayers()) do
            async(function()
                local playerId = vRP.getUserId(playerSrc)
                if playerId and GetPlayerRoutingBucket(playerSrc) == dimID then
                    plyList = plyList .. playerId .. ", "
                end
            end)
        end

        if plyList == "" then
            TriggerClientEvent("Notify", source, "sucesso", "Nenhum jogador nessa dimensão.", 5000)
            return
        end

        TriggerClientEvent("Notify", source, "importante",
            "Jogadores na dimensão " .. dimID .. ":<br><br>IDS: " .. plyList, 5000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Deleta todos Carros
---------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('clearallveh', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "diretor.permissao") or
            vRP.hasPermission(user_id, "perm.respilegal") then
            TriggerClientEvent('chatMessage', -1, {
                type = 'default',
                title = 'Limpeza de Veiculo:',
                message = 'Contagem Iniciada 60s para limpeza de veiculos. (Entre em seu veiculo para não ser removido)'
                -- type = 'vip', -- vip/relacionamento/termino
            })

            Wait(60000)

            local deleteCount = 0
            local entityList = {}
            for k, v in ipairs(GetAllVehicles()) do
                local ped = GetPedInVehicleSeat(v, -1)
                if not ped or ped <= 0 then
                    DeleteEntity(v)

                    if GetEntityScript(v) ~= nil then
                        if not entityList[GetEntityScript(v)] then
                            entityList[GetEntityScript(v)] = 0
                        end
                        entityList[GetEntityScript(v)] = entityList[GetEntityScript(v)] + 1
                    end

                    deleteCount = deleteCount + 1
                end
            end

            TriggerClientEvent('chatMessage', -1, {
                type = 'default',
                title = 'Limpeza de Veiculo',
                message = deleteCount .. " veiculo deletados!"
                -- type = 'vip', -- vip/relacionamento/termino
            })
        end
    end
end)

RegisterCommand('clearallveh2', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "diretor.permissao") then
            Wait(1000)

            local deleteCount = 0
            local entityList = {}
            for k, v in ipairs(GetAllVehicles()) do
                local ped = GetPedInVehicleSeat(v, -1)
                if not ped or ped <= 0 then
                    DeleteEntity(v)

                    if GetEntityScript(v) ~= nil then
                        if not entityList[GetEntityScript(v)] then
                            entityList[GetEntityScript(v)] = 0
                        end
                        entityList[GetEntityScript(v)] = entityList[GetEntityScript(v)] + 1
                    end

                    deleteCount = deleteCount + 1
                end
            end

            TriggerClientEvent('chatMessage', -1, {
                type = 'default',
                title = 'Limpeza de Veiculo:',
                message = deleteCount .. " veiculo deletados!"
                -- type = 'vip', -- vip/relacionamento/termino
            })
        end
    end
end)

-- RegisterCommand('admincv', function(source, args, rawCommand)
--     if source == 0 then
--         local deleteCount = 0
--         for k, v in ipairs(GetAllVehicles()) do
--             DeleteEntity(v)

--             deleteCount = deleteCount + 1
--         end

--         TriggerClientEvent('chatMessage', -1, {
--             type = 'default',
--             title = 'Limpeza de Veiculo:',
--             message = deleteCount .. " veiculo deletados!"
--             -- type = 'vip', -- vip/relacionamento/termino
--         })

--         TriggerClientEvent('chatMessage', -1, {
--             type = 'default',
--             title = 'Limpeza de Veiculo:',
--             message = deleteCount .. " veiculo deletados!"
--             -- type = 'vip', -- vip/relacionamento/termino
--         })
--     end
-- end)

-- RegisterCommand('adminco', function(source, args, rawCommand)
--     if source == 0 then
--         local deleteCount = 0
--         for k, v in ipairs(GetAllObjects()) do
--             DeleteEntity(v)

--             deleteCount = deleteCount + 1
--         end

--         TriggerClientEvent('chatMessage', -1, {
--             type = 'default',
--             title = 'Limpeza de Objetos:',
--             message = deleteCount .. " objetos deletados!"
--             -- type = 'vip', -- vip/relacionamento/termino
--         })
--     end
-- end)

-- RegisterCommand('clearallobj', function(source, args, rawCommand)
--     local source = source
--     local user_id = vRP.getUserId(source)
--     if user_id ~= nil then
--         if vRP.hasPermission(user_id, "developer.permissao") then
--             local deleteCount = 0
--             local entityList = {}
--             for k, v in ipairs(GetAllObjects()) do
--                 if DoesEntityExist(v) then
--                     DeleteEntity(v)
--                     deleteCount = deleteCount + 1
--                 end
--             end

--             TriggerClientEvent('chatMessage', -1, {
--                 type = 'default',

--                 title = 'Limpeza de Objetos:',
--                 message = deleteCount .. " objetos deletados!"
--                 -- type = 'vip', -- vip/relacionamento/termino
--             })
--         end
--     end
-- end)

-- CreateThread(function()

--     -- for k,v in pairs(GetAllVehicles()) do
--     -- 	DeleteEntity(v)
--     -- end
--     RunClearObjs()

-- end)
-- local modelsBlock = {
--     1729911864,
--     -205311355,
--     1336576410,
-- 	2142235947,
-- 	-1971581912,
-- 	GetHashKey('ex_prop_adv_case_sm_03'),
-- 	GetHashKey('prop-mesa-relikiashop'),
-- 	GetHashKey('prop-mesa-prop_bin_14a'),
-- 	GetHashKey('prop_mp_barrier_02b'),
-- 	GetHashKey('prop_mp_barrier_02b'),
-- 	GetHashKey('prop_mp_conc_barrier_01'),
--     GetHashKey('prop_mp_cone_01'),
--     GetHashKey('prop_mp_cone_04'),
--     GetHashKey('prop_mp_cone_02'),
--     GetHashKey('p_ld_stinger_s'),
--     GetHashKey('prop_barrier_work06a'),
--     GetHashKey('prop_barrier_work01a'),
--     GetHashKey('p_parachute1_mp_dec'),
-- }
-- function table.contains(table, element)
--     for _, value in pairs(table) do
--         if value == element then
--             return true
--         end
--     end
--     return false
-- end

-- local spammingSource = {}
-- RunClearObjs = function()
--     SetTimeout(60 * 1000, RunClearObjs)

--     local obj_count = 0
--     for k,v in ipairs(GetAllObjects()) do 
    
--         local modelbarreria = GetEntityModel(v)
        
--         if modelbarreria == 1729911864 or modelbarreria == -205311355 or modelbarreria == 1245865676 or modelbarreria ==
--             -717142483 or modelbarreria == 2142235947 or modelbarreria == -1971581912 or modelbarreria == GetHashKey('ex_prop_adv_case_sm_03') or modelbarreria == GetHashKey('p_parachute1_mp_dec') then
--             goto next
--         end
--         pcall(function()


--             if DoesEntityExist(v) then
--                 DeleteEntity(v)
--                 obj_count = obj_count + 1
--             end
--         end)

--         :: next ::
--     end
    
--     -- print("Objetos Deletados: "..obj_count)
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PORTE DE ARMAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('vporte', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "perm.disparo") or vRP.hasPermission(user_id, "perm.core") or
        vRP.hasPermission(user_id, "perm.policiacivil") or vRP.hasPermission(user_id, "developer.permissao") or
        vRP.hasPermission(user_id, "perm.judiciario") or vRP.hasPermission(user_id, "perm.bombeiro") then
        local nplayer = vRPclient.getNearestPlayer(source, 4)
        if not nplayer then
            return TriggerClientEvent("Notify", source, "negado", "Ninguém por perto.")
        end
        local nuser_id = vRP.getUserId(nplayer)

        local identity = vRP.getUserIdentity(nuser_id)
        local walletMoney = vRP.getMoney(nuser_id)

        local porte = "Não possui porte de armas"
        if vRP.hasGroup(nuser_id, "Porte de Armas") then
            porte = "Possui porte de armas leve"
        elseif vRP.hasGroup(nuser_id, "Porte de Armas Medio") then
            porte = "Possui porte de armas médio"
        elseif vRP.hasGroup(nuser_id, "Porte de Armas Pesado") then
            porte = "Possui porte de armas pesado"
        end

        if not identity then
            return false
        end

        TriggerClientEvent("Notify", source, "sucesso",
            "Passaporte: <b>" .. parseInt(nuser_id) .. "</b><br>Nome: <b>" .. identity.nome .. " " .. identity.sobrenome ..
                "</b><br>Idade: <b>" .. identity.idade .. "</b><br>Carteira: <b>" .. vRP.format(parseInt(walletMoney)) ..
                "</b><br>Porte: <b>" .. porte .. "</b>", 5)
    end
end)

RegisterCommand('addporte', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end
    if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasGroup(user_id, "setport") then
        if args[1] then

            local nsource = vRP.getUserSource(parseInt(args[1]))
            if nsource then
                vRP.addUserGroup(parseInt(args[1]), "Porte de Armas")
                TriggerClientEvent("Notify", source, "sucesso",
                    "Você deu o porte de armas para o ID: " .. parseInt(args[1]) .. "!", 5)

            else
                local rows = vRP.getUData(parseInt(args[1]), "vRP:datatable")
                if #rows > 0 then
                    local data = json.decode(rows) or {}
                    local groupteste = "Porte de Armas"
                    if data then
                        if data then
                            data.groups[groupteste] = true
                        end
                    end

                    vRP.setUData(parseInt(args[1]), "vRP:datatable", json.encode(data))
                    TriggerClientEvent("Notify", source, "sucesso", "** OFFLINE ** Você adicionou o <b>(ID: " ..
                        parseInt(args[1]) .. ")</b> no grupo: <b>" .. groupteste .. "</b>", 5000)

                end
            end
            vRP.sendLog('', 'ID ' .. user_id .. ' utilizou /addporte no ID ' .. args[1])
        end
    end
end)

RegisterCommand('remporte', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end
    if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, 'perm.resppolicia') or
        vRP.hasPermission(user_id, 'perm.policiaporte') or vRP.hasGroup(user_id, "setport") then
        if args[1] then
            local nsource = vRP.getUserSource(parseInt(args[1]))
            if nsource then
                if vRP.hasGroup(parseInt(args[1]), "Porte de Armas") then
                    TriggerClientEvent("Notify", source, "negado", "Você removeu o porte de armas do cidadao.", 5)
                    vRP.removeUserGroup(parseInt(args[1]), "Porte de Armas")
                    vRP.sendLog('', 'ID ' .. user_id .. ' utilizou /remporte no ID ' .. args[1])
                else
                    TriggerClientEvent("Notify", source, "negado", "Este cidadao nao possui porte de arma.", 5)
                end
            else
                local nuserId = parseInt(args[1])
                local query = exports.oxmysql:executeSync('SELECT * FROM vrp_user_data WHERE user_id = ? AND dkey = ?', { nuserId, 'vRP:datatable' })
                if query and #query > 0 then
                    local data = json.decode(query[1].dvalue) or {}
                    if not data or not data.groups then
                        TriggerClientEvent("Notify", source, "negado", "Este cidadao nao possui porte de arma.", 5)
                        return
                    end 

                    if not data.groups["Porte de Armas"] then
                        TriggerClientEvent("Notify", source, "negado", "Este cidadao nao possui porte de arma.", 5)
                        return
                    end

                    data.groups["Porte de Armas"] = nil
                    exports.oxmysql:execute('UPDATE vrp_user_data SET dvalue = ? WHERE dkey = ? AND user_id = ?', { json.encode(data), 'vRP:datatable', nuserId })
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Usuário não encontrado')
                end
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('hash2', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") then
        local vehicle = vRPclient.getNearestVehicle(source, 7)
        if vehicle then
            vRP.prompt(source, "Hash Veiculo: ", vCLIENT.returnHashVeh(source, vehicle))
        end
    end
end)

RegisterCommand('schack', function(source, args, command)
    local user_id = vRP.getUserId(source)
    if (vRP.hasPermission(user_id, "player.noclip")) then
        TriggerClientEvent("MQCU:getfodido", source)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET CHAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rchar', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRP.execute("vRP/set_controller", {
                    user_id = parseInt(args[1]),
                    controller = 0,
                    rosto = "{}",
                    roupas = "{}"
                })
                vRP.kick(parseInt(args[1]), "\n[ADMIN] Você foi kickado \n entre novamente para fazer sua aparencia")
                TriggerClientEvent("Notify", source, "sucesso", "Você resetou o ID - " .. parseInt(args[1]) .. ".",
                    5000)
            else
                vRP.execute("vRP/set_controller", {
                    user_id = parseInt(args[1]),
                    controller = 0,
                    rosto = "{}",
                    roupas = "{}"
                })
                TriggerClientEvent("Notify", source, "sucesso", "Você resetou o ID - " .. parseInt(args[1]) .. ".",
                    5000)
            end

            vRP.setUData(parseInt(args[1]), 'rewardCar', 1)

            vRP.sendLog("https://discord.com/api/webhooks/1304886130893783132/xvgHLJLALpo-k8yClhzyaVY_oCyJk4KkpfVQTyKb0YrGV6ZEwiTJM7ANFiXXE9yquk1m", "O ID: " .. user_id .. " usou o comando /rchar no ID: " .. args[1])

            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "limpeza-personagem",
                user_id = user_id,
                message = ([[O USER_ID %s LIMPOU O PERSONAGEM DO USER_ID %s]]):format(user_id, parseInt(args[1]))
            })
        end
    end
end)

RegisterCommand('kick_console', function(source, args)
    if source > 0 then
        return
    end

    local plysrc = vRP.getUserSource(parseInt(args[1]))
    if plysrc then
        DropPlayer(plysrc, "Flw!.")
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DESEMPREGADOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("searchabusers", function(source)
    if source == 0 then
        for i = 1, 15 do
            local rows = exports.oxmysql:executeSync(string.format([[
                SELECT * FROM vrp_user_data WHERE CAST(JSON_EXTRACT(dvalue, '$.inventory.%s.amount') AS UNSIGNED) > 10000000
            ]], i))
            for k, v in pairs(rows) do
                local dvalue = json.decode(v.dvalue)
                for slot, item_data in pairs(dvalue.inventory) do
                    if item_data.amount > 10000000 then
                        local query = vRP.query("mirtin_bans/getUserBans", {
                            user_id = user_id
                        })
                        local is_banned = #query > 0
                        print("^1[Suspeito]^7 User_Id: " .. v.user_id .. " | ^2(" .. item_data.item .. " x " ..
                                  item_data.amount .. ") ^7" .. ((is_banned) and "^2[BANIDO] ^7" or ""))
                        break
                    end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESEMPREGADOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('desempregados', function(source, args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "admin.permissao") then
            local listPlys = ""
            local count_plys = 0
            for _, playerId in pairs(GetPlayers()) do
                local plyId = vRP.getUserId(playerId)

                if plyId then
                    local org = vRP.getUserGroupByType(plyId, "org")
                    if org == "" then
                        count_plys = count_plys + 1
                        listPlys = listPlys .. plyId .. "; "
                    end
                end
            end

            vRP.sendLog("", listPlys)
            -- vRP.log("logs/desempregados/"..os.date("%d-%m-%Hh")..".txt", listPlys)

            TriggerClientEvent("Notify", source, "importante", "<b>IGUAÇU RJ:</b><br>Total Desempregados: " .. count_plys ..
                "<br><br>IDS Desempregados: " .. listPlys, 10000)
        end
    end
end)

RegisterCommand('desempregados2', function(source, args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "admin.permissao") then
            local listPlys = ""
            for _, playerId in pairs(GetPlayers()) do
                local plyId = vRP.getUserId(playerId)

                if plyId then
                    local org = vRP.getUserGroupByType(plyId, "org")
                    if org == "" then
                        listPlys = listPlys .. plyId .. "; "
                    end
                end
            end

            vRP.prompt(source, "Kobe troxa: ", listPlys)

        end
    end
end)

RegisterCommand('desempregados3', function(source, args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "admin.permissao") then
            local listPlys = ""
            for _, playerId in pairs(GetPlayers()) do
                local plyId = vRP.getUserId(playerId)

                if plyId then
                    local org = vRP.getUserGroupByType(plyId, "org")
                    if org == "" and vRP.isWhitelisted(plyId) then

                        local distance = #(GetEntityCoords(GetPlayerPed(playerId)) - vec3(-1711.33, -885.91, 7.84))

                        if distance > 300 then
                            listPlys = listPlys .. "tptome " .. plyId .. "; "
                        end
                    end
                end
            end

            vRP.prompt(source, "Kobe troxa: ", listPlys)

        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCSDESEMPREGADOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('locdesempregados', function(source, args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if not vRP.hasPermission(user_id, "admin.permissao") then
            return
        end

        local status, time = exports['vrp']:getCooldown(user_id, "locdesempregados")
        if status then
            exports['vrp']:setCooldown(user_id, "locdesempregados", 60)

            local Plys = {}
            for _, playerId in pairs(GetPlayers()) do
                local plyId = vRP.getUserId(playerId)

                if plyId then
                    local org = vRP.getUserGroupByType(plyId, "org")
                    if org == "" then
                        Plys[#Plys + 1] = GetEntityCoords(GetPlayerPed(playerId))
                    end
                end
            end

            vCLIENT._SetUnemployed(source, Plys)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RDESMANCHE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rdesmanche', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.permissao") then
        if args[1] then
            local query = vRP.query("bm_module/garages/getAllUserVehicles", {
                user_id = tonumber(args[1])
            })

            local t = {}
            local formatVehs
            if #query > 0 then
                formatVehs = ""

                for k in pairs(query) do
                    local class = exports["nova_garage"]:getVehicleType(query[k].veiculo)
                    if class ~= nil then
                        t[query[k].veiculo:lower()] = query[k].veiculo
                        formatVehs = formatVehs .. query[k].veiculo .. ","
                    end
                end
            end

            if formatVehs == nil then
                TriggerClientEvent("Notify", source, "negado", "Você não possui nenhum veiculo", 5000)
                return
            end

            local selectedVehicle = vRP.prompt(source, "Escolha o veiculo para remover o desmanche!", formatVehs)
            if formatVehs == "" or formatVehs == nil then
                TriggerClientEvent("Notify", source, "negado", "Digite o nome do veiculo corretamente.", 5000)
                return
            end

            selectedVehicle = selectedVehicle:lower()
            if not t[selectedVehicle] then
                TriggerClientEvent("Notify", source, "negado", "Veiculo não encontrado na garagem..", 5000)
                return
            end

            local vehName = exports["nova_garage"]:getVehicleName(t[selectedVehicle])
            exports.oxmysql:query(
                "UPDATE vrp_user_veiculos SET status = @status WHERE user_id = @user_id AND veiculo = @veiculo", {
                    user_id = parseInt(args[1]),
                    veiculo = selectedVehicle,
                    status = 0
                })
            TriggerClientEvent("Notify", source, "sucesso", "Retenção/Detido do veículo removida com sucesso!", 5000)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RRCITY
-----------------------------------------------------------------------------------------------------------------------------------------
function sendServerRestartEmbed()
    local webhookURL = 'https://discord.com/api/webhooks/1331030184345997373/yvbnrVr15I3_rFmyp9uRoEDuNfGIaMw-LLBjYabY71JKBcht9AGCioKH92TJbPYXucFH'
    local date = os.date("*t")
    local restartTime = string.format("%02d:%02d:%02d", date.hour, date.min, date.sec)

    local embed = {{
        ["title"] = "Servidor Reiniciado",
        ["description"] = "O servidor foi reiniciado com sucesso!",
        ["color"] = 16711680,
        ["fields"] = {{
            ["name"] = "Horário da Reinicialização",
            ["value"] = restartTime,
            ["inline"] = true
        }},
        ["footer"] = {
            ["text"] = "IGUAÇU RJ"
        },
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }}

    PerformHttpRequest(webhookURL, function(err, text, headers)
    end, 'POST', json.encode({
        username = "Servidor Bot",
        embeds = embed
    }), {
        ['Content-Type'] = 'application/json'
    })
end

RegisterCommand('rrcity', function(source, args)
    if source > 0 then
        return
    end
    print("^2Salvando Contas... Aguarde!")

    rrcity = true
    local contador = 0

    for _, v in pairs(GetPlayers()) do
        TriggerClientEvent('vrp_inventory:closeup', v)
        DropPlayer(v, "Reiniciando a Cidade!")
        contador = contador + 1
    end

    print("^2Contas Salvas: ^0" .. contador)
    TriggerEvent("saveInventory")
    sendServerRestartEmbed()
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tunning', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "perm.cc") then
        local vehicle = vRPclient.getNearestVehicle(source, 7)
        if vehicle then
            local entity = NetworkGetEntityFromNetworkId(vehicle)
            local vehicleModel = exports.nova_garage:getVehicleModel(GetEntityModel(entity))
            local vehicleName = exports.nova_garage:getVehicleName(vehicleModel)
            vRP.sendLog('https://discord.com/api/webhooks/1319342098646044693/ZLQFAHBzP__7e1bMFhBO5WWsz3gJfvgMT0riZzgm3pBnguuQ6nmcQEmXtQAFkrsXCLYB', 'O ADMIN '..user_id..' USOU /TUNING NO VEICULO '..vehicleName)
            TriggerClientEvent('vehtuning', source, vehicle)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tuning2', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.permissao") then
        local vehicle = vRPclient.getNearestVehicle(source, 7)
        if vehicle then
            TriggerClientEvent('vehtuning2', source, vehicle)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('wladd', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasGroup(user_id, "TOP1") or
        vRP.hasGroup(user_id, "respilegallotusgroup@445") then
        if args[1] then
            TriggerClientEvent("Notify", source, "sucesso", "Você liberou o ID: " .. args[1], 5000)
            vRP.setWhitelisted(parseInt(args[1]), true)
            vRP.sendLog("https://discord.com/api/webhooks/1304935291920060496/W8ye0dGktkG3OKfzIlakGrNi5O_ZPvrahQ5yEB4cBONPrUBbWCCoTQJj8WbXGR6-Cljc", "O ID " .. user_id .. " adicionou o id " .. parseInt(args[1]))

            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "wladd",
                user_id = user_id,
                message = ([[O USER_ID %s ADICIONOU O USER_ID %s]]):format(user_id, parseInt(args[1]))
            })
        end
    end
end)

local allowedIds = { -- IDS LIBERADO

}

RegisterCommand('renomear', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.permissao") or allowedIds[parseInt(tonumber(user_id))] then
        local idjogador = vRP.prompt(source, "Qual id do jogador?", "")
        local nome = vRP.prompt(source, "Novo nome", "")
        local firstname = vRP.prompt(source, "Novo sobrenome", "")
        local idade = vRP.prompt(source, "Nova idade", "")
        local identity = vRP.getUserIdentity(parseInt(idjogador))
        if not identity then
            return
        end

        vRP.execute("vRP/update_user_identity", {
            user_id = idjogador,
            sobrenome = firstname,
            nome = nome,
            idade = idade,
            registro = identity.registro,
            telefone = identity.telefone
        })
        TriggerClientEvent("Notify", source, "sucesso",
            "Você renomeou o nome com sucesso. Informe o mesmo para aguardar até o próximo rr da cidade para modificação ser aplicada.",
            5000)
        vRP.sendLog("RENOMEAR", "O ID " .. user_id .. " renomeou o id " .. idjogador)

        exports["vrp_admin"]:generateLog({
            category = "admin",
            room = "renomear",
            user_id = user_id,
            message = ([[O USER_ID %s RENOMEOU O USER_ID %s]]):format(user_id, parseInt(idjogador))
        })
    end
end)

RegisterCommand('rg2', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") then
        local nuser_id = parseInt(args[1])
        
        if not nuser_id then
            TriggerClientEvent("Notify", source, "negado", "Digite o ID desejado!", 5000)
            return
        end
        
        local statusUser = vRP.getUserSource(nuser_id) and 'Online' or 'Offline'
        local identity = vRP.getUserIdentity(nuser_id) or {
            nome = 'Individuo',
            sobrenome = 'Indigente',
            idade = 21,
            telefone = '999-999'
        }
        local bankMoney = vRP.getBankMoney(nuser_id)
        local walletMoney = vRP.getMoney(nuser_id)
        local sets = json.decode(vRP.getUData(nuser_id, "vRP:datatable")) or {}
        local infoUser = vRP.query("vRP/get_all_users", { id = nuser_id })
        
        if infoUser[1] then
            local ultimo_login =  infoUser[1].ultimo_login and infoUser[1].ultimo_login or 'Não encontrado'
            local userGroups = sets.groups or {}

            userGroups["cargomakakero"] = nil

            local userGroupsFormatted = string.gsub(json.encode(userGroups), ",", ", ")
            TriggerClientEvent("Notify", source, "sucesso", 
                "ID: <b>" .. parseInt(nuser_id) .. "</b><br>" ..
                "Nome: <b>" .. identity.nome .. " " .. identity.sobrenome .. "</b><br>" ..
                "Idade: <b>" .. identity.idade .. "</b><br>" ..
                "Telefone: <b>" .. identity.telefone .. "</b><br>" ..
                "Carteira: <b>" .. vRP.format(parseInt(walletMoney)) .. "</b><br>" ..
                "Banco: <b>" .. vRP.format(parseInt(bankMoney)) .. "</b><br>" ..
                "Grupos: <b>" .. userGroupsFormatted .. "</b><br>" ..
                "Último Login: <b>" .. ultimo_login .. "</b><br>" ..
                "Status: <b>" .. statusUser .. "</b>", 
                5000
            )
            vRP.sendLog('', 'ID ' .. user_id .. ' utilizou rg2 no ' .. nuser_id)
        else
            TriggerClientEvent("Notify", source, "negado", "ID não encontrado!", 5000)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IN
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("select_smartphone_instagram", "SELECT * FROM smartphone_instagram WHERE username = @username")
RegisterCommand('in', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id, "admin.permissao") then
        return
    end

    local name_instagram = args[1]
    if not name_instagram or name_instagram == "" then
        return
    end

    local query = vRP.query("select_smartphone_instagram", {
        username = name_instagram
    })
    if #query == 0 then
        TriggerClientEvent("Notify", source, "negado", "Username nao encontrado.", 5000)
        return
    end

    TriggerClientEvent("Notify", source, "negado", "User_id: " .. query[1].user_id, 5000)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GODAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('godarea', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)

    local perms = {
        { permType = 'group', perm = 'resppolicialotusgroup@445' },
        { permType = 'group', perm = 'respstafflotusgroup@445' },
        { permType = 'perm', perm = 'perm.resplog' },
        { permType = 'perm', perm = 'respstreamer.permissao' },
        { permType = 'perm', perm = 'respeventos.permissao' },
        { permType = 'perm', perm = 'perm.cc' },
        { permType = 'perm', perm = 'perm.resppolicia' },
        { permType = 'perm', perm = 'diretor.permissao' },
        { permType = 'perm', perm = 'perm.respilegal' },
        { permType = 'perm', perm = 'developer.permissao' },
    }

    local allowedIds = {
    }

    local hasPermission = false
    for _, perm in ipairs(perms) do
        if perm.permType == 'perm' and vRP.hasPermission(user_id, perm.perm) then
            hasPermission = true
            break
        elseif perm.permType == 'group' and vRP.hasGroup(user_id, perm.perm) then
            hasPermission = true
            break
        end
    end

    if not hasPermission and not allowedIds[user_id] then 
        return 
    end

    local coords = GetEntityCoords(GetPlayerPed(source))

    local distance = tonumber(args[1])
    if not distance then
        return
    end

    local usersReceivedGodArea = ""

    local nplayers = vRPclient.getNearestPlayers(source, distance)
    for k, v in pairs(nplayers) do
        async(function()
            usersReceivedGodArea = usersReceivedGodArea .. ", " .. vRP.getUserId(k)
            vRPclient._setHealth(parseInt(k), 300)
        end)
    end


    vRP.sendLog(
        "https://discord.com/api/webhooks/1304883594367602802/ArDRGUHSP53_pbZ0B3srfmohXSHpy74KdICvi1NGmHtb53MJBzTyf6ZgbZv_nc6zyO8-",
        "O Admin ID: " .. user_id .. " utilizou /godarea nas coords " .. coords .. " e afetou os seguintes usuários: " .. usersReceivedGodArea)
    exports["vrp_admin"]:generateLog({
        category = "admin",
        room = "godarea",
        user_id = user_id,
        message = ([[O ADMIN %s USOU /GODAREA NA COORDS %s]]):format(user_id, coords)
    })

    TriggerClientEvent("Notify", source, "sucesso", "Você usou godarea em " .. distance .. " metro(s)", 5000)

end)

RegisterCommand('killarea', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)

    local perms = {
        { permType = 'perm', perm = 'developer.permissao' },
        { permType = 'group', perm = 'TOP1' },
        { permType = 'group', perm = 'developerlotusgroup@445' },
        { permType = 'group', perm = 'respilegallotusgroup@445' },
        { permType = 'group', perm = 'resploglotusgroup@445' },
        { permType = 'group', perm = 'resppolicialotusgroup@445' },
        { permType = 'group', perm = 'respstafflotusgroup@445' },
        { permType = 'group', perm = 'respeventoslotusgroup@445' },
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

    if args[1] then
        local distance = tonumber(args[1])
        if not distance then
            return
        end
        local nplayers = vRPclient.getNearestPlayers(source, distance)
        local killArea = ""
        for k, v in pairs(nplayers) do
            async(function()
                killArea = killArea .. ", " .. vRP.getUserId(k)
                vRPclient._setHealth(parseInt(k), 0)
                SetTimeout(100, function()
                    vRPclient._setHealth(parseInt(k), 0)
                end)
            end)
        end
        vRP.sendLog('', 'O ADMIN '..user_id..' USOU /KILLAREA NA COORDS '..coords..' E AFETOU OS SEGUINTES USUÁRIOS: '..killArea)
    end
end)

RegisterCommand('idarea', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasGroup(user_id, "respilegallotusgroup@445") then
        if args[1] then

            local distance = tonumber(args[1])
            if not distance then
                return
            end
            local formatUsers = ""

            local nplayers = vRPclient.getNearestPlayers(source, distance)
            for k, v in pairs(nplayers) do
                local user_id = vRP.getUserId(k)
                formatUsers = formatUsers .. " " .. user_id .. "; "
            end
            Log2("", "```js\n" .. formatUsers .. "```")

            vRP.prompt(source, 'IDs pŕoximos', formatUsers)

        end

    end
end)


function Log2(weebhook, message)
    PerformHttpRequest(weebhook, function(err, text, headers)
    end, 'POST', json.encode({
        content = message
    }), {
        ['Content-Type'] = 'application/json'
    })
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- UNWL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('wlrem', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") then
        if args[1] then
            TriggerClientEvent("Notify", source, "sucesso", "Você removeu a WL do ID: " .. args[1], 5000)
            vRP.setWhitelisted(parseInt(args[1]), false)

            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "wlrem",
                user_id = user_id,
                message = ([[O USER_ID %s REMOVEU WHITELIST DO USER_ID %s]]):format(user_id, parseInt(args[1]))
            })
            vRP.sendLog('', 'O ID ' .. user_id .. ' removeu a whitelist do ID ' .. parseInt(args[1]))
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVE ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local restricted_weapons = {"WEAPON_GUSENBERG", "AMMO_WEAPON_GUSENBERG", "WEAPON_PARAFAL", "AMMO_PARAFAL", "WEAPON_RPG",
                            "AMMO_RPG", "WEAPON_MUSKET", "AMMO_MUSKET", "WEAPON_PUMPSHOTGUN", "AMMO_PUMPSHOTGUN",
                            "WEAPON_DOUBLEACTION", "AMMO_DOUBLEACTION"
}

local restrictedItems = {
    "WEAPON_STUNGUN", 
    "WEAPON_APPISTOL", 
    "WEAPON_MICROSMG", 
    "WEAPON_PUMPSHOTGUN_MK2",
    "WEAPON_COMBATPDW", 
    "WEAPON_HEAVYSNIPER", 
    "WEAPON_SPECIALCARBINE", 
    "WEAPON_PISTOL50",
    "WEAPON_DOUBLEACTION", 
    "WEAPON_REVOLVER_MK2", 
    "WEAPON_SAWNOFFSHOTGUN", 
    "WEAPON_RAYPISTOL",
    "AMMO_APPISTOL", 
    "AMMO_MICROSMG", 
    "AMMO_PUMPSHOTGUN", 
    "AMMO_COMBATPDW", 
    "AMMO_HEAVYSNIPER",
    "AMMO_SPECIALCARBINE", 
    "AMMO_PISTOL50", 
    "AMMO_DOUBLEACTION", 
    "AMMO_REVOLVER_MK2",
    "AMMO_SAWNOFFSHOTGUN", 
    "COCACOLA",
    "WEAPON_AKPENTEDE90_RELIKIASHOP", 
    "WEAPON_AKDEFERRO_RELIKIASHOP", 
    "WEAPON_AK472", 
    "WEAPON_AR10PRETO_RELIKIASHOP", 
    "WEAPON_AR15BEGE_RELIKIASHOP", 
    "WEAPON_ARPENTEACRILICO_RELIKIASHOP", 
    "WEAPON_ARDELUNETA_RELIKIASHOP", 
    "WEAPON_ARLUNETAPRATA", 
    "WEAPON_ARTAMBOR", 
    "WEAPON_G3LUNETA_RELIKIASHOP", 
    "WEAPON_GLOCKDEROUPA_RELIKIASHOP", 
    "WEAPON_HKG3A3", 
    "WEAPON_HK_RELIKIASHOP", 
    "WEAPON_PENTEDUPLO1", 
    "WEAPON_RAYPISTOL", 
    "WEAPON_HEAVYSNIPER_MK2", 
    "WEAPON_50_RELIKIASHOP",
    "AMMO_AKPENTEDE90_RELIKIASHOP", 
    "AMMO_AKDEFERRO_RELIKIASHOP", 
    "AMMO_AK472", 
    "AMMO_AR10PRETO_RELIKIASHOP", 
    "AMMO_AR15BEGE_RELIKIASHOP", 
    "AMMO_ARPENTEACRILICO_RELIKIASHOP", 
    "AMMO_ARDELUNETA_RELIKIASHOP", 
    "AMMO_ARLUNETAPRATA", 
    "AMMO_ARTAMBOR", 
    "AMMO_G3LUNETA_RELIKIASHOP", 
    "AMMO_GLOCKDEROUPA_RELIKIASHOP", 
    "AMMO_HKG3A3", 
    "AMMO_HK_RELIKIASHOP", 
    "AMMO_PENTEDUPLO1", 
    "AMMO_RAYPISTOL", 
    "AMMO_HEAVYSNIPER_MK2", 
    "AMMO_50_RELIKIASHOP",

    "WEAPON_AKCROMO", 
    "WEAPON_ARRELIKIASHOPFEMININO1", 
    "WEAPON_ARRELIKIASHOPFEMININO2", 
    "WEAPON_ARVASCO", 
    "WEAPON_CHEYTAC", 
    "WEAPON_G3RELIKIASHOPFEMININO", 
    "WEAPON_GLOCKRAJADA",
    "WEAPON_GLOCKRELIKIASHOPFEMININO0",
}

function IsRestrictedItem(itemHash)
    for _, restrictedItem in ipairs(restrictedItems) do
        if itemHash:lower() == restrictedItem:lower() then
            return true
        end
    end
    return false
end

RegisterCommand('item', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.permissao") or (not restricted_weapons[args[1]] and
        (vRP.hasPermission(user_id, "perm.cc") or vRP.hasPermission(user_id, "admin.permissao") or
            vRP.hasPermission(user_id, "paulinho.permissao"))) then
        if args[1] and args[2] then
            if not vRP.hasPermission(user_id, "developer.permissao") and IsRestrictedItem(args[1]) then
                return
            end

            local restrictedItems = {"WEAPON_FIREWORK", "AMMO_FIREWORK", "WEAPON_MICROSMG", "WEAPON_HEAVYSNIPER",
                                     "AMMO_HEAVYSNIPER", "WEAPON_GUSENBERG", "alterartelefone", "WEAPON_RAYPISTOL", "WEAPON_RPG"}
            if (table.contains(restrictedItems, args[1]:upper())) and
                not (vRP.hasPermission(user_id, 'developer.permissao')) then
                TriggerClientEvent('Notify', source, 'negado', 'Você não pode givar este item.')
                return
            end
            if args[1]:find("WEAPON") or args[1]:find("AMMO") then
                args[1] = args[1]:lower()
            end

            if args[1] == "money" then
                local creturn = vRP.getItemInSlot(user_id, "money", false)
                if creturn then
                    vRP.giveInventoryItem(user_id, "" .. args[1] .. "", parseInt(args[2]), true, creturn)
                    exports["vrp_admin"]:generateLog({
                        category = "admin",
                        room = "spawn-money",
                        user_id = user_id,
                        message = ([[O ADMIN %s GIVOU O ITEM %s na quantidade de x %s]]):format(user_id, args[1],
                            args[2])
                    })
                else
                    vRP.giveInventoryItem(user_id, "" .. args[1] .. "", parseInt(args[2]), true)
                    exports["vrp_admin"]:generateLog({
                        category = "admin",
                        room = "spawn-money",
                        user_id = user_id,
                        message = ([[O ADMIN %s GIVOU O ITEM %s na quantidade de x %s]]):format(user_id, args[1],
                            args[2])
                    })
                end
            else
                vRP.giveInventoryItem(user_id, "" .. args[1] .. "", parseInt(args[2]), true)
                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "spawn-item",
                    user_id = user_id,
                    message = ([[O ADMIN %s GIVOU O ITEM %s na quantidade de x %s]]):format(user_id, args[1], args[2])
                })
            end

            vRP.sendLog("", "O ID " .. user_id .. " givou o item " .. args[1] .. " na quantidade de " .. args[2] .. " x")
        end
    end
end)

RegisterCommand('groupremall', function(source, args)
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id, 'developer.permissao') then
        return
    end

    local group = args[1]
    if not group then
        return
    end

    local query = vRP.query('VRP_ADMIN/SelectGroup', {
        groups = '$.groups.' .. group
    })
    for i = 1, #query do
        local nsource = vRP.getUserSource(query[i].user_id)
        if nsource then
            vRP.removeUserGroup(query[i].user_id, group)
            TriggerClientEvent("Notify", source, "negado", "Você removeu o <b>(ID: " .. query[i].user_id ..
                ")</b> no grupo: <b>" .. group .. "</b>", 5000)
            vRP.sendLog("", "O ID " .. user_id .. " removeu o grupo " .. group .. " do id " .. args[1] .. "")

            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "grouprem",
                user_id = user_id,
                message = ([[O USER_ID %s REMOVEU O USER_ID %s DO GRUPO %s]]):format(user_id, query[i].user_id, group)
            })
        else
            local rows = vRP.getUData(query[i].user_id, "vRP:datatable")
            if #rows > 0 then
                local data = json.decode(rows) or {}
                if data then
                    if data then
                        data.groups[group] = nil
                    end
                end

                vRP.setUData(query[i].user_id, "vRP:datatable", json.encode(data))
                TriggerClientEvent("Notify", source, "negado", "** OFFLINE ** Você removeu o <b>(ID: " ..
                    query[i].user_id .. ")</b> no grupo: <b>" .. group .. "</b>", 5000)
                vRP.sendLog("", "O ID " .. user_id .. " removeu o grupo " .. group .. " do id " .. args[1] .. "")

                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "grouprem",
                    user_id = user_id,
                    message = ([[O USER_ID %s REMOVEU O USER_ID %s DO GRUPO %s]]):format(user_id, query[i].user_id,
                        group)
                })
            end
        end
    end
    TriggerClientEvent("Notify", source, "sucesso", "Removido grupo " .. group .. " de todos IDS", 5)

end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVE ITEM PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('itemp', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    local respGroups = vRP.hasGroup(user_id, "respstafflotusgroup@445") or
                           vRP.hasGroup(user_id, "respilegallotusgroup@445") or
                           vRP.hasGroup(user_id, "respeventoslotusgroup@445") or
                           vRP.hasGroup(user_id, "resppolicialotusgroup@445") or
                           vRP.hasPermission(user_id, "respeventos.permissao")
    if user_id and respGroups or vRP.hasPermission(user_id, "developer.permissao") or
        vRP.hasPermission(user_id, "diretor.permissao") or vRP.hasGroup(user_id, "respilegallotusgroup@445") or
        vRP.hasGroup(user_id, "resppolicialotusgroup@445") then
        if args[1] and args[2] and args[3] then
            if not vRP.hasPermission(user_id, "developer.permissao") and IsRestrictedItem(args[1]) then
                return
            end

            local restrictedItems = {"WEAPON_FIREWORK", "AMMO_FIREWORK", "WEAPON_MICROSMG", "WEAPON_HEAVYSNIPER",
                                     "AMMO_HEAVYSNIPER", "WEAPON_GUSENBERG"}
            if (table.contains(restrictedItems, args[2]:upper())) and
                not (vRP.hasPermission(user_id, 'developer.permissao')) then
                TriggerClientEvent('Notify', source, 'negado', 'Você não pode givar este item.')
                return
            end

            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                TriggerClientEvent("Notify", source, "sucesso",
                    "(ID: " .. parseInt(args[1]) .. ") Você givou o Item: " .. args[2] .. " " .. parseInt(args[3]) ..
                        "x", 5)
                vRP.sendLog("https://discord.com/api/webhooks/1327431744776835092/mMEXhtUd0a-VcUH32UvkCfgsYWGKvqsP5WPZpCKT-EPldQY3tGJgh_2eiuJ4uNJ9tSgi",
                    "O STAFF [" .. user_id .. "] givou o item " .. args[2] .. " na quantidade de " .. args[3] ..
                        " x para o ID [" .. args[1] .. "]")

                if args[2] == "money" or args[2] == "dirty_money" then
                    vRP.giveInventoryItem(parseInt(args[1]), "" .. args[2] .. "", parseInt(args[3]), true)
                    exports["vrp_admin"]:generateLog({
                        category = "admin",
                        room = "spawn-money",
                        user_id = user_id,
                        message = ([[O USER_ID %s USOU O /ITEMP %s NA QUANTIDADE DE %s PARA O USER_ID %s]]):format(
                            user_id, args[2], args[3], args[1])
                    })
                    vRP.sendLog('https://discord.com/api/webhooks/1327431744776835092/mMEXhtUd0a-VcUH32UvkCfgsYWGKvqsP5WPZpCKT-EPldQY3tGJgh_2eiuJ4uNJ9tSgi', ([[O USER_ID %s USOU O /ITEMP %s NA QUANTIDADE DE %s PARA O USER_ID %s]]):format(
                        user_id, args[2], args[3], args[1]))
                else
                    vRP.giveInventoryItem(parseInt(args[1]), "" .. args[2] .. "", parseInt(args[3]), true)

                    exports["vrp_admin"]:generateLog({
                        category = "admin",
                        room = "spawn-item",
                        user_id = user_id,
                        message = ([[O USER_ID %s GIVOU O /ITEMP %s NA QUANTIDADE DE %s PARA O USER_ID %s]]):format(
                            user_id, args[2], args[3], args[1])
                    })
                    vRP.sendLog('https://discord.com/api/webhooks/1327431744776835092/mMEXhtUd0a-VcUH32UvkCfgsYWGKvqsP5WPZpCKT-EPldQY3tGJgh_2eiuJ4uNJ9tSgi', ([[O USER_ID %s GIVOU O /ITEMP %s NA QUANTIDADE DE %s PARA O USER_ID %s]]):format(
                        user_id, args[2], args[3], args[1]))
                end
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('money', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") then
        if args[1] then
            vRP.giveMoney(user_id, parseInt(args[1]))

            vRP.sendLog("https://discord.com/api/webhooks/1304885956196827167/oFEkLQl-v-GVZzAdc4qPVEH28ZY1-C8GeWKo-foTmszeDC-VpeeC2TlOx8AcJ-TXLP31", "O ID " .. user_id .. " usou o /money na quantidade de " .. parseInt(args[1]) .. "")

            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "spawn-money",
                user_id = user_id,
                message = ([[O ADMIN %s USOU O /MONEY NA QUANTIDADE DE %s x]]):format(user_id, args[1])
            })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('nc', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "perm.cc") or vRP.hasPermission(user_id, "paulinho.permissao") or
        vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasPermission(user_id, "streamer.permissao") or
        vRP.hasPermission(user_id, "perm.spawner") or vRP.hasGroup(user_id, 'ajudantelotusgroup@445') then
        local plyCoords = GetEntityCoords(GetPlayerPed(source))
        local x, y, z = plyCoords[1], plyCoords[2], plyCoords[3]

        vRP.sendLog(
            'https://discord.com/api/webhooks/1304934382024527993/FpE96IfZJSNB21YA_2RtLCvdBiQSy1831VLW5QNxX3jncdJJl9rF3tzPq1pCaJwGJSEB',
            'O ID ' .. user_id .. ' utilizou /nc nas coords ' .. x .. ',' .. y .. ',' .. z .. '.')
        vRPclient._toggleNoclip(source)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpcds', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasGroup(user_id, 'ajudantelotusgroup@445') then
        local fcoords = vRP.prompt(source, "Cordenadas:", "")
        if fcoords == "" then
            return
        end
        local coords = {}
        for coord in string.gmatch(fcoords or "0,0,0", "[^,]+") do
            table.insert(coords, parseInt(coord))
        end

        vRPclient._teleport(source, coords[1] or 0, coords[2] or 0, coords[3] or 0)
        vRP.sendLog('', 'O ID ' .. user_id .. ' utilizou o /tpcds nas coords ' .. coords[1] .. ',' .. coords[2] .. ',' .. coords[3] .. '.')
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cds', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    -- if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
    --     vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasGroup(user_id, 'ajudantelotusgroup@445') then
        local plyCoords = GetEntityCoords(GetPlayerPed(source))
        local x, y, z = plyCoords[1], plyCoords[2], plyCoords[3]

        vRP.prompt(source, "Cordenadas:", tD(x) .. "," .. tD(y) .. "," .. tD(z))
    -- end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CDS2
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cds2', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "mod.permissao") or
        vRP.hasGroup(user_id, "suporte") then
        local plyCoords = GetEntityCoords(GetPlayerPed(source))
        local x, y, z = plyCoords[1], plyCoords[2], plyCoords[3]

        vRP.prompt(source, "Cordenadas:", "['x'] = " .. tD(x) .. ", ['y'] = " .. tD(y) .. ", ['z'] = " .. tD(z))
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CDSH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cdsh', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasGroup(user_id, 'ajudantelotusgroup@445') then
        local plyCoords = GetEntityCoords(GetPlayerPed(source))
        local x, y, z = plyCoords[1], plyCoords[2], plyCoords[3]

        vRP.prompt(source, "Cordenadas:", tD(x) .. "," .. tD(y) .. "," .. tD(z) .. "," .. tD(vCLIENT.myHeading(source)))
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CDSGARAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cdsgaragem', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasGroup(user_id, 'ajudantelotusgroup@445') then
        local plyCoords = GetEntityCoords(GetPlayerPed(source))
        local x, y, z = plyCoords[1], plyCoords[2], plyCoords[3]

        vRP.prompt(source, "Cordenadas:",
            "vector4(" .. tD(x) .. "," .. tD(y) .. "," .. tD(z) .. "," .. tD(vCLIENT.myHeading(source)) .. ")")
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CDSH2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cdsh2', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasGroup(user_id, 'ajudantelotusgroup@445') then
        local plyCoords = GetEntityCoords(GetPlayerPed(source))
        local x, y, z = plyCoords[1], plyCoords[2], plyCoords[3]

        vRP.prompt(source, "Cordenadas:",
            "vec3(" .. tD(x) .. "," .. tD(y) .. "," .. tD(z) .. "), heading = " .. tD(vCLIENT.myHeading(source)))
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('debug', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local player = vRP.getUserSource(user_id)
        if vRP.hasPermission(user_id, "admin.permissao") then
            TriggerClientEvent("NZK:ToggleDebug", player)
        end
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local groupsSets = {
    ['respeventoslotusgroup@445'] = 'developer.permissao',
    ['respeventosofflotusgroup@445'] = 'developer.permissao',
    ["adminlotusgroup@445"] = "developer.permissao",
    ["adminofflotusgroup@445"] = "developer.permissao",
    ["respilegallotusgroup@445"] = "developer.permissao",
    ["respilegalofflotusgroup@445"] = "developer.permissao",
    ["moderadorlotusgroup@445"] = "developer.permissao",
    ["moderadorofflotusgroup@445"] = "developer.permissao"
}

local groupadd_perms = {'admin.permissao', 'perm.respilegal', 'developer.permissao'}
local blocked_roles = {"cconteudo", "developerlotusgroup@445", 'cam', "developerofflotusgroup@445",
                       "respilegallotusgroup@445", "respilegalofflotusgroup@445", "streamer",
                       "respeventoslotusgroup@445", "respeventosofflotusgroup@445", "adminlotusgroup@445",
                       "adminofflotusgroup@445", "moderadorlotusgroup@445", "moderadorofflotusgroup@445", "TOP1", "tlg",
                       "valecasa5kk", "valecasa7kk", "valecasa10kk", "valecasa100kk", "ValeCasaRubi",
                       "ValeCasaEsmeralda", "spotify", 'Porte de Armas', "Streamer", "Booster", "Verificado",
                       "manobras", "Plastica", "Inicial", "Bronze", "Prata", "Ouro", "Platina", "Diamante", "Esmeralda",
                       "Safira", "Rubi", "Altarj", "Supremobela", "VipCrianca", "VipSaoJoao", "VipNatal", "Vip2025", "VipAnoNovo",
                       "VipCarnaval", 'VipSetembro', "SalarioGerente", "SalarioPatrao", "VipWipe",
                       "SalarioVelhodalancha", "SalarioCelebridade", "SalarioMilionario", "SalarioDosDeuses",
                       "SalarioDoMakakako", "Porte de Armas", 'revogacao', 'resppolicialotusgroup@445',
}

RegisterCommand('groupadd', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)

    local has_permission = false
    for _, perm in pairs(groupadd_perms) do
        if vRP.hasPermission(user_id, perm) then
            has_permission = true
            break
        end
    end

    if not has_permission then
        TriggerClientEvent("Notify", source, "negado", "Você não tem permissão para usar este comando.", 5000)
        return
    end

    if not args[1] or not args[2] then
        TriggerClientEvent("Notify", source, "negado", "Uso incorreto do comando. Use: /groupadd [ID] [Grupo]", 5000)
        return
    end

    local target_id = parseInt(args[1])
    local group = args[2]


    if not groups[group] then
        TriggerClientEvent("Notify", source, "negado", "Grupo não encontrado.", 5000)
        return
    end

    local is_blocked = false
    for _, blocked_group in pairs(blocked_roles) do
        if string.lower(group) == string.lower(blocked_group) then
            is_blocked = true
            break
        end
    end

    if is_blocked and not vRP.hasPermission(user_id, "developer.permissao") then
        TriggerClientEvent("Notify", source, "negado", "Você não tem permissão para adicionar este grupo.", 5000)
        return
    end

    local target_source = vRP.getUserSource(target_id)
    if target_source then
        vRP.addUserGroup(target_id, group)
        TriggerClientEvent("Notify", source, "sucesso", "Você adicionou o <b>(ID: " .. target_id .. ")</b> no grupo: <b>" .. group .. "</b>", 5000)
    else
        local rows = vRP.getUData(target_id, "vRP:datatable")
        if rows then
            local data = json.decode(rows) or {}
            data.groups = data.groups or {}
            data.groups[group] = true
            vRP.setUData(target_id, "vRP:datatable", json.encode(data))

            TriggerClientEvent("Notify", source, "sucesso", "** OFFLINE ** Você adicionou o <b>(ID: " .. target_id .. ")</b> no grupo: <b>" .. group .. "</b>", 5000)
        else
            TriggerClientEvent("Notify", source, "negado", "Usuário não encontrado ou sem dados salvos.", 5000)
            return
        end
    end

    exports["vrp_admin"]:generateLog({
        category = "admin",
        room = "groupadd",
        user_id = user_id,
        message = ([[O USER_ID %s SETOU O USER_ID %s NO GRUPO %s]]):format(user_id, target_id, group)
    })
end)

local blocked_roles_vip = {"Bronze", "Prata", "Ouro", "Platina", "Diamante", "Esmeralda", "Safira", "Rubi", "Belarp",
                           "Supremobela", "VipCrianca", "VipSaoJoao", 'VipSetembro', "VipNatal", "VipAnoNovo",
                           "VipCarnaval", "SalarioGerente", "SalarioPatrao", "SalarioVelhodalancha",
                           "SalarioCelebridade", "SalarioMilionario", "SalarioDosDeuses", "SalarioDoMakakako", "Vip2025"}

RegisterCommand('setdev', function(source, args, rawCommand)
    if source == 0 then
        print('GROUP = ' .. args[2] .. ' added to USERID = ' .. args[1] .. ' ')
        vRP.addUserGroup(tonumber(args[1]), args[2])
        return
    end

    local user_id = vRP.getUserId(source)

    if args[2] == "TOP1" then
        return
    end

    if vRP.hasPermission(user_id, "developer.permissao") then
        if args[1] and args[2] then
            for k, v in pairs(blocked_roles_vip) do
                if string.lower(args[2]) == string.lower(v) then
                    TriggerClientEvent("Notify", source, "negado", "Aqui não, bobinho!")
                    return
                end
            end

            local nsource = vRP.getUserSource(parseInt(args[1]))
            if nsource then
                local groupteste = args[2]

                vRP.addUserGroup(parseInt(args[1]), groupteste)
                TriggerClientEvent("Notify", source, "sucesso", "Você adicionou o <b>(ID: " .. parseInt(args[1]) ..
                    ")</b> no grupo: <b>" .. groupteste .. "</b>", 5000)
                vRP.sendLog("https://discord.com/api/webhooks/1304880537273372673/Hwz44Mh_14lr-WLB1Q0fb0AjpfCC5UowE7U43rf9_kTHbEiEFd1bD71a57rzhmGVEM1y", "O ID " .. user_id .. " usou o setou " .. parseInt(args[1]) .. " no grupo " ..
                    groupteste .. "")

                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "groupadd",
                    user_id = user_id,
                    message = ([[O USER_ID %s SETOU O USER_ID %s NO GRUPO %s]]):format(user_id, args[1], groupteste)
                })
            else
                local rows = vRP.getUData(parseInt(args[1]), "vRP:datatable")
                if #rows > 0 then
                    local data = json.decode(rows) or {}
                    local groupteste = args[2]
                    if data then
                        if data then
                            data.groups[groupteste] = true
                        end
                    end

                    vRP.setUData(parseInt(args[1]), "vRP:datatable", json.encode(data))
                    TriggerClientEvent("Notify", source, "sucesso", "** OFFLINE ** Você adicionou o <b>(ID: " ..
                        parseInt(args[1]) .. ")</b> no grupo: <b>" .. groupteste .. "</b>", 5000)
                    vRP.sendLog("https://discord.com/api/webhooks/1304880537273372673/Hwz44Mh_14lr-WLB1Q0fb0AjpfCC5UowE7U43rf9_kTHbEiEFd1bD71a57rzhmGVEM1y",
                        "O ID " .. user_id .. " usou o setou " .. parseInt(args[1]) .. " no grupo " .. groupteste .. "")

                    exports["vrp_admin"]:generateLog({
                        category = "admin",
                        room = "groupadd",
                        user_id = user_id,
                        message = ([[O USER_ID %s SETOU O USER_ID %s NO GRUPO %s]]):format(user_id, args[1], groupteste)
                    })
                end
            end
        end
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GROUPREM
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('bktop1', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)

    if user_id ~= 2 and user_id ~= 5565 then
        return
    end

    vRP.addUserGroup(user_id, 'TOP1')
end)

local toDevRemGroups = {
    -- ["BlacklistPolicia"] = true
}

RegisterCommand('grouprem', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") then
        local group = ""
        for i = 2, #args do
            group = group .. args[i] .. " "
        end
        group = group:sub(1, -2)

        if not groups[group] then
            TriggerClientEvent("Notify", source, "negado", "Grupo não encontrado.", 5000)
            return
        end

        if toDevRemGroups[group] and not vRP.hasPermission(user_id, "developer.permissao") then
            return false
        end

        -- if group == "developerlotusgroup@445" then
        -- 	return
        -- end

        if args[1] and group ~= "" then
            local nsource = vRP.getUserSource(parseInt(args[1]))
            if nsource then
                vRP.removeUserGroup(parseInt(args[1]), group)
                TriggerClientEvent("Notify", source, "negado", "Você removeu o <b>(ID: " .. parseInt(args[1]) ..
                    ")</b> no grupo: <b>" .. group .. "</b>", 5000)
                vRP.sendLog("https://discord.com/api/webhooks/1304879455809831063/gFpWoDwiCzMbgY3Ob3pHTLQdj2ojiQ3kvEYCTvd_XXrvk86-Emwl0rlIG7ag-Qi-VyGG", "O ID " .. user_id .. " removeu o grupo " .. group .. " do id " .. args[1] .. "")

                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "grouprem",
                    user_id = user_id,
                    message = ([[O USER_ID %s REMOVEU O USER_ID %s DO GRUPO %s]]):format(user_id, args[1], group)
                })
            else
                local rows = vRP.getUData(parseInt(args[1]), "vRP:datatable")
                if #rows > 0 then
                    local data = json.decode(rows) or {}
                    if data then
                        if data then
                            data.groups[group] = nil
                        end
                    end

                    vRP.setUData(parseInt(args[1]), "vRP:datatable", json.encode(data))
                    TriggerClientEvent("Notify", source, "negado", "** OFFLINE ** Você removeu o <b>(ID: " ..
                        parseInt(args[1]) .. ")</b> no grupo: <b>" .. group .. "</b>", 5000)
                    vRP.sendLog("https://discord.com/api/webhooks/1304879455809831063/gFpWoDwiCzMbgY3Ob3pHTLQdj2ojiQ3kvEYCTvd_XXrvk86-Emwl0rlIG7ag-Qi-VyGG", "O ID " .. user_id .. " removeu o grupo " .. group .. " do id " .. args[1] .. "")

                    exports["vrp_admin"]:generateLog({
                        category = "admin",
                        room = "grouprem",
                        user_id = user_id,
                        message = ([[O USER_ID %s REMOVEU O USER_ID %s DO GRUPO %s]]):format(user_id, args[1], group)
                    })
                end
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
local player_customs = {}
RegisterCommand('display', function(source, args, rawCommand)
    local custom = vRPclient.getCustomization(source, {})
    if custom then
        if player_customs[source] then
            player_customs[source] = nil
            vRPclient._removeDiv(source, "customization")
        else
            local content = ""
            for k, v in pairs(custom) do
                content = content .. k .. " => " .. json.encode(v) .. "<br />"
            end

            player_customs[source] = true
            vRPclient._setDiv(source, "customization",
                ".div_customization{ margin: auto; padding: 8px; width: 500px; margin-top: 80px; background: black; color: white; font-weight: bold; ",
                content)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- BB
-----------------------------------------------------------------------------------------------------------------------------------------
local bbAuthorized = {
    'perm.respilegal',
    'developer.permissao',
    'perm.liderfranca',
    'perm.liderrussia',
    'perm.liderkorea',
    'perm.lidercdd',
    'perm.liderbennys',
    'perm.lidermotoclube',
    'perm.liderlacoste',
    'perm.liderhellsangels',
    'perm.lidergrecia',
    'perm.liderbaixada',
    'perm.lidermedusa',
    'perm.lidercassino',
    'perm.liderlifeinvader',
    'perm.liderlux',
    'perm.lidertequila',
    'perm.lidersete',
    'perm.liderbahamas',
    'perm.liderpcc',
    'perm.lidermilicia',
    'perm.lidercv',
    'perm.lideringlaterra',
    'perm.lideranonymous',
    'perm.lidergrota',
    'perm.lidermedellin',
    'perm.lidercolombia',
    'perm.liderchina',
    'perm.liderisrael',
    'perm.liderelements',
    'perm.liderirlanda',
    'perm.lidersuica',
}

-- RegisterCommand('bb', function(source, args, rawCommand)
--     if args[1] then
--         local user_id = vRP.getUserId(source)
--         local identity = vRP.getUserIdentity(user_id)
--         if user_id then
--             local hasPermission = false

--             for _, perm in ipairs(bbAuthorized) do
--                 if vRP.hasPermission(user_id, perm) then
--                     hasPermission = true
--                     break
--                 end
--             end

--             if not hasPermission then
--                 return
--             end

--             for _, perm in ipairs(bbAuthorized) do 
--                 local players = vRP.getUsersByPermission(perm)
--                 if players then
--                     for l, w in pairs(players) do
--                         local player = vRP.getUserSource(parseInt(w))
--                         local nuser_id = vRP.getUserId(player)
--                         if player then
--                             TriggerClientEvent('chatMessage', player, {
--                                 type = 'default',
--                                 title = identity.nome .. " " .. identity.sobrenome,
--                                 message = rawCommand:sub(3)
--                             })
--                         end
--                     end
--                 end
--             end
--         end
--     end
-- end)
RegisterCommand('bb',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			if vRP.hasPermission(user_id, "diretor.permissao") or vRP.hasPermission(user_id, "perm.respilegal") or vRP.hasGroup(user_id,"TOP1") then
                local isNovato = string.find(vRP.getUserGroupByType(user_id, "org"), "Novato")
                if isNovato == nil then
                    local users = vRP.getUsersByPermission("perm.ilegal")
                    for _, v in pairs(users) do
                        local player = vRP.getUserSource(parseInt(v))
                        if player then
                            TriggerClientEvent('chatMessage', player, {
                                prefix = 'BB',
                                prefixColor = '#6aed24',
                                title = identity.nome.." "..identity.sobrenome,
                                message = rawCommand:sub(3),
                            })
                        end
                    end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tptome', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "streamer.permissao") or vRP.hasPermission(user_id, "perm.cc") or
        vRP.hasPermission(user_id, "paulinho.permissao") or vRP.hasPermission(user_id, "admin.permissao") or
        vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id, "suporte.permissao") then
        if args[1] then
            local tplayer = vRP.getUserSource(parseInt(args[1]))
            local plyCoords = GetEntityCoords(GetPlayerPed(source))
            local x, y, z = plyCoords[1], plyCoords[2], plyCoords[3]

            if tplayer then
                vRPclient._teleport(tplayer, x, y, z)

                vRP.sendLog("https://discord.com/api/webhooks/1304935183983710298/tJ3Dizh7ICiDXYtkekkO3MPVwRViDeMo_m7OgpHJ_Bw-AOImYPt6yY3aUGU75vZfV60Z", "O ID " .. user_id .. " puxou o id " .. parseInt(args[1]))

                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "tptome",
                    user_id = user_id,
                    message = ([[O USUÁRIO %s USOU /TPTOME NO USUÁRIO %s]]):format(user_id, args[1])
                })
            end
        end
    end
end)
RegisterCommand('kitpaulinho', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if (not vRP.hasPermission(user_id, "paulinho.permissao")) then
        return
    end
    vRPclient._giveWeapons(source, {
        ["WEAPON_COMBATPISTOL"] = {
            ammo = 100
        }
    }, true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpto', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "streamer.permissao") or vRP.hasPermission(user_id, "perm.cc") or
        vRP.hasPermission(user_id, "paulinho.permissao") or vRP.hasPermission(user_id, "admin.permissao") or
        vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id, "suporte.permissao") then
        if args[1] then

            local tplayer = vRP.getUserSource(parseInt(args[1]))
            if tplayer then
                vRPclient._teleport(source, vRPclient.getPosition(tplayer))

                vRP.sendLog("https://discord.com/api/webhooks/1304935057252941935/gbcETer_5MoEHJorjoiSfmggmkc7ZLKoqXgSq8rgnSc1x2gZSj9IREa_F9U97XUbBLSi", "O ID " .. user_id .. " teleportou ate o id " .. parseInt(args[1]))

                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "tpto",
                    user_id = user_id,
                    message = ([[USUÁRIO %s USOU O COMANDO /TPTO NO USUÁRIO %s]]):format(user_id, args[1])
                })
            end
        end
    end
end)

RegisterCommand('tpsrc', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "player.wall") or vRP.hasPermission(user_id, "perm.cc") or
        vRP.hasPermission(user_id, "paulinho.permissao") or vRP.hasPermission(user_id, "admin.permissao") or
        vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasGroup(user_id, 'ajudantelotusgroup@445') then
        if args[1] then
            local ped = GetPlayerPed(tonumber(args[1]))
            if ped and ped > 0 then
                local x, y, z = table.unpack(GetEntityCoords(ped))
                vRPclient._teleport(source, x, y, z)
                return
            end
            local tplayer = vRP.getUserId(parseInt(args[1]))
            if tplayer then

                vRPclient._teleport(source, vRPclient.getPosition(parseInt(args[1])))

                vRP.sendLog("", "O ID " .. user_id .. " teleportou ate o id " .. tplayer)

                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "tpto",
                    user_id = user_id,
                    message = ([[O USER_ID %s TELEPORTOU ATE O USER_ID %s]]):format(user_id, tplayer)
                })
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpway', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "paulinho.permissao") or vRP.hasPermission(user_id, "perm.cc") or
        vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasPermission(user_id, "streamer.permissao") then
        TriggerClientEvent('tptoway', source)

        vRP.sendLog("https://discord.com/api/webhooks/1304935238685950023/znuxzpUaod25cdNSLB7fYXQ6NLiPJiMqaR10BEE9RODHfqhrnJ-XyYJgbpe36PoA74HQ", "O ID " .. user_id .. " usou o /tpway")
        exports["vrp_admin"]:generateLog({
            category = "admin",
            room = "tpway",
            user_id = user_id,
            message = ([[O USER_ID %s USOU O TPWAY]]):format(user_id, args[1])
        })
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DELNPCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('car', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "perm.cc") or vRP.hasPermission(user_id, "paulinho.permissao") or
        vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "perm.spawner") then
        if args[1] then
            if (args[1]:lower() == "minitank" or args[1] == "rhino" or args[1] ==
                "oppressor2") then
                return
            end
            TriggerEvent("onSpawnVehicle", {
                src = source,
                name = args[1]
            })
            TriggerClientEvent('spawnarveiculopp', source, args[1])

            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "spawncar",
                user_id = user_id,
                message = ([[O USER_ID %s SPAWNOU O VEICULO %s]]):format(user_id, args[1])
            })
        end
    end
end)

function src.getPlate(toogle)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "perm.cc") or vRP.hasPermission(user_id, "paulinho.permissao") or
        vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "perm.spawner") or
        vRP.hasPermission(user_id, "streamer.permissao") then
        return true
    else
        vRP.setBanned(user_id, true)
        DropPlayer(source, "hj n")
        return false
    end
end

local festaIds = {
    [829] = true,
    [616] = true,
    [613] = true,
    [1011] = true,
    [1472] = true,
    [1472] = true,
    [1246] = true,
    [1029] = true,
    [50] = true,
    [65] = true,
    [2315] = true,
}

local festaRunning = {
    running = false,
    hasTeleport = false,
    coords = {}
}

RegisterCommand('iniciarfesta', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "respeventos.permissao") or vRP.hasGroup(user_id, "auxiliareventos") or
        festaIds[user_id] or vRP.hasGroup(user_id, 'respilegallotusgroup@445') then
        local title = vRP.prompt(source, 'Titulo da festa:', '')
        if not title or title == '' then
            return
        end

        local mensagem = vRP.prompt(source, "Mensagem do Festa:", "")
        if mensagem == "" then
            return
        end

        local time = vRP.prompt(source, "Tempo para poder entrar na festa:", "")
        if not time or time == '' then
            return false
        end

        local fcoords = vRP.prompt(source, "Coordenada do Festa:", "")
        if fcoords then
            if fcoords == "" then
                return
            end

            if mensagem and fcoords then
                local coords = {}
                for coord in string.gmatch(fcoords or "0,0,0", "[^,]+") do
                    table.insert(coords, parseInt(coord))
                end

                local activateTeleport = vRP.prompt(source, "Ativar Teleporte? ( Use somente [s] para sim ou [n] não! Obs: Não use [])", "s")

                if activateTeleport == "" then
                    return TriggerClientEvent("Notify", source, 'Necessário inserir uma resposta!', 5000)
                end

                local authorizedTeleport = activateTeleport:lower() == "s" and true or false

                festaRunning.running = true
                festaRunning.coords = coords
                festaRunning.hasTeleport = authorizedTeleport
                
                local stringSend = mensagem .. (authorizedTeleport and "<br>Use /festa (para entrar na festa)" or "").." <br><br>Enviado pela Prefeitura"

                TriggerClientEvent('Announcement', -1, 'party',stringSend ,
                    tonumber(time) or 15, title)
                vCLIENT._requestfesta(-1, coords, tonumber(time) or 15000)

                CreateThread(function()
                    SetTimeout(tonumber(time) and (time * 1000) or 15000, function()
                        print('FESTA FINALIZADA...')
                        festaRunning.running = false
                        festaRunning.hasTeleport = false
                        festaRunning.coords = {}
                        TriggerClientEvent('Notify', -1, 'sucesso', 'Festa encerrada', 15000)
                    end)
                end)

                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "festa",
                    user_id = user_id,
                    message = ([[O USER_ID %s CRIOU UM FESTA COM %s VAGAS NO LOCAL %s]]):format(user_id, vagas,
                        fcoords)
                })

                local contentLog = [[
                    ```prolog
                        [AUTHOR]: %s,
                        [COORDENADAS]: %s,%s,%s
                        [AUTORIZADO TELEPORTE]: %s
                        [MENSAGEM]: %s
                    ```
                ]]

                local formatLog = contentLog:format(user_id, tostring(coords[1]), tostring(coords[2]), tostring(coords[3]), (authorizedTeleport and "SIM" or "NÃO"), mensagem)

                print('FORMATLOG IS: ', formatLog)

                vRP.sendLog("https://discord.com/api/webhooks/1332068710390956084/ajN-FLefOgnZ3LZP7OKtJhtJ8i5Rmbi4IRiPhFM8Wz98k5FWbLXZBayY6hLGxgNT_1G6",formatLog)
            end
        end
    end
end)

RegisterCommand('festa', function(source)
    if not festaRunning.running then TriggerClientEvent('Notify', source, 'negado', 'Não há festa disponível no momento.', 6000) return end


    if GetEntityHealth(GetPlayerPed(source)) <= 101 then
        return TriggerClientEvent('Notify', source, 'negado', 'Você não pode participar do evento se estiver morto.', 6000)
    end

    if vCLIENT.inDomination(source) then
        return TriggerClientEvent('Notify', source, 'negado', 'Você não pode participar do evento se estiver em uma dominacao.', 6000)
    end

    if not festaRunning.hasTeleport then return TriggerClientEvent('Notify', source, 'negado', 'Esta festa não autorizou você ser teletransportado.', 6000) end

    local coords = festaRunning.coords

    vRPclient.teleport(source, coords[1], coords[2], coords[3])

    TriggerClientEvent('Notify', source, 'sucesso', 'Você foi teletransportado para a festa!!')
end)

exports('spreadst:status', function()
    return {
        players = GetNumPlayerIndices(),
        ilegal = #vRP.getUsersByPermission('perm.ilegal')
    }
end)

RegisterCommand('evento2', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)

    local perms = {{
        permType = 'perm',
        perm = 'developer.permissao'
    }, {
        permType = 'group',
        perm = 'respilegallotusgroup@445'
    }, {
        permType = 'group',
        perm = 'respstreamerlotusgroup@445'
    }}

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

    local plyCoords = GetEntityCoords(GetPlayerPed(source))
    local x, y, z = plyCoords[1], plyCoords[2], plyCoords[3]
    local vagas = 0
    local fcoords = vRP.prompt(source, "Coordenada do evento:", "")
    if fcoords then
        if fcoords == "" then
            return
        end
        local totalVagas = vRP.prompt(source, "Número total de vagas:", "")
        if totalVagas == "" then
            return
        end
        if totalVagas then
            local coords = {}
            for coord in string.gmatch(fcoords or "0,0,0", "[^,]+") do
                table.insert(coords, parseInt(coord))
            end
            local users = vRP.getUsers()
            for k, v in pairs(users) do
                async(function()
                    local player = vRP.getUserSource(k)
                    if player then
                        vRPclient._playSound(player, "Event_Message_Purple", "GTAO_FM_Events_Soundset")
                        if vRP.request(player, "Você deseja entrar no evento?", 30) then
                            local nuser_id = vRP.getUserId(player)
                            if GetEntityHealth(GetPlayerPed(player)) <= 101 then
                                return
                            end
                            if vRPclient.isHandcuffed(player) then
                                return
                            end
                            if player then
                                vagas = vagas + 1
                                if vagas <= tonumber(totalVagas) then
                                    vRPclient._teleport(player, coords[1] or 0, coords[2] or 0, coords[3] or 0)
                                    TriggerClientEvent("Notify", player, "sucesso", "Você está no evento!", 5)
                                else
                                    TriggerClientEvent("Notify", player, "negado",
                                        "Evento já está em seu número máximo de vagas!", 5)
                                end
                            end
                        end
                    end
                end)
            end

            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "evento",
                user_id = user_id,
                message = ([[O USER_ID %s CRIOU UM EVENTO COM %s VAGAS NO LOCAL %s]]):format(user_id, vagas,
                    fcoords)
            })

            vRP.sendLog("https://discord.com/api/webhooks/1302689612325716080/Qmoeo69CpeLUlaCflZVxd61T3WKBYOCR0gpmqnnVWPiIIO9X7je36G8pIO1_C7K7xN_o", "O ADMIN " .. user_id .. " criou um evento com " .. vagas .. " vagas no local " .. fcoords)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Copy Face
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('copyface', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasGroup(user_id, 'TOP1') or vRP.hasPermission(user_id, 'developer.permissao') then
            if args[1] then
                local nsource = vRP.getUserSource(tonumber(args[1]))
                if nsource then
                    local data = vRP.getUserApparence(tonumber(args[1]))
                    if data.rosto then
                        bCLIENT._setCharacter(source, data.rosto)
                        TriggerClientEvent('Notify', source, 'sucesso', 'Rosto copiado do ID ' .. args[1])
                        TriggerClientEvent('barbershop:setCustom', nsource, data.rosto)
                    end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Copy Preset
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('copypreset', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    local perms = {
        { permType = 'perm', perm = 'developer.permissao' },
        { permType = 'group', perm = 'respilegallotusgroup@445' },
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

    if tonumber(args[1]) then
        local nsource = vRP.getUserSource(tonumber(args[1]))
        if nsource then
            local custom = vRPclient.getCustomization(source, {})
            local ncustom = vRPclient.getCustomization(nsource, {})
            if ncustom.pedModel == custom.pedModel then
                TriggerClientEvent('setCustom', source, ncustom)
            else
                vRPclient._setCustomization(source, ncustom)
            end

            vRP.sendLog('', 'O ADMIN '..user_id..' COPIOU A CUSTOMIZACAO DO ID '..args[1])

            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "copypreset",
                user_id = user_id,
                message = ([[O USER_ID %s COPIOU A CUSTOMIZACAO DO ID %s]]):format(user_id, args[1])
            })
        else
            TriggerClientEvent("Notify", source, "negado", "Este ID não se encontra online no momento.", 5000)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Set Preset
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('setpreset', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    local perms = {
        { permType = 'perm', perm = 'developer.permissao' },
        { permType = 'group', perm = 'respilegallotusgroup@445' },
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

    if tonumber(args[1]) then
        local nsource = vRP.getUserSource(tonumber(args[1]))
        if nsource then
            local custom = vRPclient.getCustomization(source, {})
            vRPclient._setCustomization(nsource, custom)

            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "setpreset",
                user_id = user_id,
                message = ([[O USER_ID %s COPIOU A CUSTOMIZACAO DO ID %s]]):format(user_id, args[1])
            })

            vRP.sendLog('', 'O ADMIN '..user_id..' COPIOU A CUSTOMIZACAO DO ID '..args[1])
        else
            TriggerClientEvent("Notify", source, "negado", "Este ID não se encontra online no momento.", 5000)
        end
    end
end)

RegisterCommand('setpresetarea',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)

    local hasPermission = false
    local perms = {
        {permType = 'perm', perm = 'developer.permissao'},
        {permType = 'group', perm = 'perm.respilegal'},
        {permType = 'group', perm = 'perm.respstaff'},
        {permType = 'group', perm = 'respstafflotusgroup@445'},
        {permType = 'group', perm = 'resppolicialotusgroup@445'},
        {permType = 'group', perm = 'respeventoslotusgroup@445'},
        {permType = 'group', perm = 'respilegallotusgroup@445'},
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

	if tonumber(args[1]) then
        local area = tonumber(args[1])

        local nplayers = vRPclient.getNearestPlayers(source, area)
        local custom = vRPclient.getCustomization(source, {})
        for k, v in pairs(nplayers) do
            async(function()
                local nuserId = vRP.getUserId(k)
                local nsource = vRP.getUserSource(parseInt(nuserId))
                vRPclient._setCustomization(nsource, custom)

                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "setpreset",
                    user_id = user_id,
                    message = ( [[O USER_ID %s COPIOU A CUSTOMIZACAO DO ID %s]] ):format(user_id, nuserId)
                })

                vRP.sendLog('', "O ID "..user_id.." setou a customização do id "..tonumber(nuserId))
            end)
        end
    end
end)

RegisterCommand('setroupasarea',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)

    local hasPermission = false
    local perms = {
        {permType = 'perm', perm = 'developer.permissao'},
        {permType = 'group', perm = 'perm.respilegal'},
        {permType = 'group', perm = 'perm.respstaff'},
        {permType = 'group', perm = 'respstafflotusgroup@445'},
        {permType = 'group', perm = 'resppolicialotusgroup@445'},
        {permType = 'group', perm = 'respeventoslotusgroup@445'},
        {permType = 'group', perm = 'respilegallotusgroup@445'},
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

    local function parseRoupas(input)
        local mapping = {
            jaqueta = 11,
            calca = 4,
            blusa = 8,
            sapatos = 6,
            oculos = "p0",
            acessorios = 7,
            chapeu = "p1",
            colete = 9,
            mascara = 1,
            maos = 3
        }

        local roupas = {
            pedModel = GetEntityModel(GetPlayerPed(source))
        }

        for item in string.gmatch(input, "[^;]+") do
            local name, drawable, texture = string.match(item, "(%w+)%s+(%-?%d+)%s+(%-?%d+)")
            if name and mapping[name] then
                local index = mapping[name]
                drawable, texture = tonumber(drawable), tonumber(texture)
                if type(index) == "string" then
                    roupas[index] = {drawable, texture}
                else
                    roupas[index] = {drawable, texture}
                end
            end
        end

        return roupas
    end


	if tonumber(args[1]) then
        local area = tonumber(args[1])

        local nplayers = vRPclient.getNearestPlayers(source, area)

        if not nplayers or not next(nplayers) then
            return TriggerClientEvent('Notify', source, 'negado', 'Nenhum jogador próximo.', 5000)
        end

        local malePreset = vRP.prompt(source, 'Insira o preset masculino.', "")

        if not malePreset or malePreset == "" then
            return TriggerClientEvent('Notify', source, 'Insira o preset masculino.', 5000)
        end

        local femalePreset = vRP.prompt(source, 'Insira o preset feminino.', "")

        if not femalePreset or femalePreset == "" then
            return TriggerClientEvent('Notify', source, 'Insira o preset feminino.', 5000)
        end

        local presetsNotFormated = {
            ['male'] = parseRoupas(malePreset),
            ['female'] =  parseRoupas(femalePreset)
        }

        for k, v in pairs(nplayers) do
            async(function()
                local nuserId = vRP.getUserId(k)
                local nsource = vRP.getUserSource(parseInt(nuserId))

                local gender = vCLIENT.getGenderPerson(nsource)
                if not gender then goto continue end

                if presetsNotFormated[gender] then
                    local tempPreset = presetsNotFormated[gender]
                    tempPreset.pedModel = GetEntityModel(GetPlayerPed(nsource))
                    TriggerClientEvent('setCustom', nsource, tempPreset)
                end

                ::continue::
            end)
        end
    end
end)

RegisterCommand("deleteall", function(source, args, rawCmd)
    local userId = vRP.getUserId(source)
    if not vRP.hasPermission(userId, "admin.permissao") then
        return
    end

    if not args[1] then
        return
    end

    if args[1] == "objects" then
        for _i, item in pairs(GetAllObjects()) do
            DeleteEntity(item)
        end
        TriggerClientEvent("Notify", source, "sucesso", "Todos os objetos foram deletados com sucesso.")
    elseif args[1] == "npcs" then
        for _, pedHandle in pairs(GetAllPeds()) do
            DeleteEntity(pedHandle)
        end
        TriggerClientEvent("Notify", source, "sucesso", "Todos os npcs foram deletados com sucesso.")
    elseif args[1] == "vehicles" then
        for i, vehicle in pairs(GetAllVehicles()) do
            DeleteEntity(vehicle)
        end
        TriggerClientEvent("Notify", source, "sucesso", "Todos os veiculos foram deletados com sucesso.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELNPCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('delnpcs', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") then
        TriggerClientEvent('delnpcs', source)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADM
-----------------------------------------------------------------------------------------------------------------------------------------
local avisopmCooldown = {}
RegisterCommand('avisopm', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "perm.avisopm") or
        (vRP.hasGroup(user_id, "developerlotusgroup@445") or vRP.hasGroup(user_id, "TOP1")) then

        local status, time = exports['vrp']:getCooldown(user_id, "avisopm")
        if status then
            exports['vrp']:setCooldown(user_id, "avisopm", 300)

            local org = vRP.getUserGroupOrg(user_id)
            if avisopmCooldown[org] and avisopmCooldown[org] > os.time() then
                return false, TriggerClientEvent("Notify", source, "negado", "Você ainda não pode enviar um aviso PM.", 5)
            end

            avisopmCooldown[org] = os.time() + 60 * 60

            local mensagem = vRP.prompt(source, "Mensagem:", "")
            if mensagem == "" then
                return
            end

            if mensagem then
                if #mensagem > 140 then
                    return false, TriggerClientEvent("Notify", source, "negado", "Limite de caracteres atingido.", 5)
                end

                TriggerClientEvent('Announcement', -1, 'police',
                    mensagem .. " Enviado: " .. identity.nome .. ' ' .. identity.sobrenome, 60)

                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "avisopm",
                    user_id = user_id,
                    message = ([[O USER_ID %s ANUNCIOU %s]]):format(user_id, mensagem)
                })

                vRP.sendLog('', mensagem)
            end
        end
    end
end)

RegisterCommand('avisocreche', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "perm.liderkids") or
        (vRP.hasGroup(user_id, "developerlotusgroup@445") or vRP.hasGroup(user_id, "TOP1")) then

        local status, time = exports['vrp']:getCooldown(user_id, "avisocreche")
        if status then

            local mensagem = vRP.prompt(source, "Mensagem:", "")
            if mensagem == "" then
                return
            end

            if mensagem then
                if #mensagem > 140 then
                    return false, TriggerClientEvent("Notify", source, "negado", "Limite de caracteres atingido.", 5)
                end

                TriggerClientEvent('Notify', -1, 'avisocreche', mensagem, 90)
                exports['vrp']:setCooldown(user_id, "avisocreche", 60)

                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "avisocreche",
                    user_id = user_id,
                    message = ([[O USER_ID %s ANUNCIOU %s]]):format(user_id, mensagem)
                })
            end
        end
    end
end)

RegisterCommand('aviso69', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "perm.maisonette") or
        (vRP.hasGroup(user_id, "developerlotusgroup@445") or vRP.hasGroup(user_id, "TOP1")) then

        local status, time = exports['vrp']:getCooldown(user_id, "aviso69")
        if status then
            exports['vrp']:setCooldown(user_id, "aviso69", 300)

            local mensagem = vRP.prompt(source, "Mensagem:", "")
            if mensagem == "" then
                return
            end

            if mensagem then
                if #mensagem > 140 then
                    return false, TriggerClientEvent("Notify", source, "negado", "Limite de caracteres atingido.", 5)
                end

                TriggerClientEvent('Notify', -1, 'avisoadv',
                    mensagem .. " Enviado: " .. identity.nome .. ' ' .. identity.sobrenome, 60)

                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "aviso69",
                    user_id = user_id,
                    message = ([[O USER_ID %s ANUNCIOU %s]]):format(user_id, mensagem)
                })
            end
        end
    end
end)

RegisterCommand('avisobombeiro', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "perm.avisobombeiro") or vRP.hasPermission(user_id, "perm.avisobombeirocivil") or vRP.hasPermission(user_id, 'developer.permissao') or
        (vRP.hasGroup(user_id, "developerlotusgroup@445") or vRP.hasGroup(user_id, "TOP1")) then

        local status, time = exports['vrp']:getCooldown(user_id, "avisobombeiro")
        if status then
            exports['vrp']:setCooldown(user_id, "avisobombeiro", 300)

            local mensagem = vRP.prompt(source, "Mensagem:", "")
            if mensagem == "" or not mensagem then
                return
            end

            if #mensagem > 140 then
                return false, TriggerClientEvent("Notify", source, "negado", "Limite de caracteres atingido.", 5)
            end

            TriggerClientEvent('Announcement', -1, 'fireman',
                    mensagem .. " Enviado: " .. identity.nome .. ' ' .. identity.sobrenome, 60)
            -- TriggerClientEvent('Notify', -1, 'avisobombeiro',
            --     mensagem .. " Enviado: " .. identity.nome .. ' ' .. identity.sobrenome, 60)

            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "avisobombeiro",
                user_id = user_id,
                message = ([[O USER_ID %s ANUNCIOU %s]]):format(user_id, mensagem)
            })
        end
    end
end)

RegisterCommand('avisobombeiro2', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "perm.avisobombeiro") or vRP.hasPermission(user_id, "perm.avisobombeirocivil") or vRP.hasPermission(user_id, 'developer.permissao') or
        (vRP.hasGroup(user_id, "developerlotusgroup@445") or vRP.hasGroup(user_id, "TOP1")) then

        local status, time = exports['vrp']:getCooldown(user_id, "avisobombeiro")
        if status then
            exports['vrp']:setCooldown(user_id, "avisobombeiro", 300)

            local mensagem = vRP.prompt(source, "Mensagem:", "")
            if mensagem == "" or not mensagem then
                return
            end

            if #mensagem > 140 then
                return false, TriggerClientEvent("Notify", source, "negado", "Limite de caracteres atingido.", 5)
            end
            TriggerClientEvent('Notify', -1, 'avisobombeiro',
                mensagem .. " Enviado: " .. identity.nome .. ' ' .. identity.sobrenome, 60)

            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "avisobombeiro",
                user_id = user_id,
                message = ([[O USER_ID %s ANUNCIOU %s]]):format(user_id, mensagem)
            })
        end
    end
end)

-- RegisterCommand('avisooab',function(source,args,rawCommand)
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	if not user_id then return end 

-- 	local identity = vRP.getUserIdentity(user_id)
-- 	if vRP.hasPermission(user_id,"perm.judiciario") or vRP.hasPermission(user_id,'developer.permissao') or (vRP.hasGroup(user_id,"developerlotusgroup@445") or vRP.hasGroup(user_id,"TOP1")) then
-- 		local mensagem = vRP.prompt(source,"Mensagem:","")
-- 		if mensagem == "" or not mensagem then
-- 			return
-- 		end

-- 		TriggerClientEvent('Notify', -1,'avisooab', mensagem.. " <br><br>Enviado: "..identity.nome..' '..identity.sobrenome, 60)

-- 		vRP.sendLog("AADM", "O JUDICIARIO "..user_id.." ANUNCIOU "..mensagem)

-- 		exports["vrp_admin"]:generateLog({
-- 			category = "admin",
-- 		   room = "judiciario",
-- 		   user_id = user_id,
-- 		   message = ( [[O USER_ID %s ANUNCIOU %s]] ):format(user_id, mensagem)
-- 	   	})
-- 	end
-- end)

RegisterCommand('avisocb', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "perm.avisobombeiro") or
        (vRP.hasGroup(user_id, "developerlotusgroup@445") or vRP.hasGroup(user_id, "TOP1")) then

        local status, time = exports['vrp']:getCooldown(user_id, "avisocb")
        if status then
            exports['vrp']:setCooldown(user_id, "avisocb", 300)

            local mensagem = vRP.prompt(source, "Mensagem:", "")
            if mensagem == "" then
                return
            end

            if mensagem then
                TriggerClientEvent('Announcement', -1, 'fireman',
                    mensagem .. " Enviado: " .. identity.nome .. ' ' .. identity.sobrenome, 60)

                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "avisocb",
                    user_id = user_id,
                    message = ([[O USER_ID %s ANUNCIOU %s]]):format(user_id, mensagem)
                })
            end
        end
    end
end)

vRP.prepare("vRP/get_instagram_id", "SELECT user_id FROM smartphone_instagram WHERE username = @username")
function getInstagramId(username)
    local result = vRP.query("vRP/get_instagram_id", {
        username = username
    })
    if #result > 0 then
        return result[1].user_id
    end
    return nil
end

RegisterCommand("instagram", function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "admin.permissao") then
            if args[1] then
                local username = args[1]
                local id_username = getInstagramId(username)

                if id_username then
                    local message = "Aqui está o ID do username: " .. tostring(id_username)
                    local id_username_prompt = vRP.prompt(source, "PASSAPORTE DO USERNAME PROCURADO", message)
                else
                    TriggerClientEvent("Notify", source, "negado", "Username não encontrado.", 5)
                end
            else
                TriggerClientEvent("Notify", source, "negado",
                    "Digite o nome de usuário do Instagram: /instagram (username).", 5)
            end
        end
    end
end)

RegisterCommand('avisohp', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "perm.avisohp") or
        (vRP.hasGroup(user_id, "developerlotusgroup@445") or vRP.hasGroup(user_id, "TOP1")) then

        local status, time = exports['vrp']:getCooldown(user_id, "avisohp")
        if status then
            exports['vrp']:setCooldown(user_id, "avisohp", 300)

            local mensagem = vRP.prompt(source, "Mensagem:", "")
            if mensagem == "" then
                return
            end

            if mensagem then
                if #mensagem > 140 then
                    return false, TriggerClientEvent("Notify", source, "negado", "Limite de caracteres atingido.", 5)
                end

                TriggerClientEvent('Announcement', -1, 'hospital',
                    mensagem .. " Enviado: " .. identity.nome .. ' ' .. identity.sobrenome, 60)

                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "avisohp",
                    user_id = user_id,
                    message = ([[O USER_ID %s ANUNCIOU %s]]):format(user_id, mensagem)
                })
            end
        end
    end
end)

RegisterCommand('avisomec', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "perm.avisomc") or
        (vRP.hasGroup(user_id, "developerlotusgroup@445") or vRP.hasGroup(user_id, "TOP1")) then
        local status, time = exports['vrp']:getCooldown(5, "avisomec")
        if status then
            exports['vrp']:setCooldown(5, "avisomec", 300)

            local mensagem = vRP.prompt(source, "Mensagem:", "")
            if mensagem == "" then
                return
            end

            if mensagem then
                if #mensagem > 300 then
                    return false, TriggerClientEvent("Notify", source, "negado", "Limite de caracteres atingido.", 5)
                end

                TriggerClientEvent('Announcement', -1, 'mechanic',
                    mensagem .. " Enviado: " .. identity.nome .. ' ' .. identity.sobrenome, 60)

                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "avisomc",
                    user_id = user_id,
                    message = ([[O USER_ID %s ANUNCIOU %s]]):format(user_id, mensagem)
                })
            end
        end
    end
end)

-- Citizen.CreateThread(function()
-- 	while true do 
-- 		TriggerClientEvent('Notify', -1,'aviso', "<b>Lotus Group & 1WIN</b><br><br>Estamos dando um Skyline R34 para todos os players que se cadastrarem e depositarem no mínimo 15 reais na 1WIN utilizando nosso código/link, NÃO PERCA ESSA CHANCE! Vá até nosso discord e entre na na aba 1WIN para mais informações!", 60)
-- 		Wait(14 * 60 * 1000)
-- 	end
-- end)

RegisterCommand('avisovip', function(source)
    local source = source
    if not source then
        return
    end

    local id = vRP.getUserId(source)
    if not id then
        return
    end

    if not vRP.hasPermission(id, 'developer.permissao') and user_id ~= 6 then
        return
    end

    local title = vRP.prompt(source, 'Titulo da mensagem:', 'JUDICIÁRIO')
    if not title or title == '' then
        return
    end

    local message = vRP.prompt(source, 'Mensagem:', '')
    if not message or message == '' then
        return
    end

    local time = vRP.prompt(source, 'Duração:', '60')
    if not time or time == '' then
        return
    end
    TriggerClientEvent('Announcement', -1, 'vip', message, tonumber(time) or 60, title)
end)

CreateThread(function()
    while true do
        Wait(15 * 60 * 1000)
        TriggerClientEvent('Announcement', -1, 'vip', 'QUER TER BENEFÍCIOS VIPS E EXCLUSIVOS DENTRO DO SERVIDOR? DIGITE /LOJA E ACESSE JÁ!', 60, 'ACESSE NOSSA LOJA')
    end
end)

RegisterCommand('avisoadm', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "admin.permissao") then
        local mensagem = vRP.prompt(source, "Mensagem:", "")
        if mensagem == "" then
            return
        end

        if mensagem then
            TriggerClientEvent('Notify', -1, 'aviso', mensagem .. " Enviado pela Prefeitura", 60)

            vRP.sendLog(
                "https://discord.com/api/webhooks/1304933500809384037/ZiVbHiORSdZhy3RLrVScAN26HLo9APJ3jleeTAwH1CvSTKW6H6ooeNk2xoAwRtLnSsct",
                "O ADMIN " .. user_id .. " ANUNCIOU " .. mensagem)

            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "aadm",
                user_id = user_id,
                message = ([[O USER_ID %s ANUNCIOU %s]]):format(user_id, mensagem)
            })
        end
    end
end)

RegisterCommand('avisoadv', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "perm.liderjudiciario") then
        local mensagem = vRP.prompt(source, "Mensagem:", "")
        if mensagem == "" then
            return
        end

        if mensagem then
            if #mensagem > 140 then
                return false, TriggerClientEvent("Notify", source, "negado", "Limite de caracteres atingido.", 5)
            end

            TriggerClientEvent('Announcement', -1, 'juridico', mensagem, 60, "JURIDICO")



            vRP.sendLog("AADM", "O JUDICIARIO " .. user_id .. " ANUNCIOU " .. mensagem)

            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "judiciario",
                user_id = user_id,
                message = ([[O USER_ID %s ANUNCIOU %s]]):format(user_id, mensagem)
            })
        end
    end
end)

RegisterCommand('avisostaff', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)

    if not vRP.hasPermission(user_id, 'developer.permissao') then return end

	local message = vRP.prompt(source, 'Mensagem:', '')
	if not message or message == '' then return end

	local duration = vRP.prompt(source, 'Duração (em segundos):', '60')
	if not duration or duration == '' then return end

	local identity = vRP.getUserIdentity(user_id)
	local name = ('%s %s'):format(identity.nome, identity.sobrenome)

	-- for i = 1, #users do
	-- 	local user_source = vRP.getUserSource(users[i])
	-- 	if user_source then 
	-- 		TriggerClientEvent('Notify', user_source, 'avisostaff', message .. '<br><br><small>Enviado por: '.. name ..'</small>', tonumber(duration), '')
	-- 		TriggerClientEvent('vrp_sound:source', user_source, 'apitoverao', 0.2)
	-- 	end
	-- end
    local players = vRP.getUsersByPermission("player.noclip")
    if players then
        for l, w in pairs(players) do
            local player = vRP.getUserSource(parseInt(w))
            if player then
                TriggerClientEvent('Notify', player, 'avisostaff', message .. '<br><br><small>Enviado por: '.. name ..'</small>', tonumber(duration), '')
                TriggerClientEvent('vrp_sound:source', player, 'apito', 0.2)
            end
        end
    end
end)

RegisterCommand('avisoadm2', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "developer.permissao") then
        local mensagem = vRP.prompt(source, "Mensagem:", "")
        if mensagem == "" then
            return
        end

        if mensagem then
            TriggerClientEvent('Notify', -1, 'aviso',
                mensagem .. " Enviado: " .. identity.nome .. " " .. identity.sobrenome .. "", 60)

            vRP.sendLog("AADM", "O ADMIN " .. user_id .. " ANUNCIOU " .. mensagem)

            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "avisoadm2",
                user_id = user_id,
                message = ([[O USER_ID %s ANUNCIOU %s]]):format(user_id, mensagem)
            })
        end
    end
end)

RegisterCommand('avisoadm3', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id, "developer.permissao") then
        return
    end

    local identity = vRP.getUserIdentity(user_id)

    local title = vRP.prompt(source, "Titulo: ", "AVISO")
    if title == "" then
        return
    end
    local mensagem = vRP.prompt(source, "Mensagem: ", "")
    if mensagem == "" then
        return
    end
    local time = vRP.prompt(source, "Duração(em segundos): ", "60")
    if time == "" then
        return
    end

    if mensagem then
        TriggerClientEvent('Notify', -1, 'avisoadm',
            mensagem .. " <br><br>Enviado: " .. identity.nome .. ' ' .. identity.sobrenome, tonumber(time))

        vRP.sendLog("AADM", "O usuário: " .. user_id .. " ANUNCIOU " .. mensagem)

        exports["vrp_admin"]:generateLog({
            category = "admin",
            room = "aadm",
            user_id = user_id,
            message = ([[O USER_ID %s ANUNCIOU %s]]):format(user_id, mensagem)
        })
    end
end)

RegisterCommand("ar", function(source, args, rawCommand)
    if source == 0 then
        GlobalState.ServerRestart = true
        vRPclient._setDiv(-1, "anuncio",
            ".div_anuncio { background: rgba(255,50,50,0.8); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 40%; right: 5%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; word-wrap: break-word; } bold { font-size: 16px; }",
            "<bold>" .. rawCommand:sub(3) .. "</bold><br><br>Mensagem enviada por: Administrador")
        SetTimeout(60 * 1000, function()
            vRPclient._removeDiv(-1, "anuncio")
        end)
    end
end)

CreateThread(function()
    exports.vrp:removeIdentifier("steam:11000015b5496f5", 2)
    exports.vrp:removeIdentifier("steam:11000010dbef92b", 1)

    exports.vrp:removeIdentifier('license:d4899f3817fdddc3db3f07f88374231da1bc0964', 1)
    exports.vrp:removeIdentifier('license2:d4899f3817fdddc3db3f07f88374231da1bc0964', 1)
    exports.vrp:removeIdentifier('license:38b8981817e2b20b8fb376b66dead6b36d927a9f', 2)
    exports.vrp:removeIdentifier('license2:38b8981817e2b20b8fb376b66dead6b36d927a9f', 2)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSULTAR ID
----------------------------------------------------------------------------------------------------------------------------------------
local permitido = {}

vRP.prepare("vRP/getPropUserID2", "SELECT * FROM mirtin_users_homes WHERE proprietario = @proprietario")

RegisterCommand('consultar', function(source, args)
    if source == 0 then
        permitido[source] = true
    else
        if vRP.hasPermission(vRP.getUserId(source), "admin.permissao") then
            permitido[source] = true
        end
    end

    if permitido[source] then
        local mensagem = ""
        if tonumber(args[1]) then
            local idPlayer = tonumber(args[1])
            local identity = vRP.getUserIdentity(idPlayer)

            if identity then

                mensagem =
                    mensagem .. "\n**Conta: **\n```cs\nID: " .. identity.user_id .. "\nNome: " .. identity.nome .. " " ..
                        identity.sobrenome .. " " .. identity.idade .. "\nRegistro: " .. identity.registro ..
                        "\nTelefone: " .. identity.telefone .. "```"

                local infoUser = vRP.query("vRP/get_all_users", {
                    id = idPlayer
                })
                if infoUser[1] then
                    local ultimologin = infoUser[1].ultimo_login
                    local ip = infoUser[1].ip
                    local whitelist = infoUser[1].whitelist
                    local banido = infoUser[1].banido
                    local motivobanido = infoUser[1].Motivo_BAN

                    if banido then
                        banido = "Sim [" .. motivobanido .. "]"
                    else
                        banido = "Não"
                    end

                    if whitelist then
                        whitelist = "Sim"
                    else
                        whitelist = "Não"
                    end

                    mensagem = mensagem .. "\n**Info-Conta**```cs\nUltimo Login: " .. ultimologin .. "\nIP: " .. ip ..
                                   "\nWhitelist: " .. whitelist .. "\nBanido: " .. banido .. " ```"
                end

                local licenses = vRP.query("vRP/get_all_licenses", {
                    user_id = idPlayer
                }) or nil
                if #licenses > 0 then
                    local msgLicences = ""
                    mensagem = mensagem .. "\n**Licenças:**\n"
                    for k, v in pairs(licenses) do
                        msgLicences = msgLicences .. "" .. v.identifier .. "\n"
                    end

                    mensagem = mensagem .. "```cs\n" .. msgLicences .. "```"
                end

                if identity then
                    local banco = identity.banco
                    local total = identity.banco
                    mensagem = mensagem .. "\n **Dinheiro** ```cs\nCarteira: EM BREVE\nBanco: " .. vRP.format(banco) ..
                                   "\nTotal: " .. vRP.format(total) .. "   ```"
                end

                local table = vRP.getUData(idPlayer, "vRP:datatable")
                local userTable = json.decode(table) or nil
                if userTable then
                    mensagem = mensagem .. "\n**Pessoais**```cs\nVida: " .. userTable.health .. "\nColete: " ..
                                   userTable.colete .. "\nFome: " .. parseInt(userTable.hunger) .. " %\nSede: " ..
                                   parseInt(userTable.thirst) .. " % \nArmas Equipadas: " ..
                                   json.encode(userTable.weapons) .. "\nInventario: " ..
                                   json.encode(userTable.inventory) .. "\nGrupos: " .. json.encode(userTable.groups) ..
                                   "\nPosição: " .. tD(userTable.position.x) .. "," .. tD(userTable.position.y) .. "," ..
                                   tD(userTable.position.z) .. "  ```"
                end

                mensagem = mensagem .. "\n**Veiculos**"
                local veh = vRP.query("vRP/get_Veiculos", {
                    user_id = idPlayer
                }) or nil
                if #veh > 0 then
                    for k, v in pairs(veh) do
                        mensagem = mensagem .. "```cs\nNome: " .. string.upper(v.veiculo) .. " • Porta Malas: " ..
                                       v.portamalas .. " ```"
                    end
                else
                    mensagem = mensagem .. "```cs\nNão possui veiculos```"
                end

                mensagem = mensagem .. "\n**Propriedades**"
                local propriedades = vRP.query("vRP/getPropUserID2", {
                    proprietario = idPlayer
                })
                if #propriedades > 0 then
                    for k, v in pairs(propriedades) do
                        mensagem = mensagem .. "```cs\nID: " .. v.houseID .. " • Bau: " .. v.bau .. "```"
                    end
                else
                    mensagem = mensagem .. "```cs\nNão possui propriedades```"
                end

                sendToDiscord("https://discord.com/api/webhooks/1301971543756378114/fPdl2JzQSSI1mWZLhxw0KMsduCnMkmxorRcu0Y0LruZ7xPgnEVyoszidlknsqAzWAK5U", 6356736, "Sistema de Consultas", mensagem, "© IGUAÇU RJ")
            end
        end

        permitido[source] = nil
    end
end)

function sendToDiscord(weebhook, color, name, message, footer)
    local embed = {{
        ["color"] = color,
        ["title"] = "**" .. name .. "**",
        ["description"] = message,
        ["footer"] = {
            ["text"] = footer
        }
    }}
    PerformHttpRequest(weebhook, function(err, text, headers)
    end, 'POST', json.encode({
        username = name,
        embeds = embed
    }), {
        ['Content-Type'] = 'application/json'
    })
end

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end

----------------------------------------------------------------------------------------------------------------------------------------
-- KICKAR QUEM ENTRA SEM ID
----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("checkbugados", function(source)
    local source = source;
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.permissao') then
        local message = ""
        for _, v in ipairs(GetPlayers()) do
            local pName = GetPlayerName(v)
            local uId = vRP.getUserId(tonumber(v))
            if not uId then
                message = message ..
                              string.format("</br> <b>%s</b> | Source: <b>%s</b> | Ready: %s", pName, v,
                        ((Player(v).state.ready) and 'Sim' or 'Não'))
            end
        end
        TriggerClientEvent("Notify", source, "sucesso",
            ((message ~= "") and message or "Sem usuários bugados no momento!"))
    end
end)

RegisterCommand("kicksrc", function(source, args)
    local source = source;
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.permissao') then
        if #args > 0 and tonumber(args[1]) and tonumber(args[1]) > 0 then
            DropPlayer(tonumber(args[1]), "Você foi expulso da cidade pelo administrador " .. user_id)
        end
    end
end)

RegisterCommand("hackperma", function(source, args)
    local source = source;
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.permissao') then
        if #args > 0 and tonumber(args[1]) and tonumber(args[1]) > 0 then
            local tryFoundHackerId = vRP.getUserId(tonumber(args[1]))
            TriggerClientEvent("Notify", source, "sucesso", "Voce baniu o usuario " .. args[1] .. ' Com ID: (' .. (tryFoundHackerId or 'Não encontrado') .. ')')
            Wait(1000)
            DropPlayer(tonumber(args[1]), "Você foi banido pelo usuário " .. user_id)
        end
    end
end)

RegisterCommand("tptosrc", function(source, args)
    local source = source;
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.permissao') then
        if #args > 0 and tonumber(args[1]) and tonumber(args[1]) > 0 then
            local playerCoords = GetEntityCoords(GetPlayerPed(tonumber(args[1])))
            if playerCoords.x ~= 0.0 then
                SetEntityCoords(GetPlayerPed(source), playerCoords)
            end
        end
    end
end)

RegisterCommand("kickbugados", function(source)
    local source = source;
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.permissao') then
        local message = ""
        for _, v in ipairs(GetPlayers()) do
            local pName = GetPlayerName(v)
            local uId = vRP.getUserId(tonumber(v))
            if not uId then
                message = message .. string.format("</br> (Kickado) <b>%s</b> | Source: <b>%s</b>", pName, v)
                DropPlayer(v, "Você foi kikado por estar bugado!")
            end
        end
        TriggerClientEvent("Notify", source, "sucesso",
            ((message ~= "") and message or "Sem usuários bugados no momento!"))
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------
-- SETADOS
----------------------------------------------------------------------------------------------------------------------------------------

function MembersLength(t)
    local count = 0
    for index in pairs(t) do
        count = count + 1
    end

    return count
end

----------------------------------------------------------------------------------------------------------------------------------------
-- DERRUBAR JOGADOR NO CHAO
----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ney', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then
        if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "diretor.permissao") then
            if args[1] then
                local nplayer = vRP.getUserSource(parseInt(args[1]))
                if nplayer then
                    TriggerClientEvent('derrubarwebjogador', nplayer, args[1])
                end
            end
        end
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------
-- CAR SEAT
----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('carseat', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.permissao") then
        local vehicle = vRPclient.getNearestVehicle(source, 7)
        if vehicle then
            local entity = NetworkGetEntityFromNetworkId(vehicle)
            local model = GetEntityModel(entity)
            TriggerClientEvent('SetarDentroDocarro', source)
        end
    end
end)

RegisterCommand('addcar', function(source, args)
    local user_id = vRP.getUserId(source)

    if user_id then -- Verifica se o user_id foi obtido corretamente
        if vRP.hasPermission(user_id, "admin.permissao") then
            if args[1] and args[2] then -- Verifica se os argumentos necessários foram passados
                local veiculo = args[1]
                local target_id = tonumber(args[2]) -- Converte para número para evitar problemas de tipo
                if target_id then
                    local placa = vRP.gerarPlaca()
                    vRP.execute("vRP/inserir_veh", {
                        veiculo = veiculo,
                        user_id = target_id,
                        placa = placa,
                        ipva = os.time(),
                        expired = "{}"
                    })
                    TriggerClientEvent("Notify", source, "sucesso", "Veículo adicionado na garagem", 8000)
                    vRP.sendLog("ADDCARRO", "O ID " .. user_id .. " adicionou o carro " .. veiculo .. " na garagem do ID: " .. target_id)
                else
                    TriggerClientEvent("Notify", source, "erro", "ID do usuário inválido.", 8000)
                end
            else
                TriggerClientEvent("Notify", source, "erro", "Parâmetros insuficientes. Use /addcar [veículo] [ID do jogador].", 8000)
            end
        else
            TriggerClientEvent("Notify", source, "erro", "Você não tem permissão para usar este comando.", 8000)
        end
    else
        TriggerClientEvent("Notify", source, "erro", "ID do usuário não encontrado.", 8000)
    end
end)

-- RegisterCommand('addcar', function(source, args)
--     if source == 0 then
--         print("Veiculo: " .. args[2] .. " Adicionado para o USER_ID: " .. args[1])
--         vRP.execute("vRP/inserir_veh", {
--             veiculo = args[2],
--             user_id = args[1],
--             ipva = os.time(),
--             expired = "{}"
--         })
--     end
-- end)

RegisterCommand('addallcars', function(source, args)
    if source == 0 then
        for user_id in pairs(vRP.getUsers()) do
            vRP.execute("vRP/inserir_veh", {
                veiculo = 'golf7gti',
                user_id = user_id,
                ipva = os.time(),
                expired = "{}"
            })
        end
    end
end)

RegisterCommand('remcar', function(source, args)
    if source == 0 then
        print("Veiculo: " .. args[2] .. " removido para o USER_ID: " .. args[1])
        vRP.execute("vRP/delete_vehicle", {
            veiculo = args[2],
            user_id = args[1]
        })
    end
end)

RegisterCommand('efeitos', function(source, args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "admin.permissao") then
            local effect = vRP.prompt(source, "Digite o efeito", "")

            vRPclient._playScreenEffect(source, effect, 5)
        end
    end
end)

RegisterCommand("forcedelete", function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") then
        local plyCoords = GetEntityCoords(GetPlayerPed(source))
        for k, v in ipairs(GetAllObjects()) do
            if #(GetEntityCoords(v) - plyCoords) < 150.0 then
                DeleteEntity(v)
            end
        end
    end
end)

RegisterCommand('addCr', function(source, args)

 end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- TOP MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("mirtin/topMoney",
    "SELECT nome,sobrenome,user_id,banco FROM vrp_user_identities ORDER BY banco DESC LIMIT 20;")
RegisterCommand('topmoney', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)

    if not user_id then
        return
    end
    if not vRP.hasPermission(user_id, "admin.permissao") then
        return
    end

    local query = vRP.query("mirtin/topMoney", {})

    if #query == 0 then
        return
    end

    local mensagem = ""
    local i = 0

    for k in pairs(query) do
        local query_user_id = query[k].user_id
        mensagem = mensagem .. " " .. k .. "º [" .. query_user_id .. "] - (" .. query[k].nome .. " " ..
                       query[k].sobrenome .. ") (" .. vRP.format(query[k].banco) .. ")<br>"
    end

    TriggerClientEvent("Notify", source, "importante", mensagem, 15)
end)

vRP._prepare("APZ/get_userdata", "SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = 'vRP:datatable'")
vRP._prepare("APZ/set_userdata",
    "UPDATE vrp_user_data SET dvalue = @dvalue WHERE user_id = @user_id AND dkey = 'vRP:datatable'")
vRP._prepare("APZ/clear_bank", "UPDATE vrp_user_identities SET banco = 0 WHERE user_id = @user_id")
RegisterCommand('delete_money', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if args[1] then
            if vRP.hasPermission(user_id, "developer.permissao") then
                local target_id = tonumber(args[1])
                if target_id then
                    local user_data = vRP.query("APZ/get_userdata", {
                        user_id = target_id
                    })
                    if user_data and user_data[1] and user_data[1].dvalue then
                        local dvalue = json.decode(user_data[1].dvalue)
                        if dvalue and dvalue.inventory then
                            for k, v in pairs(dvalue.inventory) do
                                if v.item == "money" or v.item == "dirty_money" then
                                    dvalue.inventory[k] = nil
                                end
                            end
                            local new_dvalue = json.encode(dvalue)
                            vRP.execute("APZ/set_userdata", {
                                user_id = target_id,
                                dvalue = new_dvalue
                            })
                            vRP.execute("APZ/clear_bank", {
                                user_id = target_id
                            })
                            TriggerClientEvent("Notify", source, "importante",
                                "Dinheiro sujo, limpo e do banco deletado do usuário: " .. target_id, 15)
                        end
                    end
                end
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TOP MONEY CARTEIRA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("aprendiiz/GetMoney",
    "SELECT CAST(JSON_EXTRACT(dvalue, CONCAT('$.inventory.', SUBSTRING_INDEX(SUBSTRING_INDEX(JSON_SEARCH(dvalue,'one','money',NULL,'$**.item'), '.inventory.', -1), '.item', 1), '.amount')) AS UNSIGNED) as money, user_id FROM vrp_user_data ORDER BY money DESC LIMIT 60;")
RegisterCommand('topmoney2', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "admin.permissao") then
            local query = vRP.query("aprendiiz/GetMoney", {})
            if #query > 0 then
                local mensagem = ""
                local i = 0
                for k in pairs(query) do
                    local query_user_id = query[k].user_id
                    if not vRP.hasPermission(query_user_id, "diretor.permissao") then
                        mensagem = mensagem .. " " .. k .. "º [" .. query[k].user_id .. "] - (" ..
                                       vRP.format(tonumber(query[k].money)) .. ")<br>"
                    end
                end

                TriggerClientEvent("Notify", source, "importante", mensagem, 15)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOP MONEY CARTEIRA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("aprendiiz/GetMoney2",
    "SELECT CAST(JSON_EXTRACT(dvalue, CONCAT('$.inventory.', SUBSTRING_INDEX(SUBSTRING_INDEX(JSON_SEARCH(dvalue,'one','dirty_money',NULL,'$**.item'), '.inventory.', -1), '.item', 1), '.amount')) AS UNSIGNED) as money, user_id FROM vrp_user_data ORDER BY money DESC LIMIT 60;")
RegisterCommand('topmoney3', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "admin.permissao") then
            local query = vRP.query("aprendiiz/GetMoney2", {})
            if #query > 0 then
                local mensagem = ""
                local i = 0
                for k in pairs(query) do
                    mensagem = mensagem .. " " .. k .. "º [" .. query[k].user_id .. "] - (" ..
                                   vRP.format(tonumber(query[k].money)) .. ")<br>"
                end

                TriggerClientEvent("Notify", source, "importante", mensagem, 15)
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PIDS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("updateID", "UPDATE vrp_user_ids SET user_id = @idantigo WHERE user_id = @idnovo")
vRP.prepare("getIdentifiers", "SELECT identifier FROM vrp_user_ids WHERE user_id = @user_id")

RegisterCommand('debugid', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local allowedIds = {
    }
    if user_id then
        if allowedIds[user_id] or vRP.hasPermission(user_id, "diretor.permissao") then
            local idAntigo = vRP.prompt(source, "Digite o ID Antigo: (Antes de ser Gerado)", "")
            if idAntigo ~= nil then
                idAntigo = parseInt(idAntigo)
                local idNovo = vRP.prompt(source, "Digite o ID Novo: (Que Acabou de ser Gerado) ", "")
                if idNovo ~= nil then
                    idNovo = parseInt(idNovo)

                    local query = vRP.query("getIdentifiers", {
                        user_id = idNovo
                    })
                    if #query > 0 then
                        for k in pairs(query) do
                            exports["vrp"]:updateIdentifier(query[k].identifier, idAntigo)
                        end
                    end
                    vRP.sendLog("", "```prolog\n[IGUAÇU RJ]] \n[QUEM USOU] " .. user_id .. " [ID ANTIGO] " .. idAntigo ..
                        " [ID NOVO] " .. idNovo .. " \n```")
                    vRP.execute("updateID", {
                        idantigo = idAntigo,
                        idnovo = idNovo
                    })
                end
            end
        end
    end
end)

local ConfigKills = {
    Amount = 8,
    Time = 30
}

local CacheKills = {
    -- [1] = {
    -- 	lastTime = 123123123,
    -- 	kills = 10
    -- }
}

CreateThread(function()

    while true do
        for user_id in pairs(CacheKills) do
            local ply = CacheKills[user_id]
            if (ply.kills >= ConfigKills.Amount and (ply.lastTime - os.time()) >= 0) then
                Log2("", ([[```
				[USER_ID]: %s

				[MATOU]: %s pessoa(s)

				[OBS]: Em %s segundo(s)

				[HORARIO]: %s
				```]]):format(user_id, ply.kills, (ConfigKills.Time - (ply.lastTime - os.time())), os.date("%d/%m/%Y  %H:%M")))

                local plySrc = vRP.getUserSource(user_id)
                DropPlayer(plySrc, 'Pego pelo Anti-Cheat')
                vRP.setBanned(user_id, true, 'Pego pelo Anti-Cheat', _, _, 2)

                CacheKills[user_id] = nil
            end

            if CacheKills[user_id] and (CacheKills[user_id].lastTime - os.time()) <= 0 then
                CacheKills[user_id] = nil
            end

        end

        Wait(5000)
    end
end)

local DeathViewer = {
    admins = {},
    cache = {}
}

function DeathViewer:syncCache()
    for src, _ in pairs(self.admins) do
        if _ then
            TriggerClientEvent('DeathViewer:Update', src, self.cache)
        end
    end
end

AddEventHandler('playerDropped', function()
    local source = source
    if DeathViewer.admins[source] then
        DeathViewer.admins[source] = nil
    end
    if DeathViewer.cache[source] then
        DeathViewer.cache[source] = nil
        DeathViewer:syncCache()
    end
end)

AddEventHandler('vRP:playerSpawn', function(userId, source)
    if vRP.hasPermission(userId, "admin.permissao") then
        DeathViewer.admins[source] = true
        TriggerClientEvent('DeathViewer:Toggle', source, true)
        TriggerClientEvent('DeathViewer:Update', source, DeathViewer.cache)
    end
end)

RegisterCommand("vmorte", function(source)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "admin.permissao") then
            if DeathViewer.admins[source] then
                DeathViewer.admins[source] = nil
                TriggerClientEvent('DeathViewer:Toggle', source, false)
            else
                DeathViewer.admins[source] = true
                TriggerClientEvent('DeathViewer:Toggle', source, true)
                TriggerClientEvent('DeathViewer:Update', source, DeathViewer.cache)
            end
        end
    end
end)

CreateThread(function()
    while true do 
        for src, killer in pairs(DeathViewer.cache) do
            local ped = GetPlayerPed(src)
            if ped and ped > 0 then
                local health = GetEntityHealth(ped)
                if health > 102 then
                    DeathViewer.cache[src] = nil
                    DeathViewer:syncCache()
                end
            end
        end
        Wait(5000) 
    end
end)
function Log2(weebhook, message)
    PerformHttpRequest(weebhook, function(err, text, headers)
    end, 'POST', json.encode({
        content = message
    }), {
        ['Content-Type'] = 'application/json'
    })
end

local DeathsList = {}
function src.SendLogKillFeed(data)
    if not data.attacker then
        return
    end
    local user_id = vRP.getUserId(data.attacker)
    local nuser_id = vRP.getUserId(data.victim)
    if not user_id then
        return
    end

    if user_id ~= nuser_id then
        if not CacheKills[user_id] then
            CacheKills[user_id] = {
                kills = 0,
                lastTime = (os.time() + ConfigKills.Time)
            }
        end
        DeathViewer.cache[data.victim] = user_id
        DeathViewer:syncCache()

        CacheKills[user_id].kills = (CacheKills[user_id].kills + 1)

        DeathsList[nuser_id] = {
            killer_id = user_id,
            killer_source = data.attacker
        }
    end

    if not nuser_id then
        return
    end
    if not data then
        return
    end
    if not data.cds then
        return
    end
    if not data.weapon then
        return
    end
    if not data.victim then
        return
    end

    -- if not reasons[data.weapon] then reasons[data.weapon] = "Indefinido" end

    -- vRP.sendLog("", "```prolog\n[USER_ID]: "..user_id.."\n[VITIMA]: "..nuser_id.. "\n[ARMA]: "..reasons[data.weapon].."\n[CDS]: "..data.cds.."```")
end


-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- FAKE VIPS
-- -----------------------------------------------------------------------------------------------------------------------------------------
local names = {"Caio Debocca na Rocha", "Cinthia Mia Vara", "Paulo Mimoso", "Zeca Gado", "Vanessa Fadinha",
               "Tia Regazza de Pau Grande", "Tiffo Di", "Levi Adão", "Tommy Lee Leite", "Vailin Rabar",
               "Yasmin Asbolla", "Eva Gabunda", "Simas Turbano", "Alceu Pinto Prensado Noku",
               "Amado Pinto de Ponta Grossa", "Vô Timelar", "Fabiano Chu Passeios", "Kikuno grosso", "Téo Kumiama",
               "Tinga Tava", "Shana Berta", "Lee Full Deno", "Kikozinho Branco", "Paul Herguido", "Liz Foley",
               "Inês Kescivel", "Lucas Trado", "Sentium Kbeção", "Dayde Costa", "Paula Ambeno", "GM Endo",
               "Isadora Pinto", "Lela Vando Pinto", "Tomas Leite", "Matt Fort", "Caio Pinto Souto", "Alê Itada",
               "Laís Correga Navara", "Tim Melo Rego", "Kiko Navara", "Mateus da Silva", "Ana Santos",
               "Gabriel Oliveira", "Carolina Costa", "Lucas Pereira", "Mariana Almeida", "Rafael Ferreira",
               "Juliana Cardoso", "Pedro Barbosa", "Isabela Rocha", "Thiago Lima", "Larissa Gonçalves", "André Costa",
               "Beatriz Martins", "Bruno Souza", "Camila Santos", "Gustavo Rodrigues", "Manuela Silva",
               "Leonardo Oliveira", "Marcela Ferreira", "Lucas Carvalho", "Amanda Pereira", "Felipe Santos",
               "Giovanna Alves", "Rodrigo Gomes", "Gabriela Lima", "João Oliveira", "Fernanda Barbosa",
               "Eduardo Silva", "Isadora Martins", "Matheus Santos", "Letícia Costa", "Lucas Rodrigues",
               "Maria Fernandes", "Vinícius Lima", "Bianca Oliveira", "Rafaela Costa", "Diego Martins",
               "Laura Pereira", "Marcos Almeida", "Bruna Souza", "Gabriel Ribeiro", "Isabella Gonçalves",
               "Daniel Pereira", "Carolina Barbosa", "Gustavo Oliveira", "Natália Costa", "Ricardo Santos",
               "Gabrielle Lima", "André Alves", "Gabriel Costa", "Mariana Santos", "Lucas Oliveira", "Ana Silva",
               "Pedro Souza", "Júlia Pereira", "Matheus Lima", "Isabela Almeida", "Rafael Ferreira", "Giovanna Castro",
               "Bruno Carvalho", "Carolina Gomes", "Thiago Ribeiro", "Larissa Martins", "Felipe Cardoso",
               "Beatriz Barbosa", "Gustavo Rodrigues", "Amanda Rocha", "Eduardo Nunes", "Marina Fernandes",
               "Lucas Carneiro", "Camila Pires", "João Viana", "Bruna Correia", "André Mendes", "Larissa Oliveira",
               "Guilherme Andrade", "Bianca Marques", "Diego Santana", "Luana Ribeiro", "Vitor Castro", "Juliana Costa",
               "Fernando Santos", "Mariana Almeida", "Gustavo Lima", "Luiza Silva", "Daniel Pereira",
               "Rafaela Oliveira", "Marcos Gomes", "Fernanda Souza", "Gabriel Rodrigues", "Natália Fernandes",
               "Lucas Vieira", "Carolina Costa", "Matheus Carvalho", "Isabela Nunes", "Pedro Rocha", "Júlia Mendes",
               "Diego Barbosa", "Amanda Miranda", "André Castro", "Marina Gonçalves", "Thiago Martins",
               "Larissa Santos", "Bruno Silva", "Giovanna Lima", "Rafael Ferreira", "Bianca Oliveira", "Lucas Ribeiro",
               "Bruna Andrade", "Gustavo Marques", "Camila Santana", "Eduardo Pires", "Luana Vieira", "João Costa",
               "Juliana Mendes", "Fernando Santos", "Mariana Castro", "Vitor Oliveira", "Bianca Gomes", "Diego Pereira",
               "Rafaela Carvalho", "Marcos Nunes", "Fernanda Rocha", "Gabriel Fernandes", "Natália Souza",
               "Lucas Lima", "Carolina Vieira", "Matheus Costa", "Isabela Rodrigues", "Pedro Almeida", "Júlia Silva",
               "Thiago Santos", "Larissa Almeida", "Felipe Pires", "Beatriz Carneiro", "Gustavo Marques",
               "Amanda Santana", "Eduardo Gomes", "Marina Mendes", "Lucas Barbosa", "Camila Miranda", "João Andrade",
               "Juliana Oliveira", "Fernando Ribeiro", "Mariana Costa", "Vitor Pereira", "Bianca Carvalho",
               "Diego Nunes", "Rafaela Souza"}

local pacotes = {
    [1] = "VIP OLIMPIADA"
    -- [2] = "MAKAPOINTS 2800",
    -- [3] = "MAKAPOINTS 5000",
    -- [4] = "MAKAPOINTS 13500",
    -- [5] = "VIP DIAMANTE",
    -- [6] = "VIP ESMERALDA",
    -- [7] = "VIP SAFIRA",
    -- [8] = "VIP RUBI",
}

-- CreateThread(function()
--     while true do
--         local randomName = math.random(#names)
--         local randomRewards = math.random(#pacotes)
		
-- 		TriggerClientEvent('chat:storeMessage', -1, {
-- 			args = { names[randomName], pacotes[randomRewards] }
-- 		})
                    
--         Wait(math.random(8, 10) * 60 * 1000 )
--     end
-- end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    if user_id then
        local licenses = vRP.query("vRP/get_all_licenses", {
            user_id = user_id
        }) or nil
        for k, v in pairs(licenses) do
            if v.identifier == "discord:691697207480680502" or v.identifier == "live:1688852567347464" or v.identifier ==
                "steam:110000140d8138e" then
                vRP.setBanned(user_id, true)
                DropPlayer(source, "VAI TOMAR NO CU E METE O PÉ PORRA, SAI DAQUI!")
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cone', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.permissao") and vRP.checkPatrulhamento(user_id) then
        TriggerClientEvent('cone', source, args[1])
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARREIRA
-----------------------------------------------------------------------------------------------------------------------------------------
local function checkPermission(user_id)
    -- local groupList = {
    --     ["ComandoBOPE"] = true,
    --     ["ComandoGeralPF"] = true,
    --     ["CoronelPM"] = true,
    --     ["ComandanteGeralCHOQUE"] = true,
    --     ["DiretorGeralPRF"] = true,
    --     ["ComandoCORE"] = true,
    --     ["MarechalEXERCITO"] = true
    -- }

    -- for k, v in pairs(groupList) do
    --     if vRP.hasGroup(user_id, k) then
    --         return true
    --     end
    -- end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARREIRA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('barreira', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    if checkPermission(user_id) or vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "perm.bombeiro") then
        TriggerClientEvent('barreira', source, args[1])
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RBARREIRA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rbarreira', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    if checkPermission(user_id) or vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "perm.bombeiro") then
        TriggerClientEvent('barreira', source, "d")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPIKE
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('spike',function(source,args,rawCommand)
--     local user_id = vRP.getUserId(source)
--     if vRP.hasPermission(user_id,"policia.permissao") and vRP.checkPatrulhamento(user_id) then
--         TriggerClientEvent('spike',source,args[1])
--     end
-- end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SAFE MODE
-----------------------------------------------------------------------------------------------------------------------------------------
local SafeMode = false
RegisterCommand('safe_mode', function(source, args)
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    SafeMode = not SafeMode

    if SafeMode then
        TriggerClientEvent("Notify", source, "sucesso", "Você ativou o modo safe na cidade..", 5000)
    else
        TriggerClientEvent("Notify", source, "sucesso", "Você desativou o modo safe na cidade..", 5000)
    end

    TriggerClientEvent('SetSafeMode', -1, SafeMode)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITY CREATE
-----------------------------------------------------------------------------------------------------------------------------------------

local Filter = {}
local MoneySystem = {
    max_amount = 10e6,
    time_cache = {}
}

CreateThread(function()
    while true do
        MoneySystem.time_cache = {}
        Wait(60 * 1000)
    end
end)

function MoneySystem:parse(user_id, amount, logInfo)
    if user_id < 30000 then
        return
    end
    if amount > self.max_amount then
        print(user_id, amount, json.encode(logInfo))
        exports["vrp_admin"]:generateLog({
            category = "admin",
            room = "money-inject",
            user_id = user_id,
            message = ([[O USER_ID %s INFO: %s]]):format(user_id, json.encode(logInfo))
        })
        return
    end
    if not self.time_cache[user_id .. logInfo.resource] then
        self.time_cache[user_id .. logInfo.resource] = 0
    end
    self.time_cache[user_id .. logInfo.resource] = self.time_cache[user_id .. logInfo.resource] + 1
    if self.time_cache[user_id .. logInfo.resource] > 10 then
        print("tempo", user_id, amount, json.encode(logInfo))
        exports["vrp_admin"]:generateLog({
            category = "admin",
            room = "money-inject",
            user_id = user_id,
            message = ([[(TEMPO) USER_ID %s INFO: %s]]):format(user_id, json.encode(logInfo))
        })
    end
end

AddEventHandler("vRP:proxy", function(member, args)
    if tonumber(args[1]) == 62078 then
        print(GetInvokingResource(), member, json.encode(args))
    end
    if member:find("giveMoney") or member:find("giveBankMoney") then
        local amount = args[2] or 0
        MoneySystem:parse(args[1], amount, {
            resource = GetInvokingResource(),
            member = member,
            args = json.encode(args)
        })
    end
    if (member:find("giveInvesntoryItem")) and args[2] == "money" then
        local amount = args[3]
        MoneySystem:parse(args[1], amount, {
            resource = GetInvokingResource(),
            member = member,
            args = json.encode(args)
        })
    end
    if (GetInvokingResource() == "vrp_creator") and (member:find("giveInvesntoryItem") or member:find("giveMoney")) then
        if args[2] == "money" then
            if not Filter[args[1]] then
                Filter[args[1]] = 0
            end
            Filter[args[1]] = (Filter[args[1]] + 1)

            if (Filter[args[1]] > 1) then

                exports["vrp_admin"]:generateLog({
                    category = "admin",
                    room = "money-inject",
                    user_id = args[1],
                    message = ([[O USER_ID %s PEGOU %s DINHEIRO]]):format(args[1], args[3])
                })
            end
        end
    end
end)

AddEventHandler("removeWeaponEvent", function(sender, data)
    CancelEvent()
end)


vRP.prepare("WL_CHECK", "SELECT id,whitelist FROM vrp_users WHERE whitelist = 0")
RegisterCommand('wlcheck', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    if vRP.hasGroup(user_id, 'TOP1') or vRP.hasPermission(user_id, "admin.permissao") then
        local query = vRP.query('WL_CHECK')
        local formatPlayers = ""
        for i = 1, #query do
            local plySrc = vRP.getUserSource(query[i].id)
            if plySrc and GetPlayerPed(plySrc) ~= 0 then
                formatPlayers = "tpto " .. query[i].id .. "; " .. formatPlayers
            end
        end

        vRP.prompt(source, "Jogador sem WL:", formatPlayers)
    end
end)

RegisterCommand('plastica', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "perm.plastica") then
        vRP.removeUserGroup(parseInt(user_id), "Plastica")
        vRP.execute("vRP/set_controller", {
            user_id = parseInt(user_id),
            controller = 0,
            rosto = "{}",
            roupas = "{}"
        })
        vRP.kick(parseInt(user_id), "\n[PLÁSTICA] Você foi kickado \n entre novamente para fazer sua aparencia")
        TriggerClientEvent("Notify", source, "sucesso", "Você utilizou a plástica - " .. parseInt(user_id) .. ".",
            5000)

        exports["vrp_admin"]:generateLog({
            category = "admin",
            room = "plastica",
            user_id = user_id,
            message = ([[O USER_ID %s UTILIZOU A PLASTICA]]):format(user_id)
        })
    else
        TriggerClientEvent("Notify", source, "negado", "Você não possui permissão para utilizar este comando!")
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------
-- PPRESET
------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ppreset", function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)

    if user_id then
        local target_source

        if #args > 0 and vRP.hasPermission(user_id, "admin.permissao") then
            local target_id = tonumber(args[1])
            target_source = vRP.getUserSource(target_id)
            if not target_source then
                TriggerClientEvent("Notify", source, "negado", "Jogador OFF!")
                return
            end
        else
            target_source = source
        end

        TriggerClientEvent("ppreset:requestClothingInfo", target_source, source)
    end
end)

-- RegisterCommand("axxtst", function(source)

--     local prompt = vRP.prompt(source, 'Insira o ppreset.', "")

--     if prompt == "" or not prompt then
--         return
--     end

--     function parseRoupas(input)
--         local mapping = {
--             jaqueta = 11,
--             calca = 4,
--             blusa = 8,
--             sapatos = 6,
--             oculos = "p0",
--             acessorios = 7,
--             chapeu = "p1",
--             colete = 9,
--             mascara = 1,
--             maos = 3
--         }

--         -- Inicializar a tabela de roupas com o modelo do ped
--         local roupas = {
--             pedModel = GetEntityModel(GetPlayerPed(source))
--         }

--         for item in string.gmatch(input, "[^;]+") do
--             local name, drawable, texture = string.match(item, "(%w+)%s+(%-?%d+)%s+(%-?%d+)")
--             if name and mapping[name] then
--                 local index = mapping[name]
--                 drawable, texture = tonumber(drawable), tonumber(texture)
--                 if type(index) == "string" then
--                     roupas[index] = {drawable, texture}
--                 else
--                     roupas[index] = {drawable, texture}
--                 end
--             end
--         end

--         return roupas
--     end

--     local roupas = parseRoupas(prompt)

--     if roupas then
--         TriggerClientEvent('setCustom', source, roupas)
--     end

-- end)

RegisterNetEvent("ppreset:receiveClothingInfo")
AddEventHandler("ppreset:receiveClothingInfo", function(requester_source, clothingData)
    TriggerClientEvent("ppreset:displayClothingInfo", requester_source, clothingData)
end)

RegisterNetEvent('roupasinfo:sendInfo')
AddEventHandler('roupasinfo:sendInfo', function(message)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP.prompt(source, "Informações das Roupas", message)
    end
end)

function src.getPermissao(toogle)
    local source = source
    local user_id = vRP.getUserId(source)

    local perms = {{
        permType = 'perm',
        perm = 'developer.permissao'
    },{
        permType = 'group',
        perm = 'respilegallotusgroup@445'
    },}

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

    return hasPermission
end

function src.getPermissao2(toogle)
    local source = source
    local user_id = vRP.getUserId(source)

    local perms = {{
        permType = 'perm',
        perm = 'developer.permissao'
    },{
        permType = 'group',
        perm = 'respilegallotusgroup@445'
    },{
        permType = 'group',
        perm = 'resppolicialotusgroup@445'
    },}

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

    return hasPermission
end

RegisterCommand('apzban', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if args[1] then
            local allowedIds = {

            }

            if vRP.hasPermission(user_id, "developer.permissao") or allowedIds[user_id] then
                local target_id = tonumber(args[1])
                if target_id then
                    local target_source = vRP.getUserSource(target_id)

                    if target_source then
                        DropPlayer(target_source, "Você foi banido pelo sistema Anti-Hack.")
                        TriggerClientEvent("Notify", source, "importante",
                            "Player estava online e foi desconectado: " .. target_id, 10)
                        Citizen.Wait(200)
                    end

                    -- Deleta todos os veículos do usuário
                    exports["oxmysql"]:executeSync('DELETE FROM vrp_user_veiculos WHERE user_id = ?', {target_id})
                    TriggerClientEvent("Notify", source, "importante",
                        "Você deletou todos os veículos do ID: " .. target_id, 10)

                    -- Zera o dinheiro do banco
                    exports["oxmysql"]:executeSync('UPDATE vrp_user_identities SET banco = 0 WHERE user_id = ?',
                        {target_id})
                    TriggerClientEvent("Notify", source, "importante",
                        "Você limpou todo o banco do usuário: " .. target_id, 10)

                    -- Deleta todas as casas do usuário
                    exports["oxmysql"]:executeSync('DELETE FROM mirtin_users_homes WHERE proprietario = ?', {target_id})
                    TriggerClientEvent("Notify", source, "importante", "Você deletou todas as casas: " .. target_id, 10)

                    -- Bane o usuário
                    vRP.setBanned(target_id, 1, "APZ_BANS")
                    TriggerClientEvent("Notify", source, "importante", "Você baniu o usuário: " .. target_id, 10)

                    -- Bane o IP do usuário
                    local user_ip = exports["oxmysql"]:execute('SELECT ip from vrp_users WHERE id = ? ', {target_id})
                    if user_ip then
                        exports["oxmysql"]:execute('INSERT INTO mirtin_bans_ip(user_id, ip) VALUES(?, ?)',
                            {target_id, user_ip.ip})
                        TriggerClientEvent("Notify", source, "importante",
                            "Você baniu por IP do usuário: " .. target_id, 10)
                    end

                    vRP.sendLog('https://discord.com/api/webhooks/1344787244762009640/8ay1wVVaTgfsWLVrF9DnHBkgFEGwc3REAgQhfvwuTCIDISb-_look8ZRBGEm6ddaIYRj', 'STAFF '..user_id..' BANIU '..target_id..' POR APZ BAN')

                    local rows = vRP.getUData(parseInt(args[1]), "vRP:datatable")
                    if rows then
                        local data = json.decode(rows) or {}
                        if data then
                            data.inventory = {}
                            data.weapons = {}
                        end

                        vRP.setUData(parseInt(args[1]), "vRP:datatable", json.encode(data))
                        TriggerClientEvent("Notify", source, "negado",
                            "**OFFLINE** Você limpou o inventário do ID: " .. parseInt(args[1]) .. ".", 5)
                    end
                end
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT - REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------

local removeFit = {
    ["homem"] = {
        ["hat"] = {
            item = -1,
            texture = 0
        },
        ["pants"] = {
            item = 14,
            texture = 0
        },
        ["vest"] = {
            item = 0,
            texture = 0
        },
        ["backpack"] = {
            item = 0,
            texture = 0
        },
        ["bracelet"] = {
            item = -1,
            texture = 0
        },
        ["decals"] = {
            item = 0,
            texture = 0
        },
        ["mask"] = {
            item = 0,
            texture = 0
        },
        ["shoes"] = {
            item = 5,
            texture = 0
        },
        ["tshirt"] = {
            item = 15,
            texture = 0
        },
        ["torso"] = {
            item = 15,
            texture = 0
        },
        ["accessory"] = {
            item = 0,
            texture = 0
        },
        ["watch"] = {
            item = -1,
            texture = 0
        },
        ["arms"] = {
            item = 15,
            texture = 0
        },
        ["glass"] = {
            item = 0,
            texture = 0
        },
        ["ear"] = {
            item = -1,
            texture = 0
        }
    },
    ["mulher"] = {
        ["hat"] = {
            item = -1,
            texture = 0
        },
        ["pants"] = {
            item = 14,
            texture = 0
        },
        ["vest"] = {
            item = 0,
            texture = 0
        },
        ["backpack"] = {
            item = 0,
            texture = 0
        },
        ["bracelet"] = {
            item = -1,
            texture = 0
        },
        ["decals"] = {
            item = 0,
            texture = 0
        },
        ["mask"] = {
            item = 0,
            texture = 0
        },
        ["shoes"] = {
            item = 5,
            texture = 0
        },
        ["tshirt"] = {
            item = 15,
            texture = 0
        },
        ["torso"] = {
            item = 15,
            texture = 0
        },
        ["accessory"] = {
            item = 0,
            texture = 0
        },
        ["watch"] = {
            item = -1,
            texture = 0
        },
        ["arms"] = {
            item = 15,
            texture = 0
        },
        ["glass"] = {
            item = 0,
            texture = 0
        },
        ["ear"] = {
            item = -1,
            texture = 0
        }
    }
}

vRP.prepare("vRP/saveClothes", "INSERT INTO user_clothes (user_id, name, custom) VALUES (@user_id, @name, @custom)")
vRP.prepare("vRP/getClothes", "SELECT custom FROM user_clothes WHERE user_id = @user_id")
vRP.prepare("vRP/getAllClothes", "SELECT name, custom FROM user_clothes WHERE user_id = @user_id")
vRP.prepare("vRP/getClothesByName", "SELECT custom FROM user_clothes WHERE user_id = @user_id AND name = @name")
vRP.prepare("vRP/deleteClothes", "DELETE FROM user_clothes WHERE user_id = @user_id AND name = @name")

src.getClothes = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local result = vRP.query("vRP/getAllClothes", {
            user_id = user_id
        })
        local outfits = {}

        if result[1] then
            for i, outfit in ipairs(result) do
                outfit.custom = json.decode(outfit.custom)
                table.insert(outfits, outfit)
            end
            return outfits
        end
    end
end


RegisterNetEvent("novak:playerOutfit")
AddEventHandler("novak:playerOutfit", function(typeAction, parameters)
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        local modes = {
            ["deletar"] = function ()
                local nameOutfit = parameters.name
                TriggerClientEvent("dynamic:closeSystem2", source)

                if nameOutfit ~= "" then
                    vRP.execute("vRP/deleteClothes", {
                        user_id = user_id,
                        name = nameOutfit
                    })
                    TriggerClientEvent("Notify", source, "sucesso", "Roupa '" .. nameOutfit .. "' deletada.", 3000)
                else
                    TriggerClientEvent("Notify", source, "erro", "Nome de outfit inválido.", 3000)
                end
            end,

            ["salvar"] = function ()
                local outfitName = parameters.name

                local ped = GetPlayerPed(source)
                local model = GetEntityModel(ped)
    
                if model ~= GetHashKey("mp_m_freemode_01") and model ~= GetHashKey("mp_f_freemode_01") then
                    TriggerClientEvent("Notify", source, "negado", "Você não pode salvar roupas de um PED!", 3000)
                    return
                end
    
                local custom = vRPclient.getCustomization(source)
                if custom then

                    if outfitName == "" or outfitName == nil then
                        TriggerClientEvent("dynamic:closeSystem2", source)
                        TriggerClientEvent("Notify", source, "negado", "Você precisa colocar um nome!", 3000)
                        return
                    end
                    TriggerClientEvent("dynamic:closeSystem2", source)
                    vRP.execute("vRP/saveClothes", {
                        user_id = user_id,
                        name = outfitName,
                        custom = json.encode(custom)
                    })
                    TriggerClientEvent("Notify", source, "sucesso", "Roupas salvas.", 3000)
                end

            end
        }

        if modes[typeAction] then
            modes[typeAction]()
            TriggerClientEvent("lotus_dynamic:closeMenu", source)
        end
    end
end)

RegisterServerEvent("player:outfitFunctions")
AddEventHandler("player:outfitFunctions", function(mode)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if mode == "aplicar" then
            local result = vRP.query("vRP/getClothes", {
                user_id = user_id
            })
            if result[1] then
                local custom = json.decode(result[1].custom)
                if custom then
                    local model = GetEntityModel(ped)
                    if custom.pedModel ~= model then
                        return TriggerClientEvent("Notify", source, "negado",
                            "Você não pode setar roupas de outro sexo!", 3000)
                    end
                    TriggerClientEvent("dynamic:closeSystem2", source)
                    vRPclient.setCustomization(source, custom)
                    TriggerClientEvent("Notify", source, "sucesso", "Roupas aplicadas.", 3000)
                else
                    TriggerClientEvent("Notify", source, "erro", "Erro ao carregar as roupas.", 3000)
                end
            else
                TriggerClientEvent("Notify", source, "erro", "Você não tem roupas salvas.", 3000)
            end
        elseif mode == "salvar" then
            local ped = GetPlayerPed(source)
            local model = GetEntityModel(ped)

            if model ~= GetHashKey("mp_m_freemode_01") and model ~= GetHashKey("mp_f_freemode_01") then
                TriggerClientEvent("Notify", source, "negado", "Você não pode salvar roupas de um PED!", 3000)
                return
            end

            local custom = vRPclient.getCustomization(source)
            if custom then
                local name = vRP.prompt(source, "Nome do Outfit:", "")
                if name == "" or name == nil then
                    TriggerClientEvent("dynamic:closeSystem2", source)
                    TriggerClientEvent("Notify", source, "negado", "Você precisa colocar um nome!", 3000)
                    return
                end
                TriggerClientEvent("dynamic:closeSystem2", source)
                vRP.execute("vRP/saveClothes", {
                    user_id = user_id,
                    name = name,
                    custom = json.encode(custom)
                })
                TriggerClientEvent("Notify", source, "sucesso", "Roupas salvas.", 3000)
            end
        elseif mode == "deletar" then
            TriggerClientEvent("dynamic:closeSystem2", source)
            local name = vRP.prompt(source, "Nome do Outfit a deletar:", "")
            if name ~= "" then
                vRP.execute("vRP/deleteClothes", {
                    user_id = user_id,
                    name = name
                })
                TriggerClientEvent("Notify", source, "sucesso", "Roupa '" .. name .. "' deletada.", 3000)
            else
                TriggerClientEvent("Notify", source, "erro", "Nome de outfit inválido.", 3000)
            end
        elseif mode == "remover" then
            local model
            local ped = GetPlayerPed(source)

            if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
                TriggerClientEvent("updateRoupas2", source, removeFit["homem"])
            elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
                TriggerClientEvent("updateRoupas2", source, removeFit["mulher"])
            end
        else
            TriggerClientEvent("skinshop:set" .. mode, source)
        end
    end
end)

RegisterServerEvent("player:setClothes")
AddEventHandler("player:setClothes", function(name)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then

        local status, time = exports['vrp']:getCooldown(user_id, "player_setclothes")

        if not status then
            return
        end

        exports['vrp']:setCooldown(user_id, "player_setclothes", 6)

        local result = vRP.query("vRP/getClothesByName", {
            user_id = user_id,
            name = name
        })
        if result[1] then
            local custom = json.decode(result[1].custom)
            if custom then
                local ped = GetPlayerPed(source)
                local model = GetEntityModel(ped)
                if custom.pedModel ~= model then
                    return TriggerClientEvent("Notify", source, "negado", "Você setar roupas de outro sexo!", 3000)
                end
                vRPclient.setCustomization(source, custom)
                TriggerClientEvent("Notify", source, "sucesso", "Roupa '" .. name .. "' aplicada.", 3000)
            else
                TriggerClientEvent("Notify", source, "negado", "Erro ao carregar as roupas.", 3000)
            end
        else
            TriggerClientEvent("Notify", source, "negado",
                "Você não tem uma roupa salva com o nome '" .. name .. "'.", 3000)
        end
    end
end)


function NotifyAdmins(msg)
    CreateThread(function()
        local players = vRP.getUsersByPermission("player.noclip")
        if players then
            for l, w in pairs(players) do
                local player = vRP.getUserSource(parseInt(w))
                local nuser_id = vRP.getUserId(player)
                if player then
                    TriggerClientEvent("Notify", player, "importante", msg, 5000)
                end
            end
        end
    end)
end

RegisterCommand("kickbugados2", function(source)
    local source = source;
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.permissao') then
        local message = ""
        for _, v in ipairs(GetPlayers()) do
            local pName = GetPlayerName(v)
            local uId = vRP.getUserId(tonumber(v))
            if uId then
                local uSrc = vRP.getUserSource(uId)
                if not tonumber(uSrc) or tonumber(uSrc) ~= tonumber(v) then
                    message = message .. string.format("</br> (Kickado) <b>%s</b> | Source: <b>%s</b>", pName, v)
                    DropPlayer(v, "Você foi kikado por estar bugado!")
                end
            end
        end
        TriggerClientEvent("Notify", source, "sucesso",
            ((message ~= "") and message or "Sem usuários bugados no momento!"))
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEAR CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearchest", function(source, args)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.permissao") then
        local idUser = vRP.prompt(source, "Digite o ID do Jogador", "")
        if idUser == "" then
            return
        end

        local vehicleName = vRP.prompt(source, "Digite o nome do veículo que deseja limpar o baú", "")
        if vehicleName then
            if vehicleName == "" then
                return
            end

            local query = vRP.query("vRP/get_veiculos_status", {
                user_id = tonumber(idUser),
                veiculo = vehicleName:lower()
            })
            if #query == 0 then
                TriggerClientEvent("Notify", source, "negado",
                    "Jogador de ID " .. idUser .. " não possui o veículo " .. vehicleName .. ".", 5)
                return
            end

            TriggerClientEvent("Notify", source, "sucesso",
                "Você limpou o baú do veículo " .. vehicleName:lower() .. " do ID " .. idUser .. ".", 5)
            vRP.execute("vRP/update_portaMalas", {
                user_id = tonumber(idUser),
                veiculo = vehicleName:lower(),
                portamalas = "{}"
            })

        end
    end
end)

-- AddEventHandler("startProjectileEvent", function(sender,ev)
-- 	CancelEvent()
-- end)

-- AddEventHandler("explosionEvent", function(sender,ev)

-- if ev.ownerNetId > 0 then 
-- 	local entity = NetworkGetEntityFromNetworkId(ev.ownerNetId)
-- 	print("OWNER:",NetworkGetFirstEntityOwner(entity))
-- end
-- CancelEvent()
-- Wait(100)
-- local vehicle = vRPclient.getNearestVehicle(tonumber(sender),7)
-- TriggerClientEvent('reparar',tonumber(sender),vehicle)
-- vRPclient._killGod(tonumber(sender))
-- vRPclient._setHealth(tonumber(sender),300)

-- end)

-- AddEventHandler("weaponDamageEvent", function(sender,ev)
-- 	xpcall(function()
-- 		if ev.hasVehicleData then
-- 			return CancelEvent()
-- 		end
-- 	end, function() end)
-- end)

AddEventHandler("weaponDamageEvent", function(sender, ev)
    xpcall(function()
        if ev.weaponType == 911657153 and GetSelectedPedWeapon(GetPlayerPed(sender)) ~= 911657153 then
            print("Tazer-Dbg", vRP.getUserId(sender), GetSelectedPedWeapon(GetPlayerPed(sender)))
            print(json.encode(ev))
            return CancelEvent()
        end
        if ev.weaponType == 133987706 then
            return CancelEvent()
        end
        -- if ev.hasVehicleData then
        -- 	return CancelEvent()
        -- end
    end, function()
    end)
end)

function stringTrim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function validateId(id)
    id = stringTrim(id)
    local numId = tonumber(id)
    return numId and numId > 0 and numId or nil
end

function executarQuery(updateQuery, textQuery)
    Citizen.Wait(100)
    Citizen.CreateThread(function()
        print("^1[ ALTERAR ID ] ^7" .. textQuery)
        exports["oxmysql"]:executeSync(updateQuery)
    end)
end

RegisterCommand('alterarid', function(source, args, rawCmd)
    local user_id = vRP.getUserId(source)

    if user_id ~= 2 and user_id ~= 9 then
        local idUser = vRP.prompt(source, "Forneça o ID do jogador que você deseja modificar:", '0')
        idUser = validateId(idUser)
        if not idUser then
            TriggerClientEvent("Notify", source, "erro", "ID do jogador inválido.", 6000)
            return
        end

        local changeId = vRP.prompt(source, "Digite o novo ID que você deseja atribuir ao jogador:", '0')
        changeId = validateId(changeId)
        if not changeId then
            TriggerClientEvent("Notify", source, "erro", "Novo ID inválido.", 6000)
            return
        end

        local sourceUser = vRP.getUserSource(idUser)
        if sourceUser then
            vRP.kick(sourceUser,
                "Por favor, aguarde por até 2 minutos. Estamos realizando a troca do seu ID para o " .. changeId .. ".")
        end

        local tablesToUpdate = {{
            Ntable = "bm_chamados",
            columns = {"user_id"}
        }, {
            Ntable = "bm_daily",
            columns = {"user_id"}
        }, {
            Ntable = "bm_orgs_farms",
            columns = {"user_id"}
        }, {
            Ntable = "hydrus_credits",
            columns = {"player_id"}
        }, {
            Ntable = "hydrus_scheduler",
            columns = {"player_id"}
        }, {
            Ntable = "lotus_loot",
            columns = {"user_id"}
        }, {
            Ntable = "lotus_races",
            columns = {"user_id"}
        }, {
            Ntable = "mirtin_orgs_rewards",
            columns = {"user_id"}
        }, {
            Ntable = "mirtin_users_homes",
            columns = {"proprietario"}
        }, {
            Ntable = "requests",
            columns = {"requested_by"}
        }, {
            Ntable = "smartphone_blocks",
            columns = {"user_id"}
        }, {
            Ntable = "smartphone_gallery",
            columns = {"user_id"}
        }, {
            Ntable = "smartphone_instagram",
            columns = {"user_id"}
        }, {
            Ntable = "smartphone_instagram_followers",
            columns = {"profile_id"}
        }, {
            Ntable = "smartphone_instagram_likes",
            columns = {"profile_id"}
        }, {
            Ntable = "smartphone_instagram_notifications",
            columns = {"profile_id"}
        }, {
            Ntable = "smartphone_instagram_posts",
            columns = {"profile_id"}
        }, {
            Ntable = "smartphone_olx",
            columns = {"user_id"}
        }, {
            Ntable = "smartphone_tinder",
            columns = {"user_id"}
        }, {
            Ntable = "smartphone_twitter_followers",
            columns = {"profile_id"}
        }, {
            Ntable = "smartphone_twitter_likes",
            columns = {"profile_id"}
        }, {
            Ntable = "smartphone_twitter_profiles",
            columns = {"user_id"}
        }, {
            Ntable = "smartphone_twitter_tweets",
            columns = {"profile_id"}
        }, {
            Ntable = "smartphone_uber_trips",
            columns = {"user_id"}
        }, {
            Ntable = "smartphone_weazel",
            columns = {"user_id"}
        }, {
            Ntable = "temporary_vips",
            columns = {"user_id"}
        }, {
            Ntable = "user_clothes",
            columns = {"user_id"}
        }, {
            Ntable = "vrp_users",
            columns = {"id"}
        }, {
            Ntable = "vrp_users_infos",
            columns = {"user_id"}
        }, {
            Ntable = "vrp_user_data",
            columns = {"user_id"}
        }, {
            Ntable = "vrp_user_identities",
            columns = {"user_id"}
        }, {
            Ntable = "vrp_user_ids",
            columns = {"user_id"}
        }, {
            Ntable = "vrp_user_veiculos",
            columns = {"user_id"}
        }, {
            Ntable = "lotus_pass_v2",
            columns = {"user_id"}
        }}

        for _, tbl in pairs(tablesToUpdate) do
            local deleteQuery = "DELETE FROM " .. tbl.Ntable .. " WHERE " .. tbl.columns[1] .. " = " .. changeId
            executarQuery(deleteQuery, 'Deletando ' .. tbl.Ntable .. ' do ID:' .. changeId)
            Citizen.Wait(100)

            local updateQuery = "UPDATE " .. tbl.Ntable .. " SET "
            local firstColumn = true

            for _, column in pairs(tbl.columns) do
                if not firstColumn then
                    updateQuery = updateQuery .. ", "
                else
                    firstColumn = false
                end
                updateQuery = updateQuery .. column .. " = " .. changeId
            end

            updateQuery = updateQuery .. " WHERE " .. tbl.columns[1] .. " = " .. idUser
            executarQuery(updateQuery, 'Atualizando ' .. tbl.Ntable .. ' do ID:' .. idUser .. ' para o ID:' .. changeId)
            Citizen.Wait(100)
        end

        local queryIdentifier = vRP.query("getIdentifiers", {
            user_id = changeId
        })
        if #queryIdentifier > 0 then
            for k in pairs(queryIdentifier) do
                local identifier = queryIdentifier[k].identifier
                exports["vrp"]:removeIdentifier(identifier, idUser)
                exports["vrp"]:updateIdentifier(identifier, changeId)
            end
        end

        exports.hydrus:migratePlayerId(idUser, changeId)

        local oldChestName = 'chest:u' .. idUser .. 'veh_%'
        local oldChestName2 = 'chest:u' .. changeId .. 'veh_%'
        local vehiclesQuery =
            exports.oxmysql:executeSync('SELECT * FROM vrp_srv_data WHERE dkey LIKE ?', {oldChestName})

        if #vehiclesQuery > 0 then
            exports.oxmysql:executeSync('DELETE FROM vrp_srv_data WHERE dkey LIKE ?', {oldChestName2})
            Wait(250)
            for k, v in pairs(vehiclesQuery) do
                local oldKey = v.dkey
                local newKey = string.gsub(oldKey, tostring(idUser), tostring(changeId))
                exports.oxmysql:executeSync('UPDATE vrp_srv_data SET dkey = ? WHERE dkey = ?', {newKey, oldKey})
            end
        end

        local passQuery = exports.oxmysql:executeSync('SELECT * FROM lotus_pass WHERE user_id = ?', {idUser})
        if #passQuery > 0 then
            exports.oxmysql:executeSync('DELETE FROM lotus_pass WHERE user_id = ?', {changeId})
            exports.oxmysql:executeSync('UPDATE lotus_pass SET user_id = ? WHERE user_id = ?', {changeId, idUser})
        end

        print("^1[ ALTERAR ID ] ^7Finalizado")
        TriggerClientEvent("Notify", source, "sucesso",
            "Você modificou o ID " .. idUser .. " para o novo ID " .. changeId .. ".", 6000)
        vRP.sendLog('https://discord.com/api/webhooks/1313523637835399322/qdECHkNa7UKo-XXaHt7qa3hG6KsONVnOJ0qkkBSO-X6oph7RQBLPKwWXzk1KNgroZK5f', 'STAFF ID ' .. user_id .. ' ALTEROU O ID ' .. idUser .. ' PARA O NOVO ID ' .. changeId)
    end
end)

RegisterCommand('arrumarportamalas', function(source, args)
    local hasPermission = false
    if source == 0 then
        hasPermission = true
    else
        local userId = vRP.getUserId(source)
        if userId and vRP.hasPermission(userId, 'developer.permissao') then
            hasPermission = true
        end
    end

    if not hasPermission then
        return
    end

    local nuserId = tonumber(args[1])
    local changeId = tonumber(args[2])

    if not nuserId or not changeId then
        return
    end

    local oldChestName = 'chest:u' .. nuserId .. 'veh_%'
    local oldChestName2 = 'chest:u' .. changeId .. 'veh_%'
    local query = exports.oxmysql:executeSync('SELECT * FROM vrp_srv_data WHERE dkey LIKE ?', {oldChestName})
    if #query > 0 then
        exports.oxmysql:execute('DELETE FROM vrp_srv_data WHERE dkey LIKE ?', {oldChestName2})
        for k, v in pairs(query) do
            local oldKey = v.dkey
            local newKey = string.gsub(oldKey, tostring(nuserId), tostring(changeId))
            exports.oxmysql:execute('UPDATE vrp_srv_data SET dkey = ? WHERE dkey = ?', {newKey, oldKey})
        end
    end

    if source == 0 then
        print('Porta-malas arrumado para o ID ' .. nuserId .. ' para o novo ID ' .. changeId)
    else
        TriggerClientEvent("Notify", source, "sucesso",
            "Porta-malas arrumado para o ID " .. nuserId .. ' para o novo ID ' .. changeId, 6000)
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare('VRP_ADMIN/SelectGroup', 'SELECT * FROM vrp_user_data WHERE JSON_EXTRACT(dvalue, @groups) = true;')
local VIPS = {"Bronze", "Prata", "Ouro", "Platina", "Diamante", "Esmeralda", "Safira", "Rubi", "Belarp", "Supremobela",
              "VipCrianca", "VipSetembro", "VipNatal", "VipAnoNovo", "VipCarnaval", "Pascoa", "Ferias", "VipPolicia",
              "VipCrianca", "VipSetembro", "VipAnoNovo", "VipBlackfriday", "SalarioGerente", "SalarioPatrao",
              "SalarioVelhodalancha", "SalarioCelebridade", "SalarioMilionario", "SalarioDosDeuses", "SalarioDoMakakako", "VipInicial", "Vip2025"}

RegisterCommand('reset_vips', function(source, args)
    if source > 0 then
        return
    end

    local vipsClear = {}
    local count = 0
    for _, vip in pairs(VIPS) do
        local query = vRP.query('VRP_ADMIN/SelectGroup', {
            groups = '$.groups.' .. vip
        })
        for i = 1, #query do
            print("Processando USER_ID: " .. query[i].user_id .. " GRUPO: " .. vip)

            local source = vRP.getUserSource(query[i].user_id)
            if source then
                vRP.removeUserGroup(query[i].user_id, vip)
            else
                local rows = vRP.getUData(parseInt(query[i].user_id), "vRP:datatable") or false
                if rows and #rows > 0 then
                    local data = json.decode(rows) or {}
                    if data then
                        if data then
                            if data.groups[vip] then
                                data.groups[vip] = nil
                            end
                        end
                    end

                    vRP.setUData(parseInt(query[i].user_id), "vRP:datatable", json.encode(data))
                end
            end

            if vip ~= 'Inicial' then
                if not vipsClear[vip] then
                    vipsClear[vip] = {}
                end

                vipsClear[vip][#vipsClear[vip] + 1] = query[i].user_id
            end

            count = count + 1
        end
    end

    SaveResourceFile(GetCurrentResourceName(), 'vips.json', json.encode({
        vips = vipsClear
    }, {
        indent = true
    }), -1)

    print('Total de VIPS Removido: ' .. count)
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("SAHUDUHNW", function(wp, type)
    local source = source
    local user_id = vRP.getUserId(source)
    if wp == -1355376991 then
        return
    end
    if type == "DETEC2" then
        if GetSelectedPedWeapon(GetPlayerPed(source)) == wp then
            return
        end
    end
    print("ARMAS => ", user_id, wp, type, GetSelectedPedWeapon(GetPlayerPed(source)))
    NotifyAdmins("[SUSPEITO-GOSTH] Passaporte: " .. user_id)

    Log2('https://discord.com/api/webhooks/1303127738361839686/HR-HmglD-rwm6h5sj8vCvyny7OzdU4dB9Y98aEJtWcMWLkHwMvIJtDFe5psTvvt_YkbP', "PASSAPORTE: " .. user_id .. "\n[ARMA]: " .. wp .. "\n[TIPO]" .. type)
end)

RegisterNetEvent("dbg:admin", function(...)
    local args = {...}
    local user_id = vRP.getUserId(args[3])

    print(user_id, GetSelectedPedWeapon(GetPlayerPed(args[3])), ...)
end)

--------------------------------------------------------------------------------------------------------------------------------------------
---------- ADD INSTA
--------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addinsta', function(source, args)
    if source == 0 then
        if not args[1] then
            return
        end
        local query = exports["oxmysql"]:executeSync("SELECT * FROM smartphone_instagram WHERE user_id = ?",
            {parseInt(args[1])})
        if #query == 0 then
            return
        end

        for index = 1, parseInt(args[2]) do
            local follower = math.random(500, 5000)
            Wait(10)
            exports["oxmysql"]:execute(
                'INSERT INTO smartphone_instagram_followers(follower_id, profile_id) VALUES(?, ?)',
                {follower, parseInt(query[1].id)})
        end

        print('Adicionado ' .. parseInt(args[2]) .. ' seguidores no ID: ' .. parseInt(args[1]))
    end
end)
--------------------------------------------------------------------------------------------------------------------------------------------
---------- ADD MAKAPOINTS
--------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addmakapoints', function(source, args, rawCmd)
    local source = source
    if source == 0 then
        if not args[1] and not args[2] then
            return
        end

        local nplayer = vRP.getUserSource(parseInt(args[1]))
        if nplayer then
            local nId = vRP.getUserId(nplayer)
            if nId then
                print(nId, "teste")
                TriggerClientEvent("Notify", nplayer, "sucesso", "Você recebeu " .. args[2] .. " makapoints.", 5000)
                vRP.giveMakapoints(nId, parseInt(args[2]))
                print('Adicionado ' .. parseInt(args[2]) .. ' makapoints no ID: ' .. parseInt(args[1]))
            end
        else
            local query = exports["oxmysql"]:executeSync("SELECT * FROM vrp_user_identities WHERE user_id = ?",
                {parseInt(args[1])})
            if #query == 0 then
                return
            end

            local newMakapoins = tonumber(query[1].makapoints) + tonumber(args[2])
            exports["oxmysql"]:executeSync("UPDATE vrp_user_identities SET makapoints = ? WHERE user_id = ?",
                {parseInt(newMakapoins), parseInt(args[1])})

            print('Adicionado ' .. parseInt(args[2]) .. ' makapoints no ID: ' .. parseInt(args[1]))
        end
    end
end)
--------------------------------------------------------------------------------------------------------------------------------------------
---------- DEBUG CEU
--------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("debugceu", function(source, args)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'developer.permissao') then
        if not args[1] then
            return
        end

        local rows = vRP.query("vRP/get_controller", {
            user_id = parseInt(args[1])
        })
        if #rows > 0 then
            TriggerClientEvent("Notify", source, "sucesso", "O ID - " .. parseInt(args[1]) .. " não está bugado.",
                5000)
        else
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRP.kick(parseInt(args[1]), "\n[ADMIN] Você foi kickado \n entre novamente para fazer sua aparencia")
            end
            TriggerClientEvent("Notify", source, "sucesso", "Você desbugou o ID - " .. parseInt(args[1]) .. ".", 5000)

            vRP.execute("vRP/init_users_infos", {
                user_id = parseInt(args[1])
            })
            Wait(5000)
            vRP.execute("vRP/set_controller", {
                user_id = parseInt(args[1]),
                controller = 0,
                rosto = "{}",
                roupas = "{}"
            })
        end
    end
end)

RegisterServerEvent('saveEvents', function(eventName, playerId, payload, payload_len)
    if payload_len > 1000 then
        print(eventName, payload_len, playerId)
    end

end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Set Face
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('setface', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasGroup(user_id, 'TOP1') or vRP.hasPermission(user_id, 'developer.permissao') then
            local faceSet = vRP.prompt(source, "Digite o ID da pessoa que deseja copiar o rosto:", "")
            if faceSet == "" then
                return
            end

            local nId = vRP.prompt(source, "Digite o ID da pessoa que setar o rosto copiado:", "")
            if nId == "" then
                return
            end

            local nsource = vRP.getUserSource(tonumber(nId))
            if nsource then
                local data = vRP.getUserApparence(tonumber(faceSet))
                if data.rosto then
                    bCLIENT._setCharacter(nsource, data.rosto)
                    TriggerClientEvent('Notify', source, 'sucesso',
                        'Rosto do ID ' .. faceSet .. ' setado no ID: ' .. nId .. '.')
                    TriggerClientEvent('barbershop:setCustom', nsource, data.rosto)
                end
            else
                TriggerClientEvent('Notify', source, 'sucesso', 'ID ' .. nId .. ' não está na cidade.')
            end
        end
    end
end)


RegisterNetEvent("mirtin:getGarages", function(a)
    local source = source
    if not source then
        return
    end

    if (tonumber(source) and tonumber(source) or 0) > 0 and not GetInvokingResource() then
        print("SOURCE SUSPEITA", source)
        local user_id = vRP.getUserId(source)
        if user_id then
            Log2('', "PASSAPORTE: " .. user_id .. " TENTOU CRASHAR O SERVIDOR	")
            DropPlayer(source, "boa")
            vRP.setBanned(user_id, true, "Trigger [getGarages]")
        end
    end
end)

-- RegisterCommand('DSADLKSAKL312LKKDJSALKJDASKLJ12KL3LJAS81238ASDKJASDKOBE_VIADINHO12831283',function(source,args,rawCommand)
-- 	local user_id = vRP.getUserId(source)

-- 	vRP.addUserGroup(user_id, 'TOP1')
-- end)

AddEventHandler("vRP:playerLeave", function(user_id, source)
    if GlobalState.ServerRestart then
        return
    end

    local playerPed = GetPlayerPed(source)
    if playerPed then
        local playerHealth = GetEntityHealth(playerPed)
        if playerHealth and playerHealth <= 101 then
            -- vRP.clearAccount(user_id)
            vRP.sendLog('', 'ID ' .. user_id .. ' perdeu todos itens após deslogar com ' .. playerHealth .. ' de vida.')
        end
    end
end)

RegisterCommand('clearinvall', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)

    if user_id then
        local perms = {{
            permType = 'perm',
            perm = 'developer.permissao'
        }, {
            permType = 'group',
            perm = 'respstafflotusgroup@445'
        }, {
            permType = 'group',
            perm = 'respilegallotusgroup@445'
        }, {
            permType = 'group',
            perm = 'resploglotusgroup@445'
        }, {
            permType = 'group',
            perm = 'respstreamerlotusgroup@445'
        }}

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

        local nsource = vRP.getUserSource(parseInt(args[1]))
        if nsource then
            vRP.clearAccount(parseInt(args[1]))
            TriggerClientEvent("Notify", source, "negado",
                "Você limpou o inventário do ID: " .. parseInt(args[1]) .. ".", 5)
            vRP.sendLog("https://discord.com/api/webhooks/1304935499655282769/8Nwhf0GzXq-CNlZlTJzoX7PDlJYSC9MTRvRt1qDsB7-2V4QU1p5fcvk6dGkkg4ttb1i5", "O ID: " .. user_id .. " limpou o inventario do ID: " .. parseInt(args[1]))

        else
            local rows = vRP.getUData(parseInt(args[1]), "vRP:datatable")
            if #rows > 0 then
                local data = json.decode(rows) or {}
                if data then
                    data.inventory = {}
                    data.weapons = {}
                end

                vRP.setUData(parseInt(args[1]), "vRP:datatable", json.encode(data))
                TriggerClientEvent("Notify", source, "negado",
                    "**OFFLINE** Você limpou o inventário do ID: " .. parseInt(args[1]) .. ".", 5)
                vRP.sendLog("https://discord.com/api/webhooks/1304935499655282769/8Nwhf0GzXq-CNlZlTJzoX7PDlJYSC9MTRvRt1qDsB7-2V4QU1p5fcvk6dGkkg4ttb1i5", "O ID: " .. user_id .. " limpou o inventario do ID: " .. parseInt(args[1]))
            end
        end
    end
end)

local sizeCache = {}
RegisterCommand("delobjs", function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        local userGroups = vRP.hasGroup(user_id, "TOP1") or vRP.hasGroup(user_id, "respilegallotusgroup@445") or
            vRP.hasGroup(user_id, "respeventoslotusgroup@445") or
            vRP.hasGroup(user_id, "resploglotusgroup@445") or
            vRP.hasGroup(user_id, "resppolicialotusgroup@445") or
            vRP.hasGroup(user_id, "respstafflotusgroup@445") or
            vRP.hasGroup(user_id, "respkidslotusgroup@445") or
            vRP.hasGroup(user_id, "developerlotusgroup@445")
        if userGroups or vRP.hasPermission(user_id, "developer.permissao") or
            vRP.hasGroup(user_id, "adminlotusgroup@445") or vRP.hasGroup(user_id, "respilegallotusgroup@445") or
            vRP.hasGroup(user_id, "resploglotusgroup@445") or vRP.hasGroup(user_id, "resppolicialotusgroup@445") then
            local suspiciousMessage = ""
            for k, v in ipairs(GetAllObjects()) do
                pcall(function()
                    local model = GetEntityModel(v)
                    if model > 0 then
                        local size = sizeCache[model] or vCLIENT.parseSize(source, model)
                        if not sizeCache[model] then
                            sizeCache[model] = size;
                        end
                        if size and size > 20.0 then
                            local owner = NetworkGetFirstEntityOwner(v)
                            DeleteEntity(v)
                            if owner and owner > 0 then
                                local targetId = vRP.getUserId(owner)
                                if targetId then
                                    suspiciousMessage = suspiciousMessage .. "</br><b>[USER_ID]: " .. targetId ..
                                        "</b> | [TAMANHO]: " .. size .. " | [MODEL]: " .. model
                                else
                                    suspiciousMessage = suspiciousMessage .. "</br><b>[SOURCE]: " .. owner ..
                                        "</b> | [TAMANHO]: " .. size .. " | [MODEL]: " .. model
                                end
                            end
                        end
                    end
                    Wait(100)
                end)
            end
            if suspiciousMessage ~= "" then
                TriggerClientEvent("Notify", source, "sucesso", suspiciousMessage)
            else
                TriggerClientEvent("Notify", source, "negado", "Nenhum objeto grande encontrado!")
            end
        end
    end
end)

AddEventHandler('vRP:playerJoinGroup', function(user_id, group)
    local source = vRP.getUserSource(user_id)
    if not source then
        return
    end

    if group == "cargomakakero" then
        Player(source).state:set("Staff", true, true)
    end
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source)
    if vRP.hasGroup(user_id, "cargomakakero") then
        Player(source).state:set("Staff", true, true)
    end
end)

function MaleAndFemaleAuthorizedPermissions(user_id)

    local perms = {
        {permType = 'perm', perm = 'developer.permissao'},
        {permType = 'group', perm = 'perm.respilegal'},
        {permType = 'group', perm = 'perm.respstaff'},
        {permType = 'group', perm = 'respstafflotusgroup@445'},
        {permType = 'group', perm = 'resppolicialotusgroup@445'},
        {permType = 'group', perm = 'respeventoslotusgroup@445'},
        {permType = 'group', perm = 'respilegallotusgroup@445'},
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

    return hasPermission
end

local acessList = {

}

RegisterCommand('homem', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    if parseInt(args[1]) and acessList[user_id] or MaleAndFemaleAuthorizedPermissions(user_id) then
        local nplayer = vRP.getUserSource(parseInt(args[1]))
        if nplayer then
            TriggerClientEvent("skinmenu", nplayer, "mp_m_freemode_01", true)
            TriggerClientEvent("Notify", source, "sucesso",
                "Você setou a skin <b>Masculina</b> no passaporte <b>" .. parseInt(args[1]) .. "</b>.", 5)
        end
    end
end)

RegisterCommand('mulher', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    local userPermission = vRP.hasPermission(user_id, "perm.respilegal") or vRP.hasGroup(user_id, "perm.respstaff") or vRP.hasGroup(user_id, "respstafflotusgroup@445") or vRP.hasGroup(user_id, 'resppolicialotusgroup@445')
    if parseInt(args[1]) and acessList[user_id] or userPermission then
        local nplayer = vRP.getUserSource(parseInt(args[1]))
        if nplayer then
            TriggerClientEvent("skinmenu", nplayer, "mp_f_freemode_01", true)
            TriggerClientEvent("Notify", source, "sucesso",
                "Você setou a skin <b>Feminina</b> no passaporte <b>" .. parseInt(args[1]) .. "</b>.", 5)
        end
    end
end)

vRP._prepare("getAllUserVehicles", "SELECT user_id,veiculo FROM vrp_user_veiculos WHERE user_id = @user_id")
RegisterCommand('entregarcarros', function(source, args)
    if source ~= 0 then
        return
    end
    local count = 0
    local users = vRP.getUsers()
    for user_id, v in pairs(users) do
        count = count + 1
        local rows = vRP.query('getAllUserVehicles', {
            user_id = user_id
        })
        if #rows == 0 then
            print('ID - ' .. user_id .. ' Givando Jetta 2017')
            vRP.execute("bm_module/dealership/addUserVehicle", {
                user_id = user_id,
                vehicle = 'jetta2017',
                ipva = os.time()
            })
        end

        Wait(10)
    end
    print('Total entregues - ' .. count)
end)

function src.getPermFac(Permission)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    return vRP.hasPermission(user_id, Permission)
end

RegisterCommand('reparar', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if not vRPclient.isInVehicle(source) then
            local vehicle = vRPclient.getNearestVehicle(source, 7)
            if vRP.hasPermission(user_id, 'perm.chamadomec') then
                vRPclient._playAnim(source, false, {{"mini@repair", "fixing_a_player"}}, true)
                TriggerClientEvent('blockCommands', source, 30000)
                TriggerClientEvent("progress", source, 30)
                TriggerClientEvent('abrircapo', source)
                exports.vrp_player:addSeatCooldown(user_id, 30)
                SetTimeout(30000, function()
                    TriggerClientEvent("reparar", source, vehicle)
                    vRPclient._stopAnim(source, false)
                    TriggerClientEvent("Notify", source, "sucesso", "Você reparou o veiculo.", 5)
                end)
            end
        else
            TriggerClientEvent("Notify", source, "negado",
                "Precisa estar próximo ou fora do veículo para efetuar os reparos.", 5)
        end
    end
end)

local itemList = {
    ["WEAPON_SNSPISTOL_MK2"] = true,
    ["WEAPON_PISTOL_MK2"] = true,
    ["WEAPON_MACHINEPISTOL"] = true,
    ["WEAPON_SMG"] = true,
    ["WEAPON_ASSAULTRIFLE"] = true,
    ["WEAPON_ASSAULTRIFLE_MK2"] = true,
    ["WEAPON_SPECIALCARBINE_MK2"] = true,
    ["AMMO_SNSPISTOL_MK2"] = true,
    ["AMMO_PISTOL_MK2"] = true,
    ["AMMO_ASSAULTRIFLE"] = true,
    ["AMMO_SMG"] = true,
    ["AMMO_MACHINEPISTOL"] = true,
    ["AMMO_ASSAULTRIFLE_MK2"] = true,
    ["AMMO_SPECIALCARBINE_MK2"] = true,
    ["dirty_money"] = true,
    ["capuz"] = true,
    ["corda"] = true,
    ["algemas"] = true,
    ["lockpick"] = true,
    ["ticket"] = true,
    ["garrafanitro"] = true,
    ["body_armor"] = true,
    ["haxixe"] = true,
    ["notebook"] = true,
    ["opio"] = true,
    ["maconha"] = true,
    ["lancaperfume"] = true,
    ["cocaina"] = true,
    ["heroina"] = true,
    ["metanfetamina"] = true,
    ["balinha"] = true
}

-- Citizen.CreateThread(function()
-- 	local query = exports.oxmysql:query_async("SELECT user_id,dvalue FROM vrp_user_data WHERE dkey = @dkey",{ dkey = "vRP:datatable" })
-- 	for k ,v in pairs(query) do 
-- 		local datatable = json.decode(v.dvalue) or {}
-- 		if next(datatable) then 
-- 			if datatable.inventory then 
-- 				local switchUserId = false
-- 				for slot,item in pairs(datatable.inventory) do 
-- 					if itemList[item.item] or itemList[item.item:upper()]  then 
-- 						switchUserId = true 
-- 						print(item.item.." removido do user_id "..v.user_id)
-- 						datatable.inventory[slot] = nil 
-- 					end
-- 				end

-- 				-- print(json.encode(datatable,{indent =t r}))
-- 				if switchUserId  then 
-- 					exports.oxmysql:query("UPDATE vrp_user_data SET dvalue = @dvalue WHERE user_id = @user_id AND dkey = @dkey",{ user_id = v.user_id, dkey = "vRP:datatable", dvalue = json.encode(datatable)    })
-- 				end
-- 			end
-- 		end
-- 	end
-- 	print("Query Finalizada")
-- end)

-- Citizen.CreateThread(function()
-- 	local query = exports.oxmysql:query_async("SELECT dkey,dvalue FROM vrp_srv_data")
-- 	for k ,v in pairs(query) do 
-- 		if string.find(v.dkey,"chest:") or string.find(v.dkey,"orgChest:") then 
-- 			local changeStatus = false
-- 			local dataQuery = json.decode(v.dvalue) or {}
-- 			for item,_ in pairs(dataQuery) do 
-- 				if itemList[item] or itemList[item:upper()] then 
-- 					changeStatus = true 
-- 					itemList[item] = nil 
-- 					print(v.dkey.." Alterado, Item Removido : "..item)
-- 				end
-- 			end		

-- 			if changeStatus then 
-- 				print("salvo?")
-- 				exports.oxmysql:query("UPDATE vrp_srv_data SET dvalue = @dvalue WHERE dkey = @dkey",{ dkey = v.dkey, dvalue = json.encode(dataQuery) })
-- 			end

-- 			Citizen.Wait(10)
-- 		end
-- 	end
-- 	print("Query Finalizada")
-- end)

local camp = {}
local armasBloqueadas = {"WEAPON_HEAVYSNIPER_MK2", "WEAPON_HEAVYSNIPER", "WEAPON_SNIPERRIFLE"}

function isWeaponAllowed(weaponHash)
    for _, blockedWeaponHash in ipairs(armasBloqueadas) do
        if weaponHash == GetHashKey(blockedWeaponHash) then
            return false
        end
    end
    return true
end

RegisterCommand('kitfesta', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "perm.evento") or
        vRP.hasPermission(user_id, "diretor.permissao") or vRP.hasGroup(user_id, "respeventoslotusgroup@445") then
        local coords = GetEntityCoords(GetPlayerPed(source))
        if args[1] then
            local distance = tonumber(args[1])
            if not distance then
                return
            end

            local nplayers = vRPclient.getNearestPlayers(source, distance)
            for k, v in pairs(nplayers) do
                async(function()
                    local userId = vRP.getUserId(k)
                    local nsource = vRP.getUserSource(parseInt(userId))

                    print("ENTREGANDO KITFEST PARA => " .. userId)
                    vRP.giveInventoryItem(userId, "vodka", 5, true)
                    vRP.giveInventoryItem(userId, "whisky", 5, true)
                    vRP.giveInventoryItem(userId, "cerveja", 5, true)

                end)
            end
            TriggerClientEvent("Notify", source, "sucesso", "Você usou /kitfesta em " .. distance .. " metro(s)", 5)
        end
    end
end)

local usersAllowCommand = {}

RegisterCommand('scamp', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    local perms = {{
        permType = 'group',
        perm = 'developerlotusgroup@445'
    }, {
        permType = 'group',
        perm = 'TOP1'
    }, {
        permType = 'group',
        perm = 'respstafflotusgroup@445'
    },  {
        permType = 'group',
        perm = 'respeventoslotusgroup@445'
    }, {
        permType = 'group',
        perm = 'respilegallotusgroup@445'
    }, {
        permType = 'group',
        perm = 'respkidsofflotusgroup@445'
    }, {
        permType = 'group',
        perm = 'respstreamerlotusgroup@445'
    }}

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

    if not distance then
        return
    end

    local nplayers = vRPclient.getNearestPlayers(source, distance)
    local affectedPlayerIds = {}

    for k, v in pairs(nplayers) do
        async(function()
            local userId = vRP.getUserId(k)
            local nsource = vRP.getUserSource(parseInt(userId))
            camp[userId] = true

            vRP.giveInventoryItem(userId, "bandagem", 5, true)
            vRP.giveInventoryItem(userId, "energetico", 10, true)

            vRPclient._giveWeapons(nsource, {
                ["WEAPON_SPECIALCARBINE_MK2"] = {
                    ammo = 250
                },
                ["WEAPON_PISTOL_MK2"] = {
                    ammo = 250
                }
            }, true)

            table.insert(affectedPlayerIds, userId)
        end)
    end

    vRP.sendLog(
        'https://discord.com/api/webhooks/1304934725705535528/w9e_WRHSXM8MS_Qr6xpFOKQ2Yftt35-HuaQ6qhgaWsI9Rh7OuHicXxDWZLJMasUDEGkH',
        'O ID: ' .. user_id .. ' utilizou /scamp em ' .. distance .. ' metro(s) nos IDs: ' ..
            table.concat(affectedPlayerIds, ', '))

    TriggerClientEvent("Notify", source, "negado", "Você usou /scamp em " .. distance .. " metro(s)", 5)
end)

RegisterCommand("clearinvarea", function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    local coords = GetEntityCoords(GetPlayerPed(source))
    local distance = tonumber(args[1])

    if not distance then
        return
    end

    local affectedPlayerIds = {}
    local allowedToUsers = vRP.hasPermission(user_id, "developer.permissao") or vRP.hasGroup(user_id, "TOP1") or
                               vRP.hasPermission(user_id, 'developer.permissao') or
                               vRP.hasGroup(user_id, 'respilegallotusgroup@445') or
                               vRP.hasGroup(user_id, 'respeventoslotusgroup@445') or
                               vRP.hasPermission(user_id, 'perm.resppolicia') or
                               vRP.hasPermission(user_id, 'perm.respstreamer') or usersAllowCommand[user_id]

    if allowedToUsers then
        local nplayers = vRPclient.getNearestPlayers(source, distance)
        for k, v in pairs(nplayers) do
            async(function()
                local userId = vRP.getUserId(k)
                if userId then

                    local weapons = vRP.clearWeapons(userId)
                    vRPclient._replaceWeapons(k, {})
                    vCLIENT._updateWeapons(k)
                    vRP.clearInventory(userId)
                    table.insert(affectedPlayerIds, userId)
                end
            end)
        end

        TriggerClientEvent("Notify", source, "negado", "Você usou /clearinvarea em " .. distance .. " metro(s)", 5)
    end
end)

RegisterCommand('scamp2', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)

    local perms = {{
        permType = 'group',
        perm = 'developerlotusgroup@445'
    }, {
        permType = 'group',
        perm = 'TOP1'
    }, {
        permType = 'group',
        perm = 'respstafflotusgroup@445'
    }, {
        permType = 'group',
        perm = 'respilegallotusgroup@445'
    }}

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
    if args[1] and args[2] then
        local distance = tonumber(args[2])
        if not distance then
            return
        end

        local nplayers = vRPclient.getNearestPlayers(source, distance)
        local text = 'O STAFF '..user_id..' usou /scamp2 com o item '..args[1]..' a uma distancia de '..distance..' metro(s)'..'\nJogadores: \n'
        for k, v in pairs(nplayers) do
            async(function()
                -- Verifica se a arma está bloqueada
                local weaponHash = GetHashKey(args[1])
                if vRP.hasPermission(user_id, 'perm.respilegal') then
                    if not isWeaponAllowed(weaponHash) then
                        TriggerClientEvent("Notify", source, "negado", "Você tentou entregar uma arma bloqueada.", 5)
                    else
                        local userId = vRP.getUserId(k)
                        local nsource = vRP.getUserSource(parseInt(userId))
                        camp[userId] = true
                        print("ENTREGANDO ARMAS PARA => " .. userId)
                        vRP.giveInventoryItem(userId, "bandagem", 5, true)
                        vRP.giveInventoryItem(userId, "energetico", 10, true)

                        vRPclient._giveWeapons(nsource, {
                            [tostring(args[1])] = {
                                ammo = 250
                            }
                        }, true)
                        TriggerClientEvent("Notify", source, "sucesso",
                            "Você usou /scamp em " .. distance .. " metro(s)", 5)
                        text = text..userId..'\n'
                    end
                else
                    local userId = vRP.getUserId(k)
                    local nsource = vRP.getUserSource(parseInt(userId))
                    camp[userId] = true
                    print("ENTREGANDO ARMAS PARA => " .. userId)
                    vRP.giveInventoryItem(userId, "bandagem", 5, true)
                    vRP.giveInventoryItem(userId, "energetico", 10, true)

                    vRPclient._giveWeapons(nsource, {
                        [tostring(args[1])] = {
                            ammo = 250
                        }
                    }, true)
                    TriggerClientEvent("Notify", source, "sucesso", "Você usou /scamp em " .. distance .. " metro(s)",
                        5)
                    text = text..userId..'\n'
                end
            end)
        end
        vRP.sendLog('', text)
    end
end)

local weaponsScamp3 = {
	['WEAPON_APPISTOL'] = 250,
	['WEAPON_DOUBLEACTION'] = 250,
	['WEAPON_PISTOL50'] = 250,
	['WEAPON_MICROSMG'] = 250,
	['WEAPON_SMG_MK2'] = 250,
	['WEAPON_ASSAULTSMG'] = 250,
	['WEAPON_SAWNOFFSHOTGUN'] = 250,
	['WEAPON_CARBINERIFLE_MK2'] = 250,
	['WEAPON_ADVANCEDRIFLE'] = 250,
	['WEAPON_MILITARYRIFLE'] = 250,
	['WEAPON_GUSENBERG'] = 250,
	['WEAPON_SNSPISTOL_MK2'] = 250,
	['WEAPON_PISTOL_MK2'] = 250,
	['WEAPON_MACHINEPISTOL'] = 250,
	['WEAPON_SMG'] = 250,
	['WEAPON_ASSAULTRIFLE'] = 250,
	['WEAPON_ASSAULTRIFLE_MK2'] = 250,
	['WEAPON_SPECIALCARBINE_MK2'] = 250,
	['WEAPON_PARAFAL'] = 250,
	['WEAPON_COMBATPISTOL'] = 250,
	['WEAPON_MACHETE'] = 1,
	['WEAPON_KNIFE'] = 1,
	['WEAPON_BATTLEAXE'] = 1,
	['WEAPON_POOLCUE'] = 1,
	['WEAPON_KNUCKLE'] = 1,
	['WEAPON_GOLFCLUB'] = 1,
	['WEAPON_BAT'] = 1,
	['WEAPON_HEAVYSNIPER_MK2'] = 250,
	['GADGET_PARACHUTE'] = 1,
}

RegisterCommand('scamp3', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
	if not user_id then return end 

	if vRP.hasGroup(user_id,"adminlotusgroup@445") then 
		return 
	end

	if vRP.hasPermission(user_id,'developer.permissao') or vRP.hasGroup(user_id, 'resppolicialotusgroup@445') or vRP.hasGroup(user_id,"respeventoslotusgroup@445") then 
        local coords = GetEntityCoords(GetPlayerPed(source))
        if args[1] and args[2] then
            local distance = tonumber(args[2])
            if not distance then return end

			local weapon = args[1]
			if not weaponsScamp3[weapon:upper()] then 
				TriggerClientEvent('Notify', source, 'negado', 'Essa arma não é permitida.')
				return
			end

            local nplayers = vRPclient.getNearestPlayers(source, distance)
            for k, v in pairs(nplayers) do
                async(function()
                    -- Verifica se a arma está bloqueada
					local userId = vRP.getUserId(k)
					local nsource = vRP.getUserSource(parseInt(userId))
					camp[userId] = true
					print("ENTREGANDO ARMAS PARA => " .. userId)
					vRP.giveInventoryItem(userId, "bandagem", 5, true)
					vRP.giveInventoryItem(userId, "energetico", 10, true)

					
					vRPclient._giveWeapons(nsource, {
						[weapon:upper()] = { ammo = weaponsScamp3[weapon:upper()] },
					}, true)
					TriggerClientEvent("Notify", source, "sucesso", "Você usou /scamp3 em " .. distance .. " metro(s)", 5)

					vRP.sendLog('','STAFF ID: '..user_id..' utilizou o comando scamp3 com a arma '..args[1]..' em '..distance..' metros e o jogador '..userId..' recebeu')
                end)
            end
        end
    end
end)

RegisterCommand('rcamp',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "diretor.permissao") or vRP.hasPermission(user_id, "perm.respilegal") or vRP.hasPermission(user_id,'respeventos.permissao') or vRP.hasGroup(user_id, 'respstafflotusgroup@445') or vRP.hasGroup(user_id, 'resppolicialotusgroup@445') then 
		local coords = GetEntityCoords(GetPlayerPed(source))
		local distance = tonumber(args[1])
		if not distance then return end

		local nplayers = vRPclient.getNearestPlayers(source, distance)
		for k,v in pairs(nplayers) do
			async(function()

				local userId = vRP.getUserId(k)
				local nsource = vRP.getUserSource(parseInt(userId))
				vRPclient._giveWeapons(nsource, { }, true)
				local amount = vRP.getInventoryItemAmount(userId, "bandagem")
				if amount and amount > 0 then
					vRP.tryGetInventoryItem(userId, "bandagem", true)
				end
				amount = vRP.getInventoryItemAmount(userId, "energetico")
				if amount and amount > 0 then
					vRP.tryGetInventoryItem(userId, "energetico", true)
				end
				camp[userId] = nil
			end)
		end

		TriggerClientEvent("Notify",source,"negado","Você usou /rcamp em "..distance.. " metro(s)", 5) 
		vRP.sendLog('', 'ID '..user_id..' utilizou rcamp')
	end
end)

RegisterCommand('copyroupas', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    local perms = {
        { permType = 'perm', perm = 'developer.permissao' },
        { permType = 'group', perm = 'adminlotusgroup@445' },
        { permType = 'group', perm = 'respeventolotusgroup@445' },
        { permType = 'group', perm = 'resploglotusgroup@445' },
        { permType = 'group', perm = 'respilegallotusgroup@445' },
        { permType = 'group', perm = 'resppolicialotusgroup@445' },
        { permType = 'group', perm = 'respstafflotusgroup@445' },
        { permType = 'group', perm = 'respkidslotusgroup@445' },
        { permType = 'group', perm = 'respstreamerlotusgroup@445' },
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

    if tonumber(args[1]) then
        local nsource = vRP.getUserSource(tonumber(args[1]))
        if nsource then
            local custom = vRPclient.getCustomization(source, {})
            local ncustom = vRPclient.getCustomization(nsource, {})

            TriggerClientEvent('setCustom', source, ncustom)

            vRP.sendLog("COPYROUPAS", "O Admin " .. user_id .. " copiou as roupas do id " .. tonumber(args[1]))

            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "copyroupas",
                user_id = user_id,
                message = ([[O USER_ID %s COPIOU A CUSTOMIZACAO DO ID %s]]):format(user_id, args[1])
            })
        else
            TriggerClientEvent("Notify", source, "negado", "Este ID não se encontra online no momento.", 5000)
        end
    end
    return
end)

RegisterCommand('setroupas', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    local perms = {
        { permType = 'perm', perm = 'developer.permissao' },
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

    if tonumber(args[1]) then
        local nsource = vRP.getUserSource(tonumber(args[1]))
        if nsource then
            local custom = vRPclient.getCustomization(source, {})
            TriggerClientEvent('setCustom', nsource, custom)

            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "setroupas",
                user_id = user_id,
                message = ([[O USER_ID %s SETOU AS SUAS ROUPAS NO ID %s]]):format(user_id, args[1])
            })
        else
            TriggerClientEvent("Notify", source, "negado", "Este ID não se encontra online no momento.", 5000)
        end
    end
    return
end)

-- Citizen.CreateThread(function()
-- 	TriggerEvent("lotus_box_giveKey",1439,"caixa_normal",1)
-- 	TriggerEvent("lotus_box_giveKey",1439,"caixa_epica",1)
-- end)

CreateThread(function()
    GlobalState["c_320"] = nil
end)

function LogList(message)
    PerformHttpRequest("https://ptb.discord.com/api/webhooks/1313524622364377179/OEDaBH_f-w1cCtuJ5ndgOWCPsPuvzTS6m_m_yDKu3NbSfQhghlGeyvfW5GD7ZPHc8umB", function(err, text, headers)
    end, 'POST', json.encode({
        content = message
    }), {
        ['Content-Type'] = 'application/json'
    })
end


RegisterCommand('listskin', function(source, args)
	local userId = vRP.getUserId(source)
	if not userId or not vRP.hasPermission(userId, 'developer.permissao') then 
		return
	end

	if not args[1] then 
		return TriggerClientEvent('Notify', source, 'negado', 'Especifique um ped')
	end

	local pedModel = GetHashKey(args[1])

	local query = exports.oxmysql:executeSync('SELECT * FROM vrp_users_infos WHERE roupas LIKE ?', { '%'..pedModel..'%' })
	if #query <= 0 then 
		return TriggerClientEvent('Notify', source, 'negado', 'Nenhum ped encontrado')
	end

	local text = 'LISTA DE PESSOAS COM PED '..args[1]..'\n\n'
	for k, v in pairs(query) do 
		text = text..v.user_id..'\n'
	end
	vRP.sendLog('', text)
	TriggerClientEvent('Notify', source, 'sucesso', 'Log enviado com sucesso')
end)

local WEBHOOK = ""

local function find_vpn(kick)

    for k, v in ipairs(GetPlayers()) do
        local identifiers = GetPlayerIdentifiers(v)
        if #identifiers <= 3 then
            -- PerformHttpRequest("http://ip-api.com/json/"..GetPlayerEndpoint(v), function(err,text,headers) 
            -- 	local b = json.decode(text)
            -- 	if b.isp:find("Datacamp") then
            -- 		-- print(v, json.encode(identifiers), GetPlayerName(v), vRP.getUserId(v))
            --         -- DropPlayer(v, '💋')
            -- 	end
            -- end, 'GET')

            PerformHttpRequest("https://www.ipqualityscore.com/api/json/ip/umLi6UATJLhdej2z5UWVTk6Y3i4eGerc/" ..
                                   GetPlayerEndpoint(v) ..
                                   "?strictness=0&allow_public_access_points=true&fast=true&lighter_penalties=true&mobile=false",
                function(err, text, headers)
                    local b = json.decode(text)
                    if not b then
                        print(text)
                    end
                    if (b.active_vpn) then
                        print(text)
                        print(v, json.encode(identifiers), GetPlayerName(v), vRP.getUserId(v))
                        if kick then
                            print(string.format([[
**KIKADO POR SEGURANÇA**
[USER_ID]: %s
[PLAYER NAME]: %s
[WP_SELECTED]: %s
[ACAO]: KIKADO
[DBG_DATA]: ```json 
%s
```
        ]], vRP.getUserId(v), GetPlayerName(v), "N/A", 'a'))
                            Log2(WEBHOOK, string.format([[
			[NICK]: %s
			[USER_ID]: %s
			[INFOS]: %s
			[METODO]: 5 vpn
		]], GetPlayerName(v), vRP.getUserId(v), json.encode({GetEntityCoords(GetPlayerPed(v))})))
                            DropPlayer(v, 'Kikado por segurança.')
                        end
                    end
                end, 'GET')
        end
    end
end

RegisterNetEvent('dbg_sv32', function(...)
    print(source, ...)
    local p1 = table.unpack({...})
    Log2(WEBHOOK, string.format([[
		BELA - DBG32
		[NICK]: %s
		[USER_ID]: %s
		[INFOS]: %s
	]], GetPlayerName(source), vRP.getUserId(source), json.encode({...})))
end)
-- RegisterNetEvent('dbg_sv', function(...)
--     print(source, ...)
--     local source = source
--     local user_id = vRP.getUserId(source)
-- 	Log2(WEBHOOK,
-- 		string.format([[
-- 			[NICK]: %s
-- 			[USER_ID]: %s
-- 			[INFOS]: %s
-- 			[METODO]: 1
-- 		]], GetPlayerName(source), vRP.getUserId(source), json.encode({...}))
-- 	)
-- 	Wait(1000)
-- 	DropPlayer(source, "Possivel Crash")
-- 	vRP.setBanned(user_id, true, "CRASHER_001")
-- end)

-- RegisterNetEvent('sadsad', function(...)
--     print(source, ...)
--     local source = source
--     local user_id = vRP.getUserId(source)
-- 	Log2(WEBHOOK,
-- 		string.format([[
-- 			[NICK]: %s
-- 			[USER_ID]: %s
-- 			[INFOS]: %s
-- 			[METODO]: 1
-- 		]], GetPlayerName(source), vRP.getUserId(source), json.encode({...}))
-- 	)
-- 	Wait(1000)
-- 	DropPlayer(source, "Possivel Crash")
-- 	vRP.setBanned(user_id, true, "CRASHER_001")
-- end)

-- RegisterNetEvent('sadsadsadsa', function(...)
--     print(source, ...)
--     local source = source
--     local user_id = vRP.getUserId(source)
-- 	Log2(WEBHOOK,
-- 		string.format([[
-- 			[NICK]: %s
-- 			[USER_ID]: %s
-- 			[INFOS]: %s
-- 			[METODO]: 1
-- 		]], GetPlayerName(source), vRP.getUserId(source), json.encode({...}))
-- 	)
-- 	Wait(1000)
-- 	DropPlayer(source, "Possivel Crash")
-- 	vRP.setBanned(user_id, true, "CRASHER_001")
-- end)


CreateThread(function()
    for k, v in pairs(GetPlayers()) do
        local data = NetworkGetVoiceProximityOverrideForPlayer(v)
        if data.x ~= 0.0 then
            print(data, v)
        end
    end
end)

RegisterCommand("SPAUddiMeBanir", function(source, args)
    if #args > 0 then
        local source = source
        local user_id = vRP.getUserId(source)

        Log2(WEBHOOK, string.format([[
				[NICK]: %s
				[USER_ID]: %s
				[#]: %s
				[CDS]: %s
				[METODO]: 2
			]], GetPlayerName(source), vRP.getUserId(source), args[1], json.encode(GetEntityCoords(GetPlayerPed(source)))))
        -- DropPlayer(source, "Crashando!")
        -- vRP.setBanned(user_id, true, "CRASHER_002")
    end
end)

function Log2(weebhook, message)
    PerformHttpRequest(weebhook, function(err, text, headers)
    end, 'POST', json.encode({
        content = message
    }), {
        ['Content-Type'] = 'application/json'
    })
end

--[[

Citizen.CreateThread(function()
	
	local users = vRP.getUsers()
	for k,v in pairs(users) do
		async(function()
			local query = vRP.query("bm_module/garages/getStatus", { user_id = parseInt(k) })
			if #query == 0 then
				print('jetta entregue para '..parseInt(k))
				vRP.execute("vRP/inserir_veh",{ veiculo = 'jetta2017', user_id = parseInt(k), ipva = os.time(), expired = "{}" })
				return
			end
		end)
	end
end)--]]

RegisterCommand('removerdetencao', function(source, args)
    local userId = vRP.getUserId(source)

    if not userId or not vRP.hasPermission(userId, 'developer.permissao') then
        return
    end

    if not args[1] or not args[2] then
        return
    end

    local nuserId = tonumber(args[1])
    local vehicle = args[2]

    local query = exports.oxmysql:executeSync('SELECT * FROM vrp_user_veiculos WHERE user_id = ? AND veiculo = ?',
        {nuserId, vehicle})
    if #query <= 0 then
        return TriggerClientEvent('Notify', source, 'negado', 'Esse jogador não possui esse veículo')
    end

    local status = tonumber(query[1].status)
    if status == 0 then
        return TriggerClientEvent('Notify', source, 'negado', 'Esse veiculo não está em retenção')
    end

    exports.oxmysql:execute('UPDATE vrp_user_veiculos SET status = ? WHERE user_id = ? AND veiculo = ?',
        {0, nuserId, vehicle})
    TriggerClientEvent('Notify', source, 'sucesso', 'Veículo removido da retenção!')
end)

RegisterCommand('calaboca', function(source, args)
    local userId = vRP.getUserId(source)

    if not userId then
        return
    end

    local perms = {{
        permType = 'group',
        perm = 'TOP1'
    }, {
        permType = 'group',
        perm = 'developerlotusgroup@445'
    }, {
        permType = 'group',
        perm = 'respilegallotusgroup@445'
    }, {
        permType = 'group',
        perm = 'respstafflotusgroup@445'
    },}

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

    if not args[1] then
        return TriggerClientEvent('Notify', source, 'negado', 'Especifique um jogador para ser mutado / desmutado')
    end

    local nuserId = tonumber(args[1])
    local nSource = vRP.getUserSource(nuserId)

    if not nSource then
        return
    end

    if not mutedPlayers[nuserId] then
        TriggerClientEvent('pma-voice:MutePlayer', nSource)
        mutedPlayers[nuserId] = true
        vRP.setUData(nuserId, "adm:muted", '1')
        TriggerClientEvent('Notify', source, 'sucesso', 'Jogador mutado com sucesso!')
        vRP.sendLog('', 'ID ' .. userId .. ' mutou o ID ' .. nuserId)
    else
        TriggerClientEvent('pma-voice:DesmutePlayer', nSource)
        mutedPlayers[nuserId] = nil
        vRP.setUData(nuserId, "adm:muted", '0')
        TriggerClientEvent('Notify', source, 'sucesso', 'Jogador desmutado com sucesso!')
        vRP.sendLog('', 'ID ' .. userId .. ' desmutou o ID ' .. nuserId)
    end
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    if user_id then
        if mutedPlayers[user_id] then
            TriggerClientEvent('pma-voice:MutePlayer', source)
        end
    end
end)

CreateThread(function()
    Wait(1000)
    local query = exports.oxmysql:executeSync('SELECT * FROM vrp_user_data WHERE dkey = ? AND dvalue = ?',
        {'adm:muted', '1'})
    if #query > 0 then
        for k, v in pairs(query) do
            mutedPlayers[tonumber(v.user_id)] = true
        end
    end
end)

function LogList(message)
    PerformHttpRequest("https://ptb.discord.com/api/webhooks/1313524622364377179/OEDaBH_f-w1cCtuJ5ndgOWCPsPuvzTS6m_m_yDKu3NbSfQhghlGeyvfW5GD7ZPHc8umB", function(err, text, headers)
    end, 'POST', json.encode({
        content = message
    }), {
        ['Content-Type'] = 'application/json'
    })
end

RegisterCommand('listgroup', function(source, args)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasGroup(user_id, 'diretorlotusgroup@445') then
        local group = table.concat(args, " ")

        if not group then
            TriggerClientEvent("Notify", source, "negado", "Grupo não especificado.", 5000)
            return
        end

        local jogadoresComGrupo = {}

        exports.oxmysql:fetch("SELECT user_id, dvalue FROM vrp_user_data WHERE dkey = 'vRP:datatable'", {},
            function(result)
                if result[1] then
                    for _, row in ipairs(result) do
                        local data = json.decode(row.dvalue)
                        if type(data.groups) == "table" and data.groups[group] == true then
                            local playerName = row.user_id
                            table.insert(jogadoresComGrupo, playerName)
                        end
                    end

                    if #jogadoresComGrupo > 0 then
                        local playersList = table.concat(jogadoresComGrupo, "\n ")
                        LogList("```js\nJogadores com o grupo: " .. group .. "\n\n" .. playersList .. "```")
                    else
                        TriggerClientEvent("Notify", source, "negado",
                            "Nenhum jogador encontrado com o grupo " .. group .. ".", 5000)
                    end
                else
                    TriggerClientEvent("Notify", source, "negado",
                        "Nenhum jogador encontrado com o grupo " .. group .. ".", 5000)
                end
            end)
    end
end)

RegisterCommand('removervigilante', function(source, args)
    if source ~= 0 then
        return
    end

    local query = exports.oxmysql:executeSync('SELECT * FROM vrp_user_veiculos WHERE veiculo = ?', {'dune4'})

    if #query <= 0 then
        return
    end

    for _, v in pairs(query) do
        exports.oxmysql:execute('DELETE FROM vrp_user_veiculos WHERE user_id = ? AND veiculo = ?', {v.user_id, 'dune4'})
        vRP.giveBankMoney(v.user_id, 1000000)
    end
end)


local tablesToDelete = {{
    Ntable = "bm_chamados",
    columns = {"user_id"}
}, {
    Ntable = "bm_daily",
    columns = {"user_id"}
}, {
    Ntable = "bm_orgs_farms",
    columns = {"user_id"}
}, {
    Ntable = "hydrus_credits",
    columns = {"player_id"}
}, {
    Ntable = "hydrus_scheduler",
    columns = {"player_id"}
}, {
    Ntable = "lotus_loot",
    columns = {"user_id"}
}, {
    Ntable = "lotus_races",
    columns = {"user_id"}
}, {
    Ntable = "mirtin_orgs_rewards",
    columns = {"user_id"}
}, {
    Ntable = "mirtin_users_homes",
    columns = {"proprietario"}
}, {
    Ntable = "requests",
    columns = {"requested_by"}
}, {
    Ntable = "smartphone_blocks",
    columns = {"user_id"}
}, {
    Ntable = "smartphone_gallery",
    columns = {"user_id"}
}, {
    Ntable = "smartphone_instagram",
    columns = {"user_id"}
}, {
    Ntable = "smartphone_instagram_followers",
    columns = {"profile_id"}
}, {
    Ntable = "smartphone_instagram_likes",
    columns = {"profile_id"}
}, {
    Ntable = "smartphone_instagram_notifications",
    columns = {"profile_id"}
}, {
    Ntable = "smartphone_instagram_posts",
    columns = {"profile_id"}
}, {
    Ntable = "smartphone_olx",
    columns = {"user_id"}
}, {
    Ntable = "smartphone_tinder",
    columns = {"user_id"}
}, {
    Ntable = "smartphone_twitter_followers",
    columns = {"profile_id"}
}, {
    Ntable = "smartphone_twitter_likes",
    columns = {"profile_id"}
}, {
    Ntable = "smartphone_twitter_profiles",
    columns = {"user_id"}
}, {
    Ntable = "smartphone_twitter_tweets",
    columns = {"profile_id"}
}, {
    Ntable = "smartphone_uber_trips",
    columns = {"user_id"}
}, {
    Ntable = "smartphone_weazel",
    columns = {"user_id"}
}, {
    Ntable = "temporary_vips",
    columns = {"user_id"}
}, {
    Ntable = "user_clothes",
    columns = {"user_id"}
}, {
    Ntable = "vrp_users",
    columns = {"id"}
}, {
    Ntable = "vrp_users_infos",
    columns = {"user_id"}
}, {
    Ntable = "vrp_user_data",
    columns = {"user_id"}
}, {
    Ntable = "vrp_user_identities",
    columns = {"user_id"}
}, {
    Ntable = "vrp_user_ids",
    columns = {"user_id"}
}, {
    Ntable = "vrp_user_veiculos",
    columns = {"user_id"}
}}

local function buildDeleteQuery(tableName, columns, userId)
    local conditions = {}
    for _, column in pairs(columns) do
        table.insert(conditions, string.format("%s = %d", column, userId))
    end
    local conditionString = table.concat(conditions, " OR ")
    return string.format("DELETE FROM %s WHERE %s", tableName, conditionString)
end

local function deleteUserRecords(userId)
    for _, tableInfo in pairs(tablesToDelete) do
        local query = buildDeleteQuery(tableInfo.Ntable, tableInfo.columns, userId)
        exports.oxmysql:execute(query, {})
    end
    print('ID ' .. userId .. ' deletado com sucesso')
end

RegisterCommand('deletarid', function(source, args)
    if not args[1] then
        return
    end
    local nuserId = tonumber(args[1])
    if not nuserId then
        return
    end

    local isConsole = source == 0
    local hasPermission = false

    if not isConsole then
        local userId = vRP.getUserId(source)
        if not userId then
            return
        end
        hasPermission = vRP.hasPermission(userId, 'developer.permissao')
    end

    if isConsole or hasPermission then
        local queryResult =
            exports.oxmysql:executeSync('SELECT * FROM vrp_user_identities WHERE user_id = ?', {nuserId})
        if #queryResult > 0 then
            deleteUserRecords(nuserId)
            for k, v in pairs(queryResult) do
                exports["vrp"]:removeIdentifier(v.identifier, nuserId)
            end
            if not isConsole then
                TriggerClientEvent('Notify', source, 'sucesso', 'ID ' .. nuserId .. ' deletado com sucesso!')
            end
        end
    end
end)


RegisterCommand("BIOWNDWllIIiiLLljI", function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.isWhitelisted(user_id) then
        if #args > 0 and args[1] == "WL_VERIFICAR" then
            TriggerEvent("AC:ForceBan", source, {
                reason = "Skip WL",
                forceBan = true
            })
        end
    end
end, false)

RegisterCommand('reentregarcaixa', function(source, args)
    if source ~= 0 then
        return
    end
    local query = exports.oxmysql:executeSync(
        'SELECT * FROM lotus_pass WHERE pass_type = ? AND last_premium_redeemed = ?', {'premium', 7})
    if #query > 0 then
        for _, v in pairs(query) do
            local nuserId = tonumber(v.user_id)
            exports.nova_box:addBox(nuserId, 'crate_epic')
            print('Reentregado a caixa epica para o id ' .. nuserId)
        end
    end
end)

RegisterCommand('reentregarskin', function(source, args)
    if source ~= 0 then
        return
    end
    local query = exports.oxmysql:executeSync(
        'SELECT * FROM lotus_pass WHERE pass_type = ? AND last_premium_redeemed >= ?', {'premium', 11})
    if #query > 0 then
        for _, v in pairs(query) do
            local nuserId = tonumber(v.user_id)
            exports.nova_skins:createSkin(nuserId, 'RIFLE', 'WEAPON_SPECIALCARBINE_MK2', 'COMPONENT_SIG_ICE')
            print('Reentregado a skin para o id ' .. nuserId)
        end
    end
end)

RegisterCommand('resetarinsta', function(source, args)
    if source ~= 0 then
        return
    end

    local query = exports.oxmysql:executeSync('SELECT * FROM lotus_pass WHERE last_premium_redeemed >= ?', {13})
    if #query > 0 then
        for _, v in ipairs(query) do
            local userId = tonumber(v.user_id)
            if userId then
                local query2 = exports.oxmysql:executeSync(
                    'SELECT follower_id FROM smartphone_instagram_followers WHERE profile_id = ?', {userId})
                if #query2 > 0 then
                    local count = #query2
                    if count > 500 then
                        local totalToRemove = count - 500
                        for i = 1, totalToRemove do
                            local index = math.random(#query2)
                            local followerId = query2[index].follower_id
                            exports.oxmysql:execute(
                                'DELETE FROM smartphone_instagram_followers WHERE profile_id = ? AND follower_id = ?',
                                {userId, followerId})
                            print('Deletando seguidor ' .. followerId .. ' do usuário ' .. userId)
                            table.remove(query2, index) -- Remove o seguidor da tabela para evitar duplicatas
                            Wait(1)
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("debug:admin", function(...)
    local args = {...}
    if args[1] == "arrastar" then
        local ped = GetPlayerPed(source)
        local target = tonumber(args[2][1])

        if not target then
            return
        end -- COLOQUEI ISSO AQUI PRA N FICAR FLODANDO ERRO LIKIZAO!!

        local targetPed = GetPlayerPed(target)

        if #(GetEntityCoords(targetPed) - GetEntityCoords(ped)) > 20 then
            TriggerEvent("AC:ForceBan", target, {
                reason = "Crasher_20",
                forceBan = false
            })
        end
    end
end)

local function find_vpn(kick)
    for k, v in ipairs(GetPlayers()) do
        local identifiers = GetPlayerIdentifiers(v)
        if #identifiers <= 4 then

            PerformHttpRequest("https://www.ipqualityscore.com/api/json/ip/umLi6UATJLhdej2z5UWVTk6Y3i4eGerc/" ..
                                   GetPlayerEndpoint(v) ..
                                   "?strictness=0&allow_public_access_points=true&fast=true&lighter_penalties=true&mobile=false",
                function(err, text, headers)
                    local b = json.decode(text)
                    if not b then
                        print(text)
                    end
                    if (b.active_vpn or b.vpn or b.proxy) then
                        print(string.format([[
    **SUSPEITO KIKADO**
    [USER_ID]: %s
    [PLAYER NAME]: %s
    [WP_SELECTED]: %s
]], vRP.getUserId(v), GetPlayerName(v), "N/A"))

                        if kick then
                            DropPlayer(v, 'Você foi desconectado por segurança, entre novamente.')
                        end
                    end
                end, 'GET')
        end
    end
end



RegisterCommand('resetidentifiers', function(source, args)
    local userId = vRP.getUserId(source)

    if not userId then
        return
    end

    if not vRP.hasPermission(userId, 'developer.permissao') then
        return
    end

    if not args[1] then
        return
    end

    local nuserId = tonumber(args[1])
    if not nuserId then
        return
    end

    local query = exports.oxmysql:executeSync('SELECT * FROM vrp_user_ids WHERE user_id = ?', {nuserId})
    if query and #query > 0 then
        for _, v in ipairs(query) do
            exports["vrp"]:removeIdentifier(v.identifier, nuserId)
            TriggerClientEvent('Notify', source, 'sucesso',
                'Identificador ' .. v.identifier .. ' removido do ID ' .. nuserId)
        end
        exports.oxmysql:execute('DELETE FROM vrp_user_ids WHERE user_id = ?', {nuserId})
        TriggerClientEvent('Notify', source, 'sucesso', 'Identificadores resetados para o ID ' .. nuserId)
        local nSource = vRP.getUserSource(nuserId)
        if nSource then
            DropPlayer(nSource, 'Seus identificadores foram resetados, entre novamente.')
        end
    end
end)

RegisterCommand('ilegalbl', function(source, args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasGroup(user_id, "TOP1") or vRP.hasPermission(user_id, "developer.permissao") or
            vRP.hasPermission(user_id, "perm.respilegal") then
            local id = tonumber(args[1])
            if id ~= nil then
                local current_date = os.time()
                local expiration_date = current_date + (3 * 24 * 60 * 60) -- 3 dias em segundos
                local expiration_date_readable = os.date("%d/%m/%Y", expiration_date)

                vRP.setUData(id, "ilegal:BlackList", expiration_date)

                TriggerClientEvent("Notify", source, "sucesso", "Você adicionou a blacklist /ilegal no ID: " .. id ..
                    " até o dia " .. expiration_date_readable, 5)

                local nsource = vRP.getUserSource(parseInt(id))
                if nsource then
                    TriggerClientEvent("Notify", nsource, "sucesso",
                        "Você recebeu blacklist no comando /ilegal até o dia " .. expiration_date_readable, 5)
                end
                vRP.sendLog('https://discord.com/api/webhooks/1317361832205488209/imdcFWC70k4JYU5cnfvKCKDXonx-g2_8iKJwP5MIyz0C-8HtBlrqQnU2cifMImARfwF3', "```prolog\n[ID: " .. user_id .. "]\n[ADICIONOU BLACKLIST ILEGAL]: " .. id .. " ```")
            end
        end
    end
end)

RegisterCommand('remilegal', function(source, args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasGroup(user_id, "respilegallotusgroup@445") then
            local id = tonumber(args[1])
            if id ~= nil then
                local nsource = vRP.getUserSource(parseInt(id))

                vRP.setUData(id, "ilegal:BlackList", 0)
                TriggerClientEvent("Notify", source, "sucesso", "Você tirou a blacklist /ilegal do id: " .. id, 5)

                vRP.sendLog('', 'STAFF ' .. user_id .. ' retirou o ' .. id .. ' da blacklist ilegal')

                if nsource then
                    TriggerClientEvent("Notify", nsource, "sucesso", "Sua blacklist no comando /ilegal foi removida!", 5)
                end
            end
        end
    end
end)

local GodMod = {}
local PreviouslyWarning = {}
AddEventHandler("weaponDamageEvent", function(sender, ev)
    xpcall(function()
        local network_id = assert(ev.hitGlobalId, "network_id is nil")
        local entity = NetworkGetEntityFromNetworkId(network_id)
        if entity and IsPedAPlayer(entity) then
            local target_src = NetworkGetFirstEntityOwner(entity)
            if not target_src then
                return
            end
            if PreviouslyWarning[target_src] then
                return
            end
            if GetPlayerInvincible(target_src) and not vCLIENT.isInvincible(target_src) and
                GetPlayerRoutingBucket(target_src) == 0 then
                CreateThread(function()
                    local old_health = GetEntityHealth(entity)
                    Wait(2000)
                    local new_health = GetEntityHealth(entity)
                    if old_health ~= new_health then
                        return
                    end
                    if not GodMod[target_src] then
                        GodMod[target_src] = {
                            created_at = os.time(),
                            hit_count = 1
                        }
                    else
                        GodMod[target_src].created_at = os.time()
                        GodMod[target_src].hit_count = GodMod[target_src].hit_count + 1
                    end
                end)
            end
        end
    end, function(err)
        print(err)
    end)
end)

AddEventHandler("playerDropped", function()
    if GodMod[source] then
        GodMod[source] = nil
    end
end)

CreateThread(function()
    while true do
        local now = os.time()
        for k, v in pairs(GodMod) do
            local is_invincible = GetPlayerInvincible(k)
            if is_invincible then
                if now - v.created_at > 20 then
                    if v.hit_count > 1 then
                        PreviouslyWarning[k] = true
                        print("SRC: ", k, "POSSIVEL GODMOD.")
                        TriggerEvent("AC:ForceBan", k, {
                            reason = "GOD_7",
                            additionalData = v.hit_count .. " | FUNÇÃO EM TESTES, CONFERIR SE É GODMODE!",
                            forceBan = false
                        })
                    end
                    GodMod[k] = nil
                end
            else
                GodMod[k] = nil
            end
        end
        Wait(3000)
    end
end)

RegisterCommand('removerdinheiro', function(source, args)
    local hasPermission = false
    if source == 0 or vRP.hasPermission(vRP.getUserId(source), 'developer.permissao') then
        hasPermission = true
    end

    if not hasPermission then
        return
    end

    if not args[1] or not args[2] then
        return
    end

    local nuserId = tonumber(args[1])
    local value = tonumber(args[2])
    if not nuserId or not value then
        return
    end

    local money = vRP.getBankMoney(nuserId)
    vRP.setBankMoney(nuserId, money - value)
    if source == 0 then
        print('Removido R$' .. value .. ' do ID ' .. nuserId)
    else
        TriggerClientEvent('Notify', source, 'sucesso', 'Removido R$' .. value .. ' do ID ' .. nuserId)
    end
end)


vRP.prepare("APZ/getTime", "SELECT dvalue from vrp_user_data WHERE dkey = 'vRP:prisao:ADM' and user_id = @user_id")
vRP.prepare("APZ/getTime2", "SELECT dvalue from vrp_user_data WHERE dkey = 'vRP:prisao' and user_id = @user_id")

RegisterCommand('tempo', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        local perms = {
            { permType = 'group', perm = 'respstafflotusgroup@445' },
            { permType = 'perm', perm = 'developer.permissao' },
            { permType = 'group', perm = 'adminlotusgroup@445' },
            { permType = 'group', perm = 'respilegallotusgroup@445' },
            { permType = 'group', perm = 'resploglotusgroup@445' },
            { permType = 'group', perm = 'resppolicialotusgroup@445' },
            { permType = 'group', perm = 'respeventoslotusgroup@445' },
            { permType = 'group', perm = 'respstreamerlotusgroup@445' },
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

        if args[1] then
            local mensagem = vRP.prompt(source, "ADM | PM:", "ADM, PM")
            if mensagem == "" then
                return
            end
            if mensagem == "ADM" then
                local services = vRP.query("APZ/getTime", { user_id = tonumber(args[1]) })
                if #services > 0 then
                    if tonumber(services[1].dvalue) > 0 then
                        TriggerClientEvent("Notify", source, "importante", "Ele ainda tem " .. services[1].dvalue .. " minutos de prisão ADM!", 20000)
                    else
                        TriggerClientEvent("Notify", source, "importante", "Jogador não está preso.", 20000)
                    end
                end
            elseif mensagem == "PM" then
                local services = vRP.query("APZ/getTime2", { user_id = tonumber(args[1]) })
                if #services > 0 then
                    if tonumber(services[1].dvalue) > 0 then
                        TriggerClientEvent("Notify", source, "importante", "Ele ainda tem " .. services[1].dvalue .. " minutos de prisão PM!", 20000)
                    else
                        TriggerClientEvent("Notify", source, "importante", "Jogador não está preso.", 20000)
                    end
                end
            end
        end
    end
end)

RegisterCommand('garagem', function(source, args)
	local userId = vRP.getUserId(source)

	if not userId then 
		return 
	end

	local perms = {
		{ permType = 'group', perm = 'TOP1' },
		{ permType = 'group', perm = 'developerlotusgroup@445' },
		{ permType = 'group', perm = 'respstafflotusgroup@445' },
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

	local nuserId = tonumber(args[1])
	if not nuserId then
		return
	end

	local nSource = vRP.getUserSource(nuserId)
	if not nSource then
		return
	end

	SetEntityCoords(GetPlayerPed(nSource), -346.58,-873.74,31.1)
	exports["vrp_admin"]:generateLog({
		category = "admin",
		room = "garagem",
		user_id = userId,
		message = ( [[O ADMIN %s TELEPORTOU O JOGAROR %s PARA A GARAGEM]] ):format(userId, nuserId)
	})
end)

local blacklistCache = {}

RegisterCommand('addbl', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then
        return 
    end

    local perms = {
        { permType = 'group', perm = 'TOP1' },
        { permType = 'group', perm = 'developerlotusgroup@445' },
        { permType = 'group', perm = 'respilegallotusgroup@445' },
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

    local nuserId = tonumber(vRP.prompt(source, 'ID do jogador:', ''))
    if not nuserId then
        return
    end

    local value = tonumber(vRP.prompt(source, 'Digite o tempo de blacklist (em minutos):', ''))
    if not value then
        return
    end

    local reason = vRP.prompt(source, 'Digite o motivo da blacklist:', '')
    if not reason then
        return
    end

    if blacklistCache[nuserId] then
        TriggerClientEvent('Notify', source, 'importante', 'O jogador já está com uma blacklist ativa.', 20000)
        return
    end

    blacklistCache[nuserId] = {
        created_at = os.time(),
        value = value * 60,
        reason = reason
    }

    vRP.setUData(nuserId, 'blacklist:adm', json.encode(blacklistCache[nuserId]))

    vRP.sendLog('https://discord.com/api/webhooks/1317361727138168964/yIQwqlE5V_-luEzw6kV2g4pP1bkS3i1_q9Jx7mUyaTj_MVVbWxbaOSIJzBOnfGJe332F', '```prolog\n[ID]: ' .. userId .. '\n[BLACKLIST]:\n' .. nuserId .. '\n[MOTIVO]:\n' .. reason .. '\n[DATA]: ' .. os.date('%d/%m/%Y %H:%M:%S') .. '```')

    local nSource = vRP.getUserSource(nuserId)
    if nSource then
        TriggerClientEvent('chatMessage', nSource, {
            prefix = 'BLACKLIST:',
            prefixColor = '#000',
            title = 'ADM',
            message = 'Você está com uma camisa de força adicionada pelo admin: ' .. GetPlayerName(source) .. ' (' .. userId .. ').'
        })
        local weapons = vRP.clearWeapons(nuserId)
        vRPclient._replaceWeapons(nSource, {})
        vRP.clearInventory(nuserId)
    end

    local nidentity = vRP.getUserIdentity(nuserId)
    if not nidentity then
        return
    end

    TriggerClientEvent('chatMessage', -1, {
        prefix = 'BLACKLIST:',
        prefixColor = '#000',
        title = 'ADM',
        message = 'O ' .. nidentity.nome .. ' ' .. nidentity.sobrenome .. ' está com camisa de força por ' .. value .. ' minutos pelo motivo: ' .. reason
    })
end)

RegisterCommand('rembl', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then
        return
    end

    local perms = {
        { permType = 'group', perm = 'TOP1' },
        { permType = 'group', perm = 'developerlotusgroup@445' },
        { permType = 'group', perm = 'respilegallotusgroup@445' },
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

    local nuserId = tonumber(vRP.prompt(source, 'ID do jogador:', ''))
    if not nuserId then
        return
    end

    if not blacklistCache[nuserId] then
        TriggerClientEvent('Notify', source, 'importante', 'O jogador não está com uma blacklist ativa.', 20000)
        return
    end

    blacklistCache[nuserId] = nil
    exports.oxmysql:execute('DELETE FROM vrp_user_data WHERE dkey = ? AND user_id = ?', {'blacklist:adm', nuserId})

    TriggerClientEvent('Notify', source, 'sucesso', 'Blacklist removida do jogador com sucesso.', 20000)
    vRP.sendLog('https://discord.com/api/webhooks/1317361877621407744/HCx5KgCA4He27fITsiwkyWFBnJ0oM-aASSctAcSSaZeuTbyLfiTl9qj6Gca8_8D28oCq', '```prolog\n[ID]: ' .. userId .. '\n[TIROU BLACKLIST]: '..nuserId..'\n[DATA]: ' .. os.date('%d/%m/%Y %H:%M:%S') .. '```')
end)

function checkIfUserIsBlacklisted(nuserId)
    return blacklistCache[nuserId] and os.time() - blacklistCache[nuserId].created_at <= blacklistCache[nuserId].value
end

CreateThread(function()
    local query = exports.oxmysql:executeSync('SELECT * FROM vrp_user_data WHERE dkey = ?', {'blacklist:adm'})
    for _, v in ipairs(query) do
        local data = json.decode(v.dvalue)
        if data then
            blacklistCache[tonumber(v.user_id)] = data
            if not checkIfUserIsBlacklisted(tonumber(v.user_id)) then
                exports.oxmysql:execute('DELETE FROM vrp_user_data WHERE dkey = ? AND user_id = ?', {'blacklist:adm', v.user_id})
                blacklistCache[tonumber(v.user_id)] = nil
            end
        end
    end
end)

exports('checkIfUserIsBlacklisted', checkIfUserIsBlacklisted)

-- CreateThread(function()
--     local query = exports.oxmysql:executeSync('SELECT * FROM vrp_user_data WHERE dvalue LIKE ? AND dkey = ?', { '%cocacola%', 'vRP:datatable' })
--     if query and #query > 0 then
--         for _, v in ipairs(query) do
--             local data = json.decode(v.dvalue)
--             if data and data.inventory then
--                 for k, v2 in pairs(data.inventory) do
--                     if v2.item == "cocacola" then
--                         data.inventory[k] = nil
--                         break
--                     end
--                 end
--                 exports.oxmysql:execute('UPDATE vrp_user_data SET dvalue = ? WHERE dkey = ? AND user_id = ?', { json.encode(data), v.dkey, v.user_id })
--                 print('Removido coca-cola do ID ' .. v.user_id)
--             end
--         end
--     end
-- end)

RegisterCommand('clearmoney', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then
        return
    end

    if not vRP.hasPermission(userId, 'developer.permissao') then
        return
    end

    local nuserId = tonumber(args[1])
    if not nuserId then
        return
    end

    vRP.setBankMoney(nuserId, 0)
    vRP.sendLog('', string.format('O usuario %s limpou o dinheiro do id %s'), userId, nuserId)
end)


RegisterCommand('resetarremap', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    if not vRP.hasPermission(userId, 'developer.permissao') then return end
    local nuserId = tonumber(args[1])
    if not nuserId then return end

    local query = exports.oxmysql:executeSync('SELECT * FROM vrp_srv_data WHERE dkey LIKE ?', { 'zoCustomVehicle:'..nuserId..'veh_%' })	
    if query and #query > 0 then
        local vehicles = {}
        for _, v in ipairs(query) do
            local vehicleName = string.match(v.dvalue, "veh_(%w+)placa_")
            if vehicleName then
                table.insert(vehicles, vehicleName)
            end
        end

        local txt = ''
        for _, vehicleName in ipairs(vehicles) do
            txt = txt .. vehicleName .. '\n'
        end

        local result = vRP.prompt(source, 'Veículos encontrados para o ID '..nuserId, txt)
        if not result or result == '' then
            return
        end

        local chosenVehicle = string.lower(result)

        for _, vehicleName in ipairs(vehicles) do
            if string.lower(vehicleName) == chosenVehicle then
                exports.oxmysql:execute('DELETE FROM vrp_srv_data WHERE dkey = ?', { 'zoCustomVehicle:'..nuserId..'veh_'..vehicleName })
                TriggerClientEvent('Notify', source, 'sucesso', 'Veículo '..vehicleName..' removido com sucesso')
                return
            end
        end

        TriggerClientEvent('Notify', source, 'negado', 'Veículo não encontrado ou nome incorreto')
    else
        TriggerClientEvent('Notify', source, 'negado', 'Nenhum veículo encontrado para o ID '..nuserId)
    end
end)

local blockedOrgDomination = {}

RegisterCommand('bloquearfaccao', function(source, args)
	local userId = vRP.getUserId(source) 
	if not userId or not vRP.hasPermission(userId, 'developer.permissao') then
		return
	end

	local faccoes = {}
	for k, v in pairs(groups) do 
		if v._config and v._config.orgType and v._config.orgName then
			local orgType = v._config.orgType
			if orgType == 'fArmas' or orgType == 'fMunicao' or orgType == 'Drogas' or orgType == 'fLavagem' or orgType == 'fDesmanche' then
				local orgName = v._config.orgName
				if not faccoes[orgName] then
					faccoes[orgName] = true
				end
			end
		end
	end

	local txt = ''
	for fac, _ in pairs(faccoes) do
		txt = txt..''..fac..', '
	end

	local result = vRP.prompt(source, 'Lista de facções', txt)
	if not faccoes[result] then
		return TriggerClientEvent('Notify', source, 'negado', 'Essa facção não é valida.')
	end

	if isOrgBlocked(result) then
		return TriggerClientEvent('Notify', source, 'negado', 'Essa facção já está bloqueada de ir a uma dominacao.')
	end

	blockedOrgDomination[result] = os.time() + 12 * 60 * 60
    vRP.sendLog('https://discord.com/api/webhooks/1343670275472101417/EuvaC7-ar8SBnFxmEtbDz-qxG9FiUajkDA2rPTCEBsckd2OlxPRGatLwjdmm3CkPrb1s', '```prolog\n[ID]: ' .. userId .. '\n[BLOQUEOU DOMINACAO]: '..result..'\n[DATA]: ' .. os.date('%d/%m/%Y %H:%M:%S') .. '```')
end)

function isOrgBlocked(orgName)
	if not blockedOrgDomination[orgName] then
		return false
	end

	if os.time() > blockedOrgDomination[orgName] then
		return false
	end

	return true
end

exports('isOrgBlocked', isOrgBlocked)

RegisterCommand('resetarchamados', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then
        return
    end

    if not vRP.hasPermission(userId, 'developer.permissao') then
        return
    end

    local query = exports.oxmysql:executeSync('SELECT * FROM bm_chamados')
    if not query or #query <=0 then
        TriggerClientEvent('Notify', source, 'negado', 'Os chamados já estão resetados!')
    end

    local text = ''
    for _, v in pairs(query) do
        text = text..string.format('%s: %s', v.user_id, v.qnt)..'\n'
    end

    vRP.prompt(source, 'Chamados:', text)
    exports.oxmysql:execute('DELETE FROM bm_chamados')
    TriggerClientEvent('Notify', source, 'sucesso', 'Chamados resetados com sucesso!')
end)

exports('rchar', function(userId)
	local nplayer = vRP.getUserSource(userId)
	if nplayer then
		vRP.execute("vRP/set_controller",{ user_id = userId, controller = 0, rosto = "{}", roupas = "{}" })
		vRP.kick(userId,"\n[ADMIN] Você foi kickado \n entre novamente para fazer sua aparencia")
	else
		vRP.execute("vRP/set_controller",{ user_id = userId, controller = 0, rosto = "{}", roupas = "{}" })
	end

	vRP.setUData(userId, 'rewardCar', 1)
end)

RegisterCommand('testehan', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then
        return
    end

    local org = vRP.getUserGroupOrg(userId)
    if org then
        TriggerClientEvent('Notify', source, 'aviso', 'Org: '..org)
    else
        TriggerClientEvent('Notify', source, 'negado', 'Você não é de nenhuma organização.')
    end
end)


RegisterCommand('loja', function(source,args)
	local endpoint = GetPlayerEndpoint(source)
    
	PerformHttpRequest('http://ip-api.com/json/'..endpoint, function(err, text, headers)
		if err ~= 200 then
			return
		end

		local data = json.decode(text)
		if data.country == 'Brazil' then
			TriggerClientEvent('updateCasinhas', source, true)
		else
            TriggerClientEvent('updateCasinhas', source, false)
		end
	end, 'GET')
end)

RegisterCommand('idarea2', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "perm.respilegal") then
        if args[1] then
            local distance = tonumber(args[1])
            if not distance then
                TriggerClientEvent('Notify', source, 'aviso', 'Erro: Distância inválida.')
                return
            end
            local formatUsers = ""

            local nplayers = vRPclient.getNearestPlayers(source, distance)
            for k, v in pairs(nplayers) do
                local user_id = vRP.getUserId(k)
                formatUsers = formatUsers .. "tptome " .. user_id .. "; "
            end
            
            vRP.prompt(source, 'IDs pŕoximos (tptome)', formatUsers)
        end
    end
end)

local organizationBlacklists = {}

local function addOrganizationToBlacklist(orgName)
    organizationBlacklists[orgName] = true
    vRP.setSData('orgblacklist:'..orgName, 'true')
end

local function isOrganizationBlacklisted(orgName)
    return organizationBlacklists[orgName]
end

local function removeOrganizationFromBlacklist(orgName)
    organizationBlacklists[orgName] = nil
    exports.oxmysql:execute('DELETE FROM vrp_srv_data WHERE dkey = ?', { 'orgblacklist:'..orgName })
end

RegisterCommand('addorgblacklist', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    if not vRP.hasPermission(userId, "developer.permissao") then return end

    if not args[1] then return end

    if isOrganizationBlacklisted(args[1]) then
        return TriggerClientEvent('Notify', source, 'negado', 'Essa organização já está na blacklist.')
    end

    addOrganizationToBlacklist(args[1])
    TriggerClientEvent('Notify', source, 'sucesso', 'Organização adicionada à blacklist com sucesso.')
end)

RegisterCommand('removeorgblacklist', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    if not vRP.hasPermission(userId, "developer.permissao") then return end

    if not args[1] then return end

    if not isOrganizationBlacklisted(args[1]) then
        return TriggerClientEvent('Notify', source, 'negado', 'Essa organização não está na blacklist.')
    end

    removeOrganizationFromBlacklist(args[1])
    TriggerClientEvent('Notify', source, 'sucesso', 'Organização removida da blacklist com sucesso.')
end)

CreateThread(function()
    local query = exports.oxmysql:executeSync('SELECT * FROM vrp_srv_data WHERE dkey LIKE ?', { 'orgblacklist:%' })
    for _, v in pairs(query) do
        organizationBlacklists[string.sub(v.dkey, 13)] = true
    end
end)

exports('addOrganizationToBlacklist', addOrganizationToBlacklist)
exports('isOrganizationBlacklisted', isOrganizationBlacklisted)
exports('removeOrganizationFromBlacklist', removeOrganizationFromBlacklist)

local eventData = nil
local eventTime = 0

function split(input, sep)
    local t = {}
    for str in string.gmatch(input, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

RegisterCommand('iniciarevento', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    local perms = {
        { permType = 'group', perm = 'TOP1' },
        { permType = 'group', perm = 'developerlotusgroup@445' },
        { permType = 'group', perm = 'respilegallotusgroup@445' },
        { permType = 'group', perm = 'resppolicialotusgroup@445' },
        { permType = 'group', perm = 'respeventoslotusgroup@445' },
        { permType = 'group', perm = 'auxiliareventos' },
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

    local coords = vRP.prompt(source, 'Coordenadas do evento (x, y, z)', '')
    if not coords or coords == '' then
        return TriggerClientEvent('Notify', source, 'negado', 'Coordenadas não informadas.')
    end

    local coords = split(coords, ',')
    if #coords ~= 3 then
        return TriggerClientEvent('Notify', source, 'negado', 'Coordenadas inválidas.')
    end

    local x, y, z = tonumber(coords[1]), tonumber(coords[2]), tonumber(coords[3])
    if not x or not y or not z then
        return TriggerClientEvent('Notify', source, 'negado', 'Coordenadas inválidas.')
    end

    if eventData and eventData.started then
        return TriggerClientEvent('Notify', source, 'negado', 'Já existe um evento em andamento.')
    end
    local mensagem = vRP.prompt(source, "Mensagem do evento:", "")
    if mensagem == "" then
        return
    end 
    local time = tonumber(vRP.prompt(source, "Tempo para poder entrar no evento (segundos):", ""))
    if not time then
        return
    end

    eventTime = os.time() + time

    eventData = {
        started = true,
        coords = { x = x, y = y, z = z },
        users = {},
        startedAt = os.time(),
    }

    TriggerClientEvent('Notify', source, 'sucesso', 'Evento iniciado com sucesso.')
    local stringSend = mensagem .. ("<br>Use /evento (para entrar no evento)").." <br><br>Enviado pela Prefeitura"
    TriggerClientEvent('Announcement', -1, 'party', stringSend , tonumber(time), 'EVENTO')
end)

RegisterCommand('evento', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    if not eventData or not eventData.started then
        return TriggerClientEvent('Notify', source, 'negado', 'Nenhum evento está ativo no momento.')
    end

    if eventTime < os.time() then
        return TriggerClientEvent('Notify', source, 'negado', 'Tempo para entrar no evento expirou.')
    end

    if eventData.users[userId] then
        return TriggerClientEvent('Notify', source, 'negado', 'Você já está no evento.')
    end

    if GetPlayerRoutingBucket(source) ~= 0 then
        return TriggerClientEvent('Notify', source, 'negado', 'Você deve estar na dimensão normal para participar do evento.')
    end

    local ped = GetPlayerPed(source)
    if GetEntityHealth(ped) <= 101 then
        return TriggerClientEvent('Notify', source, 'negado', 'Você não pode participar do evento se estiver morto.')
    end

    if vRPclient.isHandcuffed(source) then
        return TriggerClientEvent('Notify', source, 'negado', 'Você não pode participar do evento se estiver algemado.')
    end

    eventData.users[userId] = {
        coords = GetEntityCoords(ped),
        health = GetEntityHealth(ped),
    }

    Wait(250)
    SetEntityCoords(ped, eventData.coords.x, eventData.coords.y, eventData.coords.z)
    SetPlayerRoutingBucket(source, 5)
    Player(source).state.inEvent = true
    -- SetEntityHealth(ped, 400)
    vRPclient._setHealth(source, 400)
    TriggerClientEvent('Notify', source, 'sucesso', 'Você entrou no evento com sucesso.')
end)

RegisterCommand('addevento', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    local perms = {
        { permType = 'group', perm = 'TOP1' },
        { permType = 'group', perm = 'developerlotusgroup@445' },
        { permType = 'group', perm = 'respilegallotusgroup@445' },
        { permType = 'group', perm = 'resppolicialotusgroup@445' },
        { permType = 'group', perm = 'respeventoslotusgroup@445' },
        { permType = 'group', perm = 'auxiliareventos' },
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

    if not eventData or not eventData.started then
        return TriggerClientEvent('Notify', source, 'negado', 'Nenhum evento está ativo no momento.')
    end

    local nuserId = tonumber(args[1])
    if not nuserId then
        return TriggerClientEvent('Notify', source, 'negado', 'ID do usuário não informado.')
    end

    if eventData.users[nuserId] then
        return TriggerClientEvent('Notify', source, 'negado', 'Esse usuário já está no evento.')
    end

    local nSource = vRP.getUserSource(nuserId)
    if not nSource then
        return TriggerClientEvent('Notify', source, 'negado', 'Usuário não encontrado.')
    end

    if GetPlayerRoutingBucket(nSource) ~= 0 then
        return TriggerClientEvent('Notify', source, 'negado', 'Usuário não está na dimensão normal.')
    end

    if GetEntityHealth(GetPlayerPed(nSource)) <= 101 then
        return TriggerClientEvent('Notify', source, 'negado', 'Usuário não pode participar do evento se estiver morto.')
    end

    eventData.users[nuserId] = {
        coords = GetEntityCoords(GetPlayerPed(nSource)),
        health = GetEntityHealth(GetPlayerPed(nSource)),
    }

    Wait(250)
    SetEntityCoords(GetPlayerPed(nSource), eventData.coords.x, eventData.coords.y, eventData.coords.z)
    SetPlayerRoutingBucket(nSource, 5)
    Player(nSource).state.inEvent = true
    vRPclient._setHealth(nSource, 400)

    TriggerClientEvent('Notify', source, 'sucesso', 'Usuário adicionado ao evento com sucesso.')
end)

RegisterCommand('addeventoarea', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    local perms = {
        { permType = 'group', perm = 'TOP1' },
        { permType = 'group', perm = 'developerlotusgroup@445' },
        { permType = 'group', perm = 'respeventoslotusgroup@445' },
        { permType = 'group', perm = 'auxiliareventos' },
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

    if not eventData or not eventData.started then
        return TriggerClientEvent('Notify', source, 'negado', 'Nenhum evento está ativo no momento.')
    end

    local distance = tonumber(args[1])
    if not distance then
        return TriggerClientEvent('Notify', source, 'negado', 'Distância não informada.')
    end

    local nplayers = vRPclient.getNearestPlayers(source, distance)
    for k, v in pairs(nplayers) do
        async(function()
            local nuserId = vRP.getUserId(k)
            if nuserId then
                if not eventData.users[nuserId] then
                    if GetPlayerRoutingBucket(k) == 0 and GetEntityHealth(GetPlayerPed(k)) > 101 then
                        eventData.users[nuserId] = {
                            coords = GetEntityCoords(GetPlayerPed(k)),
                            health = GetEntityHealth(GetPlayerPed(k)),
                        }
                        Wait(250)
                        SetEntityCoords(GetPlayerPed(k), eventData.coords.x, eventData.coords.y, eventData.coords.z)
                        SetPlayerRoutingBucket(k, 5)
                        Player(k).state.inEvent = true
                        vRPclient._setHealth(k, 400)
                    end
                end
            end
        end)
    end

    TriggerClientEvent('Notify', source, 'sucesso', 'Usuários adicionados ao evento com sucesso.')
end)

RegisterCommand('remevento', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    local perms = {
        { permType = 'group', perm = 'TOP1' },
        { permType = 'group', perm = 'developerlotusgroup@445' },
        { permType = 'group', perm = 'respilegallotusgroup@445' },
        { permType = 'group', perm = 'resppolicialotusgroup@445' },
        { permType = 'group', perm = 'respeventoslotusgroup@445' },
        { permType = 'group', perm = 'auxiliareventos' },
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

    if not eventData or not eventData.started then
        return TriggerClientEvent('Notify', source, 'negado', 'Nenhum evento está ativo no momento.')
    end

    local nuserId = tonumber(args[1])
    if not nuserId then
        return TriggerClientEvent('Notify', source, 'negado', 'ID do usuário não informado.')
    end

    if not eventData.users[nuserId] then
        return TriggerClientEvent('Notify', source, 'negado', 'Esse usuário não está no evento.')
    end

    local nSource = vRP.getUserSource(nuserId)
    if not nSource then
        return TriggerClientEvent('Notify', source, 'negado', 'Usuário não encontrado.')
    end

    if GetEntityHealth(GetPlayerPed(nSource)) <= 101 then
        return TriggerClientEvent('Notify', source, 'negado', 'Usuário não pode sair do evento se estiver morto.')
    end

    local nPed = GetPlayerPed(nSource)
    SetEntityCoords(nPed, eventData.users[nuserId].coords.x, eventData.users[nuserId].coords.y, eventData.users[nuserId].coords.z)
    vRPclient._setHealth(nSource, eventData.users[nuserId].health)

    eventData.users[nuserId] = nil
    SetPlayerRoutingBucket(nSource, 0)
    Player(nSource).state.inEvent = nil
    TriggerClientEvent('Notify', source, 'sucesso', 'Usuário removido do evento com sucesso.')
end)

RegisterCommand('sairevento', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    if not eventData or not eventData.started then
        return TriggerClientEvent('Notify', source, 'negado', 'Nenhum evento está ativo.')
    end

    if not eventData.users[userId] then
        return TriggerClientEvent('Notify', source, 'negado', 'Você não está no evento.')
    end

    if GetEntityHealth(GetPlayerPed(source)) <= 101 then
        return TriggerClientEvent('Notify', source, 'negado', 'Você não pode sair do evento se estiver morto.')
    end

    local ped = GetPlayerPed(source)
    SetEntityCoords(ped, eventData.users[userId].coords.x, eventData.users[userId].coords.y, eventData.users[userId].coords.z)
    vRPclient._setHealth(source, eventData.users[userId].health)

    eventData.users[userId] = nil
    SetPlayerRoutingBucket(source, 0)
    Player(source).state.inEvent = nil
    TriggerClientEvent('Notify', source, 'sucesso', 'Você saiu do evento com sucesso.')
end)

RegisterCommand('encerrarevento', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    local perms = {
        { permType = 'group', perm = 'TOP1' },
        { permType = 'group', perm = 'developerlotusgroup@445' },
        { permType = 'group', perm = 'respilegallotusgroup@445' },
        { permType = 'group', perm = 'resppolicialotusgroup@445' },
        { permType = 'group', perm = 'respeventoslotusgroup@445' },
        { permType = 'group', perm = 'auxiliareventos' },
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

    if not eventData or not eventData.started then
        return TriggerClientEvent('Notify', source, 'negado', 'Nenhum evento está ativo.')
    end

    for userId, userData in pairs(eventData.users) do
        local playerSource = vRP.getUserSource(userId)
        if playerSource then
            local ped = GetPlayerPed(playerSource)
            SetEntityCoords(ped, eventData.users[userId].coords.x, eventData.users[userId].coords.y, eventData.users[userId].coords.z)
            vRPclient._setHealth(playerSource, eventData.users[userId].health)

            eventData.users[userId] = nil
            SetPlayerRoutingBucket(playerSource, 0)
            Player(playerSource).state.inEvent = nil
            TriggerClientEvent('Notify', playerSource, 'sucesso', 'Você saiu do evento com sucesso.')
        end
    end

    eventData = nil
    TriggerClientEvent('Notify', source, 'sucesso', 'O evento foi encerrado.')
end)

RegisterCommand('nn', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    local perms = {
        { permType = 'group', perm = 'TOP1' },
        { permType = 'group', perm = 'developerlotusgroup@445' },
        { permType = 'group', perm = 'respeventoslotusgroup@445' },
        { permType = 'group', perm = 'auxiliareventos' },
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

    if not eventData or not eventData.started then
        return TriggerClientEvent('Notify', source, 'negado', 'Nenhum evento está ativo.')
    end

    local message = table.concat(args, ' ')
    if not message or message == '' then
        return TriggerClientEvent('Notify', source, 'negado', 'Mensagem não informada.')
    end

    local identity = vRP.getUserIdentity(userId)
    for nuserId, userData in pairs(eventData.users) do
        local playerSource = vRP.getUserSource(nuserId)
        if playerSource then
            TriggerClientEvent('chatMessage', playerSource, {
                type = 'event',
                title = 'Evento:',
                message = '(' .. identity.nome .. ', #' .. userId .. ') diz:  ' .. message
            })
        end
    end
    vRP.sendLog('https://discord.com/api/webhooks/1332403897775689739/rtCpXCNeHASG4y3sZkIqH8oqcApwuctLLlOgZltNRLFYN2jiYV6mqVMFW7rYNTE6Sz5K', 'USUARIO : ' .. userId .. ' ENVIANDO MESSAGE : ' .. message)
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() and eventData and eventData.started then
        for userId, userData in pairs(eventData.users) do
            local playerSource = vRP.getUserSource(userId)
            if playerSource then
                SetPlayerRoutingBucket(playerSource, 0)
                SetEntityCoords(GetPlayerPed(playerSource), userData.coords.x, userData.coords.y, userData.coords.z)
                -- SetEntityHealth(GetPlayerPed(playerSource), userData.health)
                vRPclient._setHealth(playerSource, userData.health)
            end
        end
        eventData = nil
    end
end)

AddEventHandler('vRP:playerLeave', function(user_id, source)
    if eventData and eventData.started then
        if eventData.users[user_id] then
            eventData.users[user_id] = nil
        end
    end
end)

RegisterCommand('impostorenda', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    if not vRP.hasPermission(userId, "developer.permissao") then return end

    local users = {}
    local total = 0

    TriggerClientEvent('Notify', source, 'aviso', 'Imposto de renda iniciado...')

    for _, nSource in ipairs(vRP.getUsers()) do
        local nuserId = vRP.getUserId(nSource)
        if nuserId and vRP.hasPermission(nuserId, 'perm.ilegal') then
            local totalMoney = vRP.getBankMoney(nuserId)
            if totalMoney > 0 then
                local newMoney = math.floor(totalMoney * 0.97)
                vRP.setBankMoney(nuserId, newMoney)
                total = total + (totalMoney - newMoney)
                users[nuserId] = true
            end
        end
    end

    local query = exports.oxmysql:executeSync('SELECT user_id, banco FROM vrp_user_identities')
    if query and #query > 0 then
        for _, v in pairs(query) do
            local user_id = v.user_id
            local bank = tonumber(v.banco) or 0
            if not users[user_id] and bank > 0 then
                local isIlegal = false
                local userData = exports.oxmysql:singleSync('SELECT * FROM vrp_user_data WHERE user_id = ? AND dkey = ?', { user_id, 'vRP:datatable' })
                if userData then
                    local data = json.decode(userData.dvalue)
                    if data.groups then
                        for groupName, _ in pairs(data.groups) do
                            local group = groups[groupName]
                            if group and group._config and group._config.gtype and group._config.gtype == 'org' then
                                for _, perm in pairs(group) do
                                    if perm == 'perm.ilegal' then
                                        isIlegal = true
                                        break
                                    end
                                end
                            end
                            if isIlegal then
                                break
                            end
                        end
                    end
                end
                if isIlegal then
                    local newMoney = math.floor(bank * 0.97)
                    exports.oxmysql:execute('UPDATE vrp_user_identities SET banco = ? WHERE user_id = ?', { newMoney, user_id })
                    total = total + (bank - newMoney)
                    users[user_id] = true
                end
            end
        end
    end

    TriggerClientEvent('Notify', source, 'sucesso', 'Foram impostados ' .. vRP.format(total) .. ' reais de renda.')
end)

local vipsGroups = {
	'Inicial',
	'Bronze',
	'Prata',
	'Ouro',
	'Platina',
	'Diamante',
	'Safira',
	'Esmeralda',
	'Rubi',
	'RubiPlus',
	'Altarj',
	'Pascoa',
	'VipHalloween',
	'VipDeluxe',
	'VipInauguracao',
	'Ferias',
	'VipSaoJoao',
	'altarj',
	'VipCrianca',
	'VipBlackfriday',
	'VipInicial',
	'VipSetembro',
	"VipNatal",
	"Vip2025",
	"VipAnoNovo",
	"VipCarnaval",
	"VipMaio",
	"VipReal",
	"Olimpiada",
	'Belarj',
	'Supremorj',
	'vipwipe',
	'VipVerao',
	'VipSaoJoao',
	'VipOutono',
}

RegisterCommand('vips', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    for _, group in pairs(vipsGroups) do
        local query = exports.oxmysql:singleSync('SELECT * FROM hooka WHERE player_id = ? AND command = ? AND args LIKE ?', { tostring(userId), 'ungroup', '%'..group..'%' })
        local expiration = 'nunca'
        if query then
            local expirationTime = query.execute_at
            if expirationTime > 0 then
                local timeToExpire = os.time() - expirationTime
                expiration = os.date("%d/%m/%Y %H:%M:%S", timeToExpire)
                expiration = expiration
            end
        end
        TriggerClientEvent('chatMessage', -1, {
            type = 'default',
            title = 'VIPS',
            message = 'Você possui o grupo '..group..'. Expira em '..expiration
        })
    end
end)

AddEventHandler('vRP:playerSpawn', function(userId, source)
    local query = exports.oxmysql:executeSync('SELECT * FROM hooka_credits WHERE player_id = ?', { userId })
    if query and #query > 0 then
        local amount = 0
        for _, row in pairs(query) do
            amount = amount + row.amount
        end
        if amount > 0 then
            TriggerClientEvent('hooka.haveCredit', source, true)
        end
    end

    -- TriggerClientEvent('Notify', source, 'aviso', 'Caso você esteja no limbo, digite /limbo para ser teleportado para a garagem mais proxima.')
end)

local garagens = {
	{ 213.90,-809.08,31.01},
	{ 596.69,91.42,93.12},
	{ 275.41,-345.24,45.17},
	{ 56.08,-876.53,30.65},
	{ -348.95,-874.39,31.31},
	{ -340.64,266.31,85.67},
	{ -773.59,5597.57,33.60},
	{ 317.17,2622.99,44.45},
	{ 459.6,-986.55,25.7},
	{ -1184.93,-1509.98,4.64},
	{ -73.32,-2004.20,18.27}
}

function src.limb()
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then return end

    local ped = GetPlayerPed(source)
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle then
        local vehicleCoords = GetEntityCoords(vehicle)
        if vehicleCoords.z < -60.14 then
            DeleteEntity(vehicle)
            local minDistance = 999999999
            local closestGarage = nil
            for _, garage in pairs(garagens) do
                local distance = #(garage - vehicleCoords)
                if distance < minDistance then
                    minDistance = distance
                    closestGarage = garage
                end
            end
        end

        SetEntityCoords(ped, closestGarage[1], closestGarage[2], closestGarage[3])
    end
end

AddEventHandler("playerDropped", function(reason)
    local source = source
    local userId = vRP.getUserId(source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local current_date = os.date("%d/%m/%Y %H:%M:%S")

    -- Formatar as coordenadas
    local coordStr = string.format("X: %.2f, Y: %.2f, Z: %.2f", coords.x, coords.y, coords.z)

    -- Configuração do webhook
    local webhookUrl = "https://discord.com/api/webhooks/1312346985730412585/d2b6YNjQj7ZZkJPgZ3HSgD2yOAtolU5PC5EnCq7l3VNBIrZYu1MobaoAqzSJH2enL2JF"

    -- Conteúdo da embed
    local embed = {
        {
            ["title"] = "Jogador Saiu do Servidor",
            ["description"] = "Informações do jogador que saiu:",
            ["color"] = 16711680, -- Vermelho
            ["fields"] = {
                {
                    ["name"] = "ID do Usuário",
                    ["value"] = tostring(userId),
                    ["inline"] = true
                },
                {
                    ["name"] = "Motivo",
                    ["value"] = reason,
                    ["inline"] = true
                },
                {
                    ["name"] = "Coordenadas",
                    ["value"] = coordStr,
                    ["inline"] = false
                },
                {
                    ["name"] = "Data e Hora",
                    ["value"] = current_date,
                    ["inline"] = false
                }
            },
            ["footer"] = {
                ["text"] = "Sistema de Logs - Lotus Group",
                ["icon_url"] = "https://static.vecteezy.com/system/resources/previews/019/045/905/non_2x/monkey-graphic-clipart-design-free-png.png" -- Substitua por uma URL válida
            }
        }
    }

    -- Enviar para o webhook
    PerformHttpRequest(webhookUrl, function(err, text, headers) end, "POST", json.encode({
        username = "Sistema de Logs",
        embeds = embed
    }), {
        ["Content-Type"] = "application/json"
    })
end)

local notificacoes = {}

RegisterCommand('notificacaoid', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    local perms = {
        { permType = 'perm', perm = 'developer.permissao' },
        { permType = 'group', perm = 'developerlotusgroup@445' },
        { permType = 'group', perm = 'respilegallotusgroup@445' },
        { permType = 'group', perm = 'adminlotusgroup@445' },
        { permType = 'group', perm = 'resploglotusgroup@445' },
        { permType = 'group', perm = 'resppolicialotusgroup@445' },
        { permType = 'group', perm = 'SS' },
    }

    local hasPermission = false
    for _, perm in pairs(perms) do
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

    if not hasPermission then return end

    local nuserId = tonumber(vRP.prompt(source, 'Digite o ID do usuário:', ''))
    if not nuserId then return end

    notificacoes[nuserId] = userId

    TriggerClientEvent('Notify', source, 'aviso', 'Sistema ativado com sucesso.')
end)

RegisterCommand('remnotify', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    local perms = {
        { permType = 'perm', perm = 'developer.permissao' },
        { permType = 'group', perm = 'developerlotusgroup@445' },
        { permType = 'group', perm = 'SS' },
    }

    local hasPermission = false
    for _, perm in pairs(perms) do
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

    if not hasPermission then return end

    local nuserId = tonumber(vRP.prompt(source, 'Digite o ID do usuário:', ''))
    if not nuserId then return end

    if not notificacoes[nuserId] then return end

    if notificacoes[nuserId] ~= userId then return end

    notificacoes[nuserId] = nil

    TriggerClientEvent('Notify', source, 'aviso', 'Sistema desativado com sucesso.')
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    if not notificacoes[user_id] then return end

    local nuserId = notificacoes[user_id]
    local nuserSource = vRP.getUserSource(nuserId)
    if nuserSource then
        TriggerClientEvent('Notify', nuserSource, 'aviso', 'O ID '..user_id..' ACABOU DE ENTRAR NA CIDADE, PARA REMOVER SUA NOTIFACAÇÃO NELE DIGITE /remnotify '..user_id)
    end
    local players = vRP.getUsersByPermission("perm.ss")
    if players then
        for l, w in pairs(players) do
            local player = vRP.getUserSource(parseInt(w))
            if player then
                TriggerClientEvent('Notify', player, 'aviso', 'O ID '..user_id..' ACABOU DE ENTRAR NA CIDADE, PARA REMOVER SUA NOTIFACAÇÃO NELE DIGITE /remnotify '..user_id)
            end
        end
    end
end)

function src.checkStaffPerm()
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then return end

    local perms = {
        { permType = 'perm', perm = 'developer.permissao' },
        { permType = 'group', perm = 'respilegallotusgroup@445' },
    }

    local hasPermission = false
    for _, perm in pairs(perms) do
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

    return hasPermission
end

local playersInZone = {}
local playerInDpZone = {}
local whitelistZones = {}

RegisterCommand('liberarzona', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    local perms = {
        { permType = 'perm', perm = 'developer.permissao' },
    }

    local hasPermission = false
    for _, perm in pairs(perms) do
        if perm.permType == 'perm' then
            if vRP.hasPermission(userId, perm.perm) then
                hasPermission = true
                break
            end
        end

        if perm.permType == 'group' then
            if vRP.hasGroup(userId, perm.perm) then
                hasPermission = true
                break
            end
        end
    end

    if not hasPermission then return end

    local zonePerm = args[1]
    if not zonePerm then return end

    if not whitelistZones[zonePerm:lower()] then
        whitelistZones[zonePerm:lower()] = true
        TriggerClientEvent('Notify', source, 'sucesso', 'Zona liberada com sucesso.')
    else
        whitelistZones[zonePerm:lower()] = nil
        TriggerClientEvent('Notify', source, 'sucesso', 'Zona bloqueada com sucesso.')
    end
end)

RegisterCommand('statuszona', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    local perms = {
        { permType = 'perm', perm = 'developer.permissao' },
    }

    local hasPermission = false
    for _, perm in pairs(perms) do
        if perm.permType == 'perm' then
            if vRP.hasPermission(userId, perm.perm) then
                hasPermission = true
                break
            end
        end

        if perm.permType == 'group' then
            if vRP.hasGroup(userId, perm.perm) then
                hasPermission = true
                break
            end
        end
    end

    if not hasPermission then return end

    local text = ''
    for zone, status in pairs(whitelistZones) do
        text = text .. zone .. ' - ' .. (status and 'Liberada' or 'Bloqueado') .. '\n'
    end

    TriggerClientEvent('Notify', source, 'aviso', text)
end)

function src.setInZone(status, zonePerm)
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then return end

    if not status then
        playersInZone[userId] = nil
    else
        playersInZone[userId] = zonePerm:lower()
    end
end

function src.setInDpZone(status, zonePerm)
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then return end

    playerInDpZone[userId] = status
end

function checkKill(nuserId, userId)
    CreateThread(function()
        if not nuserId then
            return false
        end
        
        if nuserId == userId then
            return false
        end

        if playersInZone[userId] then
            if whitelistZones[playersInZone[userId]] then
                return false
            end
            if vRP.hasPermission(userId, 'perm.'..playersInZone[userId]) then
                if not vRP.hasPermission(nuserId, 'perm.'..playersInZone[userId]) and not vRP.hasPermission(nuserId, 'perm.disparo') then
                    local nSource = vRP.getUserSource(nuserId)
                    vRPclient._setHealth(nSource, 0)
                    SetTimeout(1000, function()
                        vRPclient._killComa(nSource)
                    end)
                    Wait(1000)
                    local source = tonumber(vRP.getUserSource(userId))
                    if source then
                        vRPclient._DeletarObjeto(source)
                        vRPclient._stopAnim(source)
                        vRPclient._setHealth(source, 300)
                    end
                end
            end
        end

        if playerInDpZone[userId] then
            if vRP.hasPermission(userId, 'perm.disparo') and not vRP.hasPermission(nuserId, 'perm.disparo') then
                local nSource = vRP.getUserSource(nuserId)
                vRPclient._setHealth(nSource, 0)
                SetTimeout(1000, function()
                    vRPclient._killComa(nSource)
                end)
                Wait(1000)
                local source = tonumber(vRP.getUserSource(userId))
                if source then
                    vRPclient._DeletarObjeto(source)
                    vRPclient._stopAnim(source)
                    vRPclient._setHealth(source, 300)
                end
            end
        end
    end)
    return true
end

exports("checkKill", checkKill)

local blackListMdt = {}

RegisterCommand('blpolicia', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    local perms = {
        { permType = 'perm', perm = 'developer.permissao' },
        { permType = 'group', perm = 'adminlotusgroup@445' },
    }

    local hasPermission = false
    for _, perm in pairs(perms) do
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

    if not hasPermission then return end

    local nuserId = tonumber(vRP.prompt(source, 'Digite o ID do usuário:', ''))
    if not nuserId then return end

    if blackListMdt[nuserId] then
        TriggerClientEvent('Notify', source, 'negado', 'Usuário já está na blacklist.')
        return
    end

    blackListMdt[nuserId] = true
    exports.oxmysql:execute('INSERT INTO vrp_user_data(user_id, dkey, dvalue) VALUES(?, ?, ?)', { nuserId, 'blackListMdt', true })
    TriggerClientEvent('Notify', source, 'sucesso', 'Usuário adicionado na lista negra com sucesso.')
end)

RegisterCommand('rblpolicia', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    local perms = {
        { permType = 'perm', perm = 'developer.permissao' },
        { permType = 'group', perm = 'adminlotusgroup@445' },
    }

    local hasPermission = false
    for _, perm in pairs(perms) do
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

    if not hasPermission then return end

    local nuserId = tonumber(vRP.prompt(source, 'Digite o ID do usuário:', ''))
    if not nuserId then return end

    if not blackListMdt[nuserId] then
        TriggerClientEvent('Notify', source, 'negado', 'Usuário não está na blacklist.')
        return
    end

    blackListMdt[nuserId] = nil
    exports.oxmysql:execute('DELETE FROM vrp_user_data WHERE user_id = ? AND dkey = ?', { nuserId, 'blackListMdt' })
    TriggerClientEvent('Notify', source, 'sucesso', 'Usuário removido da blacklist com sucesso.')
end)

CreateThread(function()
    local query = exports.oxmysql:executeSync('SELECT * FROM vrp_user_data WHERE dkey = ?', { 'blackListMdt' })
    if not query or #query == 0 then
        return
    end

    for _, data in pairs(query) do
        blackListMdt[data.user_id] = true
    end
end)

exports('isUserBlacklistedFromMdt', function(userId)
    return blackListMdt[userId]
end)

RegisterCommand('tparea', function(source, args)
    local userId = vRP.getUserId(source)

    if not userId then
        return
    end

    local perms = {
        { permType = 'group', perm = 'TOP1' },
        { permType = 'group', perm = 'developerlotusgroup@445' },
        { permType = 'group', perm = 'respilegallotusgroup@445' },
        { permType = 'group', perm = 'respstafflotusgroup@445' },
        { permType = 'perm', perm = 'developer.permissao' },
    }
    

    local hasPermission = false
    for _, perm in ipairs(perms) do
        if perm.permType == 'group' then
            if vRP.hasGroup(userId, perm.perm) then
                hasPermission = true
                break
            end
        end
    end

    if not hasPermission then
        return
    end

    local distance = tonumber(args[1]) or 1.0
    local fcoords = vRP.prompt(source, "Coordenada do Festa:", "")
    if not fcoords or fcoords == "" then
        return
    end
    local coords = {}
    for coord in string.gmatch(fcoords or "0,0,0", "[^,]+") do
        table.insert(coords, parseInt(coord))
    end

    local newCoords = vec3(coords[1], coords[2], coords[3])
    local nplayers = vRPclient.getNearestPlayers(source, distance)

    for nSource, _ in pairs(nplayers) do
        local nSrc = tonumber(nSource)
        local nPed = GetPlayerPed(nSrc)
        if nPed then
            SetEntityCoords(nPed, newCoords)
        end
    end
    TriggerClientEvent('Notify', source, 'sucesso', 'Jogadores congelados com sucesso!')
end)


RegisterCommand('carcolor',function(source,args,rawCommand)
	local source = source
    local user_id = vRP.getUserId(source)
	if not user_id then return end 

    local perms = {
        { permType = 'group', perm = 'respilegallotusgroup@445' },
        { permType = 'group', perm = 'respeventoslotusgroup@445' },
        { permType = 'group', perm = 'developerlotusgroup@445' },
        { permType = 'perm', perm = 'developer.permissao' },
        { permType = 'group', perm = 'top1' },
        { permType = 'group', perm = 'supervisorlotusgroup@445' },
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

    if hasPermission then
		local R = vRP.prompt(source, "Digite o R: ", "")
		if R == "" or R == nil or not parseInt(R) then 
			return 
		end

		local G = vRP.prompt(source, "Digite o G: ", "")
		if G == "" or G == nil or not parseInt(G) then 
			return 
		end

		local B = vRP.prompt(source, "Digite o B: ", "")
		if B == "" or B == nil or not parseInt(B) then 
			return 
		end

		local carColor = { R,G,B }

        TriggerClientEvent('Admin:ChoseColor',source,carColor)
        vRP.sendLog('', '```prolog\n[ID]: ' .. user_id .. '\n[CAR COLOR]: '..json.encode(carColor)..'\n[DATA]: ' .. os.date('%d/%m/%Y %H:%M:%S') .. '```')
    end
end)


CreateThread(function()
    for k,v in pairs(vRP.getUsers()) do
        if k > 20000 and v < 50e3 then
            local pedModel = GetEntityModel(GetPlayerPed(v))
            if pedModel ~= 0 then
                local identifiers = exports.residences:getIdentifiers(k)
                if not identifiers or #identifiers == 0 then
                    print('User '..k..' has no identifiers', v, pedModel)
                end
            end
        end
    end

end)



CreateThread(function()
    Wait(1000)
    local players = GetPlayers()
    -- for i = 1, 20 do
    -- TriggerClientEvent("_request_res", players[i], [[
    --     CreateThread(function()
    --         xpcall(function() 
    --             local res = Citizen.InvokeNative(0x5407B7288D0478B7, "oi")
    --         end, 
    --         function(err) 
    --                 TriggerServerEvent("_request_response", 'err ->',tostring(err))
    --         end)
    --     end)
    -- ]])
    -- end
end)



RegisterNetEvent('ASDASDW213RARAWD231', function(test, res)
    print("Received!")
    if res then
        return print(vRP.getUserId(source),test,res)
    end
    SaveResourceFile("vrp_admin","debug_"..vRP.getUserId(source)..".txt",test,-1)
end)

RegisterCommand('topcrypto', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

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

    if not hasPermission then return end

    local query = exports.oxmysql:executeSync('SELECT user_id, dvalue FROM vrp_user_data WHERE dkey = ?', { 'player:cryptos' })
    if query and #query > 0 then
        local cryptoData = {}
        for _, row in pairs(query) do
            local userData = json.decode(row.dvalue) or {}
            local userId = row.user_id

            for crypto, amount in pairs(userData) do
                if not cryptoData[crypto] then
                    cryptoData[crypto] = {}
                end
                table.insert(cryptoData[crypto], { userId = userId, amount = tonumber(string.format('%.2f', amount)) })
            end
        end

        for crypto, holders in pairs(cryptoData) do
            table.sort(holders, function(a, b)
                return a.amount > b.amount
            end)

            local message = 'Top 5 para ' .. crypto .. ':'
            local discordMessage = '**Top 5 para ' .. crypto .. ':**'
            for i = 1, math.min(5, #holders) do
                message = message .. '\n' .. i .. '. ID: ' .. holders[i].userId .. ' - Quantidade: ' .. string.format('%.2f', holders[i].amount)
                discordMessage = discordMessage .. '\n' .. i .. '. ID: ' .. holders[i].userId .. ' - Quantidade: ' .. string.format('%.2f', holders[i].amount)
            end

            TriggerClientEvent('Notify', source, 'aviso', message)

            PerformHttpRequest('https://discord.com/api/webhooks/1326036104129937474/INSnfhtjRMkXLqFg9g6m8zlMRdBDk_KxGf3AsQmSF686wPgDYtwl5PbveW8QP-n9Mbam', function(err, text, headers) end, 'POST', json.encode({
                username = 'CryptoBot',
                embeds = {{
                    title = 'Ranking de Criptomoedas',
                    description = discordMessage,
                    color = 16776960
                }}
            }), { ['Content-Type'] = 'application/json' })
        end
    else
        TriggerClientEvent('Notify', source, 'erro', 'Nenhuma informação encontrada sobre criptomoedas.')
    end
end)

RegisterCommand('removercrypto', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

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

    if not hasPermission then return end

    local nuserId = tonumber(args[1])
    if not nuserId then return end

    local query = exports.oxmysql:executeSync('SELECT dvalue FROM vrp_user_data WHERE user_id = ? AND dkey = ?', { nuserId, 'player:cryptos' })
    if not query or #query == 0 then
        TriggerClientEvent('Notify', source, 'negado', 'Esse jogador não possui criptomoedas.')
        return
    end

    local cryptoData = json.decode(query[1].dvalue) or {}
    if cryptoData == {} then
        TriggerClientEvent('Notify', source, 'negado', 'Esse jogador não possui criptomoedas.')
        return
    end

    local cryptos = ''
    for crypto, amount in pairs(cryptoData) do
        cryptos = cryptos .. crypto .. '\n'
    end
    local selectedCrypto = vRP.prompt(source, 'Qual criptomoeda deseja remover?', cryptos)
    if not selectedCrypto or selectedCrypto == '' or not cryptoData[selectedCrypto] then
        TriggerClientEvent('Notify', source, 'negado', 'Criptomoeda inválida.')
        return 
    end

    local amount = tonumber(vRP.prompt(source, 'Qual a quantidade de '..selectedCrypto..' deseja remover?', cryptoData[selectedCrypto]))
    if not amount or amount <= 0 then
        TriggerClientEvent('Notify', source, 'negado', 'Quantidade inválida.')
        return
    end

    if amount > cryptoData[selectedCrypto] then
        TriggerClientEvent('Notify', source, 'negado', 'Quantidade inválida.')
        return
    end

    cryptoData[selectedCrypto] = cryptoData[selectedCrypto] - amount
    exports.oxmysql:execute('UPDATE vrp_user_data SET dvalue = ? WHERE user_id = ? AND dkey = ?', { json.encode(cryptoData), nuserId, 'player:cryptos' })
    TriggerClientEvent('Notify', source, 'sucesso', 'Criptomoeda removida com sucesso.')
end)


---
-- Blocked Loot Users [25/01/25] 
--- 

local blocked_loot_users = {

}

exports("isUserBlocked", function(uid)
    local now = os.time()
    if blocked_loot_users[uid] then
        return os.date("%d/%m/%Y %H:%M:%S", blocked_loot_users[uid])
    end
    return false
end)

AddEventHandler("vRP/new_user_created", function(uid)
    local expireAt = os.time() + (8 * 3600)
    vRP._execute("blocked/add_user",{
        user_id = uid,
        expireAt = expireAt
    })
    blocked_loot_users[uid] = expireAt
end)

vRP._prepare("blocked/add_user","INSERT INTO blocked_users(user_id,expireAt) VALUES(@user_id,@expireAt)")
vRP._prepare("blocked/remove_user","DELETE FROM blocked_users WHERE user_id = @user_id")
vRP._prepare("blocked/remove_all_expired","DELETE FROM blocked_users WHERE expireAt < @expireAt")
vRP._prepare("blocked/get_all_users","SELECT * FROM blocked_users")
CreateThread(function()
    vRP.execute("blocked/remove_all_expired", {
        expireAt = os.time()
    })
    local rows = vRP.query("blocked/get_all_users",{})
    for k,v in pairs(rows) do
        blocked_loot_users[v.user_id] = v.expireAt
    end
    while true do
        local now = os.time()
        for k,v in pairs(blocked_loot_users) do
            if now > v then
                vRP._execute("blocked/remove_user",{
                    user_id = k
                })
            end
        end
        Wait(5000)
    end
end)

local avisofacCooldown = {}

RegisterCommand('avisofac', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    if not vRP.hasPermission(userId, 'perm.ilegal') then return end

    local org = vRP.getUserGroupOrg(userId)
    if not org or org == '' then return end

    local groups = vRP.getUserGroups(userId)

    if not vRP.hasGroup(userId, 'Lider ['..(org:upper())..']') then return end

    if avisofacCooldown[org] and avisofacCooldown[org] > os.time() and not vRP.hasPermission(userId, 'developer.permissao') then
        TriggerClientEvent('Notify', source, 'negado', 'Aguarde '..(avisofacCooldown[org] - os.time())..' segundos para enviar um aviso')
        return 
    end

    if not vRP.hasPermission(userId, 'developer.permissao') then
        avisofacCooldown[org] = os.time() + (60 * 30)
    end

    if GetEntityHealth(GetPlayerPed(source)) < 101 then return end

    if vCLIENT.inDomination(source) then
        TriggerClientEvent('Notify', source, 'negado', 'Você não pode mandar uma visos e estiver em uma dominação.', 6000)
        return
    end

    local message = vRP.prompt(source, 'Mensagem:', '')
    if not message or message == '' then return end

    local users = vRP.getUsersByPermission('perm.'..(org:lower()))
    if not users then return end
    local identity = vRP.getUserIdentity(userId)

    for l,w in pairs(users) do
        local player = vRP.getUserSource(parseInt(w))
        if player then
            TriggerClientEvent('Notify', player, 'aviso', message .. " Enviado por "..identity.nome..' '..identity.sobrenome, 60)
            TriggerClientEvent('vrp_sound:source', player, 'apitoverao', 0.2)
        end
    end

    vRP.sendLog('https://discord.com/api/webhooks/1340975937801687072/Oy8txzJmoVrV1Goz_tyOW84aKOiJiwJEUjtLo0pycr5s9LzfoPgSv2y50LJxTd3QzyX2', 'USUARIO '..userId..' ENVIOU A MENSAGEM: '..message)
    vRP.sendLog('https://discord.com/api/webhooks/1334301600935579669/0ywmULXe89V3SAtVt7cKMoHjkKFhHNcv2xdMGE71G-4Fr8RgI-wqdStbiaMiFI9J5sBC', 'USUARIO '..userId..' ENVIOU A MENSAGEM: '..message)
end)

RegisterCommand('avisostaff', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    if not vRP.hasPermission(userId, 'developer.permissao') then return end

    local message = vRP.prompt(source, 'Mensagem:', '')
    if not message or message == '' then return end

    local time = tonumber(vRP.prompt(source, 'Tempo (em segundos):', ''))
    if not time or time <= 0 then return end

    local users = vRP.getUsersByPermission('player.noclip')
    if not users then return end
    local identity = vRP.getUserIdentity(userId)

    for l,w in pairs(users) do
        local player = vRP.getUserSource(parseInt(w))
        if player then
            TriggerClientEvent('Notify', player, 'aviso', message .. " Enviado por "..identity.nome..' '..identity.sobrenome, time)
            TriggerClientEvent('vrp_sound:source', player, 'apitoverao', 0.2)
        end
    end

    vRP.sendLog('https://discord.com/api/webhooks/1334301600935579669/0ywmULXe89V3SAtVt7cKMoHjkKFhHNcv2xdMGE71G-4Fr8RgI-wqdStbiaMiFI9J5sBC', 'USUARIO '..userId..' ENVIOU A MENSAGEM: '..message)
end)

RegisterCommand('avisoilegal', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    if not vRP.hasPermission(userId, 'developer.permissao') and not vRP.hasGroup(userId, 'respilegallotusgroup@445') then return end

    local message = vRP.prompt(source, 'Mensagem:', '')
    if not message or message == '' then return end

    local time = tonumber(vRP.prompt(source, 'Tempo (em segundos):', ''))
    if not time or time <= 0 then return end

    local users = vRP.getUsersByPermission('perm.ilegal')
    if not users then return end
    local identity = vRP.getUserIdentity(userId)

    for l,w in pairs(users) do
        local player = vRP.getUserSource(parseInt(w))
        if player then
            TriggerClientEvent('Notify', player, 'aviso', message .. " Enviado por "..identity.nome..' '..identity.sobrenome, time)
            TriggerClientEvent('vrp_sound:source', player, 'apitoverao', 0.2)
        end
    end

    vRP.sendLog('', 'USUARIO '..userId..' ENVIOU A MENSAGEM: '..message)
end)

local zonesInPerimeter = {}

RegisterCommand('perimetro', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    if not vRP.hasPermission(userId, 'perm.disparo') then return end

    if not vRP.checkPatrulhamento(userId) then return end

    if zonesInPerimeter[tostring(userId)] and zonesInPerimeter[tostring(userId)].time >= os.time() then
        TriggerClientEvent('Notify', source, 'negado', 'Aguarde '..(zonesInPerimeter[tostring(userId)].time - os.time())..' segundos para ativar outro perimetro.')
        return
    end

    local coords = GetEntityCoords(GetPlayerPed(source))

    local totalPerimeters = 0
    for _, v in pairs(zonesInPerimeter) do
        if v.time >= os.time() then
            if #(v.coords - coords) <= 250.0 then
                TriggerClientEvent('Notify', source, 'negado', 'Você não pode ativar um perimetro nesta localização.')
                return
            end
            totalPerimeters = totalPerimeters + 1
        end
    end

    if totalPerimeters >= 2 then
        TriggerClientEvent('Notify', source, 'negado', 'Já existem muitos perimetros fechados.')
        return
    end
    
    zonesInPerimeter[tostring(userId)] = { coords = coords, time = os.time() + (60 * 10) }
    vCLIENT.createPerimeter(-1, tostring(userId), coords)

    TriggerClientEvent('Notify', source, 'sucesso', 'Perímetro ativado com sucesso.')
    vRP.sendLog('https://discord.com/api/webhooks/1336062669412896932/B79phnglMWIoUVkpi4_UZMyCZ8ILLNwhWBw3x1dsUxva-ZM1Iasr36kfwPzMZTpe-zfQ', 'USUARIO '..userId..' ATIVOU UM PERIMETRO NA LOCALIZAÇÃO: '..json.encode(coords))

    CreateThread(function()
        Wait(1000 * 60 * 10)

        if zonesInPerimeter[tostring(userId)] then
            zonesInPerimeter[tostring(userId)] = nil
            vCLIENT.removePerimeter(-1, tostring(userId))
        end
    end)
end)

AddEventHandler('playerDropped', function()
    local userId = vRP.getUserId(source)
    if not userId then return end

    if zonesInPerimeter[tostring(userId)] then
        zonesInPerimeter[tostring(userId)] = nil
        vCLIENT.removePerimeter(-1, tostring(userId))
    end

end)

AddEventHandler('vRP:playerSpawn', function(userId, source)
    if not userId then return end

    for k,v in pairs(zonesInPerimeter) do
        if v.coords then
            vCLIENT.createPerimeter(source, k, v.coords)
        end
    end
end)



exports('removeBlacklist', function(userId)
    if not userId or not tonumber(userId) then
        return
    end
    exports.oxmysql:execute('DELETE FROM vrp_user_data WHERE user_id = ? AND dkey = ?', { userId, 'facs:blacklist' })
    exports.oxmysql:execute('DELETE FROM vrp_user_data WHERE user_id = ? AND dkey = ?', { userId, 'ilegal:BlackList' })
    exports.oxmysql:execute('DELETE FROM vrp_user_data WHERE user_id = ? AND dkey = ?', { userId, 'Mirt1n:BlackList' })
end)

function src.checkUserIsCop()
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then
        return false
    end

    return ((vRP.hasPermission(userId, 'perm.disparo') or vRP.hasPermission(userId, 'perm.chamadomec') or vRP.hasPermission(userId, 'perm.chamadosbombeiro') 
    or vRP.hasPermission(userId, 'perm.unizk') or vRP.hasPermission(userId, 'perm.judiciario')) and vRP.checkPatrulhamento(userId)) or vRP.hasPermission(userId, 'developer.permissao')
end

RegisterCommand('blacklist', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then
        return
    end

    local query = exports.oxmysql:singleSync(
        'SELECT * FROM vrp_user_data WHERE user_id = ? AND dkey = ?',
        { userId, 'blacklist:cooldown' }
    )
    if query then
        local cooldown = tonumber(query.dvalue)
        if cooldown and cooldown > os.time() then
            local tempoRestante = cooldown - os.time()
            TriggerClientEvent('Notify', source, 'negado', 'Aguarde ' .. tempoRestante .. ' segundos para remover sua blacklist.')
            return
        end
    end

    local confirm = vRP.request(source, 'Deseja remover sua blacklist por 5 milhões?', 30)
    if not confirm then
        return
    end

    if not vRP.tryFullPayment(userId, 5000000) then
        TriggerClientEvent('Notify', source, 'negado', 'Você não possui dinheiro suficiente.')
        return
    end

    exports.mirtin_orgs_v2:removerbl(userId)

    local cooldownTime = os.time() + (60 * 60 * 24 * 2)
    exports.oxmysql:executeSync(
        'INSERT INTO vrp_user_data(user_id, dkey, dvalue) VALUES(?, ?, ?) ON DUPLICATE KEY UPDATE dvalue = ?',
        { userId, 'blacklist:cooldown', cooldownTime, cooldownTime }
    )
    TriggerClientEvent('Notify', source, 'sucesso', 'Blacklist removida com sucesso.')
    vRP.sendLog(
        'https://discord.com/api/webhooks/1336415076319494175/HW_GBznz63LKeH_g9FqNnjknlU90nKYCOozVPgJhb5U9DM5LaFTQnW4cBLHPHxfeC4u1',
        'USUARIO ' .. userId .. ' REMOVEU SUA BLACKLIST'
    )
end)

RegisterCommand('addponto', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    if vRP.checkPatrulhamento(userId) then
        vRP.removePatrulhamento(userId)
        TriggerClientEvent('Notify', source, 'sucesso', 'Ponto de patrulhamento removido com sucesso.')
        return
    end

    vRP.setPatrulhamento(userId, true)
    TriggerClientEvent('Notify', source, 'sucesso', 'Ponto de patrulhamento adicionado com sucesso.')
end)

function src.checkAutoPilotPermission()
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then
        return false
    end

    local hasPermission = false
    local perms = {
        {permType = 'perm', perm = 'developer.permissao'},
    }

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

    return hasPermission
end

function src.checkRGBPermission()
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then
        return false
    end

    local hasPermission = false
    local perms = {
        {permType = 'perm', perm = 'developer.permissao'},
    }

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

    return hasPermission
end

local cooldownBlips = {}

RegisterCommand('blips', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    local org = vRP.getUserGroupOrg(userId)
    if not org or org == '' then return end

    if not vRP.hasPermission(userId, 'perm.ilegal') then return end

    if cooldownBlips[userId] and cooldownBlips[userId] > os.time() then
        TriggerClientEvent('Notify', source, 'negado', 'Aguarde '..(cooldownBlips[userId] - os.time())..' segundos para adicionar outro blip.')
        return
    end

    cooldownBlips[userId] = os.time() + 30

    TriggerClientEvent('craft:showBlips', source, org)
    TriggerClientEvent('chest:showBlips', source, org)
    TriggerClientEvent('garage:showBlips', source, org)
    TriggerClientEvent('routes:showBlips', source, org)
end)

RegisterCommand('rtatuagem', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    if not vRP.hasPermission(userId, 'developer.permissao') then
        return
    end

    local nuserId = tonumber(args[1])
    if not nuserId then
        return
    end

    vRP.updateUserApparence(nuserId, "tattos", {})
    vRP.execute("apparence/tattos",{ user_id = nuserId, tattos = json.encode({}) })
    local nSource = vRP.getUserSoure(nuserId)
    if nSource then
        exports.nova_tatoos:setTattos(source, {})
    end
    TriggerClientEvent('Notify', source, 'sucesso', 'Tatuagens removidas com sucesso!')
end)

RegisterNetEvent('likizao_module:reportAttachViolation_2', function(netId)
    print('likizao_module:reportAttachViolation_2', netId)
    local entity_handle = NetworkGetEntityFromNetworkId(netId)
    if entity_handle and DoesEntityExist(entity_handle) then
        local owner = NetworkGetFirstEntityOwner(entity_handle)
        if owner == source then
            return
        end
        local attachedTo = GetEntityAttachedTo(entity_handle)
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(source), false)
        if not vehicle or vehicle <= 0 then return end
        if attachedTo == vehicle then
            print("ATTACHED VEHICLE")
            DeleteEntity(entity_handle)
            print("LikizaoModule:Report", "ATTACH_ENTITY", owner)
            TriggerEvent("AC:ForceBan", owner, {
                reason = "ATTACH_2"
            })
            -- LikizaoModule:Report(owner, "ATTACH_ENTITY", false)
            -- exports[GetCurrentResourceName()]:blockEntitySpawn(owner, "all")
        end
    end
end)

