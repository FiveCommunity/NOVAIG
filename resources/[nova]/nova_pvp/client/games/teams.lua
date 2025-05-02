-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
TEAMS = {
    inLobby = false,
    old_custom = {}
}

local ROOM_DATA = {}

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CreateTunnel.forceOpenTeams(room)
    ROOM_DATA = room
    TEAMS.inLobby = true

    SendNUIMessage({ action = 'open:room', type= 'teams' })
end

function CreateTunnel.syncTeams(room)
    SendNUIMessage({
        action = 'ROOM_UPDATED',
        data = {
          id = room.id,
          owner_id = room.owner_id,
          name = room.name,
          image = room.image,
          players = { 
            current = room.players.current, 
            max = room.players.max
        },
          weapon = room.weapon,
          rounds = room.rounds,
          mode = room.mode,
          teams = Execute.requestTeams()
      }
    })
end 

function CreateTunnel.destroyTeams()
    TEAMS.inLobby = false
    ROOM_DATA = {}

    SendNUIMessage({ action = 'open:home' }) 
    
    SetLocalPlayerAsGhost(false)
end

function CreateTunnel.destroyRoom()
    TEAMS.inLobby = false
    ROOM_DATA = {}

    PLAYER.IN_PVP = false
    PLAYER.MODE = nil
    PLAYER.MAP = nil 

    SetTimeout(1000, function()
        SendNUIMessage({ action = 'open', data = false }) 
    end)

    local ped = PlayerPedId()
    RemoveAllPedWeapons(ped,true)
    SetEntityCoords(ped, PLAYER.enterCoords) 
    SetEntityHealth(ped, PLAYER.enterHealth)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    SetLocalPlayerAsGhost(false)

    vRP.setCustomization(TEAMS.old_custom)

    -- freezar ele validar se veio pra ca e dps soltar de 5s
end

function CreateTunnel.startTeams(team, data)
    local map = Config.Maps[data.map]
    if not map or PLAYER.IN_PVP then
        return
    end

    TEAMS.old_custom = vRP.getCustomization()

    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'open', data = false }) 
    
    Wait(100)
    SendNUIMessage({ action = 'open:hud', data = 'teams' })

    PLAYER.enterHealth = GetEntityHealth(PlayerPedId())
    PLAYER.enterCoords = GetEntityCoords(PlayerPedId())

    local spawns = map.spawns[data.mode] and map.spawns[data.mode][team] or false
    if not spawns then
        return print('Spawns não encontrados.')
    end

    local ped = PlayerPedId()
    currentWeapon = Weapons[data.weapon]

    local x,y,z = spawns[data.slot].x, spawns[data.slot].y, spawns[data.slot].z
    RequestCollisionAtCoord(x,y,z)
    while not HasCollisionLoadedAroundEntity(ped) do
        RequestCollisionAtCoord(x,y,z)
        Citizen.Wait(1)
    end
    
    SetLocalPlayerAsGhost(false)
    SetEntityHealth(ped, GetPedMaxHealth(ped))
    SetEntityCoords(ped, x,y,z)
    FreezeEntityPosition(ped, true)

    CreateThread(function()
        if Config.Teams.uniforms[team] then
            local model = GetEntityModel(ped)
            local uniform = Config.Teams.uniforms[team][model]

            if uniform then
                vRP.setCustomization(uniform)
            end
        end
    end)

    -- FORÇAR TIRAR DO LIMBO
    CreateThread(function()
        local timeout = 3
        local x,y,z = x,y,z
        while timeout > 0 do
            timeout = timeout - 1
            if PLAYER.IN_PVP then
                RequestCollisionAtCoord(x,y,z)
                
                local dist = #(GetEntityCoords(ped) - vector3(x,y,z))
                if dist > 10 then
                    SetEntityCoords(ped, x,y,z)
                end
            end

            Wait(1000)
        end
    end)

    vRP._giveWeapons({ [currentWeapon] = { ammo = 250 } }, true)
    SetCurrentPedWeapon(ped, GetHashKey(currentWeapon), true)

    Wait(100)
    TriggerEvent('Weapon:Attachs')

    SetRunSprintMultiplierForPlayer(PlayerId(),1.2)

    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(),true,true)

    PLAYER.IN_PVP = true
    PLAYER.MODE = 'teams'
    PLAYER.MAP = data.map

    Wait(100)
    SendNUIMessage({ action = 'UPDATE_POINTS', data = { ct = 0, tr = 0 } })
    SendNUIMessage({ action = "UPDATE_TIME", data = Config.Teams.timePerRound * 60 })

    TEAMS:StartCountdown()

    CreateThread(function()
        local current_time = 1000
        while PLAYER.IN_PVP do
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)
            local health = (GetEntityHealth(ped) - 100) * 100
            local calc_health = health / (GetPedMaxHealth(ped) - 100)
            
            SendNUIMessage({ action = 'UPDATE_STATS', 
                data = { 
                    health = calc_health, 
                    armour = GetPedArmour(PlayerPedId()) 
                } 
            })

            local pedWeapon = GetSelectedPedWeapon(ped)
            if pedWeapon ~= GetHashKey(currentWeapon) and GetEntityHealth(PlayerPedId()) > 101 then
                vRP._giveWeapons({ [currentWeapon] = { ammo = 250 } }, true)
                SetCurrentPedWeapon(ped, GetHashKey(currentWeapon), true)

                Wait(100)
                TriggerEvent('Weapon:Attachs')
            end

            SetEntityInvincible(ped,false)
            SetEntityVisible(ped,true,false)

            Wait(1000)
        end
    end)

    CreateThread(function()
        while PLAYER.IN_PVP and PLAYER.MODE == 'teams' do
            local ped = PlayerPedId()
            local current_weapon = GetSelectedPedWeapon(ped)
            local _,current_ammo = GetAmmoInClip(ped, current_weapon) 
            SendNUIMessage({
                action = 'UPDATE_WEAPON',
                data = {
                  visibled = current_weapon ~= GetHashKey('WEAPON_UNARMED'),
                  munition = { current = current_weapon ~= GetHashKey('WEAPON_UNARMED') and current_ammo or 0, clip = current_weapon ~= GetHashKey('WEAPON_UNARMED') and (GetAmmoInPedWeapon(ped, current_weapon) - current_ammo) or 0 },
                  image = WeaponsHashs[current_weapon] and 'http://177.54.148.31:4020/lotus/inventario_cda/'..WeaponsHashs[current_weapon]..'.png' or ''
                }
            })

            BlockWeaponWheelThisFrame()
            DisableControlAction(0, 37, true)
            DisableControlAction(0, 199, true) 
            Wait(0)
        end
    end)
