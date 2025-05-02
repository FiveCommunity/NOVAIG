
local loaded = false
local categoryParameters = {
    {id = 2, name = 'Cabelo', category = 'Cabelo', value = 0, min = 0, max = GetNumberOfPedDrawableVariations(PlayerPedId(), 2) - 1, isIndex = 'hair_model'},
    {name = 'Cor Primaria', category = 'Cabelo', value = 0, min = 0, max = GetNumHairColors() - 1, isIndex = 'hair_primary'},
    {name = 'Cor Secundaria', category = 'Cabelo', value = 0, min = 0, max = GetNumHairColors() - 1, isIndex = 'hair_secondary'},

    {id = 1, name = 'Barba', category = 'Barba', value = 0, min = 0, max = GetNumHeadOverlayValues(1) - 1, isIndex = 'beard_model'},
    {name = 'Cor da Barba', category = 'Barba', value = 0, min = 0, max = GetNumHairColors() - 1, isIndex = 'beard_color'},
    {name = 'Opacidade Barba', category = 'Barba', value = 10, min = 0, max = 10, isIndex = 'beard_intensity'},

    {id = 2, name = 'Sobrancelhas', category = 'Rosto', value = 0, min = 0, max = GetNumHeadOverlayValues(2) - 1, isIndex = 'eyebrows_model'},
    {name = 'Cor da Sobrancelha', category = 'Rosto', value = 0, min = 0, max = GetNumHairColors() - 1, isIndex = 'eyebrows_color'},
    {name = 'Opacidade Sobrancelha', category = 'Rosto', value = 10, min = 0, max = 10, isIndex = 'eyebrows_intensity'}, 

    {id = 4, name = 'Maquiagem', category = 'Maquiagem', value = 0, min = 0, max = GetNumHeadOverlayValues(4) - 1, isIndex = 'makeup_model'},
    {name = 'Cor da Maquiagem', category = 'Maquiagem', value = 0, min = 0, max = GetNumMakeupColors() - 1, isIndex = 'makeup_color'}, 
    {name = 'Opacidade Maquiagem', category = 'Maquiagem', value = 10, min = 0, max = 10, isIndex = 'makeup_intensity'},

    {id = 8, name = 'Batom', category = 'Rosto', value = 0, min = 0, max = GetNumHeadOverlayValues(8) - 1, isIndex = 'lipstick_model'},
    {name = 'Cor do Batom', category = 'Rosto', value = 0, min = 0, max = GetNumMakeupColors() - 1, isIndex = 'lipstick_color'}, 
    {name = 'Opacidade Batom', category = 'Rosto', value = 10, min = 0, max = 10, isIndex = 'lipstick_intensity'},

    {id = 5, name = 'Blush', category = 'Rosto', value = 0, min = 0, max = GetNumHeadOverlayValues(5) - 1, isIndex = 'blush_model'},
    {name = 'Cor do Blush', category = 'Rosto', value = 0, max = GetNumMakeupColors() - 1, isIndex = 'blush_color'},
    {name = 'Opacidade Blush', category = 'Rosto', value = 10, min = 0, max = 10, isIndex = 'blush_intensity'},

    {id = 10, name = 'Pelo Corporal', category = 'Barba', value = 0, min = 0, max = GetNumHeadOverlayValues(10) - 1, isIndex = 'bodyhair_model'},
    {name = 'Cor do Pelo Corporal', category = 'Barba', value = 0, min = 0, max = GetNumHairColors() - 1, isIndex = 'bodyhair_color'}, 
}

function updateValueInGlobalTable(index, barber)
    local barberUpdate = categoryParameters[index]

    barberUpdate['value'] = barber['value']

    if barberUpdate['value'] > barberUpdate['max'] then
        barberUpdate['value'] = barberUpdate['max']
    end

    return categoryParameters
end

