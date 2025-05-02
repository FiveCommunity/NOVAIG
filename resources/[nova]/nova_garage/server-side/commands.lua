------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMANDOS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dv',function(source,args,rawCommand)
    local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "perm.cc") or vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasGroup(user_id, 'ajudante') or vRP.hasPermission(user_id,"dv.permissao") then
        local vehicle = clientFunctions.garageGetNearestVehicle(source,7)
		if vehicle then
            if (vRP.hasPermission(user_id,"perm.disparo") and GetEntityHealth(GetPlayerPed(source)) <= 101) then
                return false
            end

            if vRP.hasPermission(user_id, 'perm.disparo') and (not vRP.checkPatrulhamento(user_id) and not vRP.hasPermission(user_id, 'developer.permissao')) then
                return false
            end
            
			local plyCoords = GetEntityCoords(GetPlayerPed(source))
            local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]

            if allSpawnedCars[vehicle] and allSpawnedCars[vehicle][1] and allSpawnedCars[vehicle][2] then
                SaveVehicleInfos(allSpawnedCars[vehicle][1],allSpawnedCars[vehicle][2],allSpawnedCars[vehicle][3], NetworkGetEntityFromNetworkId(vehicle), source)

                if userPersonalCar[allSpawnedCars[vehicle][2]..":"..allSpawnedCars[vehicle][1]] then
                    userPersonalCar[allSpawnedCars[vehicle][2]..":"..allSpawnedCars[vehicle][1] ] = nil
                end

                allSpawnedCars[vehicle] = nil
            end

            local plate,name,netid = vRPClient.ModelName(source, 10.0)
            DeleteVehicle(NetworkGetEntityFromNetworkId(vehicle))

            vRP.sendLog("https://discord.com/api/webhooks/1327431807385210902/xWuaSmO0ZPYWH_2f3dzfaKm-vbLj4alaqeLpDzdlcLa9gpco5FnkyLp7vp2ql1ATUYGx","O ID : "..user_id.." Utilizou o comando de DV")
            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "dv",
                user_id = user_id,
                message = ( [[O USER_ID %s usou o comando dv nas cds %s VEICULO %s]] ):format(user_id, vec3(x,y,z), name)
            })
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAR CACHES DE VEICULOS QUE NAO EXISTE / NAO USADOS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        Wait( 5 * 60 * 1000 )
        
        local cache_vehicles = 0
        for k in pairs(userPersonalCar) do
            if (not DoesEntityExist(NetworkGetEntityFromNetworkId(userPersonalCar[k]))) then
                allSpawnedCars[userPersonalCar[k] ] = nil
                userPersonalCar[k] = nil
            end
        end
       
        if main['clearVehicle'].enable then
            local unused_vehicles = 0
            for _,entity in ipairs(GetAllVehicles()) do
                if DoesEntityExist(entity) then 
                    if lastEntitys[entity] then
                        local plyInVehicle = (GetPedInVehicleSeat(entity,-1) == 0)

                        if (os.time() - lastEntitys[entity]) >= (main['clearVehicle'].time * 60) then
                            if plyInVehicle then
                                DeleteEntity(entity)
                                
                                lastEntitys[entity] = nil
                                unused_vehicles = unused_vehicles + 1
                            else
                                lastEntitys[entity] = os.time()
                            end
                        end
                    else
                        if plyInVehicle then
                            DeleteEntity(entity)
                            
                            lastEntitys[entity] = nil
                            unused_vehicles = unused_vehicles + 1
                        else
                            lastEntitys[entity] = os.time()
                        end
                    end
                end
            end

            --print("Total de veiculos não usados limpo: "..unused_vehicles)
        end
    end
end)