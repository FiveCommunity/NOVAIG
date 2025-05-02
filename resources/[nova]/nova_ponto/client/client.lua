local nearestOrg = nil
local userGroup = nil
local clothes = {}

local userData = {}
function table.map(t, f)
    local t2 = {}
    for k,v in pairs(t) do
        t2[k] = f(k, v)
    end
    return t2
end

local function dbg(t)
    if(type(t) == "table") then
    else
    end
end


local function findNearestOrg(coords)
    local distance = 10000
    local org = nil
    local resultCoords = nil
    for k,v in pairs(Config.Orgs) do
        for i = 1, #v.coords do
            local dist = #(coords - v.coords[i])
            if dist < distance then
                distance = dist
                org = k
                resultCoords = v.coords[i]
            end
        end
    end
    return org, distance, resultCoords
end

CreateThread(function()
	while true do
        local sleep = 3000
		local coords = GetEntityCoords(PlayerPedId())
        local org, distance, resultCoords = findNearestOrg(coords)
        if org and distance < 5 then
            sleep = 3
            local orgData = Config.Orgs[org]
            DrawText3D(resultCoords, "~g~[E]~w~ Ponto - "..org)
            if IsControlJustPressed(0, 38) then
                local success, group, startTime, userInfo = Remote.checkOrgData(org)
                userData = userInfo
                if success then
                    nearestOrg = org
                    userGroup = group
                    SendNUIMessage({ action = 'open', data = {
                        point = startTime
                    }})
                    SetNuiFocus(true, true)
                else
                    TriggerEvent("Notify", "negado", "Você não faz parte da organização "..org)
                    Wait(2000)
                end
            end
        end
        Wait(sleep)
	end
end)

RegisterNUICallback('getUser', function(data, cb)
  cb(userData)
end)

RegisterNUICallback('hideFrame', function(data, cb)
    SetNuiFocus(false, false)
    cb(true)
end)

RegisterNUICallback('point', function(data, cb)
    if data.status then
    Remote._startService(nearestOrg)
    else
    Remote.stopService(nearestOrg)
    end
    cb(true)
end)

RegisterNUICallback('equip', function(data, cb)
    local response = Remote.equip(nearestOrg)
    if response then
        local newChannel = Config.Orgs[nearestOrg].radioChannel
        TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",0.6)
        TriggerEvent("lotus-hud:setRadioFrequency", parseInt(newChannel))
        exports["pma-voice"]:setRadioChannel(parseInt(newChannel))
        exports["pma-voice"]:setVoiceProperty('radioEnabled',true)
    end
    cb(true)
end)

RegisterNUICallback('getEquipments', function(_, cb)
    local payload = {}

    for k,v in pairs(Config.Orgs[nearestOrg].groups[userGroup].WeaponsKit) do
        local kit = Config.WeaponsKit[v]
        payload[#payload + 1] = {
            image = "nui://nova_hud/web-side/assets/weapons/"..GetHashKey(kit.name)..".png",
            name = v, 
        }
    end
    dbg(payload)
    cb(payload)
end)

RegisterNUICallback('getUniforms', function(data, cb)
    local payload = Remote.getClothes(nearestOrg)
    dbg(payload)
    cb(payload)
end)

RegisterNUICallback('getRanking', function(data, cb)
    local payload = Remote.getRanking(nearestOrg)
    cb(payload)
end)
RegisterNUICallback('editUniform', function(data, cb)
    -- text = json.encode(json.decode(json.encode(data.text)))

    local response = Remote.updateUniform(nearestOrg, data.uniform.group, json.decode(data.text))
    if response then
        cb(true)
    else
        TriggerEvent("Notify", "negado", "Uniforme inválido!")
        cb(false)
    end
end)


