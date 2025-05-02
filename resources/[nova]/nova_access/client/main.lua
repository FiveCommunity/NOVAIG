RegisterNetEvent('lotus_access:open', function(msg)
    print(msg)
    TriggerEvent("Notify", "negado", msg)
    SendNUIMessage({
        action = "open"
    })
    SetNuiFocus(true, true)
end)

RegisterNetEvent('lotus_access:close', function()
    SendNUIMessage({
        action = "close"
    })
    SetNuiFocus(false, false)
end)