-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local showBlips = {}
local timeBlips = {}
local numberBlips = 0

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("notify",function(source,args)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		SendNUIMessage({ action = "showAll" })
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("notify","Abrir as notificações","keyboard","f1")

-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFYPUSH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("NotifyPush")
AddEventHandler("NotifyPush",function(data)
	numberBlips = numberBlips + 1

	if numberBlips then
		--PlaySoundFrontend(-1,"CHALLENGE_UNLOCKED","HUD_AWARDS",false)

		data["street"] = GetStreetNameFromHashKey(GetStreetNameAtCoord(data["x"],data["y"],data["z"]))
		SendNUIMessage({ action = "notify", data = data })

		timeBlips[numberBlips] = data["time"]
		showBlips[numberBlips] = AddBlipForCoord(data["x"],data["y"],data["z"])
		SetBlipSprite(showBlips[numberBlips], data["blipID"])
		SetBlipColour(showBlips[numberBlips], data["blipColor"])
		SetBlipScale(showBlips[numberBlips], data["blipScale"])
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(data["title"])
		EndTextCommandSetBlipName(showBlips[numberBlips])
		SetBlipAlpha(showBlips[numberBlips],150)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(timeBlips) do
			if timeBlips[k] > 0 then
				timeBlips[k] = timeBlips[k] - 1

				if timeBlips[k] <= 0 then
					RemoveBlip(showBlips[k])
					showBlips[k] = nil
					timeBlips[k] = nil
				end
			end
		end

		Citizen.Wait(1000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FOCUSON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("focusOn",function()
	SetNuiFocus(true,true)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FOCUSOFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("focusOff",function()
	SetNuiFocus(false,false)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("setWay",function(data)
	SetNewWaypoint(data["x"] + 0.0001,data["y"] + 0.0001)
	SendNUIMessage({ action = "hideAll" })
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("phoneCall",function(data)
	SendNUIMessage({ action = "hideAll" })
	TriggerEvent("gcPhone:callNotifyPush",data.phone)
end)