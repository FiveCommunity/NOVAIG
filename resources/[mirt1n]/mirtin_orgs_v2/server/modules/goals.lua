

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare('mirtin_orgs_v2/bank/getinfo', 'SELECT bank,bank_historic FROM mirtin_orgs_info WHERE organization = @organization')
vRP.prepare('mirtin_orgs_v2/bank/updateBank', 'UPDATE mirtin_orgs_info SET bank = @bank, bank_historic = @historic WHERE organization = @organization')
vRP.prepare('mirtin_orgs_v2/updateConfigGoals', 'UPDATE mirtin_orgs_info SET config_goals = @config_goals WHERE organization = @organization')
vRP.prepare('mirtin_orgs_v2/myGoals', ' SELECT * FROM mirtin_orgs_goals WHERE user_id = @user_id and organization = @organization and day = @day and month = @month ')
vRP.prepare('mirtin_orgs_v2/updateFarm', 'UPDATE mirtin_orgs_goals SET step = @step, reward_step = @reward_step WHERE user_id = @user_id AND organization = @organization AND month = @month AND day = @day')
vRP.prepare('mirtin_orgs_v2/getDailyFarms', 'SELECT * FROM mirtin_orgs_goals WHERE organization = @organization and day = @day and month = @month ORDER BY amount DESC')

vRP.prepare('mirtin_orgs_v2/getDailyFarmsByUser', 'SELECT * FROM mirtin_orgs_goals WHERE organization = @organization and day = @day and month = @month and user_id = @user_id ORDER BY amount DESC')

vRP.prepare('mirtin_orgs_v2/addPlayerFarm', 'INSERT IGNORE INTO mirtin_orgs_goals(organization, user_id, item, amount, day, month) VALUES(@organization, @user_id, @item, @amount, @day, @month) ON DUPLICATE KEY UPDATE amount = amount + @amount;')

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local GOALS = {
    cooldown = {}
}

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function RegisterTunnel.getGoals()
    local source = source
    local user_id = getUserId(source)
    if not user_id then return end

    local user = Organizations.Members[user_id]
    if not user then return end

    if not Organizations.goalsConfig[user.groupType] then return end

    local myGoals = vRP.query('mirtin_orgs_v2/myGoals', { user_id = user_id, organization = user.groupType, day = os.date('%d'), month = os.date('%m') }) or {}
    local myItems, concluded_items = {}, 0
    for i = 1, #myGoals do
        local goal = myGoals[i]
        
        local valid_goal = Organizations.goalsConfig[user.groupType].info.itens
        if valid_goal[goal.item] then
            local maxItem = valid_goal[goal.item].max

            myItems[goal.item] = {
                amount = goal.amount,
                step = goal.step
            }

        end
    end

    local goalsItens = {}
    local goalMax = Organizations.goalsConfig[user.groupType].info
    for item, maxItem in pairs(Organizations.goalsConfig[user.groupType].info.itens) do
        goalsItens[#goalsItens + 1] = {
            name = getItemName(item),
            item = item,
            needed = goalMax.itens[item].needed,
            current = myItems[item] and myItems[item].amount or 0,
            max = goalMax.itens[item].max*(myItems[item] and myItems[item].step or 1)
        }
    end

    local function getWeekDays()
        local today = os.date("*t").wday
        local days = {}

        for i = 0, 6 do
            local offset = (i - (today - 1)) * 86400 
            local date = os.date("*t", os.time() + offset)
            days[i + 1] = { day = date.day, month = date.month }
        end
    
        return days
    end
    
    local weekDays = getWeekDays()
    local t = {}
    
    for nuserid in ipairs(Organizations.MembersList[user.groupType]) do
        local ply_identity = getUserIdentity(nuserid)
        if ply_identity then
            local nuser = Organizations.Members[nuserid]
            local status = { 2, 2, 2, 2, 2, 2, 2 }
    
            for i, date in ipairs(weekDays) do
                local reward_data = vRP.query('mirtin_orgs_v2/getDailyFarmsByUser', {
                    user_id = nuserid,
                    day = date.day,
                    month = date.month,
                    organization = user.groupType
                })

                if #reward_data > 0 and reward_data[1].reward_step >= 1 then
                    status[i] = 1 
                end
            end
    
            local today = os.date("*t").wday
            if status[today] ~= 1 then
                status[today] = 3
            end
    
            table.insert(t, {
                name = ('%s %s'):format(ply_identity.name, ply_identity.firstname),
                role = Config.Groups[nuser.groupType] and Config.Groups[nuser.groupType].List[nuser.group].prefix or "Desconhecido",
                status = {status[2],status[3],status[4],status[5],status[6],status[7],status[1]}
            })
        end
    end

    return {
        prize = goalMax.defaultReward,
        my = goalsItens,
        faction = {},
        members = t,
    }
end

