----------------------------------------------------------------------------------------------------------------------------------------------------
-- VRP
----------------------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")
----------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNEL
----------------------------------------------------------------------------------------------------------------------------------------------------
registerTunnel = {}
Tunnel.bindInterface(GetCurrentResourceName(), registerTunnel)
----------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁIVES
----------------------------------------------------------------------------------------------------------------------------------------------------
local playersCache = {}
local specialSlots = {
    ["Pascoa"] = 1,
    ["Ferias"] = 1,
    ["Platina"] = 1,
    ["Diamante"] = 1,
    ["Esmeralda"] = 2,
    ["Safira"] = 3,
    ["Rubi"] = 3,
    ["Belarp"] = 3,
    ["Supremobela"] = 3,
    ["altarj"] = 3,
}
----------------------------------------------------------------------------------------------------------------------------------------------------
-- SAVE ON EXIT
----------------------------------------------------------------------------------------------------------------------------------------------------
local saveTime = true
----------------------------------------------------------------------------------------------------------------------------------------------------
-- SAVE AIM
----------------------------------------------------------------------------------------------------------------------------------------------------
function registerTunnel.Save(Aims)
    local source = source 
    local userId = vRP.getUserId(source)
    if not userId then return end 


    if not playersCache[userId] then 
        playersCache[userId] = {}
    end

    playersCache[userId] = Aims
    if saveTime then 
        vRP.setUData(userId, "Aims", json.encode(playersCache[userId]))
    end
    
    return true 
end
----------------------------------------------------------------------------------------------------------------------------------------------------
-- LIST AIMS
----------------------------------------------------------------------------------------------------------------------------------------------------
function registerTunnel.Aims()
    local source = source 
    local userId = vRP.getUserId(source)
    if not userId then return end 

    local userAims = json.decode(vRP.getUData(userId, "Aims")) or {}
    if next(userAims) then 
        return userAims
    end

    return false 
end
----------------------------------------------------------------------------------------------------------------------------------------------------
-- MAX AIMS
----------------------------------------------------------------------------------------------------------------------------------------------------
function registerTunnel.Max()
    local source = source 
    local userId = vRP.getUserId(source)
    if not userId then return end 

    local amountAims = 3 
    for nameGroup,extraAims in pairs(specialSlots) do 
        if vRP.hasGroup(userId, nameGroup) or vRP.hasPermission(userId, nameGroup) then 
            amountAims = amountAims + extraAims
            break
        end
    end

    return amountAims
end
----------------------------------------------------------------------------------------------------------------------------------------------------
-- PRINT CODE
----------------------------------------------------------------------------------------------------------------------------------------------------
function registerTunnel.Output(Env64)
    local source = source 
    local userId = vRP.getUserId(source)
    if not userId then return end 

    local userPremium = false
    for k,v in pairs(specialSlots) do 
        if vRP.hasGroup(userId, k) or vRP.hasPermission(userId, k) then 
            userPremium = true 
            break
        end
    end

    if userPremium then 
        vRP.prompt(source, "Copie o Código da Mira", Env64)
    else
        TriggerClientEvent("Notify",source,"negado","Você precisa de um vip para realizar essa ação.",5)
    end

    return true 
end
----------------------------------------------------------------------------------------------------------------------------------------------------
-- SAVE ON EXIT
----------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(userId,userSource)
    if not playersCache[userId] then return end 

    vRP.setUData(userId, "Aims", json.encode(playersCache[userId]))
end)

