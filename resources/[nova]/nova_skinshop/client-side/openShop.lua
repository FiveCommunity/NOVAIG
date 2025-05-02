CreateThread(function()
    while true do
        local thread = 1000

        local playerPed = PlayerPedId()

		if not IsPedInAnyVehicle(playerPed) and not creatingCharacter then
            local playerCoords = GetEntityCoords(playerPed)

            for _, parameters in pairs (locateShops) do
                local distancePlayerToShop = #(playerCoords - vector3(parameters[1],parameters[2],parameters[3]))

                if distancePlayerToShop <= 10 then
                    thread = 2

                    if distancePlayerToShop <= 5 then
                        if parameters[5] then
                            DrawMarker(23, parameters[1], parameters[2], parameters[3]-0.97, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 254, 56, 0, 155, 0, 0, 0, 1)
                        end

                        DrawText3D(parameters[1],parameters[2],parameters[3],"Pressione ~r~E~w~ para abrir")

                        if distancePlayerToShop <= 2 then
                            if IsControlJustPressed(0,38) then
                                clientFunctions.openNuiShop()
                            end
                        end
                    end
                end
            end
        end
        Wait(thread)
    end
end)

function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 400
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end