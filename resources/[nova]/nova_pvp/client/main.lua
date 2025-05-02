-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local SLEEP_TIME = 1000
        local pedCoords = GetEntityCoords(PlayerPedId())

        for _, coords in pairs(Config.coords) do
            local dist = #(pedCoords - vec3(coords.x,coords.y,coords.z))
            if --[[ not LocalPlayer.state.inPvP and ]] dist <= 2.5 then
                SLEEP_TIME = 0
                DrawMarker(27,coords.x,coords.y,coords.z-0.97,0,0,0,0,0,0,1.0,1.0,0.5,75, 189, 255,155,0,0,0,1)
                if IsControlJustPressed(0,38) then
                    Execute._open()
                end
            end
        end

        Wait(SLEEP_TIME)
    end
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CreateTunnel.openLobby(data, cb)
    SendNUIMessage({ action = 'open', data = true })
    SendNUIMessage({ action = 'open:home' })
    SetNuiFocus(true, true)
end

function CreateTunnel.openRegister(data, cb)
    SendNUIMessage({ action = 'open', data = true })
    SendNUIMessage({ action = 'open:register' })
    SetNuiFocus(true, true)
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNuiCallback('REGISTER', function(data, cb)
    local register = Execute.register(data)
    if register then
        SetNuiFocus(false, false)
    end
    
    cb(register)
end)

RegisterNuiCallback('OPEN_SKINS', function(data, cb)
    cb(true)
end)

RegisterNuiCallback('CLOSE', function(data, cb)
    SendNUIMessage({ action = 'open', data = false }) 
    SetNuiFocus(false, false)

    if TEAMS.inLobby then
        TEAMS.inLobby = false
        TEAMS:closeLobby()
    end

    cb(true)
end)