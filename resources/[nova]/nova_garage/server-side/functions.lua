userPersonalCar = {}
userJobCar = {}
housesGarages = {}
allSpawnedCars = {}
lastEntitys = {}
vehKeys = {}

function serverFunctions.garageCheckPermission(permission, service)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if permission == "Warehouses" then 
            local warehousesPermission = false
            local queryWarehouses = exports.oxmysql:query_async("SELECT garages FROM warehouses WHERE user_id = @id",{ id = user_id })
            for _,v in pairs(queryWarehouses) do 
                if v.garages == 1 then 
                    warehousesPermission = true 
                    break 
                end
            end
            
            return warehousesPermission
        end
        
        if vRP.hasPermission(user_id, permission) then
            if service and not vRP.checkPatrulhamento(user_id) then 
                return false, TriggerClientEvent("Notify",source,"negado","Você precisa estar em serviço.",3000)
            end
            
            return true
        end

        return false
    end
end

function serverFunctions.garageCheckHouseOwner(home)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if housesGarages[home].tipo == "casa" then
            local owner = vRP.query("mirtin/ownerPropriedade", { houseID = home }) or 0
            if owner then
                if #owner > 0 then
                    if user_id == parseInt(owner[1].proprietario) then
                        return true
                    end
    
                    local moradores = json.decode(owner[1].moradores)
                    if moradores[tostring(user_id)] ~= nil then
                        return true
                    end
                end
            end
        end
    
        if housesGarages[home].tipo == "apartamento" then
            local owner = vRP.query("mirtin/ownerPropriedade", { houseID = home }) or 0
            if owner then
                if #owner > 0 then
                    for k,v in pairs(owner) do
                        if parseInt(v.proprietario) == parseInt(user_id) then
                            return true
                        end
                    end
                end
            end
        end
    
        TriggerClientEvent("Notify",source,"negado","Você não tem acesso à essa residência.",3000)
        return false
    end
end

-------------------------------------
-- STORE PROXIMITY VEHICLE
-------------------------------------

function serverFunctions.storeProximityVehicle(distance)

    local src = source

    local vehicle = clientFunctions.garageGetNearestVehicle(src, distance)
    if vehicle then

        if GetPedInVehicleSeat(NetworkGetEntityFromNetworkId(vehicle), -1) ~= 0 then
            TriggerClientEvent("Notify",src,"negado","Existe alguém no veiculo.",3000)
            return false
        end
        
        local plyCoords = GetEntityCoords(GetPlayerPed(src))
        local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]
    
        if allSpawnedCars[vehicle] and allSpawnedCars[vehicle][1] and allSpawnedCars[vehicle][2] then
            SaveVehicleInfos(allSpawnedCars[vehicle][1],allSpawnedCars[vehicle][2],allSpawnedCars[vehicle][3], NetworkGetEntityFromNetworkId(vehicle), src)
    
            if userPersonalCar[allSpawnedCars[vehicle][2]..":"..allSpawnedCars[vehicle][1]] then
                userPersonalCar[allSpawnedCars[vehicle][2]..":"..allSpawnedCars[vehicle][1] ] = nil
            end
    
            allSpawnedCars[vehicle] = nil
        end
    
        local plate,name,netid = vRPClient.ModelName(src, 10.0)
        DeleteVehicle(NetworkGetEntityFromNetworkId(vehicle))
    end
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GET USERS VEHICLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function serverFunctions.garageGetUserVehicles()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then
        local query = vRP.query("bm_module/garages/getAllUserVehicles", { user_id = user_id })

        local t = {}

        for i = 1, #query do
            t[i] = {
                ['vehicle'] = query[i].veiculo,
                ['plate'] = identity.registro,
                ['engine'] = query[i].motor,
                ['body'] = query[i].lataria,
                ['fuel'] = 100,
                ['custom'] = json.decode(query[i].tunagem),
                ['status'] = (query[i].status > 0),
                ['ipva'] = (query[i].ipva+main['ipvaVencimento']*24*60*60 <= os.time())
            }
        end
        
        return t or {}
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SAVE VEHICLES INFOS / DELETE VEHICLE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function SaveVehicleInfos(user_id, name, netID, vehicle, source)
    if vehicle then
        local body = GetVehicleBodyHealth(vehicle) or 1000.0
        local engine = GetVehicleEngineHealth(vehicle) or 1000.0
        local fuel = clientFunctions.garageGetVehicleFuel(source, netID) or 100.0

        if engine <= 100 then engine = 1000 end
		if body <= 100 then body = 1000 end
		if fuel == nil or fuel >= 100 then fuel = 100 end
        
        vRP._execute("bm_module/garages/updateVehicleInfos", { lataria = body, motor = engine, gasolina = 100, user_id = user_id, veiculo = name })
    end
