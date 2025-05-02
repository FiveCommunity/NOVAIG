----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("hud",src)
vCLIENT = Tunnel.getInterface("hud")

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE CLIMA
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local hora = 12
local minuto = 0
GlobalState.time = {}

Citizen.CreateThread(function()
    while true do
        if parseInt(hora) >= 00 and parseInt(hora) < 8 then
            minuto = minuto + 2
        else
            minuto = minuto + 2
        end

        if parseInt(minuto) >= 60 then
            hora = hora + 1
            minuto = 0

            if parseInt(hora) >= 24 then
                hora = 0
            end
        end

        GlobalState.time = { hora,parseInt(minuto) }

        Citizen.Wait( 10 * 1000 )
    end
end)

RegisterCommand('time', function(source,args)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "developer.permissao") then
            if args[1] and args[2] and parseInt(args[1]) >= 0 and parseInt(args[1]) <= 23 and parseInt(args[2]) >= 0 and parseInt(args[2]) <= 60 then
                hora = parseInt(args[1])
                minuto = parseInt(args[2])

                GlobalState.time = { hora,parseInt(minuto) }
                vRP.sendLog('','ID '..user_id..' utilizou /time '..hora..' '..minuto)
            else
                TriggerClientEvent("Notify",source,"negado","Digite o tempo corretamente, entre 00 00 ate 23 00", 5)
            end
        end
    end
        
end)

RegisterCommand("cupomtoggle", function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasPermission(user_id,"developer.permissao") or vRP.hasGroup(user_id,"TOP1") then 
        TriggerClientEvent("Lotus:SwitchCupom",source)
    end    
end)

function src.checkhud()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"developer.permissao") or vRP.hasPermission(user_id,"respeventos.permissao") or vRP.hasPermission(user_id,"perm.tiktok") 
    or vRP.hasGroup(user_id, 'cconteudo') or vRP.hasGroup(user_id, 'respeventoslotusgroup@445') or vRP.hasGroup(user_id, 'auxiliareventos') then
        return true
    end

    return false
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OTHERS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[AddEventHandler('vRP:playerJoinGroup', function(user_id, group)
    local source = vRP.getUserSource(user_id)
    if group == 'Inicial' then 
        
    end
end)]]
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OTHERS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('vRP:playerJoinGroup', function(user_id, group)
    local source = vRP.getUserSource(user_id)
    if group == 'TikTok' then 
        local vehicleList = { "bmws","evo9","rmodx6" }
        local vehicleLog = false
        for _,name in pairs(vehicleList) do 
            local result = exports["oxmysql"]:query_async("SELECT veiculo FROM vrp_user_veiculos WHERE veiculo = @veiculo AND user_id = @user_id",{ veiculo = name, user_id = user_id })
            if #result <= 0 then 
                vRP.execute("bm_module/dealership/addUserVehicle", { user_id = user_id, vehicle = name, ipva = os.time() })
                vehicleLog = true 
            end
        end

        if vehicleLog then 
            print("VEÍCULOS DO VIP TIKTOK ADICIONADO PARA O PASSAPORTE : "..user_id)
        end
    end
end)
----------------------------------------------------------------------------------------------------------------------------------
-- SYSTEM NITRO
----------------------------------------------------------------------------------------------------------------------------------
local cachedData = {}
local function updateCachedData(user_id, vname, data)
    cachedData[user_id] = cachedData[user_id] or {}
    cachedData[user_id][vname] = data
end

RegisterNetEvent("sync:updateNitro")
AddEventHandler("sync:updateNitro", function(vehi, turbo)
    local source, user_id = source, vRP.getUserId(source)
    local custom, infos = src.getCustom()
    if custom and infos.veh == vehi then
        custom.nitro_q = turbo
        updateCachedData(infos.placa_user_id, infos.vname, custom)
    end
end)

local function getVehicleData(user_id, vname)
    if cachedData[user_id] and cachedData[user_id][vname] then
        return cachedData[user_id][vname]
    end
    local rows = vRP.query("vRP/get_nitro", {user_id = user_id, veiculo = vname})
    if rows[1] then
        local data = json.decode(rows[1].nitro or {}) or {}
        updateCachedData(user_id, vname, data)
        return data
    end
    return false
end

function src.haveKitNitro()
    local source, user_id = source, vRP.getUserId(source)
    return vRP.getInventoryItemAmount(user_id, itemKitNitro) >= 1
end

