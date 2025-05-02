local reasonDeath
local pedKiller
local Killer

local cooldown = 0
local morto = false
local deathtimer = LocalPlayer.state.NovatMode and 30 or cfg.deathtimer
local DisableMouse = 0
local mouseActived = false


local cooldownOnClick = GetGameTimer()
local calledStaff = false 
local inReviving = false
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
        local time = 300
		local ped = PlayerPedId()
		local vida = GetEntityHealth(ped)
		local x,y,z = table.unpack(GetEntityCoords(ped,true))

        if cfg.dependencys() then
            if IsEntityDead(ped) then
                time = 0
                if GetPedCauseOfDeath(ped) ~= 0 and cooldown == 0 then
                    cooldown = cfg.cooldown

                    reasonDeath = GetPedCauseOfDeath(ped)
                    pedKiller = GetPedSourceOfDeath(ped)

                    if IsEntityAPed(pedKiller) and IsPedAPlayer(pedKiller) then
                        Killer = NetworkGetPlayerIndexFromPed(pedKiller)
                    elseif IsEntityAVehicle(pedKiller) and IsEntityAPed(GetPedInVehicleSeat(pedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(pedKiller, -1)) then
                        Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(pedKiller, -1))
                    end
                    
                    sendToLog(PlayerId(), reasonDeath, Killer)
                end 

                if not morto then
                    deathtimer = LocalPlayer.state.NovatMode and 30 or cfg.deathtimer
                    
                    local newSeconds = vSERVER.secoundsDeath()
                    if newSeconds then
                        deathtimer = newSeconds
                    end
                end


                NetworkResurrectLocalPlayer(x,y,z,true,true, false)
                SetEntityInvincible(ped,true)
                SetPedDiesInWater(ped, false)
                SetEntityHealth(ped, cfg.minHealth)
            end

            if vida <= cfg.minHealth and not morto then
                if not LocalPlayer.state.isSpawnActived then
                    morto = true
                    mouseActived = false 
                    SetNuiFocus(true,true)
                    TriggerEvent('dynamic:closeSystem2',source)
                    TriggerEvent("ragdoll:ChangeStatus", morto)

                    SetEntityHealth(ped, cfg.minHealth)
                    vRPserver.updateHealth(cfg.minHealth)
                    ExecuteCommand("e morrer")
                    TriggerEvent('mirtin_survival:updateComa', morto)
                    TriggerServerEvent('pma-voice:toggleMutePlayer', true)
                    SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
                    TriggerEvent("pma-voice:MutePlayer")
                    MumbleSetVolumeOverride(PlayerId(),0.0)
                    MumbleSetActive(false)

                    exports["pma-voice"]:removePlayerFromRadio()
                    exports["pma-voice"]:setVoiceProperty('radioEnabled',false)
                    TriggerEvent("lotus-hud:leaveFrequency", 0)
                    TriggerEvent('flaviin:toggleHud', false)
                else
                    Wait(4000)
                end
            end

            if morto then
                if vida <= cfg.minHealth and not inReviving then
                    time = 5
                    cfg.animDeath()

                    DisableControlAction(0,199,true)
                    DisableControlAction(0,200,true)

                    if cfg.versionNUI then
                        openNui()
                        if deathtimer <= 0 then
                            if DisableMouse <= 0 then 
                                if not mouseActived then 
                                    SetNuiFocus(true,true)
                                    mouseActived = true 
                                end
                            else
                                if mouseActived then 
                                    mouseActived = false 
                                    SetNuiFocus(false,false)
                                end
                            end
                            
                            if not cfg.timedown then
                             --[[   if IsControlJustPressed(0,38) then
                                    if exports['vrp_policia']:getArrest() == true then 
                                        TriggerEvent("Notify",'negado','Você não pode reviver sendo arrestado.')
                                    else
                                        morrer()
                                        StopScreenEffect("DeathFailMPIn")
                                    end
                                end]]
                            end
                        end
                    else
                        cfg.drawtext(deathtimer)
                    end

                end

                if vida > cfg.minHealth then
                    morto = false
                    TriggerEvent("ragdoll:ChangeStatus", morto)
                    deathtimer =  cfg.deathtimer
                    SetEntityInvincible(ped,false)
                    SetPedDiesInWater(ped, true)
                    TriggerEvent('mirtin_survival:updateComa', morto)
                    StopScreenEffect("DeathFailMPIn")
                    vRPserver.updateHealth(GetEntityHealth(ped))
                    TriggerServerEvent('pma-voice:toggleMutePlayer', false)
                    TriggerEvent("pma-voice:DesmutePlayer")
                    MumbleSetVolumeOverride(PlayerId(),-1.0)
                    MumbleSetActive(true)
                    ClearPedTasksImmediately(ped)
                    calledStaff = false
                    if cfg.versionNUI then
                        closeNui()
                        TriggerEvent('flaviin:toggleHud', true)
                    end
                end

                if not IsEntityAttached(PlayerPedId()) then
                    if deathtimer <= 0 then
                        if cfg.timedown then
                            morrer()
                        end
                    end
                end
            end
        end

        Citizen.Wait(time)
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
sendToLog = function(idMorto, motivoMorto, quemMatou)
    local source = 0
    local ksource = 0
    local motivo = ""

    if idMorto ~= 0 then
        source = GetPlayerServerId(idMorto)
    end

    if quemMatou ~= 0 then
        ksource = GetPlayerServerId(quemMatou)
    end
    
    if cfg.reasons[motivoMorto] then
        motivo = cfg.reasons[motivoMorto]
    else
        motivo= cfg.reasons[0]
    end

    vSERVER.receberMorte(source, motivo, ksource)
