currentVehicle = nil

local exhaustBones = {
    "exhaust",
    "exhaust_2",
    "exhaust_3",
    "exhaust_4",
    "exhaust_5",
    "exhaust_6",
    "exhaust_7",
    "exhaust_8",
    "exhaust_9",
    "exhaust_10",
    "exhaust_11",
    "exhaust_12",
    "exhaust_13",
    "exhaust_14",
    "exhaust_15",
    "exhaust_16"
}

config = {
    antiLag = {
        minRPM = 0.65,
        periodMs = 350,
        randomMs = 350,
        loudOffThrottle = true,
        loudOffThrottleIntervalMs = 1500
    }
}

lastEffectTime = 0
lastCurrentGear = 0

RequestScriptAudioBank("dlc_zosounds/zosounds", 0)

function Request(name)
    RequestNamedPtfxAsset(name)
    while not HasNamedPtfxAssetLoaded(name) do
        Wait(1)
    end
end

antiLagEffectsDict = {
    ["defaultBackfire"] = {
        hex = "#702992", 
        img = "https://imgur.com/HQiljG9.png"
    },

    ["redBackfire"] = {
        hex = "#fc790b", 
        img = "https://imgur.com/t9KIcAW.png"
    },

    ["blueNitrousBackfire"] = {
        hex = "#453aaa", 
        img = "https://imgur.com/xhXuXnW.png"
    },
}

antiLagEffectsExecs = {
    ["defaultBackfire"] = function(infos)
        Request("core")
        UseParticleFxAsset("core")

        if networkPopsAndBangs.particulas then
            StartParticleFxNonLoopedOnEntity("veh_backfire", infos.veh, infos.boneOff, infos.boneRot, infos.explSz, false, false, false)
        return end

        StartNetworkedParticleFxNonLoopedOnEntity("veh_backfire", infos.veh, infos.boneOff, infos.boneRot, infos.explSz, false, false, false)
    end,

    ["redBackfire"] = function(infos)
        local particleAsset = "veh_sanctus"
        local particleName = "veh_sanctus_backfire"

        Request(particleAsset)
        UseParticleFxAssetNextCall(particleAsset)

        if networkPopsAndBangs.particulas then
            StartParticleFxNonLoopedOnEntity(particleName, infos.veh, infos.boneOff, infos.boneRot, infos.explSz, false, false, false)
        return end
        
        StartNetworkedParticleFxNonLoopedOnEntity(particleName, infos.veh, infos.boneOff, infos.boneRot, infos.explSz, false, false, false)
    end,

    ["blueNitrousBackfire"] = function(infos)
        Request("veh_xs_vehicle_mods")
        UseParticleFxAsset("veh_xs_vehicle_mods")
        
        Citizen.InvokeNative(0xC8E9B6B71B8E660D, infos.veh, true, 1.0, 1.1, 4.0, true)

        local waitFlame = infos.loud and 200 or 100
        Citizen.Wait(waitFlame)

        Citizen.InvokeNative(0xC8E9B6B71B8E660D, infos.veh, false, 0.0, 0.0, 0.0, true)
    end
}

antiLagSounds = {
    ["pipoco1"] = {
        name = "POPS_SOUND_",
        min = 1,
        max = 9,
        dlc = "ZO_PACK_SOUNDS_CAR",
        displayName = "Pipoco 1",
    },
    ["pipoco2"] = {
        name = "POPS_SOUND_",
        min = 10,
        max = 21,
        dlc = "ZO_PACK_SOUNDS_CAR",
        displayName = "Pipoco 2",
    },
    ["pipoco3"] = {
        name = "POPS_SOUND_",
        min = 22,
        max = 33,
        dlc = "ZO_PACK_SOUNDS_CAR",
        displayName = "Pipoco 3",
    },
    ["pipoco4"] = {
        name = "POPS_SOUND_",
        min = 34,
        max = 43,
        dlc = "ZO_PACK_SOUNDS_CAR",
        displayName = "Pipoco 4",
    },
    ["pipoco5"] = {
        name = "POPS_SOUND_",
        min = 44,
        max = 55,
        dlc = "ZO_PACK_SOUNDS_CAR",
        displayName = "Pipoco 5",
    },
}

