local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

ServerAPI = {}
Tunnel.bindInterface(GetCurrentResourceName(), ServerAPI)
ClientAPI = Tunnel.getInterface(GetCurrentResourceName())

local rafflesCache = nil
local buyedCache = { usersNumbers = {}, numbersOwners = {}, totalBuyed = 0 }
local winnerId = nil

--- @param userId number
--- @return boolean
local function hasStaffPermission(userId)
    if type(userId) ~= 'number' then
        return false
    end    

    for _, permission in pairs(Config.StaffPermissions) do
        if permission.permissionType == 'perm' then
            if vRP.hasPermission(userId, permission.permission) then
                return true
            end
        elseif permission.permissionType == 'group' then
            if vRP.hasGroup(userId, permission.permission) then
                return true
            end
        end
    end

    return false
end

---@param number string
---@return number
local function parseNumber(number)
    if type(number) ~= 'string' then
        return nil
    end

    local cleanedNumber = number
        :gsub('R%$', '')
        :gsub('%s+', '')
        :gsub('%.', '')
        :gsub(',', '.')
    return tonumber(cleanedNumber)
end

---@param amount number
---@param prices table
---@return number
local function calculateTotal(amount, prices)
    if type(amount) ~= 'number' or type(prices) ~= 'table' then
        return 0
    end

    if amount <= 0 then
        return 0
    end

    local total = 0
    local rifasRestantes = amount

    local loteSizes = {}
    for loteSize in pairs(prices) do
        table.insert(loteSizes, tonumber(loteSize))
    end
    table.sort(loteSizes, function(a, b) return a > b end)

    for _, loteSize in ipairs(loteSizes) do
        if rifasRestantes >= loteSize then
            local lotesCompletos = math.floor(rifasRestantes / loteSize)
            total = total + lotesCompletos * prices[tostring(loteSize)]
            rifasRestantes = rifasRestantes % loteSize
        end
    end

    return total
end

---@param date string
---@param hour string
---@return number
local function convertToTimestamp(date, hour)
    if type(date) ~= 'string' or type(hour) ~= 'string' then
        return nil
    end

    local day, month, year = date:match("(%d%d)/(%d%d)/(%d%d%d%d)")
    local h, m = hour:match("(%d%d):(%d%d)")

    local timestamp = os.time({
        year = tonumber(year),
        month = tonumber(month),
        day = tonumber(day),
        hour = tonumber(h),
        min = tonumber(m),
        sec = 0
    })

    return timestamp
end

---@param userId number
---@return table
local function getMyNumbers(userId)
    if type(userId) ~= 'number' then
        return {}
    end

    local usersNumbers = {}
    if buyedCache and buyedCache.usersNumbers[userId] then
        for number, _ in pairs(buyedCache.usersNumbers[userId]) do
            table.insert(usersNumbers, number)
        end
    end

    return usersNumbers
end

---@return table
function ServerAPI.getRaffleData()
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then
        return nil
    end

    if not rafflesCache then
        return nil
    end

    return {
        title = rafflesCache.item.title,
        description = rafflesCache.item.description,
        image_url = rafflesCache.item.image,
        prices = rafflesCache.prices,
        endAt = rafflesCache.endAt * 1000,
        titles = getMyNumbers(userId),
        totalBuyed = buyedCache.totalBuyed,
    }

end

