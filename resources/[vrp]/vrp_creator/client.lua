local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vSERVER = Tunnel.getInterface(GetCurrentResourceName())


local startClothes = {
	[`mp_m_freemode_01`] = {0,0,0,0,0,0,0,0,309,0,216,0,41,0,585,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	[`mp_f_freemode_01`] = {0,0,0,0,43,0,14,0,248,0,261,0,4,1,618,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}
}

RegisterNetEvent("character:normalSpawn")
RegisterNetEvent("character:characterCreate")

local cam = nil
local freezedOnTop = true
local doStatus = -1
local continuousFadeOutNetwork = false
local actual_gender = 1

local isInCharacterMode = false
local currentCharacterMode = { fathersID = 0, mothersID = 0, skinColor = 0, shapeMix = 0.0, eyesColor = 0, eyebrowsHeight = 0, eyebrowsWidth = 0, noseWidth = 0, noseHeight = 0, noseLength = 0, noseBridge = 0, noseTip = 0, noseShift = 0, cheekboneHeight = 0, cheekboneWidth = 0, cheeksWidth = 0, lips = 0, jawWidth = 0, jawHeight = 0, chinLength = 0, chinPosition = 0, chinWidth = 0, chinShape = 0, neckWidth = 0, hairModel = 4, firstHairColor = 0, secondHairColor = 0, eyebrowsModel = 0, eyebrowsColor = 0, beardModel = -1, beardColor = 0, chestModel = -1, chestColor = 0, blushModel = -1, blushColor = 0, lipstickModel = -1, lipstickColor = 0, blemishesModel = -1, ageingModel = -1, complexionModel = -1, sundamageModel = -1, frecklesModel = -1, makeupModel = -1 }
local idNome = ""
local idSobrenome = ""
local idIdade = 0


function f(n)
	n = n + 0.00000
	return n
end

function setCamHeight(height)
	local pos = GetEntityCoords(PlayerPedId())
	SetCamCoord(cam,vector3(pos.x,pos.y,f(height)))
end

local function StartFade()
	DoScreenFadeOut(500)
	while IsScreenFadingOut() do
		Citizen.Wait(1)
	end
end

local function EndFade()
	ShutdownLoadingScreen()
	DoScreenFadeIn(500)
	while IsScreenFadingIn() do
		Citizen.Wait(1)
	end
end

-- Citizen.CreateThread(function()
-- 	local time = 1000
-- 	SetNuiFocus(false,false)
-- 	SetEntityInvincible(PlayerPedId(),false) --mqcu
-- 	SetEntityVisible(PlayerPedId(),false)
-- 	FreezeEntityPosition(PlayerPedId(),true)
-- 	SetPedDiesInWater(PlayerPedId(),false)
-- 	TriggerCamController(doStatus)
-- 	while freezedOnTop do
-- 		time = 5
-- 		if doStatus == 1 then
-- 			SetEntityInvincible(PlayerPedId(),false) --mqcu
-- 			--SetEntityVisible(PlayerPedId(),true)
-- 			FreezeEntityPosition(PlayerPedId(),true)
-- 			SetPedDiesInWater(PlayerPedId(),false)
-- 		elseif doStatus == 2 then
-- 			TriggerCamController(doStatus)
-- 			SetEntityInvincible(PlayerPedId(),false)
-- 			SetEntityVisible(PlayerPedId(),true)
-- 			FreezeEntityPosition(PlayerPedId(),false)
-- 			SetPedDiesInWater(PlayerPedId(),true)
-- 			TriggerCamController(-2)
-- 			freezedOnTop = false
-- 		else
-- 			SetEntityInvincible(PlayerPedId(),false) --mqcu
-- 			SetEntityVisible(PlayerPedId(),false)
-- 			FreezeEntityPosition(PlayerPedId(),true)
-- 		end
-- 		Citizen.Wait(time)
-- 	end
-- end)

local altura
function TriggerCamController(statusSent)
	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",false)
	end

	if statusSent == -1 then
		local pos = GetEntityCoords(PlayerPedId())
		SetCamCoord(cam,vector3(pos.x,pos.y,f(1000)))
		SetCamRot(cam,-f(90),f(0),f(0),2)
		SetCamActive(cam,true)
		StopCamPointing(cam)
        RenderScriptCams(true,true,0,0,0,0)
    elseif statusSent == 2 then
		local pos = GetEntityCoords(PlayerPedId())
        SetCamCoord(cam,vector3(pos.x,pos.y,f(1000)))
        Wait(1500)
		altura = 1000
		while altura > 50 do
			if altura <= 300 then
				altura = altura - 6
			elseif altura >= 301 and altura <= 700 then
				altura = altura - 4
			else
				altura = altura - 2
			end
			setCamHeight(altura)
			Citizen.Wait(10)
		end
		
		TriggerEvent("flaviin:toggleHud", true)
	elseif statusSent == -2 then
		SetCamActive(cam,false)
		StopCamPointing(cam)
		RenderScriptCams(0,0,0,0,0,0)
		SetFocusEntity(PlayerPedId())
	elseif statusSent == 1 then
		SetCamCoord(cam,vector3(402.6,-997.2,-98.3))
		SetCamRot(cam,f(0),f(0),f(358),15)
		SetCamActive(cam,true)
		RenderScriptCams(true,true,20000000000000000000000000,0,0,0)
	end
end

RegisterNetEvent('ToogleBackCharacter')
AddEventHandler('ToogleBackCharacter', function()
	doStatus = 2
end)

AddEventHandler("character:characterCreate",function()
	doStatus = 1
	SetTimeout(1000,function()
		TriggerCreateCharacter()
	end)
end)

AddEventHandler("character:normalSpawn",function(firstspawn)
    if firstspawn then
		TriggerCamController(-1)
        Wait(7000)
		EndFade()

		if DoesCamExist(cam) then
			RenderScriptCams(false,true,250,1,0)
			DestroyCam(cam,false)
			cam = nil
		end
		
		-- doStatus = 2
		-- TriggerCamController(-2)
	else
		TriggerEvent("vrp:ToogleLoginMenu")
	end
end) 

function TriggerCreateCharacter()
	TriggerEvent('flaviin:toggleHud', false)
	TriggerEvent('notify:toogle', false)
	TriggerEvent('chat:toogle', false)
	TriggerEvent('shortcuts:terms', false)
	TriggerCamController(-1)
	isInCharacterMode = true
	StartFade()
	continuousFadeOutNetwork = true
	TriggerCamController(-2)
	changeGender("mp_m_freemode_01")
	refreshDefaultCharacter()
	TaskUpdateSkinOptions()
	TaskUpdateFaceOptions()
	TaskUpdateHeadOptions()

	SetEntityCoordsNoOffset(PlayerPedId(),402.55,-996.37,-99.01,true,true,true)
	SetEntityHeading(PlayerPedId(),f(180))
	TriggerCamController(doStatus)
	SetEntityVisible(PlayerPedId(), false)

	Citizen.Wait(5000)
	EndFade()
	
	SetNuiFocus(isInCharacterMode,isInCharacterMode)
	SendNUIMessage({ whitelist = true, id = (vSERVER.getUserId() or 0) })

	SetEntityCoordsNoOffset(PlayerPedId(),402.55,-996.37,-99.01,true,true,true)
	SetEntityHeading(PlayerPedId(),f(180))
	TriggerEvent('flaviin:toggleHud', false)
	CreateThread(function() 
		local executionCount = 0
		while executionCount < 7 do
			if #(GetEntityCoords(PlayerPedId()) - vector3(402.55,-996.37,-99.01)) > 9.0 then
				SetEntityCoordsNoOffset(PlayerPedId(),402.55,-996.37,-99.01,true,true,true)
				SetEntityHeading(PlayerPedId(),f(180))
			end
			executionCount = executionCount + 1
			Wait(1000)
		end
	end)
end

RegisterNUICallback('finishWhitelist', function(data, cb)
	refreshDefaultCharacter()
	TaskUpdateSkinOptions()
	TaskUpdateFaceOptions()
	TaskUpdateHeadOptions()
	SetEntityVisible(PlayerPedId(), true)
	SetNuiFocus(isInCharacterMode,isInCharacterMode)
	SendNUIMessage({ whitelist = false, CharacterMode = isInCharacterMode, CharacterMode2 = not isInCharacterMode, CharacterMode3 = not isInCharacterMode })

	vSERVER._finishWhitelist(data)
end)

RegisterNuiCallback('resetChar', function(data, cb)
	SetPedDefaultComponentVariation(PlayerPedId())
	ClearAllPedProps(PlayerPedId())

	print('Resetando Char')
	changeGender('mp_m_freemode_01')
	Wait(1000)
	SetEntityVisible(PlayerPedId(), true)
end)

function refreshDefaultCharacter()
	SetPedDefaultComponentVariation(PlayerPedId())
	ClearAllPedProps(PlayerPedId())
	if startClothes[GetEntityModel(PlayerPedId())] then 
		TriggerEvent("Character:UpdateClothes",startClothes[GetEntityModel(PlayerPedId())])
	end
end

function changeGender(model)
	local mhash = GetHashKey(model)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mhash) then
		SetPlayerModel(PlayerId(),mhash)
		-- SetPedCanRagdoll(PlayerPedId(), false)
		SetPedMaxHealth(PlayerPedId(),300)
		SetEntityHealth(PlayerPedId(),300)
		SetModelAsNoLongerNeeded(mhash)
	end

	SetEntityVisible(PlayerPedId(), true)