-- RegisterCommand("barbershop", function()
-- 	if GetEntityHealth(PlayerPedId()) <= 101 then return end
--     if serverFunctions.checkPermission() then
--         clientFunctions.openNuiShop()
--     end
-- end)

function changeBarber(barber)
    local ped = PlayerPedId()

    updateNuiLimit(barber['index'], barber)

    local indexExecution = {
        -- Cabelo
        ['hair_model'] = function()
            SetPedComponentVariation(ped, 2, categoryParameters[1]['value'], 0, 0)
            if custom['hairModel'] then
                custom['hairModel'] = categoryParameters[1]['value']
            end
        end,
    
        ['hair_primary'] = function()
            SetPedHairColor(ped, categoryParameters[2]['value'], categoryParameters[3]['value'])
            if custom['firstHairColor'] then
                custom['firstHairColor'] = categoryParameters[2]['value']
            end
        end,
    
        ['hair_secondary'] = function()
            SetPedHairColor(ped, categoryParameters[2]['value'], categoryParameters[3]['value'])
            if custom['secondHairColor'] then
                custom['secondHairColor'] = categoryParameters[3]['value']
            end
        end,
    
        -- Barba
        ['beard_model'] = function()
            SetPedHeadOverlay(ped, 1, categoryParameters[4]['value'], categoryParameters[6]['value'] / 10) -- Aplicando modelo e intensidade de barba
            if custom['beardModel'] then
                custom['beardModel'] = categoryParameters[4]['value']
            end
        end,
    
        ['beard_color'] = function()
            SetPedHeadOverlayColor(ped, 1, 1, categoryParameters[5]['value'], categoryParameters[5]['value']) -- Aplicando cor da barba
            if custom['beardColor'] then
                custom['beardColor'] = categoryParameters[5]['value']
            end
        end,
    
        ['beard_intensity'] = function()
            SetPedHeadOverlay(ped, 1, categoryParameters[4]['value'], categoryParameters[6]['value'] / 10)
            if custom['beardIntensity'] then
                custom['beardIntensity'] = categoryParameters[6]['value'] / 10
            end
        end,
    
        -- Sobrancelhas
        ['eyebrows_model'] = function()
            SetPedHeadOverlay(ped, 2, categoryParameters[7]['value'], categoryParameters[9]['value'] / 10) -- Aplicando modelo e intensidade das sobrancelhas
            if custom['eyebrowsModel'] then
                custom['eyebrowsModel'] = categoryParameters[7]['value']
            end
        end,
    
        ['eyebrows_color'] = function()
            SetPedHeadOverlayColor(ped, 2, 1, categoryParameters[8]['value'], categoryParameters[8]['value']) -- Aplicando cor das sobrancelhas
            if custom['eyebrowsColor'] then
                custom['eyebrowsColor'] = categoryParameters[8]['value']
            end
        end,
    
        ['eyebrows_intensity'] = function()
            SetPedHeadOverlay(ped, 2, categoryParameters[7]['value'], categoryParameters[9]['value'] / 10)
            if custom['eyebrowsIntensity'] then
                custom['eyebrowsIntensity'] = categoryParameters[9]['value'] / 10
            end
        end,
    
        -- Maquiagem
        ['makeup_model'] = function()
            local model = categoryParameters[10]['value']
            if model == 0 then
                model = -1
            end
            SetPedHeadOverlay(ped, 4, model, categoryParameters[12]['value'] / 10) -- Aplicando modelo e intensidade de maquiagem
            if custom['makeupModel'] then
                custom['makeupModel'] = model
            end
        end,
    
        ['makeup_color'] = function()
            SetPedHeadOverlayColor(ped, 4, 0, categoryParameters[11]['value'], categoryParameters[11]['value'])
            if custom['makeupColor'] then
                custom['makeupColor'] = categoryParameters[11]['value']
            end
        end,
    
        ['makeup_intensity'] = function()
            SetPedHeadOverlay(ped, 4, categoryParameters[10]['value'], categoryParameters[12]['value'] / 10)
            if custom['makeupIntensity'] then
                custom['makeupIntensity'] = categoryParameters[12]['value'] / 10
            end
        end,
    
        -- Batom
        ['lipstick_model'] = function()
            local model = categoryParameters[13]['value']
            if model == 0 then
                model = -1 -- Remover completamente o batom
            end
            SetPedHeadOverlay(ped, 8, model, categoryParameters[15]['value'] / 10) -- Aplicando modelo e intensidade de batom
            if custom['lipstickModel'] then
                custom['lipstickModel'] = model
            end
        end,
    
        ['lipstick_color'] = function()
            SetPedHeadOverlayColor(ped, 8, 2, categoryParameters[14]['value'], categoryParameters[14]['value']) -- Aplicando cor do batom
            if custom['lipstickColor'] then
                custom['lipstickColor'] = categoryParameters[14]['value']
            end
        end,
    
        ['lipstick_intensity'] = function()
            SetPedHeadOverlay(ped, 8, categoryParameters[13]['value'], categoryParameters[15]['value'] / 10)
            if custom['lipstickIntensity'] then
                custom['lipstickIntensity'] = categoryParameters[15]['value'] / 10
            end
        end,
    
        -- Blush
        ['blush_model'] = function()
            local model = categoryParameters[16]['value']
            if model == 0 then
                model = -1
            end
            SetPedHeadOverlay(ped, 5, model, categoryParameters[18]['value'] / 10) -- Aplicando modelo e intensidade de blush
            if custom['blushModel'] then
                custom['blushModel'] = model
            end
        end,
    
        ['blush_color'] = function()
            SetPedHeadOverlayColor(ped, 5, 2, categoryParameters[17]['value'], categoryParameters[17]['value']) -- Aplicando cor do blush
            if custom['blushColor'] then
                custom['blushColor'] = categoryParameters[17]['value']
            end
        end,
    
        ['blush_intensity'] = function()
            SetPedHeadOverlay(ped, 5, categoryParameters[16]['value'], categoryParameters[18]['value'] / 10)
            if custom['blushIntensity'] then
                custom['blushIntensity'] = categoryParameters[18]['value'] / 10
            end
        end,
    
        -- Pelo Corporal
        ['bodyhair_model'] = function()
            local model = categoryParameters[19]['value']
            if model == 0 then
                model = -1
            end
            SetPedHeadOverlay(ped, 10, model, 0.99)
            if custom['chestModel'] then
                custom['chestModel'] = model
            end
        end,
    
        ['bodyhair_color'] = function()
            SetPedHeadOverlayColor(ped, 10, 1, categoryParameters[20]['value'], categoryParameters[20]['value']) -- Aplicando cor do pelo corporal
            if custom['chestColor'] then
                custom['chestColor'] = categoryParameters[20]['value']
            end
        end,
    }
    
    if indexExecution[barber['isIndex']] then
        indexExecution[barber['isIndex']]()
    end
    
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SAVE UPDATES
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function clientFunctions.saveBarberShop()
    clientFunctions.closeNuiShop()
    serverFunctions.updateSkin(custom)
    TriggerEvent("Character:UpdateClothes",old_custom)
    setBarbershop(PlayerPedId(), custom)
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE ALL VARIATIONS IN TABLE
-----------------------------------------------------------------------------------------------------------------------------------------