---@param data table
---@return boolean
function ServerAPI.createRaffle(data)
    if type(data) ~= 'table' then
        return false
    end

    local source = source
    local userId = vRP.getUserId(source)
    if not userId or not hasStaffPermission(userId) then
        return false
    end

    if rafflesCache then
        TriggerClientEvent('Notify', source, 'negado', 'Não é possível criar mais de um sorteio ao mesmo tempo.')
        return false
    end

    local item = data.item
    local initialNumber = tonumber(data.initialNumber)
    local finalNumber = tonumber(data.finalNumber)
    local finishData = data.date
    local finishHour = data.hour
    local endAt = convertToTimestamp(finishData, finishHour)
    local prices = {}
    for k, price in pairs(data.prices) do
        prices[tonumber(k)] = parseNumber(price)
    end

    if not item or not initialNumber or not finalNumber or not finishData or not finishHour or not prices or not endAt then
        TriggerClientEvent('Notify', source, 'negado', 'Dados inválidos.')
        return false
    end

    exports.oxmysql:executeSync(
        'INSERT INTO `lotus_raffle` (item, initial_number, final_number, prices, end_at) VALUES(?, ?, ?, ?, ?)', 
        { json.encode(item), initialNumber, finalNumber, json.encode(prices), endAt }
    )

    Wait(1000)
    rafflesCache = nil
    winnerId = nil
    buyedCache = { usersNumbers = {}, numbersOwners = {}, totalBuyed = 0 }
    local raffleQuery = exports.oxmysql:singleSync('SELECT * FROM `lotus_raffle`')
    if raffleQuery then
        rafflesCache = {
            item = json.decode(raffleQuery.item),
            initialNumber = raffleQuery.initial_number,
            finalNumber = raffleQuery.final_number,
            prices = json.decode(raffleQuery.prices),
            endAt = raffleQuery.end_at,
        }
    end

    local buyedQuery = exports.oxmysql:executeSync('SELECT * FROM `lotus_raffle_buyed`')
    if buyedQuery and #buyedQuery > 0 then
        for _, buyed in pairs(buyedQuery) do

            buyedCache.numbersOwners[buyed.number] = buyed.user_id
            if not buyedCache.usersNumbers[buyed.user_id] then
                buyedCache.usersNumbers[buyed.user_id] = {}
            end

            buyedCache.usersNumbers[buyed.user_id][buyed.number] = true
            buyedCache.totalBuyed = buyedCache.totalBuyed + 1
        end
    end

    return true
end

local paymentQueue = {}
local processingPayment = false

---@param amount number
---@return boolean
function ServerAPI.buy(amount)
    if type(amount) ~= 'number' then
        return false
    end

    local source = source
    local userId = vRP.getUserId(source)
    if not userId then
        return false
    end

    if amount <= 0 then
        return false
    end

    table.insert(paymentQueue, {source = source, userId = userId, amount = amount})
    processQueue()
    return true
end

function processQueue()
    if processingPayment then
        return
    end

    if #paymentQueue == 0 then
        return
    end

    local currentPayment = table.remove(paymentQueue, 1)
    processingPayment = true

    local source = currentPayment.source
    local userId = currentPayment.userId
    local amount = currentPayment.amount

    local maxNumbers = rafflesCache.finalNumber - rafflesCache.initialNumber + 1
    local remainingNumbers = maxNumbers - buyedCache.totalBuyed
    if amount > remainingNumbers then
        TriggerClientEvent('Notify', source, 'negado', 'Você não pode comprar mais números. Restam apenas ' .. remainingNumbers .. ' números.')
        processingPayment = false
        processQueue()
        return
    end

    local total = calculateTotal(amount, rafflesCache.prices)
    if not vRP.tryFullPayment(userId, total) then
        TriggerClientEvent('Notify', source, 'negado', 'Você não tem dinheiro suficiente.')
        processingPayment = false
        processQueue()
        return
    end

    TriggerClientEvent('Notify', source, 'aviso', 'Aguarde um momento, estamos processando sua compra...')
    for i = 1, amount do
        local randomNumber = math.random(rafflesCache.initialNumber, rafflesCache.finalNumber)
        while buyedCache.numbersOwners[randomNumber] do
            randomNumber = math.random(rafflesCache.initialNumber, rafflesCache.finalNumber)
        end

        buyedCache.numbersOwners[randomNumber] = userId
        if not buyedCache.usersNumbers[userId] then
            buyedCache.usersNumbers[userId] = {}
        end
        buyedCache.usersNumbers[userId][randomNumber] = true
        buyedCache.totalBuyed = buyedCache.totalBuyed + 1
        exports.oxmysql:executeSync('INSERT INTO `lotus_raffle_buyed` (user_id, number) VALUES(?, ?)', {userId, randomNumber})
    end

    TriggerClientEvent('Notify', source, 'sucesso', 'Você comprou ' .. amount .. ' números por R$ ' .. total .. '.')
    vRP.sendLog('https://discord.com/api/webhooks/1318632648960245863/0tMVLVgvEca-oB5pYApR70FWVECkg_zqxQnqb-WlrWbiko29GOMjMo9dfp8GBtlAYPbr', string.format('```prolog\n[USUARIO]: %s\n[COMPROU]: %s numeros\n[VALOR]: R$ %s\n[NUMEROS RESTANTES]: %s\n[NUMEROS COMPRADOS]: %s```', userId, vRP.format(amount), vRP.format(total), vRP.format(remainingNumbers), vRP.format(maxNumbers - remainingNumbers)))
    processingPayment = false

    processQueue()
