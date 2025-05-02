local currentWeapon = nil
local currentLevel = 1
local loadWeapons = {}
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EVENTS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('join:game:gungame', function(data, time)
    local time = time
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(),true,true)

    local map = Config.Maps[data.map]
    if not map or PLAYER.IN_PVP then
        return
    end

    PLAYER.enterHealth = GetEntityHealth(PlayerPedId())
    PLAYER.enterCoords = GetEntityCoords(PlayerPedId())

    local spawns = map.spawns[data.mode]
    local random = math.random(#spawns)

    currentLevel = 1
    currentWeapon = Config.Gungame.weapons[currentLevel].weapon

    local ped = PlayerPedId()
    local x,y,z = spawns[random].x, spawns[random].y, spawns[random].z
    RequestCollisionAtCoord(x,y,z)
    while not HasCollisionLoadedAroundEntity(ped) do
        RequestCollisionAtCoord(x,y,z)
        Citizen.Wait(1)
    end

    SetLocalPlayerAsGhost(true)
    SetEntityHealth(ped, GetPedMaxHealth(ped))
    SetEntityCoords(ped, x,y,z)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.2)

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

    PLAYER.IN_PVP = true
    PLAYER.MODE = 'gungame'
    PLAYER.MAP = data.map

    loadWeapons = {}
    for i = currentLevel, math.min(currentLevel + 4, #Config.Gungame.weapons) do
        loadWeapons[#loadWeapons + 1] = 'http://177.54.148.31:4020/lotus/pvp/'..Config.Gungame.weapons[i].weapon..'.png'
    end

    SendNUIMessage({ action = 'open:hud', data = 'gungame' })
    SetNuiFocus(false, false)

    Wait(10)
    SendNUIMessage({ action = 'UPDATE_WEAPONS', data = { visibled = true, list = loadWeapons } })

    if time then
        SendNUIMessage({ action = 'UPDATE_TIME', data = time })
    end

    SetTimeout(2000, function()
        SetLocalPlayerAsGhost(false)
    end)

    CreateThread(function()
        local current_time = 1000
        while PLAYER.IN_PVP and PLAYER.MODE == 'gungame' do
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

            local spawns = map.spawns[PLAYER.MODE]
            local distAllSpawns = false
            for i = 1, #spawns do
                local spawn = spawns[i]

                if #(pedCoords - spawn) <= 80 then
                    distAllSpawns = true
                end
            end

            local pedWeapon = GetSelectedPedWeapon(ped)
            if pedWeapon ~= GetHashKey(currentWeapon) then
                vRP._giveWeapons({ [currentWeapon] = { ammo = 250 } }, true)
                SetCurrentPedWeapon(ped, GetHashKey(currentWeapon), true)
            end

            if not distAllSpawns then
                TriggerEvent('Notify', 'negado', 'Detectamos que você se afastou muito do pvp, então teleportamos você de volta.')
                SetEntityCoords(ped, spawns[random].x, spawns[random].y, spawns[random].z)
            end

            SetEntityInvincible(ped,false)
            SetEntityVisible(ped,true,false)

            Wait(1000)
        end
    end)

    CreateThread(function()
        while PLAYER.IN_PVP and PLAYER.MODE == 'gungame' do
            local ped = PlayerPedId()
            local current_weapon = GetSelectedPedWeapon(ped)
            local _,current_ammo = GetAmmoInClip(ped, current_weapon) 
            SendNUIMessage({
                action = 'UPDATE_WEAPON',
                data = {
                  visibled = current_weapon ~= GetHashKey('WEAPON_UNARMED'),
                  munition = { current = current_weapon ~= GetHashKey('WEAPON_UNARMED') and current_ammo or 0, clip = current_weapon ~= GetHashKey('WEAPON_UNARMED') and (GetAmmoInPedWeapon(ped, current_weapon) - current_ammo) or 0 },
                  image = WeaponsHashs[current_weapon] and 'http://177.54.148.31:4020/lotus/pvp/'..WeaponsHashs[current_weapon]..'.png' or ''
                }
            })

            BlockWeaponWheelThisFrame()
            DisableControlAction(0, 37, true)
            DisableControlAction(0, 199, true) 
            Wait(0)
        end
    end)
end)

local death_plys = {}
AddEventHandler("gameEventTriggered", function(eventName, args)
    if eventName ~= "CEventNetworkEntityDamage" or not PLAYER.IN_PVP or PLAYER.MODE ~= 'gungame' then
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
        RefillAmmoInstantly(ped)
    end

    -- Validando Morte
    if not death_plys[victim] and victim == ped and GetEntityHealth(ped) <= 101 or IsEntityDead(ped) then
        local hit, bone = GetPedLastDamageBone(victim)
        Execute._sendKillFeed({
            attacker = GetPlayerServerId(NetworkGetPlayerIndexFromPed(attacker)),
            victim = GetPlayerServerId(NetworkGetPlayerIndexFromPed(victim)),
            isHs = (bone == 31086),
            weapon = weapon,
            mode = PLAYER.MODE
        })

        local plyCds = GetEntityCoords(ped)
        NetworkResurrectLocalPlayer(plyCds.x, plyCds.y, plyCds.z, true, true, false)
         
        local map = Config.Maps[PLAYER.MAP]
        if not map then return end  

        local spawns = map.spawns[PLAYER.MODE]
        if not spawns then return end

        local random = math.random(#spawns) 
        SetEntityCoords(PlayerPedId(), spawns[random].x, spawns[random].y, spawns[random].z)
        SetEntityHealth(PlayerPedId(), 300)

        vRP._giveWeapons({ [currentWeapon] = { ammo = 250 } }, true)
        RefillAmmoInstantly(ped)
        SetCurrentPedWeapon(ped, GetHashKey(currentWeapon), true)
        TriggerEvent('Weapon:Attachs')
    end

    -- Evitar KILLS Duplicadas
    if victim then
        death_plys[victim] = true

        SetTimeout(1000, function()
            death_plys[victim] = nil
        end)
    end
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CreateTunnel.updateWeapon(playerKills)
    for i = 1, #Config.Gungame.weapons do
        if playerKills >= Config.Gungame.weapons[i].current_kills then
            currentWeapon = Config.Gungame.weapons[i].weapon
            currentLevel = i
        end
    end 

    loadWeapons = {}
    for i = currentLevel, math.min(currentLevel + 4, #Config.Gungame.weapons) do
        if Config.Gungame.weapons[i] then
            loadWeapons[#loadWeapons + 1] = 'http://177.54.148.31:4020/lotus/pvp/'..Config.Gungame.weapons[i].weapon..'.png'
        end
    end
    SendNUIMessage({ action = 'UPDATE_WEAPONS', data = { visibled = true, list = loadWeapons } })
end

