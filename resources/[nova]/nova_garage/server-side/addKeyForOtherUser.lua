function serverFunctions.addKeyCarForOtherUser(vehicleData)
    local vehicleSpawn = vehicleData['vehicle']['key']
    local vehicleName = vehicleData['vehicle']['name']

    local src = source

    local user_id = vRP.getUserId(src)

    if not vehicleData or not next(vehicleData) then return end

    local status, time = exports['vrp']:getCooldown(user_id, "veh")

    if not status then return end

    exports['vrp']:setCooldown(user_id, "veh", 3)

    local target_user_id = vehicleData['userId']
    local target_source = vRP.getUserSource(target_user_id)

    if not target_source then
        return TriggerClientEvent("Notify",source,"negado","Este cidadão não se encontra na cidade no momento.", 5)
    end 

    local acceptKeys = vRP.request(target_source, "Você deseja aceitar a chave desse veiculo?", 30)
    
    if not acceptKeys then
        return TriggerClientEvent("Notify",src,"negado","O Cidadão recusou suas chaves.", 5)
    end
    
    if not vehKeys[user_id..":"..vehicleSpawn] then
        vehKeys[user_id..":"..vehicleSpawn] = {}
    end

    vehKeys[user_id..":"..vehicleSpawn][target_user_id] = vehicleSpawn

    TriggerClientEvent("Notify",src,"sucesso","Você adicionou o id: "..target_user_id.." em seu veiculo.", 5)
end