function setBarbershop(ped, data)
	if not data then
		return
	end

	SetPedHeadBlendData(ped,data.fathersID,data.mothersID,0,data.skinColor,0,0,f(data.shapeMix),0,0,false)
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

-----------------------------------------------------------------------------------------------------------------------------------------
-- CAM FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------

function prepareCamera()
    local playerPed = PlayerPedId()
    local playerCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0,3.0,0)

    RenderScriptCams(false,false,0,1,0)

	DestroyCam(cam, false)

	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
		SetCamActive(cam,true)
		RenderScriptCams(true,false,0,true,true)
		SetCamCoord(cam, playerCoords["x"],playerCoords["y"],playerCoords["z"] + 0.55)
		SetCamRot(cam,0.0,0.0,GetEntityHeading(PlayerPedId()) + 180)
	end
end

function changeCamPosition(camPos)
    local playerPed = PlayerPedId()
    local camOffests = {
        ['hair'] = function()
            local playerCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0, 0.35 ,0.10)
            SetCamCoord(cam, playerCoords.x, playerCoords.y, playerCoords.z + 0.7)
        end,

        ['face'] = function()
            local playerCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0, 0.35 ,0.10)
            SetCamCoord(cam, playerCoords.x, playerCoords.y, playerCoords.z + 0.55)
        end,

        ['beard'] = function()
            local playerCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0, 0.30 ,0.10)
            SetCamCoord(cam, playerCoords.x, playerCoords.y, playerCoords.z + 0.49)
        end,
    }

    if camOffests[camPos] then
        camOffests[camPos]()
    end