end

function DeleteVehicle(entityID)
    if DoesEntityExist(entityID) then
        DeleteEntity(entityID)
    end
end

function syncDeleteVehicle(source, netID)
    local entity = NetworkGetEntityFromNetworkId(netID)
    if entity then
        if allSpawnedCars[netID] and allSpawnedCars[netID][1] and allSpawnedCars[netID][2] then
            SaveVehicleInfos(allSpawnedCars[netID][1],allSpawnedCars[netID][2],allSpawnedCars[netID][3], entity, source)

            if userPersonalCar[allSpawnedCars[netID][2]..":"..allSpawnedCars[netID][1]] then
                userPersonalCar[allSpawnedCars[netID][2]..":"..allSpawnedCars[netID][1]] = nil
            end

            allSpawnedCars[netID] = nil
        end
        
        DeleteEntity(entity)
    end
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TRY PAYMENT VEHICLE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

vRP._prepare("bm_module/garages/org/getStatus", "SELECT 1 FROM dismantle_vehicles WHERE vehicle = @vehicle AND user_id = @user_id")
vRP._prepare("bm_module/garages/org/deleteVehicle", "DELETE FROM dismantle_vehicles WHERE vehicle = @vehicle AND user_id = @user_id")
vRP._prepare("bm_module/garages/org/insertArrestedVehicle", "INSERT INTO dismantle_vehicles (vehicle, user_id) VALUES (@vehicle, @user_id)")
local orgVehiclesArrested = {}

AddEventHandler("setOrgVehicleArrested", function(user_id, vehicle)
    orgVehiclesArrested[vehicle..":"..user_id] = true
end)

function serverFunctions.getOrgArrestedVehicles(vehicleList)
    local source = source
    local user_id = vRP.getUserId(source)
    local arrestedVehicles = {}
    for _, vehicleData in pairs(vehicleList) do
        if isOrgVehicleArrested(user_id, vehicleData.vehicle) then
            arrestedVehicles[vehicleData.vehicle] = true
        end
    end
    return arrestedVehicles
end

function isOrgVehicleArrested(user_id, vehicle)
    -- prevent query spam
    if orgVehiclesArrested[vehicle..":"..user_id] ~= nil then
        return orgVehiclesArrested[vehicle..":"..user_id]
    end
    local query = vRP.query("bm_module/garages/org/getStatus", { vehicle = vehicle, user_id = user_id })
    if #query > 0 then
        orgVehiclesArrested[vehicle..":"..user_id] = true
        return true
    end
    orgVehiclesArrested[vehicle..":"..user_id] = false
    return false
end

function serverFunctions.tryPaymentOrgVehicle(name)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local query = vRP.query("bm_module/garages/org/getStatus", { vehicle = name, user_id = user_id })
        if #query > 0 then
            local vehPrice = getVehiclePrice(name) or 100000
            local payment = parseInt(vehPrice * main['retidoValue']) 
            if vRP.request(source, "Você deseja pagar <b>$ "..vRP.format(payment).."</b> para tirar seu veiculo da retenção?") then
                if vRP.tryFullPayment(user_id, payment) then
                    orgVehiclesArrested[name..":"..user_id] = false
                    vRP._execute("bm_module/garages/org/deleteVehicle", { vehicle = name, user_id = user_id })
                    TriggerClientEvent("Notify",source,"sucesso","Você Pagou $ "..vRP.format(payment).." para tirar o veiculo da apreensão.", 5)
                else
                    TriggerClientEvent("Notify",source,"negado","Você não possui dinheiro.", 5)
                end
            end
        end
    end
