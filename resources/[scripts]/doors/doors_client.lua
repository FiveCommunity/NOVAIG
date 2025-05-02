local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
srcDoors = {}
Tunnel.bindInterface(GetCurrentResourceName(),srcDoors)
vSERVERdoors = Tunnel.getInterface(GetCurrentResourceName())
local sprites = {
    [0] = { 'mpsafecracking', 'lock_open', 0, 0, 0.018, 0.018, 0, 0, 255, 0, 255 },
    [1] = { 'mpsafecracking', 'lock_closed', 0, 0, 0.018, 0.018, 0, 255, 0, 0, 255 },
}

local nearestLocks = {}
local closestLocks = {}
local doorData = {}
local tempData = {}
local delay = false
local doors = {}

local loadDoors = function()
    for key,lockable in pairs(doors) do
        local isGate, dist, text, lock, hash, x, y, z, perm in lockable
        local identifier = ([[%s_%s]]):format(key, perm)
        local state = (lock and 4 or 0)
        lockable.identifier = identifier
        AddDoorToSystem(identifier, hash, x, y, z, false, false, false)
        DoorSystemSetDoorState(identifier, state, false, false)
    end
end

RegisterNetEvent('doors:load', function(lockList)
    for k, lock in pairs(lockList) do
        print("Key:", k, "Lock status:", lock)
        if doors[k] then
            doors[k].lock = lock
        else
            print("Porta não encontrada para o ID:", k)
        end
    end
    loadDoors()
end)


RegisterNetEvent('door', function(id, unk)
    local door = doors[id]
    if door then
        local status = (unk and 2 or 0)
        DoorSystemSetDoorState(door.identifier, status, false, false)
        door.lock = unk or false
    end
end)

RegisterNetEvent('doors:loadall')
AddEventHandler('doors:loadall', function(listdoors)
    doors = listdoors
end)

local function getClosestLock(playerCoords)
    local closestLocks = {}
    for key, lockable in pairs(doors) do
        local dist, x, y, z in lockable
        local playerDistance = #(playerCoords - vec3(x, y, z))
        if playerDistance <= dist then
            lockable.key = key
            closestLocks[#closestLocks+1] = lockable
        end
    end
    return closestLocks
end

local function drawSprite(lockCoords, sprite)
    SetDrawOrigin(lockCoords.x, lockCoords.y, lockCoords.z)
    DrawSprite(sprite[1], sprite[2], sprite[3], sprite[4], sprite[5], sprite[6] * GetAspectRatio(true), sprite[7], sprite[8], sprite[9], sprite[10], sprite[11])
    ClearDrawOrigin()
end

local drawInteraction = function()
    RequestStreamedTextureDict(sprites[0][1], true)
    RequestStreamedTextureDict(sprites[1][1], true)

    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        local closestLocks = getClosestLock(playerCoords)
        local delay = (#closestLocks > 0 and 0 or 500)

        if (closestLocks) then
            for key, lockable in pairs(closestLocks) do 
                local x, y, z, dist, lock in lockable
                local lockCoords = vec3(x, y, z)
                local lockState = (lock and 1 or 0)
                local sprite = sprites[lockState]
                drawSprite(lockCoords, sprite)          
            end
        end
        Wait(delay)
    end
end
local isAddingDoorlock = false

srcDoors.rayCastDoor = function()
    local rayCastCam = function(flags, ignore, distance)
        local coords, normal = GetWorldCoordFromScreenCoord(0.5, 0.5)
        local destination = coords + normal * (distance or 20)
        local handle = StartShapeTestLosProbe(coords.x, coords.y, coords.z, destination.x, destination.y, destination.z, flags or 511, PlayerPedId(), ignore or 4)
    
        while true do
            Wait(0)
    
            local retval, hit, endCoords, surfaceNormal, materialHash, entityHit = GetShapeTestResultIncludingMaterial(handle)
    
            if retval ~= 1 then
                return hit, entityHit, endCoords, surfaceNormal, materialHash
            end
        end
    end
    isAddingDoorlock = true
    repeat
        DisablePlayerFiring(PlayerId(), true)
        DisableControlAction(0, 25, true)

        local hit, entity, coords = rayCastCam(1|16)
        local changedEntity = lastEntity ~= entity
        local doorA = tempData[1]?.entity

        if changedEntity and lastEntity ~= doorA then
            SetEntityDrawOutline(lastEntity, false)
        end

        lastEntity = entity

        if hit then
            DrawMarker(28, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 42, 24, 100, false, false, 0, true, false, false, false)
        end

        if hit and entity > 0 and GetEntityType(entity) == 3 and (doorA ~= entity) then
            if changedEntity then
                SetEntityDrawOutline(entity, true)
            end

            if IsDisabledControlJustPressed(0, 24) then
                isAddingDoorlock = false
                local doorCoords = GetEntityCoords(entity)
                local data = {
                    coords = {
                        x = doorCoords.x,
                        y = doorCoords.y,
                        z = doorCoords.z,
                    },
                    hash = GetEntityModel(entity)
                }
                SetEntityDrawOutline(entity, false)
                return data
            end
        end

        if IsDisabledControlJustPressed(0, 25) then
            SetEntityDrawOutline(entity, false)

            if not doorA then
                isAddingDoorlock = false
                return
            end

            SetEntityDrawOutline(doorA, false)
            table.wipe(tempData)
        end
    until not isAddingDoorlock
end

RegisterKeyMapping("synclock1","Trancar / Destrancar","keyboard","e")
local syncLock1 = function(source,args)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local closestLocks = getClosestLock(playerCoords)
    if (#closestLocks == 0) then return end
    
    for key, lockable in pairs(closestLocks) do 
        TriggerServerEvent('tryLockDoor', lockable.key)
    end
end

RegisterCommand('synclock1', syncLock1)
CreateThread(drawInteraction)
