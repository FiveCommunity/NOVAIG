local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

ServerAPI = {}
Tunnel.bindInterface(GetCurrentResourceName(), ServerAPI)
ClientAPI = Tunnel.getInterface(GetCurrentResourceName())

local userPasses = {}

CreateThread(function()
    exports.oxmysql:execute([[
        CREATE TABLE IF NOT EXISTS lotus_pass_v2 (
            user_id INT UNIQUE,
            pass_type VARCHAR(255),
            redeemed_levels TEXT
        )
    ]])
end)

function ServerAPI.getUserPass()
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then
        return {}
    end

    if not userPasses[userId] then
        userPasses[userId] = BattlePass:new(userId)
        userPasses[userId]:startCounter()
    end

    local items = userPasses[userId]:getItems()
    return {
        season = 1,
        imagesUrl = Config.imagesURL,
        discordUrl = Config.websiteURL,
        passType = userPasses[userId].passType,
        progress = userPasses[userId]:calculateProgress(),
        items = items,
        leftDays = userPasses[userId]:calculateLeftDays(),
        days = userPasses[userId]:getCurrentDay(),
    }
end

function ServerAPI.redeemItem(item)
    if type(item) ~= 'table' then
        return
    end
    
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then
        return
    end

    if not userPasses[userId] then
        return {}
    end

    userPasses[userId]:redeemItem(item)
    return userPasses[userId]:getItems()
end

AddEventHandler('vRP:playerSpawn', function(userId, source, first_spawn)
    if not userId then
        return 
    end

    if not userPasses[userId] then
        userPasses[userId] = BattlePass:new(userId)
        userPasses[userId]:startCounter()
    end
end)

AddEventHandler('playerDropped', function()
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then
        return
    end

    if userPasses[userId] then
        userPasses[userId]:saveData()
        userPasses[userId]:stopCounter()
        userPasses[userId] = nil
    end
end)

function setPremiumPass(userId)
    if not userId then
        return
    end

    if userPasses[userId] then
        userPasses[userId].passType = 'premium'
    end

    local query = exports.oxmysql:executeSync('SELECT pass_type FROM lotus_pass_v2 WHERE user_id = ?', { userId })
    if #query > 0 then
        exports.oxmysql:execute('UPDATE lotus_pass_v2 SET pass_type = ? WHERE user_id = ?', { 'premium', userId })
    else
        exports.oxmysql:execute('INSERT INTO lotus_pass_v2 (user_id, pass_type, redeemed_levels) VALUES (?, ?, ?)', { userId, 'premium', json.encode({}) })
    end
    print('Premium pass set for user ' .. userId)
end

exports('setPremiumPass', setPremiumPass)

RegisterCommand('setpremiumpass', function(source, args)
    local hasPermission = false
    if source == 0 or vRP.hasPermission(vRP.getUserId(source), 'developer.permissao') then
        hasPermission = true
    end

    if not hasPermission then
        return
    end

    local userId = tonumber(args[1])
    if not userId then
        return
    end

    setPremiumPass(userId)
end)

RegisterCommand('resetpass', function(source, args)
    local hasPermission = false
    if source == 0 or vRP.hasPermission(vRP.getUserId(source), 'developer.permissao') then
        hasPermission = true
    end

    if not hasPermission then
        return
    end

    local userId = tonumber(args[1])
    if not userId then
        return
    end

    if userPasses[userId] then
        userPasses[userId].redeemedDays = {}
    else
        exports.oxmysql:execute('UPDATE lotus_pass_v2 SET redeemed_levels = ? WHERE user_id = ?', { json.encode({}), userId })
    end
end)

RegisterCommand('salvarpasse', function ()
    if source ~= 0 then return end 

    for userId, pass in pairs(userPasses) do 
        pass:saveData()
    end

    print('Passes salvos com sucesso!')
end)

-- CreateThread(function()
--     local query = exports.oxmysql:executeSync('SELECT * FROM lotus_pass_v2')
--     for _, v in ipairs(query) do
--         local levels = json.decode(v.redeemed_levels)
--         for _, level in pairs(levels) do
--             if tonumber(level) == 4 then
--                 Config.items[4].func(v.user_id)
--                 print('Vale ap devolvido para o id ' .. v.user_id)
--             end
--         end
--     end
-- end)