end

RegisterCommand(Config.Commands.ConfigCommand, function (source, args)
    local userId = vRP.getUserId(source)
    if not userId then
        return
    end

    if not hasStaffPermission(userId) then
        return
    end

    ClientAPI.openRaffleCreate(source)
end)

RegisterCommand(Config.Commands.ResetCommand, function (source, args)
    local userId = vRP.getUserId(source)
    if not userId then
        return
    end

    if not hasStaffPermission(userId) then
        return
    end

    if not rafflesCache then
        TriggerClientEvent('Notify', source, 'negado', 'Não há sorteios ativos.')
        return
    end

    rafflesCache = nil
    winnerId = nil
    buyedCache = { usersNumbers = {}, numbersOwners = {}, totalBuyed = 0 }
    exports.oxmysql:executeSync('DELETE FROM `lotus_raffle`')
    exports.oxmysql:executeSync('DELETE FROM `lotus_raffle_buyed`')
    TriggerClientEvent('Notify', source, 'sucesso', 'Sorteios resetados com sucesso.')
end)

RegisterCommand(Config.Commands.FinishCommand, function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then
        return
    end

    if not hasStaffPermission(userId) then
        return
    end

    if not rafflesCache then
        TriggerClientEvent('Notify', source, 'negado', 'Não há sorteios ativos.')
        return
    end

    if not buyedCache or buyedCache.totalBuyed == 0 then
        TriggerClientEvent('Notify', source, 'negado', 'Não há números comprados.')
        return
    end

    TriggerClientEvent('Notify', source, 'aviso', 'Aguarde um momento, estamos processando o sorteio...')

    local boughtNumbers = {}
    for number, _ in pairs(buyedCache.numbersOwners) do
        table.insert(boughtNumbers, number)
    end

    if #boughtNumbers == 0 then
        TriggerClientEvent('Notify', source, 'negado', 'Erro ao processar o sorteio: nenhum número comprado foi encontrado.')
        return
    end

    local randomIndex = math.random(1, #boughtNumbers)
    local randomNumber = boughtNumbers[randomIndex]

    local winnerUserId = buyedCache.numbersOwners[randomNumber]
    local rewardType = Config.RewardsTypes[rafflesCache.item.rewardType]
    if rewardType then
        rewardType.reward(winnerUserId, rafflesCache.item.reward)
    end

    if winnerId then
        winnerUserId = winnerId
    end

    rafflesCache = nil
    winnerId = nil
    buyedCache = { usersNumbers = {}, numbersOwners = {}, totalBuyed = 0 }
    exports.oxmysql:executeSync('DELETE FROM `lotus_raffle`')
    exports.oxmysql:executeSync('DELETE FROM `lotus_raffle_buyed`')
    TriggerClientEvent('Notify', source, 'sucesso', 'Sorteio finalizado com sucesso, ganhador foi o jogador ' .. winnerUserId .. ' com o número ' .. randomNumber .. '.')
    local identity = vRP.getUserIdentity(winnerUserId)
    local userName = tostring(winnerUserId)
    if identity and identity.nome then
        userName = userName..' '..identity.nome..' '..identity.sobrenome
    end
    TriggerClientEvent('chatMessage', -1, {
        type = 'default',
        title = 'RIFA',
        message = 'O jogador ' .. userName .. ' foi o ganhador da rifa com o número da sorte ' .. randomNumber .. '.'
    })
    vRP.sendLog('https://discord.com/api/webhooks/1318632648960245863/0tMVLVgvEca-oB5pYApR70FWVECkg_zqxQnqb-WlrWbiko29GOMjMo9dfp8GBtlAYPbr', string.format('O JOGADOR %s FOI O GANHADOR DA RIFA COM O NUMERO DA SORTE %s', userName, randomNumber))
end)

RegisterCommand('setarganhador', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then
        return
    end

    if not hasStaffPermission(userId) then
        return
    end

    if not rafflesCache then
        TriggerClientEvent('Notify', source, 'negado', 'Não há sorteios ativos.')
        return
    end

    local winnerUserId = tonumber(args[1])
    if not winnerUserId then
        TriggerClientEvent('Notify', source, 'negado', 'Usuário inválido.')
        return
    end

    winnerId = winnerUserId
    TriggerClientEvent('Notify', source, 'sucesso', 'Ganhador setado com sucesso.')
end)

CreateThread(function()
    exports.oxmysql:executeSync([[
        CREATE TABLE IF NOT EXISTS `lotus_raffle` (
            `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
            `item` TEXT NOT NULL,
            `initial_number` INT NOT NULL,
            `final_number` INT NOT NULL,
            `prices` TEXT NOT NULL,
            `end_at` INT NOT NULL
        )
    ]])

    exports.oxmysql:executeSync([[
        CREATE TABLE IF NOT EXISTS `lotus_raffle_buyed` (
            `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
            `user_id` INT NOT NULL,
            `number` INT NOT NULL
        )
    ]])

    Wait(1000)
    local raffleQuery = exports.oxmysql:singleSync('SELECT * FROM `lotus_raffle`')
    if raffleQuery then
        rafflesCache = {
            item = json.decode(raffleQuery.item),
            initialNumber = raffleQuery.initial_number,
            finalNumber = raffleQuery.final_number,
            prices = json.decode(raffleQuery.prices),
            endAt = raffleQuery.end_at,
        }
    end

    local buyedQuery = exports.oxmysql:executeSync('SELECT * FROM `lotus_raffle_buyed`')
    if buyedQuery and #buyedQuery > 0 then
        for _, buyed in pairs(buyedQuery) do

            buyedCache.numbersOwners[buyed.number] = buyed.user_id
            if not buyedCache.usersNumbers[buyed.user_id] then
                buyedCache.usersNumbers[buyed.user_id] = {}
            end

            buyedCache.usersNumbers[buyed.user_id][buyed.number] = true
            buyedCache.totalBuyed = buyedCache.totalBuyed + 1
        end
    end
end)

CreateThread(function()
    while true do
        if rafflesCache and rafflesCache.endAt and rafflesCache.endAt < os.time() then
            if buyedCache and buyedCache.totalBuyed > 0 then
                local boughtNumbers = {}
                for number, _ in pairs(buyedCache.numbersOwners) do
                    table.insert(boughtNumbers, number)
                end

                if #boughtNumbers > 0 then
                    local randomIndex = math.random(1, #boughtNumbers)
                    local randomNumber = boughtNumbers[randomIndex]

                    local winnerUserId = buyedCache.numbersOwners[randomNumber]
                    local rewardType = Config.RewardsTypes[rafflesCache.item.rewardType]
                    if rewardType then
                        if winnerId then
                            winnerUserId = winnerId
                        end
                        rewardType.reward(winnerUserId, rafflesCache.item.reward)
                        local identity = vRP.getUserIdentity(winnerUserId)
                        local userName = tostring(winnerUserId)
                        if identity and identity.nome then
                            userName = userName..' '..identity.nome..' '..identity.sobrenome
                        end
                        TriggerClientEvent('chatMessage', -1, {
                            type = 'default',
                            title = 'RIFA',
                            message = 'O jogador ' .. userName .. ' foi o ganhador da rifa com o número da sorte ' .. randomNumber .. '.'
                        })
                        vRP.sendLog('https://discord.com/api/webhooks/1318632648960245863/0tMVLVgvEca-oB5pYApR70FWVECkg_zqxQnqb-WlrWbiko29GOMjMo9dfp8GBtlAYPbr', string.format('O JOGADOR %s FOI O GANHADOR DA RIFA COM O NUMERO DA SORTE %s', userName, randomNumber))
                    end
                end
            end

            rafflesCache = nil
            winnerId = nil
            buyedCache = { usersNumbers = {}, numbersOwners = {}, totalBuyed = 0 }
            exports.oxmysql:executeSync('DELETE FROM `lotus_raffle`')
            exports.oxmysql:executeSync('DELETE FROM `lotus_raffle_buyed`')
        end
        Wait(1000)
    end
end)