end

RegisterNUICallback('notify', function(data, cb)
	TriggerEvent('Notify', data.type, data.message, 5)
end)

RegisterNUICallback('changeGender', function(data,cb) 
	if tonumber(data.sex) == 1 then
		changeGender("mp_m_freemode_01")
	else
		changeGender("mp_f_freemode_01")
	end

	actual_gender = tonumber(data.sex) == 1 and 'mp_m_freemode_01' or 'mp_f_freemode_01'
end)

RegisterNUICallback('verify', function(data, cb)
	if vSERVER.checkWhitelist() then
		ExecuteCommand("BIOWNDWllIIiiLLljI WL_VERIFICAR")
		return cb({ whitelisted = true })
	end
	return cb({ whitelisted = false })
end)

RegisterNUICallback('cDone',function(data,cb)
	SetNuiFocus(isInCharacterMode, isInCharacterMode)
	SendNUIMessage({ CharacterMode = not isInCharacterMode, CharacterMode2 = isInCharacterMode, CharacterMode3 = not isInCharacterMode })
end)

RegisterNUICallback('BackPart1', function(data,cb)
	SetNuiFocus(isInCharacterMode, isInCharacterMode)
	SendNUIMessage({ CharacterMode = isInCharacterMode, CharacterMode2 = not isInCharacterMode, CharacterMode3 = not isInCharacterMode })
end)

