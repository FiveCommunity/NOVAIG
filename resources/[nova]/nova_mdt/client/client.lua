local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')

ClientAPI = {}
Tunnel.bindInterface(GetCurrentResourceName(), ClientAPI)
ServerAPI = Tunnel.getInterface(GetCurrentResourceName())

function closeNui()
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })
end

function ClientAPI.openOrganizationMenu(data)
    SendNUIMessage({
        action = 'open',
        data = data
    })
    SetNuiFocus(true, true)
end

RegisterNUICallback('getInitialInfos', function(data, cb)
    cb(ServerAPI.getOrganizationMembers())
end)

RegisterNUICallback('hideFrame', function(data, cb)
    closeNui()
    cb(true)
end)

RegisterNUICallback('getRolesToContract', function(data, cb)
    cb(ServerAPI.getRolesToContract())
end)