end

function CreateTunnel.forcePositions(team, slot, scoreboard)
    local ped = PlayerPedId()
    local map = Config.Maps[PLAYER.MAP]
    if not map or not PLAYER.IN_PVP then
        return print('Mapa não encontrado')
    end

    local spawns = map.spawns[PLAYER.MODE] and map.spawns[PLAYER.MODE][team] or false
    if not spawns then
        return print('Spawns não encontrados.')
    end

    if not spawns[slot] then
        return print('SLOT NAO ENCONTRADO')
    end

    local x,y,z = spawns[slot].x, spawns[slot].y, spawns[slot].z
    RequestCollisionAtCoord(x,y,z)
    while not HasCollisionLoadedAroundEntity(ped) do
        RequestCollisionAtCoord(x,y,z)
        Citizen.Wait(1)
    end
    
    SetLocalPlayerAsGhost(true)
    SetEntityHealth(ped, GetPedMaxHealth(ped))
    SetEntityCoords(ped, x,y,z)
    SetEntityInvincible(ped,false)
    SetEntityVisible(ped,true,true)

    -- FORÇAR TIRAR DO LIMBO
    CreateThread(function()
        local timeout = 3
        while timeout > 0 do
            timeout = timeout - 1
            if PLAYER.IN_PVP then
                RequestCollisionAtCoord(x,y,z)
                
                local dist = #(GetEntityCoords(ped) - vector3(x,y,z))
                if dist > 10 then
                    SetEntityCoords(ped, x,y,z)
                end
            end

            Wait(1000)
        end
    end)

    vRP._giveWeapons({ [currentWeapon] = { ammo = 250 } }, true)
    SetCurrentPedWeapon(ped, GetHashKey(currentWeapon), true)

    Wait(100)
    TriggerEvent('Weapon:Attachs')

    SetRunSprintMultiplierForPlayer(PlayerId(),1.2)

    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(),true,true)
    Wait(100)

    print(json.encode(scoreboard, { indent = true }))
    SendNUIMessage({ action = 'UPDATE_POINTS', data = scoreboard })
    SendNUIMessage({ action = "UPDATE_TIME", data = Config.Teams.timePerRound * 60 })

    TEAMS:StartCountdown()
    SetLocalPlayerAsGhost(false)
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HANDLERS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local death_plys = {}
local myDeath = {}

