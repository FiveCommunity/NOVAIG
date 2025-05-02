BattlePass = {}
BattlePass.__index = BattlePass

function BattlePass:new(userId)
    local query = exports.oxmysql:executeSync('SELECT * FROM lotus_pass_v2 WHERE user_id = ?', { userId })
    local instance = {
        userId = userId,
        items = deepcopy(Config.items),
        timeCounter = 0,
        passType = query[1] and query[1].pass_type or 'vip',
        isCounterRunning = false,
        redeemedDays = json.decode(query[1] and query[1].redeemed_levels or '[]')
    }

    setmetatable(instance, BattlePass)
    return instance
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

function BattlePass:getItems()
    local currentDay = self:getCurrentDay()
    for _, item in ipairs(self.items) do 
        item.avaliable = self:isItemAvailable(item, currentDay)
        item.redeemed = self:isItemRedeemed(item)
    end

    return self.items
end

function BattlePass:isItemAvailable(item, currentDay)
    if item.type == 'premium' and self.passType ~= 'premium' then
        return false
    elseif item.day < currentDay and self.passType == 'premium' then
        return true
    elseif item.day == currentDay and self.timeCounter >= Config.minTime then
        return true
    else
        return false
    end
end

function BattlePass:isItemRedeemed(item)
    for _, day in ipairs(self.redeemedDays) do
        if day == item.day then
            return true
        end
    end
    return false
end

function BattlePass:redeemItem(item)
    if not item.avaliable then
        return
    end

    if self:isItemRedeemed(item) then
        print('Usuário suspeito, tentando pegar item duplicado no passe. ID '..self.userId)
        vRP.sendLog(Config.Webhook, 'JOGADOR '..self.userId..' TENTOU PEGAR O ITEM '..item.spawn..' DUPLICADO NO PASSE')
        return
    end

    local currentDay = self:getCurrentDay()
    if item.day > currentDay or (item.day == currentDay and self.timeCounter < Config.minTime) or (item.type == 'premium' and self.passType ~= 'premium') then
        return
    end

    for k, bpItem in ipairs(self.items) do
        if bpItem.name == item.name and bpItem.day == item.day then
            bpItem.redeemed = true
            bpItem.avaliable = false
            table.insert(self.redeemedDays, item.day)
            if Config.items[k].func then
                Config.items[k].func(self.userId)
            end
            vRP.sendLog(Config.Webhook, 'JOGADOR '..self.userId..' RESGATOU O ITEM '..bpItem.spawn)
            break
        end
    end
    self:saveData()
end

function BattlePass:saveData()
    exports.oxmysql:execute('INSERT INTO lotus_pass_v2 (user_id, pass_type, redeemed_levels) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE pass_type = ?, redeemed_levels = ?', 
        { self.userId, self.passType, json.encode(self.redeemedDays), self.passType, json.encode(self.redeemedDays) })
end

function BattlePass:getCurrentDay()
    local startDay = Config.startDay
    local actualDay = os.date('*t')

    local startTimestamp = os.time{year=startDay.year, month=startDay.month, day=startDay.day, hour=0, min=0, sec=0}
    local currentTimestamp = os.time{year=actualDay.year, month=actualDay.month, day=actualDay.day, hour=0, min=0, sec=0}

    local dayDifference = os.difftime(currentTimestamp, startTimestamp)
    local currentDay = math.floor(dayDifference / 86400) + 1

    return math.min(currentDay, Config.totalDays)
end

function BattlePass:calculateProgress()
    -- if self.timeCounter == 0 then
    --     return 0
    -- end

    -- local progress = (self.timeCounter / Config.minTime) * 100
    -- return math.min(math.floor(progress), 100)
    return self.timeCounter
end

function BattlePass:startCounter()
    if self.isCounterRunning then
        return
    end

    self.isCounterRunning = true
    CreateThread(function()
        while self.isCounterRunning do
            Wait(60000)
            self.timeCounter = self.timeCounter + 1
            if self.timeCounter >= Config.minTime then
                self.timeCounter = 30
                self.isCounterRunning = false
            end
        end
    end)
end

function BattlePass:stopCounter()
    self.isCounterRunning = false
end

function BattlePass:calculateLeftDays()
    local currentDay = self:getCurrentDay()
    return (Config.totalDays - currentDay) <= 0 and 0 or (Config.totalDays - currentDay)
end