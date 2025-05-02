-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PLAYER = {
    IN_PVP = false,
    MODE = nil,
    MAP = nil,
    enterCoords = nil,
    enterHealth = nil,
}

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CreateTunnel.syncKillFeed(data)
    SendNUIMessage({ action = 'NEW_KILL', data = data })
end

function CreateTunnel.syncKills(data)
    SendNUIMessage({ action = 'UPDATE_KILLS', data = data })
end

function CreateTunnel.destroyRoom(data)
    PLAYER.IN_PVP = false
    PLAYER.MODE = nil
    PLAYER.MAP = nil 

    SendNUIMessage({ action = 'open', data = false }) 

    local ped = PlayerPedId()
    RemoveAllPedWeapons(ped,true)
    SetEntityCoords(ped, PLAYER.enterCoords)
    SetEntityHealth(ped, PLAYER.enterHealth)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    SetLocalPlayerAsGhost(false)
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('+scoreboard_pvp', function()
    if not PLAYER.IN_PVP and not IN_X1 then return end
    
    local scoreboard = Execute.requireScoreboard()
    if not scoreboard then return end

    SendNUIMessage({ action = 'UPDATE_SCOREBOARD', data = { visibled = true, players = scoreboard } })
end)

RegisterCommand('-scoreboard_pvp', function()
    SendNUIMessage({ action = 'UPDATE_SCOREBOARD', data = { visibled = false, } })
end)
RegisterKeyMapping('+scoreboard_pvp', 'Scoreboard PVP', 'keyboard', 'TAB')

RegisterCommand('pvpoff', function()
    print('PLAYER.IN_PVP', PLAYER.IN_PVP)
    if not PLAYER.IN_PVP then 
        return 
    end

    print('IN_X1', IN_X1)
    if IN_X1 then
        return Execute._leaveX1()
    end

    print('PLAYER.MODE', PLAYER.MODE)
    if PLAYER.MODE == 'teams' then
        return Execute._leaveTeams()
    end

    print('leaveRoom', leaveRoom)
    Execute._leaveRoom()
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNuiCallback('GET_ARENAS', function(data, cb)
    local rooms = Execute.getRooms(data.mode)
    cb(rooms)
end)

RegisterNuiCallback('GET_MAPS', function(data, cb)
    local maps = {}
    for name, v in pairs(Config.Maps) do
        maps[#maps + 1] = {
            name = name,
            image = v.image
        }
    end
    cb(maps)
end)

RegisterNuiCallback('GET_OPTIONS', function(data, cb)
    local weapons = {}
    if Config.Weapons[data.category] then
        for spawn, name in pairs(Config.Weapons[data.category]) do
            weapons[#weapons + 1] = name
        end
    end

    cb(weapons)
end)

RegisterNuiCallback('CREATE_ROOM', function(data, cb)
    cb(Execute.CreateRoom(data))
end)

RegisterNuiCallback('JOIN_ROOM', function(data, cb)
    cb(Execute.JoinRoom(data.room))
end)