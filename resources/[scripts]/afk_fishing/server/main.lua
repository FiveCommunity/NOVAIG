local FishingCache = {}

function API.JoinFishing()
    local source = source
    local user_id = vRP.getUserId(source)
    local missingItems = {}
    print('JoinFishing')
    for i = 1, #Config.requiredItems do
        if vRP.getInventoryItemAmount(user_id, Config.requiredItems[i]) <= 0 then
            missingItems[#missingItems + 1] = Config.requiredItems[i]
        end
    end
    if #missingItems > 0 then
        print('missingItems')
        return false, "Você precisa de " .. table.concat(missingItems, " e ") .. " para pescar."
    end
    FishingCache[user_id] = {
        lastFishTime = os.time()
    }
    SetPlayerRoutingBucket(source, source)
    print('started fishing successfully')
    return true
end

function API.LeaveFishing()
    local source = source
    local user_id = vRP.getUserId(source)
    local fishingData = FishingCache[user_id]
    Remote._forceFishStop(source)
    if fishingData then
        SetPlayerRoutingBucket(source, 0)
        FishingCache[user_id] = nil
        return true
    end
    return false
end

AddEventHandler("vRP:playerLeave", function(user_id)
    if FishingCache[user_id] then FishingCache[user_id] = nil end
end)

local function giveRandomFish(user_id)
    local source = vRP.getUserSource(user_id)
    if source then
        local randomItem = Config.fishItems[math.random(1, #Config.fishItems)]
        if vRP.computeInvWeight(user_id) + vRP.getItemWeight(randomItem) >= vRP.getInventoryMaxWeight(user_id) then
            TriggerClientEvent("Notify",source,"aviso","Sua mochila está cheia.")
            Remote._forceFishStop(source)
            return false
        end
        vRP.giveInventoryItem(user_id, randomItem, 1, true)
        return true
    end
    return false
end

CreateThread(function()
    while true do
        Wait(15000)
        local now = os.time()
        for user_id, fishingData in pairs(FishingCache) do
            if now - fishingData.lastFishTime >= Config.fishInterval then
                local success = giveRandomFish(user_id)
                if success then
                    FishingCache[user_id].lastFishTime = os.time()
                end
            end
        end
    end
end)
