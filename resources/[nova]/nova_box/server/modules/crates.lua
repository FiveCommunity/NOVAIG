-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GlobalState.Crates = {}
GlobalState.CratesItems = {}

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CreateTunnel.buyCrate(crateId)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local status, time = exports['vrp']:getCooldown(user_id, "box_cooldown")
    if not status then
        return
    end
    exports['vrp']:setCooldown(user_id, "box_cooldown", 2)

    local crate = Config.Crates[crateId]
    if not crate then
        return
    end

    local inventory = USER:getInventory(user_id)
    if not inventory or not inventory.crates or not inventory.keys then
        return
    end

    local points = vRP.getMakapoints(user_id) 
    if points < crate.price then
        return
    end

    points = (points - crate.price)
    if points <= 0 then
        points = 0
    end
    vRP.setMakapoints(user_id,parseInt(points))

    if inventory.crates[crateId] then
        inventory.crates[crateId] = (inventory.crates[crateId] + 1)
    else
        inventory.crates[crateId] = 1
    end

    USER:updateInventory(user_id, inventory)
    vRP.sendLog('https://discord.com/api/webhooks/1285670330207043675/uaYxRZQqK1ZcTH48j8egFDa1_Wcd2hCNWC20xrW2BEYYcoFVsWvc173sEdBO8Eh5tyWI', '```prolog\n[ID]: '..user_id..'\n[CRATE]: '..crateId..' \n[PRICE]: '..crate.price..' \n[POINTS]: '..points..' \n[TIME]: '..os.date("%d/%m/%Y %X", os.time())..' \r```')

    return true
end

function addBox(user_id, crateId)
    local crate = Config.Crates[crateId]
    if not crate then
        return
    end

    local inventory = USER:getInventory(user_id)
    if not inventory or not inventory.crates or not inventory.keys then
        return
    end

    if inventory.crates[crateId] then
        inventory.crates[crateId] = (inventory.crates[crateId] + 1)
    else
        inventory.crates[crateId] = 1
    end

    USER:updateInventory(user_id, inventory)
end

exports('addBox', function(user_id, crateId)
    return addBox(user_id, crateId)
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    local CRATES = {}
    local CRATE_ITEMS = {}
    for index in pairs(Config.Crates) do
        local crate = Config.Crates[index]
        
        local gen_id = #CRATES + 1
        CRATES[gen_id] = {
            id = index,
            name = crate.name,
            type = 'box',
            price = crate.price,
            category = crate.rarity,
            image_url = crate.image_url,
            drops = {}
        }

        for _, item in pairs(crate.items) do
            local gen_item_id = (#CRATES[gen_id].drops + 1)
            CRATES[gen_id].drops[gen_item_id] = {
                category = item.rarity,
                id = gen_item_id,
                item = item.item,
                name = item.name,
                probability = Config.raritys[item.rarity] or 50,
                rarity = item.rarity,
                amount = item.amount,
                image_url = ('%s/%s.png'):format(item.type == 'item' and Config.dir or item.type == 'car' and Config.dirCars or item.type == 'others' and Config.dirOthers, item.item)
            }
        end

        CRATE_ITEMS[index] = CRATES[gen_id].drops
    end

    GlobalState.Crates = CRATES
    GlobalState.CratesItems = CRATE_ITEMS
end)