RegisterNUICallback('cDonePart2', function(data,cb)
	SetNuiFocus(isInCharacterMode, isInCharacterMode)
	SendNUIMessage({ CharacterMode = not isInCharacterMode, CharacterMode2 = not isInCharacterMode, CharacterMode3 = isInCharacterMode })
end)

RegisterNUICallback('BackPart2', function(data,cb)
	SetNuiFocus(isInCharacterMode, isInCharacterMode)
	SendNUIMessage({ CharacterMode = not isInCharacterMode, CharacterMode2 = isInCharacterMode, CharacterMode3 = not isInCharacterMode })
end)

RegisterNUICallback('cDoneSave',function(data,cb)
	StartFade()
	isInCharacterMode = false
	SetNuiFocus(isInCharacterMode,isInCharacterMode)
	SendNUIMessage({ CharacterMode = isInCharacterMode, CharacterMode2 = isInCharacterMode, CharacterMode3 = isInCharacterMode })


	if startClothes[GetEntityModel(PlayerPedId())] then 
		TriggerEvent("Character:UpdateClothes",startClothes[GetEntityModel(PlayerPedId())])
	end

--[[	if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
		--[ MASCULINO ]--
		SetPedComponentVariation(PlayerPedId(),1,0,0,2) --MASCARA
        SetPedComponentVariation(PlayerPedId(),3,13,0,2) --MAOS
        SetPedComponentVariation(PlayerPedId(),4,207,0,1) --CALCA
        SetPedComponentVariation(PlayerPedId(),6,8,3,1) --SAPATOS
        SetPedComponentVariation(PlayerPedId(),7,0,0,2) --ACESSORIOS
        SetPedComponentVariation(PlayerPedId(),8,15,0,2) --BLUSA
        SetPedComponentVariation(PlayerPedId(),9,0,0,1) --COLETE
        SetPedComponentVariation(PlayerPedId(),11,560,0,1) --JAQUETA
        SetPedPropIndex(PlayerPedId(),6,-1,0)
        SetPedPropIndex(PlayerPedId(),0,-1,0)
	else
		--[ FEMININO ]--
		SetPedComponentVariation(PlayerPedId(),1,0,0,2) --MASCARA
		SetPedComponentVariation(PlayerPedId(),3,6,0,1) --MAOS 
		SetPedComponentVariation(PlayerPedId(),4,223,0,1) --CALCA
		SetPedComponentVariation(PlayerPedId(),6,81,5,1) --SAPATOS 
		SetPedComponentVariation(PlayerPedId(),7,-1,0,0) --ACESSORIOS
		SetPedComponentVariation(PlayerPedId(),8,15,0,1) --BLUSA
		SetPedComponentVariation(PlayerPedId(),9,0,0,2) --COLETE
		SetPedComponentVariation(PlayerPedId(),11,651,0,1) --JAQUETA
		SetPedPropIndex(PlayerPedId(),0,-1,0,2)
		SetPedPropIndex(PlayerPedId(),6,-1,0,2)
	end]]
	
	SetEntityCoordsNoOffset(PlayerPedId(),-1713.54,-887.1,8.0,true,true,true)
	SetEntityHeading(PlayerPedId(),f(225.34))

	continuousFadeOutNetwork = false

	TriggerServerEvent("character:finishedCharacter",currentCharacterMode, vRP.getCustomization())
	loadCutSine()
end)

