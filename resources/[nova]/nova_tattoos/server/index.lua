-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("vrp_tattos",cRP)
vCLIENT = Tunnel.getInterface("vrp_tattos")

-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateTattoo(status)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.updateUserApparence(user_id, "tattos", status)
		vRP.execute("apparence/tattos",{ user_id = user_id, tattos = json.encode(status) })
		vCLIENT._setTattos(source, status)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETINSTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
-- function cRP.setInstance(status)
--     local source = source 
--     local user_id = vRP.getUserId(source)
--     if user_id then 
-- 		if status then
-- 			SetPlayerRoutingBucket(source, user_id)
-- 		else
-- 			SetPlayerRoutingBucket(source, 0)
-- 		end
--     end
-- end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("tattos:init", function(user_id)
	local source = vRP.getUserSource(user_id)
	if source and user_id then
		local data = vRP.getUserApparence(user_id)
		vCLIENT._setTattos(source, data.tattos)
	end
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
		for _, player in pairs(GetPlayers()) do
			local userId = vRP.getUserId(tonumber(player))
			if userId then
				TriggerEvent("tattos:init", userId)
			end
		end
    end
end)

function addTattooShop(id, coords, blip)
    if not coords.x then
        coords = vec3(tonumber(coords[1]), tonumber(coords[2]), tonumber(coords[3]))
    end

    locateTattoos[tostring(id)] = { coords.x, coords.y, coords.z, blip }
    vCLIENT.addTattooShop(-1, id, coords, blip)
end

function removeTattooShop(id)
    locateTattoos[tostring(id)] = nil
    vCLIENT.removeTattooShop(-1, id)
end

function syncTattoosWithPlayer(source)
    for id, data in pairs(locateTattoos) do
        if data[1] then
            local coords = vec3(data[1], data[2], data[3])
            local blip = data[4]
            vCLIENT.addTattooShop(source, id, coords, blip)
        end
    end
end

AddEventHandler('vRP:playerSpawn', function(userId, source)
    syncTattoosWithPlayer(source)
end)

exports('getTattooShops', function()
    local tattooShops = {}
    for id, data in pairs(locateTattoos) do
        if data[1] then
            table.insert(tattooShops, {
                id = tonumber(id),
                coords = vec3(data[1], data[2], data[3]),
                blip = data[4]
            })
        end
    end
    table.sort(tattooShops, function(a, b)
        return a.id < b.id
    end)
    return tattooShops
end)

exports('addTattooShop', function(coords, blip)
    if not coords.x then
        coords = vec3(tonumber(coords[1]), tonumber(coords[2]), tonumber(coords[3]))
    end
    local query = exports.oxmysql:executeSync(
        'INSERT INTO lotus_tattooshops (coords, blip) VALUES (?, ?)',
        { json.encode(coords), blip }
    )
    if query and query.insertId then
        addTattooShop(query.insertId, coords, blip)
        return true, 'Loja de tatuagem adicionada com sucesso'
    end
    return false, 'Falha ao adicionar a loja de tatuagem'
end)

exports('removeTattooShop', function(id)
    local query = exports.oxmysql:executeSync('DELETE FROM lotus_tattooshops WHERE id = ?', { id })
    if query then
        removeTattooShop(id)
        return true, 'Loja de tatuagem removida com sucesso'
    end
    return false, 'Falha ao remover a loja de tatuagem'
end)

CreateThread(function()
    exports.oxmysql:executeSync([[CREATE TABLE IF NOT EXISTS lotus_tattooshops (
        id INT AUTO_INCREMENT PRIMARY KEY,
        coords VARCHAR(255) NOT NULL,
        blip BOOLEAN NOT NULL DEFAULT FALSE
    )]])
    Wait(250)

    local query = exports.oxmysql:executeSync('SELECT * FROM lotus_tattooshops')
    if query and #query > 0 then
        for _, tattooShop in ipairs(query) do
            local coords = json.decode(tattooShop.coords)
            if type(coords) == "table" and coords[1] and coords[2] and coords[3] then
                coords = vec3(tonumber(coords[1]), tonumber(coords[2]), tonumber(coords[3]))
            end
            addTattooShop(tattooShop.id, coords, tattooShop.blip)
            Wait(100)
        end
    elseif query and #query == 0 then
        for i = 1, #locateTattoos do
            local tattooShop = locateTattoos[i]
            exports.oxmysql:executeSync('INSERT INTO lotus_tattooshops (coords, blip) VALUES (?, ?)', { json.encode(vec3(tattooShop[1], tattooShop[2], tattooShop[3])), tattooShop[4] })
        end
    end
end)

exports('setTattos', function(nSource, data)
    vCLIENT._setTattos(nSource, data)
end)