state = {
    isOpen = false,
    camera = nil
}

Citizen.CreateThread(function ()
    print('Script iniciado.')
end)

RegisterNUICallback('close', function(_, cb) cb(false) end)

RegisterNUICallback('getSpawns', function(data, cb)
    local hasOrg, indexOrg = Remote.getOrg()
    local spawnData = {
        hasOrg = hasOrg,
        spawns = Config.Spawns
    }
    cb(spawnData)
end)

RegisterNUICallback('spawn', function(data, cb)
    local spawn = data.spawn
    _G.Teleporting = true
    StartFade()
    -- vRP._teleport(spawn.coords[1], spawn.coords[2], spawn.coords[3])
    CloseUi()
    Citizen.Wait(1300)
    SetEntityCoords(PlayerPedId(), spawn.coords[1], spawn.coords[2], spawn.coords[3])

    Citizen.Wait(1000)
    EndFade()
    TriggerEvent("flaviin:toggleHud",true)

    SetTimeout(10*1000,function()
		local ped = PlayerPedId()
		SetEntityHealth(ped,300)
	end)
    cb(true)
end)


RegisterNUICallback('lastSpawn', function(data, cb)
    local data = Remote.GetUserData()
    if not data or not data.position then
        cb(false)
        return
    end
    _G.Teleporting = true

    print(data.position,'linha 51')

    local position = data and {data.position.x, data.position.y, data.position.z} or {x = -425.07, y = 1125.78, z = 325.86}
    StartFade()
    -- vRP._teleport(position[1],position[2],position[3])
    CloseUi()
    Citizen.Wait(1300)

    SetEntityCoords(PlayerPedId(), position[1], position[2], position[3])
    
    Citizen.Wait(1000)
    EndFade()
	TriggerEvent("flaviin:toggleHud",true)
    
    SetFocusEntity(PlayerPedId())
    CreateThread(function()
        Wait(3000)
        TriggerEvent('checkIsInDomination')
    end)

    SetTimeout(10*1000,function()
		local ped = PlayerPedId()
		SetEntityHealth(ped,300)
	end)

    cb(true)
end)

RegisterNUICallback('org', function(data, cb)
    local hasOrg, indexOrg = Remote.getOrg()
    if hasOrg then
        local spawn = Config.Orgs_Spawns[indexOrg]
    _G.Teleporting = true

        StartFade()
        -- vRP._teleport(spawn[1], spawn[2], spawn[3])
        CloseUi()
        Citizen.Wait(1300)

        SetEntityCoords(PlayerPedId(), spawn[1], spawn[2], spawn[3])

        Citizen.Wait(1000)
        EndFade()
        TriggerEvent("flaviin:toggleHud",true)

        SetTimeout(10*1000,function()
            local ped = PlayerPedId()
            SetEntityHealth(ped,300)
        end)
    end
    cb(true)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLE LOGIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vrp:ToogleLoginMenu')
AddEventHandler('vrp:ToogleLoginMenu', function()
    if not state.isOpen then
        OpenUi()
    else
        CloseUi()
    end
end)