end

local horizontalFloat = 0.0
local verticalFloat = 0.0

function moveCamPosition(camPos, floatPos)
    local camPositions = {
        ['VERTICAL'] = function()
            verticalFloat = floatPos
        end,

        ['HORIZONTAL'] = function()
            horizontalFloat = floatPos
        end,
    }

    if camPositions[camPos] then
        camPositions[camPos]()
    end

    local playerCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, (0.35 + horizontalFloat * 0.12) ,0.10)
    SetCamCoord(cam, playerCoords.x, playerCoords.y, (playerCoords.z + (verticalFloat == 0.0 and 0.55 or (verticalFloat * 0.7)))   )
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFORM IN FLOAT
-----------------------------------------------------------------------------------------------------------------------------------------

function f(n)
	n = n + 0.00000
	return n
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATION
-----------------------------------------------------------------------------------------------------------------------------------------

function userRotate(rotation)
	SetEntityHeading(PlayerPedId(), f(rotation))
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE TABLE CUSTOM...
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function clientFunctions.setCharacter(data)
	if data then 
		custom = data
        canStartThread = true
		canUpdate = true
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD SYNC PED
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		
		if canStartThread then
			while not IsPedModel(PlayerPedId(),"mp_m_freemode_01") and not IsPedModel(PlayerPedId(),"mp_f_freemode_01") do
				Citizen.Wait(10)
			end

			if custom and next(custom) then
				setBarbershop(PlayerPedId(), custom)
			end
		end
	end
