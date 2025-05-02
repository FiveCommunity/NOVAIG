function API.openInspect(data)
    SendNUIMessage({
        route = "OPEN_INSPECT",
        payload = data
    })
    SetNuiFocus(true,true)
end