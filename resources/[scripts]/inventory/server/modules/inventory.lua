local ts <const> = tostring
local tn <const> = tonumber


local imagesProfile = imagesProfile or {}

WeaponsTypes = {
    ["WEAPON_SNSPISTOL_MK2"] = "PISTOLAS",
    ["WEAPON_PISTOL_MK2"] = "PISTOLAS",
    ["WEAPON_PISTOL"] = "PISTOLAS",
    ["WEAPON_COMBATPISTOL"] = "PISTOLAS",
    ["WEAPON_DOUBLEACTION"] = "PISTOLAS",
	["WEAPON_HEAVYPISTOL"] = "PISTOLAS",
	["WEAPON_APPISTOL"] = "PISTOLAS",
    ["WEAPON_PISTOL50"] = "PISTOLAS",
    ["WEAPON_GUSENBERG"] = "SEMI-RIFLE",
    ["WEAPON_MACHINEPISTOL"] = "SEMI-RIFLE",
    ["WEAPON_SMG_MK2"] = "SEMI-RIFLE",
    ["WEAPON_SMG"] = "SEMI-RIFLE",
    ["WEAPON_MICROSMG"] = "SEMI-RIFLE",
    ["WEAPON_ASSAULTSMG"] = "SEMI-RIFLE",
	["WEAPON_COMBATPDW"] = "SEMI-RIFLE",
    ["WEAPON_SAWNOFFSHOTGUN"] = "SHOTGUN",
    ["WEAPON_PUMPSHOTGUN_MK2"] = "SHOTGUN",
    ["WEAPON_PUMPSHOTGUN"] = "SHOTGUN",
    ["WEAPON_MILITARYRIFLE"] = "RIFLE",
    ["WEAPON_ASSAULTRIFLE"] = "RIFLE",
    ["WEAPON_ASSAULTRIFLE_MK2"] = "RIFLE",
    ["WEAPON_PARAFAL"] = "RIFLE",
    ["WEAPON_TACTICALRIFLE"] = "RIFLE",
    ["WEAPON_BULLPUPRIFLE"] = "RIFLE",
    ["WEAPON_ADVANCEDRIFLE"] = "RIFLE",
    ["WEAPON_SPECIALCARBINE_MK2"] = "RIFLE",
    ["WEAPON_AKPENTEDE90_RELIKIASHOP"] = "RIFLE",
    ["WEAPON_AKDEFERRO_RELIKIASHOP"] = "RIFLE",
    ["WEAPON_HEAVYRIFLE"] = "RIFLE",

    ["WEAPON_AK472"] = "RIFLE",
    ["WEAPON_AR10PRETO_RELIKIASHOP"] = "RIFLE",
    ["WEAPON_AR15BEGE_RELIKIASHOP"] = "RIFLE",
    ["WEAPON_ARPENTEACRILICO_RELIKIASHOP"] = "RIFLE",
    ["WEAPON_ARDELUNETA_RELIKIASHOP"] = "RIFLE",
    ["WEAPON_ARLUNETAPRATA"] = "RIFLE",
    ["WEAPON_ARTAMBOR"] = "RIFLE",
    ["WEAPON_G3LUNETA_RELIKIASHOP"] = "RIFLE",
    ["WEAPON_GLOCKDEROUPA_RELIKIASHOP"] = "RIFLE",
    ["WEAPON_HKG3A3"] = "RIFLE",
    ["WEAPON_HK_RELIKIASHOP"] = "RIFLE",
    ["WEAPON_PENTEDUPLO1"] = "RIFLE",
    ["WEAPON_50_RELIKIASHOP"] = "RIFLE",
    ["WEAPON_CARBINERIFLE"] = "RIFLE",
    ["WEAPON_CARBINERIFLE_MK2"] = "RIFLE",
    ["WEAPON_SPECIALCARBINE"] = "RIFLE",
    ["WEAPON_STUNGUN"] = "STUNGUN",
    ["WEAPON_HEAVYSNIPER"] = "SNIPER",

    ["WEAPON_AKCROMO"] = "RIFLE",
    ["WEAPON_ARRELIKIASHOPFEMININO1"] = "RIFLE",
    ["WEAPON_ARRELIKIASHOPFEMININO2"] = "RIFLE",
    ["WEAPON_ARVASCO"] = "RIFLE",
    ["WEAPON_CHEYTAC"] = "SNIPER",
    ["WEAPON_G3RELIKIASHOPFEMININO"] = "RIFLE",
    ["WEAPON_GLOCKRAJADA"] = "PISTOLAS",
    ["WEAPON_GLOCKRELIKIASHOPFEMININO0"] = "PISTOLAS",
}

