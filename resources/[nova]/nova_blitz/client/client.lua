local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

ClientAPI = {}
Tunnel.bindInterface(GetCurrentResourceName(), ClientAPI)
ServerAPI = Tunnel.getInterface(GetCurrentResourceName())

local spawnedObject = nil
local isPlacingObject = false
local heading = 0

function LoadModel(model)
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(500)
        end
        return true
    end
    return false
end

function GetCoordsFromCam(distance)
    local camRot = GetGameplayCamRot(2)
    local camCoord = GetGameplayCamCoord()
    local adjustedRot = vector3(
        math.rad(camRot.x),
        math.rad(camRot.y),
        math.rad(camRot.z)
    )
    local direction = vector3(
        -math.sin(adjustedRot.z) * math.abs(math.cos(adjustedRot.x)),
        math.cos(adjustedRot.z) * math.abs(math.cos(adjustedRot.x)),
        math.sin(adjustedRot.x)
    )
    return camCoord + (direction * distance)
end

function startPlacingObject(objectModel)
    if not LoadModel(objectModel) then return end

    isPlacingObject = true
    heading = 0

    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    spawnedObject = CreateObject(objectModel, coords.x, coords.y, coords.z, false, false, false)
    SetEntityAlpha(spawnedObject, 100, false)
    SetEntityCollision(spawnedObject, false, false)

    CreateThread(function()
        while isPlacingObject do
            Wait(0)

            DisableControlAction(0, 37, true)
            DisableControlAction(0, 14, true)
            DisableControlAction(0, 15, true)

            local camCoords = GetGameplayCamCoord()
            local hitCoords = GetCoordsFromCam(30.0)
            local _, hit, posX, posY, posZ = GetShapeTestResult(StartShapeTestRay(camCoords.x, camCoords.y, camCoords.z, hitCoords.x, hitCoords.y, hitCoords.z, -1, playerPed, 0))

            if hit then
                SetEntityCoords(spawnedObject, posX, posY, posZ, false, false, false, true)
                SetEntityHeading(spawnedObject, heading + 0.0)
                DrawMultiLineText3D(posX, {
                    "~g~E~w~ para confirmar",
                    "~g~C~w~ para cancelar",
                    "~y~Scroll~w~ para rotacionar"
                })
            end

            if IsControlJustPressed(1, 241) then
                heading = heading + 5
                if heading > 360 then
                    heading = 0
                end
            elseif IsControlJustPressed(1, 242) then
                heading = heading - 5
                if heading < 0 then
                    heading = 360
                end
            end

            if IsControlJustPressed(1, 38) then
                local finalPos = GetEntityCoords(spawnedObject)
                confirmPlacement(objectModel, finalPos, heading)
            end

            if IsControlJustPressed(1, 26) then
                cancelPlacement()
            end
        end
    end)
end

function confirmPlacement(objectModel, finalPos, heading)
    DeleteObject(spawnedObject)
    spawnedObject = nil
    isPlacingObject = false
    
    if LoadModel(objectModel) then
        local object = CreateObject(objectModel, finalPos.x, finalPos.y, finalPos.z, true, true, true)
        local netId = ObjToNet(object)
        SetModelAsNoLongerNeeded(objectModel)
        NetworkRegisterEntityAsNetworked(object)
        SetNetworkIdExistsOnAllMachines(netId, true)
        SetNetworkIdCanMigrate(netId, true)
        SetEntityHeading(object, heading + 0.0)
        SetEntityAsMissionEntity(object, true, true)
        FreezeEntityPosition(object, true)
        PlaceObjectOnGroundProperly(object)
    end
end

function cancelPlacement()
    if spawnedObject then
        DeleteObject(spawnedObject)
        spawnedObject = nil
    end
    isPlacingObject = false
end

function DrawMultiLineText3D(coords, texts)
    local lineSpacing = 0.2
    for i, text in ipairs(texts) do
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        SetDrawOrigin(coords.x, coords.y, coords.z - ((i - 1) * lineSpacing), 0)
        DrawText(0.0, 0.0)
    end
end

function openMenu()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'open' })
end

function closeMenu()
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })
end

function ClientAPI.openMenu()
    openMenu()
end

RegisterNUICallback('PUT_ITEM', function(data, cb)
    local object = data
    if Config.Props[object] then
        closeMenu()
        startPlacingObject(Config.Props[object])
    end
    cb(true)
end)

RegisterNUICallback('REMOVE_ITEM', function(data, cb)
    local objectModel = Config.Props[data]
    if objectModel then
        local playerPed = PlayerPedId()
        local pos = GetEntityCoords(playerPed)
        local closestObject = GetClosestObjectOfType(pos.x, pos.y, pos.z, 3.0, objectModel, false, false, false)
        
        if DoesEntityExist(closestObject) then
            ServerAPI.removeObject(ObjToNet(closestObject))
        end
    end
    cb(true)
end)

RegisterNUICallback('CLOSE', function(data, cb)
    closeMenu()
    cb(true)
end)