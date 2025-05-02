local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')

ClientAPI = {}
Tunnel.bindInterface(GetCurrentResourceName(), ClientAPI)
ServerAPI = Tunnel.getInterface(GetCurrentResourceName())

--- @return void
local function closeNui()
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })
end

--- @return void
function ClientAPI.openRaffleCreate()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'update', data = { items = Config.Items } })
    SendNUIMessage({ action = 'open', data = { page = 'create' } })
end

RegisterCommand(Config.Commands.MainCommand, function (source, args)
    local raffleData = ServerAPI.getRaffleData()
    if not raffleData then
        return
    end
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'update', data = raffleData })
    SendNUIMessage({ action = 'open' })
end)

RegisterNUICallback('CREATE_RAFFLE', function(data, cb)
    cb(ServerAPI.createRaffle(data))
    closeNui()
end)

RegisterNUICallback('BUY', function(data, cb)
    local amount = tonumber(data)
    if not amount then
        return cb(false)
    end
    closeNui()
    cb(ServerAPI.buy(amount))
end)

RegisterNUICallback('CLOSE', function (data, cb)
    closeNui()
    return cb(true)
end)