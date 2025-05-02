local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

Server = {}
Tunnel.bindInterface(GetCurrentResourceName(), Server)
Client = Tunnel.getInterface(GetCurrentResourceName())

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE DEALERSHIP
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    local startTimer = os.time()
    for k, v in pairs(Prepare) do
        vRP.prepare(k, v)
    end

    local getVehicles = vRP.query("bm_module/dealership/getVehicles", {})

    if not next(getVehicles) then return print('^1[nova_dealership]^7 Não foi encontrado nenhum veículo na tabela!') end

    if GetResourceState('nova_garage') ~= 'started' then
        while GetResourceState('nova_garage') ~= 'started' do
            Wait(1000)
        end
    end

    local vehiclesRegisteredGarage = exports.nova_garage:getListVehicles()

    for i = 1, #getVehicles do
        local vehicleParams = vehiclesRegisteredGarage[GetHashKey(getVehicles[i].vehicle)]

        if not vehicleParams then
            goto continue
        end

        local isVip = false

        if vehicleParams then
            if vehicleParams.type == 'vip' then
                isVip = true
            end
        end

        Dealership:addCar(getVehicles[i].vehicle, {
            name = vehicleParams.name,
            stock = getVehicles[i].stock,
            price = vehicleParams.price,
            type = vehicleParams.type,
            trunk = vehicleParams.trunk,
            vip = isVip,
            amountSell = getVehicles[i].amountSell
        }, false)

        ::continue::
    end

    local during = os.time() - startTimer
    print('Processamentos concluídos em '.. string.format("%.2f", during) .. ' segundos')
end)

function Server.getVehicles()
    local source = source

    return Dealership.list
end

function Server.getMyVehicles()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return {} end

    return Dealership:getUserVehicles(user_id)
end

function Server.buyVehicle(vehicle, color)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return false end

    Dealership:buyVehicle(user_id, source, vehicle.spawn, color)
end

function Server.sellVehicle(vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return false end

    Dealership:sellVehicle(user_id, source, vehicle)
end

function Server.setDimension(status)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    if status then
        SetPlayerRoutingBucket(source, user_id)
    else
        SetPlayerRoutingBucket(source, 0)
    end
end

function Server.getMostSold()
    return Dealership:getTopSoldVehicles()
end

RegisterCommand('conce', function(source, args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if user_id ~= 1 or user_id ~= 2 then
            return
        end
        if not vRP.hasPermission(user_id, "developer.permissao") then return end

        local query = vRP.query("bm_module/dealership/getVehicles", {})
        local t = ""

        for i = 1, #query do
            t = t..", "..query[i].vehicle
        end

        local v_value = vRP.prompt(source, "Digite o veiculo: ", t)
        if v_value == "" or not v_value then
            return
        end

        local s_value = vRP.prompt(source, "Digite a quantidade de estoque: ", 100)
        if s_value == "" or not s_value then
            return
        end

        local t_value = vRP.prompt(source, "Esse veículo é vip?: 1 PARA SIM OU 0 PARA NÃO", 1)
        if t_value == "" or not t_value then
            return
        end

        Dealership:updateStock(v_value, s_value)
        vRP._execute("bm_module/dealership/createNewVehicleStock", { vehicle = v_value, stock = s_value, vip = t_value })
        TriggerClientEvent("Notify",source,"sucesso","Você alterou o stock do veiculo: "..v_value.." para "..s_value.."x .", 5)
    end
end, false)


exports('getUserAmountCars', function(user_id)
    return Dealership:getUserAmountCars(user_id)
end)