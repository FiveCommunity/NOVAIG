RegisterNUICallback('onClose', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "hideMenu" })
    ExecuteCommand("e")
    TriggerEvent("CancelAnimation")
end)

