local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_control",src)
Proxy.addInterface("vrp_control",src)

---------------------------------------------------------------------------------------------------------------------------------------
-- LUX VEH CONTROL
---------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("lvc_TogDfltSrnMuted_s")
AddEventHandler("lvc_TogDfltSrnMuted_s",function(toggle,playerAround)
	local source = source

	if playerAround then
		for _,v in ipairs(playerAround) do
			TriggerClientEvent("lvc_TogDfltSrnMuted_c",v,source,toggle)	
		end	
	end
end)
---------------------------------------------------------------------
RegisterServerEvent("lvc_SetLxSirenState_s")
AddEventHandler("lvc_SetLxSirenState_s", function(newstate,playerAround)
	local source = source

	if playerAround then
		for _,v in ipairs(playerAround) do
			TriggerClientEvent("lvc_SetLxSirenState_c",v,source,newstate)
		end	
	end
end)
---------------------------------------------------------------------
RegisterServerEvent("lvc_SetAirManuState_s")
AddEventHandler("lvc_SetAirManuState_s", function(newstate,playerAround)
	local source = source

	if playerAround then
		for _,v in ipairs(playerAround) do
			TriggerClientEvent("lvc_SetAirManuState_c",v,source,newstate)
		end	
	end
end)
---------------------------------------------------------------------
RegisterServerEvent("lvc_TogIndicState_s")
AddEventHandler("lvc_TogIndicState_s", function(newstate,playerAround)
	local source = source

	if playerAround then
		for _,v in ipairs(playerAround) do
			TriggerClientEvent("lvc_TogIndicState_c",v,source,newstate)
		end	
	end
end)

