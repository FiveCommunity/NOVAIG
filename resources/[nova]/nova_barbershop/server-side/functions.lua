AddEventHandler("barbershop:init", function(user_id)
	local source = vRP.getUserSource(user_id)
	if source then
		local data = vRP.getUserApparence(user_id)
		if user_id then
			if data['rosto'] then
				clientFunctions.setCharacter(source, data['rosto'])
			end
		end
	end
end)

RegisterCommand('loja3', function(source, args)
    local userId = vRP.getUserId(source)
    local perms = {
        { permType = 'perm', perm = 'developer.permissao' },
    }

    local hasPermission = false
    for _, perm in pairs(perms) do
        if perm.permType == 'perm' then
            if vRP.hasPermission(userId, perm.perm) then
                hasPermission = true
                break
            end
        elseif perm.permType == 'group' then
            if vRP.hasGroup(userId, perm.perm) then
                hasPermission = true
                break
            end
        end
    end

    if not hasPermission then
        return
    end

    clientFunctions.openNuiShop(source)
end)

function serverFunctions.updateSkin(skinUpdate)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.updateUserApparence(user_id, "rosto", skinUpdate)
		vRP.execute("apparence/rosto",{ user_id = user_id, rosto = json.encode(skinUpdate) })
	end
end

function addBarberShop(id, coords, blip)
    locations[tostring(id)] = { coords.x, coords.y, coords.z, blip }
    clientFunctions.addBarberShop(-1, id, coords, blip)
end

function removeBarberShop(id)
    locations[tostring(id)] = nil
    clientFunctions.removeBarberShop(-1, id)
end

function syncBarberShopsWithPlayer(source)
    for id, data in pairs(locations) do
        if data[1] then
            local coords = vec3(data[1], data[2], data[3])
            local blip = data[4]
            clientFunctions.addBarberShop(source, id, coords, blip)
        end
    end
end

AddEventHandler('vRP:playerSpawn', function(userId, source)
    syncBarberShopsWithPlayer(source)
end)

exports('getBarberShops', function()
    local barberShops = {}
    for id, data in pairs(locations) do
        if data[1] then
            table.insert(barberShops, {
                id = tonumber(id),
                coords = vec3(data[1], data[2], data[3]),
                blip = data[4]
            })
        end
    end
    table.sort(barberShops, function(a, b)
        return a.id < b.id
    end)
    return barberShops
end)

exports('addBarberShop', function(coords, blip)
    local query = exports.oxmysql:executeSync('INSERT INTO lotus_barbershop (coords, blip) VALUES (?, ?)', { json.encode(vec3(coords[1], coords[2], coords[3])), blip })
    if query and query.insertId then
        addBarberShop(query.insertId, vec3(coords[1], coords[2], coords[3]), blip)
        return true, 'Barbearia adicionada com sucesso'
    end
    return false, 'Falha ao adicionar a barbearia'
end)

exports('removeBarberShop', function(id)
    local query = exports.oxmysql:executeSync('DELETE FROM lotus_barbershop WHERE id = ?', { id })
    if query then
        removeBarberShop(id)
        return true, 'Barbearia removida com sucesso'
    end
    return false, 'Falha ao remover a barbearia'
end)

CreateThread(function()
    exports.oxmysql:executeSync([[
        CREATE TABLE IF NOT EXISTS lotus_barbershop (
            id INT AUTO_INCREMENT PRIMARY KEY,
            coords VARCHAR(255) NOT NULL,
            blip BOOLEAN NOT NULL DEFAULT FALSE
        )
    ]])
    Wait(250)

    local query = exports.oxmysql:executeSync('SELECT * FROM lotus_barbershop')
    if query and #query > 0 then
        for _, barberShop in ipairs(query) do
            local coords = json.decode(barberShop.coords)
            if type(coords) == "table" and coords[1] and coords[2] and coords[3] then
                coords = vec3(tonumber(coords[1]), tonumber(coords[2]), tonumber(coords[3]))
            end 
            addBarberShop(barberShop.id, vec3(coords.x, coords.y, coords.z), barberShop.blip)
            Wait(100)
        end
    elseif query and #query == 0 then
        for i = 1, #locations do
            local shop = locations[i]
            exports.oxmysql:executeSync('INSERT INTO lotus_barbershop (coords, blip) VALUES (?, ?)', { json.encode(vec3(shop[1], shop[2], shop[3])), shop[4] })
        end
    end
end)

AddEventHandler("onResourceStart", function(resource)
	if resource == GetCurrentResourceName() then
		for _, nSource in pairs(GetPlayers()) do
			local nuserId = vRP.getUserId(tonumber(nSource))
			if nuserId then
				TriggerEvent("barbershop:init", nuserId)
			end
		end
	end
end)