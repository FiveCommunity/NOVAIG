CreateThread(function()
    while true do  
        local thread = 1000
        local plyCoords = GetEntityCoords(PlayerPedId())

        for i in pairs(nearestGarages) do
            if nearestGarages[i] then
                thread = 2
                local coords = nearestGarages[i].coords
                local distance = #(plyCoords - coords)

                DrawMarker(36,coords.x,coords.y,coords.z,0,0,0,0,0,0,1.0,1.0,1.0, 254, 56, 0,155, 1,1,1,1)
                DrawMarker(1,coords.x,coords.y,coords.z-0.97,0,0,0,0,0,0,1.0,1.0,0.5, 254, 56, 0,155, 0,0,0,1)

                if IsControlJustPressed(0,38) and distance < 2 and GetEntityHealth(PlayerPedId()) > 101 then
                    if nearestGarages[i].permiss == nil or serverFunctions.garageCheckPermission(nearestGarages[i].permiss, nearestGarages[i].checkService or nil) then
                        if nearestGarages[i].type == "Homes" then
                            if serverFunctions.garageCheckHouseOwner(nearestGarages[i].houseID) then
                                clientFunctions.openNui(i, nearestGarages[i].type)
                            end
                        else
                            clientFunctions.openNui(i, nearestGarages[i].type)
                        end
                    end
                end
            end
        end
        Wait(thread)
    end
end)

