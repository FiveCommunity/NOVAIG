
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local PEDS = {}
local veh = 0
local delayTimer = GetGameTimer()

CreateThread(function()
    PEDS:createPeds()

    while true do
        local SLEEP_TIME = 1000
        local pedCoords = GetEntityCoords(PlayerPedId())

        for _,ped in pairs(configSelector.Peds) do
            local dist = #(pedCoords - vec3(ped.coords.x,ped.coords.y,ped.coords.z))
            if dist <= 150.0 then
                SLEEP_TIME = 0 

                DrawMarker(27,ped.coords.x,ped.coords.y,ped.coords.z-0.95,0,0,0,0, 0,0,1.0,1.0,1.5, 102,204,0, 180,0,0,0,1)

                if dist <= 5 then
                    DrawText3Ds(ped.coords.x,ped.coords.y,ped.coords.z+1.2,ped.text)

                    if IsControlJustPressed(0,38) and dist < 2 and (delayTimer - GetGameTimer()) <= 0 then
                        delayTimer = (GetGameTimer() + 5000)

                        if veh > 0 then
                            TriggerServerEvent("bm_module:deleteVehicles", VehToNet(veh))
                        end

                        local mhash = GetHashKey(ped.cars.name)

                        local timeout = 10
                        while not HasModelLoaded(mhash) and timeout > 0 do timeout = (timeout - 1) RequestModel(mhash) Wait(200) end
                        if timeout <= 0 then goto skip_car end

                        veh = CreateVehicle(mhash, ped.cars.spawn.x,ped.cars.spawn.y,ped.cars.spawn.z,ped.cars.spawn.w, true, true)
                    
                        while not DoesEntityExist(veh) do Wait(200) end
                        while not NetworkDoesEntityExistWithNetworkId(VehToNet(veh)) do Wait(200) end
        
                        if not IsEntityAVehicle(veh) then return end

                        SetLocalPlayerAsGhost(true)
                        SetNetworkVehicleAsGhost(veh, true)
                        SetEntityAlpha(veh, 101, true)

                        SetVehicleNumberPlateText(veh, vTunnel.requestPlate())
                        SetEntityAsMissionEntity(veh, true, true)
                        SetVehicleOnGroundProperly(veh)
                        SetVehRadioStation(veh, "OFF")
                        SetVehicleDirtLevel(veh, 0.0)
                        SetVehicleDoorsLocked(veh, 2)
                        SetPedIntoVehicle(PlayerPedId(),veh,-1)
                        SetVehicleEngineHealth(veh, 1000.0)
                        SetVehicleBodyHealth(veh, 1000.0)
                        SetVehicleFuelLevel(veh, 100.0)
                        SetModelAsNoLongerNeeded(mhash)

                        SetTimeout(10 * 1000, function()
                            SetEntityAlpha(veh, 255, true)
                            SetLocalPlayerAsGhost(false)
                            SetNetworkVehicleAsGhost(veh, false)
                        end)

                        SetNewWaypoint(ped.setGps.x+0.0001,ped.setGps.y+0.0001)
                        TriggerEvent("Notify", "importante", 'Vá até o local marcado em seu GPS!', 15)
                    end

                    :: skip_car ::
                end
            end
        end

        Wait( SLEEP_TIME )
    end
end)

function PEDS:createPeds()
    for index,ped in pairs(configSelector.Peds) do
        RequestModel(GetHashKey(ped.type))
        while not HasModelLoaded(GetHashKey(ped.type)) do Wait(0) end

        PEDS[index] = CreatePed(ped.type, GetHashKey(ped.type), ped.coords.x, ped.coords.y, ped.coords.z-0.9, ped.coords.w, false, true)
        FreezeEntityPosition(PEDS[index], true)
        SetEntityInvincible(PEDS[index], true)
        SetBlockingOfNonTemporaryEvents(PEDS[index],true)
    end
end