end

function serverFunctions.garageTryPaymentVehicle(name)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local query = vRP.query("bm_module/garages/getStatus", { veiculo = name, user_id = user_id })
        if #query > 0 then
            local vehPrice = getVehiclePrice(name) 

            if query[1].status == 1 then
                local payment = parseInt(vehPrice * main['detidoValue'])
                if vRP.request(source, "Você deseja pagar <b>$ "..vRP.format(payment).."</b> para tirar seu veiculo da apreensão ?") then
                    if vRP.tryFullPayment(user_id, payment) then
                        vRP._execute("bm_module/garages/updateStatus", { status = 0, user_id = user_id, veiculo = name })
                        TriggerClientEvent("Notify",source,"sucesso","Você Pagou $ "..vRP.format(payment).." para tirar o veiculo da apreensão.", 5)
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não possui dinheiro.", 5)
                    end
                end
            end

            if query[1].status == 2 or query[1].status == 3 then
                local payment = parseInt(vehPrice * main['retidoValue']) 

                if vRP.request(source, "Você deseja pagar <b>$ "..vRP.format(payment).."</b> para tirar seu veiculo da retenção ?") then
                    if vRP.tryFullPayment(user_id, payment) then
                        vRP._execute("bm_module/garages/updateStatus", { status = 0, user_id = user_id, veiculo = name })
                        TriggerClientEvent("Notify",source,"sucesso","Você Pagou $ "..vRP.format(payment).." para tirar o veiculo da retenção.", 5)
                        vRP.sendLog('https://discord.com/api/webhooks/1313521148822028441/Mn7y9IZPgd3qsoKsXzudeVWlW4lZ8gdIVHMo1hHIISHEYWgjv2UAXOGcTjwEuUPuEqrq', 'USUARIO '..user_id..' RETIROU O VEICULO '..name..' DA RETENÇÃO')
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não possui dinheiro.", 5)
                    end
                end
            end

            if (query[1].ipva+main['ipvaVencimento']*24*60*60 <= os.time()) then
                local payment = parseInt(vehPrice * main['ipvaValue'])

                
                if vRP.hasPermission(user_id, "perm.supremorj") then
                    payment = 1
                elseif vRP.hasPermission(user_id, "perm.belarp") then
                    payment = payment * 0.5
                elseif vRP.hasPermission(user_id, "perm.rubi") then
                    payment = payment * 0.75
                elseif vRP.hasPermission(user_id, "perm.safira") then
                    payment = payment * 0.9
                else
                    payment = payment
                end

                if vRP.request(source, "Você deseja pagar <b>$ "..vRP.format(payment).."</b> para deixar o ipva de seu veiculo em dia ?") then
                    if vRP.tryFullPayment(user_id, payment) then
                        vRP._execute("bm_module/garages/updateIpva", { ipva = os.time(), user_id = user_id, veiculo = name })
                        TriggerClientEvent("Notify",source,"sucesso","Você Pagou $ "..vRP.format(payment).." para deixar o ipva de seu veiculo em dia.", 5)
                        vRP.sendLog('https://discord.com/api/webhooks/1313520617487597660/05u0fUerGEWepyU5cbuNKn13Ve_kuaZ2KSvm3WgpaL4YEwfKG55Hv-5RJTceTCm5kb84', 'ID '..user_id..' PAGOU O IPVA DO VEICULO '..name)
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não possui dinheiro.", 5)
                    end
                end
            end
        end
    end
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN VEHICLE - EVENT
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local debug_while = false

RegisterCommand('debug_while', function(source)
    if source > 0 then return end
    if debug_while then
        print("Debug While Desativado")
        debug_while = false
    else
        print("Debug While Ativado")
        debug_while = true
    end
end)

local VEHICLES_PERMISSIONS = {
    ['wrbmwi8exc'] = 'perm.disparo',
}

local maxSpawnsVehicles = {
    ['wrx7pf'] = {
        max = 5,
        liveries = {
            [1] = true,
            [2] = true,
            [3] = true,
        },
    }
}

local vehiclesBlockeds = {}