RegisterNUICallback('cChangeHeading',function(data,cb)
	SetEntityHeading(PlayerPedId(),f(data.camRotation))
	cb('ok')
end)

RegisterNUICallback('UpdateSkinOptions',function(data,cb)
	currentCharacterMode.fathersID = data.fathersID
	currentCharacterMode.mothersID = data.mothersID
	currentCharacterMode.skinColor = data.skinColor
	currentCharacterMode.shapeMix = data.shapeMix
	idNome = data.idNome
	idSobrenome = data.idSobrenome
	idIdade = data.idIdade
	TaskUpdateSkinOptions()
	cb('ok')
end)

function TaskUpdateSkinOptions()
	local data = currentCharacterMode
	SetPedHeadBlendData(PlayerPedId(),data.fathersID,data.mothersID,0,data.skinColor,0,0,f(data.shapeMix),0,0,false)
end

RegisterNUICallback('UpdateFaceOptions',function(data,cb)
	currentCharacterMode.eyesColor = data.eyesColor
	currentCharacterMode.eyebrowsHeight = data.eyebrowsHeight
	currentCharacterMode.eyebrowsWidth = data.eyebrowsWidth
	currentCharacterMode.noseWidth = data.noseWidth
	currentCharacterMode.noseHeight = data.noseHeight
	currentCharacterMode.noseLength = data.noseLength
	currentCharacterMode.noseBridge = data.noseBridge
	currentCharacterMode.noseTip = data.noseTip
	currentCharacterMode.noseShift = data.noseShift
	currentCharacterMode.cheekboneHeight = data.cheekboneHeight
	currentCharacterMode.cheekboneWidth = data.cheekboneWidth
	currentCharacterMode.cheeksWidth = data.cheeksWidth
	currentCharacterMode.lips = data.lips
	currentCharacterMode.jawWidth = data.jawWidth
	currentCharacterMode.jawHeight = data.jawHeight
	currentCharacterMode.chinLength = data.chinLength
	currentCharacterMode.chinPosition = data.chinPosition
	currentCharacterMode.chinWidth = data.chinWidth
	currentCharacterMode.chinShape = data.chinShape
	currentCharacterMode.neckWidth = data.neckWidth
	TaskUpdateFaceOptions()
	cb('ok')
end)

function TaskUpdateFaceOptions()
	local ped = PlayerPedId()
	local data = currentCharacterMode

	-- Olhos
	SetPedEyeColor(ped,data.eyesColor)
	-- Sobrancelha
	SetPedFaceFeature(ped,6,data.eyebrowsHeight)
	SetPedFaceFeature(ped,7,data.eyebrowsWidth)
	-- Nariz
	SetPedFaceFeature(ped,0,data.noseWidth)
	SetPedFaceFeature(ped,1,data.noseHeight)
	SetPedFaceFeature(ped,2,data.noseLength)
	SetPedFaceFeature(ped,3,data.noseBridge)
	SetPedFaceFeature(ped,4,data.noseTip)
	SetPedFaceFeature(ped,5,data.noseShift)
	-- Bochechas
	SetPedFaceFeature(ped,8,data.cheekboneHeight)
	SetPedFaceFeature(ped,9,data.cheekboneWidth)
	SetPedFaceFeature(ped,10,data.cheeksWidth)
	-- Boca/Mandibula
	SetPedFaceFeature(ped,12,data.lips)
	SetPedFaceFeature(ped,13,data.jawWidth)
	SetPedFaceFeature(ped,14,data.jawHeight)
	-- Queixo
	SetPedFaceFeature(ped,15,data.chinLength)
	SetPedFaceFeature(ped,16,data.chinPosition)
	SetPedFaceFeature(ped,17,data.chinWidth)
	SetPedFaceFeature(ped,18,data.chinShape)
	-- Pescoço
	SetPedFaceFeature(ped,19,data.neckWidth)
