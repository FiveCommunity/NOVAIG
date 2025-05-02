Tunnel  = module("vrp","lib/Tunnel")
local RESOURCE_NAME <const> = GetCurrentResourceName()
local Proxy <const>         = module("vrp","lib/Proxy")
local Tools  <const>        = module("vrp","lib/Tools")

---@alias vector3 table

IdGen = Tools.newIDGenerator()
vRP = Proxy.getInterface("vRP")
vRPc = Tunnel.getInterface("vRP")
local CloseListeners = {}

if IsDuplicityVersion() and not _G["API"] then 
    _G["API"] = {}
    Tunnel.bindInterface(RESOURCE_NAME,API)
    function API.emitCloseListeners()
        local source    = source
        local user_id   = vRP.getUserId(source)
        for i = 1,#CloseListeners do 
            CloseListeners[i](source, user_id)
        end
    end
end

Remote = Tunnel.getInterface(RESOURCE_NAME)


---@param source number | string
---@param notifyType "negado" | "sucesso" | "importante" | "veiculo" | "carro"
---@param message string
---@return any
_G["Notify"] = function(source, notifyType, message)
    return TriggerClientEvent("Notify", source, notifyType, message)
end

---@param players table
---@param member string
---@vararg ... unknown
_G["TriggerNearEvent"] = function(players, member, ...)
    for i = 1, #players do 
        Remote["_"..member](players[i], ...)
    end
end

_G["AddCloseListener"] = function(cb)
    table.insert(CloseListeners, cb)
end
