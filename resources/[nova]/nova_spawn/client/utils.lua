-----------------------------------------------------------------------------------------------------------------------------------------
-- START FADE
-----------------------------------------------------------------------------------------------------------------------------------------
function StartFade()
	DoScreenFadeOut(500)
	while IsScreenFadingOut() do
		Citizen.Wait(1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- END FADE
-----------------------------------------------------------------------------------------------------------------------------------------
function EndFade()
	SetEntityVisible(PlayerPedId(), true)
	DoScreenFadeIn(500)
	while IsScreenFadingIn() do
		Citizen.Wait(1)
	end

end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMATE CAMERA TO CHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function AnimateCameraToCharacter(targetX, targetY, targetZ, duration)
    local startTime = GetGameTimer()
    local startX, startY, startZ = table.unpack(GetCamCoord(state.camera))
    
    Citizen.CreateThread(function()
        while true do
            local elapsedTime = GetGameTimer() - startTime
            if elapsedTime > duration or not state.isOpen then
                break
            end
            local playerPed = PlayerPedId()
            local playerPos = GetEntityCoords(playerPed)
            if #(playerPos - vector3(-425.07, 1125.78, 325.86)) > 2.0 then
                StartPlayerTeleport(playerPed, -425.07, 1125.78, 325.86, 338.0, false, true, false)
                while IsPlayerTeleportActive(playerPed) do
                    Citizen.Wait(0)
                end
            end
            local progress = elapsedTime / duration
            local currentX = startX + (targetX - startX) * progress
            local currentY = startY + (targetY - startY) * progress
            local currentZ = startZ + (targetZ - startZ) * progress
            
            SetCamCoord(state.camera, currentX, currentY, currentZ)
            SetFocusPosAndVel(currentX, currentY, currentZ, 0, 0, 0)
            Citizen.Wait(0)
        end
        if not state.isOpen then
            print("Forçando retorno da animação da camera")
            return
        end
        SetFocusPosAndVel(targetX, targetY, targetZ, 0, 0, 0)
        -- Garante que a câmera termina exatamente no alvo
        SetCamCoord(state.camera, targetX, targetY, targetZ)
        PointCamAtEntity(state.camera, PlayerPedId(), 0, 0, 0, true)
    end)
end

local function setBucket(status)
    Remote._setBucket(status)
end

-- RegisterCommand("spawnopen", function()
--     OpenUi()
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN UI
-----------------------------------------------------------------------------------------------------------------------------------------
function OpenUi()
    LocalPlayer.state.isSpawnActived = true
    state.isOpen = true
    StartFade()
    CreateThread(function()
        while state.isOpen do
            if _G.Teleporting then
                break
            end
            local ped = PlayerPedId()
            if #(GetEntityCoords(ped) - vec3(-425.07, 1125.78, 325.86)) > 2.0 then
                print("Forçando teleport")
                SetEntityCoords(ped, -425.07, 1125.78, 325.86)
                SetEntityHeading(ped, 338.0)
            end
            Wait(1000)
        end
        print('Nui fechada!')
    end)
    SetEntityVisible(PlayerPedId(), true) -- Oculta o personagem
    setBucket(state.isOpen)
    TriggerEvent("shortcuts:hide")
    TriggerEvent("flaviin:toggleHud", false)

    local playerPed = PlayerPedId()
    local targetCoords = vector3(-425.07, 1125.78, 325.86)

    -- Carregar o local antes de teletransportar o jogador
    RequestCollisionAtCoord(targetCoords.x, targetCoords.y, targetCoords.z)
    -- NewLoadSceneStart(targetCoords.x, targetCoords.y, targetCoords.z, 0.0, 0.0, 0.0, 50.0, 0) -- Garante o carregamento da cena
    -- while not IsNewLoadSceneLoaded() do
    --     Citizen.Wait(100) -- Aguarda o carregamento da cena
    -- end
    SetEntityCoords(playerPed, targetCoords.x, targetCoords.y, targetCoords.z)
    SetEntityHeading(playerPed, 338.0)
    Wait(3400)
    Citizen.CreateThread(function()
        while true do
            local playerPed = PlayerPedId()
            local playerPos = GetEntityCoords(playerPed)
            if #(playerPos - targetCoords) < 1.0 and HasCollisionLoadedAroundEntity(playerPed) then
                EndFade()

                -- Jogador está na posição correta, inicia a câmera
                state.camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

                -- Inicializa a câmera em uma posição afastada
                SetCamCoord(state.camera, targetCoords.x + 5.0, targetCoords.y + 5.0, targetCoords.z + 5.0)
                PointCamAtEntity(state.camera, playerPed, 0, 0, 0, true)
                SetCamActive(state.camera, true)
                RenderScriptCams(true, false, 0, true, true)


                AnimateCameraToCharacter(targetCoords.x + 0.6, targetCoords.y + 2, targetCoords.z + 1, 2000)
                break
            else
                -- Jogador não está na posição correta, teletransporta novamente
                -- RequestCollisionAtCoord(targetCoords.x, targetCoords.y, targetCoords.z)
                SetEntityCoords(playerPed, targetCoords.x, targetCoords.y, targetCoords.z)
                SetEntityHeading(playerPed, 338.0)
            end
            Citizen.Wait(100)
        end
        SendNUIMessage({
            action = "open"
        })
        SetNuiFocus(true, true)
    end)

end

RegisterCommand("debugcamera", function()
    local camRot = GetCamRot(state.camera, 0) 
    print(string.format("Cam Rotation is x: %f, y: %f, z: %f", camRot.x, camRot.y, camRot.z))
    local camRot = GetCamCoord(state.camera) 
    print(string.format("Cam Coord is x: %f, y: %f, z: %f", camRot.x, camRot.y, camRot.z))

 end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE UI
-----------------------------------------------------------------------------------------------------------------------------------------
function CloseUi()
    ClearFocus()
    state.isOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })

    setBucket(false)
    -- Restaura a visibilidade do personagem e a câmera padrão
    SetEntityVisible(PlayerPedId(), true)
    SetCamActive(state.camera, false)
    RenderScriptCams(false, false, 0, true, true)
    LocalPlayer.state.isSpawnActived = false
end