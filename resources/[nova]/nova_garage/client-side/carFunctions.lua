---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ANIMLOCK
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function clientFunctions.garageAnimLock(index, v)
    local status = (v == 2) and 'Destrancado' or 'Trancado'
    TriggerEvent("Notify","importante","Veiculo <b>".. status .."</b>",5)
    vRP._playAnim(true, {{"anim@mp_player_intmenu@key_fob@","fob_click"}}, false)

    if NetworkDoesNetworkIdExist(index) then
        TriggerEvent("vrp_sound:source",'lock',0.1)

		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleLights(v,2)
				Wait(200)
				SetVehicleLights(v,0)
				Wait(200)
				SetVehicleLights(v,2)
				Wait(200)
				SetVehicleLights(v,0)
			end
		end
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SYNC LOCK
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function clientFunctions.syncLock(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				local locked = GetVehicleDoorLockStatus(v)
				if locked == 1 then
                    TriggerEvent('Notify', 'importante', 'Veiculo Trancado .', 5000)
					SetVehicleDoorsLocked(v,2)
				else
                    TriggerEvent('Notify', 'importante', 'Veiculo Destrancado .', 5000)
					SetVehicleDoorsLocked(v,1)
				end
				SetVehicleLights(v,2)
				Wait(200)
				SetVehicleLights(v,0)
				Wait(200)
				SetVehicleLights(v,2)
				Wait(200)
				SetVehicleLights(v,0)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LOCK VEHICLE
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('lockvehicle', function(source,args)
    if GetEntityHealth(PlayerPedId()) <= 105 then return end 
    
    local plyCoords = GetEntityCoords(PlayerPedId())
    local vehicle,hash = GetClosestVehiclePlayer(5.0)
    if vehicle then
        if segundos == 0 then
            segundos = 2
            serverFunctions.garageTryLockVehicle(VehToNet(vehicle),hash)
        end
    end
end)
RegisterKeyMapping('lockvehicle', 'Trancar/Destrancar Veiculo', 'keyboard', 'L')


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLE FUEL
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function clientFunctions.garageGetVehicleFuel(veh)
    if IsEntityAVehicle(NetToVeh(veh)) then
        return GetVehicleFuelLevel(NetToVeh(veh))
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES PROXIMITY IN PLAYER
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function clientFunctions.garageGetNearestVehicle(distance)
    local veh = GetClosestVehiclePlayer(distance)

    if veh then
        return VehToNet(veh)
    end

    return false
end


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HANDLERS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("mirtin:reciveGarages")
AddEventHandler("mirtin:reciveGarages", function(all,houses,id)
    if all then
        for k in pairs(houses) do
            if houses[k] and houses[k].garagem ~= nil and houses[k].garagem['garagem'] ~= nil then
                garages[(1000 + k)] = { -- SE TIVER + 1000 GARAGEM CRIADA, AUMENTAR AQUI... [ 1000 + IDDACASA ]
                    type = "Homes",
                    houseID = k,
                    blipDistance = 5.0,

                    coords = vec3(houses[k].garagem['garagem'].x,houses[k].garagem['garagem'].y,houses[k].garagem['garagem'].z), 
                    spawnCoords = {
                        vector4(houses[k].garagem['spawn'].x,houses[k].garagem['spawn'].y,houses[k].garagem['spawn'].z,houses[k].garagem['spawn'].h),
                    }
                }
            end
        end
    else
        v = houses
        garages[(1000 + id)] = { -- SE TIVER + 1000 GARAGEM CRIADA, AUMENTAR AQUI... [ 1000 + IDDACASA ]
            type = "Homes",
            houseID = id,
            blipDistance = 5.0,

            coords = vec3(v.garagem['garagem'].x,v.garagem['garagem'].y,v.garagem['garagem'].z), 
            spawnCoords = {
                vector4(v.garagem['spawn'].x,v.garagem['spawn'].y,v.garagem['spawn'].z,v.garagem['spawn'].h),
            }
        }
    end
end)

AddEventHandler("gameEventTriggered",function(eventName, args)
    if eventName == "CEventNetworkPlayerEnteredVehicle" and args[1] == PlayerId() then
        if GetPedInVehicleSeat(args[2], -1) == PlayerPedId() then 
            if segundos == 0 then
                segundos = 2
                serverFunctions.garageUpdateVehicleJoin(VehToNet(args[2]))
            end
        end
    end
end)
