identity = {}
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
Tunnel.bindInterface(GetCurrentResourceName(), identity)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())

RegisterKeyMapping("rg", "Identidade", "keyboard", "F11")

RegisterNetEvent('nova_identity:hide', function()
	identity.hidden = false
	SendNUIMessage({ action = "close" })
end)

RegisterCommand("rg", function()
	if GetEntityHealth(PlayerPedId()) > 101 then
		if not identity.hidden then
			identity.hidden = true
			SendNUIMessage(vSERVER.getInfos())
			TriggerEvent('lotus-hud:toggle', false)
		else
			identity.hidden = false
			SendNUIMessage({ action = "close" })
			TriggerEvent('lotus-hud:toggle', true)
		end
	end
end)