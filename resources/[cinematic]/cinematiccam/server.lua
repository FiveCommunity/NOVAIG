local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("cinematiccam",src)
Proxy.addInterface("cinematiccam",src)
--------------------------------------------------
---------------------- EVENTS --------------------
--------------------------------------------------

RegisterServerEvent('CinematicCam:requestPermissions')
AddEventHandler('CinematicCam:requestPermissions', function()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "perm.cam") then 
		local isWhitelisted = false
		TriggerClientEvent('CinematicCam:receivePermissions', source, true)
	end
end)


function src.getPermissao(toogle)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "perm.cam") then 
        return true
    else
        return false
    end
end

RegisterServerEvent('cam:enterInCan', function()
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then
        return
    end

    if not vRP.hasPermission(user_id, "developer.permissao") and not vRP.hasPermission(user_id, "perm.cam") then
        return
    end

    vRP.sendLog('', string.format('o [ID] %s usou o /cam na [CDS] %s', userId, GetEntityCoords(GetPlayerPed(source))))
end)