local function checkIfVehiclesBlockedExists(name, livery)
    local newName = livery and (name .. ":" .. livery) or name
    if not vehiclesBlockeds[newName] or (#vehiclesBlockeds[newName].entities == 0) then
        return
    end

    for i = #vehiclesBlockeds[newName].entities, 1, -1 do
        local netId = vehiclesBlockeds[newName].entities[i]
        local entity = NetworkGetEntityFromNetworkId(netId)
        if not DoesEntityExist(entity) then
            table.remove(vehiclesBlockeds[newName].entities, i)
            vehiclesBlockeds[newName].total = vehiclesBlockeds[newName].total - 1
        end
    end
end

local function checkVehicleLimit(name, livery)
    if not maxSpawnsVehicles[name] or (livery and not maxSpawnsVehicles[name].liveries[livery]) then
        return true
    end

    local newName = livery and (name .. ":" .. livery) or name
    if not vehiclesBlockeds[newName] then
        return true
    end

    checkIfVehiclesBlockedExists(name, livery)
    if vehiclesBlockeds[newName].total >= maxSpawnsVehicles[name].max then
        return false
    end

    return true
end

RegisterServerEvent('garage:registerBlockedVehicle', function(name, netId, livery)
    if not maxSpawnsVehicles[name] then
        return
    end

    if livery and not maxSpawnsVehicles[name].liveries[livery] then
        return
    end

    local newName = livery and (name .. ":" .. livery) or name
    if not vehiclesBlockeds[newName] then
        vehiclesBlockeds[newName] = {
            entities = {},
            total = 0,
        }
    end

    table.insert(vehiclesBlockeds[newName].entities, netId)
    vehiclesBlockeds[newName].total = vehiclesBlockeds[newName].total + 1
end)

RegisterNetEvent("garage:garageTrySpawnVehicle",function(isPersonal, name, spawnLoc, types, opennedGarageId, opennedGarageType)
    if not name then return end
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    if user_id then
        -- local multas = vRP.getMultas(user_id)
        -- if multas and multas > 0 then
        --     TriggerClientEvent("Notify",source,"negado","Você possui multas pendentes.", 5)
        --     return false
        -- end
        -- local infos = vRP.query("vRP/get_user_identity",{ user_id = user_id })
		-- if #infos <= 0 then
		-- 	return
		-- end

		-- local criminal = json.decode(infos[1].criminal)
		-- local ticket = {}
		-- if infos then
		-- 	for k,v in pairs(criminal) do
		-- 		if v.tipo == "MULTA" then
		-- 			table.insert(ticket,{ data = os.date("%d/%m/%Y", k), value = 0, info = v.motivo, officer = "Policia SX" })
		-- 		end
		-- 	end
		-- end

        -- if #ticket > 0 then
        --     TriggerClientEvent("Notify",source,"negado","Você possui multas pendentes.", 5)
        --     return false
        -- end

        if isPersonal then
            local query = vRP.query("bm_module/garages/getSpawnVehInfo", { user_id = user_id, veiculo = name })
            if #query > 0 then
                if userPersonalCar[name..":"..user_id] then
                    if (DoesEntityExist(NetworkGetEntityFromNetworkId(userPersonalCar[name..":"..user_id])) == 1) then
                        TriggerClientEvent("Notify",source,"negado","Você já possui um veiculo desse fora da garagem.", 5)
                        return false
                    end

                    allSpawnedCars[userPersonalCar[name..":"..user_id] ] = nil
                    userPersonalCar[name..":"..user_id] = nil
                end

                if VEHICLES_PERMISSIONS[name] then
                    if not vRP.hasPermission(user_id, VEHICLES_PERMISSIONS[name]) then
                        return TriggerClientEvent("Notify",source,"negado","Você não possui permissão para puxar esse veiculo.", 5)
                    end
                end 

                if main['spawnClientVehicle'] then
                    if spawnLoc then
                        TriggerEvent('onSpawnVehicle', {
                            name = name,
                            src = source
                        })
                        TriggerClientEvent("garage:clientSpawnVehicle", source, name, {
                            plate = identity.registro,
                            engine = query[1].motor or 1000,
                            body = query[1].lataria or 1000,
                            fuel = 100,
                            custom = json.decode(query[1].tunagem) or {}
                        }, true, spawnLoc)
                    end
                else
                    if spawnLoc then
                        local vehicleHash = GetHashKey(name)
                        local entity

                        entity = CreateVehicle(vehicleHash,spawnLoc.x,spawnLoc.y,spawnLoc.z,spawnLoc.w,true,true,true)
                        if not entity or entity == 0 then return false end

                        while not DoesEntityExist(entity) do 
                            Wait(250)
                            if debug_while then
                                print("While rodando")
                            end
                        end

                        local netid = NetworkGetNetworkIdFromEntity(entity)

                        userPersonalCar[name..":"..user_id] = netid
                        allSpawnedCars[netid] = { user_id,name,netid }

                        CreateThread(function()
                            local vehOwner = NetworkGetEntityOwner(entity)
                            local plate = identity.registro
                            
                            local timeout = 0
                            while vehOwner == -1 do
                                Wait(1000)
                                timeout = timeout + 1

                                if DoesEntityExist(entity) and NetworkGetEntityOwner(entity) then
                                    vehOwner = source
                                    break;
                                end

                                if timeout > 3 then
                                    vehOwner = source
                                    break;
                                end

                                if debug_while then
                                    print("While rodando 2")
                                end
                            end

                            if not vehOwner then print("Problemas Aqui!!!") return end

                            SetVehicleNumberPlateText(entity, plate)
                            SetVehicleDoorsLocked(entity, 2)

                            TriggerClientEvent("garage:updateVehicle", vehOwner, netid, {
                                engine = query[1].motor or 1000,
                                body = query[1].lataria or 1000,
                                fuel = 100,
                                custom = json.decode(query[1].tunagem) or {}
                            }, true)
                        end)
                    end
                end
            end
        else
            if userJobCar[name..":"..user_id] then
                if (DoesEntityExist(NetworkGetEntityFromNetworkId(userJobCar[name..":"..user_id])) == 1) then
                    TriggerClientEvent("Notify",source,"negado","Você já possui um veiculo desse fora da garagem.", 5)
                    return
                end

                userJobCar[name..":"..user_id] = nil
            end
            if main['spawnClientVehicle'] then
                
                local chosenVehicleLivery = nil
                for i, vehicle in ipairs(types["vehicles"]) do
                    if vehicle.vehicle == name and vehicle.livery then
                        chosenVehicleLivery = vehicle.livery
                        break
                    end
                end
                if not opennedGarageType then 
                    DropPlayer(source,"SHARK MENU")
                    return 
                end
                
                if typeGarages[opennedGarageType] then
                    if garagesLocs[opennedGarageId] then
                        if garagesLocs[opennedGarageId].type ~= opennedGarageType then
                            print("Tipo de garagem incorreto", garagesLocs[opennedGarageId].type, opennedGarageType, opennedGarageId)
                            TriggerEvent("AC:ForceBan", source, {
                                reason = "GARAGEM_ABUSO_2",
                                additionalData = 'TIPO',
                                forceBan = false
                            })
                            return false
                        end
                        if garagesLocs[opennedGarageId].permiss and not vRP.hasPermission(user_id, garagesLocs[opennedGarageId].permiss) then
                            print("Permissão incorreta", garagesLocs[opennedGarageId].permiss, user_id)
                            TriggerEvent("AC:ForceBan", source, {
                                reason = "GARAGEM_ABUSO_1",
                                additionalData = 'PERMISSAO',
                                forceBan = false
                            })
                            return false
                        end
                    else
                        print("Invalid opennedGarageId, ", user_id, opennedGarageId, opennedGarageType)
                        return false
                    end

                    local vehicle_found = false
                    for k,v in ipairs(typeGarages[opennedGarageType].vehicles) do
                        if v.vehicle == name then
                            vehicle_found = true
                            break
                        end
                    end
                    if vehicle_found then
                        TriggerEvent('onSpawnVehicle', {
                            name = name,
                            src = source
                        })
                    end
                end

                if not checkVehicleLimit(name, chosenVehicleLivery) then
                    return TriggerClientEvent('Notify', source, 'negado', 'O limite de veiculos desse modelo foi atingido.', 5000)
                end
             
                TriggerClientEvent("garage:clientSpawnVehicle", source, name, {
                    plate = identity.registro,
                    engine = 1000,
                    body = 1000,
                    fuel = 100,
                    custom = {},
                    livery = chosenVehicleLivery,
                    opennedGarageType = opennedGarageType,
                }, false, spawnLoc)
            else
                if spawnLoc then

                    local vehicleHash = GetHashKey(name)
                    local entity

                    entity = CreateVehicle(vehicleHash,spawnLoc.x,spawnLoc.y,spawnLoc.z,spawnLoc.w,true,true,true)
                    if not entity or entity == 0 then return false end

                    while not DoesEntityExist(entity) do 
                        Wait(250)
                        if debug_while then
                            print("While rodando")
                        end
                    end

                    local netid = NetworkGetNetworkIdFromEntity(entity)

                    userJobCar[name..":"..user_id] = netid

                    CreateThread(function()
                        local vehOwner = NetworkGetEntityOwner(entity)
                        local plate = identity.registro
                        
                        local timeout = 0
                        while vehOwner == -1 do
                            Wait(1000)
                            timeout = timeout + 1

                            if DoesEntityExist(entity) and NetworkGetEntityOwner(entity) then
                                vehOwner = source
                                break;
                            end

                            if timeout > 3 then
                                vehOwner = source
                                break;
                            end

                            if debug_while then
                                print("While rodando 2")
                            end
                        end

                        if not vehOwner then print("Problemas Aqui!!!") return end

                        SetVehicleNumberPlateText(entity, plate)
                        SetVehicleDoorsLocked(entity, 2)

                        TriggerClientEvent("garage:updateVehicle", vehOwner, netid, {
                            engine = 1000,
                            body = 1000,
                            fuel = 100,
                            custom = {}
                        }, true)
                    end)
                end
            end
        end
    end
end)


RegisterNetEvent("garage:registerVehicle",function(name, netID, isPersonal)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if isPersonal then
            if netID and name then
                userPersonalCar[name..":"..user_id] = netID
                allSpawnedCars[netID] = { user_id,name,netID }
            end
        else
            if netID and name then
                userJobCar[name..":"..user_id] = netID
            end
        end
    end
end)

local facCars = {}
RegisterNetEvent("garage:registerFacVehicle",function(name, netID, garageName)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local entity = NetworkGetEntityFromNetworkId(netID)
        if entity and DoesEntityExist(entity) then
            facCars[netID] = { user_id, name, netID, garageName }
            Entity(entity).state:set("orgVehicle", user_id, false)
        end
    end
end)



exports("deleteVehicleFac", function(netID)
    facCars[netID] = nil
    local entity = NetworkGetEntityFromNetworkId(netID)
    if DoesEntityExist(entity) and Entity(entity).state.orgVehicle then
        Entity(entity).state.orgVehicle = nil
    end
end)


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LOCK VEHICLE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function serverFunctions.garageTryLockVehicle(vnetid, vhash)
    local source = source
    local user_id = vRP.getUserId(source)
    if source then
        local entity = NetworkGetEntityFromNetworkId(vnetid)
        local vname = getVehicleModel(vhash)
        if entity > 0 then
            plate = GetVehicleNumberPlateText(entity)
            if plate then
                plate = plate:gsub(" ","")

                local plateOwnerId = vRP.getUserByRegistration(plate)
                if plateOwnerId and (plateOwnerId == user_id or canAcessVehicle(user_id, vname:lower(), plateOwnerId)) then
                    local status = GetVehicleDoorLockStatus(entity)
                    SetVehicleDoorsLocked(entity, ((status == 2) and 1 or 2))
                    
                    clientFunctions.garageAnimLock(source, vnetid, status)
                end
            end
        else
            local plate,name,netid = vRPclient._ModelName(source, 5.0)

            print("Tentando trancar veiculo", plate, name, netid)

            if plate then
                plate = plate:gsub(" ", "")
                local plateOwnerId = vRP.getUserByRegistration(plate)

                if plateOwnerId and plateOwnerId == user_id then
                    if GetVehiclePedIsIn(GetPlayerPed(source),false) == 0 then
                        vRPclient._playAnim(source,true,{{"anim@mp_player_intmenu@key_fob@","fob_click"}},false)
                    end

                    clientFunctions.syncLock(source, netid)
                end
            end
        end
    end
end

function canAcessVehicle(user_id, vname, owner_id)
    if vehKeys[owner_id..":"..vname] then
        if vehKeys[owner_id..":"..vname][user_id] then
            return true
        end
    end

    return false
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE VEHICLE JOIN
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function serverFunctions.garageUpdateVehicleJoin(netID)
    local entityId = NetworkGetEntityFromNetworkId(netID) 
    if entityId and entityId > 0 then
        lastEntitys[entityId] = os.time()
    end
end


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HANDLERS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

AddEventHandler("mirtin:getGarages", function(value, id)
    housesGarages = value

    if id ~= nil then
        TriggerClientEvent("mirtin:reciveGarages", -1, false, housesGarages[id], id)
    end
end)

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    if user_id then
        TriggerClientEvent("mirtin:reciveGarages", source, true, housesGarages)
    end
end)

