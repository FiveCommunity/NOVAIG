function serverFunctions.saveCloths(clothes)
    local src = source
    local user_id = vRP.getUserId(src)

    if user_id then
        vRP.execute("apparence/roupas",{ user_id = user_id, roupas = json.encode(clothes) })
		vRP.updateUserApparence(user_id, "clothes", clothes)
    end
end

function serverFunctions.checkPermission()
    local src = source
    local user_id = vRP.getUserId(src)

    return vRP.hasGroup(user_id,"developerlotusgroup@445") or vRP.hasGroup(user_id,"respilegallotusgroup@445") 
    or vRP.hasGroup(user_id,"gestaolotusgroup@445") or vRP.hasGroup(user_id,"respeventoslotusgroup@445") or vRP.hasGroup(user_id,"supervisorlotusgroup@445")
end

function addSkinshop(id, coords, blip)
    if not coords.x then
        coords = vec3(tonumber(coords[1]), tonumber(coords[2]), tonumber(coords[3]))
    end

    locateShops[tostring(id)] = { coords.x, coords.y, coords.z, blip }
    clientFunctions.addSkinshop(-1, id, coords, blip)
end

function removeSkinshop(id)
    locateShops[tostring(id)] = nil
    clientFunctions.removeSkinshop(-1, id)
end

function syncSkinshopsWithPlayer(source)
    for id, data in pairs(locateShops) do
        if data[1] then
            local coords = vec3(data[1], data[2], data[3])
            local blip = data[4]
            clientFunctions.addSkinshop(source, id, coords, blip)
        end
    end
end

AddEventHandler('vRP:playerSpawn', function(userId, source)
    syncSkinshopsWithPlayer(source)
end)

exports('getSkinShops', function()
    local skinShops = {}
    for id, data in pairs(locateShops) do
        if data[1] then
            table.insert(skinShops, {
                id = tonumber(id),
                coords = vec3(data[1], data[2], data[3]),
                blip = data[4]
            })
        end
    end
    table.sort(skinShops, function(a, b)
        return a.id < b.id
    end)
    return skinShops
end)

exports('addSkinshop', function(coords, blip)
    if not coords.x then
        coords = vec3(tonumber(coords[1]), tonumber(coords[2]), tonumber(coords[3]))
    end
    local query = exports.oxmysql:executeSync(
        'INSERT INTO lotus_skinshops (coords, blip) VALUES (?, ?)',
        { json.encode(coords), blip }
    )
    if query and query.insertId then
        addSkinshop(query.insertId, coords, blip)
        return true, 'Loja de roupas adicionada com sucesso'
    end
    return false, 'Falha ao adicionar a loja de roupas'
end)

exports('removeSkinshop', function(id)
    local query = exports.oxmysql:executeSync('DELETE FROM lotus_skinshops WHERE id = ?', { id })
    if query then
        removeSkinshop(id)
        return true, 'Loja de roupas removida com sucesso'
    end
    return false, 'Falha ao remover a loja de roupas'
end)

CreateThread(function()
    exports.oxmysql:executeSync([[CREATE TABLE IF NOT EXISTS lotus_skinshops (
        id INT AUTO_INCREMENT PRIMARY KEY,
        coords VARCHAR(255) NOT NULL,
        blip BOOLEAN NOT NULL DEFAULT FALSE
    )]])
    Wait(250)

    local query = exports.oxmysql:executeSync('SELECT * FROM lotus_skinshops')
    if query and #query > 0 then
        for _, skinShop in ipairs(query) do
            local coords = json.decode(skinShop.coords)
            if type(coords) == "table" and coords[1] and coords[2] and coords[3] then
                coords = vec3(tonumber(coords[1]), tonumber(coords[2]), tonumber(coords[3]))
            end
            addSkinshop(skinShop.id, coords, skinShop.blip)
            Wait(100)
        end
    elseif query and #query == 0 then
        for i = 1, #locateShops do
            local shop = locateShops[i]
            exports.oxmysql:executeSync('INSERT INTO lotus_skinshops (coords, blip) VALUES (?, ?)', { json.encode(vec3(shop[1], shop[2], shop[3])), shop[4] })
        end
    end
end)