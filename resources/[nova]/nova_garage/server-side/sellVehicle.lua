function serverFunctions.sellVehicle(vehicleData)
    local src = source

    local user_id = vRP.getUserId(src)

    if not vehicleData or not next(vehicleData) then return end

    local vehicleSpawn = vehicleData['vehicle']['key']
    local vehicleName = vehicleData['vehicle']['name']
    local vehiclePrice = tonumber(vehicleData['price'])

    local status, time = exports['vrp']:getCooldown(user_id, "veh")

    if not status then return TriggerClientEvent('Notify', src, 'negado', 'Você deve esperar para efetuar outra venda.') end

    exports['vrp']:setCooldown(user_id, "veh", 3)

    local query = vRP.query("bm_module/dealership/getVehicle", { user_id = user_id, vehicle = vehicleSpawn })
    if #query <= 0 then
        return TriggerClientEvent("Notify",src,"negado","Você não possui esse veiculo em sua garagem.", 5)
    end

    local target_user_id = vehicleData['userId']
    local target_source = vRP.getUserSource(target_user_id)

    if not target_source then
        return TriggerClientEvent("Notify",src,"negado","Este cidadão não se encontra na cidade no momento.", 5)
    else
        if GetEntityHealth(GetPlayerPed(target_source)) <= 105 then
            return TriggerClientEvent("Notify",src,"negado","Este cidadão não se encontra na cidade no momento.", 5)
        end
    end

    local query = vRP.query("bm_module/dealership/getVehicle", { user_id = target_user_id, vehicle = vehicleSpawn })

    if #query > 0 then
        return TriggerClientEvent("Notify",src,"negado","O jogador já possuí esse veículo na garagem.", 5)
    end

    if blacklistSell[vehicleSpawn] then
        return TriggerClientEvent("Notify",src,"negado","Você não pode transferir este veiculo.", 5)
    end

    local rows = vRP.query("vRP/get_veiculos_status", {user_id = user_id, veiculo = data.index})

    if rows and next(rows) then
        local vehicleStatus = tonumber(rows[1]['status'])
        
        local statusTrigger = {
            [1] = function()
                return TriggerClientEvent("Notify",src,"negado","Você não pode transferir um veiculo desmanchado e/ou detido!", 5)
            end,

            [2] = function()
                return TriggerClientEvent("Notify",src,"negado","Você não pode transferir um veiculo desmanchado e/ou detido!", 5) 
            end 
        }
        if statusTrigger[vehicleStatus] then
            statusTrigger[vehicleStatus]()
        else
            return
        end
    end

    if user_id == target_user_id then
        return TriggerClientEvent("Notify",src,"negado","Você não pode transferir um veiculo para si mesmo.", 5) 
    end

    local maxCars, totalCars = exports["nova_dealership"]:getUserAmountCars(target_user_id)

    if totalCars >= maxCars then
        return TriggerClientEvent("Notify", target_source,"negado","Você não possui mais vagas na garagem.", 5)
    end

    TriggerClientEvent("Notify",src,"sucesso","Você enviou a proposta para o jogador... aguarde.", 5)

    local buyVehicle = vRP.request(target_source, "Você deseja comprar o veiculo <b>"..vehicleName.."</b> por "..vRP.format(vehiclePrice).." ?", 30)


    if not buyVehicle then
        TriggerClientEvent("Notify",src,"negado","O Jogador recusou sua proposta.", 5)
        TriggerClientEvent("Notify",target_source,"negado","Você recusou a proposta.", 5)
        return
    end

    if not vRP.tryFullPayment(target_user_id, vehiclePrice) then
        TriggerClientEvent("Notify",src,"negado","O Jogador não possui dinheiro.", 5)
        TriggerClientEvent("Notify",target_source,"negado","Você não possui dinheiro.", 5)
        return
    end

    TriggerClientEvent("Notify",src,"sucesso","Você vendeu esse veiculo.", 5)
    TriggerClientEvent("Notify",target_source,"sucesso","Você comprou esse veiculo.", 5)

    vRP._giveBankMoney(user_id, vehiclePrice)

    print(json.encode(vehicleData, {indent = true}))

    vRP._execute("bm_module/garages/updateOwnerVehicle", { new_owner = target_user_id, user_id = user_id, veiculo = vehicleSpawn, portamalas = json.encode({}) })

    vRP.sendLog("https://discord.com/api/webhooks/1313521523780227132/TdJvTkC_1BLQ7r_freIo90nRCddeGl_mL9m7zsswcrg2lvFV4ifK-mnjc7-KmY1wrzHx", "[COMPROU] " ..target_user_id.. " | [VENDEU] "..user_id.." | VALOR "..vehiclePrice.." | VEICULO: "..vehicleName.."")
    
    exports["vrp_admin"]:generateLog({
        category = "admin",
        room = "vender-veiculo-player",
        user_id = user_id,
        message = ( [[O USER_ID %s VENDEU O VEICULO %s PARA O USER_ID %s PELO VALOR %s]] ):format(user_id, vehicleName, target_user_id, vehiclePrice)
    })
end