AddEventHandler("gameEventTriggered", function(eventName, args)
    if eventName ~= "CEventNetworkEntityDamage" or not PLAYER.IN_PVP or PLAYER.MODE ~= 'teams' then
        return
    end

    local ped = PlayerPedId()
    local victim = args[1]
    local attacker = args[2]
    local weapon = args[7]

    -- ENVIANDO KILL FEED
    if IsPedAPlayer(attacker) and attacker == ped and not death_plys[victim] and GetEntityHealth(victim) <= 101 then
        SetEntityHealth(ped, GetPedMaxHealth(ped))
        vRP._giveWeapons({ [currentWeapon] = { ammo = 250 } }, false)

        Wait(100)
        TriggerEvent('Weapon:Attachs')

        RefillAmmoInstantly(ped)
    end

    -- Validando Morte
    if victim == ped and GetEntityHealth(victim) < 101 or IsEntityDead(victim) then
        if death_plys[victim] then
            return
        end
        death_plys[victim] = true
    
        local hit, bone = GetPedLastDamageBone(victim)
        Execute._updateTeamsFeed({
            attacker = GetPlayerServerId(NetworkGetPlayerIndexFromPed(attacker)),
            victim = GetPlayerServerId(NetworkGetPlayerIndexFromPed(victim)),
            isHs = (bone == 31086),
            weapon = weapon,
            mode = PLAYER.MODE
        })
    
        CreateThread(function()
            local ped = PlayerPedId()
            local plyCds = GetEntityCoords(ped)
            NetworkResurrectLocalPlayer(plyCds.x, plyCds.y, plyCds.z, true, false)
            SetEntityHealth(ped, 101)
    
            while GetEntityHealth(ped) <= 101 and PLAYER.IN_PVP do
                SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
                SetEntityHealth(ped, 101)
                SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
                Wait(0)
            end

            if not PLAYER.IN_PVP then
                SetEntityHealth(ped, 110)
            end
            
            death_plys[victim] = nil
        end)
    end
    
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OTHERS FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TEAMS:closeLobby()
    Execute._leaveTeam()
end

function TEAMS:StartCountdown()
    CreateThread(function()
        local count = 5
        local startTime = GetGameTimer()

        while count > 0 do
            FreezeEntityPosition(PlayerPedId(), true)
            SetLocalPlayerAsGhost(true)

            if GetGameTimer() - startTime >= 1000 then
                count = count - 1
                startTime = GetGameTimer()
            end

            Wait(0)
        end

        FreezeEntityPosition(PlayerPedId(), false)
        SetLocalPlayerAsGhost(false)
    end)
end


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('GET_ROOM', function(data, cb)
    cb({
        id = ROOM_DATA.id,
        owner_id = ROOM_DATA.owner_id,
        name = ROOM_DATA.name,
        image = ROOM_DATA.image,
        players = {
            current = ROOM_DATA.players.current,
            max = ROOM_DATA.players.max
        },
        weapon = ROOM_DATA.weapon,
        rounds = ROOM_DATA.rounds,
        mode = ROOM_DATA.mode,
        minutes = ROOM_DATA.minutes,
        teams = Execute.requestTeams()
    })
end)

RegisterNuiCallback('ROOM_UPDATED', function(data, cb)
    cb(Execute.changeTeam())
end)

RegisterNuiCallback('START_GAME', function(data, cb)
    cb(Execute.startGame())
end)

RegisterNuiCallback('BACK_TEAM', function(data, cb)
    Execute._leaveTeam()
    cb(true)
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('+scoreboard_teams', function()
    if not PLAYER.IN_PVP or PLAYER.MODE ~= 'teams' then return end
    SendNUIMessage({ 
        action = 'UPDATE_SCOREBOARD',
        data = {
          visibled = true,
          players = Execute.requireTeamsScoreboard()
        }
    })
end)

RegisterCommand('-scoreboard_teams', function()
    SendNUIMessage({ 
        action = 'UPDATE_SCOREBOARD', 
        data = { 
            visibled = false 
        } 
    })
end)
RegisterKeyMapping('+scoreboard_teams', 'Scoreboard PVP', 'keyboard', 'TAB')