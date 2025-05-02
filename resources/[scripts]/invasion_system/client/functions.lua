-- Utility functions
function createAreaBlip(x, y, z, width, height, heading, color, alpha, highDetail, display, shortRange)
    local blip = AddBlipForArea(x or 0.0, y or 0.0, z or 0.0, width or 100.0, height or 100.0)
    
    SetBlipColour(blip, color or 1)
    SetBlipAlpha(blip, alpha or 80) 
    SetBlipHighDetail(blip, highDetail or true)
    SetBlipRotation(blip, heading or 0.0)
    SetBlipDisplay(blip, display or 4)
    SetBlipAsShortRange(blip, shortRange or true)

    return {
        handle = blip,
        pos = vector3(x or 0.0, y or 0.0, z or 0.0),
        width = width or 100.0,
        height = height or 100.0,
        heading = heading or 0.0,
        color = color or 1,
        alpha = alpha or 80,
        display = display or 4,
        highDetail = highDetail or true
    }
end

function showMe3D(x,y,z,text,h,back,color,opacity)

    SetTextFont(4)
	SetTextCentre(1)
	SetTextEntry("STRING")
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z,0)
	DrawText(0.0,0.0)
	--local factor = (string.len(text) / 375) + 0.01
	--DrawRect(0.0,0.0125,factor,0.03,38,42,56,200)
	ClearDrawOrigin()
end

function drawText(text, font, x, y, scale, r, g, b, a, centre)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextOutline()
    if centre then SetTextCentre(1) end
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(x, y)
end

function rayCastCamera(flags, ignore, distance)
    local coords, normal = GetWorldCoordFromScreenCoord(0.5, 0.5)
    local destination = coords + normal * (distance or 1000)
    local handle = StartShapeTestLosProbe(
        coords.x, coords.y, coords.z,
        destination.x, destination.y, destination.z,
        flags or 511, PlayerPedId(), ignore or 4
    )

    while true do
        Wait(0)
        local retval, hit, endCoords, surfaceNormal, materialHash, entityHit = GetShapeTestResultIncludingMaterial(handle)
        if retval ~= 1 then
            return hit, entityHit, endCoords, surfaceNormal, materialHash
        end
    end
end

-- Control blocking
function clientAPI.blockControls(status, spawnPoint)
    blocked = status
    CreateThread(function()
        while blocked do
            local ped = PlayerPedId()
            BlockWeaponWheelThisFrame()
            DisablePlayerFiring(PlayerId(), true)
            SetEntityInvincible(ped, true)
            
            DrawMarker(1, spawnPoint[1], spawnPoint[2], spawnPoint[3]-1.5, 
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
                6.0, 6.0, 1.0, 
                255, 165, 0, 100, 
                false, true, 2, false, nil, nil, false)

            local coords = GetEntityCoords(ped)
            local distance = #(coords - vector3(spawnPoint[1], spawnPoint[2], spawnPoint[3]))
            
            if distance > 3 then
                SetEntityCoords(ped, spawnPoint[1], spawnPoint[2], spawnPoint[3])
            end

            if not blocked then break end
            Wait(0)
        end
        SetEntityInvincible(PlayerPedId(), false)
    end)
end

