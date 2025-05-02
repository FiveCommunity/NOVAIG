local cache = {}
cache['inArena'] = {}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SETARENA
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.setArena(source, status)
	if status then
		cache['inArena'][source] = true
	else
		cache['inArena'][source] = nil
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CRIAR ITENS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local tn = tonumber
local ts = tostring


-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS PADROES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getAllItens()
	return Items
end

function vRP.getItemName(idname)
	return itemNameList(idname)
end

function vRP.getItemWeight(idname)
	if Items[idname] then
		return Items[idname].weight
	end
	return 0
end

function vRP.itemFood(args)
    local item = vRP.items[args]
    if item then
        return item.fome,item.sede
    end
end

function vRP.computeItemName(item,args)
	if type(item.name) == "string" then
		return item.name
	else
		return item.name(args)
	end
end

function vRP.computeItemWeight(item,args)
	if type(item.weight) == "number" then
		return item.weight
	else
		return item.weight(args)
	end
end

function vRP.getItemType(args)
	local item = vRP.items[args]
	if item then
		return item.tipo
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMBODYLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function itemBodyList(item)
	if Items[item] then 
		return Items[item]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMINDEXLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function itemIndexList(item)
	if Items[item] then
		return Items[item].index
	end
end
exports("itemIndexList",itemIndexList)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMPNGLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function itemImageList(item)
	if Items[item] then
        if Items[item].png then
            return Items[item].png
        end
        return Items[item].index
    end
end
exports("itemImageList",itemImageList)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMNAMELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function itemNameList(item)
	if Items[item] then
		return Items[item].name
	end
	return "Deleted"
end
exports("itemNameList",itemNameList)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMTYPELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function itemTypeList(item)
	if Items[item] then
		return Items[item].type
	end
end
exports("itemTypeList",itemTypeList)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMAMMOLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function itemAmmoList(item)
	if Items[item] then
		return Items[item].ammo
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMWEIGHTLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function itemWeightList(item)
	if Items[item] then
		return Items[item].weight
	end
	return 0
end
exports("itemWeightList",itemWeightList)


function vRP.computeChestWeight(items)
	local weight = 0
	for k,v in pairs(items) do
		if itemBodyList(k) then
			weight +=  itemWeightList(k) * tn(v.amount)
		end
	end
	return weight
end

function vRP.swapSlot(user_id,slot,target)
	local data = vRP.getInventory(user_id)
	if not data then return end
	local temp = data[ts(slot)]
	data[ts(slot)] = data[ts(target)]
	data[ts(target)] = temp 
end

function vRP.computeInvWeight(user_id)
	local weight = 0
	local inventory = vRP.getInventory(user_id)
	if inventory then
		for k in pairs(inventory) do
			if vRP.getItemWeight(inventory[k].item) then
				weight = weight + vRP.getItemWeight(inventory[k].item) * parseInt(inventory[k].amount)
			end
		end
		return weight
	end
	return 0
end 

function vRP.computeItemsWeight(items)
	local weight = 0
	if items then
		for k in pairs(items) do
			if vRP.items[items[k].item] then
				weight = weight + vRP.getItemWeight(items[k].item) * parseInt(items[k].amount)
			end
		end
		return weight
	end
	return 0
end 

function vRP.getInventoryItemAmount(user_id,idname)
	local data = vRP.getInventory(user_id)
	if data then
		for k in pairs(data) do
			if data[k].item == idname then
				-- vRP.checkInventoryWeightAndBan(user_id)
				return parseInt(data[k].amount)
			end
		end
	end
	return 0
end

function vRP.getItemInSlot(user_id, idname, target)
	local data = vRP.getInventory(user_id)
	if data then
		for k in pairs(data) do
			if data[k].item == idname then
				return k
			end
		end
	end
	return target
end

