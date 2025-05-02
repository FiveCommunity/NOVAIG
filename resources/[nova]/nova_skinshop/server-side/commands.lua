-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('oculos', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			-- vCLIENT._updateClothes(source, "oculos", tonumber(args[1]), tonumber(args[2]))
			TriggerClientEvent("oculos",source,args[1],args[2])

		end
	end
end)

RegisterCommand('chapeu', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			TriggerClientEvent("chapeu",source,args[1],args[2])
			-- vCLIENT._updateClothes(source, "chapeu", tonumber(args[1]), tonumber(args[2]))
		end
	end
end)

RegisterCommand('sapatos', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			-- vCLIENT._updateClothes(source, "sapato", tonumber(args[1]), tonumber(args[2]))
			TriggerClientEvent("sapatos",source,args[1],args[2])
		end
	end
end)

RegisterCommand('maos', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			-- vCLIENT._updateClothes(source, "mao", tonumber(args[1]), tonumber(args[2]))
			TriggerClientEvent("maos",source,args[1],args[2])

		end
	end
end)

RegisterCommand('colete', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			-- vCLIENT._updateClothes(source, "colete", tonumber(args[1]), tonumber(args[2]))
			TriggerClientEvent("setcolete",source,args[1],args[2])

		end
	end
end)

RegisterCommand('jaqueta', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			-- vCLIENT._updateClothes(source, "jaqueta", tonumber(args[1]), tonumber(args[2]))
			TriggerClientEvent("jaqueta",source,args[1],args[2])
			
		end
	end
end)

RegisterCommand('mascara', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			-- vCLIENT._updateClothes(source, "mascara", tonumber(args[1]), tonumber(args[2]))
			TriggerClientEvent("mascara",source,args[1],args[2])

		end
	end
end)

RegisterCommand('acessorio', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			-- vCLIENT._updateClothes(source, "acessorio", tonumber(args[1]), tonumber(args[2]))
			TriggerClientEvent("acessorios",source,args[1],args[2])

		end
	end
end)

RegisterCommand('blusa', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			-- vCLIENT._updateClothes(source, "blusa", tonumber(args[1]), tonumber(args[2]))
			TriggerClientEvent("blusa",source,args[1],args[2])

		end
	end
end)

RegisterCommand('calca', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, "roupas") >= 1 or vRP.hasPermission(user_id,"perm.roupas") then
			-- vCLIENT._updateClothes(source, "calca", tonumber(args[1]), tonumber(args[2]))
			TriggerClientEvent("calca",source,args[1],args[2])
		end
	end
end)

RegisterCommand('lojaderoupas', function(source, args)
	local source = source
	local user_id = vRP.getUserId(source)
	if not user_id then
		return
	end

	if not vRP.hasPermission(user_id, 'perm.ferias') then
		return
	end

	if GetEntityHealth(GetPlayerPed(source)) <= 101 then
		return
	end


	clientFunctions.openNuiShop(source)
end)