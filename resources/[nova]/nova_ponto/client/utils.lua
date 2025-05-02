
DrawText3D = function(coords, text)
    SetDrawOrigin(coords)
    SetTextScale(0.35, 0.35)
    SetTextColour(255, 255, 255, 255)
    SetTextFont(4)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    DrawRect(0.0, 0.0125, 0.015 + text:gsub('~.-~', ''):len() / 370, 0.03, 45, 45, 45, 150)
    ClearDrawOrigin()
end