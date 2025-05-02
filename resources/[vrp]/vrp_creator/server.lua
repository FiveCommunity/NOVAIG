local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface(GetCurrentResourceName(), src)


local inCreator = {}
local WhitelistPending = {}

src.getUserId = function()
	local source = source
	local id = vRP.getUserId(source)
	WhitelistPending[id] = source
	return id
end

src.checkWhitelist = function()
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		local query = exports.oxmysql:query_async("SELECT whitelist FROM vrp_users WHERE id = ?", { user_id })
		if #query > 0 and query[1].whitelist == 1 then
			WhitelistPending[user_id] = nil
			return true
		else
			-- Impedir o jogador de continuar caso não esteja aprovado
			SetPlayerRoutingBucket(source, user_id)
			TriggerClientEvent("Notify", source, "negado", "Você não está aprovado na whitelist!", 5)
			return false
		end
	end
	return false
end


local cars = {
	["civictyper"] = true,
	["z1000"] = true,
	["speedo"] = true,
} 

vRP._prepare ("vRP/add_temp_vip", "INSERT INTO temporary_vips (user_id, expiration_date) VALUES (@user_id, FROM_UNIXTIME(@expiration_date)) ON DUPLICATE KEY UPDATE expiration_date = VALUES(expiration_date)")
vRP._prepare ("vRP/get_expired_vips", "SELECT * FROM temporary_vips WHERE expiration_date < NOW()")
vRP._prepare ("vRP/remove_temp_vip", "DELETE FROM temporary_vips WHERE user_id = @user_id")
local vipDuration = 1 * 24 * 60 * 60 -- 1 dia em segundos.
src.finishWhitelist = function(data)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    if not inCreator[user_id] then
        DropPlayer(source, ":)")
        vRP.setBanned(user_id, true, "INJECT finishWhitelist")
        return
    end

    local name_str = data.name..""..data.surname

    if name_str:find("iframe") or name_str:find("<") then
        DropPlayer(source, ":)")
        vRP.setBanned(user_id, true, "IFRAME INJECT")
        return 
    end

    local findType = data.find
    if findType then
        local query = "INSERT INTO leads_new (user_id, type, created_at) VALUES (?, ?, ?)"
        exports.oxmysql:executeSync(query, {user_id, findType, os.date('%Y-%m-%d %H:%M:%S')})

        local query = "UPDATE leads SET " .. findType .. " = " .. findType .. " + 1"
        exports.oxmysql:executeSync(query)
    end

    vRP.execute("vRP/update_user_first_spawn",{ user_id = user_id, nome = data.name, sobrenome = data.surname, idade = data.age })
    vRP.updateIdentity(user_id)

    local uData = vRP.getUData(user_id, 'rewardCar') or false
    if uData == "" then
        if cars[data.vehicle] then
            vRP.execute("vRP/inserir_veh",{ veiculo = data.vehicle, user_id = user_id, ipva = os.time(), expired = "{}" })
		else
			if data.vehicle then
				print('Veiculo não encontrado na criacao '..data.vehicle)
			else
				print('Veiculo retornando nil na criacao')
			end
		end
        vRP.setUData(user_id, 'rewardCar', 1)
        local recomendation = data.recomendation
        if recomendation and tonumber(recomendation) and tonumber(recomendation) ~= user_id then 
            vRP.giveBankMoney(tonumber(recomendation), 50000)
        end
    else
        TriggerClientEvent("Notify",source,"negado","Você já resgatou um veiculo anteriormente.", 5)
    end

	local vipData = vRP.getUData(user_id, 'vipinicial') or false
	if vipData == "" then
		vRP.setUData(user_id, 'vipinicial', 1)
		vRP.addUserGroup(user_id, "VipInicial")
--		exports.hydrus:schedule(user_id, { 'ungroup', user_id, 'VipInicial' }, 86400 * 7)
	end
end

local userlogin = {}

