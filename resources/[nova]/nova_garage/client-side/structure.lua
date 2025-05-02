function requestVehiclesUserTable()
    local tableVehiclesUser = {}

    if types[opennedGarageType].type == "public" then
        local list = serverFunctions.garageGetUserVehicles()
    
        if not list or not next(list) then 
            return 
        end

        for _, vehicleData in pairs(list) do

            if types[opennedGarageType].listCars == nil or types[opennedGarageType].listCars[vehicleClasses[GetVehicleClassFromName(GetHashKey(vehicleData.vehicle))]] or vehicleClasses[GetVehicleClassFromName(GetHashKey(vehicleData.vehicle))] == nil then
                local typeCar = ((listCars[GetHashKey(vehicleData.vehicle)] and listCars[GetHashKey(vehicleData.vehicle)]["type"] == "vip") and "special" or "normal")
                local parametersInsertVehicle = {
                    ["type"] = typeCar,
                    ["key"] = vehicleData.vehicle,
                    ["name"] = (listCars[GetHashKey(vehicleData.vehicle)] == nil) and vehicleData.vehicle or listCars[GetHashKey(vehicleData.vehicle)].name,
                    ["category"] = vehicleClassesTranslated[GetVehicleClassFromName(GetHashKey(vehicleData.vehicle))],
                    ["plate"] = vehicleData.plate,
                    ["image_url"] = main["dir"]..vehicleData.vehicle..'.png',
                    ["max_speed"] = math.floor(GetVehicleModelEstimatedMaxSpeed(GetHashKey(vehicleData.vehicle)) * 3.605936 or 0),
                    ["agility"] = math.floor((GetVehicleModelEstimatedAgility(GetHashKey(vehicleData.vehicle)))*100 or 0),
                    ["braking"] = math.floor((GetVehicleModelMaxBraking(GetHashKey(vehicleData.vehicle))/1.5)*100 or 0),
                    ["grip"] = math.min(math.floor(((GetVehicleModelMaxTraction(GetHashKey(vehicleData.vehicle)) / 1.5) * 100) or 0), 100),
                    ["ipva"] = not vehicleData.ipva,
                    ["arrested"] = vehicleData.status,
                    ["service"] = false,
                }

                table.insert(tableVehiclesUser, parametersInsertVehicle)
            end
        end
    elseif types[opennedGarageType].type == "service" then
        local arrestedVehicles = serverFunctions.getOrgArrestedVehicles(types[opennedGarageType].vehicles)
        for _, vehicleData in pairs(types[opennedGarageType].vehicles) do

            local typeCar = ((listCars[GetHashKey(vehicleData.vehicle)] and listCars[GetHashKey(vehicleData.vehicle)]["type"] == "vip") and "special" or "normal")

            local parametersInsertVehicle = {
                ["type"] = typeCar,
                ["key"]  = vehicleData.vehicle,
                ["name"] = (listCars[GetHashKey(vehicleData.vehicle)] == nil) and vehicleData.vehicle or listCars[GetHashKey(vehicleData.vehicle)].name,
                ["category"] = vehicleClassesTranslated[GetVehicleClassFromName(GetHashKey(vehicleData.vehicle))],
                ["plate"] = "Teste",
                ["image_url"] = main["dir"]..vehicleData.vehicle..'.png',
                ['max_speed'] = math.floor(GetVehicleModelEstimatedMaxSpeed(GetHashKey(vehicleData.vehicle)) * 3.605936 or 0),
                ['braking'] = math.floor((GetVehicleModelMaxBraking(GetHashKey(vehicleData.vehicle))/1.5)*100 or 0),
                ['agility'] = math.floor((GetVehicleModelEstimatedAgility(GetHashKey(vehicleData.vehicle)))*100 or 0),
                ["grip"] = math.floor((GetVehicleModelMaxTraction(GetHashKey(vehicleData.vehicle)) * 100) or 0),
                ["ipva"] = true,
                ["arrested"] = arrestedVehicles[vehicleData.vehicle],
                ["custom"] = {},
                ["service"] = true,
            }

            table.insert(tableVehiclesUser, parametersInsertVehicle)
        end
    end

    return tableVehiclesUser
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VERIFYER SPAWN IN COORDS IS BLOCKED
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function clientFunctions.garageCheckSpawnLock(garageID)
    local spawnCoords
    local liverys
    for k,v in pairs(garages[garageID].spawnCoords) do
        if GetClosestVehicle(v.x,v.y,v.z, 4.0, 0 ,71) == 0 then
            spawnCoords = v
            break;
        end
    end

    return spawnCoords
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN VEHICLE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function spawnVehicle(vehicleData)
    if segundos <= 0 then
        segundos = 2
        local spawnCoords = clientFunctions.garageCheckSpawnLock(opennedGarageId)

        if spawnCoords then
            if types[opennedGarageType].type == "public" then
                if vehicleData["ipva"] and not vehicleData["arrested"] then
                    TriggerServerEvent("garage:garageTrySpawnVehicle", true, vehicleData.key, spawnCoords)
                else
                    serverFunctions.garageTryPaymentVehicle(vehicleData.key)
                end
            else
                if vehicleData["arrested"] then
                    serverFunctions.tryPaymentOrgVehicle(vehicleData.key)
                else
                    TriggerServerEvent("garage:garageTrySpawnVehicle", false, vehicleData.key, spawnCoords, types[opennedGarageType], opennedGarageId, opennedGarageType)
                end
            end
        else
            TriggerEvent('Notify', 'negado', 'Todas as vagas dessa garagem estão lotadas.', 5)  
        end
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DESPAWN VEHICLE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function pullVehicle(vehicleData)
    if segundos == 0 then
        if types[opennedGarageType].type == "public" then
            if vehicleData["arrested"] then
                local vehicle = GetClosestVehiclePlayer(20.0)
                if vehicle and vehicle > 0 then
                    serverFunctions.garageStoreUserVehicle(true, vehicleData["key"], vehicleData["arrested"], VehToNet(vehicle)) -- GUARDAR VEICULO PROXIMO
                else
                    TriggerEvent("Notify","negado","Nenhum veiculo proximo.",5)
                end
            else
                serverFunctions.garageStoreUserVehicle(true, vehicleData["key"])
            end
        else
            if vehicleData["arrested"] then
                local vehicle = GetClosestVehiclePlayer(20.0)
                if vehicle and vehicle > 0 then
                    serverFunctions.garageStoreUserVehicle(false, vehicleData["key"], vehicleData["arrested"], VehToNet(vehicle)) -- GUARDAR VEICULO PROXIMO
                else
                    TriggerEvent("Notify","negado","Nenhum veiculo proximo.",5)
                end
            else
                serverFunctions.garageStoreUserVehicle(false, vehicleData["key"])
            end
        end

        if blockDuplicate[vehicleData["key"]] then
            blockDuplicate[vehicleData["key"]] = nil
        end
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EVENTS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("garage:clientSpawnVehicle",function(name, info, isPersonal, spawnLoc)
    local mhash = GetHashKey(name)
    if not blockDuplicate[name] then
        blockDuplicate[name] = true
        SetTimeout(10 * 1000, function() if blockDuplicate[name] then blockDuplicate[name] = nil end end)

        while not HasModelLoaded(mhash) do
            RequestModel(mhash)

            Wait(200)
        end

        if isPersonal then
            if spawnLoc then
                local veh = CreateVehicle(mhash, spawnLoc.x,spawnLoc.y,spawnLoc.z,spawnLoc.w, true, true)
                    
                while not DoesEntityExist(veh) do
                    print("Entity nao encontrada")
                    Wait(200)
                end

                while not NetworkDoesEntityExistWithNetworkId(VehToNet(veh)) do
                    print("NETID nao encontrado")
                    Wait(200)
                end

                local netid = VehToNet(veh)

                if not IsEntityAVehicle(veh) then
                    print("Nao e um veiculo")
                    return
                end

                SetVehicleNumberPlateText(veh, info.plate)
                SetEntityAsMissionEntity(veh, true, true)
                SetVehicleOnGroundProperly(veh)
                SetVehRadioStation(veh, "OFF")
                SetVehicleDirtLevel(veh, 0.0)
                SetVehicleDoorsLocked(veh, 2)
                SetPedIntoVehicle(PlayerPedId(),veh,-1)
                SetVehicleEngineHealth(veh, info.engine + 0.0)
                SetVehicleBodyHealth(veh, info.body + 0.0)
                SetVehicleFuelLevel(veh, info.fuel + 0.0)
                SetModelAsNoLongerNeeded(mhash)
                SetVehicleMods(veh, info.custom)
                TriggerEvent("stancetuning:Apply",veh,name)


                TriggerServerEvent("garage:registerVehicle", name, netid, isPersonal)
            end
        else
            if spawnLoc then
                local veh = CreateVehicle(mhash, spawnLoc.x,spawnLoc.y,spawnLoc.z,spawnLoc.w, true, true)
                    
                while not DoesEntityExist(veh) do
                    print("Entity nao encontrada")
                    Wait(200)
                end

                while not NetworkDoesEntityExistWithNetworkId(VehToNet(veh)) do
                    print("NETID nao encontrado")
                    Wait(200)
                end

                local netid = VehToNet(veh)

                if not IsEntityAVehicle(veh) then
                    print("Nao e um veiculo")
                    return
                end

                SetVehicleNumberPlateText(veh, info.plate)
                SetEntityAsMissionEntity(veh, true, true)
                SetVehicleOnGroundProperly(veh)
                SetVehRadioStation(veh, "OFF")
                SetVehicleDirtLevel(veh, 0.0)
                SetVehicleDoorsLocked(veh, 2)
                SetPedIntoVehicle(PlayerPedId(),veh,-1)
                SetVehicleEngineHealth(veh, info.engine + 0.0)
                SetVehicleBodyHealth(veh, info.body + 0.0)
                SetVehicleFuelLevel(veh, info.fuel + 0.0)
                SetModelAsNoLongerNeeded(mhash)
                SetVehicleMods(veh, info.custom)
                TriggerServerEvent("garage:registerVehicle", name, netid, isPersonal)
                TriggerServerEvent('garage:registerBlockedVehicle', name, netid, info.livery)
                if info.opennedGarageType and info.opennedGarageType:find("Recrutamento") then
                    TriggerServerEvent("garage:registerFacVehicle", name, netid, info.opennedGarageType)
                end
                SetVehicleLivery(GetVehiclePedIsIn(PlayerPedId()), info.livery)
            end
        end
    end
end)

