local menu_state = {}
local segundos = 0
local celular_state = false

RegisterNetEvent("gcPhone:celular")
AddEventHandler("gcPhone:celular",function(status)
	celular_state = status
end)

function tvRP.openMenuData(menudata)
	SendNUIMessage({ act = "open_menu", menudata = menudata })
end

function tvRP.closeMenu()
	SendNUIMessage({ act = "close_menu" })
end

function tvRP.prompt(title,default_text)
	SendNUIMessage({ act = "prompt", title = title, text = tostring(default_text) })
	SetNuiFocus(true)
end

function tvRP.request(id,text,time)
	SendNUIMessage({ act = "request", id = id, text = tostring(text), time = time })
end

RegisterNUICallback("menu",function(data,cb)
	if data.act == "close" then
		vRPserver._closeMenu(data.id)
	elseif data.act == "valid" then
		vRPserver._validMenuChoice(data.id,data.choice,data.mod)
	end
end)

RegisterNUICallback("menu_state",function(data,cb)
	menu_state = data
end)

RegisterNUICallback("prompt",function(data,cb)
	if data.act == "close" then
		SetNuiFocus(false)
		vRPserver._promptResult(data.result)
	end
end)

RegisterNUICallback("request",function(data,cb)
	if data.act == "response" then
		vRPserver._requestResult(data.id,data.ok)
	end
end)

RegisterNUICallback("init",function(data,cb)
	SendNUIMessage({ act = "cfg", cfg = {} })
	TriggerEvent("vRP:NUIready")
end)

function tvRP.setDiv(name,css,content)
	SendNUIMessage({ act = "set_div", name = name, css = css, content = content })
end

function tvRP.setDivContent(name,content)
	SendNUIMessage({ act = "set_div_content", name = name, content = content })
end

function tvRP.removeDiv(name)
	SendNUIMessage({ act = "remove_div", name = name })
end

function tvRP.loadAnimSet(dict)
	RequestAnimSet(dict)
	while not HasAnimSetLoaded(dict) do
		Citizen.Wait(10)
	end
	SetPedMovementClipset(PlayerPedId(),dict,0.25)
end

function tvRP.apagarTela()
	DoScreenFadeOut(1000)
	Wait(1000)
end

function tvRP.acenderTela()
	Wait(3000)
	DoScreenFadeIn(1000)
	Wait(1000)
end

function tvRP.CarregarAnim(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10)
	end
end

function tvRP.CarregarObjeto(dict,anim,prop,flag,mao,altura,pos1,pos2,pos3)
	local ped = PlayerPedId()

	RequestModel(GetHashKey(prop))
	while not HasModelLoaded(GetHashKey(prop)) do
		Citizen.Wait(10)
	end

	if altura then
		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
		object = CreateObject(GetHashKey(prop),coords.x,coords.y,coords.z,true,true,true)
		SetEntityCollision(object,false,false)
		TriggerEvent("setProp", object)
		AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,mao),altura,pos1,pos2,pos3,260.0,60.0,true,true,false,true,1,true)
	else
		tvRP.CarregarAnim(dict)
		TaskPlayAnim(ped,dict,anim,3.0,3.0,-1,flag,0,0,0,0)
		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
		object = CreateObject(GetHashKey(prop),coords.x,coords.y,coords.z,true,true,true)
		SetEntityCollision(object,false,false)
		TriggerEvent("setProp", object)
		AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,mao),0.0,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
	end
	SetEntityAsMissionEntity(object,true,true)
end