local function getInfos()
    local source, user_id = source, vRP.getUserId(source)
    local mPlaca, mName, mNet, _, _, _, _, _, mVeh = vRPclient.ModelName(source, 5)
    if mName and mPlaca then
        local placa_user_id = vRP.getUserByRegistration(mPlaca)
        if placa_user_id ~= nil then
            return { placa_user_id = placa_user_id, vname = mName, placa = mPlaca, veh = mVeh }
        end
    end
    return false
end

function src.getInfosVeh(veh)
    local source = source
	local mPlaca,mName,mNet,mPortaMalas,mPrice,mLock,_,_,mVeh = vRPclient.ModelName(source, 5)
    if mNet == veh then
        return vehicle
    end
    return false
end

function src.getCustom()
    local infos = getInfos()
    if infos then
        local data = getVehicleData(infos.placa_user_id, infos.vname)
        if data then
            return data, infos
        end
    end
    return false
end

RegisterNetEvent("updateCachedData")
AddEventHandler("updateCachedData", function(user_id, vname, data)
    updateCachedData(user_id, vname, data)
end)

function src.setCustom(custom, infos)
    if infos then
        vRP.execute("vRP/update_nitro", { user_id = infos.placa_user_id, veiculo = infos.vname, nitro = json.encode(custom) })
        updateCachedData(infos.placa_user_id, infos.vname, custom)
    end
end

function src.checkPermission()
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 
    
    for k,v in pairs(permissaoParaInstalarNitro) do 
        if vRP.hasPermission(user_id,v) then 
            return true 
        end
    end

    return false
end

function src.setNitro(vehi)
    local source, user_id = source, vRP.getUserId(source)
    if vRP.tryGetInventoryItem(user_id, itemKitNitro, 1) then
        local custom, infos = src.getCustom()
        if custom and infos.veh == vehi then
            custom.nitro, custom.nitro_q = 1, 100
            vRP.execute("vRP/update_nitro", { user_id = infos.placa_user_id, veiculo = infos.vname, nitro = json.encode(custom) })
            updateCachedData(infos.placa_user_id, infos.vname, custom)
        end
    else 
        TriggerClientEvent('Notify',source,'negado','Você não possui 1x kit nitro.')
    end
end

function src.setQtdNitro(qtd, vehi)
    local source, user_id = source, vRP.getUserId(source)
    local custom, infos = src.getCustom()
    if custom and infos.veh == vehi then
        custom.nitro_q = qtd
        vRP.execute("vRP/update_nitro", { user_id = infos.placa_user_id, veiculo = infos.vname, nitro = json.encode(custom) })
        updateCachedData(infos.placa_user_id, infos.vname, custom)
    end
end

function src.setQtdNitro2(qtd, vehi)
    local source, user_id = source, vRP.getUserId(source)
    if vRP.tryGetInventoryItem(user_id, itemGarrafaNitro, 1) then
        local custom, infos = src.getCustom()
        if custom and infos.veh == vehi then
            custom.nitro_q = qtd
            vRP.execute("vRP/update_nitro", { user_id = infos.placa_user_id, veiculo = infos.vname, nitro = json.encode(custom) })
            updateCachedData(infos.placa_user_id, infos.vname, custom)
        end
    else 
        TriggerClientEvent('Notify',source,'negado','Você não possui 1x garrafa nitro.')
    end
end

-- function src.checkVehicleNitro()
--     local custom = src.getCustom()
--     if custom then
--         if custom.nitro == 1 then
--             return true
--         end
--     end
--     return false
-- end

-- function src.getVehicleQuantityNitro()
--     local custom = src.getCustom()
--     if custom then
--         return custom.nitro_q
--     end
--     return false
-- end

function src.anim(name, dict, time, bool)
    local source = source
    vRPclient._playAnim(source, false, {{"mini@repair", "fixing_a_player"}}, true )
    SetTimeout(time, function()
        vRPclient.DeletarObjeto(source)
        vRPclient._stopAnim(source, false)
        vCLIENT.instalando(source, false)
    end)
end

RegisterServerEvent("tryCapo")
AddEventHandler("tryCapo",function(nveh, abrir)
    TriggerClientEvent("syncCapo", -1, nveh, abrir)
end)

RegisterNetEvent("sync:alignMechanicAndCarHeading")
AddEventHandler("sync:alignMechanicAndCarHeading", function(h, n)
    TriggerClientEvent("apz:alignMechanicAndCarHeading", -1, h, n)
end)

Citizen.CreateThread(function()
    Citizen.Wait(3000)
    vCLIENT.createNitroValidation(-1)
end)