local function hasAmmoType(to_equip_weapon, weapon_list)
    local to_equip_type = WeaponsTypes[to_equip_weapon]
    if not to_equip_type then return false end
    for k, v in pairs(weapon_list) do
        if WeaponsTypes[k] and WeaponsTypes[k] == to_equip_type then
            return true
        end
    end
    return false
end

---@return table<string, table | number> | false
function API.getInventory()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return {
            weight = vRP.computeInvWeight(user_id),
            max_weight = vRP.getInventoryMaxWeight(user_id),
            inventory = vRP.getInventory(user_id),
        }
    end
    return false
end

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	if (not user_id) then return end
	if (imagesProfile[tostring(user_id)]) then return end

	local query = exports["oxmysql"]:executeSync('SELECT avatarURL from smartphone_instagram WHERE user_id = ? ', { user_id })
	if (not query[1]) then return end

	imagesProfile[tostring(user_id)] = query[1].avatarURL
end)

local vipGroups = {
	'Inicial',
	'Bronze',
	'Prata',
	'Ouro',
	'Platina',
	'Diamante',
	'Safira',
	'Esmeralda',
	'Rubi',
	'RubiPlus',
	'Altarj',
	'Pascoa',
	'VipHalloween',
	'VipDeluxe',
	'VipInauguracao',
	'Ferias',
	'VipSaoJoao',
	'VipCrianca',
	'VipBlackfriday',
	'VipInicial',
	'VipSetembro',
	"VipNatal",
	"Vip2025",
	"VipAnoNovo",
	"VipCarnaval",
	"VipMaio",
	"VipReal",
	"Olimpiada",
	'Belarj',
	'Supremorj',
	'vipwipe',
	'VipVerao',
	'VipSaoJoao',
	'VipOutono',
}


local function getUserName(userId)
    local identity = vRP.getUserIdentity(userId)
    if identity then
        if identity.nome and identity.sobrenome then
            return identity.nome .. ' ' .. identity.sobrenome
        end
        return identity.nome
    end
    return ''
end

