------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local COINS_GENERATE = false
local COINS_HISTORY = {
    -- ['Bitcoin'] = { LAST 14 DAYS
    --     { value = 1323 },
    --     { value = 1323 },
    --     { value = 1323 },
    --     { value = 1323 },
    --     { value = 1323 },
    -- }
}
local COIN_VALUE = {}

local coinsList = {}
local finishDate = json.decode(LoadResourceFile(GetCurrentResourceName(), 'finishdate.json')) or false

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.requestBankInfo()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local identity = vRP.getUserIdentity(user_id)
    if not identity then return end

    return {
        name = ('%s'):format(identity.nome),
        cards = {
          { balance = vRP.getBankMoney(user_id) or 0 }
        },
        fine = vRP.getMultas(user_id)
    }
end

function RegisterTunnel.tryDeposit(value)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    if value <= 0 then return end

    local status, time = exports['vrp']:getCooldown(user_id, "bank")
    if not status then
        return
    end
    exports['vrp']:setCooldown(user_id, "bank", 5)

    if vRP.tryDeposit(user_id, value) then
        TriggerClientEvent("Notify",source,"sucesso","Você depositou <b>$ "..value.."</b>", 5)
        addExtract(user_id, 'deposit', value)
        vRP.sendLog('deposito', '```prolog\n[ID]: '..user_id..' \n[DEPOSITO]: '..value..' \n[DATA]: '..os.date("%d/%m/%Y %H:%M:%S")..' \r```')
        return true
    end

    TriggerClientEvent("Notify",source,"importante","Você não possui essa quantia para depositar.", 5)
    return false
end

function RegisterTunnel.tryWithdraw(value)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return false end

    local status, time = exports['vrp']:getCooldown(user_id, "bank")
    if not status then
        return
    end
    exports['vrp']:setCooldown(user_id, "bank", 5)

    if value <= 0 then return false end

    if vRP.tryWithdraw(user_id, value) then
        TriggerClientEvent("Notify",source,"sucesso","Você sacou <b>$ "..value.."</b>", 5)
        addExtract(user_id, 'withdraw', value)
        vRP.sendLog('', '```prolog\n[ID]: '..user_id..' \n[SAQUE]: '..value..' \n[DATA]: '..os.date("%d/%m/%Y %H:%M:%S")..' \r```')
        return true
    end

    TriggerClientEvent("Notify",source,"importante","Você não possui essa quantia no banco para sacar.", 5)
    return false
end

function RegisterTunnel.tryTransfer(nuser_id, value)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local status, time = exports['vrp']:getCooldown(user_id, "bank")
    if not status then
        return
    end
    exports['vrp']:setCooldown(user_id, "bank", 5)

    if value <= 0 then return end

    if parseInt(user_id) == parseInt(nuser_id) then
        TriggerClientEvent("Notify",source,"negado","Você não pode transferir para si mesmo.", 5)
        return
    end

    local nsource = vRP.getUserSource(nuser_id)
    if vRP.tryTransfer(user_id, nuser_id, value) then
        if nsource then
            TriggerClientEvent("Notify",nsource,"sucesso","Você acabou de receber uma transferencia de <b>$ "..value.."</b> do ID: <b> "..user_id.."</b>.", 5)
        end
        addExtract(user_id, 'transfer', value)

        TriggerClientEvent("Notify",source,"sucesso","Você acabou de transferir <b>$ "..value.."</b> para o ID: <b> "..nuser_id.."</b>.", 5)
        return true
    else
        TriggerClientEvent("Notify",source,"importante","Você não possui essa quantia para transferir.", 5)
    end

    return false
end

function RegisterTunnel.payFines(value)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local status, time = exports['vrp']:getCooldown(user_id, "bank")
    if not status then
        return
    end
    exports['vrp']:setCooldown(user_id, "bank", 5)

    if value <= 0 then return end
    
    local multas = vRP.getMultas(user_id)
    if multas >= value then
        if vRP.tryTransfer(user_id, 1, value) then -- TODAS MULTAS IREM PARA O ID [1]
            TriggerClientEvent("Notify",source,"sucesso","Você pagou <b>$ "..value.."</b> de multas.", 5)
            vRP.updateMultas(user_id, multas - value)
            addExtract(user_id, 'fines', value)
            return true
        end
    else
        TriggerClientEvent("Notify",source,"negado","Você possui <b>$ "..multas.."</b> de multas.", 5)
    end

    return false
end

function RegisterTunnel.getExtract()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    return getExtract(user_id)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CRYPTOS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.requestCryptos(value)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local query = json.decode(vRP.getUData(user_id, 'player:cryptos')) or {}
    return {
        cryptos = COINS_HISTORY,
        myCryptos = query and query or {}
    }
end

