PICKUPS = {}

function API.CreatePickup(pickupInfo, id)
    PICKUPS[id] = pickupInfo
    SendNUIMessage({
        route = 'UPDATE_PICKUP'
    })
end

function API.UpdatePickup(pickupInfo, id)
    PICKUPS[id] = pickupInfo
    SendNUIMessage({
        route = 'UPDATE_PICKUP'
    })
end


function API.RemovePickup(id)
    PICKUPS[id] = nil
    SendNUIMessage({
        route = 'UPDATE_PICKUP'
    })
end

function API.getPickups()
    local ply = PlayerPedId()
    local plyCds = GetEntityCoords(ply)
    local response = {}
    for id,v in pairs(PICKUPS) do
        local distance = #(plyCds - v.coords)
        if distance < 7.0 then 
            response[#response + 1] = v
            response[#response].id = k
        end
    end
    return response
end


CreateThread(function() 
    while true do 
        local sleep = 1001
        if (next(PICKUPS) == nil) then 
            Wait(1000)
        else
            local ply = PlayerPedId()
            local plyCds = GetEntityCoords(ply)
            for id,v in pairs(PICKUPS) do
                local distance = #(plyCds - v.coords)
                if distance < 7.0 then
                    sleep = 3
                    DrawMarker(21, v.coords.x, v.coords.y, v.coords.z-0.55, 0, 0, 0, 0, 180.0, 130.0, 0.3, 0.3, 0.3, 254, 56, 0, 50, 0, 0, 0, 1)
                    if distance < 1.2 then 
						DrawText3D(v.coords.x, v.coords.y,v.coords.z-0.6, "Pressione ~g~[E] ~w~para pegar ~g~ "..v.name.." x".. v.amount .." ~w~")
                        if IsControlJustPressed(0, 38) then 
                            Remote.getPickup(id)
                            Wait(1000)
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end