------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ACCOUNTS = {
    users = {
        -- [10] = { @@user_id ( servidor )
        -- "found": true,
            -- "data": {
            --     "identifiers": "[\"license:91104e993315803b21627150df56eb969867bca0\",\"xbl:2535412562117175\",\"live:1055521064662377\",\"discord:396877259811717122\",\"fivem:101117\",\"license2:91104e993315803b21627150df56eb969867bca0\"]",
            --     "banner": "default.png",
            --     "color": "#B51A00",
            --     "nickname": "Mirtin",
            --     "user_id": 6,
            --     "email": "conrado-henrique@live.com"
            -- }
        -- }
    },

    users_name = {
        -- ['mirtinzera'] = 10,
    },

    users_accounts = {
        -- [333] = 10, -- account_id, user_id
    },

    registering = {
        -- [10] = true @@user_id
    },
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CreateTunnel.open()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    local weapons = vRPclient.getWeapons(source) or {}
	local count = 0
	for weapon in pairs(weapons) do count = count + 1 end
	if count > 0 then 
		TriggerClientEvent('Notify', source, 'negado', 'Você não pode entrar com armas.', 5000)
		return
	end

    local ids = GetPlayerIdentifiers(source)
    if not ids or #ids <= 0 then
        return
    end

    if not ACCOUNTS.users[user_id] then
        return ACCOUNTS:find(ids, function(data)
            if data.found then
                ACCOUNTS.users[user_id] = data
                ACCOUNTS.users[user_id].data.last_matchs = json.decode(data.data.last_matchs) or {}
                ACCOUNTS.users_accounts[data.data.user_id] = user_id
                ACCOUNTS.users_name[data.data.nickname] = {
                    user_id = user_id,
                    source = source
                }
                
                Execute._openLobby(source)
            else
                ACCOUNTS.registering[user_id] = true
                Execute._openRegister(source)
            end
        end)
    end

    Execute._openLobby(source)
end

function CreateTunnel.register(data)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    if not ACCOUNTS.registering[user_id] then
        return
    end

    local ids = GetPlayerIdentifiers(source)
    if not ids or #ids <= 0 then
        return
    end

    return ACCOUNTS:createUser(source, user_id, ids, data)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ACCOUNTS:find(ids, callback)
    local formatIds = {}
    for i = 1, #ids do
        if ids[i]:find('ip:') == nil then
            formatIds[#formatIds + 1] = ids[i]
        end
    end

    PerformHttpRequest(Config.route.."/user/get", function(statusCode, response, headers)
        local data = {}
        if statusCode ~= 200 then
            callback({ found = false })
            return
        end

        data = json.decode(response)
        callback(data)
    end, "GET", json.encode({ identifiers = formatIds }), {
        ["Content-Type"] = "application/json"
    })
end

function ACCOUNTS:createUser(source, user_id, ids, data)
    local formatIds = {}
    for i = 1, #ids do
        if ids[i]:find('ip:') == nil then
            formatIds[#formatIds + 1] = ids[i]
        end
    end

    local payload = {
        identifiers = formatIds,
        nickname = data.name,
        email = data.email,
        color = data.banner,
        banner = "default.png",
    }

    local p = promise.new()
    PerformHttpRequest(Config.route.."/user/add", function(statusCode, response, headers)
        local data = {}
        if statusCode ~= 201 then
            p:resolve({ created = false, error = 'error '..statusCode })
            return
        end

        data = json.decode(response)
        p:resolve(data)
    end, "POST", json.encode(payload), {
        ["Content-Type"] = "application/json"
    })

    local data = Citizen.Await(p)
    if not data.created then
        TriggerClientEvent("Notify", source, "negado", "Já existe esse usuario com esse nome.", 5 )
        return false
    end
    
    ACCOUNTS.users[user_id] = {
        found = true,
        data = payload
    }
    ACCOUNTS.users[user_id].data.user_id = data.user_id
    ACCOUNTS.users[user_id].data.points = 0

    ACCOUNTS.registering[user_id] = nil

    return true
end

function ACCOUNTS:updatePoints(data)
    PerformHttpRequest(Config.route.."/user/updatePoints", function(statusCode, response, headers) end, "POST", json.encode(data), { ["Content-Type"] = "application/json" })
end

function ACCOUNTS:updateMatchs(data)
    PerformHttpRequest(Config.route.."/user/updateMatchs", function(statusCode, response, headers) end, "POST", json.encode(data), { ["Content-Type"] = "application/json" })
end

function ACCOUNTS:updateKills(data)
    PerformHttpRequest(Config.route.."/user/updateKills", function(statusCode, response, headers) end, "POST", json.encode(data), { ["Content-Type"] = "application/json" })
end

function ACCOUNTS:updateWins(data)
    PerformHttpRequest(Config.route.."/user/updateWins", function(statusCode, response, headers) end, "POST", json.encode(data), { ["Content-Type"] = "application/json" })
end