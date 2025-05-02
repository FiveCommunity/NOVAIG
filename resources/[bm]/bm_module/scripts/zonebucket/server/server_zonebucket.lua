local inZonePlayers = {}


function changeBucket(bucket, src, ped, passagers)
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle and vehicle > 0 then
        local vehicleCoords = GetEntityCoords(vehicle)
        SetPlayerRoutingBucket(src, bucket)
        SetEntityRoutingBucket(vehicle, bucket)
        TaskWarpPedIntoVehicle(ped, vehicle, -1)
        for seat, v in pairs(passagers) do
            local pedPassager = GetPlayerPed(v)
            if #(vehicleCoords - GetEntityCoords(pedPassager)) < 30 then
                SetPlayerRoutingBucket(v, bucket)
                TaskWarpPedIntoVehicle(pedPassager, GetVehiclePedIsIn(ped, false), seat)
                SetPedIntoVehicle(pedPassager, GetVehiclePedIsIn(ped, false), seat)
                if bucket == 0 then
                    inZonePlayers[v] = nil
                    TriggerEvent("zoneBucket:Toggle", v, nil)
                else
                    inZonePlayers[v] = true
                    TriggerEvent("zoneBucket:Toggle", v, true)
                end

            end
        end
    else
        SetPlayerRoutingBucket(src, bucket)
    end
end


RegisterNetEvent('zone:enter', function(zone, passagers)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local ped = GetPlayerPed(source)
        local coords = GetEntityCoords(ped)

        local dist = #(Config_Zones[zone].coords[1] - coords)
        if dist > 1000 then
            return print('[ZONE-SYSTEM] Player '..user_id..' is too far from the zone')
        end

        TriggerEvent("zoneBucket:Toggle", source, true)
        inZonePlayers[source] = user_id

        changeBucket(Config_Zones[zone].bucket_id, source, ped, passagers)
        
    end
end)

RegisterNetEvent('zone:leave', function(zone, passagers)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local ped = GetPlayerPed(source)
        if not inZonePlayers[source] then
            return print('[ZONE-SYSTEM] Player '..user_id..' is not in the zone')
        end

        TriggerEvent("zoneBucket:Toggle", source, false)

        inZonePlayers[source] = nil

        changeBucket(0, source, ped, passagers)

    end
end)