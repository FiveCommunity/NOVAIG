-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local PENDING_REQUEST = false
local currentWeapon = nil
IN_X1 = false
local CURRENT_TIME = 0
local currentPos = 0

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EVENTS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('join:game:x1', function(data)
    SetNuiFocus(false, false)

    local map = Config.X1.map
    if not map or PLAYER.IN_PVP then
        return
    end

    PLAYER.enterHealth = GetEntityHealth(PlayerPedId())
    PLAYER.enterCoords = GetEntityCoords(PlayerPedId())

    local spawns = map.spawns
    local ped = PlayerPedId()

    currentWeapon = Weapons[data.weapon]
    currentPos = data.pos

    local x,y,z = spawns[currentPos].x, spawns[currentPos].y, spawns[currentPos].z
    RequestCollisionAtCoord(x,y,z)
    while not HasCollisionLoadedAroundEntity(ped) do
        RequestCollisionAtCoord(x,y,z)
        Citizen.Wait(1)
    end

    SetLocalPlayerAsGhost(false)
    SetEntityHealth(ped, GetPedMaxHealth(ped))
    SetEntityCoords(ped, x,y,z)

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


    vRP._giveWeapons({ [currentWeapon] = { ammo = 250 } })
    SetCurrentPedWeapon(ped, GetHashKey(currentWeapon), true)

    Wait(100)
    TriggerEvent('Weapon:Attachs')

    SetRunSprintMultiplierForPlayer(PlayerId(),1.2)

    SendNUIMessage({ action = 'open:hud', data = 'x1' })

    Wait(100)
    SendNUIMessage({
        action = 'updateScore',
        data = {
          timer = 60 * Config.X1.maxTime,
          player1 = { icon = '', points = 0 },
          player2 = { icon = '', points = 0 }
        }
    })

    IN_X1 = true

    StartCountdown()

    CreateThread(function()
        local current_time = 1000
        while IN_X1 do
            local ped = PlayerPedId()
            local health = (GetEntityHealth(ped) - 100) * 100
            local calc_health = health / (GetPedMaxHealth(ped) - 100)
            
            SendNUIMessage({ action = 'UPDATE_STATS', 
                data = { 
                    health = calc_health, 
                    armour = GetPedArmour(PlayerPedId()) 
                } 
            })

            local pedWeapon = GetSelectedPedWeapon(ped)
            if pedWeapon ~= GetHashKey(currentWeapon) then
                vRP._giveWeapons({ [currentWeapon] = { ammo = 250 } }, true)
                SetCurrentPedWeapon(ped, GetHashKey(currentWeapon), true)
            end

            SetEntityInvincible(ped,false)
            SetEntityVisible(ped,true,false)

            NetworkSetFriendlyFireOption(true)
            SetCanAttackFriendly(PlayerPedId(),true,true)

            Wait(1000)
        end
    end)

    CreateThread(function()
        while IN_X1 do
            local ped = PlayerPedId()
            local current_weapon = GetSelectedPedWeapon(ped)
            local _,current_ammo = GetAmmoInClip(ped, current_weapon) 
            SendNUIMessage({
                action = 'UPDATE_WEAPON',
                data = {
                  visibled = current_weapon ~= GetHashKey('WEAPON_UNARMED'),
                  munition = { current = current_weapon ~= GetHashKey('WEAPON_UNARMED') and current_ammo or 0, clip = current_weapon ~= GetHashKey('WEAPON_UNARMED') and (GetAmmoInPedWeapon(ped, current_weapon) - current_ammo) or 0 },
                  image = WeaponsHashs[current_weapon] and 'http://177.54.148.31:4020/lotus/inventario_tokyo/'..WeaponsHashs[current_weapon]..'.png' or ''
                }
            })

            BlockWeaponWheelThisFrame()
            DisableControlAction(0, 37, true)
            DisableControlAction(0, 199, true) 
            Wait(0)
        end
    end)
end)

RegisterNetEvent('sync:x1:position', function(data)
    local map = Config.X1.map
    if not map or PLAYER.IN_PVP then
        return
    end

    local spawns = map.spawns
    local ped = PlayerPedId()

    local x,y,z = spawns[currentPos].x, spawns[currentPos].y, spawns[currentPos].z
    RequestCollisionAtCoord(x,y,z)
    while not HasCollisionLoadedAroundEntity(ped) do
        RequestCollisionAtCoord(x,y,z)
        Citizen.Wait(1)
    end

    SetEntityHealth(ped, GetPedMaxHealth(ped))
    SetEntityCoords(ped, x,y,z)

    SendNUIMessage({
        action = 'updatePlayer1',
        data = data.owner_score
    })

    SendNUIMessage({
        action = 'updatePlayer2',
        data = data.invited_score
    })

    StartCountdown()
end)

