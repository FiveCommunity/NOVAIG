local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')

vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

ServerAPI = {}
Tunnel.bindInterface(GetCurrentResourceName(), ServerAPI)
ClientAPI = Tunnel.getInterface(GetCurrentResourceName())

local airdrops = {}
local currentAirdropId = 0
local Airdrop = module(GetCurrentResourceName(), 'server/airdrop')

local function hasPermission(userId)
    for _, permission in ipairs(Config.AirdropPermissions) do
        if permission.permType == 'perm' and vRP.hasPermission(userId, permission.perm) then
            return true
        elseif permission.permType == 'group' and vRP.hasGroup(userId, permission.group) then
            return true
        end
    end
    return false
end

RegisterCommand(Config.AirdropCommand, function(source, args)
    local userId = vRP.getUserId(source)
    if not hasPermission(userId) then return end

    currentAirdropId = currentAirdropId + 1
    local airdropNow = Airdrop:new(currentAirdropId, false)
    if airdropNow then
        airdrops[currentAirdropId] = airdropNow
        airdrops[currentAirdropId]:start()
    else
        TriggerClientEvent('Notify', source, 'negado', 'Já existe um airdrop em andamento.')
    end
end)

RegisterCommand('airdrop2', function(source, args)
    local userId = vRP.getUserId(source)
    if not hasPermission(userId) then return end

    currentAirdropId = currentAirdropId + 1
    local coords = GetEntityCoords(GetPlayerPed(source))
    local airdropNow = Airdrop:new(currentAirdropId, coords)
    if airdropNow then
        airdrops[currentAirdropId] = airdropNow
        airdrops[currentAirdropId]:start()
    else
        TriggerClientEvent('Notify', source, 'negado', 'Já existe um airdrop em andamento.')
    end
end)

exports('createCustomAirdrop', function(location, rewards)
    currentAirdropId = currentAirdropId + 1
    local airdropNow = Airdrop:newCustom(location, rewards, currentAirdropId)
    if airdropNow then
        airdrops[currentAirdropId] = airdropNow
        airdrops[currentAirdropId]:start()
    end
end)

function ServerAPI.collectAirdrop(id)
    local userId = vRP.getUserId(source)
    if not userId or not airdrops[id] then return end

    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    local distance = #(coords - airdrops[id].location)
    if distance > 5.0 then
        print('Suspeito pegando airdrop mais longe do que deveria. ID: ' .. userId .. ' | Distance: ' .. distance)
        return
    end

    if distance > 2.0 then
        TriggerClientEvent('Notify', source, 'negado', 'Você está longe do airdrop.')
        return
    end

    if airdrops[id]:collect(userId) then
        airdrops[id]:stop()
        airdrops[id] = nil
        ClientAPI.removeAirdrop(-1, id)
        TriggerClientEvent('Notify', source, 'sucesso', 'Você coletou o airdrop.')
    end
end

Citizen.CreateThread(function()
    local airdropTimes = getRandomAirdropTimes()
    
    -- print('Airdrop times: ' .. json.encode(airdropTimes))

    while true do
        local currentTime = os.date('*t')
        for _, scheduledTime in ipairs(airdropTimes) do
            local remainingMinutes = (scheduledTime.hour * 60 + scheduledTime.minute) - (currentTime.hour * 60 + currentTime.min)

            if remainingMinutes == 10 then
                TriggerClientEvent('Notify', -1, 'aviso', 'Um airdrop será lançado em 10 minutos!')
            elseif remainingMinutes == 5 then
                TriggerClientEvent('Notify', -1, 'aviso', 'Um airdrop será lançado em 5 minutos!')
            end

            if isScheduledTime(currentTime, scheduledTime) then
                triggerAirdrop()
            end
        end
        Citizen.Wait(60000)
    end
end)

Citizen.CreateThread(function()
    local COUNTER_DELETE = 0
    while true do
        local THREAD_OPTIMIZER = 5000

        if airdrops and next(airdrops) then
            for id, airdrop in pairs(airdrops) do
                if airdrop.deleteInTime then
                    if GetGameTimer() > airdrop.deleteInTime then
                        print('DELETE AIRDROP TEMP LIMIT: '..id)    
                        airdrops[id]:stop()
                        airdrops[id] = nil
                        ClientAPI.removeAirdrop(-1, id)
                    end
                end
            end
        end
        Wait(THREAD_OPTIMIZER)
    end
end)


function getRandomAirdropTimes()
    if Config.DailyAirdropCount > #Config.AirdropSchedule then
        Config.DailyAirdropCount = #Config.AirdropSchedule
    end
    local times = {}
    local availableTimes = {table.unpack(Config.AirdropSchedule)}
    for i = 1, Config.DailyAirdropCount do
        local randomIndex = math.random(#availableTimes)
        table.insert(times, availableTimes[randomIndex])
        table.remove(availableTimes, randomIndex)
    end
    return times
end

function isScheduledTime(currentTime, scheduledTime)
    return currentTime.hour == scheduledTime.hour and currentTime.min == scheduledTime.minute
end

function triggerAirdrop()
    currentAirdropId = currentAirdropId + 1
    airdrops[currentAirdropId] = Airdrop:new(currentAirdropId)
    airdrops[currentAirdropId]:start()
end

AddEventHandler('vRP:playerSpawn', function(userId, source)
    for id, airdrop in pairs(airdrops) do
        if airdrop.isActive and airdrop.object and DoesEntityExist(airdrop.object) then
            local remainingTime = type(airdrop.remainingTime) == 'number' and airdrop.remainingTime or false

            if type(remainingTime) == "number" then
                if not GetGameTimer() > remainingTime then
                    ClientAPI.addAirdrop(source, airdrop.id, airdrop.location, airdrop.remainingTime, NetworkGetNetworkIdFromEntity(airdrop.object))
                end
            end
        end
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() ~= resource then return end
    for _, airdrop in pairs(airdrops) do
        airdrop:stop()
    end
end)