end

RegisterNUICallback('UpdateHeadOptions',function(data,cb)
	currentCharacterMode.hairModel = data.hairModel
	currentCharacterMode.firstHairColor = data.firstHairColor
	currentCharacterMode.secondHairColor = data.secondHairColor
	currentCharacterMode.eyebrowsModel = data.eyebrowsModel
	currentCharacterMode.eyebrowsColor = data.eyebrowsColor
	currentCharacterMode.beardModel = data.beardModel
	currentCharacterMode.beardColor = data.beardColor
	currentCharacterMode.chestModel = data.chestModel
	currentCharacterMode.chestColor = data.chestColor
	currentCharacterMode.blushModel = data.blushModel
	currentCharacterMode.blushColor = data.blushColor
	currentCharacterMode.lipstickModel = data.lipstickModel
	currentCharacterMode.lipstickColor = data.lipstickColor
	currentCharacterMode.blemishesModel = data.blemishesModel
	currentCharacterMode.ageingModel = data.ageingModel
	currentCharacterMode.complexionModel = data.complexionModel
	currentCharacterMode.sundamageModel = data.sundamageModel
	currentCharacterMode.frecklesModel = data.frecklesModel
	currentCharacterMode.makeupModel = data.makeupModel
	TaskUpdateHeadOptions()
	cb('ok')
end)

function TaskUpdateHeadOptions()
	local ped = PlayerPedId()
	local data = currentCharacterMode

	-- Cabelo
	SetPedComponentVariation(ped,2,data.hairModel,0,0)
	SetPedHairColor(ped,data.firstHairColor,data.secondHairColor)
	-- Sobracelha
	SetPedHeadOverlay(ped,2,data.eyebrowsModel,0.99)
	SetPedHeadOverlayColor(ped,2,1,data.eyebrowsColor,data.eyebrowsColor)
	-- Barba
	SetPedHeadOverlay(ped,1,data.beardModel,0.99)
	SetPedHeadOverlayColor(ped,1,1,data.beardColor,data.beardColor)
	-- Pelo Corporal
	SetPedHeadOverlay(ped,10,data.chestModel,0.99)
	SetPedHeadOverlayColor(ped,10,1,data.chestColor,data.chestColor)
	-- Blush
	SetPedHeadOverlay(ped,5,data.blushModel,0.99)
	SetPedHeadOverlayColor(ped,5,2,data.blushColor,data.blushColor)
	-- Battom
	SetPedHeadOverlay(ped,8,data.lipstickModel,0.99)
	SetPedHeadOverlayColor(ped,8,2,data.lipstickColor,data.lipstickColor)
	-- Manchas
	SetPedHeadOverlay(ped,0,data.blemishesModel,0.99)
	SetPedHeadOverlayColor(ped,0,0,0,0)
	-- Envelhecimento
	SetPedHeadOverlay(ped,3,data.ageingModel,0.99)
	SetPedHeadOverlayColor(ped,3,0,0,0)
	-- Aspecto
	SetPedHeadOverlay(ped,6,data.complexionModel,0.99)
	SetPedHeadOverlayColor(ped,6,0,0,0)
	-- Pele
	SetPedHeadOverlay(ped,7,data.sundamageModel,0.99)
	SetPedHeadOverlayColor(ped,7,0,0,0)
	-- Sardas
	SetPedHeadOverlay(ped,9,data.frecklesModel,0.99)
	SetPedHeadOverlayColor(ped,9,0,0,0)
	-- Maquiagem
	SetPedHeadOverlay(ped,4,data.makeupModel,0.99)
	SetPedHeadOverlayColor(ped,4,0,0,0)
end