local CountVehicles = {}
RegisterServerEvent("bm_module:deleteVehicles")
AddEventHandler("bm_module:deleteVehicles", function(vehID) 
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    if not CountVehicles[user_id] then
        CountVehicles[user_id] = 0
    end
    CountVehicles[user_id] = (CountVehicles[user_id] + 1)

    if CountVehicles[user_id] > 3 then
        print("^1[EMPREGOS]^7 Usuário: "..user_id.." | Deletando Veiculos | Banindo ")
        DropPlayer(source,"Trigger [DELETE VEHICLES]")
        vRP.setBanned(user_id, true, "Trigger [DELETE VEHICLES]")
        return
    end

    SetTimeout(5 * 1000, function()
        if CountVehicles[user_id] then
            CountVehicles[user_id] = (CountVehicles[user_id] - 1)
        end

        if not CountVehicles[user_id] or CountVehicles[user_id] < 0 then
            CountVehicles[user_id] = nil
        end
    end)

    syncDeleteVehicle(source, vehID)
end)


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PULL VEHICLE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function serverFunctions.garageStoreUserVehicle(isPersonal, name, proximity, vehicle)
    if not name then return end
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if proximity then
            if vehicle and vehicle > 0 then
                local entity = NetworkGetEntityFromNetworkId(vehicle)

                if isPersonal then
                    if (DoesEntityExist(entity) == 1) then
                        if (GetPedInVehicleSeat(entity, -1) > 0) then
                            TriggerClientEvent("Notify",source,"negado","Você não pode guardar este veiculo, pois ele está em uso.", 5)
                            return
                        end
                    end

                    if allSpawnedCars[vehicle] and allSpawnedCars[vehicle][1] and allSpawnedCars[vehicle][2] then
                        SaveVehicleInfos(allSpawnedCars[vehicle][1],allSpawnedCars[vehicle][2],allSpawnedCars[vehicle][3], entity, source)
        
                        if userPersonalCar[allSpawnedCars[vehicle][2]..":"..allSpawnedCars[vehicle][1]] then
                            userPersonalCar[allSpawnedCars[vehicle][2]..":"..allSpawnedCars[vehicle][1]] = nil
                        end
        
                        allSpawnedCars[vehicle] = nil
                    end

                    DeleteVehicle(entity)
                    TriggerClientEvent("Notify",source,"negado","Você guardou este veiculo.", 5)
                else
                    if (DoesEntityExist(entity) == 1) then
                        if (GetPedInVehicleSeat(entity, -1) > 0) then
                            TriggerClientEvent("Notify",source,"negado","Você não pode guardar este veiculo, pois ele está em uso.", 5)
                            return
                        end
                    end

                    if userJobCar[name..":"..user_id] then
                        userJobCar[name..":"..user_id] = nil
                    end

                    DeleteVehicle(entity)
                    TriggerClientEvent("Notify",source,"negado","Você guardou este veiculo.", 5)
                end
            end
        else
            if isPersonal then
                if userPersonalCar[name..":"..user_id] then
                    local entity = NetworkGetEntityFromNetworkId(userPersonalCar[name..":"..user_id])
    
                    if (DoesEntityExist(entity) == 1) then
                        if #(GetEntityCoords(entity) - GetEntityCoords(GetPlayerPed(source))) >= 100 then
                            TriggerClientEvent("Notify",source,"negado","Este veiculo que você está tentando guardar, está muito longe de você.", 5)
                            return
                        end
    
                        if (GetPedInVehicleSeat(entity, -1) > 0) then
                            TriggerClientEvent("Notify",source,"negado","Você não pode guardar este veiculo, pois ele está em uso.", 5)
                            return
                        end
                    end
                    
                    if allSpawnedCars[userPersonalCar[name..":"..user_id]] then
                        SaveVehicleInfos(allSpawnedCars[userPersonalCar[name..":"..user_id]][1],allSpawnedCars[userPersonalCar[name..":"..user_id]][2],allSpawnedCars[userPersonalCar[name..":"..user_id]][3], entity, source)
                    end
    
                    DeleteVehicle(entity)
    
                    if userPersonalCar[name..":"..user_id] then
                        allSpawnedCars[userPersonalCar[name..":"..user_id]] = nil
                        userPersonalCar[name..":"..user_id] = nil
                    end
                    
                    TriggerClientEvent("Notify",source,"negado","Você guardou este veiculo.", 5)
                    return
                end
    
                TriggerClientEvent("Notify",source,"negado","Este veiculo não está fora da garagem.", 5)
            else
                if userJobCar[name..":"..user_id] then
                    local entity = NetworkGetEntityFromNetworkId(userJobCar[name..":"..user_id])
    
                    if (DoesEntityExist(entity) == 1) then
                        if (GetPedInVehicleSeat(entity, -1) > 0) then
                            TriggerClientEvent("Notify",source,"negado","Você não pode guardar este veiculo, pois ele está em uso.", 5)
                            return
                        end
                    end
    
                    if userJobCar[name..":"..user_id] then
                        userJobCar[name..":"..user_id] = nil
                    end
    
                    DeleteVehicle(entity)
                    TriggerClientEvent("Notify",source,"negado","Você guardou este veiculo.", 5)
                    return
                end
    
                TriggerClientEvent("Notify",source,"negado","Este veiculo não está fora da garagem.", 5)
            end
        end
    end
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function getVehiclePrice(name)
    return (listCars[GetHashKey(name)] == nil) and main['defaultCarPrice'] or listCars[GetHashKey(name)].price
