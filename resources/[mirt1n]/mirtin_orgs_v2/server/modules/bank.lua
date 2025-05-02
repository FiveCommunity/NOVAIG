
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare('mirtin_orgs_v2/bank/getinfo', 'SELECT bank, bank_historic FROM mirtin_orgs_info WHERE organization = @organization')
vRP.prepare('mirtin_orgs_v2/bank/updateBank', 'UPDATE mirtin_orgs_info SET bank = @bank, bank_historic = @historic WHERE organization = @organization')

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.getBankInfos()
    local source = source
    local user_id = getUserId(source)
    if not user_id then return end

    local identity = getUserIdentity(user_id)
    if not identity then return end

    local user = Organizations.Members[user_id]
    if not user then return end

    local query = vRP.query('mirtin_orgs_v2/bank/getinfo', { organization = user.groupType })
    if #query == 0 then return end

    return json.decode(query[1].bank_historic) or {}
end

function RegisterTunnel.transactionBank(data)
    local source = source
    local user_id = getUserId(source)
    if not user_id then return end

    local identity = getUserIdentity(user_id)
    if not identity then return end

    local user = Organizations.Members[user_id]
    if not user then return end
    

    if BANK.cooldown[user.groupType] and (BANK.cooldown[user.groupType] - os.time()) > 0 then
        return Config.Langs['waitCooldown'](source)
    end
    BANK.cooldown[user.groupType] = os.time() + 5

    local amount = parseInt(data.amount)
    if amount <= 0 then return end

    local query = vRP.query('mirtin_orgs_v2/bank/getinfo', { organization = user.groupType })
    if #query == 0 then return end

    if (data.type == 'deposit') then
        local hasPermission = Organizations.Permissions[user.groupType] and Organizations.Permissions[user.groupType][user.group].deposit or false
        if not hasPermission then
            return Config.Langs['notPermission'](source)
        end

        if not tryFullPayment(user_id, amount) then
            return Config.Langs['notMoneyDeposit'](source)
        end

        local bank_value = (query[1].bank + amount)
        local generate_log = BANK:generateLog(json.decode(query[1].bank_historic), {
            name = ('%s %s'):format(identity.name, identity.firstname),
            type = "DEPÓSITO",
            value = amount,
            date = os.date('%d/%m/%Y %X'),
        })
        vRP.execute('mirtin_orgs_v2/bank/updateBank', { organization = user.groupType, bank = (query[1].bank + amount), historic = json.encode(generate_log) })
        
        TriggerClientEvent('updateExtract', source, { balance = bank_value, extracts = generate_log, playerBalance = giveBankMoney(user_id) })
        return true
    end

    if (data.type == 'withdraw') then
        local hasPermission = Organizations.Permissions[user.groupType] and Organizations.Permissions[user.groupType][user.group].withdraw or false
        if not hasPermission then
            return Config.Langs['notPermission'](source)
        end

        if amount > query[1].bank then
            return Config.Langs['bankNotMoney'](source)
        end
    
        local bank_value = (query[1].bank - amount)
        local generate_log = BANK:generateLog(json.decode(query[1].bank_historic), {
            name = ('%s %s'):format(identity.name, identity.firstname),
            type = "SAQUE",
            value = amount,
            date = os.date('%d/%m/%Y %X'),
        })

        vRP.execute('mirtin_orgs_v2/bank/updateBank', { organization = user.groupType, bank = bank_value, historic = json.encode(generate_log) })
        giveBankMoney(user_id, amount)

        TriggerClientEvent('updateExtract', source, { balance = bank_value, extracts = generate_log, playerBalance = getBankMoney(user_id) })
        return true
    end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function BANK:generateLog(historic, data)
    if #historic > 20 then
        table.remove(historic,1)
    end
    historic[#historic + 1] = data

    return historic
end