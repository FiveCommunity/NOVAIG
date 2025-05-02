-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehMenu = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCONTROL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("open_vehicle",function(source,args)
	if not vehMenu then
		local ped = PlayerPedId()
		if not IsEntityInWater(ped) and GetEntityHealth(ped) > 101 then
			local vehicle = vRP.ModelName(7)
			if vehicle then
				SendNUIMessage({ show = true })
				SetCursorLocation(0.5,0.8)
				SetNuiFocus(true,true)
				vehMenu = true
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCONTROL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("open_vehicle","Abrir o menu rapido..","keyboard","F3")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function(data)
	SendNUIMessage({ show = false })
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	vehMenu = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MENUACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("menuActive",function(data)
	if data["active"] == "chest" then
		exports["inventory"]:openTrunk()
		SendNUIMessage({ show = false })
		SetCursorLocation(0.5,0.5)
		SetNuiFocus(false,false)
		vehMenu = false
	elseif data["active"] == "door1" then
		ExecuteCommand("portas 1")
	elseif data["active"] == "door2" then
		ExecuteCommand("portas 2")
	elseif data["active"] == "door3" then
		ExecuteCommand("portas 3")
	elseif data["active"] == "door4" then
		ExecuteCommand("portas 4")
	elseif data["active"] == "trunk" then
		ExecuteCommand("portas 5")
	elseif data["active"] == "hood" then
		ExecuteCommand("capo")
	elseif data["active"] == "trunkin" then
		TriggerServerEvent("trunkin")

		SendNUIMessage({ show = false })
		SetCursorLocation(0.5,0.5)
		SetNuiFocus(false,false)
		vehMenu = false
	elseif data["active"] == "vtuning" then
		ExecuteCommand("vtuning")

		SendNUIMessage({ show = false })
		SetCursorLocation(0.5,0.5)
		SetNuiFocus(false,false)
		vehMenu = false
	end
end)