local discordAuthEnabled = GetResourceState('lotus_access') == 'started'
CreateThread(function()
	Wait(5000)
	discordAuthEnabled = GetResourceState('lotus_access') == 'started'
end)
AddEventHandler("onResourceStop", function(resource)
	if resource == 'lotus_access' then
		discordAuthEnabled = false
		for k,v in pairs(GetPlayers()) do
			if Player(v).state.waitDiscordAuth then
				local user_id = vRP.getUserId(v)
				if user_id then
					local rows = vRP.query("vRP/get_controller",{ user_id = user_id }) or false
					if rows and rows[1].controller then
						Player(v).state:set("waitDiscordAuth", false)
						processSpawnController(v,rows[1].controller,user_id)
					end
				else
					DropPlayer(v, 'Relogando...')
				end
			end
		end
	end
end)

AddEventHandler("onResourceStart", function(resource)
	if resource == 'lotus_access' then
		discordAuthEnabled = true
	end
end)

AddEventHandler("lotus_access:authorized", function(user_id, source, first_spawn)
	if not first_spawn then return end
	local rows = vRP.query("vRP/get_controller",{ user_id = user_id }) or false
	if rows and rows[1].controller then
		processSpawnController(source,rows[1].controller,user_id)
	end
end)

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if discordAuthEnabled then return end
	if first_spawn then
		local rows = vRP.query("vRP/get_controller",{ user_id = user_id }) or false
		if rows and rows[1].controller then
			processSpawnController(source,rows[1].controller,user_id)
		end
	end
end)

function processSpawnController(source,statusSent,user_id)
	local source = source
	if statusSent >= 1 then
		if not userlogin[user_id] then
			userlogin[user_id] = true
			doSpawnPlayer(source,user_id,false)
		else
			doSpawnPlayer(source,user_id,true)
		end
	elseif statusSent == 0 then
		inCreator[user_id] = true
		userlogin[user_id] = true
		TriggerClientEvent("character:characterCreate",source)
		SetPlayerRoutingBucket(source, user_id)
	end
end

RegisterServerEvent("character:finishedCharacter")
AddEventHandler("character:finishedCharacter",function(currentCharacterMode,Clothes)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local query = vRP.query("vRP/get_controller", { user_id = user_id })
		if #query > 0 then
			if not inCreator[user_id] then
				return
			end
			inCreator[user_id] = nil
			
			vRP.execute("vRP/set_controller",{ user_id = user_id, controller = 1, rosto = json.encode(currentCharacterMode), roupas = json.encode(Clothes) })
			vRP.updateUserApparence(user_id, "clothes", Clothes)
			vRP.updateUserApparence(user_id, "rosto", currentCharacterMode)
			

			vRP.giveInventoryItem(user_id, "money", 5000, false, 1)
			vRP.giveInventoryItem(user_id, "celular", 1, false, 2)
			vRP.giveInventoryItem(user_id, "mochila", 3, false, 3)
			vRP.giveInventoryItem(user_id, "radio", 1, false, 4)

			SetPlayerRoutingBucket(source, 0)
		
			TriggerEvent("barbershop:init", user_id)
		end
	end
end)

function doSpawnPlayer(source,user_id,firstspawn)
	if source then
		TriggerClientEvent("character:normalSpawn",source,firstspawn)
	end
end

RegisterCommand("verroupas",function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then 
        local clothes = vRPclient.getCustom(source)
        if clothes then 
            vRP.prompt(source, "Código da Roupa", json.encode(clothes))
        end
    end
end)

AddEventHandler("vRP:playerLeave", function(uid) 
	if WhitelistPending[uid] then WhitelistPending[uid] = nil end
end)

CreateThread(function() 
	while true do
		for id, src in pairs(WhitelistPending) do
			local bucket = GetPlayerRoutingBucket(src)
			if bucket == 0 then
				if vRP.isWhitelisted(id) then
					WhitelistPending[id] = nil
				else
					SetPlayerRoutingBucket(src, src)
					print("UID: "..id.." | PULANDO WL (bucket: "..bucket..")")
					TriggerEvent("AC:ForceBan", src, {
						reason = "SKIP_WL_3",
						additionalData = "Pulou Whitelist!",
						forceBan = true
					})
				end
			end
		end
		Wait(5000)
	end
end)



















