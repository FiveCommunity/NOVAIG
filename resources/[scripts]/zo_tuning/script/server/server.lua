Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
Tools = module("vrp", "lib/Tools")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}

Tunnel.bindInterface(GetCurrentResourceName(), src)
Proxy.addInterface(GetCurrentResourceName(), src)

vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

vehiclesInfoCache = {}

local customDefault = {
    neon = {
        power = false,
        color = '#ffffff'
    },
  
    xenon = {
        power = false,
        color = '#ffffff'
    },
  
    suspensao = {
        max = -0.1,
        min = 0.1,
        value = 0
    },
  
    camber = {
        frontal = 0,
        ambos = 0,
        traseiro = 0
    },
  
    offset = {
        frontal = 0,
        ambos = 0,
        traseiro = 0
    },

    antiLag = {
        active = 0
    },

    westgate = {
        active = 0
    },

    remap = {},

    purgador = {
        active = 0,
        value = 1
    },
}

function table.empty(self)
    for _, _ in pairs(self) do return false end
    return true
end

function src.giveItens(itens, sSource)
    local source = source
    if source == nil then source = sSource end
    local user_id = zof.getUserId(source)

    for i, v in pairs(itens) do
        zof.giveInventoryItem(user_id, v.item, v.qtd)
    end
end

function src.checkItens(itens, sSource)
    local source = source
    if source == nil then source = sSource end
    local user_id = zof.getUserId(source)

    if json.encode(itens) == json.encode({}) then return true end

    local itensName = ""

    for i, v in pairs(itens) do
        if zof.getInventoryItemAmount(user_id, v) > 0 then return true end

        itensName = itensName .. "- " .. zof.itemNameList(v) .. "<br/>"
    end

    return false, itensName
end

function src.removeItens(itens)
    local source = source
    local user_id = zof.getUserId(source)

    local possuiItens = src.checkItens(itens, source)
    if possuiItens then
        for i, v in pairs(itens) do zof.tryGetInventoryItem(user_id, v, 1) end
    end

    return possuiItens
end

function src.checkPerms(perms)
    local source = source
    local user_id = zof.getUserId(source)

    if perms == nil then
        return true
    end

    if type(perms) == "string" then
        return zof.hasPermission(user_id, perms)
    end

    for i, v in ipairs(perms) do
        if zof.hasPermission(user_id, v) then
            return true
        end
    end

    local next = next
    return next(perms) == nil
end

function src.anim(anim)
    local source = source
    zof.playAnim(source, anim)

    SetTimeout(anim.time, function()
        zof.deletarObjeto(source)
        zof.stopAnim(source, false)
    end)
end

RegisterNetEvent("zo_tuning_suspe")
AddEventHandler('zo_tuning_suspe', function(vehicle, pAlturaAtual, pAlturaAnterior)
    local source = source

    local altura = pAlturaAnterior
    local subir = pAlturaAtual > pAlturaAnterior

    vCLIENT.soundSuspensao(source, subir)

    if subir then
        while altura < pAlturaAtual do
            altura = altura + 0.003
            TriggerClientEvent("synczosuspe_tuning", -1, vehicle, altura)
            Citizen.Wait(1)
        end
    else
        while altura > pAlturaAtual do
            altura = altura - 0.003
            TriggerClientEvent("synczosuspe_tuning", -1, vehicle, altura)
            Citizen.Wait(1)
        end
    end
end)

function src.checkVehicleBlackList()
    local source = source
    local user_id = zof.getUserId(source)

    local vehicle, vnetid, placa, vname, lock, banned = vCLIENT.vehList(source, 3)
    for i, v in pairs(veiculosBlackList) do
        if v == vname then return true end
    end
end

function src.getInfos(sSource, params)
    local source = source
    if source == nil then
        source = sSource
    end

    local user_id = zof.getUserId(source)

    if params then
        local placa = GetVehicleNumberPlateText(params.vehicle)
        local placa_user_id = zof.getUserByRegistration(placa)

        if placa_user_id ~= nil then
            infos = {
                placa_user_id = placa_user_id,
                vname = params.vname,
                placa = placa,
                veh = params.vehicle,
                vnetid = tostring(params.vnetid),
                keyCache = tostring(params.vnetid) .. placa,
                key = placa_user_id .. "veh_" .. params.vname .. "placa_" .. placa
            }
        end
    end

    local vehicle, vnetid, placa, vname, lock, banned = vCLIENT.vehList(source, 3)
    if veiculosBlackList[vname] then return nil end

    if vehicle and placa then
        local placa_user_id = zof.getUserByRegistration(placa)

        if placa_user_id and placa_user_id ~= nil then
            return {
                placa_user_id = placa_user_id,
                vname = vname,
                placa = placa,
                veh = vehicle,
                vnetid = tostring(vnetid),
                keyCache = tostring(vnetid) .. placa,
                key = placa_user_id .. "veh_" .. vname .. "placa_" .. placa
            }
        end
    end

    return nil
end

function src.getCustom(infos)
    if infos then
        local tuning = zof.getSData("zoCustomVehicle:" .. infos.key)
        local custom = json.decode(tuning) or {}

        if table.empty(custom) then 
            return customDefault, nil
        end

        return custom, infos
    end

    return customDefault, nil
end

function src.setCustom(custom, infos, vNetId)
    if infos then
        zof.setSData("zoCustomVehicle:" .. infos.key, json.encode(custom))

        custom.vnetid = vNetId
        vehiclesInfoCache[infos.keyCache] = custom
    end
end

function src.checkVehicleInfos(params)
    local source = source


    local infos = src.getInfos(source, params)

    if infos then
        if vehiclesInfoCache[infos.keyCache] then
            return vehiclesInfoCache[infos.keyCache]
        end

        local custom, isNotDefault = src.getCustom(infos)
        if isNotDefault ~= nil then
            custom.vnetid = infos.vnetid

            vehiclesInfoCache[infos.keyCache] = custom
        end

        return custom
    end

    return false
end

AddEventHandler('vRP:playerSpawn', function(user_id, source)
    TriggerEvent('zo_tuning:updateVehicles', source, vehiclesInfoCache)
end)