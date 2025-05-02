local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')
vCLIENT = Tunnel.getInterface('radio')
src = {}
Tunnel.bindInterface('radio', src)

function src.hasPermission(value,service)
    local source = source
    local user_id = vRP.getUserId(source)
    if service and not vRP.checkPatrulhamento(user_id) then 
        return false, TriggerClientEvent("Notify",source,"negado","Você precisa estar em serviço.",3000)
    end

    return vRP.hasPermission(user_id, value)
end

function src.hasRadio()
    local source = source
    local user_id = vRP.getUserId(source)
    if exports["vrp"]:checkCommand(user_id) then
        return vRP.getInventoryItemAmount(user_id, 'radio') >= 1
    end
end