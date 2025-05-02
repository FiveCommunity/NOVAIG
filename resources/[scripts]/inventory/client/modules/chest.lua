local openChest = {}
-- local Chests = {}

local InSoloSession = false

RegisterNetEvent("openChestGroup", function(data)
    -- received by the server just to facilitate requireChest. Even bypassing GetInvokingResource, illegal execution will do nothing
    if GetInvokingResource() then return end
    local response = Remote.requireChest( "GROUP", false, data )
    if response then
        response.chest_type = 'GROUP'
        SendNUIMessage({
            route   = "OPEN_CHEST",
            payload = response
        })
        SetNuiFocus(true, true)
    end
end)

function API.SearchChest()
    local ply     = PlayerPedId()
    local plyCds  = GetEntityCoords(ply)
    local vehicle = getClosestVeh()
    local args    = {}
    if InSoloSession then
        return false
    end
    if vehicle and GetVehicleDoorLockStatus(vehicle) == 1 then
        local vehCds = GetEntityCoords(vehicle)

        args = { "VEHICLE", VehToNet(vehicle), _ }
        openChest = { coords = vehCds }
    else
        for k, v in pairs(Chests) do
            if #(v.coords - plyCds) <= 2.0 then
                args = { "GROUP", false, k }
                openChest = v
            end
        end
    end
    if #args == 0 then
        return
    end
    local response = Remote.requireChest(table.unpack(args))
    if response then
        response.chest_type = args[1]
        SendNUIMessage({
            route   = "OPEN_CHEST",
            payload = response
        })
        SetNuiFocus(true, true)
        if response.chest_type == "GROUP" or response.chest_type == "VEHICLE" then
            CreateThread(function()
                while IsNuiFocused() do
                    if not API.checkChestDistance() then
                        break
                    end
                    Wait(1000)
                end
            end)
        end
    end
end

RegisterNetEvent("abrirpm:Open", function(data) 
    SendNUIMessage({
        route   = "OPEN_CHEST",
        payload = response
    })
    SetNuiFocus(true, true)
end)

RegisterNetEvent("openChestVehicle", function(data)
    -- received by the server just to facilitate requireChest. Even bypassing GetInvokingResource, illegal execution will do nothing
    if GetInvokingResource() then return end
    RequestModel(GetHashKey(data[1]))
    while not HasModelLoaded(GetHashKey(data[1])) do
        Wait(1)
    end
    local vehicle = CreateVehicle(GetHashKey(data[1]), GetEntityCoords(PlayerPedId()), true, true)
    -- SetEntityVisible(vehicle, false, false)
    FreezeEntityPosition(vehicle, true)
    SetVehicleNumberPlateText(vehicle, data[2])
    local response = Remote.requireChest( "VEHICLE", VehToNet(vehicle), _, true)
    if response then
        SetNuiFocus(true, true)
        response.chest_type = 'VEHICLE'
        SendNUIMessage({
            route   = "OPEN_CHEST",
            payload = response
        })
        while IsNuiFocused() do
            Wait(1000)
        end
        Wait(5000)
        if DoesEntityExist(vehicle) then
            -- print("[Info] Closing /abrirpm")
            DeleteEntity(vehicle)
            SetNuiFocus(false, false)
        end
    end
end)

RegisterNetEvent("mirt1n:myHouseChest", function(_, id, maxBau)
    assert(GetInvokingResource() == nil, "This event can only be called from server");
    local response = Remote.requireChest("HOUSE", maxBau, id)
    if response then
        response.chest_type = "HOUSE"
        SendNUIMessage({
            route   = "OPEN_CHEST",
            payload = response
        })
        SetNuiFocus(true, true)
    end
end)

RegisterNetEvent("Warehouses:Chest", function(_, id, maxBau)
    assert(GetInvokingResource() == nil, "This event can only be called from server");
    local response = Remote.requireChest("WAREHOUSES", maxBau, id)
    if response then
        response.chest_type = "WAREHOUSES"
        SendNUIMessage({
            route   = "OPEN_CHEST",
            payload = response
        })
        SetNuiFocus(true, true)
    end
end)

