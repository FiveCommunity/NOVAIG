-----------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------
-- TUNNEL
-----------------------------------------------------------------------------------------------------------------
cO = {}
Tunnel.bindInterface(GetCurrentResourceName(), cO)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())
-----------------------------------------------------------------------------------------------------------------
-- GENERATE PAYMENT
-----------------------------------------------------------------------------------------------------------------
local paymentCooldown = {}
function cO.Generate(Home)
    local source = source 
    local userId = vRP.getUserId(source)
    if not userId then 
        return 
    end

    if (paymentCooldown[userId] and paymentCooldown[userId] > os.time()) then 
        return 
    end

    local playerService = vCLIENT.checkService(source)
    if not playerService then 
        return 
    end

    if not HomeBlips[Home] then 
        return 
    end

    local Distance = #(GetEntityCoords(GetPlayerPed(source)) - HomeBlips[Home].Start)
    if Distance > 20 then 
        return 
    end

    local Payment = math.random(HomeBlips[Home].Payment[1],HomeBlips[Home].Payment[2])


    vRP.giveInventoryItem(userId, "money", parseInt(Payment), true)

    paymentCooldown[userId] = os.time() + 10
    return true 
end