function loadCutSine()
	DoScreenFadeOut(1000)
	Wait(1500)
	RequestCollisionAtCoord(PlayerPedId(),-1170.57, -1644.02, 4.38)
	SetEntityCoords(PlayerPedId(), -1170.57, -1644.02, 4.38, false, false, false, true)
	DoScreenFadeOut(1000)

	Wait(4000)
	TriggerCamController(-1)
	doStatus = 2

	if DoesCamExist(cam) then
		RenderScriptCams(false,true,250,1,0)
		DestroyCam(cam,false)
		cam = nil
	end
	
	Wait(2000)
	RequestCollisionAtCoord(PlayerPedId(),-2245.09,262.57,174.61)
	SetEntityCoords(PlayerPedId(), -2245.09,262.57,174.61 + 1.0, false, false, false, true)

	Wait(5000)
	while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
		SetEntityCoords(PlayerPedId(), -2245.09,262.57,174.61 + 1.0, false, false, false, true)
		Citizen.Wait(0)
	end
	-- RequestCutscene('mp_intro_concat',8)

	-- while not HasCutsceneLoaded() do
	-- 	Citizen.Wait(10)
	-- end

	-- PrefetchSrl('GTAO_INTRO_MALE')
	-- PrefetchSrl('GTAO_INTRO_FEMALE')
	-- while not IsSrlLoaded() do
	-- 	Citizen.Wait(10)
	-- end

	-- BeginSrl()
	-- SetCutsceneEntityStreamingFlags('MP_Female_Character',0,1)
	-- SetCutsceneEntityStreamingFlags('MP_Male_Character',0,0)
	-- RegisterEntityForCutscene(nil,'MP_Male_Character',3, 0, 64)
	-- RegisterEntityForCutscene(PlayerPedId(),'MP_Female_Character',0,0,64)
	-- for i = 7,1,-1 do 
	-- 	SetCutsceneEntityStreamingFlags("MP_Plane_Passenger_"..i, 0, 1)
	-- 	RegisterEntityForCutscene(nil, 'MP_Plane_Passenger_'..i, 3, GetHashKey('mp_f_freemode_01'), 0)
	-- 	RegisterEntityForCutscene(nil, 'MP_Plane_Passenger_'..i, 3, GetHashKey('mp_m_freemode_01'), 0)
	-- end


	DoScreenFadeOut(1000)

	StopCutsceneImmediately()
	EndSrl()
	EndFade()
	

	Wait(2000)
	DoScreenFadeIn(1000)

	TriggerEvent('flaviin:toggleHud', true)
	TriggerEvent('notify:toogle', true)
	TriggerEvent('chat:toogle', true)
	TriggerEvent('shortcuts:terms', true)
	DisplayRadar(true)
	-- if HasCutsceneLoaded() then
	-- 	SetTimeout(28*1000, function()
			
	-- 		Wait(2000)
	-- 		StopCutsceneImmediately()
		

	-- 		Wait(3000)
	-- 		ShutdownLoadingScreen()
	-- 		while IsScreenFadingIn() do
	-- 			Citizen.Wait(1)
	-- 		end

	-- 		Wait(2000)
	-- 		local qtd = math.random(1,100)
	-- 		if qtd > 50 then
	-- 			RequestCollisionAtCoord(PlayerPedId(), -270.0,-1903.83,27.75)
	-- 			SetEntityCoordsNoOffset(PlayerPedId(), -270.0,-1903.83,27.75, true, true, false)
	-- 		else
	-- 			RequestCollisionAtCoord(PlayerPedId(), -280.64,-1916.72,29.94)
	-- 			SetEntityCoordsNoOffset(PlayerPedId(), -280.64,-1916.72,29.94, true, true, false)
	-- 		end

	-- 		--[[if qtd >= 60 and qtd <= 100 then
	-- 			RequestCollisionAtCoord(PlayerPedId(), -1669.27,-976.74,7.41)
	-- 			SetEntityCoordsNoOffset(PlayerPedId(), -1669.27,-976.74,7.41, true, true, false)
	-- 		elseif qtd > 40 and qtd < 60 then
	-- 			RequestCollisionAtCoord(PlayerPedId(), -1666.6,-970.72,7.55)
	-- 			SetEntityCoordsNoOffset(PlayerPedId(), -1666.6,-970.72,7.55, true, true, false)
	-- 		else
	-- 			RequestCollisionAtCoord(PlayerPedId(), -1654.02,-1001.36,13.01)
	-- 			SetEntityCoordsNoOffset(PlayerPedId(), -1654.02,-1001.36,13.01, true, true, false)
	-- 		end--]]
	-- 		StopCutsceneImmediately()
	-- 		EndSrl()
	-- 		EndFade()
			

	-- 		Wait(2000)
	-- 		DoScreenFadeIn(1000)
	-- 	end)
		
	-- 	SetTimeout(1000, function()
	-- 		DoScreenFadeIn(1000)
	-- 	end)
		
	-- 	StartCutscene()
	-- 	Citizen.CreateThread(function()
	-- 		while IsCutsceneActive() do
	-- 		  SetPlayerControl(PlayerId(), true, false)
	-- 		  Wait(1)
	-- 		end
	-- 	end)
	-- 	TriggerEvent('flaviin:toggleHud', true)
	-- 	TriggerEvent('notify:toogle', true)
	-- 	TriggerEvent('chat:toogle', true)
	-- 	TriggerEvent('shortcuts:terms', true)
	-- 	DisplayRadar(true)
	-- end