end

function getVehicleTrunk(name)
    return (listCars[GetHashKey(name)] == nil) and main['defaultCarChest'] or listCars[GetHashKey(name)].trunk
end

function serverFunctions.getVehicleTrunk(name)
    return (listCars[GetHashKey(name)] == nil) and main['defaultCarChest'] or listCars[GetHashKey(name)].trunk
end

function getVehicleName(name)
    return (listCars[GetHashKey(name)] == nil) and name or listCars[GetHashKey(name)].name
end

function serverFunctions.getVehicleName(name)
    return getVehicleName(name)
end

function getVehicleType(name)
    return (listCars[GetHashKey(name)] == nil) and "Carros" or listCars[GetHashKey(name)].type
end

function getVehicleModel(hash)
    return (listCars[hash] == nil) and "Indefinido" or listCars[hash].model
end

exports('getVehicleModel', function(hash)
    return getVehicleModel(hash)
end)

exports('getVehiclePrice', function(name)
    return getVehiclePrice(name)
end)

exports('getVehicleTrunk', function(name)
    return getVehicleTrunk(name)
end)

exports('allSpawnedCars', function(name)
    return allSpawnedCars
end)

exports('getVehicleName', function(name)
    return getVehicleName(name)
end)

exports('getVehicleType', function(name)
    return getVehicleType(name)
end)

exports('getListVehicles', function()
    return listCars
end)

exports('deleteVehicle', function(...)
    syncDeleteVehicle(...)
end)

exports('getVehicleParameters', function(name)
    return listCars[name] or false
end)