end

src.getPosition = function()
    return GetEntityCoords(PlayerPedId(),true)
end

src.setFinalizado = function()  
    deathtimer = 0
end

morrer = function()
    Citizen.Wait(500)
    calledStaff = false
    morto = false
    TriggerEvent("ragdoll:ChangeStatus", morto)

    deathtimer = cfg.deathtimer

    StopScreenEffect("DeathFailMPIn")
    if cfg.versionNUI then
        closeNui()
    end

    TriggerEvent('mirtin_survival:updateComa', morto)
    TriggerServerEvent('pma-voice:toggleMutePlayer', false)

    MumbleSetVolumeOverride(PlayerId(),-1.0)
    MumbleSetActive(true)

    DoScreenFadeOut(500)

    Citizen.Wait(2000)
    SetEntityInvincible(PlayerPedId(),false)
    SetPedDiesInWater(PlayerPedId(), true)
    ClearPedBloodDamage(PlayerPedId())

    Citizen.Wait(200)
    -- SetEntityCoords(PlayerPedId(), cfg.respawn)
    if not LocalPlayer.state.NovatMode then
        cfg.clearAccount()
    end

    Citizen.Wait(3000)
    SetEntityHealth(PlayerPedId(), cfg.maxHealth)
    ClearPedTasks(PlayerPedId())
    
    Citizen.Wait(4000)
    DoScreenFadeIn(1000)
    -- TriggerEvent('flaviin:toggleHud', true)
end

src.morrer2 = function()
    if IsEntityAttached(PlayerPedId()) then
        return false
    end
    calledStaff = false
    morto = false
    TriggerEvent("ragdoll:ChangeStatus", morto)

    deathtimer =  cfg.deathtimer

    StopScreenEffect("DeathFailMPIn")
    if cfg.versionNUI then
        closeNui()
    end

    TriggerEvent('mirtin_survival:updateComa', morto)
    TriggerServerEvent('pma-voice:toggleMutePlayer', false)

    MumbleSetVolumeOverride(PlayerId(),-1.0)
    MumbleSetActive(true)
    DoScreenFadeOut(500)

    Citizen.Wait(2000)
    SetPedDiesInWater(PlayerPedId(), true)
    ClearPedBloodDamage(PlayerPedId())

    Citizen.Wait(3000)
    SetEntityCoords(PlayerPedId(), cfg.respawn)
    if not LocalPlayer.state.NovatMode then
        cfg.clearAccount()
    end

    Citizen.Wait(500)
    SetEntityHealth(PlayerPedId(), cfg.maxHealth)
    ClearPedTasks(PlayerPedId())
    
    TriggerServerEvent('pma-voice:toggleMutePlayer', false)
    
    Citizen.Wait(4000)
    DoScreenFadeIn(1000)
