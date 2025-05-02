local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')

ClientAPI = {}
Tunnel.bindInterface(GetCurrentResourceName(), ClientAPI)
ServerAPI = Tunnel.getInterface(GetCurrentResourceName())

RegisterNUICallback('hideFrame', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })
    cb(true)
end)

RegisterNUICallback('select', function(data, cb)
    local orgType = data
    ServerAPI._selectOrganization(orgType)
    SendNUIMessage({ action = 'close' })
    SetNuiFocus(false, false)
    cb(true)
end)

RegisterNUICallback('getRequests', function(data, cb)
    local payload = ServerAPI.getRequests()
    cb(payload)
end)

RegisterNUICallback('gps', function(data, cb)
    local nuserId = tonumber(data.passport)
    if nuserId then 
        ServerAPI._gps(nuserId)
    end
    cb(true)
end)

RegisterNUICallback('call', function(data, cb)
    local nuserId = tonumber(data.passport)
    local phone = data.phone
    if nuserId then 
        ServerAPI._call(nuserId, phone)
    end
    cb(true)
end)

RegisterNUICallback('message', function(data, cb)
    local message = data.message
    local nuserId = tonumber(data.user.passport)
    local phone = data.user.phone
    if nuserId then 
        ServerAPI._message(nuserId, phone, message)
    end
    cb(true)
end)  

RegisterNUICallback('tramp', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })
    ServerAPI._tramp()
    cb(true)
end)

RegisterNUICallback('delete', function(data, cb)
    local nuserId = tonumber(data.passport)
    if nuserId then 
        ServerAPI.delete(nuserId)
        SetNuiFocus(false, false)
        SendNUIMessage({ action = 'close' })
    end
    cb(true)
end)

function ClientAPI.openNui()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'open' })
end

function ClientAPI.openDashboard()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'dashboard' })
end

function ClientAPI.openNotify(status)
    if status then 
        SendNUIMessage({ action = 'notify' })
    else
        SendNUIMessage({ action = 'close' })
    end
end

function ClientAPI.callUser(phone)
    exports.smartphone:callPlayer(phone)
end