function StartCountdown()
    local count = 5

    while count > 0 do
        FreezeEntityPosition(PlayerPedId(), true)
        SetLocalPlayerAsGhost(true)

        count = count - 1
        Wait(1000)
    end

    FreezeEntityPosition(PlayerPedId(), false)
    SetLocalPlayerAsGhost(false)
end

RegisterNetEvent('end:game:x1', function(data)
    SendNUIMessage({ action = 'open', data = false }) 

    IN_X1 = false

    local ped = PlayerPedId()
    RemoveAllPedWeapons(ped,true)

    SetEntityHealth(ped, PLAYER.enterHealth)
    SetEntityCoords(ped, PLAYER.enterCoords)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    SetLocalPlayerAsGhost(false)
end)

local death_plys = {}
AddEventHandler("gameEventTriggered", function(eventName, args)
    if eventName ~= "CEventNetworkEntityDamage" or not IN_X1 then
        return
    end

    local ped = PlayerPedId()
    local victim = args[1]
    local attacker = args[2]
    local weapon = args[7]

    -- ENVIANDO KILL FEED
    -- if IsPedAPlayer(attacker) and attacker == ped and not death_plys[victim] and GetEntityHealth(victim) <= 101 then
    --     SetEntityHealth(ped, GetPedMaxHealth(ped))
    --     vRP._giveWeapons({ [currentWeapon] = { ammo = 250 } }, true)
    --     RefillAmmoInstantly(ped)
    -- end

    -- Validando Morte
    if victim == ped and GetEntityHealth(ped) <= 101 or IsEntityDead(ped) then
        local hit, bone = GetPedLastDamageBone(victim)
        Execute._syncKillFeed({
            attacker = GetPlayerServerId(NetworkGetPlayerIndexFromPed(attacker)),
            victim = GetPlayerServerId(NetworkGetPlayerIndexFromPed(victim)),
            isHs = (bone == 31086),
            weapon = weapon,
            mode = PLAYER.MODE
        })

        local plyCds = GetEntityCoords(ped)
        NetworkResurrectLocalPlayer(plyCds.x, plyCds.y, plyCds.z, true, true, false)
    
        SetEntityHealth(PlayerPedId(), 300)

        vRP._giveWeapons({ [currentWeapon] = { ammo = 250 } }, true)
        RefillAmmoInstantly(ped)
        SetCurrentPedWeapon(ped, GetHashKey(currentWeapon), true)
        TriggerEvent('Weapon:Attachs')
    end
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CreateTunnel.sendX1Invite(data)
    PENDING_REQUEST = true

    SendNUIMessage({ 
        action = 'request',
        data = {
          name = data.owner_username, -- nome de quem convidou
          weapon = data.weapon, -- nome da arma do x1
          rounds = data.rounds, -- quantidade de rounds
          visibled = true, -- se a request vai ser visivel ou não
          bet = {
            makapoints = data.makapoints, -- se o valor da aposta é em makapoints ou não
            value = data.bet -- valor da aposta
          }
        }
    })
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('lotus_pvp:accept_x1', function()
    if PENDING_REQUEST then
        PENDING_REQUEST = false
        SendNUIMessage({ action = 'requestAccept' })
    end
end)

RegisterCommand('lotus_pvp:refuse_x1', function()
    if PENDING_REQUEST then
        PENDING_REQUEST = false
        SendNUIMessage({ action = 'requestRefused' })
    end
end)
RegisterKeyMapping('lotus_pvp:accept_x1', 'Lotus PVP - Aceitar X1', 'keyboard', 'Y')
RegisterKeyMapping('lotus_pvp:refuse_x1', 'Lotus PVP - Recusar X1', 'keyboard', 'U')

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNuiCallback('X1_INVITE', function(data, cb)
    SendNUIMessage({ action = 'open', data = false }) 
    SetNuiFocus(false, false)

    cb(Execute.requestCreateX1(data))
end)

RegisterNuiCallback('REQUEST_ACCEPT', function(data, cb)
    Execute._sendX1Status(true)
    cb(true)
end)

RegisterNuiCallback('REQUEST_REFUSED', function(data, cb)
    Execute._sendX1Status(false)
    cb(true)
end)

