openSocial = function()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "registration" })
end

RegisterNUICallback('registration_infos', function(data)
    vTunnel._saveSocial(data.info)
end)

RegisterNetEvent("bm_module/open_registration")
AddEventHandler("bm_module/open_registration", function()
    openSocial()
end)

