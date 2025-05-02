-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CreateTunnel.buyKeys(keyId)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local status, time = exports['vrp']:getCooldown(user_id, "box_cooldown")
    if not status then
        return
    end
    exports['vrp']:setCooldown(user_id, "box_cooldown", 2)

    local key = Config.Keys[keyId]
    if not key then
        return
    end

    local inventory = USER:getInventory(user_id)
    if not inventory or not inventory.crates or not inventory.keys then
        return
    end

    local points = vRP.getMakapoints(user_id) 
    if points < key.price then
        return
    end

    points = (points - key.price)
    if points <= 0 then
        points = 0
    end
    vRP.setMakapoints(user_id,parseInt(points))

    if inventory.keys[keyId] then
        inventory.keys[keyId] = (inventory.keys[keyId] + 1)
    else
        inventory.keys[keyId] = 1
    end

    USER:updateInventory(user_id, inventory)
    vRP.sendLog('https://discord.com/api/webhooks/1285670214184341555/YaYmoXaHtp2oKnexCvbRQjf5OEHdtWUMaN5qFiAER1nk0msxpP88Oet1u2j8GhxSZknn', '```prolog\n[ID]: '..user_id..'\n[KEY]: '..keyId..' \n[PRICE]: '..key.price..' \n[POINTS]: '..points..' \n[TIME]: '..os.date("%d/%m/%Y %X", os.time())..' \r```')

    return true
end

function addKey(user_id, keyId)
    local key = Config.Keys[keyId]
    if not key then
        return
    end

    local inventory = USER:getInventory(user_id)
    if not inventory or not inventory.crates or not inventory.keys then
        return
    end

    if inventory.keys[keyId] then
        inventory.keys[keyId] = (inventory.keys[keyId] + 1)
    else
        inventory.keys[keyId] = 1
    end

    USER:updateInventory(user_id, inventory)
end
exports('addKey', function(user_id, keyId)
    return addKey(user_id, keyId)
end)