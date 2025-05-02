function OpenUI()
    SendNUIMessage({ action = 'open' })
    SetNuiFocus(true, true)
end

function CloseUI()
    SendNUIMessage({ action = 'close' })
    SetNuiFocus(false, false)
end

RegisterCommand('tips', function(source, args, rawCommand)
    OpenUI()
end)

RegisterNUICallback('CLOSE', function(_, cb)
    CloseUI()
    cb('ok')
end)

RegisterNUICallback('GET_TIPS', function(data, cb)
    cb(Config.Tips)
end)

RegisterNUICallback('GET_IDENTITY', function(_, cb)
    local identity = Remote.GetIdentity()
    cb(identity)
end)

RegisterNUICallback('CALL', function(data, cb)
    Remote.Call(data.type, data.description)
    cb('ok')
end)

function API.setWaypoint(x, y, z)
    SetNewWaypoint(x, y, z)
end 
