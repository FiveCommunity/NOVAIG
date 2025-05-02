zof = {
    getUserSource = function(user_id)
        return vRP.getUserSource(parseInt(user_id))
    end,
    
    getUserId = function(source)
        return vRP.getUserId(source)
    end,

    itemNameList = function(item)
        return (vRP.itemNameList(item) or item)
    end,

    hasPermission = function(user_id, perm)
        return vRP.hasPermission(user_id, perm)
    end,

    getInventoryItemAmount = function(user_id, idname)
        return vRP.getInventoryItemAmount(user_id, idname)
    end,

    tryGetInventoryItem = function(user_id, item, amount)
        return vRP.tryGetInventoryItem(user_id, item, amount)
    end,

    giveInventoryItem = function(user_id, item, qtd)
        return vRP.giveInventoryItem(user_id, item, qtd)
    end,
    
    getUserByRegistration = function(placa)
        local plate = vRP.getUserByRegistration(placa)

        if plate == nil then
            plate = vRP.getVehiclePlate(placa)
        end
        
        return plate
    end,

    setSData = function(key, data)
        return vRP.setSData(key, data)
    end,

    getSData = function(key)
        return vRP.getSData(key)
    end,

    playAnim = function(source, anim)
        return vRPclient._playAnim(source, false, {{ anim.name, anim.extra }}, true)
    end,

    stopAnim = function(source)
        return vRPclient._stopAnim(source, false)
    end,

    deletarObjeto = function(source)
        return vRPclient.DeletarObjeto(source)
    end,
}
