-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local termsList = {}

AddEventHandler("vRP:playerSpawn",function(user_id,source)
    if not termsList[user_id] then
        TriggerClientEvent("shortcuts:terms",source,true)
    end
end)

RegisterServerEvent("shortcuts:termsAccept", function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        termsList[user_id] = true
    end
end)