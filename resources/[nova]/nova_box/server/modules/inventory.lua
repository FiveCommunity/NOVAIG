-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local playerPrize = {}


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CreateTunnel.getInventory()
    local source = source

    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local inventory = USER:getInventory(user_id)
    if not inventory or not inventory.crates or not inventory.keys then
        return
    end

    local t = {}
    for crate, amount in pairs(inventory.crates) do
        local cfg_crate = Config.Crates[crate]
        if not cfg_crate then goto next_crate end

        local key = Config.Keys[cfg_crate.key]
        if not key then goto next_crate end

        local gen_id = #t + 1
        if amount > 0 then
            t[gen_id] = {
                id = crate,
                name = cfg_crate.name,
                type = 'BOX',
                rarity = cfg_crate.rarity,
                amount = amount,
                image_url = cfg_crate.image_url,

                drops = {
                    { category = key.category, id = cfg_crate.key, name = key.name, amount = inventory.keys[cfg_crate.key] and inventory.keys[cfg_crate.key] or 0, image_url = key.image_url }
                }
            }
        end
        
        :: next_crate ::
    end

    return t
end

function CreateTunnel.openInventoryBox(crate)
    local source = source

    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local status, time = exports['vrp']:getCooldown(user_id, "box_cooldown")
    if not status then
        return
    end
    exports['vrp']:setCooldown(user_id, "box_cooldown", 2)

    if not Config.Crates[crate] then
        return
    end
    
    local inventory = USER:getInventory(user_id)
    if not inventory or not inventory.crates or not inventory.keys then
        return
    end

    local amountCrate = inventory.crates[crate]
    if not amountCrate or amountCrate <= 0 then
        return
    end

    local key = Config.Crates[crate].key
    if not key then
        return
    end

    local amountKey = inventory.keys[key]
    if not amountKey or amountKey <= 0 then
        return
    end

    inventory.crates[crate] = (amountCrate - 1)
    inventory.keys[key] = (amountKey - 1)
    USER:updateInventory(user_id, inventory)

    local CRATES = GlobalState.CratesItems
    if not CRATES[crate] then return end

    local item_prize
    while not item_prize do
        local t = {}
        for i = 1, #CRATES[crate] do
            local item = CRATES[crate][i]

            t[#t + 1] = {
                id = item.id,
                item = item.item,
                name = item.name,
                rarity = item.rarity,
                amount = item.amount
            }
        end

        local random_chance = math.random(100)
        local items_possible = {}
        for i=1, #t do
            local item = t[i]
            if Config.raritys[item.rarity] then
                if ( random_chance <= Config.raritys[item.rarity] ) then
                    items_possible[i] = item
                end
            end
        end

        local calc_reward = math.random(0, #items_possible)
        item_prize = items_possible[calc_reward]

        Wait( 5 )
    end

    playerPrize[user_id] = {
        crate = crate,
        itemId = item_prize.id,
    }

    return item_prize.id
end

function CreateTunnel.paymentReward()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local identity = vRP.getUserIdentity(user_id)
    if not identity then
        return
    end

    local status, time = exports['vrp']:getCooldown(user_id, "box_cooldown_reward")
    if not status then
        return
    end
    exports['vrp']:setCooldown(user_id, "box_cooldown_reward", 2)

    local prize = playerPrize[user_id]
    if not prize then
        return
    end
    playerPrize[user_id] = nil

    local crate = GlobalState.CratesItems[prize.crate]
    if not crate then
        return
    end

    for i = 1, #crate do
        local crateItem = crate[i] 

        if crateItem.id == prize.itemId then
            TriggerClientEvent('chatMessage', -1, {
                title = 'BOX',
                type = 'box',
                message =  ("O(a) %s %s GANHOU O ITEM %s NA %s"):format(identity.nome, identity.sobrenome, crateItem.name, Config.Crates[prize.crate].name),
            })	

            Config.Crates[prize.crate].items[prize.itemId].func(source, user_id)
            vRP.sendLog('https://discord.com/api/webhooks/1313526074277363712/vPOsXtXci8RrjyQS5Q2rGgT360B0rjbp2Zqs_p61vYs32bI79ThjZ5q-ZnhRRc51lcIm', 'USUARIO '..user_id..' RESGATOU O BAU '..Config.Crates[prize.crate].name..' E GANHOU O ITEM '..crateItem.name)

            local crate_price = Config.Crates[prize.crate].price
            local key_price = Config.Keys[Config.Crates[prize.crate].key].price
            local total_price = (crate_price + key_price) / 2

            if Config.Crates[prize.crate].items[prize.itemId].type == 'car' then
                local query = vRP.query('lotus_box/getVehicle', { user_id = user_id, veiculo = Config.Crates[prize.crate].items[prize.itemId].item })
                if #query > 0 then
                    TriggerClientEvent('Notify', source, 'importante', 'Você já possui esse veiculo, por isso reembolsamos 50% do valor gasto de makapoints, TOTAL de '..total_price..' makapoints.', 10)
                    vRP.giveMakapoints(user_id, total_price)
                end
            end

            if Config.Crates[prize.crate].items[prize.itemId].type == 'others' and Config.Crates[prize.crate].items[prize.itemId].item:find('COMPONENT_') then
                local data = json.decode(vRP.getUData(user_id, "Skins:Buyed")) or {}
                for _, v in pairs(data) do
                    if v.component == Config.Crates[prize.crate].items[prize.itemId].item then
                        TriggerClientEvent('Notify', source, 'importante', 'Você já possui essa skin, por isso reembolsamos 50% do valor gasto de makapoints, TOTAL de '..total_price..' makapoints.', 10)
                        vRP.giveMakapoints(user_id, total_price)
                        break;
                    end
                end
            end


            return crateItem.image_url
        end
    end

    return print('Problemas ao encontrar o Premio')
end