RegisterNetEvent("garage:updateVehicle",function(netid, info, isPersonal)
    if isPersonal then
        while not NetworkDoesEntityExistWithNetworkId(netid) do
            print("Nao encontrado netid")
            Wait(200)
        end

        local entity = NetworkGetEntityFromNetworkId(netid)

        while not DoesEntityExist(entity) do
            print("Entity nao encontrada")
            Wait(200)
        end

        if not IsEntityAVehicle(entity) then
            print("Nao eh um veiculo")
            return
        end

        local nveh = NetToVeh(netid)
        if nveh then
            SetVehicleDoorsLocked(nveh, 2)
            SetEntityAsMissionEntity(nveh, true, true)
            SetVehicleOnGroundProperly(nveh)
            SetVehRadioStation(nveh, "OFF")
            SetVehicleDirtLevel(nveh, 0.0)
            SetPedIntoVehicle(PlayerPedId(),nveh,-1)
            SetVehicleEngineHealth(nveh, info.engine + 0.0)
            SetVehicleBodyHealth(nveh, info.body + 0.0)
            SetVehicleFuelLevel(nveh, info.fuel + 0.0)
            SetVehicleMods(nveh, info.custom)          
        end
    else
        while not NetworkDoesEntityExistWithNetworkId(netid) do
            print("Nao encontrado netid")
            Wait(200)
        end

        local entity = NetworkGetEntityFromNetworkId(netid)

        while not DoesEntityExist(entity) do
            print("Entity nao encontrada")
            Wait(200)
        end

        if not IsEntityAVehicle(entity) then
            print("Nao eh um veiculo")
            return
        end

        local nveh = NetToVeh(netid)
        if nveh then
            SetVehicleDoorsLocked(nveh, 2)
            SetEntityAsMissionEntity(nveh, true, true)
            SetVehicleOnGroundProperly(nveh)
            SetVehRadioStation(nveh, "OFF")
            SetVehicleDirtLevel(nveh, 0.0)
            SetPedIntoVehicle(PlayerPedId(),nveh,-1)
            SetVehicleEngineHealth(nveh, info.engine + 0.0)
            SetVehicleBodyHealth(nveh, info.body + 0.0)
            SetVehicleFuelLevel(nveh, info.fuel + 0.0)
            SetVehicleMods(nveh, info.custom)          
        end
    end
end)