function API.getProfile()
    local source = source
    local user_id = vRP.getUserId(source)

    local currentVips = {}

    for k, v in pairs(vipGroups) do
        if (vRP.hasGroup(user_id, v)) then
            if v == 'VipWipe' then
                currentVips[#currentVips + 1] = 'VIP INAUGURAÇÃO'
            else
                currentVips[#currentVips + 1] = v
            end
        end
    end

    if user_id then
        if not imagesProfile[tostring(user_id)] then
            local query = exports["oxmysql"]:executeSync(
                'SELECT avatarURL FROM smartphone_instagram WHERE user_id = ?', 
                { user_id }
            )

            if query and query[1] and query[1].avatarURL then
                imagesProfile[tostring(user_id)] = query[1].avatarURL
            else
                imagesProfile[tostring(user_id)] = ""
            end
        end
        return {
            makapoints = vRP.getMakapoints(user_id),
            id = user_id,
            isVip = next(currentVips) and true or false,
            name = getUserName(user_id),
            image_url = imagesProfile[tostring(user_id)],
        }
    end
end

---@return table<string, number> | false
function API.getWeight()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return {
            weight = vRP.computeInvWeight(user_id),
        }
    end
    return false
end

---@param from_slot string
---@param from_amount number
---@param to_slot string
---@return boolean | nil
function API.swapSlot(from_slot, from_amount, to_slot)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if from_amount < 0 then
            from_amount = 1
            return
        end
        from_amount = parseInt(from_amount)

        local from_slot_data = vRP.getSlotItem(user_id, from_slot)
        if not from_slot_data then
            return false
        end
        local to_slot_data = vRP.getSlotItem(user_id, to_slot)
        from_amount = tn(from_amount) or from_slot_data.amount
        local fullAmount = ((from_slot_data.amount and from_slot_data.amount == from_amount) and true or false)

        if not to_slot_data then
            -- Alteração de slot, não há item no slot de destino.
            if from_slot_data.amount then
                if vRP.tryGetInventoryItem(user_id, from_slot_data.item, from_amount, false, from_slot) then
                    vRP.giveInventoryItem(user_id, from_slot_data.item, from_amount, false, ts(to_slot))
                    return true
                end
            end
        else
            local sameItems = from_slot_data.item == to_slot_data.item
            if sameItems then
                if fullAmount then
                    if vRP.tryGetInventoryItem(user_id, from_slot_data.item, from_slot_data.amount, false, ts(from_slot)) then
                        vRP.giveInventoryItem(user_id, to_slot_data.item, from_amount, false, ts(to_slot))
                        return true
                    end
                end
            else
                vRP.swapSlot(user_id, from_slot, to_slot)
                return true
            end
        end
    else
        return error("Usuário não encontrado")
    end
end

---@param slot string
---@param amount number
---@return boolean | table
function API.sendItem(slot, amount)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local slot_data = vRP.getSlotItem(user_id, slot)
        if slot_data then
            local tPlayer = vRPc.getNearestPlayer(source, 3.0)
            if tPlayer then
                local tUserId = vRP.getUserId(tPlayer)
                if tUserId then
                    if not (vRP.computeInvWeight(tUserId) + vRP.getItemWeight(slot_data.item) * amount <= vRP.getInventoryMaxWeight(tUserId)) then
                        return {
                            error = "Jogador sem espaço suficiente!"
                        }
                    end

                    if (slot_data.item):upper() == 'WEAPON_PISTOL' or (slot_data.item):upper() == 'AMMO_PISTOL' then
                        if not vRP.hasPermission(user_id, 'developer.permissao') and not vRP.hasPermission(user_id, 'perm.policiacivil') and not vRP.hasPermission(user_id, 'perm.pf') then
                            TriggerClientEvent("Notify",source,"negado","Você não pode pegar armas ou munições.")
                            return
                        end
                    end
                    if vRP.tryGetInventoryItem(user_id, slot_data.item, amount, ts(slot)) then
                        vRP.giveInventoryItem(tUserId, slot_data.item, amount, true)
                        vRPc._playAnim(source, true, { { "pickup_object", "putdown_low" } }, false)
                        vRPc._playAnim(tPlayer, true, { { "pickup_object", "putdown_low" } }, false)
                        Remote._sendNuiEvent(tPlayer, {
                            route = "FORCE_UPDATE_INVENTORY",
                        })

                        vRP.sendLog('https://discord.com/api/webhooks/1313515328285708349/QEwLRsWgOIZm8b9HGb2ZsgnR6bqZSbj73blubt0OpOWCIHCUVDXnD2iph3lcYtmI1vMU', ( [[O USER_ID %s ENVIOU O ITEM %s NA QUANTIDADE DE %s PARA O USER_ID %s]] ):format(user_id, slot_data.item, amount, tUserId))

                        exports["vrp_admin"]:generateLog({
                            category = "inventario",
                            room = "enviar-item",
                            user_id = user_id,
                            target_id = tUserId,
                            message = ( [[O USER_ID %s ENVIOU O ITEM %s NA QUANTIDADE DE %s PARA O USER_ID %s]] ):format(user_id, slot_data.item, amount, tUserId)
                        })

                        return true
                    end
                end
            else
                return {
                    error = "Ninguém por perto!"
                }
            end
        end
    end
    return {
        error = "Erro desconhecido ao enviar item."
    }
end

function parseWeapons(valids, client)
    local response = {}
    for weapon, data in pairs(valids) do
        response[weapon] = data
        local compare = client[weapon]
        if compare and compare.ammo < data.ammo then
            data.ammo = compare.ammo
        end
    end
    return response
end

function mergeWeapons(user_id, source)
    local valids = vRP.getWeapons(user_id)
    local client = vRPc.getWeapons(source)
    if not client then
        print("Erro no getWeapons, source = " .. source)
    end
    return parseWeapons(valids, client)
end

---@param slot string
---@param amount number
---@return nil | table
function API.useItem(slot, amount)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local status, time = exports.vrp:getCooldown(user_id, "inventario")
        if not status then
            return { error = "Aguarde " .. time .. " segundos para usar um item novamente." }
        end
        local slot_data = vRP.getSlotItem(user_id, slot) or false
        if slot_data then
            if Items[slot_data.item] then
                if Items[slot_data.item].func and (Items[slot_data.item].keep_item or vRP.tryGetInventoryItem(user_id, slot_data.item, 1, true, slot)) then
                    local p = promise.new()
                    local slot_data = slot_data
                    Items[slot_data.item].func(user_id, source, slot_data.item, slot, function(cb)
                        if type(cb) == "table" and cb.error then
                            if cb.error and not Items[slot_data.item].keep_item then
                                vRP.giveInventoryItem(user_id, slot_data.item, 1, true, slot)
                            end
                            return p:resolve(cb)
                        end
                        local _slot_data = vRP.getSlotItem(user_id, slot)
                        if not _slot_data then
                            return p:resolve({
                                used_amount = slot_data.amount
                            })
                        else
                            p:resolve({
                                used_amount = ((slot_data.amount - _slot_data.amount) or 1)
                            })
                        end
                    end)
                    return Citizen.Await(p)
                end
                if Items[slot_data.item].type then
                    if Items[slot_data.item].type == "recharge" then
                        if vRP.hasPermission(user_id, "crianca.permissao") then return end

                        local weapon_name = "WEAPON_" .. slot_data.item:gsub("ammo_", ""):upper();
                        local weapons = mergeWeapons(user_id, source)
                        if weapons[weapon_name] then
                            if weapons[weapon_name].ammo < 250 then
                                local checkamount = 250 - weapons[weapon_name].ammo
                                if amount > checkamount then
                                    amount = checkamount
                                end
                                if vRP.tryGetInventoryItem(user_id, slot_data.item, amount, slot) then
                                    weapons[weapon_name].ammo = weapons[weapon_name].ammo + amount
                                    vRP.setWeapons(user_id, weapons)
                                    vRPc.giveWeapons(source, weapons, true)
                                    exports["vrp_admin"]:generateLog({
                                        category = "inventario",
                                        room = "equipar",
                                        user_id = user_id,
                                        message = ( [[O USER_ID %s RECARREGOU A MUNICAO %s NA QUANTIDADE %s]] ):format(user_id, slot_data.item, amount)
                                    })
                                    return {
                                        used_amount = amount,
                                    }
                                end
                            else
                                return {
                                    error = "Você já está com a munição cheia."
                                }
                            end
                        else
                            return {
                                error = "Você não tem essa arma equipada."
                            }
                        end
                    end

                    if Items[slot_data.item].type == "equip" then
                        if GetPlayerRoutingBucket(source) ~= 0 then return { error = "Você não pode equipar arma agora." } end

                        if exports.vrp_admin:checkIfUserIsBlacklisted(user_id) then return { error = "Você não pode equipar arma agora." } end

                        local org = vRP.getUserGroupOrg(user_id)
                        if exports.vrp_admin:isOrganizationBlacklisted(org) then return { error = "Você não pode equipar arma agora." } end

                        local weapon_name = slot_data.item:upper()
                        local weapons = mergeWeapons(user_id, source)
                        if not weapons[weapon_name] then
                            if hasAmmoType(weapon_name, weapons) then
                                return {
                                    error = "Você já tem uma arma desse tipo equipada!"
                                }
                            end
                            if vRP.tryGetInventoryItem(user_id, slot_data.item, 1, slot) then
                                weapons[weapon_name] = { ammo = 0 }
                                vRP.setWeapons(user_id, weapons)
                                vRPc.giveWeapons(source, weapons, true)
                                exports["vrp_admin"]:generateLog({
                                    category = "inventario",
                                    room = "equipar",
                                    user_id = user_id,
                                    message = ( [[O USER_ID %s EQUIPOU A ARMA %s]] ):format(user_id, slot_data.item)
                                })
                                return {
                                    used_amount = 1,
                                }
                            end
                        else
                            return {
                                error = "Você já tem essa arma equipada!"
                            }
                        end
                    end
                end
            end
        end
    end
    return {
        error = "Item não utilizável."
    }
end

RegisterNetEvent("vrp_inventory:useItem", API.useItem)

---@param slot string
---@param amount number
---@return boolean | nil
function API.dropItem(slot, amount)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if amount <= 0 then
            return {error = 'Quantidade inválida.'}
        end
        if (GetPlayerRoutingBucket(source) ~= 0) then return { error = "Você não pode fazer isso aogra." } end
        if (GetEntityHealth(GetPlayerPed(source))) <= 101 then return { error = "Você está morto." } end
        local slot_data = vRP.getSlotItem(user_id, slot)
        if slot_data then
            if Items[slot_data.item] then
                if Items[slot_data.item].type == "equip" or Items[slot_data.item].type == "recharge" or slot_data.item == "dinheirosujo" then
                    return { error = "Você não pode dropar esse item." }
                end
            end

            if (slot_data.item):upper() == 'WEAPON_PISTOL' or (slot_data.item):upper() == 'AMMO_PISTOL' then
                TriggerClientEvent("Notify",source,"negado","Você não pode dropar armas ou munições.")
                return
            end
            if vRP.tryGetInventoryItem(user_id, slot_data.item, amount, slot) then
                vRPc._playAnim(source, true, { { "pickup_object", "pickup_low" } }, false)
                PickupSystem:Create({
                    src = source,
                    user_id = user_id
                }, slot_data.item, amount, GetEntityCoords(GetPlayerPed(source)))

                vRP.sendLog('https://discord.com/api/webhooks/1313515255187374140/4O1xzbKLBkK4k2PplTw4V8dDMZj8yiRt5F3DSYA34Bidv79j5VCvWBsvK2McluaxRYdt', ( [[O USER_ID %s DROPOU O ITEM %s NA QUANTIDADE DE x %s]] ):format(user_id, slot_data.item, amount))

                
				exports["vrp_admin"]:generateLog({
                    category = "inventario",
                    room = "dropar",
                    user_id = user_id,
                    message = ( [[O USER_ID %s DROPOU O ITEM %s NA QUANTIDADE DE x %s]] ):format(user_id, slot_data.item, amount)
                })

                return true
            end
        else
            return {error = 'Re-abra seu inventário. Você está realizando ações rápido demais.'}
        end
    end
end

---@param id number
---@param amount? number
---@param slot? string
---@return boolean
function API.getPickup(id, amount, slot)
    local source = source
    local user   = vRP.getUserId(source)
    if user then
        return PickupSystem:getPickup(id, user, source, amount, slot)
    end
    return false
end



RegisterCommand('garmas', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end
    local ok = vRP.request(source, "Você deseja guardar suas armas?", 30)
    local status, time = exports['vrp']:getCooldown(user_id, "garmas")
    if not status then
        Notify(source, "negado", "Aguarde " .. time .. " segundos para guardar suas armas novamente.")
        return
    end
    if not ok then
        return Notify(source, "negado", "Você recusou a ação.")
    end
    if GetEntityHealth(GetPlayerPed(source)) <= 102 then
        return Notify(source, "negado", "Você não pode guardar armas estando morto.")
    end
    if vRP.hasPermission(user_id, "perm.disparo") and vRP.checkPatrulhamento(user_id) then
        TriggerClientEvent("Notify", source, "negado", "Você não pode guardar armas em patrulhamento.", 5)
        return
    end

    if vRP.hasPermission(user_id, "perm.bombeiro") or vRP.checkPatrulhamento(user_id) then
        TriggerClientEvent("Notify", source, "negado", "Você não pode guardar armas em patrulhamento.", 5)
        return
    end


    if vRP.hasPermission(user_id, "perm.tunar") and vRP.checkPatrulhamento(user_id) then
        TriggerClientEvent("Notify", source, "negado", "Você não pode guardar armas em patrulhamento.", 5)
        return
    end
    
    if vRP.hasPermission(user_id, "perm.customs") and vRP.checkPatrulhamento(user_id) then
        TriggerClientEvent("Notify", source, "negado", "Você não pode guardar armas em patrulhamento.", 5)
        return
    end

    if vRP.hasPermission(user_id, "perm.policia") and vRP.checkPatrulhamento(user_id) then
        TriggerClientEvent("Notify", source, "negado", "Você não pode guardar armas em patrulhamento.", 5)
        return
    end

    if GetPlayerRoutingBucket(source) ~= 0 then
        Notify(source, "negado", "Você não pode guardar armas agora.")
        return
    end
    -- TODO: Check if player is in a restricted area
    --[[
    if camp[user_id] then
            TriggerClientEvent("Notify",source,"negado","Você não pode dar /GARMAS estando com armas de campeonato!")
            return false
        end

        if arena.inArena(source) then
            TriggerClientEvent("Notify",source,"negado","Você não pode guardar armas aqui.", 3)
            return
    end
    ]]
    local weapons = vRP.clearWeapons(user_id)
    exports['vrp']:setCooldown(user_id, "garmas", 60)
    -- print(json.encode(weapons))
    if weapons then
        local weapon_list = ""
        for weapon, v in pairs(weapons) do
            if Items[(weapon):lower()] then
                vRP.giveInventoryItem(user_id, (weapon):lower(), 1)
                if v.ammo > 0 then
                    vRP.giveInventoryItem(user_id, "ammo_" .. (weapon:gsub("WEAPON_", "")):lower(),
                        v.ammo)
                    weapon_list = weapon_list .. "\n(ARMA: " .. weapon .. " MUNICAO: " .. v.ammo .. "x)"
                else
                    weapon_list = weapon_list .. "\n(ARMA: " .. weapon .. " MUNICAO: 0x)"
                end
            else
                print("Item não encontrado: " .. (weapon):lower())
            end
        end

        vRP.sendLog("https://discord.com/api/webhooks/1313515180642271232/C0SNU-jrkxAShUJ2d5dlOTDKo05HTU7FoXR1rQnXayfxaGUAuPFaJ8sIdIMyr7KUtMUF","Passaporte : "..user_id.." Armas : "..weapon_list)
        exports["vrp_admin"]:generateLog({
            category = "inventario",
            room = "garmas",
            user_id = user_id,
            message = ( [[O USER_ID %s GUARDOU %s]] ):format(user_id, weapon_list)
        })
        Notify(source, "sucesso", "Você guardou suas armas.")
    else
        Notify(source, "negado", "Você não tem armas para guardar.")
    end

end, false)

exports("storeWeapons",function(source,user_id)
    local status, time = exports['vrp']:getCooldown(user_id, "garmas")
    if not status then
        return
    end

    local weapons = vRP.clearWeapons(user_id)
    exports['vrp']:setCooldown(user_id, "garmas", 5)
    if weapons then
        local weapon_list = ""
        
        local inService = vRP.checkPatrulhamento(user_id) 
        if inService or GetPlayerRoutingBucket(source) ~= 0 then 
            return 
        end

        for weapon, v in pairs(weapons) do
            if Items[(weapon):lower()] then
                vRP.giveInventoryItem(user_id, (weapon):lower(), 1)
                if v.ammo > 0 then
                    vRP.giveInventoryItem(user_id, "ammo_" .. (weapon:gsub("WEAPON_", "")):lower(),v.ammo)
                    weapon_list = weapon_list .. "\n(ARMA: " .. weapon .. " MUNICAO: " .. v.ammo .. "x)"
                else
                    weapon_list = weapon_list .. "\n(ARMA: " .. weapon .. " MUNICAO: 0x)"
                end
            end
        end
        
        vRP.sendLog("GARMAS","Passaporte : "..user_id.." Armas : "..weapon_list)
    end
end)

function Log(message)
    if webhook ~= "none" then
        PerformHttpRequest("", function(err, text, headers) end, 'POST', json.encode({ content = message }),
            { ['Content-Type'] = 'application/json' })
    end
end

local coldoownRepair = {}
RegisterServerEvent("tryreparar")
AddEventHandler("tryreparar",function(nveh)
	local source = source
	
	if coldoownRepair[source] and (coldoownRepair[source] - os.time()) > 0 then
		return
	end
	coldoownRepair[source] = os.time() + 30

	if type(nveh) ~= 'number' then
		return
	end

	nveh = tostring(nveh)
	if nveh:len() > 10 then
		return
	end

	nveh = tonumber(nveh)

	TriggerClientEvent("syncreparar",-1,nveh)
end)

local coldoownRepairPneus = {}
RegisterServerEvent("tryrepararpneus")
AddEventHandler("tryrepararpneus",function(nveh)
	local source = source
	
	if coldoownRepairPneus[source] and (coldoownRepairPneus[source] - os.time()) > 0 then
		return
	end
	coldoownRepairPneus[source] = os.time() + 30

	if type(nveh) ~= 'number' then
		return
	end

	nveh = tostring(nveh)
	if nveh:len() > 10 then
		return
	end

	nveh = tonumber(nveh)

	TriggerClientEvent("syncrepararpneus",-1,nveh)
end)

RegisterCommand('bauadm', function(source,args)
    local source = source
	local user_id = vRP.getUserId(source)
	if not user_id then return end
	if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id,"perm.resplog") or vRP.hasGroup(user_id,'respilegallotusgroup@445') then
	
		
		local promptHouse = vRP.prompt(source, "Digite o Id da casa: ", t)
		if not promptHouse or promptHouse == "" then
			return
		end

		local rows = vRP.query("mirtin/ownerPropriedade", { houseID = promptHouse })
		if #rows == 0 then
			TriggerClientEvent("Notify",source,"negado","Propriedade não encontrada.", 3)
			return
		end

		vRP.sendLog("https://discord.com/api/webhooks/1304881874702827613/qz7y0aXJTCYE7YgQRjC2vGUjXxcN0DrEMNC2-THpCBEnVDRblOCQ3AOsBs5YbgbK3v3D","STAFF ID "..user_id..' utilizou /bauadm na casa : '..promptHouse)
		TriggerClientEvent('mirt1n:myHouseChest', source, rows[1].id, promptHouse, 1000,rows[1].proprietario)
	end
end, false)

RegisterCommand('baufacadm', function(source,args)
	local user_id = vRP.getUserId(source)
	if not user_id then return end
    if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id,"perm.resplog") or vRP.hasGroup(user_id,'respilegallotusgroup@445') then
        local t = ""
        for i in pairs(Chests) do
            t = t.. i..", "
        end
    
        local promptOrg = vRP.prompt(source, "Escolha a Fac: ", t)
        if not promptOrg or promptOrg == "" then
            return
        end
    
        for i in pairs(Chests) do
            if i == promptOrg then
                staffRequests[source] = { user_id = user_id, org = promptOrg }
                TriggerClientEvent('openChestGroup', source, promptOrg)
                vRP.sendLog("https://discord.com/api/webhooks/1304882057217970287/7Uv8v-Napo1Fb5ThtLtJO7cOldvEESR87DotQQijq5pJq31_Tk7jGqchBsRT3ozIMzlt","STAFF ID "..user_id..' utilizou /baufacadm '..promptOrg)
                return
            end
        end
    
        TriggerClientEvent( "Notify", source, "negado", "Bau de facção não encontrado...", 5 )
        return	
    end
end)