local Airdrop = {}
Airdrop.__index = Airdrop

function Airdrop:new(id, location, source)
    local otherAirdropRunning = false

    if airdrops and next(airdrops) then
        for _, airdrop in pairs(airdrops) do
            if airdrop.isActive then
                otherAirdropRunning = true
                break
            end
        end
    end
    if otherAirdropRunning then
        return false
    end

    local counterTry = 0

    local instance = setmetatable({}, Airdrop)
    instance.id = id
    instance.location = not location and Config.AirdropLocations[math.random(#Config.AirdropLocations)] or location
    instance.reward = self:selectRewardWithProbability(Config.AirdropRewards)
    instance.isActive = false
    instance.remainingTime = GetGameTimer() + Config.AirdropTimeToFall * 1000
    instance.deleteInTime = GetGameTimer() + (8 * 60 * 1000)
    instance.object = CreateObject(Config.AirdropProps.crate, instance.location.x, instance.location.y, instance.location.z + Config.AirdropHigh, true, true, false)

    return instance
end

function Airdrop:newCustom(location, rewards, id)
    local instance = setmetatable({}, Airdrop)
    instance.id = id
    instance.location = location
    instance.reward = self:selectRewardWithProbability(rewards)
    instance.isActive = false
    instance.remainingTime = GetGameTimer() + Config.AirdropTimeToFall * 1000
    instance.deleteInTime = GetGameTimer() + (8 * 60 * 1000)
    instance.object = CreateObject(Config.AirdropProps.crate, instance.location.x, instance.location.y, instance.location.z + Config.AirdropHigh, true, true, false)
    instance.isCustom = true

    return instance
end

function Airdrop:selectRewardWithProbability(reward)
    local totalProbability = 0

    for _, reward in ipairs(reward) do
        totalProbability = totalProbability + reward.probability
    end

    local randomValue = math.random() * totalProbability
    local cumulativeProbability = 0

    for _, reward in ipairs(reward) do
        cumulativeProbability = cumulativeProbability + reward.probability
        if randomValue <= cumulativeProbability then
            return reward.rewards
        end
    end
end

function Airdrop:start()
    while not DoesEntityExist(self.object) do
        Citizen.Wait(1000)
    end

    Wait(1000)
    FreezeEntityPosition(self.object, true)
    ClientAPI.addAirdrop(-1, self.id, self.location, Config.AirdropTimeToFall, NetworkGetNetworkIdFromEntity(self.object), self.isCustom)

    if not self.isCustom then
        local ilegal = vRP.getUsersByPermission('perm.ilegal')
        for l,w in pairs(ilegal) do
            local player = vRP.getUserSource(parseInt(w))
            if player then
                TriggerClientEvent('Notify', player, 'importante', 'Um novo airdrop está caindo do ceu, abra seu mapa para ver a localização.')
            end
        end
    end

    self:dropCrate()
end

function Airdrop:dropCrate()
    local totalTime = Config.AirdropTimeToFall * 1000
    local initialZ = self.location.z + Config.AirdropHigh
    Citizen.CreateThread(function()
        local startTime = GetGameTimer()
        while GetGameTimer() < startTime + totalTime do
            local progress = (GetGameTimer() - startTime) / totalTime
            local currentZ = initialZ - (progress * Config.AirdropHigh)
            SetEntityCoords(self.object, self.location.x, self.location.y, currentZ)
            Citizen.Wait(10)
        end
        SetEntityCoords(self.object, self.location.x, self.location.y, self.location.z - 1.0)
        self.isActive = true
    end)
end

local function textLog(items)
    local txt = ''
    for _, reward in ipairs(items) do
        txt = txt .. reward.quantity .. 'x ' .. reward.item .. '\n'
    end
    return txt
end

function Airdrop:collect(userId)
    if not self.isActive then return false end
    self.isActive = false

    for _, reward in ipairs(self.reward) do
        vRP.giveInventoryItem(userId, reward.item, reward.quantity, true)
    end

    TriggerEvent("aidrop:dominacao_pistol:rewardItem",  {
        user_id = userId,
        rewards = self.reward
    })

    ClientAPI.removeAirdrop(-1, self.id)
    self:stop()

    vRP.sendLog('https://discord.com/api/webhooks/1313519570492850179/I-a8QsU5W76LltQOhtLVqh2Z0V_i2gLjz0Lfq5s-SCga1sXsM-uyZ6x9IWuZrcB-bNUq', '```prolog\n[ID]: ' .. userId .. '\n[RECOMPENSA]:\n' .. textLog(self.reward) .. '\n[DATA]: ' .. os.date('%d/%m/%Y %H:%M:%S') .. '```')
    return true
end

function Airdrop:stop()
    if self.object then
        CreateThread(function()
            local trysDelete = 0
            while trysDelete < 5 do
                if DoesEntityExist(self.object) then
                    DeleteEntity(self.object)
                    break
                else
                    trysDelete = trysDelete + 1
                end
                Wait(1000)
            end
        end)
    end

    self.object = nil
    self.isActive = false
end

return Airdrop