end

RegisterNetEvent("Character:UpdateClothes",function(custom)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if custom[1] == -1 then
			SetPedComponentVariation(ped,1,0,0,2)
		else
			SetPedComponentVariation(ped,1,custom[1],custom[2],2)
		end

		if custom[3] == -1 then
			SetPedComponentVariation(ped,5,0,0,2)
		else
			SetPedComponentVariation(ped,5,custom[3],custom[4],2)
		end

		if custom[5] == -1 then
			SetPedComponentVariation(ped,7,0,0,2)
		else
			SetPedComponentVariation(ped,7,custom[5],custom[6],2)
		end

		if custom[7] == -1 then
			SetPedComponentVariation(ped,3,15,0,2)
		else
			SetPedComponentVariation(ped,3,custom[7],custom[8],2)
		end

		if custom[9] == -1 then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				SetPedComponentVariation(ped,4,18,0,2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(ped,4,15,0,2)
			end
		else
			SetPedComponentVariation(ped,4,custom[9],custom[10],2)
		end

		if custom[11] == -1 then
			SetPedComponentVariation(ped,8,15,0,2)
		else
			SetPedComponentVariation(ped,8,custom[11],custom[12],2)
		end

		if custom[13] == -1 then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				SetPedComponentVariation(ped,6,34,0,2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(ped,6,35,0,2)
			end
		else
			SetPedComponentVariation(ped,6,custom[13],custom[14],2)
		end

		if custom[15] == -1 then
			SetPedComponentVariation(ped,11,15,0,2)
		else
			SetPedComponentVariation(ped,11,custom[15],custom[16],2)
		end

		if custom[17] == -1 then
			SetPedComponentVariation(ped,9,0,0,2)
		else
			SetPedComponentVariation(ped,9,custom[17],custom[18],2)
		end

		if custom[19] == -1 then
			SetPedComponentVariation(ped,10,0,0,2)
		else
			SetPedComponentVariation(ped,10,custom[19],custom[20],2)
		end

		if custom[21] == -1 then
			ClearPedProp(ped,0)
		else
			SetPedPropIndex(ped,0,custom[21],custom[22],2)
		end

		if custom[23] == -1 then
			ClearPedProp(ped,1)
		else
			SetPedPropIndex(ped,1,custom[23],custom[24],2)
		end

		if custom[25] == -1 then
			ClearPedProp(ped,2)
		else
			SetPedPropIndex(ped,2,custom[25],custom[26],2)
		end

		if custom[27] == -1 then
			ClearPedProp(ped,6)
		else
			SetPedPropIndex(ped,6,custom[27],custom[28],2)
		end

		if custom[29] == -1 then
			ClearPedProp(ped,7)
		else
			SetPedPropIndex(ped,7,custom[29],custom[30],2)
		end
	end
end)

-- local UI_LOADED = false
-- local TRAP = 0
-- RegisterNUICallback("loadUi", function(_,cb)
--     TRAP = TRAP + 1

--     if TRAP >= 2 then
--         return
--     end

-- 	if UI_LOADED then 
-- 		return
-- 	end
-- 	UI_LOADED = true

-- 	cb('ok')
-- end)

-- AddEventHandler('onClientResourceStart', function(resourceName)
-- 	if (GetCurrentResourceName() ~= resourceName) then
-- 		return
-- 	end
	
-- 	DisplayRadar(false)
-- 	while not UI_LOADED do Wait(50) end 

--     ShutdownLoadingScreen()
-- end)