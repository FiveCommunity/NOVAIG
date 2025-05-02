local plyInZone = false

local function getPassagers()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local passagers = {}
    if vehicle ~= 0 then
        for i = 0, GetVehicleMaxNumberOfPassengers(vehicle) do
            local passager = GetPedInVehicleSeat(vehicle, i)
            if passager ~= 0 and passager ~= ped then
                passagers[i] = GetPlayerServerId(NetworkGetPlayerIndexFromPed(passager))
            end
        end
    end
    return passagers
end

local function handleAction(method, index)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= 0 then
        if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
            -- check it on server side to avoid any kind of exploit 
            TriggerServerEvent('zone:'..method, index, getPassagers())
        end
        return
    end
    TriggerServerEvent('zone:'..method, index)
end

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local inZone, index, name = getPlyZone()
        if not LocalPlayer.state.inPvP then
            if inZone and not plyInZone then
                plyInZone = true
                handleAction('enter', index)
            end

            if not inZone and plyInZone then
                plyInZone = false
                handleAction('leave', -1)
            end
        end

        Wait(1000)
    end
end)


function getPlyZone()
    local plyCoords = GetEntityCoords(PlayerPedId())
    local inZone = false
    local tZone = {}
    local min = 1000.0

    for k in pairs(Config_Zones) do
        if Config_Zones[k] then
            local Zone = Config_Zones[k].coords
            local j = #Zone
            for i = 1, #Zone do
                if (Zone[i][2] < plyCoords.y and Zone[j][2] >= plyCoords.y or Zone[j][2] < plyCoords.y and Zone[i][2] >= plyCoords.y) then
                    if (Zone[i][1] + ( plyCoords[2] - Zone[i][2] ) / (Zone[j][2] - Zone[i][2]) * (Zone[j][1] - Zone[i][1]) < plyCoords.x) then
                        inZone = not inZone;
                        tZone = { Index = k, Name = Config_Zones[k].name }
                    end
                end
                j = i;
            end
        end
    end 

    if not inZone then
        tZone = {}
    end
    return inZone,tZone.Index,tZone.Name
end