function RegisterTunnel.rewardGoal()
    local source = source
    local user_id = getUserId(source)
    if not user_id then return end

    local identity = getUserIdentity(user_id)
    if not identity then return end

    local user = Organizations.Members[user_id]
    if not user then return end

    if not Organizations.goalsConfig[user.groupType] then return end

    if GOALS.cooldown[user_id] and (GOALS.cooldown[user_id] - os.time()) > 0 then
        return Config.Langs['waitCooldown'](source)
    end
    GOALS.cooldown[user_id] = (os.time() + 5)

    local myGoals = vRP.query('mirtin_orgs_v2/myGoals', { user_id = user_id, organization = user.groupType, day = os.date('%d'), month = os.date('%m') }) or {}
    if #myGoals <= 0 or not myGoals[1] then
        return
    end

    local concluded_items = 0
    for i = 1, #myGoals do
        local goal = myGoals[i]
        
        local valid_goal = Organizations.goalsConfig[user.groupType].info.itens
        if valid_goal[goal.item] then
            local maxItem = valid_goal[goal.item].max

            if goal.amount >= (maxItem * goal.step) then
                concluded_items = (concluded_items + 1)
            end
        end
    end

    local totalItems = 0
    for item, values in pairs(Organizations.goalsConfig[user.groupType].info.itens) do
        if values.needed then
            totalItems = (totalItems + 1)
        end
    end

    if concluded_items < totalItems then
        return
    end

    local reward_step = myGoals[1].reward_step
    if myGoals[1].step >= 1 then
        reward_step = (reward_step + 1)
    end

    local query = vRP.query('mirtin_orgs_v2/bank/getinfo', { organization = user.groupType })
    if #query == 0 then return end

    local amount = Organizations.goalsConfig[user.groupType].info.defaultReward or 0
    if not amount or not query[1].bank then
        return
    end

    if amount > query[1].bank then
        return Config.Langs['bankNotMoney'](source)
    end
    
    vRP.execute('mirtin_orgs_v2/updateFarm', { user_id = user_id, organization = user.groupType, day = os.date('%d'), month = os.date('%m'), reward_step = reward_step, step = (myGoals[1].step + 1) })

    -- PAGAR META

    local bank_value = (query[1].bank - amount)
    local generate_log = BANK:generateLog(json.decode(query[1].bank_historic), {
        name = ('%s %s'):format(identity.name, identity.firstname),
        type = "META DIARIA",
        value = amount,
        date = os.date('%d/%m/%Y %X'),
    })

    vRP.execute('mirtin_orgs_v2/bank/updateBank', { organization = user.groupType, bank = bank_value, historic = json.encode(generate_log) })
    vRP.giveBankMoney(user_id, amount)

    Config.Langs['rewardedGoal'](source, amount)
    return true
end


function RegisterTunnel.saveGoals(data)
    local source = source
    local user_id = getUserId(source)
    if not user_id then return end

    local user = Organizations.Members[user_id]
    if not user then return end
    local hasPermission = Organizations.Permissions[user.groupType] and Organizations.Permissions[user.groupType][user.group].leader or false
    if not hasPermission then
        return
    end

    local t = {}
    for index in pairs(data.items) do
        if not t.info then 
            t.info = {
                defaultReward = data.payment,
                itens = {}
            }
        end

        t.info.itens[data.items[index].item] = { max = data.items[index].max, needed = data.items[index].needed }
    end

    if Organizations.goalsConfig[user.groupType] then
        Organizations.goalsConfig[user.groupType] = t
    end

    vRP.execute('mirtin_orgs_v2/updateConfigGoals', { organization = user.groupType, config_goals = json.encode(t) })
end

vRP.prepare("mirtin_orgs_v2/insert_member_data",[[
    INSERT INTO mirtin_organization_members
    (user_id, group_type, member_data, item, amount, day, month) 
    VALUES 
    (@user_id, @group_type, @member_data, @item, @amount, @day, @month)
]])

exports('addGoal', function(user_id, item, amount)
    user_id = parseInt(user_id)
    local source = getUserSource(user_id)
    if not source then 
        return 
    end
    
    local user = Organizations.Members[user_id]
    if not user then 
        return 
    end
    
    if not Organizations.goalsConfig[user.groupType] then 
        return 
    end
    
    if not item or item == "" then
        item = "unknown" 
    end

    local day = tonumber(os.date('%d'))
    local month = tonumber(os.date('%m'))
    amount = tonumber(amount)
    

    vRP.execute('mirtin_orgs_v2/addPlayerFarm', {
        organization = user.groupType,
        user_id = user_id,
        item = item,
        amount = amount,
        day = day,
        month = month
    })


    local source = source
    local user_id = getUserId(source)
    local identity = getUserIdentity(user_id)
    local playerName = identity and identity.name
    
    local myJob = nil
    for groupName, groupConfig in pairs(Config.Groups) do
        for cargo, data in pairs(groupConfig.List) do
            if vRP.hasGroup(user_id, cargo) then
                myJob = cargo 
                break 
            end
        end
        
        if myJob then
            break  
        end
    end
    
    if myJob then
        local querySuccess, err = pcall(function()
            vRP.execute("mirtin_orgs_v2/insert_member_data", {
                user_id = user_id,
                group_type = myJob,  
                member_data = playerName, 
                item = item,
                amount = amount,
                day = os.date('%d'),
                month = os.date('%m')
            })
        end)
    
        if not querySuccess then
            print("Erro ao inserir dados: " .. tostring(err))
        end
    else
        print("Usuário não possui cargo em nenhum grupo.")
    end
end)
