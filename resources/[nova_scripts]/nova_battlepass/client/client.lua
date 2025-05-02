local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

ClientAPI = {}
Tunnel.bindInterface(GetCurrentResourceName(), ClientAPI)
ServerAPI = Tunnel.getInterface(GetCurrentResourceName())

RegisterCommand('openpass', function()
    OpenBattlepassUI()
end)

RegisterNUICallback('Close', function(data, cb)
    CloseBattlepassUI()
    cb(true)
end)

RegisterNUICallback('GetData', function(data, cb)
    cb(ServerAPI.getUserPass())
end)

RegisterNUICallback('RedeemItem', function(data, cb)
    local item = data.item
    local items = ServerAPI.redeemItem(item)
    cb(items)
end)