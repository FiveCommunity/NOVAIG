---@param permission string
---@return boolean
function API.checkPermission(permission)
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id, permission)
end

---@param store_index string
---@param item string
---@param amount number
---@param slot string
---@return table<string, string>
function API.shopAction(store_index, item, amount, slot)
    local source = source
    local user_id = vRP.getUserId(source)

    local shopData = Shops[store_index]
    if shopData then
        if shopData.mode == "buy" then
            if not (vRP.computeInvWeight(user_id) + vRP.getItemWeight(item) * amount <= vRP.getInventoryMaxWeight(user_id)) then
                return {
                    error = "Sem espaço suficiente!"
                }
            end

            if shopData.onlyWalletPayment then
                if not vRP.tryPayment(user_id, shopData.items[item] * amount) then return { error =
                    "Você precisa ter dinheiro em mãos para comprar isso." } end
            else
                if not vRP.tryFullPayment(user_id, shopData.items[item] * amount) then return { error =
                    "Dinheiro insuficiente" } end
            end
            vRP.giveInventoryItem(user_id, item, amount, slot)
            return {
                notify = "Compra realizada com sucesso!",
                money = shopData.items[item] * amount
            }
        end
        if shopData.mode == "sell" then
            if vRP.tryGetInventoryItem(user_id, item, amount, true, tostring(slot)) then
                vRP.giveMoney(user_id, shopData.items[item] * amount)
                return {
                    notify = "Você recebeu R$" .. shopData.items[item] * amount,
                    money = shopData.items[item] * amount
                }
            else
                return {
                    error = "Você não tem o item à ser vendido!"
                }
            end
        end
    end
    return {
        error = "Loja indisponível"
    }
end

function addShop(id, coords, blip)
    if not coords.x then
        coords = vec3(tonumber(coords[1]), tonumber(coords[2]), tonumber(coords[3]))
    end

    Shops['Mercado'].coords[tostring(id)] = { coords = vec3(coords.x, coords.y, coords.z), blip = blip }
    Remote.addShop(-1, id, coords, blip)
end

function removeShop(id)
    Shops['Mercado'].coords[tostring(id)] = nil
    Remote.removeShop(-1, id)
end

function syncShopsWithPlayer(source)
    for id, data in pairs(Shops['Mercado'].coords) do
        if data.coords then
            local coords = data.coords
            local blip = data.blip
            Remote.addShop(source, id, coords, blip)
        end
    end
end

AddEventHandler('vRP:playerSpawn', function(userId, source)
    syncShopsWithPlayer(source)
end)

exports('getShops', function()
    local shops = {}
    for id, data in pairs(Shops['Mercado'].coords) do
        if data.coords then
            table.insert(shops, {
                id = tonumber(id),
                coords = data.coords,
                blip = data.blip
            })
        end
    end
    table.sort(shops, function(a, b)
        return a.id < b.id
    end)
    return shops
end)

exports('addShop', function(coords, blip)
    if not coords.x then
        coords = vec3(tonumber(coords[1]), tonumber(coords[2]), tonumber(coords[3]))
    end
    local query = exports.oxmysql:executeSync(
        'INSERT INTO lotus_shops (coords, blip) VALUES (?, ?)',
        { json.encode(coords), blip }
    )
    if query and query.insertId then
        addShop(query.insertId, coords, blip)
        return true, 'Loja adicionada com sucesso'
    end
    return false, 'Falha ao adicionar a loja'
end)

exports('removeShop', function(id)
    local query = exports.oxmysql:executeSync('DELETE FROM lotus_shops WHERE id = ?', { id })
    if query then
        removeShop(id)
        return true, 'Loja removida com sucesso'
    end
    return false, 'Falha ao remover a loja'
end)

CreateThread(function()
    exports.oxmysql:executeSync([[CREATE TABLE IF NOT EXISTS lotus_shops (
        id INT AUTO_INCREMENT PRIMARY KEY,
        coords VARCHAR(255) NOT NULL,
        blip BOOLEAN NOT NULL DEFAULT FALSE
    )]])
    Wait(250)

    local query = exports.oxmysql:executeSync('SELECT * FROM lotus_shops')
    if query and #query > 0 then
        for _, shop in ipairs(query) do
            local coords = json.decode(shop.coords)
            if type(coords) == "table" and coords[1] and coords[2] and coords[3] then
                coords = vec3(tonumber(coords[1]), tonumber(coords[2]), tonumber(coords[3]))
            end
            addShop(shop.id, coords, shop.blip)
            Wait(100)
        end
    elseif query and #query == 0 then
        for i = 1, #Shops['Mercado'].coords do
            local shop = Shops['Mercado'].coords[i]
            exports.oxmysql:executeSync('INSERT INTO lotus_shops (coords, blip) VALUES (?, ?)', { json.encode(vec3(shop.coords[1], shop.coords[2], shop.coords[3])), shop.blip })
        end
    end
end)