function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    if onScreen then
        SetTextFont(4)
        SetTextScale(0.35,0.35)
        SetTextColour(255,255,255,150)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text))/400
        DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
    end
end

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

Weapons = {}
WeaponsHashs = {}
CreateThread(function()
    for type in pairs(Config.Weapons) do
        for weapon_id, weapon_name in pairs(Config.Weapons[type]) do
            Weapons[weapon_name] = weapon_id
            WeaponsHashs[GetHashKey(weapon_id)] = weapon_id
        end
    end
end)