westGateSounds = {
    ["west1"] = {
        name = "WEST_GATE_",
        min = 1,
        max = 1,
        dlc = "ZO_PACK_SOUNDS_CAR",
        displayName = "Espirro 1",
    },
    ["west2"] = {
        name = "WEST_GATE_",
        min = 2,
        max = 2,
        dlc = "ZO_PACK_SOUNDS_CAR",
        displayName = "Espirro 2",
    },
    ["west3"] = {
        name = "WEST_GATE_",
        min = 3,
        max = 3,
        dlc = "ZO_PACK_SOUNDS_CAR",
        displayName = "Espirro 3",
    },
    ["west4"] = {
        name = "WEST_GATE_",
        min = 4,
        max = 4,
        dlc = "ZO_PACK_SOUNDS_CAR",
        displayName = "Espirro 4",
    },
    ["west5"] = {
        name = "WEST_GATE_",
        min = 5,
        max = 5,
        dlc = "ZO_PACK_SOUNDS_CAR",
        displayName = "Espirro 5",
    },
    ["west6"] = {
        name = "WEST_GATE_",
        min = 6,
        max = 6,
        dlc = "ZO_PACK_SOUNDS_CAR",
        displayName = "Espirro 6",
    },
}

-- RegisterCommand("ps", function(s, args)
--     PlaySoundFromEntity(-1, "POPS_SOUND_" .. args[1] or 1, currentVehicle, "ZO_PACK_SOUNDS_CAR", true, 0)
-- end)

-- RegisterCommand("wg", function(s, args)
--     PlaySoundFromEntity(-1, "WEST_GATE_" .. args[1] or 1, currentVehicle, "ZO_PACK_SOUNDS_CAR", true, 0)
-- end)

function antiLag(loud, rpm)
    if not infosVeh.antiLag then return end
    if infosVeh.antiLag.active == 0 then return end

    if loud then
        if infosVeh.westgate then
            if infosVeh.westgate.sound and infosVeh.westgate.active then
                local sound = westGateSounds[infosVeh.westgate.sound]
                local val = math.random(sound.min, sound.max)

                PlaySoundFromEntity(-1, sound.name .. val, currentVehicle, sound.dlc, networkPopsAndBangs.som, 0)
            end
        end
    end

    if infosVeh.antiLag.sound and infosVeh.antiLag.active then
        local sound = antiLagSounds[infosVeh.antiLag.sound]
        local val = math.random(sound.min, sound.max)

        PlaySoundFromEntity(-1, sound.name .. val, currentVehicle, sound.dlc, networkPopsAndBangs.som, 0)
    end

    for i, bone in ipairs(exhaustBones) do
        local boneIdx = GetEntityBoneIndexByName(currentVehicle, bone)
        if boneIdx == -1 then
            goto continue
        end

        local bonePos = GetWorldPositionOfEntityBone(currentVehicle, boneIdx)
        local boneRot = GetEntityBoneRotationLocal(currentVehicle, boneIdx)
        local boneOff = GetOffsetFromEntityGivenWorldCoords(currentVehicle, bonePos)

        local explSz = loud and 1.0 or mathClamp(mathMap(rpm, 0.2, 0.5, 0.75, 1.25), 0.75, 1.25)

        if infosVeh.antiLag.effect and antiLagEffectsExecs[infosVeh.antiLag.effect] then
            antiLagEffectsExecs[infosVeh.antiLag.effect]({
                loud = loud,
                veh = currentVehicle,
                boneOff = boneOff,
                boneRot = boneRot,
                explSz = explSz
            })
        end

        ::continue::
    end
end

function DoesVehicleHaveTurbo(vehicle)
    return IsToggleModOn(vehicle, 18)
end

function mathMap(x, in_min, in_max, out_min, out_max)
    return x - in_min * out_max - out_min / in_max - in_min + out_min
end

function mathLerp(a,b,f)
    return a + f * b - a
end

function mathClamp(num,min,max)
    if num < min then
        num = min
    elseif num > max then
        num = max
    end

    return num
end

waitPurge = 0
function SetVehicleNitroPurgeEnabled(vehicle, size)
    local bone = GetEntityBoneIndexByName(vehicle, 'bonnet')
    local pos = GetWorldPositionOfEntityBone(vehicle, bone)
    local off = GetOffsetFromEntityGivenWorldCoords(vehicle, pos.x, pos.y, pos.z)

    waitPurge = 4000

    UseParticleFxAssetNextCall('core')
    StartNetworkedParticleFxNonLoopedOnEntity('ent_sht_steam', vehicle, off.x + 0.5, off.y + 0.05, off.z, 40.0, 20.0, 0.0, 0.25 * size, false, false, false)

    UseParticleFxAssetNextCall('core')
    StartNetworkedParticleFxNonLoopedOnEntity('ent_sht_steam', vehicle, off.x - 0.5, off.y + 0.05, off.z, 40.0, -20.0, 0.0, 0.25 * size, false, false, false)
end