function RegisterTunnel.buyCryptos(name, amount)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local status, time = exports['vrp']:getCooldown(user_id, "banco_crypto")
    if not status then return end
    exports['vrp']:setCooldown(user_id, "banco_crypto", 5)

    if amount <= 0 or type(amount) ~= "number" then return end

    amout = parseInt(amount * 0.85) -- TAXA DE 15%
 
    local coin_value = COINS_HISTORY[name] and COINS_HISTORY[name][#COINS_HISTORY[name]].value or false
    if not coin_value then return end

    local payment = coin_value * amount
    if payment < 1 then
        TriggerClientEvent('Notify',source,'negado','Você não pode comprar essa quantia, compre uma quantidade maior.')
        return
    end

    if vRP.tryFullPayment(user_id, payment) then
        local query = json.decode(vRP.getUData(user_id, 'player:cryptos')) or {}
        if not query[name] then
            query[name] = 0
        end

        query[name] = query[name] + amount

        vRP.setUData(user_id, 'player:cryptos', json.encode(query))
        --addExtract(user_id, 'COMPROU CRYPTO - '..name, payment)

        TriggerClientEvent('Notify',source,'sucesso','Você comprou <b>'..name..'</b> agora possui uma quantidade de <b>'..query[name]..'</b> '.. name ..'x .', 15)
        vRP.sendLog('https://discord.com/api/webhooks/1336433867493474415/_XndJyHdvBUenqaUeLr-sHFgTtgq2mb17MS8szM_iMShi0Ce9gycele-jQ_MiWE73dA7', '```prolog\n[ID]: '..user_id..'\n[COMPRA]: '..name..' '..amount..'x \n[PRICE]: '..payment..' \n[TIME]: '..os.date("%d/%m/%Y %X", os.time())..' \r```')
    else
        TriggerClientEvent('Notify',source,'negado','Você não possui dinheiro para comprar essa quantia.')
    end
end

function RegisterTunnel.sellCryptos(name, amount)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local status, time = exports['vrp']:getCooldown(user_id, "banco_crypto")
    if not status then return end
    exports['vrp']:setCooldown(user_id, "banco_crypto", 5)

    if amount <= 0 or type(amount) ~= "number" then return end
 
    local coin_value = COINS_HISTORY[name] and COINS_HISTORY[name][#COINS_HISTORY[name]].value or false
    if not coin_value then return end

    local payment = (coin_value * amount) * 0.85 -- TAXA DE 15%
    if payment < 1 then
        TriggerClientEvent('Notify',source,'negado','Você não pode vender essa quantia, venda uma quantidade maior.')
        return
    end

    local query = json.decode(vRP.getUData(user_id, 'player:cryptos')) or {}
    if not query[name] then
        query[name] = 0
    end

    if amount > query[name] then
        TriggerClientEvent('Notify',source,'negado','Você não possui essa quantia para vender.')
        return
    end

    query[name] = query[name] - amount
    if query[name] <= 0 then
        query[name] = 0
    end
    
    vRP.giveMoney(user_id, payment)
    vRP.setUData(user_id, 'player:cryptos', json.encode(query))
    --addExtract(user_id, 'VENDEU CRYPTO - '..name, payment)

    TriggerClientEvent('Notify',source,'sucesso','Você vendeu <b>'..name..'</b> '..amount..'x por <b>R$ '..payment..'</b> agora possui uma quantidade de <b>'..query[name]..'</b> '.. name ..'x .', 15)
    vRP.sendLog('https://discord.com/api/webhooks/1336434166681698428/Y4z4L3OodMjP-R5C5T9LfOS5Kk6TCqy3b28ZPbZ8IypV5Hnf0NqU4Q4tM4IZqEAyVqio', '```prolog\n[ID]: '..user_id..'\n[VENDA]: '..name..' '..amount..'x \n[PRICE]: '..payment..' \n[TIME]: '..os.date("%d/%m/%Y %X", os.time())..' \r```')
end

getExtract = function(user_id)
	local data = vRP.getUData(user_id,"bank:Log")
	local result = json.decode(data) or {}

    local t = {}
    for i = 1, #result do
        t[#t + 1] = { type = result[i].type, date = result[i].date, price = result[i].value }
    end

    return t
end


addExtract = function(user_id, type, value)
	local data = vRP.getUData(user_id,"bank:Log")
	local result = json.decode(data) or {}
	if #result > 10 then 
		table.remove(result,1)
	end

	local index = #result + 1
	result[index] = { type = type, value = value, date = os.date("[%d/%m/%Y as %H:%M]")  }
	vRP.setUData(user_id,'bank:Log' ,json.encode(result))
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    coinsList = json.decode(vRP.getSData('LOTUS_BANKS:COINS')) or {}

    if not finishDate or (finishDate.time - os.time()) <= 0 then
        local time = os.time() + 24 * 60 * 60
        finishDate = {
            time = time
        }

        for coin, url in pairs(Config.APIS) do
            if not coinsList[coin] then coinsList[coin] = {} end
    
            PerformHttpRequest(url, function(err, text, headers) 
                if err ~= 200 then
                    tryAttempting(coin, url)
                    return
                end
    
                local data = json.decode(text)
                for k,v in pairs(data) do
                    coinsList[coin][#coinsList[coin] + 1] = data[k].brl
    
                    if #coinsList[coin] >= 14 then
                        table.remove(coinsList[coin], 1)
                    end
                end
            end)
    
            Wait( 5000 )
        end

        SaveResourceFile(GetCurrentResourceName(), 'finishdate.json', json.encode({time = time}), -1)
        vRP.setSData('LOTUS_BANKS:COINS', json.encode(coinsList))
    end

    for coinName, brl in pairs(coinsList) do
        local prefix = (Config.PREFIX[coinName] and Config.PREFIX[coinName] or coinName)

        if not COINS_HISTORY[prefix] then COINS_HISTORY[prefix] = {} end
        for i = 1, #coinsList[coinName] do
            COINS_HISTORY[prefix][i] = { value = coinsList[coinName][i] }
            COIN_VALUE[prefix] = coinsList[coinName][i]
        end

    end
    
    COINS_GENERATE = true
end)

tryAttempting = function(coin, url)
    CreateThread(function()
        Wait(60000)
        PerformHttpRequest(url, function(err, text, headers) 
            if err ~= 200 then
                tryAttempting(coin, url)
                return
            end

            local data = json.decode(text)
            for k,v in pairs(data) do
                if not coinsList[coin] then coinsList[coin] = {} end
                coinsList[coin][#coinsList[coin] + 1] = data[k].brl
                
                if #coinsList[coin] >= 14 then
                    table.remove(coinsList[coin], 1)
                end
            end
        end)

        for coinName, brl in pairs(coinsList) do
            local prefix = (Config.PREFIX[coinName] and Config.PREFIX[coinName] or coinName)
    
            if not COINS_HISTORY[prefix] then COINS_HISTORY[prefix] = {} end
            for i = 1, #coinsList[coinName] do
                COINS_HISTORY[prefix][i] = { value = coinsList[coinName][i] }
                COIN_VALUE[prefix] = coinsList[coinName][i]
            end
        end

        SetTimeout(2000, function()
            vRP.setSData('LOTUS_BANKS:COINS', json.encode(coinsList))
        end)
    end)
end

function addBank(id, coords, isBank)
    if not coords.x then
        coords = vec3(tonumber(coords[1]), tonumber(coords[2]), tonumber(coords[3]))
    end

    Config.locations[tostring(id)] = { coords = vec3(coords.x, coords.y, coords.z), isBank = isBank }
    vTunnel.addBank(-1, id, coords, isBank)
end

function removeBank(id)
    Config.locations[tostring(id)] = nil
    vTunnel.removeBank(-1, id)
end

function syncBanksWithPlayer(source)
    for id, data in pairs(Config.locations) do
        if data.coords then
            local coords = data.coords
            local isBank = data.isBank
            vTunnel.addBank(source, id, coords, isBank)
        end
    end
end

AddEventHandler('vRP:playerSpawn', function(userId, source)
    syncBanksWithPlayer(source)
end)

exports('getBanks', function()
    local banks = {}
    for id, data in pairs(Config.locations) do
        if data.coords then
            table.insert(banks, {
                id = tonumber(id),
                coords = data.coords,
                isBank = data.isBank
            })
        end
    end
    table.sort(banks, function(a, b)
        return a.id < b.id
    end)
    return banks
end)

exports('addBank', function(coords, isBank)
    if not coords.x then
        coords = vec3(tonumber(coords[1]), tonumber(coords[2]), tonumber(coords[3]))
    end
    local query = exports.oxmysql:executeSync(
        'INSERT INTO lotus_banks (coords, isBank) VALUES (?, ?)',
        { json.encode(coords), isBank }
    )
    if query and query.insertId then
        addBank(query.insertId, coords, isBank)
        return true, 'Banco adicionado com sucesso'
    end
    return false, 'Falha ao adicionar o banco'
end)

exports('removeBank', function(id)
    local query = exports.oxmysql:executeSync('DELETE FROM lotus_banks WHERE id = ?', { id })
    if query then
        removeBank(id)
        return true, 'Banco removido com sucesso'
    end
    return false, 'Falha ao remover o banco'
end)

CreateThread(function()
    exports.oxmysql:executeSync([[CREATE TABLE IF NOT EXISTS lotus_banks (
        id INT AUTO_INCREMENT PRIMARY KEY,
        coords VARCHAR(255) NOT NULL,
        isBank BOOLEAN NOT NULL DEFAULT FALSE
    )]])
    Wait(250)

    local query = exports.oxmysql:executeSync('SELECT * FROM lotus_banks')
    if query and #query > 0 then
        for _, bank in ipairs(query) do
            local coords = json.decode(bank.coords)
            if type(coords) == "table" and coords[1] and coords[2] and coords[3] then
                coords = vec3(tonumber(coords[1]), tonumber(coords[2]), tonumber(coords[3]))
            end
            addBank(bank.id, coords, bank.isBank)
            Wait(100)
        end
    elseif query and #query == 0 then
        for i = 1, #Config.locations do
            local bank = Config.locations[i]
            exports.oxmysql:executeSync('INSERT INTO lotus_banks (coords, isBank) VALUES (?, ?)', { json.encode(bank.coords), bank.isBank })
        end
    end
end)