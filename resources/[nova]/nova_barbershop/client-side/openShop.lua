CreateThread(function()
    while true do
        thread = 1000
        local playerPed = PlayerPedId()

        if not IsPedInAnyVehicle(playerPed) then
            local pCoords = GetEntityCoords(playerPed)

            for _, location in pairs(locations) do
				local distance = #(pCoords - vector3(location[1],location[2],location[3]))

                if distance <= 5 then
                    thread = 2
                    if location[5] then
						DrawMarker(23,location[1],location[2],location[3]-0.97,0,0,0,0,0,0,1.0,1.0,0.5, 254, 56, 0 ,155, 0,0,0,1)
                    end
                    DrawText3D(location[1],location[2],location[3]-0.1, "Pressione [~b~E~w~] para acessar a barbearia.")

                    if distance <= 2.5 then
						if IsControlJustPressed(1,38)  then
                            clientFunctions.openNuiShop()
						end
                    end
                end
            end
        end
        Wait(thread)
    end
end)





function DrawText3D(x,y,z, text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end