local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "five_setgroup")

local cfg = module("vrp", "cfg/groups")
local groups = cfg.groups

local webhookadmin = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

RegisterNetEvent('five_setgroup:buscarGrupos')
AddEventHandler('five_setgroup:buscarGrupos',function(id)
    local user_id = vRP.getUserId(source)
    local playerId = tonumber(id)
    if vRP.hasPermission(user_id, "admin.permissao") or user_id == 1 then
        local ssgrupo = {}
        local ppgrupo = {}
        for s_grupos, k in pairs(groups) do
            if s_grupos ~= "user" then table.insert(ssgrupo, s_grupos) end
        end

        p_grupos = vRP.getUserGroups(playerId)
        for x, y in pairs(p_grupos) do
            if x ~= "user" then table.insert(ppgrupo, x) end
        end

        table.sort(ppgrupo)
        table.sort(ssgrupo)

        TriggerClientEvent("five_setgroup:abrirAdminG", source, ssgrupo, ppgrupo, playerId)
    end
end)

RegisterNetEvent('five_setgroup:aceito')
AddEventHandler('five_setgroup:aceito',function(grupos, playerId)
    local source = source
    local player = tonumber(playerId)
    local user_id = vRP.getUserId(tonumber(source))
    local identity = vRP.getUserIdentity(tonumber(user_id))
    p_grupos = vRP.getUserGroups(player)
    for x, y in pairs(p_grupos) do
            if x ~= "user" then
                vRP.removeUserGroup(player, x)
            end
       -- print(SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.nome.." "..identity.sobrenome.." \n[SETOU]: "..ssgrupo.." \n[GRUPO]: "..ssgrupo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```"))
    end

    for a,b in pairs(grupos) do
        local newGroup = table.maxn(grupos)
        vRP.addUserGroup(player,b)
        SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.nome.." "..identity.sobrenome.." \n[SETOU O ID]: "..player.." \n[NO GRUPO]: "..grupos[tonumber(newGroup)].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
    end
end)

RegisterCommand("limpar", function(source, args)
    TriggerClientEvent('vrp_escconcessionaria:limpar',-1)
end)
