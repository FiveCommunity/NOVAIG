-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP")

shorts = {}
Tunnel.bindInterface("lotus-shortcuts", shorts)
termscheck = {}

RegisterKeyMapping("shortcuts", "Terms", "keyboard", "U")
RegisterCommand("shortcuts", function()
	if GetEntityHealth(PlayerPedId()) > 101 then
		if not terms then
			terms = true
			SendNUIMessage({ action = 'open' })
		else
			terms = false
            SendNUIMessage({ action = 'close' })
		end
	end
end)

RegisterNetEvent("shortcuts:terms",function(status)
    terms = status
    if terms then
			SendNUIMessage({ action = 'open' })
    else
			SendNUIMessage({ action = 'close' })
    end
end)

RegisterNetEvent('shortcuts:hide', function()
	terms = false
	SendNUIMessage({ action = "close" })
end)
