----------------------------------------------------------------------------------------------------------------------------------------------------
-- VRP
----------------------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vSERVER = Tunnel.getInterface(GetCurrentResourceName())
----------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
----------------------------------------------------------------------------------------------------------------------------------------------------
local activeConfig = { ["Padrão"] = "eyJuYW1lIjoiUGFkcuNvIiwiY29sb3IiOiJ3aGl0ZSIsImRvdCI6eyJhY3RpdmVkIjp0cnVlLCJ0aGlja25lc3MiOjUsIm9wYWNpdHkiOjF9LCJpbm5lciI6eyJhY3RpdmVkIjpmYWxzZSwib3BhY2l0eSI6MSwibGVuZ3RoIjo2LCJ0aGlja25lc3MiOjUsIm9mZnNldCI6MX0sIm91dGVyIjp7ImFjdGl2ZWQiOmZhbHNlLCJvcGFjaXR5IjoxLCJsZW5ndGgiOjYsInRoaWNrbmVzcyI6NSwib2Zmc2V0IjoxMH19" }
local showAim = false
local lastShowAimState = false
local aimState = false 
----------------------------------------------------------------------------------------------------------------------------------------------------
-- OPEN INTERFACE
----------------------------------------------------------------------------------------------------------------------------------------------------
local function openInterface()
    TriggerEvent("flaviin:toggleHud",false)
    SetNuiFocus(true,true)
    TransitionToBlurred(1000)    
    SendNUIMessage({ action = "open:configuration", data = true })
end
----------------------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE INTERFACE
----------------------------------------------------------------------------------------------------------------------------------------------------
local function closeInterface()
    TriggerEvent("flaviin:toggleHud",true)
    SetNuiFocus(false,false)
    TransitionFromBlurred(1000)
    SendNUIMessage({ action = "open:crosshair", data = true })
end
----------------------------------------------------------------------------------------------------------------------------------------------------
-- OPEN SYSTEM
----------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("aim", function(_, args, rawCommand)
    openInterface()
end)
----------------------------------------------------------------------------------------------------------------------------------------------------
-- DESATIVAR MIRA
----------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("mira", function(_, args, rawCommand)
    aimState = not aimState
    if not aimState then 
        TriggerEvent("Notify","sucesso","Mira Desativada.",5)
    else
        TriggerEvent("Notify","sucesso","Mira Ativada.",5)
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------
-- OBTER MIRAS
----------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("GetAims", function(Data, Callback)
    local sendIndex = {}
    for k,v in pairs(activeConfig) do 
        table.insert(sendIndex,{ activeConfig[k] })
    end

    Callback(sendIndex)    
end)
----------------------------------------------------------------------------------------------------------------------------------------------------
-- CREATE
----------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Create", function(Data, Callback)
    local checkSave = function()
        local indexAims = 0
        for k,v in pairs(activeConfig) do 
            indexAims = indexAims + 1
        end

        local checkMax = vSERVER.Max()

        if (indexAims + 1) > checkMax then 
            return false 
        end

        return true 
    end

    local response = checkSave()
    Callback(response)
    if not response then 
        closeInterface()
        TriggerEvent("Notify","negado","Você atingiu o máximo de miras criadas, expanda os seus Slots.",5)
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
----------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Delete", function(Data, Callback)
    local sendIndex = {}
    if activeConfig[Data.name] then 
        activeConfig[Data.name] = nil 
    end

    vSERVER.Save(activeConfig)

    for k,v in pairs(activeConfig) do 
        table.insert(sendIndex,{ activeConfig[k] })
    end


    Callback(sendIndex)

    closeInterface()
end)
----------------------------------------------------------------------------------------------------------------------------------------------------
-- CREATE
----------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close", function(Data, Callback)
    closeInterface()
    Callback(true)
end)
----------------------------------------------------------------------------------------------------------------------------------------------------
-- COPIAR CÓDIGO DA MIRA
----------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Copy", function(Data, Callback)
    closeInterface()
    vSERVER.Output(Data.config)
end)
----------------------------------------------------------------------------------------------------------------------------------------------------
-- SALVAR
----------------------------------------------------------------------------------------------------------------------------------------------------
local clickCooldown = GetGameTimer()
RegisterNUICallback("Save", function(Data, Callback)
    if clickCooldown > GetGameTimer() then 
        return false 
    end

    clickCooldown = clickCooldown + 500

    activeConfig[Data.name] = Data.config

    local sendIndex = {}
    for k,v in pairs(activeConfig) do 
        table.insert(sendIndex,{ activeConfig[k] })
    end

    Callback(sendIndex)
    closeInterface()

    if not aimState then 
        aimState = true 
    end

    vSERVER.Save(activeConfig)
end)
----------------------------------------------------------------------------------------------------------------------------------------------------
-- THREAD SYSTEM
----------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do 
        local timeDistance = 500 
        local ped = PlayerPedId()

        if IsPedArmed(ped, 6) and aimState then 
            timeDistance = 0
            HideHudComponentThisFrame(14)
            local isAiming = GetControlNormal(0,25)
            if isAiming > 0 then 
                if not showAim then 
                    showAim = true 
                    if showAim ~= lastShowAimState then
                        SendNUIMessage({ action = "showCrosshair", data = showAim })
                        lastShowAimState = showAim -- Atualiza o último estado conhecido
                    end
                end
            else
                if showAim then
                    showAim = false 
                    if showAim ~= lastShowAimState then
                        SendNUIMessage({ action = "showCrosshair", data = showAim })
                        lastShowAimState = showAim -- Atualiza o último estado conhecido
                    end
                end
            end
        end

        Citizen.Wait(timeDistance)
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------
-- LOAD AIMS
----------------------------------------------------------------------------------------------------------------------------------------------------
local function LoadAims()
    while not IsPlayerPlaying(PlayerId()) do 
        Citizen.Wait(10)
    end

    local requestAims = vSERVER.Aims(activeConfig)
    if requestAims then 
        aimState = true 
        activeConfig = requestAims 
    end

    SendNUIMessage({ action = "opened", data = true })
end
----------------------------------------------------------------------------------------------------------------------------------------------------
-- ON LOAD RESOURCE
----------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("ToogleBackCharacter",function()
    Citizen.Wait(200)
    LoadAims()
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    LoadAims()
end)

exports("openInterface",openInterface)