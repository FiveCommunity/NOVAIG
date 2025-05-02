local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')

ClientAPI = {}
Tunnel.bindInterface(GetCurrentResourceName(), ClientAPI)
ServerAPI = Tunnel.getInterface(GetCurrentResourceName())

local props = {}
local doorsLocked = {}
local isScaping = false

---@param model string
---@return void
local function loadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(1)
    end
end

---@param model string
---@param coords vector3
---@return void
local function spawnObject(model, coords)
    loadModel(model)
    local obj = CreateObject(model, coords.x, coords.y, coords.z, false, true, false)
    while not DoesEntityExist(obj) do
        Wait(1)
    end
    Wait(100)
    SetEntityAsMissionEntity(obj, true, true)
    SetEntityInvincible(obj, true)
    PlaceObjectOnGroundProperly(obj)
    SetModelAsNoLongerNeeded(model)
    SetTimeout(10000, function()
        FreezeEntityPosition(obj, true)
    end)
    return obj
end

---@param obj number
---@return void
local function deleteObject(obj)
    if DoesEntityExist(obj) then
        DeleteObject(obj)
    end
end

---@param x number
---@param y number
---@param z number
---@param text string
---@return void
local function drawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

---@param animDict string
---@param animName string
---@param duration number
---@return void
local function playAnimation(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(1)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, -8.0, duration, 1, 0, false, false, false)
    Wait(duration)
    ClearPedTasks(PlayerPedId())
end

---@param trashIndex number
---@return void
local function collectTrash(trashIndex)
    playAnimation('amb@prop_human_bum_bin@idle_b', 'idle_d', 3000)
    ServerAPI.collectTrash(trashIndex)
end

---@param escapeIndex number
---@return void
local function escapePrison(escapeIndex)
    playAnimation('amb@prop_human_bum_bin@idle_b', 'idle_d', 5000)
    ServerAPI.escapePrison(escapeIndex)
end

---@param craftIndex number
---@return void
local function craftItem(craftIndex)
    playAnimation('amb@prop_human_bum_bin@idle_b', 'idle_d', 5000)
    ServerAPI.craftItem(craftIndex)
end

---@param doorIndex number
---@param locked boolean
---@return void
local function toggleDoorLock(doorIndex, locked)
    local doorHash = Config.Doors[doorIndex].hash
    local coords = Config.Doors[doorIndex].coords

    local door = GetClosestObjectOfType(coords.x, coords.y, coords.z, 5.0, doorHash, false, false, false)
    
    if door ~= 0 then
        AddDoorToSystem(doorIndex, doorHash, coords)

        local lockState = locked and 1 or 0
    
        DoorSystemSetDoorState(k, lockState)
        FreezeEntityPosition(door, (lockState == 1 and true or false))

        doorsLocked[doorIndex] = locked
    else
        print("Porta não encontrada nas coordenadas especificadas.")
    end
end


---@param coords vector3
---@return void
function ClientAPI.addTracker(coords)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 362)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 1)
    SetBlipAsShortRange(blip, false)
    SetBlipHighDetail(blip, true) 
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Fugitivo')
    EndTextCommandSetBlipName(blip)
    SetTimeout(30000, function()
        RemoveBlip(blip)
    end)
end

CreateThread(function()
    while true do
        local timeDistance = 1000
        local ped = PlayerPedId()
        
        if not LocalPlayer.state.isInPrison then
            for i = 1, #props do
                deleteObject(props[i])
            end
        else
            local coords = GetEntityCoords(ped)
            
            for i = 1, #Config.TrashLocations do
                if not props[i] or not DoesEntityExist(props[i]) then
                    props[i] = spawnObject(Config.TrashProp, Config.TrashLocations[i])
                end

                local trashCoords = GetEntityCoords(props[i])
                local distance = #(coords - trashCoords)
                if distance <= 10.0 then
                    timeDistance = 0
                    drawText3D(trashCoords.x, trashCoords.y, trashCoords.z + 1.0, '~g~[E] ~w~Coletar Lixo')
                    if distance <= 2.0 and IsControlJustPressed(0, 38) then
                        collectTrash(i)
                    end
                end
            end

            for i = 1, #Config.EscapeLocations do
                local escapeCoords = Config.EscapeLocations[i]
                local distance = #(coords - escapeCoords)
                if distance <= 2.0 then
                    timeDistance = 0
                    drawText3D(escapeCoords.x, escapeCoords.y, escapeCoords.z, '~g~[E] ~w~Escapar')
                    if IsControlJustPressed(0, 38) then
                        escapePrison(i)
                    end
                end
            end

            for i = 1, #Config.CraftLocations do
                local craftCoords = Config.CraftLocations[i]
                local distance = #(coords - craftCoords)
                if distance <= 2.0 then
                    timeDistance = 0
                    drawText3D(craftCoords.x, craftCoords.y, craftCoords.z, '~g~[E] ~w~Craftar')
                    if IsControlJustPressed(0, 38) then
                        craftItem(i)
                    end
                end
            end
        end

        Wait(timeDistance)
    end
end)

CreateThread(function()
    while true do
        local timeDistance = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        
        if LocalPlayer.state.isInPrison then
            for i = 1, #Config.Doors do
                local doorCoords = Config.Doors[i].coords
                local distance = #(coords - doorCoords)
                if distance <= 30.0 then
                    toggleDoorLock(i, true)
                end
            end
        else
            for i = 1, #Config.Doors do
                local doorCoords = Config.Doors[i].coords
                local distance = #(coords - doorCoords)
                if distance <= 30.0 then
                    if doorsLocked[i] then
                        toggleDoorLock(i, false)
                    end
                end
            end
        end

        Wait(timeDistance)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() ~= resource then return end
    for i = 1, #props do
        deleteObject(props[i])
    end
end)