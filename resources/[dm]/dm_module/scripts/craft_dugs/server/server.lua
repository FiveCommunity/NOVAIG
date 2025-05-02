local cooldown_user = {}

function RegisterTunnel.craftDrug(drug)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    if not ConfigDrugs.Drugs[drug] then return end

    -- VALIDANDO COORDENADAS
    local pedCoords = GetEntityCoords(GetPlayerPed(source))
    local locPermission
    for i = 1, #ConfigDrugs.Locations do
        local loc = ConfigDrugs.Locations[i]
        if loc.type == drug then
            local dist = #(pedCoords - loc.coords)
            if dist > 10 then
                DropPlayer(source, 'POSSIVEL TRAPAÇA DETECTADA.')
                return print('[INJECT-CRAFT-DRUGS] USER_ID: '..user_id..' DISTANCE: '..dist)
            end

            locPermission = loc.permission
        end
    end

    -- VALIDANDO COOLDOWN
    if cooldown_user[user_id] then
        if (cooldown_user[user_id] - os.time()) > 0 then
            return 
        end
    end
    cooldown_user[user_id] = (os.time() + 5)

    if locPermission and not vRP.hasPermission(user_id, locPermission) then 
        return print('[CRAFT-DRUGS] USER_ID: '..user_id..' NOT PERMISSION.')
    end

    -- GIVANDO ITEM
    for _,v in pairs(ConfigDrugs.Drugs[drug]) do
        vRP.giveInventoryItem(user_id, v.item, v.amount, true)
    end
end
