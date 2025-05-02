local playersCache = {}
function cO.playerWeapons()
    local source = source 
    local userId = vRP.getUserId(source)
    if not userId then return end 

    if not playersCache[userId] then 
        local dbResponse = vRP.getUData(userId, "Skins:Buyed")
        playersCache[userId] = dbResponse ~= "" and json.decode(dbResponse) or {}
    end

    return playersCache[userId]
end
----------------------------------------------------------------------------------------------------
-- OBTER MAKAPOINTS || HAN BIXA VIADO TE ODEIO
----------------------------------------------------------------------------------------------------
function cO.getMakapoints()
    local source = source 
    local userId = vRP.getUserId(source)
    if not userId then return end 
    return (vRP.getMakapoints(userId) or 0)
end
----------------------------------------------------------------------------------------------------
-- ABRIR INTERFACE || HAN BIXA VIADO TE ODEIO
----------------------------------------------------------------------------------------------------
function cO.openInterface()
    local source = source 
    local userId = vRP.getUserId(source)
    if not userId then return false end 

    if vRP.checkPatrulhamento(userId) then 
        return false 
    end

    exports.inventory:storeWeapons(source,userId)

    return true 
end
----------------------------------------------------------------------------------------------------
-- FUNÇÃO DE COMPRA || HAN BIXA VIADO TE ODEIO
----------------------------------------------------------------------------------------------------
function cO.buyWeapons(cart)
    local source = source 
    local userId = vRP.getUserId(source)
    if not userId then return false end 

    local purchaseWeapon = cart.skin
    if not playersCache[userId] then 
        playersCache[userId] = {}
    end


    local makaPoints = vRP.getMakapoints(userId)
    if makaPoints < parseInt(purchaseWeapon.points) then 
        return false, TriggerClientEvent("Notify",source,"negado","Saldo Insuficiente.",5)
    end
    
    if not purchaseWeapon.expires then 
        local weapon,category,rarity = purchaseWeapon.data.weapon,purchaseWeapon.data.type,purchaseWeapon.rarity
        for k,v in pairs(playersCache[userId]) do 
            if v.weapon == weapon and v.name == purchaseWeapon.name or v.pack == purchaseWeapon.name then
                return false, TriggerClientEvent("Notify",source,"negado","Você já possuí essa skin.",5)
            end
        end
    else
        for k,v in pairs(playersCache[userId]) do 
            if v.pack == purchaseWeapon.name then
                return false, TriggerClientEvent("Notify",source,"negado","Você já possuí essa skin.",5)
            end
        end
    end


    local balancePoints = makaPoints - parseInt(purchaseWeapon.points)
    if balancePoints <= 0 then 
        balancePoints = 0 
    end


    vRP.setMakapoints(userId, balancePoints)

    if not purchaseWeapon.expires then 
        table.insert(playersCache[userId],{
            weapon = purchaseWeapon.data.weapon,
            name = purchaseWeapon.name,
            category = purchaseWeapon.data.type,
            component = purchaseWeapon.data.component
        })
    else
        for k,v in pairs(bannerWeapon.data) do 
            table.insert(playersCache[userId],{
                weapon = v.weapon,
                name = v.name,
                category = v.type,
                component = v.component,
                pack = purchaseWeapon.name
            })
        end
    end
    
  

    if Shared.RealTime then 
        vRP.setUData(userId, "Skins:Buyed", json.encode(playersCache[userId]))
    end
    
    
    TriggerClientEvent("Notify",source,"sucesso","A sua compra foi concluida.",5)
    return true, playersCache[userId]
end
----------------------------------------------------------------------------------------------------
-- SELECT SKIN || HAN BIXA VIADO TE ODEIO
----------------------------------------------------------------------------------------------------
function cO.selectSkin(nameSkin,weaponName,skinStatus)
    local source = source 
    local userId = vRP.getUserId(source)
    if not userId then return false end 

    if not playersCache[userId] then return end 

    for k,v in pairs(playersCache[userId]) do 
        if v.name == nameSkin or v.name == nameSkin:lower() and v.weapon == weaponName then 
            playersCache[userId][k].selected = skinStatus 
        end
    end

    if Shared.RealTime then 
        vRP.setUData(userId, "Skins:Buyed", json.encode(playersCache[userId]))
    end

    return true 
end
----------------------------------------------------------------------------------------------------
-- CONNECT || HAN BIXA VIADO TE ODEIO
----------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(userId,userSource)
    if not playersCache[userId] then 
        local dbResponse = vRP.getUData(userId, "Skins:Buyed")
        playersCache[userId] = dbResponse ~= "" and json.decode(dbResponse) or {}
        if next(playersCache[userId]) then 
            TriggerClientEvent("Skins:SyncWeapons",userSource,playersCache[userId])
        end
    end
end)
----------------------------------------------------------------------------------------------------
-- DISCONNECT || HAN BIXA VIADO TE ODEIO
----------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(userId,_)
    if not Shared.RealTime and playersCache[userId] then 
        vRP.setUData(userId, "Skins:Buyed", json.encode(playersCache[userId]))
    end

    playersCache[userId] = nil
end)

RegisterCommand("addskin", function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasPermission(user_id, "developer.permissao") then 
        local Array = Shared.Weapons[args[1]]
        if Array then 
            if Array[args[2]] then 
                for k,v in pairs(Array[args[2]].Components) do 
                    if v.component == args[3] then 
                        if not playersCache[user_id] then 
                            playersCache[user_id] = {}
                        end

                        table.insert(playersCache[user_id],{
                            weapon = Array[args[2]].Weapon,
                            name = v.name,
                            category = args[1],
                            component = v.component
                        })

                        vRP.setUData(user_id, "Skins:Buyed", json.encode(playersCache[user_id]))

                        TriggerClientEvent("Skins:SyncWeapons",source,playersCache[user_id])
                        TriggerClientEvent("Notify",source,"sucesso","A skin foi adicionada com sucesso.",5000)
                        break 
                    end
                end
            end
        end
    end    
end)

RegisterCommand('liberarskins', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then
        return
    end

    if not vRP.hasPermission(userId, "developer.permissao") then
        return
    end

    if not playersCache[userId] then 
        playersCache[userId] = {}
    end

    for weaponType, data in pairs(Shared.Weapons) do
        for weaponName, weaponData in pairs(data) do
            for _, component in pairs(weaponData.Components) do
                table.insert(playersCache[userId],{
                    weapon = weaponName,
                    name = component.name,
                    category = weaponType,
                    component = component.component
                })

                TriggerClientEvent("Skins:SyncWeapons",source,playersCache[userId])
            end
        end
    end

    vRP.setUData(userId, "Skins:Buyed", json.encode(playersCache[userId]))
    TriggerClientEvent("Notify",source,"sucesso","Todas as skins foram liberadas.")
end)

exports("createSkin",function(userId,weaponCategory,weaponName,weaponSkin)
    local Array = Shared.Weapons[weaponCategory]
    if Array then 
        if Array[weaponName] then 
            for k,v in pairs(Array[weaponName].Components) do 
                if v.component == weaponSkin then 
                    if not playersCache[userId] then 
                        playersCache[userId] = {}
                    end

                    table.insert(playersCache[userId],{
                        weapon = Array[weaponName].Weapon,
                        name = v.name,
                        category = weaponCategory,
                        component = v.component
                    })

                    vRP.setUData(userId, "Skins:Buyed", json.encode(playersCache[userId]))

                    TriggerClientEvent("Skins:SyncWeapons",source,playersCache[userId])
                    break 
                end
            end
        end
    end
end)