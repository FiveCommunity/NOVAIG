local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')

vRP = Proxy.getInterface('vRP')

ClientAPI = {}
Tunnel.bindInterface(GetCurrentResourceName(), ClientAPI)
ServerAPI = Tunnel.getInterface(GetCurrentResourceName())

local activeAirdrops = {}
local airdropBlips = {}

local nowAirdropId = nil

CreateThread(function()
    while true do
        local THREAD_OPTIMIZER = 8000
        if activeAirdrops and next(activeAirdrops) then
            local pool = GetGamePool("CNetObject")
            for i = 1, #pool do
                local v = pool[i]
                if GetEntityModel(v) == Config.AirdropProps.crate then
                    if nowAirdropId ~= nil then
                        THREAD_OPTIMIZER = 1000
                        if activeAirdrops[nowAirdropId].object ~= v then
                            activeAirdrops[nowAirdropId].object = v
                        end
                    end
                end
            end
        end
        Wait(THREAD_OPTIMIZER)
    end
end)

local function requestParticleAsset(particleName)
    RequestNamedPtfxAsset(particleName)
    while not HasNamedPtfxAssetLoaded(particleName) do
        Wait(50)
    end
    UseParticleFxAssetNextCall(particleName)
end

local function createParticleEffect(id, coords, particleDict, particleName)
    requestParticleAsset(particleDict)
    activeAirdrops[id].particleId = StartParticleFxLoopedAtCoord(particleName, coords.x, coords.y, coords.z - 1.0, 0.0, 0.0, 0.0, 2.0, false, false, false)
end

function ClientAPI.addAirdrop(id, dropLocation, duration, airdropObjectNetId, isCustom)
    activeAirdrops[id] = {
        location = dropLocation,
        endTime = GetGameTimer() + duration * 1000,
        isVisible = false,
        object = NetToObj(airdropObjectNetId),
        particleId = 0,
        isCustom = isCustom
    }

    if isCustom then return end

    local blip = AddBlipForCoord(dropLocation.x, dropLocation.y, dropLocation.z)
    local radiusBlip = AddBlipForRadius(dropLocation.x, dropLocation.y, dropLocation.z, 200.0)

    SetBlipSprite(blip, 306)
    SetBlipColour(blip, 47)
    SetBlipScale(blip, 1.0)
    SetBlipColour(radiusBlip, 1)
    SetBlipAlpha(radiusBlip, 125)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Airdrop")
    EndTextCommandSetBlipName(blip)

    airdropBlips[id] = { blip = blip, radiusBlip = radiusBlip }
end

function ClientAPI.removeAirdrop(id)

    if not activeAirdrops[id] then return end

    if activeAirdrops[id].isCustom then return end

    RemoveBlip(airdropBlips[id].blip)
    RemoveBlip(airdropBlips[id].radiusBlip)
    activeAirdrops[id] = nil
    airdropBlips[id] = nil
end

local function attachParachuteToAirdrop(id)
    RequestModel(Config.AirdropProps.parachute)
    while not HasModelLoaded(Config.AirdropProps.parachute) do
        Wait(200)
    end
    if DoesEntityExist(activeAirdrops[id].object) and activeAirdrops[id].object > 0 then
        activeAirdrops[id].parachute = CreateObject(Config.AirdropProps.parachute, activeAirdrops[id].location.x, activeAirdrops[id].location.y, activeAirdrops[id].location.z + Config.AirdropHigh, false, true, false)
        while not DoesEntityExist(activeAirdrops[id].parachute) do
            Wait(200)
        end
        AttachEntityToEntity(activeAirdrops[id].parachute, activeAirdrops[id].object, 0, 0.0, 0.0, 3.4, 0.0, 0.0, 0.0, false, false, false, true)
    end

    createParticleEffect(id, activeAirdrops[id].location, 'core', 'exp_grd_flare')

    CreateThread(function()
        while true do
            if not activeAirdrops[id] then print('DROP ID'..tostring(id) .. ' NOT FOUND') break end
            if GetGameTimer() >= activeAirdrops[id].endTime and DoesEntityExist(activeAirdrops[id].object) then
                StopParticleFxLooped(activeAirdrops[id].particleId, false)
                DeleteEntity(activeAirdrops[id].parachute)
                break
            end
            Wait(1000)
        end
    end)
end

local function playAnimation(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(1)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, -8.0, duration, 1, 0, false, false, false)
    Wait(duration)
    ClearPedTasks(PlayerPedId())
end

local function tryCollectAirdrop(id)
    playAnimation('amb@medic@standing@tendtodead@idle_a', 'idle_a', 5000)
    if GetEntityHealth(PlayerPedId()) > 101 and not IsPedInAnyVehicle(PlayerPedId()) then
        ServerAPI.collectAirdrop(id)
    end
end

CreateThread(function()
    while true do
        local waitTime = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for id, airdrop in pairs(activeAirdrops) do
            local distance = #(playerCoords - airdrop.location)

            if distance <= Config.AirdropHigh then
                nowAirdropId = id
                if not airdrop.isVisible and GetGameTimer() <= airdrop.endTime then
                    airdrop.isVisible = true
                    attachParachuteToAirdrop(id)
                end

                if GetGameTimer() > airdrop.endTime then
                    PlaceObjectOnGroundProperly(airdrop.object)
                    if distance <= 2.0 and not IsPedInAnyVehicle(playerPed) and GetEntityHealth(PlayerPedId()) > 101 then
                        if DoesEntityExist(airdrop.object) then
                            waitTime = 0
                            DrawText3D(airdrop.location.x, airdrop.location.y, airdrop.location.z, "~g~[E]~w~ para coletar o airdrop")
                            if IsControlJustPressed(0, 38) then
                                tryCollectAirdrop(id)
                            end
                        end
                    end
                end
            else
                nowAirdropId = nil
                airdrop.isVisible = false
                if DoesEntityExist(airdrop.parachute) then
                    DeleteEntity(airdrop.parachute)
                end
                if activeAirdrops[id].particleId ~= 0 then
                    StopParticleFxLooped(activeAirdrops[id].particleId, false)
                end
            end
        end
        Wait(waitTime)
    end
end)

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
end