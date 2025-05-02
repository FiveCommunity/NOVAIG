local Tunnel <const>        = module("vrp", "lib/Tunnel")
local RESOURCE_NAME <const> = GetCurrentResourceName()
local Proxy <const>         = module("vrp", "lib/Proxy")

---@alias vector3 table

vRP                         = Proxy.getInterface("vRP")
vRPs                        = Tunnel.getInterface("vRP")

if not IsDuplicityVersion() and not _G["API"] then
    _G["API"] = {}
    Tunnel.bindInterface(RESOURCE_NAME, API)
end

Remote = Tunnel.getInterface(RESOURCE_NAME)

function API.closeInventory(time)
    SendNUIMessage({
        route = "CLOSE_INVENTORY"
    })
    SetNuiFocus(false, false)
end

RegisterCommand("abrirmochilarevoada", function()
    if LocalPlayer.state.pvp or LocalPlayer.state.defuse_mode or vRP.isHandcuffed() or (GetEntityHealth(PlayerPedId()) <= 101) then
        TriggerEvent("Notify", "negado", "Você não pode acessar seu inventario agora.")
        return
    end

	local profile = Remote.getProfile()

    SendNUIMessage({
        route = "OPEN_INVENTORY",
    })
    SetNuiFocus(true, true)
end, false)

CreateThread(function()
    RegisterKeyMapping("abrirmochilarevoada", "Abrir a mochila", "keyboard", "OEM_3")
    RegisterKeyMapping("openchest", "Trunkchest Open", "keyboard", "PAGEUP")
end)

function API.getActivePlayers()
    local response = {}
    local players = GetActivePlayers()
    for i = 1, #players do
        response[#response + 1] = GetPlayerServerId(players[i])
    end
    return response
end

function API.sendNuiEvent(ev)
    SendNUIMessage(ev)
end

CreateThread(function()
    SetNuiFocus(false, false)
end)

AddEventHandler(GetCurrentResourceName() .. ":sendNuiEvent", function(ev)
    if IsNuiFocused() and not IsNuiFocusKeepingInput() then
        SendNUIMessage(ev)
    end
end)

function LoadModel(Model)
	if IsModelInCdimage(Model) and IsModelValid(Model) then
		RequestModel(Model)

		while not HasModelLoaded(Model) do
			RequestModel(Model)

			Citizen.Wait(1)
		end

		return true
	end

	return false
end

function GetCoordsFromCam(Distance, Coords)
	local Rotation = GetGameplayCamRot()
	local Adjusted = vec3((math.pi / 180) * Rotation['x'], (math.pi / 180) * Rotation['y'], (math.pi / 180) * Rotation['z'])
	local Direction = vec3(-math.sin(Adjusted[3]) * math.abs(math.cos(Adjusted[1])), math.cos(Adjusted[3]) * math.abs(math.cos(Adjusted[1])), math.sin(Adjusted[1]))

	return vec3(Coords[1] + Direction[1] * Distance, Coords[2] + Direction[2] * Distance, Coords[3] + Direction[3] * Distance)
end

function API.objectCoords(Model)
	local Aplication = false
	local ObjectCoords = false
	local ObjectHeading = false

	if LoadModel(Model) then
		local Progress = true

		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)
		local Heading = GetEntityHeading(Ped)
		local NextObject = CreateObjectNoOffset(Model, Coords['x'], Coords['y'], Coords['z'], false, false, false)

		SetEntityCollision(NextObject, false, false)
		SetEntityHeading(NextObject, Heading)
		SetEntityAlpha(NextObject, 100, false)

		while Progress do
			local Ped = PlayerPedId()
			local Cam = GetGameplayCamCoord()
			local Handle = StartExpensiveSynchronousShapeTestLosProbe(Cam, GetCoordsFromCam(10.0, Cam), -1, Ped, 4)
			local _, _, Coords = GetShapeTestResult(Handle)

			if Model == 'prop_ld_binbag_01' then
				SetEntityCoords(NextObject, Coords['x'], Coords['y'], Coords['z'] + 0.9, false, false, false, false)
			else
				SetEntityCoords(NextObject, Coords['x'], Coords['y'], Coords['z'], false, false, false, false)
			end

			DwText('~g~F~w~  CANCELAR', 4, 0.015, 0.86, 0.38, 255, 255, 255, 255)
			DwText('~g~E~w~  COLOCAR OBJETO', 4, 0.015, 0.89, 0.38, 255, 255, 255, 255)
			DwText('~y~SCROLL UP~w~  GIRA ESQUERDA', 4, 0.015, 0.92, 0.38, 255, 255, 255, 255)
			DwText('~y~SCROLL DOWN~w~  GIRA DIREITA', 4, 0.015, 0.95, 0.38, 255, 255, 255, 255)

			if IsControlJustPressed(1, 38) then
				Aplication = true
				Progress = false
			end

			if IsControlJustPressed(0, 49) then
				Progress = false
			end

			if IsControlJustPressed(0, 180) then
				local Heading = GetEntityHeading(NextObject)
				
				SetEntityHeading(NextObject, Heading + 2.5)
			end

			if IsControlJustPressed(0, 181) then
				local Heading = GetEntityHeading(NextObject)

				SetEntityHeading(NextObject, Heading - 2.5)
			end

			Wait(1)
		end

		ObjectCoords = GetEntityCoords(NextObject)
		ObjectHeading = GetEntityHeading(NextObject)

		DeleteEntity(NextObject)
	end

	return Aplication, ObjectCoords, ObjectHeading
end

function DwText(Text, Font, x, y, Scale, R, G, B, A)
	SetTextFont(Font)
	SetTextScale(Scale, Scale)
	SetTextColour(R, G, B, A)
	SetTextOutline()
	SetTextEntry('STRING')
	AddTextComponentString(Text)
	DrawText(x, y)
end

function API.createObject(obj, coords)
	local hash = GetHashKey(obj)
	if LoadModel(hash) then
		local object = CreateObject(hash, coords.x, coords.y, coords.z, true, true, true)
		local netId = ObjToNet(object)
		SetModelAsNoLongerNeeded(hash)
		NetworkRegisterEntityAsNetworked(object)
		SetNetworkIdExistsOnAllMachines(netId, true)
		SetNetworkIdCanMigrate(netId, true)
		SetEntityHeading(object, coords.h)
		SetEntityAsMissionEntity(object, true, true)
		FreezeEntityPosition(object, true)
		PlaceObjectOnGroundProperly(object)
	end
end

RegisterNUICallback('openStore', function(data, cb)
	ExecuteCommand('loja')
	cb(true)
end)