end

RegisterNetEvent("mirtin_survival:updateComa")

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NUI
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
openNui = function()
--    if deathtimer <= 0 then SetNuiFocus(true, true) end
    local killerSource = nil
    if Killer ~= 0 then
        killerSource = GetPlayerServerId(Killer)
    end
    SendNUIMessage({ action = 'open', deathtimer = deathtimer })
end

closeNui = function()
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close', deathtimer = deathtimer })
end

RegisterNuiCallback('spawn', function(data)
    if deathtimer <= 0 then
        
        if not cfg.timedown then
            if exports['vrp_policia']:getArrest() == true then 
                TriggerEvent("Notify",'negado','Você não pode reviver sendo arrestado.')
            elseif IsEntityAttached(PlayerPedId()) then
                TriggerEvent("Notify",'negado','Você não pode reviver enquanto está carregando.')
            else
                inReviving = true
                StopScreenEffect("DeathFailMPIn")
                if data.name == 'north' then
                    vRP.teleport(-234.11,6313.94,31.48)
                elseif data.name == 'south' then
                    vRP.teleport(338.79,-1394.7,32.5)
                end
                morrer()
                inReviving = false
            end
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CALL BOMBEIRO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("callFireman", function(data, cb) 
    if cooldownOnClick > GetGameTimer() then return end 
    TriggerEvent("Notify",'negado','Notify enviada para o bombeiro.')
    TriggerServerEvent("hub:sendFireCall")
    
    cooldownOnClick = GetGameTimer() + (60000 * 2)
    cb(true)
end) 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CALL STAFF
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("callStaff",function(data,cb)
    if calledStaff then return end 

    TriggerServerEvent("hub:sendCall2",true)

    calledStaff = true 

    cb(true)
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONTADOR
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local time = 1000
        
        if cooldown > 0 then
            cooldown = cooldown - 1

            if cooldown <= 0 then
                cooldown = 0
            end
        end

        if DisableMouse >= 0 then 
            DisableMouse = DisableMouse - 1 
            if DisableMouse <= 0 then 
                DisableMouse = 0 
            end
        end

        if morto then
            deathtimer = deathtimer - 1

            if deathtimer <= 0 then
                deathtimer = 0
            end
        end

        Citizen.Wait(time)
    end
end)

RegisterNetEvent("Survival:DisableFocus",function()
    DisableMouse = 30
end)

local isNotifyActive = false
RegisterNetEvent('hub:notify', function(id, distance)
    isNotifyActive = true
    SendNUIMessage({ action = 'notify', id = id, distance = distance })

    CreateThread(function()
        local distanceString = vSERVER.getDistance(id)
        
        local distanceNumber = 0
        if distanceString then
            distanceString = distanceString:gsub('m', ''):gsub(',', '.')
            distanceNumber = tonumber(distanceString) or 0
        end
        
        while distanceNumber and distanceNumber > 5.0 and isNotifyActive do
            Wait(5000)
            distanceString = vSERVER.getDistance(id)

            if distanceString then
                distanceString = distanceString:gsub('m', ''):gsub(',', '.')
                distanceNumber = tonumber(distanceString) or 0
            else
                distanceNumber = 0
            end

            SendNUIMessage({ action = 'notify', id = id, distance = distanceString or '0m' })
        end
        isNotifyActive = false
        SendNUIMessage({ action = 'notify:close' })
    end)
end)

RegisterNetEvent('close:callhud', function()
    if isNotifyActive then
        isNotifyActive = false
    end
end)