function vRP.getInventoryMaxWeight(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		local mochila = data.mochila
		local peso_base = 10 + 30 * tonumber(mochila.quantidade)
		local peso_adicional = 0
		
		if vRP.hasGroup(user_id,"TOP1") or vRP.hasGroup(user_id,"respstafflotusgroup@445") or vRP.hasGroup(user_id,"resploglotusgroup@445") or vRP.hasGroup(user_id,"respeventoslotusgroup@445") or vRP.hasGroup(user_id, "developerlotusgroup@445") or vRP.hasPermission(user_id, "diretor.permissao") or vRP.hasPermission(user_id, "perm.resplog") or vRP.hasGroup(user_id, "developerofflotusgroup@445") or vRP.hasGroup(user_id, "respilegallotusgroup@445") or vRP.hasGroup(user_id, "respilegalofflotusgroup@445") or vRP.hasGroup(user_id, "resppolicialotusgroup@445") then 
			-- vRP.checkInventoryWeightAndBan(user_id)
			return 100000000+30*tonumber(mochila.quantidade)
		end
		if vRP.hasGroup(user_id, "Pascoa") then
			peso_adicional = peso_adicional + 50
		end
		if vRP.hasGroup(user_id, "VipMaio") then
			peso_adicional = peso_adicional + 50
		end
		if vRP.hasGroup(user_id, "Ferias") then
			peso_adicional = peso_adicional + 50
		end
		if vRP.hasGroup(user_id, "VipIndependencia") then
			peso_adicional = peso_adicional + 50
		end
		if vRP.hasGroup(user_id, "VipMakakero") then
			peso_adicional = peso_adicional + 50
		end
		if vRP.hasGroup(user_id, 'VipHalloween') then
			peso_adicional = peso_adicional + 50
		end
		if vRP.hasGroup(user_id, 'VipDeluxe') then
			peso_adicional = peso_adicional + 50
		end
		if vRP.hasGroup(user_id, 'VipOutono') then
			peso_adicional = peso_adicional + 50
		end
		if vRP.hasGroup(user_id, 'VipBlackfriday') then
			peso_adicional = peso_adicional + 50
		end
		if vRP.hasGroup(user_id, 'VipNatal') then
			peso_adicional = peso_adicional + 50
		end
		if vRP.hasGroup(user_id, 'VipCarnaval') then
			peso_adicional = peso_adicional + 50
		end
		if vRP.hasGroup(user_id, 'mochila350') then
			peso_adicional = peso_adicional + 350
		end
		if vRP.hasGroup(user_id, 'm400') then
			peso_adicional = peso_adicional + 400
		end
		if vRP.hasPermission(user_id, 'perm.yakuza') then
			peso_adicional = peso_adicional + 100
		end
		if vRP.hasPermission(user_id, 'perm.dandara') then
			peso_adicional = peso_adicional + 400
		end
		
		-- vRP.checkInventoryWeightAndBan(user_id)
		return peso_base + peso_adicional
	end
end

function vRP.clearInventory(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		data.inventory = {}
	end
end

function vRP.parseItem(idname)
	return splitString(idname,"|")
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES DO INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------

function vRP.giveInventoryItem(user_id,idname,amount,notify,slot)	
	local source = vRP.getUserSource(user_id)
	local data 		= vRP.getInventory(user_id)
	local amount 	= parseInt(amount)

	if not itemBodyList(idname) then 
		return 
	end
	if type(notify) == "string" then 
		slot = notify
		notify = true
	end
	if not (data or amount < 0) then 
		return false 
	end
	if not slot then
		local initial = 5
		repeat
			initial = initial + 1
		until data[ts(initial)] == nil or (data[ts(initial)] and data[ts(initial)].item == idname)
		initial = ts(initial)		
		if data[initial] == nil then
			data[initial] = { item = idname, amount = amount }
		elseif data[initial] and data[initial].item == idname then
			data[initial].amount = tn(data[initial].amount) + amount
		end
		if notify and itemBodyList(idname) then
			-- vRP.checkInventoryWeightAndBan(user_id)
			TriggerClientEvent("itensNotify",source,"sucesso", amount , vRP.getItemName(idname), idname, vRP.getItemWeight(idname)*amount)
		end
	else
		slot = ts(slot)
		if data[slot] then
			if data[slot].item == idname then
				local oldAmount = tn(data[slot].amount)
				data[slot] = { item = idname, amount = tn(oldAmount) + amount }
			else 
				data[slot] = { item = idname, amount = amount or 1  }
			end
		else
			data[slot] = { item = idname, amount = amount or 1 }
		end
		if notify and itemBodyList(idname) then
			TriggerClientEvent("itensNotify",source,"sucesso", amount , vRP.getItemName(idname), idname, vRP.getItemWeight(idname)*amount)
		end
	end 
end

function vRP.tryGetInventoryItem(user_id,idname,amount,notify,slot)
	if amount<0 then
		vRP.setBanned(user_id, 1, "tryGetInventoryItem")
		return false
	end
	local data = vRP.getInventory(user_id)
	if not data then return end
	if type(notify) == "string" then 
		slot = notify
		notify = true
	end
	local source = vRP.getUserSource(user_id)
	local amount = parseInt(amount)
	if not slot then
		for k,v in pairs(data) do
			if v.item == idname and parseInt(v.amount) >= amount then
				v.amount = v.amount - amount
				if v.amount <= 0 then
					data[k] = nil
				end
				if notify and itemBodyList(idname) then
					TriggerClientEvent("itensNotify",source,"negado", amount , vRP.getItemName(idname), idname, vRP.getItemWeight(idname)*amount)
				end
				return true
			end
		end
	else
		local slot  = ts(slot)
		if data[slot] and data[slot].item == idname and parseInt(data[slot].amount) >= amount then
			data[slot].amount = data[slot].amount - amount
			if data[slot].amount <= 0 then
				data[slot] = nil
			end
			if notify and itemBodyList(idname) then
				TriggerClientEvent("itensNotify",source,"negado", amount , vRP.getItemName(idname), idname, vRP.getItemWeight(idname)*amount)
			end
			return true
		end
	end  
end

function vRP.tryGetInventoryItem(user_id,idname,amount,notify,slot)
	local amount = parseInt(amount)
	if amount < 0 then
		amount = 1
	end
	
	local source = vRP.getUserSource(user_id)
	local data = vRP.getInventory(user_id)
	if user_id then
		if data then
			if not slot then
				for k,v in pairs(data) do
					if v.item == idname and parseInt(v.amount) >= parseInt(amount) then
						v.amount = parseInt(v.amount) - parseInt(amount)

						if parseInt(v.amount) <= 0 then
							data[k] = nil
						end

						if notify then
							TriggerClientEvent("itensNotify",source,"negado", amount , vRP.getItemName(idname), idname, vRP.getItemWeight(idname)*amount)
						end
						-- vRP.checkInventoryWeightAndBan(user_id)
						return true
					end
				end
			else
				local slot  = tostring(slot)

				if data[slot] and data[slot].item == idname and parseInt(data[slot].amount) >= parseInt(amount) then
					data[slot].amount = parseInt(data[slot].amount) - parseInt(amount)

					if parseInt(data[slot].amount) <= 0 then
						data[slot] = nil
					end

					if notify then
						TriggerClientEvent("itensNotify",source,"negado", amount , vRP.getItemName(idname), idname, vRP.getItemWeight(idname)*amount)
					end
					-- vRP.checkInventoryWeightAndBan(user_id)
					return true
				end
			end
		end
	end
	return false
end

function vRP.getSlotItem(user_id, slot)
	local inventory = vRP.getInventory(user_id)
	if not inventory then
		return
	end
	
	return  ((inventory[slot]) and inventory[slot]) or nil
end

function vRP.removeInventoryItem(user_id,idname,amount)
	local source = vRP.getUserSource(user_id)
	local data = vRP.getInventory(user_id)
	if user_id then
		if data then
			for k,v in pairs(data) do
				if v.item == idname and parseInt(v.amount) >= parseInt(amount) then
					v.amount = parseInt(v.amount) - parseInt(amount)

					if parseInt(v.amount) <= 0 then
						data[k] = nil
					end
					break
				end
			end
			-- vRP.checkInventoryWeightAndBan(user_id)
			TriggerClientEvent("itensNotify",source,"negado", amount , vRP.getItemName(idname), idname, vRP.getItemWeight(idname)*amount)
		end
	end
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CHECKAMOUNT BAN
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.checkInventoryWeightAndBan(user_id)
    local totalWeight = vRP.computeInvWeight(user_id)  
    local source = vRP.getUserSource(user_id)

    if totalWeight > 6600 and not vRP.hasPermission(user_id, "perm.mochilastaff") then
		vRP.sendLog("", "O ID "..user_id.." está com "..totalWeight.." KG no inventário!")
		DropPlayer(source, 'Você foi pego pelo makakero LGBT!')
		vRP.setBanned(user_id, 1, "Você foi pego pelo makakero LGBT!")
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE MOCHILA
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.addMochila(user_id)
	local data = vRP.getUserDataTable(user_id)
	local mochila = data.mochila

	if data then
		if not mochila.perder then
			mochila.perder = 0
		end

		data.mochila = { quantidade = mochila.quantidade+1, perder = mochila.perder }
	end
end

function vRP.remMochila(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		if data.mochila then

			if not data.mochila.perder then
				data.mochila.perder = 0
			end

			data.mochila = { quantidade = 0, perder = data.mochila.perder }
		end
	end
end

function vRP.getMochilaAmount(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then

		if data.mochila then
			-- vRP.checkInventoryWeightAndBan(user_id)
			return (data.mochila.quantidade or 0)
		end
	end

	return 0
end

function vRP.atualizarMochila(user_id, time)
	local data = vRP.getUserDataTable(user_id)
	local mochila = data.mochila
	if data then
		-- vRP.checkInventoryWeightAndBan(user_id)
		data.mochila = { quantidade = mochila.quantidade, perder = time }
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EVENTOS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerJoin", function(user_id,source,name)
	local data = vRP.getUserDataTable(user_id)
	if not data then return end
	
	if not data.inventory then
		data.inventory = {}
	end

	if not data.mochila then
		data.mochila = { quantidade = 0, perder = 0 }
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NATION GET INVENTARIO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function vRP.getVehicleName(name)
	return exports["nova_garage"]:getVehicleName(name)
end

function vRP.getVehicleTrunk(name)
	return exports["nova_garage"]:getVehicleTrunk(name)
end
