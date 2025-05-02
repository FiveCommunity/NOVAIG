------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
player = {
    inZone = false,
    userOrg = nil
}

dominationPistol = {
    running = false
}

markers = {}

WeaponsWhitelisted = Config.weaponsWhitelistEnterZone

blip = 0

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function enterZone()
    player.inZone = true

    exports["nova_extras"]:toggleDominationGeral(true, 'Pistola')

    vTunnel.enterZone()
end

function leaveZone()
    player.inZone = false

    exports["nova_extras"]:toggleDominationGeral(false, 'Pistola')

    WeaponsWhitelisted = Config.weaponsWhitelistEnterZone

    vTunnel.leaveZone()
end

function RegisterTunnel.inDomination()
    return player.inZone
end

function RegisterTunnel.setUserOrg(org)
    player.userOrg = org
end

exports("inDomination",function()
    return player.inZone
end)

exports("insertWeaponWhitelist",function(weapon)
    WeaponsWhitelisted[GetHashKey(weapon)] = true
end)

RegisterNetEvent("dominacao_pistol:insertWeaponWhitelist", function(item)
    if player.inZone then
        WeaponsWhitelisted[GetHashKey(item)] = true
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MAIN THREADS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    Wait(1000)
    while true do
        local SLEEP_TIME = 1000

        local dist = #(GetEntityCoords(PlayerPedId()) - Config.coordsBlip)
        if dist <= 800 and GetEntityHealth(PlayerPedId()) >= 101 then
            SLEEP_TIME = 0
            
            local inZone = getPlyInZone()
            if inZone then
                if not player.inZone then
                    enterZone()
                end

                -- if not dominationPistol.running then
                --     if dist <= 10.0 then
                --         DrawText3Ds(Config.coordsBlip.x, Config.coordsBlip.y, Config.coordsBlip.z, "~r~[DOMINACAO GERAL] ~n~~w~Controlada: ~b~"..GlobalState.dominationPistolOwner.."~n~ ~w~Pressione ~b~[E]~w~ para dominar esta area ")
                --         DrawMarker(27,Config.coordsBlip[1],Config.coordsBlip[2],Config.coordsBlip[3]-0.95,0,0,0,0, 0,0,1.5,1.5,1.5, 255,0,0, 180,0,0,0,1)

                --         if IsControlJustPressed(0,38) and dist < 5.0 and GetEntityHealth(PlayerPedId()) > 101 then
                --             vTunnel._requestInit()
                --         end
                --     end
                -- end

                if player.inZone then
                    if GetEntityHealth(PlayerPedId()) < 101 then
                        leaveZone()
                        SendNUIMessage({action = "setVisible", data = false}) 
                    end

                    local _, currentWeapon = GetCurrentPedWeapon(PlayerPedId(), false)
                    if currentWeapon and currentWeapon ~= GetHashKey("WEAPON_UNARMED") then
                        if not WeaponsWhitelisted[currentWeapon] then
                            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
                        end
                    end

                end

            else
                if player.inZone then
                    leaveZone()
                    SendNUIMessage({action = "setVisible", data = false}) 
                end
            end
            drawPoly()
        else
            if player.inZone then
                leaveZone()
                SendNUIMessage({action = "setVisible", data = false})
            end
        end

        Wait(SLEEP_TIME)
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- STATEBAG
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler('dominationPistolOwner', 'global', function(_,_,value)
    Wait(1000)
    updateBlip()
end)

RegisterNetEvent('dom_pistol:updateMarkers', function(marker) 
    markers = marker
end)

local playerInMarker = false

local function DrawPosition(markerData, status, alpha)

    local function DrawTexture(textureStreamed, textureName, x, y, width, height, rotation, r, g, b, a, p11)
        if not HasStreamedTextureDictLoaded(textureStreamed) then
            RequestStreamedTextureDict(textureStreamed, false)
        else
            DrawSprite(textureStreamed, textureName, x, y, width, height, rotation, r, g, b, a, p11)
        end
    end

    local function DrawTextOnScreen(x, y, text, scale, r, g, b, a)
        SetTextFont(0)
        SetTextScale(scale, scale)
        SetTextColour(r, g, b, a)
        SetTextOutline()
        SetTextCentre(1)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(x, y)
    end

    alpha = alpha or 80

    local playerCoords = GetEntityCoords(PlayerPedId())

    local onScreen, screenX, screenY = GetScreenCoordFromWorldCoord(markerData.coords.pos.x, markerData.coords.pos.y, markerData.coords.pos.z)
    local distLocal = math.floor(#(playerCoords - markerData.coords.pos))

    if onScreen then
        DrawTextOnScreen(screenX, screenY - 0.025, status, 0.18, 255, 255, 255, alpha)
        DrawTextOnScreen(screenX, screenY - 0.010, markerData.coords.label, 0.25, 255, 255, 255, alpha)
        DrawTexture("mpmissmarkers256", "corona_shade", screenX, screenY, 0.020, 0.020, 0.0, 255, 255, 255, alpha, true)
        DrawTexture("basejumping", "arrow_pointer", screenX, screenY + 0.02, 0.025, 0.025, 180.0, 255, 0, 60, alpha, true)
        DrawTextOnScreen(screenX + 0.025, screenY - 0.0125, tostring(distLocal) .. " m", 0.2, 200, 200, 200, alpha)
    end
end

function ChangeStatusUserInZone(markerData, index, status)
    vTunnel._changeUsersInZone(markerData, index, status)
end


function GetStatusMarker(markerData)
    if markerData.contestando then
        return 'CONTESTANDO'
    end

    if markerData.dominando and not markerData.dominado then
        return 'ATACANDO'
    end

    if markerData.dominado then
        return 'DOMINADO'
    end

    return 'ATACAR'
end


RegisterNetEvent('dom_pistol:createMarker', function(marker)
    markers = marker

    CreateThread(function()

        local timeInsideMarker = 0
        local playerInZone = false
        local lastUpdate = GetGameTimer()

        while player.inZone do
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            if markers and next(markers) then
                for index, markerData in pairs(markers) do
                    local statusDUI = nil
                    local statusMarker = 'ATACAR'
                    local statusColors = statusMarker
    
                    local alphaDUI = 80
    
                    local colorsLib = {
                        ['ATACAR'] = { 41, 245, 0 },
                        ['ATACANDO'] = { 245, 0, 0 },
                        ['DOMINADO'] = { 54, 117, 206 },
                        ['CONTESTANDO'] = { 245, 118, 0 },
                    }
    
                    if #(playerCoords - vector3(markerData.coords.pos.x, markerData.coords.pos.y, markerData.coords.pos.z)) < 20 then
                        THREAD_OPTIMIZER = 0
    
                        statusMarker = GetStatusMarker(markerData)
    
                        statusColors = statusMarker
    
                        if statusMarker == 'DOMINADO' then
                            statusDUI = 'DOMINADO POR: ' .. string.upper(markerData.dominadoBy)
                        else
                            statusDUI = statusMarker
                        end
    
                        if #(playerCoords - vector3(markerData.coords.pos.x, markerData.coords.pos.y, markerData.coords.pos.z)) < 4 and GetEntityHealth(PlayerPedId()) > 101 then
                            if not playerInZone then
                                playerInZone = true
    
                                ChangeStatusUserInZone(markerData, index, true)
    
                                lastUpdate = GetGameTimer()
                                timeInsideMarker = 0
                            end
    
                            alphaDUI = 255
    
    
                            if statusMarker == 'ATACAR' or statusMarker == 'CONTESTANDO' or statusMarker == 'ATACANDO' then
                                if #markerData.orgsInZone == 1 then -- Se houver mais de uma org na zona, não ira contar
    
                                    statusColors = 'ATACANDO'
    
                                    if statusMarker == 'ATACAR' and not markerData.dominando then
                                        markerData.dominando = true
                                        vTunnel.updateMarkerDominando({
                                            index = index,
                                            status = true,
                                        })
                                    end
    
                                    local timeRemaining = math.max(Config.timeDominationZone - timeInsideMarker, 0)
                                    local secondsRemaining = math.floor(timeRemaining)
    
                                    local elapsed = (GetGameTimer() - lastUpdate) / 1000
                                    if elapsed >= 1 then
                                        timeInsideMarker = timeInsideMarker + 1
                                        lastUpdate = GetGameTimer()
                                    end
    
                                    statusDUI = string.format('CAPTURANDO: %d segundos', secondsRemaining)
    
                                    if timeInsideMarker >= Config.timeDominationZone then
                                        timeInsideMarker = 0
                                        markerData.dominado = true
                                        markerData.dominando = false
                                        vTunnel._updateMarker({
                                            marker = markerData,
                                            index = index,
                                        })
    
                                        statusMarker = 'DOMINADO'
                                        statusDUI = 'DOMINADO POR: ' .. string.upper(markerData.dominadoBy)
                                    end
                                else
                                    statusColors = 'CONTESTANDO'
                                    if markerData.dominando then
                                        markerData.dominando = false
                                        vTunnel.updateMarkerDominando({
                                            index = index,
                                            status = false,
                                        })
                                    end
                                end
                            elseif statusMarker == 'DOMINADO' then
                                local orgsInZoneCount = #markerData.orgsInZone
    
                                if orgsInZoneCount > 1 then
                                    -- CONTESTANDO
                                    statusDUI = 'CONTESTANDO'
                                    alphaDUI = 255
    
                                    if not markerData.contestando then
                                        markerData.contestando = true
                                        vTunnel.updateMarkerContestando({
                                            index = index,
                                            status = true
                                        })
                                    end
    
                                elseif orgsInZoneCount == 1 then
                                    -- Tem exatamente 1 org na área, precisamos checar qual é
                                    local orgInZone = player.userOrg
    
                                    -- Se for a mesma org que dominou, mantemos "DOMINADO"
                                    if orgInZone == markerData.dominadoBy then
                                        if markerData.contestando then
                                            markerData.contestando = false
                                            vTunnel.updateMarkerContestando({
                                                index = index,
                                                status = false
                                            })
                                        end
    
                                        statusDUI = 'DOMINADO POR: ' .. string.upper(markerData.dominadoBy)
    
                                        if not markerData.dominando then
                                            markerData.dominando = true
                                            vTunnel.updateMarkerDominando({
                                                index = index,
                                                status = true
                                            })
                                        end
    
                                    else
                                        -- É uma org nova/diferente. Precisamos permitir que ela faça o "ATACANDO".
                                        -- Então removemos dominado e contestando, e colocamos dominando = true
                                        markerData.dominado = false
    
                                        if markerData.contestando then
                                            markerData.contestando = false
                                            vTunnel.updateMarkerContestando({
                                                index = index,
                                                status = false
                                            })
                                        end
                            
                                        statusDUI = 'ATACANDO'
                                        alphaDUI = 255
                            
                                        if not markerData.dominando then
                                            markerData.dominando = true
                                            vTunnel.updateMarkerDominando({
                                                index = index,
                                                status = true
                                            })
                                        end
                                    end
                            
                                else
                                    -- orgsInZoneCount == 0
                                    -- Ninguém na área, então talvez só manter "DOMINADO"
                                    -- ou, dependendo da lógica que você quer, resetar tudo
                                    if markerData.contestando then
                                        markerData.contestando = false
                                        vTunnel.updateMarkerContestando({
                                            index = index,
                                            status = false
                                        })
                                    end
                            
                                    statusDUI = 'DOMINADO POR: ' .. string.upper(markerData.dominadoBy)
                                    -- Aqui você pode decidir se zera ou não, mas normalmente se não tem ninguém
                                    -- a dominação permanece da org antiga
                                end
                            end
                            
                        else
                            if playerInZone then
                                playerInZone = false
                                ChangeStatusUserInZone(markerData, index, false)
    
                                vTunnel.updateMarkerDominando({
                                    index = index,
                                    status = false,
                                })
    
                                statusColors = statusMarker
    
                                alphaDUI = 80
                                timeInsideMarker = 0
    
    
                            end
                        end
    
                        DrawMarker(
                            25,
                            markerData.coords.pos.x, markerData.coords.pos.y, markerData.coords.pos.z - 0.8,
                            0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                            8.5, 8.5, 1.0,
                            colorsLib[statusColors][1], colorsLib[statusColors][2], colorsLib[statusColors][3], 255,
                            false, true, 2, false, nil, nil, false
                        )
                    end
    
                    DrawPosition(markerData, statusDUI, alphaDUI)
                end
            end
            Wait(0)
        end
    end)
end)

-- RegisterNetEvent('dom_pistol:createMarker', function(marker)
--     markers = marker

--     Citizen.CreateThread(function()
--         local playerInMarker = false
--         local timeInsideMarker = 0
--         local lastUpdate = GetGameTimer()

--         print('Criando marcadores...')
--         while true do
--             local playerPed = PlayerPedId()
--             local playerCoords = GetEntityCoords(playerPed)

--             for index, markerData in pairs(markers) do

--                 local status = 'ATACAR'
--                 local alpha = 80



--                 if not markerData.dominado then
--                     if #(playerCoords - vector3(markerData.coords.pos.x, markerData.coords.pos.y, markerData.coords.pos.z)) < 20 and GetEntityHealth(PlayerPedId()) > 101 then

--                         DrawMarker(
--                             25,
--                             markerData.coords.pos.x, markerData.coords.pos.y, markerData.coords.pos.z - 0.8,
--                             0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
--                             8.5, 8.5, 1.0,
--                             255,0,0, 180,
--                             false, true, 2, false, nil, nil, false
--                         )
    
--                         if #(playerCoords - vector3(markerData.coords.pos.x, markerData.coords.pos.y, markerData.coords.pos.z)) < 4  then

--                             status = 'DEFENDER'
--                             if not playerInMarker then
--                                 playerInMarker = true
--                                 timeInsideMarker = 0
--                                 lastUpdate = GetGameTimer()
--                                 ChangeStatusUserInZone(markerData, index, true)
--                             end
    
--                             local timeRemaining = math.max(Config.timeDominationZone - timeInsideMarker, 0)
--                             local secondsRemaining = math.floor(timeRemaining)
    
--                             if playerInMarker then
--                                 local elapsed = (GetGameTimer() - lastUpdate) / 1000
--                                 if elapsed >= 1 then
--                                     timeInsideMarker = timeInsideMarker + 1
--                                     lastUpdate = GetGameTimer()
--                                 end
--                             end 
    
--                             alpha = 255
--                             status = string.format('CONTESTANDO: %d segundos', secondsRemaining)
    
--                             if timeInsideMarker >= Config.timeDominationZone then
--                                 timeInsideMarker = 0
--                                 markerData.dominado = true
                                
--                                 playerInMarker = false
--                                 vTunnel._updateMarker({
--                                     marker = markerData,
--                                     index = index,
--                                 })
--                             end
--                         else
--                             alpha = 80
--                             status = 'ATACAR'
--                         end
--                     else
--                         if playerInMarker then
--                             playerInMarker = false
--                             ChangeStatusUserInZone(markerData, index, false)
--                         end
--                     end
--                 else
--                     if #(playerCoords - vector3(markerData.coords.pos.x, markerData.coords.pos.y, markerData.coords.pos.z)) < 4 and GetEntityHealth(PlayerPedId()) > 101 then
--                         if not playerInMarker then
--                             playerInMarker = true

--                             local res = vTunnel.validateOtherOrgInMarker(markerData, index)
--                             if res then
--                                 timeInsideMarker = 0
--                                 lastUpdate = GetGameTimer()
--                             end
--                         else
--                             if markerData.contestando then

--                                 local timeRemaining = math.max(Config.timeDominationZone - timeInsideMarker, 0)
--                                 local secondsRemaining = math.floor(timeRemaining)
        
--                                 if playerInMarker then
--                                     local elapsed = (GetGameTimer() - lastUpdate) / 1000 -- Tempo em segundos
--                                     if elapsed >= 1 then
--                                         timeInsideMarker = timeInsideMarker + 1
--                                         lastUpdate = GetGameTimer() -- Atualiza o último tempo
--                                     end
--                                 end
        
--                                 alpha = 255
--                                 status = string.format('CONTESTANDO: %d segundos', secondsRemaining)
        
--                                 if timeInsideMarker >= Config.timeDominationZone then
--                                     timeInsideMarker = 0
--                                     markerData.dominado = true
                                    
--                                     playerInMarker = false
--                                     vTunnel._updateMarker({
--                                         marker = markerData,
--                                         index = index,
--                                     })
--                                 end
--                             end
--                         end
--                     else

--                         alpha = 80
--                         status = string.format('DOMINADO POR: %s', markerData.dominadoBy)

--                         playerInMarker = false
--                     end


--                     local color = {255, 0, 0, 250}
--                     if markerData.contestando then
--                         color = {255, 255, 0, 250}
--                     else
--                         color = {54, 117, 206, 250}
--                     end

--                     DrawMarker(
--                         25,
--                         markerData.coords.pos.x, markerData.coords.pos.y, markerData.coords.pos.z - 0.8,
--                         0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
--                         8.5, 8.5, 1.0,
--                         color[1], color[2], color[3], color[4],
--                         false, true, 2, false, nil, nil, false
--                     )
--                 end 

--                 drawPosition(markerData, status, alpha)
--             end
--             Citizen.Wait(0)
--         end
--     end)
-- end)

function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OTHERS FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function updateBlip()
    if blip > 0 then
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end
    
    blip = AddBlipForCoord(Config.coordsBlip.x,Config.coordsBlip.y,Config.coordsBlip.z)
    SetBlipScale(blip, 0.5)
    SetBlipSprite(blip, 84)
    SetBlipColour(blip, 1)
    SetBlipAsShortRange(blip,true)
    BeginTextCommandSetBlipName("STRING")

    AddTextComponentString( ("[ %s ] Dominado Por: %s"):format('Pistola', GlobalState.dominationPistolOwner) )
    EndTextCommandSetBlipName(blip)
end

function drawPoly()
    local playerPed = GetPlayerPed(-1)
    local Zone = Config.coordsPolyZone
    local j = #Zone
    for i = 1, #Zone do
        local zone = Zone[i]
        if i < #Zone then
            local p2 = Zone[i+1]
            showWall(zone, p2)
        end
    end
    if #Zone > 2 then
        local firstPoint = Zone[1]
        local lastPoint = Zone[#Zone]
        showWall(firstPoint, lastPoint)
    end
end

function showWall(p1, p2)
    local bottomLeft = vector3(p1[1], p1[2], p1[3] - 100)
    local topLeft = vector3(p1[1], p1[2],  p1[3] + 100)
    local bottomRight = vector3(p2[1], p2[2], p2[3] - 100)
    local topRight = vector3(p2[1], p2[2], p2[3] + 100)

    DrawPoly(bottomLeft, topLeft, bottomRight, GlobalState.GlobalDominationPistolColor[1], GlobalState.GlobalDominationPistolColor[2], GlobalState.GlobalDominationPistolColor[3], GlobalState.GlobalDominationPistolColor[1] == 175 and 250 or 150)
    DrawPoly(topLeft, topRight, bottomRight, GlobalState.GlobalDominationPistolColor[1], GlobalState.GlobalDominationPistolColor[2], GlobalState.GlobalDominationPistolColor[3], GlobalState.GlobalDominationPistolColor[1] == 175 and 250 or 150)
    DrawPoly(bottomRight, topRight, topLeft, GlobalState.GlobalDominationPistolColor[1], GlobalState.GlobalDominationPistolColor[2], GlobalState.GlobalDominationPistolColor[3], GlobalState.GlobalDominationPistolColor[1] == 175 and 250 or 150)
    DrawPoly(bottomRight, topLeft, bottomLeft, GlobalState.GlobalDominationPistolColor[1], GlobalState.GlobalDominationPistolColor[2], GlobalState.GlobalDominationPistolColor[3], GlobalState.GlobalDominationPistolColor[1] == 175 and 250 or 150)
end

function getPlyInZone()
    local plyCoords = GetEntityCoords(PlayerPedId())
    local inZone = false
    local tZone = {}
    local min = 1000.0

    local dist = #(Config.coordsBlip - GetEntityCoords(PlayerPedId()))
    if dist < min then
        min = dist

        local Zone = Config.coordsPolyZone
        local j = #Zone
        for i = 1, #Zone do
            if (Zone[i][2] < plyCoords.y and Zone[j][2] >= plyCoords.y or Zone[j][2] < plyCoords.y and Zone[i][2] >= plyCoords.y) then
                if (Zone[i][1] + ( plyCoords[2] - Zone[i][2] ) / (Zone[j][2] - Zone[i][2]) * (Zone[j][1] - Zone[i][1]) < plyCoords.x) then
                    inZone = not inZone;
                end
            end
            j = i;
        end
    end

    return inZone
end

CreateThread(function()
    updateBlip()
end)


CreateThread(function()
    while true do
        local timeDistance = 1000
        local ped = PlayerPedId()
        if player.inZone then
            if Config.vehicles.blockVehicles then
                timeDistance = 0
                if IsPedInAnyVehicle(ped) then
                    if Config.vehicles.allowListVehicles then
                        if not Config.vehicles.ListVehicles[GetEntityModel(GetVehiclePedIsIn(ped, false))] then
                            TaskLeaveVehicle(ped, GetVehiclePedIsIn(ped, false), 0)
                        end
                    else
                        TaskLeaveVehicle(ped, GetVehiclePedIsIn(ped, false), 0)
                    end
                end
            end
        end
        Wait(timeDistance)
    end
end)