RegisterCommand('nitro', function(source, args)
    vCLIENT.createNitroValidation(source)
end)

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
    Citizen.Wait(3000)
    vCLIENT.createNitroValidation(source)
end)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MAKAPOINTS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local timeLeft = {}
AddEventHandler("vRP:playerSpawn",function(user_id,source)
    timeLeft[user_id] = os.time() + 3600
end)

AddEventHandler("vRP:playerLeave",function(user_id,source)
    timeLeft[user_id] = nil
end)

Citizen.CreateThread(function()
    while true do
        for k,v in pairs(timeLeft) do 
            if os.time() > timeLeft[k] then 
                local source = vRP.getUserSource(k)
                if source then 
                    local qtdMakapoints = math.random(1, 10)
                    vRP.giveMakapoints(k, qtdMakapoints)
                    TriggerClientEvent("vrp_sound:source", source, "makapoints", 0.1)
                    TriggerClientEvent('NotifyMakapoints', source, qtdMakapoints)
                    timeLeft[k] = os.time() + 3600
                end
            end
        end

        Citizen.Wait(60000)
    end
end)

RegisterCommand('makapoints', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasGroup(user_id,'TOP1') then
            if not args[1] then 
                TriggerClientEvent('Notify',source,'Você deve inserir uma quantidade.')
                return 
            end
            
           
			vRP.giveMakapoints(user_id,parseInt(args[1]))
			TriggerClientEvent('NotifyMakapoints',source,parseInt(args[1]))
			TriggerClientEvent("vrp_sound:source", source, "makapoints", 0.1)

            SetTimeout(4000,function()
                timeLeft[user_id] = 0
            end)
        end
    end
end)

local disabledRecruitment = {}
local recruitmentQueue = {}
local isProcessingQueue = false
local usersInCooldown = {}

RegisterCommand('hiderec', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    if not disabledRecruitment[userId] then
        disabledRecruitment[userId] = true
        TriggerClientEvent('Notify', source, 'sucesso', 'Recrutamento oculto com sucesso')
        TriggerClientEvent('HideRecruitment', source, true)
    else
        disabledRecruitment[userId] = nil
        TriggerClientEvent('Notify', source, 'sucesso', 'Recrutamento visível com sucesso')
        TriggerClientEvent('HideRecruitment', source, false)
    end
end)

RegisterCommand('recdiv', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    local org = vRP.getUserGroupOrg(userId)
    if not org or org == '' then return end

    if not vRP.hasPermission(userId, 'perm.'..(org:lower())) then return end

    if usersInCooldown[userId] and usersInCooldown[userId] > os.time() then
        TriggerClientEvent('Notify', source, 'negado', 'Você está em cooldown aguarde.')
        return
    end

    usersInCooldown[userId] = os.time() + 60 * 15

    local message = vRP.prompt(source, 'Digite a mensagem que deseja enviar', '')
    if not message or message == '' then return end

    table.insert(recruitmentQueue, {message = message, org = org})

    if not isProcessingQueue then
        processRecruitmentQueue()
    end

    vRP.sendLog('https://discord.com/api/webhooks/1340976315376996423/cU_FWJhIhojo0VXJGltxXghkwe9BoWRwTxzhY6itC7etXrjO7U-dV5vuw198vy2ayQE_', 'ID: '..userId..' | ORG: '..org..' | MENSAGEM: '..message)
    vRP.sendLog('https://discord.com/api/webhooks/1330956032477757632/oflA6eksNyM7Dezqp7jNu8nB4KtxXWtMg-AlLYYcPy42iqPzq91OLch8TnrjBanDAwgo', 'ID: '..userId..' | ORG: '..org..' | MENSAGEM: '..message)
end)

function processRecruitmentQueue()
    if #recruitmentQueue > 0 then
        isProcessingQueue = true
        local message = table.remove(recruitmentQueue, 1)

        for _, nPlayer in ipairs(GetPlayers()) do
            local nSource = tonumber(nPlayer)
            local nUserId = vRP.getUserId(nSource)
            if nUserId and not disabledRecruitment[nUserId] then
                local nOrg = vRP.getUserGroupOrg(nUserId)
                if not nOrg or nnOrg == '' then 
                    TriggerClientEvent('lotus:recrutamento', nSource, message.message, message.org)
                end
            end
        end

        Citizen.SetTimeout(15000, function()
            processRecruitmentQueue()
        end)
    else
        isProcessingQueue = false
    end
end