zof = {
    hasPermission = function(user_id, perm)
        return vRP.hasPermission(user_id, perm)
    end,

    giveWeapons = function(source, weapons)
        return vRPclient._giveWeapons(source, weapons)
    end,

    getUserId = function(source)
        return vRP.getUserId(source)
    end,

    tryFullPayment = function(user_id, price)
        return vRP.paymentBank(user_id, price)
    end,

    getInventoryItemAmount = function(user_id, item)
        return vRP.getInventoryItemAmount(user_id, item)
    end,

    tryGetInventoryItem = function(user_id, item, qtd)
        return vRP.tryGetInventoryItem(user_id, item, qtd)
    end,
    
    itemNameList = function(item)
        return vRP.itemNameList(item)
    end,

    giveInventoryItem = function(user_id, item, qtd)
        return vRP.giveInventoryItem(user_id, item, qtd)
    end,

    query = function(nameQuery, data)
        return vRP.query(nameQuery, data)
    end,
    
    prepare = function(nameQuery, query)
        return vRP._prepare(nameQuery, query)
    end,
    
    execute = function(nameQuery)
        return vRP.execute(nameQuery)
    end,
}