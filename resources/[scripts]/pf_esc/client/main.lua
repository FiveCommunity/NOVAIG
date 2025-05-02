----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local SLEEP_TIME = 1000

        if not (IsPauseMenuActive()) then
            SLEEP_TIME = 0

            DisableControlAction(0, 200, true)
        end

        Wait( SLEEP_TIME )
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local delayTimer = GetGameTimer()
RegisterCommand('open_menu', function(source,args)
    if exports["nova_skins"]:Status() then return end 
    
    if (not IsPauseMenuActive()) and (delayTimer - GetGameTimer() < 0 ) and (GetEntityHealth(PlayerPedId()) > 101) then
        delayTimer = (GetGameTimer() + 3000)
        SetNuiFocus(true, true)
        SendNUIMessage({ action = 'setVisible', data = true })
    end
end)
RegisterKeyMapping("open_menu","Open Menu","keyboard","ESCAPE")

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CloseMenu()
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'setVisible', data = false })
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local cacheTimer,cached = GetGameTimer(), {}
RegisterNUICallback('requestInfos', function(data,cb)
    if (cacheTimer - GetGameTimer() < 0) then
        cacheTimer = (GetGameTimer() + 10000)

        cached = vTunnel.requestMenu()
    end

    cb(cached)
end)

RegisterNUICallback('requestStore', function(data,cb)
    local data = vTunnel.requestStore()
    data.package = config.package
    data.items = config.stores
    data.time = data.remaingTime

    cb(data)
end)

RegisterNUICallback('buyItem', function(data,cb)
    vTunnel._buyItem(data)
end)

RegisterNUICallback('buyPackage', function(data,cb)
    vTunnel._buyPackage()
end)

RegisterNUICallback('action', function(data, cb)
    if data.action == 'settings' then
        ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'), true)
    elseif data.action == 'exit' then
        RestartGame()
    elseif data.action == 'map' then
        ActivateFrontendMenu(GetHashKey("FE_MENU_VERSION_MP_PAUSE"),0,-1)
    end
    
    CloseMenu()
end)

RegisterNUICallback('hideFrame', function(data, cb) 
    CloseMenu()
end)

RegisterNUICallback('OpenCases', function (data, cb)
    CloseMenu()
    ExecuteCommand('box')
end)

RegisterNUICallback('OpenPass', function (data, cb)
    CloseMenu()
    ExecuteCommand('openpass')
end)

RegisterNUICallback('OpenSkins', function (data, cb)
    CloseMenu()
    -- TriggerEvent("Notify","negado","Disponivel em Breve",5)
    -- exports["nova_skins"]:showInterface()
    ExecuteCommand('skins')
end)

RegisterNUICallback('OpenAim', function (data, cb)
    CloseMenu()
    exports["nova_aim"]:openInterface()
end)

RegisterNUICallback('OpenBoost', function (data, cb)
    CloseMenu()

    ExecuteCommand("fpsbooster")
end)

RegisterNUICallback('OpenBet', function(data, cb)
    CloseMenu()
    ExecuteCommand('apostar')
    cb(true)
end)

RegisterNUICallback('OpenVips', function(data, cb)
    CloseMenu()
    ExecuteCommand('loja')
    cb(true)
end)

RegisterNUICallback('OpenCrosshair', function(data, cb)
    CloseMenu()
    ExecuteCommand("aim")
    cb(true)
end)


RegisterNUICallback('OpenTip', function(data, cb)
    CloseMenu()
    ExecuteCommand("tips")
    cb(true)
end)