end)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OPEN SHOP NUI
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function clientFunctions.openNuiShop()
    local ped = PlayerPedId()

    old_custom = vRP.getCustom()

    if loaded == false then
        loaded = true

        categoryParameters = {
            {id = 2, name = 'Cabelo', category = 'Cabelo', value = 0, min = 0, max = GetNumberOfPedDrawableVariations(PlayerPedId(), 2) - 1, isIndex = 'hair_model'},
            {name = 'Cor Primaria', category = 'Cabelo', value = 0, min = 0, max = GetNumHairColors() - 1, isIndex = 'hair_primary'},
            {name = 'Cor Secundaria', category = 'Cabelo', value = 0, min = 0, max = GetNumHairColors() - 1, isIndex = 'hair_secondary'},
        
            {id = 1, name = 'Barba', category = 'Barba', value = 0, min = -1, max = GetNumHeadOverlayValues(1) - 1, isIndex = 'beard_model'},
            {name = 'Cor da Barba', category = 'Barba', value = 0, min = 0, max = GetNumHairColors() - 1, isIndex = 'beard_color'},
            {name = 'Opacidade Barba', category = 'Barba', value = 10, min = 0, max = 10, isIndex = 'beard_intensity'},
        
            {id = 2, name = 'Sobrancelhas', category = 'Rosto', value = 0, min = 0, max = GetNumHeadOverlayValues(2) - 1, isIndex = 'eyebrows_model'},
            {name = 'Cor da Sobrancelha', category = 'Rosto', value = 0, min = 0, max = GetNumHairColors() - 1, isIndex = 'eyebrows_color'},
            {name = 'Opacidade Sobrancelha', category = 'Rosto', value = 10, min = 0, max = 10, isIndex = 'eyebrows_intensity'}, 
        
            {id = 4, name = 'Maquiagem', category = 'Maquiagem', value = 0, min = 0, max = GetNumHeadOverlayValues(4) - 1, isIndex = 'makeup_model'},
            {name = 'Cor da Maquiagem', category = 'Maquiagem', value = 0, min = 0, max = GetNumMakeupColors() - 1, isIndex = 'makeup_color'}, 
            {name = 'Opacidade Maquiagem', category = 'Maquiagem', value = 10, min = 0, max = 10, isIndex = 'makeup_intensity'},
        
            {id = 8, name = 'Batom', category = 'Rosto', value = 0, min = 0, max = GetNumHeadOverlayValues(8) - 1, isIndex = 'lipstick_model'},
            {name = 'Cor do Batom', category = 'Rosto', value = 0, min = 0, max = GetNumMakeupColors() - 1, isIndex = 'lipstick_color'}, 
            {name = 'Opacidade Batom', category = 'Rosto', value = 10, min = 0, max = 10, isIndex = 'lipstick_intensity'},
        
            {id = 5, name = 'Blush', category = 'Rosto', value = 0, min = 0, max = GetNumHeadOverlayValues(5) - 1, isIndex = 'blush_model'},
            {name = 'Cor do Blush', category = 'Rosto', value = 0, max = GetNumMakeupColors() - 1, isIndex = 'blush_color'},
            {name = 'Opacidade Blush', category = 'Rosto', value = 10, min = 0, max = 10, isIndex = 'blush_intensity'},
        
            {id = 10, name = 'Pelo Corporal', category = 'Barba', value = 0, min = 0, max = GetNumHeadOverlayValues(10) - 1, isIndex = 'bodyhair_model'},
            {name = 'Cor do Pelo Corporal', category = 'Barba', value = 0, min = 0, max = GetNumHairColors() - 1, isIndex = 'bodyhair_color'}, 
        }
    end

    SendNUIMessage({
        ['action'] = 'open',
        ['data'] = {
            ['customs'] = categoryParameters
        }
    })
    SetNuiFocus(true, true)

    SetEntityHeading(ped,332.21)
    vRP.playAnim(false,{{"mp_sleep","bind_pose_180"}},true)
    prepareCamera()
    
    TriggerEvent('flaviin:toggleHud', false)
    ClearAllPedProps(ped)

    currentMode = json.encode(custom)
    currentMode = json.decode(currentMode)

    local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,0.35,-0.10)
    SetCamCoord(cam,coords["x"],coords["y"] ,coords["z"] + 0.8)
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE SHOP NUI
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function clientFunctions.closeNuiShop(cancel)
    SetNuiFocus(false, false)
    SendNUIMessage({['action'] = 'close'})

    local ped = PlayerPedId()

    FreezeEntityPosition(ped,false)
    SetPlayerInvincible(ped,false)
    RenderScriptCams(false,false,0,1,0)
    DestroyCam(cam,false)
    TriggerEvent('flaviin:toggleHud', true)

    ClearPedTasks(ped)

    if cancel then
        custom = currentMode
        setBarbershop(ped, currentMode)
        TriggerEvent("Character:UpdateClothes",old_custom)
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE NUI LIMIT BARBERSHOP
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function updateNuiLimit(index, custom)
    SendNUIMessage({
        ['action'] = 'UPDATE_CUSTOM',
        ['data'] = updateValueInGlobalTable(index, custom)
    })
end