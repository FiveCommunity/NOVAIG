local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")

cO = {}
Tunnel.bindInterface(GetCurrentResourceName(), cO)

local cooldownMessages = {}
local openedRequests = {}
function cO.callMessage(Organization,Option)
    local source = source 
    local userId = vRP.getUserId(source)
    if not userId then 
        return 
    end

    local organizationPerm = Interfones[Organization]
    if not organizationPerm then 
        return 
    end

    if cooldownMessages[userId] and cooldownMessages[userId] > os.time() then 
        return 
    end

    
    local membersOnline = vRP.getUsersByPermission(organizationPerm["permission"])
    if #membersOnline <= 0 then 
        return false, TriggerClientEvent("Notify",source,"negado","Nenhum membro da organização na cidade.",5000)
    end

    local identity = vRP.getUserIdentity(userId)
    openedRequests[userId] = true
    cooldownMessages[userId] = os.time() + 15
    for k,v in pairs(membersOnline) do 
        async(function()
            if openedRequests[userId] and vRP.getUserSource(parseInt(userId)) then
                local playerRequest = vRP.request(vRP.getUserSource(parseInt(v)),(identity.nome or "N/A").." "..(identity.sobrenome or "N/A").." ("..userId..") - Tocou o interfone com a intenção de <b>"..Option.."</b>, deseja atender?",60)
                if playerRequest then
                    if not openedRequests[userId] then
                        TriggerClientEvent("Notify",vRP.getUserSource(parseInt(v)),"negado", "O chamado já foi atendido por outra pessoa.")
                        return false
                    end

                    openedRequests[userId] = nil

                    local idTarget = vRP.getUserId(vRP.getUserSource(parseInt(v)))
                    local identityTarget = vRP.getUserIdentity(parseInt(idTarget))

                    TriggerClientEvent("Notify",source,"sucesso","SEU CHAMADO FOI ATENDIDO AGUARDE NO LOCAL, QUEM ATENDEU: "..identityTarget.nome.." "..identityTarget.sobrenome.." ("..idTarget..")",20)
                    if coords then
                        vRPC._setGPS(vRP.getUserSource(parseInt(v)), coords.x, coords.y)
                    end
                end
            end
        end)
    end
end