function tvRP.DeletarObjeto()
	tvRP.stopAnim(true)
	TriggerEvent("binoculos")
	if DoesEntityExist(object) then
		DetachEntity(object,false,false)
		TriggerServerEvent("trydeleteobj",ObjToNet(object))
		object = nil
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOQUEAR ARMAS QUANDO ESTIVER COM ANIMACAO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
        local time = 1000
        local ped = PlayerPedId()
        if IsEntityPlayingAnim(ped,"anim@amb@nightclub@peds@","rcmme_amanda1_stand_loop_cop",3) or IsEntityPlayingAnim(ped,"anim@mp_player_intupperface_palm","idle_a",3) or IsEntityPlayingAnim(ped,"anim@heists@heist_corona@single_team","single_team_loop_boss",3) or IsEntityPlayingAnim(ped,"anim@mp_player_intupperfinger","idle_a_fp",3) or IsEntityPlayingAnim(ped,"random@arrests@busted","idle_a",3) or IsEntityPlayingAnim(ped,"random@mugging3","handsup_standing_base",3) or IsEntityPlayingAnim(ped,"mini@strip_club@idles@bouncer@base","base",3) or IsEntityPlayingAnim(ped,"rcmnigel1c","hailing_whistle_waive_a",3) or IsEntityPlayingAnim(ped,"anim@mp_player_intupperthumbs_up","enter",3) or IsEntityPlayingAnim(ped,"anim@mp_player_intcelebrationmale@face_palm","face_palm",3) or IsEntityPlayingAnim(ped,"anim@mp_player_intcelebrationmale@salute","salute",3) then
            time = 500
            SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
        end
        Citizen.Wait(time)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ANTI DUMP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("antiDump", function(data, cb)
	vRPserver._banAntiDump()
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITENSNOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("itensNotify")
AddEventHandler("itensNotify",function(mode, quantidade, itemname, idname, kgTotal) 
	SendNUIMessage({ mode = mode, quantidade = quantidade, nome = itemname, item = idname, kgTotal = kgTotal })
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TASKBAR
-----------------------------------------------------------------------------------------------------------------------------------------
local chance = 0
local skillGap = 0
local activeTasks = 0
local taskInProcess = false
local resultTask = nil

--[[ function tvRP.taskBar(difficulty,skillGapSent)
	Citizen.Wait(100)

	skillGap = skillGapSent

	if skillGap < 5 then
		skillGap = 5
	end

	if taskInProcess then
		return false
	end

	chance = math.random(20,80)

	local length = math.ceil(difficulty*1.0)

	taskInProcess = true
	local taskIdentifier = "taskid"..math.random(1000000)
	openGui(length,taskIdentifier,chance,skillGap)
	activeTasks = 1
	resultTask = nil

	local maxcount = GetGameTimer() + length

	while resultTask == nil do
		Citizen.Wait(1)
	end
	while activeTasks == 1 do
		Citizen.Wait(1)
		local curTime = GetGameTimer()
		if curTime > maxcount then
			activeTasks = 2
		end
		local updater = 100 - (((maxcount - curTime)/length)*100)
		updater = math.min(100,updater)
		updateGui(updater,taskIdentifier,chance,skillGap)
	end

	closeGui()
	taskInProcess = false

	if activeTasks == 2 then
		return false
	else
		return true
	end
end ]]

function tvRP.taskBar()
	Citizen.Wait(100)

	if taskInProcess then
		return false
	end

	taskInProcess = true
	openGui()
	activeTasks = 1
	resultTask = nil


	while resultTask == nil do
		Citizen.Wait(1)
	end

	closeGui()
	SendNUIMessage({ action = 'clearTasks' })
	taskInProcess = false

	return resultTask

	--[[ if activeTasks == 2 then
		return false
	else
		return true
	end ]]
end

function openGui(sentLength,taskID,chancesent,skillGapSent)
	SetNuiFocus(true,false)
	SendNUIMessage({ action = 'createTask' })
	-- SendNUIMessage({ create = true, Length = sentLength, Task = taskID, chance = chancesent, skillGap = skillGapSent })
end

--[[ function updateGui(sentLength,taskID,chancesent,skillGapSent)
	SendNUIMessage({ runUpdate = true, Length = sentLength, Task = taskID, chance = chancesent, skillGap = skillGapSent })
end ]]

function closeGui()
	SetNuiFocus(false,false)
	SendNUIMessage({ closeProgress = true })
end

function closeNormalGui()
	SetNuiFocus(false,false)
end

RegisterNUICallback("taskEnd",function(data,cb)
	resultTask = data
	closeNormalGui()
	--[[ if (tonumber(data.taskResult) > chance) and tonumber(data.taskResult) < (chance + skillGap + 3) then
		activeTasks = 3
		closeNormalGui()
	else
		activeTasks = 2
		closeNormalGui()
	end ]]
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCCLEAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncclean")
AddEventHandler("syncclean",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleDirtLevel(v,0.0)
				SetVehicleUndriveable(v,false)
				tvRP.DeletarObjeto()
			end
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- KEY MAPPING MENU
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("keybind",function(source,args)
	if not IsPauseMenuActive() then
		local ped = PlayerPedId()
		-- if GetEntityHealth(ped) > 105 then
			
			if args[1] == "left" and menu_state.opened then
				tvRP.playSound("NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET")
				SendNUIMessage({ act = "event", event = "LEFT" })

			elseif args[1] == "right" and menu_state.opened then
				tvRP.playSound("NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET")
				SendNUIMessage({ act = "event", event = "RIGHT" })

			elseif args[1] == "up" and menu_state.opened then
				tvRP.playSound("NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET")
				SendNUIMessage({ act = "event", event = "UP" })

			elseif args[1] == "down" and menu_state.opened then
				tvRP.playSound("NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET")
				SendNUIMessage({ act = "event", event = "DOWN" })

			elseif args[1] == "select" and menu_state.opened then
				tvRP.playSound("SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET")
				SendNUIMessage({ act = "event", event = "SELECT" })

			elseif args[1] == "accept" then
				SendNUIMessage({ act = "event", event = "Y" })

			elseif args[1] == "reject" then
				SendNUIMessage({ act = "event", event = "U" })

			elseif args[1] == "exit" then
				SendNUIMessage({ act = "event", event = "CANCEL" })
				
			elseif args[1] == "exit2" then
				SendNUIMessage({ act = "event", event = "CANCEL" })
			end

		-- end
	end
end)

RegisterKeyMapping("keybind accept","Aceitar chamado","keyboard","y")
RegisterKeyMapping("keybind reject","Rejeitar chamado","keyboard","u")
RegisterKeyMapping("keybind left","Menu Esquerda","keyboard","left")
RegisterKeyMapping("keybind right","Menu Direita","keyboard","right")
RegisterKeyMapping("keybind up","Menu Cima","keyboard","up")
RegisterKeyMapping("keybind down","Menu Baixo","keyboard","down")
RegisterKeyMapping("keybind select","Menu Select","keyboard","return")
RegisterKeyMapping("keybind exit","Fechar Menu","keyboard","escape")
RegisterKeyMapping("keybind exit2","Fechar Menu 2","keyboard","BACK")

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- KEY MAPPING DE EMOTES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local agachar = false
local apontar = false
local object = nil

RegisterCommand('emote', function(source,args)
	if not IsPauseMenuActive() then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 105 and not celular_state and not menu_state.opened then
			if not IsPedInAnyVehicle(ped) then
				if args[1] == "aguardar" then
					if IsEntityPlayingAnim(ped,"anim@amb@nightclub@peds@","rcmme_amanda1_stand_loop_cop",3) then
						tvRP.DeletarObjeto()
					else
						tvRP.playAnim(true,{{"anim@amb@nightclub@peds@","rcmme_amanda1_stand_loop_cop"}},true)
					end
				elseif args[1] == "aguardar2" then
					if IsEntityPlayingAnim(ped,"mini@strip_club@idles@bouncer@base","base",3) then
						tvRP.DeletarObjeto()
					else
						tvRP.playAnim(true,{{"mini@strip_club@idles@bouncer@base","base"}},true)
					end
				-- elseif args[1] == "dedomeio" then
				-- 	if IsEntityPlayingAnim(ped,"anim@mp_player_intupperfinger","idle_a_fp",3) then
				-- 		tvRP.DeletarObjeto()
				-- 	else
				-- 		tvRP.playAnim(true,{{"anim@mp_player_intupperfinger","idle_a_fp"}},true)
				-- 	end
				elseif args[1] == "assobiar" then
					if IsEntityPlayingAnim(ped,"rcmnigel1c","hailing_whistle_waive_a",3) then
						tvRP.DeletarObjeto()
					else
						tvRP.playAnim(true,{{"rcmnigel1c","hailing_whistle_waive_a"}}, false)
					end
				elseif args[1] == "joia" then
					if IsEntityPlayingAnim(ped,"anim@mp_player_intupperthumbs_up","enter",3) then
						tvRP.DeletarObjeto()
					else
						tvRP.playAnim(true,{{"anim@mp_player_intupperthumbs_up","enter"}}, false)
					end
				elseif args[1] == "lamentar" then
					if IsEntityPlayingAnim(ped,"anim@mp_player_intcelebrationmale@face_palm","face_palm",3) then
						tvRP.DeletarObjeto()
					else
						tvRP.playAnim(true,{{"anim@mp_player_intcelebrationmale@face_palm","face_palm"}},false)
					end
				elseif args[1] == "saudacao" then
					if IsEntityPlayingAnim(ped,"anim@mp_player_intcelebrationmale@salute","salute",3) then
						tvRP.DeletarObjeto()
					else
						tvRP.playAnim(true,{{"anim@mp_player_intcelebrationmale@salute","salute"}},false)
					end
				elseif args[1] == "maonacabeca" then
					if IsEntityPlayingAnim(ped,"random@arrests@busted","idle_a",3) then
						tvRP.DeletarObjeto()
					else
						tvRP.playAnim(true,{{"random@arrests@busted","idle_a"}},true)
					end
				elseif args[1] == "levantarmao" then
					SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
					if IsEntityPlayingAnim(ped,"random@mugging3","handsup_standing_base",3) then
						tvRP.DeletarObjeto()
					else
						tvRP.playAnim(true,{{"random@mugging3","handsup_standing_base"}},true)
					end
				elseif args[1] == "apontar" then
					tvRP.CarregarAnim("anim@mp_point")
					if not apontar then
						SetPedCurrentWeaponVisible(ped,0,1,1,1)
						SetPedConfigFlag(ped,36,1)
						Citizen.InvokeNative(0x2D537BA194896636,ped,"task_mp_pointing",0.5,0,"anim@mp_point",24)
						apontar = true
					else
						Citizen.InvokeNative(0xD01015C7316AE176,ped,"Stop")
						if not IsPedInjured(ped) then
							ClearPedSecondaryTask(ped)
						end
						if not IsPedInAnyVehicle(ped) then
							SetPedCurrentWeaponVisible(ped,1,1,1,1)
						end
						SetPedConfigFlag(ped,36,0)
						ClearPedSecondaryTask(ped)
						apontar = false
					end
				elseif args[1] == "agachar" then
					if not IsPedInAnyVehicle(ped) then
						if agachar then
							ResetPedMovementClipset(ped,0.25)
							ResetPedStrafeClipset(ped)
							agachar = false
						else
							RequestAnimSet("move_ped_crouched")
							RequestAnimSet("move_ped_crouched_strafing")

							SetPedMovementClipset(ped,"move_ped_crouched",0.25)
							SetPedStrafeClipset(ped,"move_ped_crouched_strafing")
							agachar = true
						end
					end
				end
			else
				if args[1] == "motor" then
					local vehicle = GetVehiclePedIsIn(ped,false)
					if GetPedInVehicleSeat(vehicle,-1) == ped then
						tvRP.DeletarObjeto()
						local running = Citizen.InvokeNative(0xAE31E7DF9B5B132E,vehicle)
						SetVehicleEngineOn(vehicle,not running,true,true)
						if running then
							SetVehicleUndriveable(vehicle,true)
						else
							SetVehicleUndriveable(vehicle,false)
						end
					end
				end
			end
		end
	end
end)

RegisterKeyMapping("emote aguardar","Executar Animação","keyboard","f1")
RegisterKeyMapping("emote aguardar2","Executar Animação","keyboard","f2")
RegisterKeyMapping("emote assobiar","Executar Animação","keyboard","down")
RegisterKeyMapping("emote joia","Executar Animação","keyboard","left")
RegisterKeyMapping("emote lamentar","Executar Animação","keyboard","right")
RegisterKeyMapping("emote saudacao","Executar Animação","keyboard","up")
RegisterKeyMapping("emote maonacabeca","Executar Animação","keyboard","f10")
RegisterKeyMapping("emote levantarmao","Executar Animação","keyboard","x")
RegisterKeyMapping("emote motor","Executar Animação","keyboard","z")
RegisterKeyMapping("emote apontar","Executar Animação","keyboard","b")
RegisterKeyMapping("emote agachar","Executar Animação","keyboard","LCONTROL")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR MENUS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("open",function(source,args)
	if not IsPauseMenuActive() then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 105 then
			if args[1] == "org" then
				vRPserver._openOrgMenu()
			end
		end
	end
end)

RegisterKeyMapping("open org","Abrir Menu da Org","keyboard","insert")

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local time = 1000
		if agachar then
			time = 0
			DisableControlAction(1,24,true)
			DisablePlayerFiring(GetPlayerPed(-1), true)
		end

        Citizen.Wait(time)
	end
end)

Citizen.CreateThread(function()
	while true do
		local time = 1000
        if apontar then
			local ped = PlayerPedId()

            time = 5
			local camPitch = GetGameplayCamRelativePitch()
			if camPitch < -70.0 then
				camPitch = -70.0
			elseif camPitch > 42.0 then
				camPitch = 42.0
			end
			camPitch = (camPitch + 70.0) / 112.0

			local camHeading = GetGameplayCamRelativeHeading()
			local cosCamHeading = Cos(camHeading)
			local sinCamHeading = Sin(camHeading)
			if camHeading < -180.0 then
				camHeading = -180.0
			elseif camHeading > 180.0 then
				camHeading = 180.0
			end
			camHeading = (camHeading + 180.0) / 360.0

			local blocked = 0
			local nn = 0
			local coords = GetOffsetFromEntityInWorldCoords(ped,(cosCamHeading*-0.2)-(sinCamHeading*(0.4*camHeading+0.3)),(sinCamHeading*-0.2)+(cosCamHeading*(0.4*camHeading+0.3)),0.6)
			local ray = Cast_3dRayPointToPoint(coords.x,coords.y,coords.z-0.2,coords.x,coords.y,coords.z+0.2,0.4,95,ped,7);
			nn,blocked,coords,coords = GetRaycastResult(ray)

			Citizen.InvokeNative(0xD5BB4025AE449A4E,ped,"Pitch",camPitch)
			Citizen.InvokeNative(0xD5BB4025AE449A4E,ped,"Heading",camHeading*-1.0+1.0)
			Citizen.InvokeNative(0xB0A6CFD2C69C1088,ped,"isBlocked",blocked)
			Citizen.InvokeNative(0xB0A6CFD2C69C1088,ped,"isFirstPerson",Citizen.InvokeNative(0xEE778F8C7E1142E2,Citizen.InvokeNative(0x19CAFA3C87F7C2FF))==4)
        end

        Citizen.Wait(time)
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Segundos Counter
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if segundos > 0 then
            segundos = segundos - 1
        end

        if segundos <= 0 then
            segundos = 0
        end
    end
end)