local LAST_COMMAND_EXECUTION = GetGameTimer()
RegisterCommand("openchestlotus", function()
    if LocalPlayer.state.pvp or vRP.isHandcuffed() or (GetEntityHealth(PlayerPedId()) <= 101) then
        TriggerEvent("Notify", "negado", "Você não pode acessar seu inventario agora.")
        return
    end

    if GetGameTimer() - LAST_COMMAND_EXECUTION < 2000 then
        TriggerEvent("Notify", "negado", "Espere um pouco para executar este comando novamente.")
        return
    end
    API.SearchChest()
end)

CreateThread(function()
    SetNuiFocus(false, false)
    while true do
        local msec = 3000
        local ply = PlayerPedId()
        local plyCoords = GetEntityCoords(ply)
        for k, v in pairs(Chests) do
            local distance = #(v.coords - plyCoords)
            if distance < 10.0 then
                msec = 4
                DrawMarker(20, v.coords - vec3(0.0, 0.0, 0.4), 0, 0, 0, 0, 180.0, 0, 0.7, 0.7, 0.7, 254, 56, 0, 75, 1,
                    0,
                    0, 1)
                if distance < 1.3 and IsControlJustPressed(0, 38) then
                    ExecuteCommand('openchestlotus')
                    Wait(1000)
                end
            end
        end
        Wait(msec)
    end
end)


CreateThread(function()
    RegisterKeyMapping("openchestlotus", "Abrir baú ~", "keyboard", "PAGEUP")
end)








---
-- Helper functions
---
function getClosestVeh()
    local plyPed    = PlayerPedId()
    local actualVeh = GetVehiclePedIsIn(plyPed, false)
    if actualVeh > 0 then return actualVeh end
    local plyPos              = GetEntityCoords(plyPed, false)
    local plyOffset           = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.0, 0.0)
    local radius              = 0.8
    local rayHandle           = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset
        .z, radius, 10, plyPed, 7)
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)

    return vehicle
end

function API.checkChestDistance()
    local ply    = PlayerPedId()
    local plyCds = GetEntityCoords(ply)
    if not openChest.coords then
        return true
    end

    if #(openChest.coords - plyCds) <= 4.0 then
        return true
    else
        TriggerEvent("Notify", "negado", "Você está longe do baú.")
        openChest = {}
        SendNUIMessage({
            route = "CLOSE_INVENTORY",
            payload = false
        })
        SetNuiFocus(false, false)
        return false
    end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- check if player is in solo session [mirtin]
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while InSoloSession do
        if #GetActivePlayers() > 1 then
            InSoloSession = false
            break
        end
        Wait(2000)
    end
end)

local isAnyChestSynced = false

function API.addChest(chestName, chestData)
    if not isAnyChestSynced then
        isAnyChestSynced = true
    end
    Chests[chestName] = chestData
    -- print(string.format("[Client] Baú '%s' adicionado/atualizado.", chestName))
end

function API.removeChest(chestName)
    Chests[chestName] = nil
    -- print(string.format("[Client] Baú '%s' removido.", chestName))
end

CreateThread(function()
    Wait(30000)
    if not isAnyChestSynced then
        Remote.debugBau()
    end
end)

function DrawText3DAlways(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if not onScreen then
        return
    end

    local playerCoords = GetEntityCoords(PlayerPedId())
    local distance = #(playerCoords - vector3(x, y, z))
    local scale = 1.0 / math.max(distance, 1.0) * 2.0
    scale = math.min(scale, 0.35)
    scale = math.max(scale, 0.2)

    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(_x, _y)
end

RegisterNetEvent('chest:showBlips', function(org)
    CreateThread(function()
        if not Chests[org] then return end

        local coords = Chests[org].coords
        if not coords then return end

        local endTime = GetGameTimer() + (1000 * 60 * 2)
        while GetGameTimer() < endTime do
            Wait(0)
            DrawText3DAlways(coords.x, coords.y, coords.z + 1.0, "Baú")
        end
    end)
end)