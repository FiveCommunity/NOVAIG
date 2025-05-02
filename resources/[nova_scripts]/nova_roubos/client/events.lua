local isNear = false

local meeleWeapons = {
    ["0"] = true,
    ["WEAPON_UNARMED"] = true,
    ["WEAPON_RUN_OVER_BY_CAR"] = true,
    ["WEAPON_RAMMED_BY_CAR"] = true,
    ["VEHICLE_WEAPON_ROTORS"] = true,
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

AddEventHandler('gameEventTriggered', function(event, args)
    if event ~= 'CEventNetworkEntityDamage' and not ActualRobbery then return end
    local data = {
        victim = args[1],
        attacker = args[2]
    }
    if IsEntityAPed(data.victim) then
        local ped = PlayerPedId()
        local gameTimer = GetGameTimer()
        if data.victim == ped and timeout < gameTimer then
            local source = -1
            local weapon = "0"
            if DoesEntityExist(data.attacker) and IsPedAPlayer(data.attacker) and data.attacker ~= data.victim then
                source = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.attacker))
                weapon = ({GetCurrentPedWeapon(data.attacker)})[2]
            end
            local _, bone = GetPedLastDamageBone(ped)
            -- 31086 é o bone ID para SKEL_Head
            if (bone and bone == 31086 and not meeleWeapons[weapon]) or GetEntityHealth(ped) <= 101 then
                if isInRobbery then
                    timeout = gameTimer + 500
                    SetEntityHealth(PlayerPedId(),100)
                    local coords = GetEntityCoords(ped)
                    OpenNUI({ action = 'ClosePainel' }, false)
                    CloseNUI()
                    TriggerServerEvent('nova_roubos:playerKilled', source, {weaponhash = weapon, killerpos = coords})
                    isAlive = false
                end
            end
        end
    end
end)


----==={ KILL FEED }===---- 
        
RegisterNetEvent('killfeed', function(victim, reason, killer, team, team2)
    if type(victim) ~= 'string' or type(reason) ~= 'string' then 
        return 
    end
    
    local myTeam = tostring(vSERVER.GetMyTeam(ActualRobbery) or '')
    if team == "cops" then 
        team = "Policial"
    elseif team2 == "cops" then 
        team2 = "Policial"
    end
    local data = {
        type = killer and 'kill' or 'death',
        victim = { name = tostring(team), team = tostring(team) },
        icon = tostring(reason),
        myteam = myTeam,
        action = 'KillFeed'
    }

    if killer then
        data.killer = { name = tostring(team2), team = tostring(team2) }
    end

    OpenNUI(data, false)
end)

----==={ WINNER NOTIFY }===----
        
RegisterNetEvent('winnernotify', function(team)
    if type(team) ~= 'string' then return end
    OpenNUI({ action = 'WinnerNotify', winner = tostring(team) }, false)
end)

----==={ NOTIFY }===----
RegisterNetEvent('nova_roubos:robnotify', function(style,content,sleep)
    local styles = { negado = true, sucesso = true, aviso = true, importante = true } 
    if not styles[style] or not content then return end 
    sleep = tonumber(sleep) or 8000
    OpenNUI({ style = style, content = content, sleep = sleep, action = 'NotifyMessage' }, false)
end)
