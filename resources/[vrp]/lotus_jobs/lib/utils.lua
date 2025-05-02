function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,200)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end

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
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,140)
end

function drawTxt(text,x,y)
	local res_x, res_y = GetActiveScreenResolution()

	SetTextFont(4)
	SetTextScale(0.3,0.3)
	SetTextColour(255,255,255,255)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)

	if res_x >= 2000 then
		DrawText(x+0.076,y)
	else
		DrawText(x,y)
	end
end

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end

function GetNerarestVehicle(range)
	local ped = PlayerPedId()
    local vehicles = GetGamePool("CVehicle")

    local vehID
    local min = range+0.0001
    local vehHash
    for i = 1, #vehicles do
        local veh = vehicles[i]
        local dist = #(GetEntityCoords(ped) - GetEntityCoords(veh))

        if IsEntityAVehicle(veh) and dist <= range then
            if dist < min then
                min = dist
                vehID = veh
                vehHash = GetEntityModel(veh)
            end
        end
    end

    return vehID,vehHash
end