-- Combat system
local meeleWeapons = {
    ["0"] = true,
    ["WEAPON_UNARMED"] = true,
    ["WEAPON_RUN_OVER_BY_CAR"] = true,
    ["WEAPON_RAMMED_BY_CAR"] = true,
    ["WEAPON_VEHICLE_ROTORS"] = true,
    ["WEAPON_DAGGER"] = true,
    ["WEAPON_BAT"] = true,
    ["WEAPON_BOTTLE"] = true,
    ["WEAPON_CROWBAR"] = true,
    ["WEAPON_FLASHLIGHT"] = true,
    ["WEAPON_GOLFCLUB"] = true,
    ["WEAPON_HAMMER"] = true,
    ["WEAPON_HATCHET"] = true,
    ["WEAPON_KNUCKLE"] = true,
    ["WEAPON_KNIFE"] = true,
    ["WEAPON_MACHETE"] = true,
    ["WEAPON_SWITCHBLADE"] = true,
    ["WEAPON_NIGHTSTICK"] = true,
    ["WEAPON_WRENCH"] = true,
    ["WEAPON_BATTLEAXE"] = true,
    ["WEAPON_POOLCUE"] = true,
    ["WEAPON_STONE_HATCHET"] = true,
    ["WEAPON_GRENADE"] = true,
    ["WEAPON_BZGAS"] = true,
    ["WEAPON_MOLOTOV"] = true,
    ["WEAPON_STICKYBOMB"] = true,
    ["WEAPON_PROXMINE"] = true,
    ["WEAPON_SNOWBALL"] = true,
    ["WEAPON_PIPEBOMB"] = true,
    ["WEAPON_BALL"] = true,
    ["WEAPON_SMOKEGRENADE"] = true,
    ["WEAPON_FLARE"] = true,
    ["WEAPON_PETROLCAN"] = true,
    ["WEAPON_PARACHUTE"] = true,
    ["WEAPON_FIREEXTINGUISHER"] = true,
    ["WEAPON_HAZARDCAN"] = true
}

local timeout = 0
-- Event handlers
AddEventHandler('gameEventTriggered', function(event, args)
    if event ~= 'CEventNetworkEntityDamage' or not state.isInInvasion then return end

    local victim = args[1]
    local attacker = args[2]

    if not IsEntityAPed(victim) then return end

    local ped = PlayerPedId()
    local gameTimer = GetGameTimer()

    if victim == ped and timeout < gameTimer then
        local source = -1
        local weapon = "0"

        if DoesEntityExist(attacker) and IsPedAPlayer(attacker) and attacker ~= victim then
            source = GetPlayerServerId(NetworkGetPlayerIndexFromPed(attacker))
            weapon = ({GetCurrentPedWeapon(attacker)})[2]
        end

        local _, bone = GetPedLastDamageBone(ped)
        if (bone and bone == 31086 and not meeleWeapons[weapon]) or GetEntityHealth(ped) <= 101 then
            if state.isInInvasion then
                state.isInInvasion = false
                timeout = gameTimer + 500
                SetEntityHealth(PlayerPedId(), 100)
                
                local coords = GetEntityCoords(ped)
                SetNuiFocus(false, false)
                SendNUIMessage({action = 'open:hud'})
                TriggerServerEvent('invasion_system:playerKilled', source, {
                    weaponhash = weapon,
                    killerpos = coords
                })
            end
        end
    end
end)

RegisterNetEvent('invasion_system:killFeed')
AddEventHandler('invasion_system:killFeed', function(victim, killer)
    if type(victim) ~= 'string' then return end
    SendNUIMessage({
        action = 'killNotification',
        data = {name1 = killer, name2 = victim}
    })
end)

RegisterNetEvent('invasion_system:winNotify')
AddEventHandler('invasion_system:winNotify', function()
    SendNUIMessage({action = 'winMessage', data = true})
    SetTimeout(10000, function()
        SendNUIMessage({action = 'winMessage', data = false})
    end)
end)

RegisterNetEvent('invasion_system:winningNotify')
AddEventHandler('invasion_system:winningNotify', function(team)
    if type(team) ~= 'string' then return end
    SendNUIMessage({
        action = 'winningTeam',
        data = {show = true, team = tostring(team)}
    })
    SetTimeout(10000, function()
        SendNUIMessage({action = 'winningTeam', data = {show = false}})
    end)
end)

AddEventHandler('onResourceStop', function(resourceName)
    if Resource ~= resourceName then return end
    
    SetNuiFocus(false, false)
    SendNUIMessage({action = 'open:hud'})
    SendNUIMessage({action = 'scoreboard', data = {show = false}})
    
    if NetworkIsInSpectatorMode() then
        NetworkSetInSpectatorMode(false)
    end
end)