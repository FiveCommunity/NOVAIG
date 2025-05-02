local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")

local config = module("cfg/base")

vRP = {}
Proxy.addInterface("vRP",vRP)

tvRP = {}
Tunnel.bindInterface("vRP",tvRP)
vRPclient = Tunnel.getInterface("vRP")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TABELAS TEMPORÁRIAS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP.users = {}
vRP.rusers = {}
vRP.user_tables = {}
vRP.user_appareance = {}
vRP.user_tmp_tables = {}
vRP.user_sources = {}
vRP.user_through_src = {}
vRP.tempSource = {}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local prepared_queries = {}
local GeneratingCache = false 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.prepare(name,query)
	prepared_queries[name] = query
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QUERY
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.query(name,params,mode)
	return exports["oxmysql"]:query_async(prepared_queries[name],params)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EXECUTE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.execute(name,params)
	exports["oxmysql"]:query(prepared_queries[name],params)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BASE.LUA
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.setUData(user_id,key,value)
	exports["oxmysql"]:executeSync([[
		REPLACE INTO `vrp_user_data`(`user_id`,`dkey`,`dvalue`) VALUES(?,?,?)
	]],{ 
		user_id,key,value
	})
end

function vRP.getUData(user_id,key,cbr)
	local rows = exports["oxmysql"]:singleSync("SELECT `dvalue` FROM `vrp_user_data` WHERE `user_id` = ? AND `dkey` = ? ", { user_id,key })
	if rows then 
		return rows.dvalue
	end
	return ""
end

function vRP.remUData(user_id,key)
	vRP.execute("vRP/rem_u_data",{ user_id = parseInt(user_id), key = key })
end

function vRP.setSData(key,value)
	exports["oxmysql"]:executeSync([[
		REPLACE INTO `vrp_srv_data`(`dkey`,`dvalue`) VALUES(?,?)
	]],{ 
		key,value
	})
end

function vRP.getSData(key, cbr)
	local rows = exports["oxmysql"]:singleSync("SELECT `dvalue` FROM `vrp_srv_data` WHERE `dkey` = ?", { key })
	if rows then 
		return rows.dvalue
	end
	return ""
end

function vRP.getSDataKeys()
    local rows = exports["oxmysql"]:executeSync("SELECT `dkey` FROM `vrp_srv_data`", {})
    local keys = {}
    for _, row in ipairs(rows) do
        table.insert(keys, row.dkey)
    end
    return keys
end

function vRP.getUsers()
	local users = {}
	for k, v in pairs(vRP.user_sources) do
		users[k] = v
	end
	return users
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CAPTURAR IDENTIFIERS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/getAllIdentifiers", "SELECT * FROM vrp_user_ids")

local identifier = {
	cache = {}
}

function identifier:createCache()
	local rows = vRP.query("vRP/getAllIdentifiers", {})
	for i = 1, #rows do
		if not self.cache[rows[i].user_id] then self.cache[rows[i].user_id] = {} end
		self.cache[rows[i].user_id][#self.cache[rows[i].user_id] + 1] = rows[i].identifier
	end

	GeneratingCache = true
end

function identifier:set(identifier, user_id)
	if not self.cache[user_id] then self.cache[user_id] = {} end

	self.cache[user_id][#self.cache[user_id] + 1] = identifier
end

function identifier:remove(identifier, user_id)
    if self.cache[user_id] then
        for i, id in ipairs(self.cache[user_id]) do
            if id == identifier then
                table.remove(self.cache[user_id], i)
                print(("Identificador %s removido do usuário %d."):format(identifier, user_id))
                return
            end
        end
    end
end

function identifier:Format(ids)
	local output = {}
	for i = 1, #ids do 
		local id = ids[i]
		if not id:find('ip:') then
			output[id] = true
		end
	end

	return output
end

function vRP.getUserIdByIdentifiers(ids)
	if ids and #ids then
		
		local identifiers = identifier:Format(ids) 
		local UserIdentifier = {}
		for user_id, identifier in pairs(identifier.cache) do
			for i = 1, #identifier do
				if identifiers[identifier[i]] then
					UserIdentifier[#UserIdentifier + 1] = user_id
				end
			end
		end

		if #UserIdentifier > 0 then		
			return math.min(table.unpack(UserIdentifier))
		end
		

		local rows = exports["oxmysql"]:executeSync([[INSERT INTO vrp_users(whitelist) VALUES(false)]])
		if rows then
			local user_id = rows.insertId

			for l,w in pairs(ids) do
				if (string.find(w,"ip:") == nil) then
					vRP.execute("vRP/add_identifier",{ user_id = user_id, identifier = w })
					identifier:set(w, user_id)
				end
			end

			vRP.execute("vRP/init_users_infos",{ user_id = user_id })
			TriggerEvent("vRP/new_user_created", user_id)
			return user_id
		end
	end
end

function vRP.getUserIdByIdentifier(ids) -- MQCU
	local rows = vRP.query("vRP/userid_byidentifier",{ identifier = ids})
	if #rows > 0 then
		return rows[1].user_id
	else
		return -1
	end
end

exports("updateIdentifier", function(...)
	identifier:set(...)
end)

exports("removeIdentifier", function(...)
    identifier:remove(...)
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE WHITELIST
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.isWhitelisted(user_id)
	local rows = vRP.query("vRP/get_whitelisted",{ user_id = user_id })
	if #rows > 0 then
		return rows[1].whitelist
	else
		return false
	end
end

function vRP.setWhitelisted(user_id,whitelisted)
	vRP.execute("vRP/set_whitelisted",{ user_id = user_id, whitelist = whitelisted })
end

function vRP.kick(source,reason)
	DropPlayer(source,reason)
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION GERAIS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.getUserDataTable(user_id)
	return vRP.user_tables[user_id]
end

function vRP.getUserApparence(user_id)
	return vRP.user_appareance[user_id]
end

function vRP.getUserTmpTable(user_id)
	return vRP.user_tmp_tables[user_id]
end

function vRP.getUserId(source)
	if source ~= nil then
		if vRP.user_through_src[source] then 
			return vRP.user_through_src[source]
		end
		local ids = GetPlayerIdentifiers(source)
		if ids ~= nil and #ids > 0 then
			return vRP.users[ids[1]]
		end
	end
	return nil
end

function vRP.getUserSource(user_id)
	return vRP.user_sources[user_id]
end

function vRP.updateUserApparence(user_id, name, value)
	if vRP.user_appareance[user_id] then
		vRP.user_appareance[user_id][name] = value
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Sistema do Inventario
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.getInventory(user_id)
	local data = vRP.user_tables[user_id]
	if data then
		return data.inventory
	end
	return false
end

-- RegisterNetEvent('playerJoining')
AddEventHandler('playerJoining', function(tempId)
	local src = source
	SetPlayerRoutingBucket(src, src)
	local tempId = tonumber(tempId)
	if vRP.user_through_src[tempId] then 
		vRP.user_through_src[src] = vRP.user_through_src[tempId]
		vRP.user_through_src[tempId] = nil
	end
end)

AddEventHandler("playerJoining", function(old_source)
	old_source = parseInt(old_source)

	local source = source

	local plyId = vRP.tempSource[old_source]
	if not plyId then return end

	vRP.user_sources[plyId] = source
	vRP.tempSource[old_source] = nil
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HWID SYSTEM
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("getAllTokens", "SELECT token,id FROM mirtin_bans_hwid")
vRP.prepare("mirtin_bans/getUserBans", "SELECT user_id,banimento,desbanimento,motivo FROM mirtin_bans WHERE user_id = @user_id")
vRP.prepare("mirtin_bans/addToken","INSERT IGNORE INTO mirtin_bans_hwid(id,token) VALUES(@user_id,@token)")

local geral = {
	logo = "https://cdn.discordapp.com/attachments/1173704025267507202/1174446266403520584/838612b66ee96f5a927a4e38892380c9.png", -- LOGO do Servidor
    background = "https://cdn.discordapp.com/attachments/403296672748142595/875522538510368858/download_1.jpg", -- Fundo da Tela de banimento
    discord = "https://discord.gg/cidadealtarj", -- Discord do Servidor (Colocar https://)

    color = 6356736, -- Cor da Lateral do WeebHook
    footer = "© CIDADE NOVA IGUAÇU", -- RODAPE do WeebHook

    whookHWIDlogin = "", -- WEEBHOOK para quando o estiver banido HWID e logar com outra conta.
}

local hwid = {
	list = {}
}

function hwid:createCache()
	local query = vRP.query("getAllTokens", {})

	if query then
		for i = 1, #query do
			self.list[query[i].token] = query[i].id
		end
	end
end

function hwid:getUserTokens(src)
	local numTokens = GetNumPlayerTokens(src)
	local tokens = {}
	for i = 0, numTokens - 1 do
		tokens[i] = GetPlayerToken(src, i)
	end

	return tokens
end

function hwid:checkBanned(src, user_id)
	local tokens = hwid:getUserTokens(src)
	for i = 1, #tokens do
		if self.list[tokens[i]] then
			if self.list[tokens[i]] ~= user_id then
				local query = vRP.query("mirtin_bans/getUserBans", { user_id = self.list[tokens[i]] })
				if query and #query > 0 then
					vRP.execute("mirtin/insertBanned", { user_id = user_id, motivo = "Banido HWID! ID ANTIGO: "..self.list[tokens[i]], banimento = os.date("%d/%m/%Y as %H:%M"), desbanimento = "Nunca", time = 0, hwid = 0 })

					local card = '{ "type": "AdaptiveCard", "$schema": "http://adaptivecards.io/schemas/adaptive-card.json", "version": "1.3", "body": [ { "type": "Image", "url": "'..geral['logo']..'", "spacing": "Large", "size": "Large", "horizontalAlignment": "Center" }, { "type": "Container", "separator": true, "items": [ { "type": "TextBlock", "text": "Você está banido da cidade.", "wrap": true, "fontType": "Default", "weight": "Bolder", "color": "Attention", "size": "Large", "horizontalAlignment": "Center", "spacing": "None" } ] }, { "type": "TextBlock", "text": "Seu ID: '..user_id..'", "wrap": true, "size": "Medium", "color": "Warning", "fontType": "Default", "weight": "Bolder" }, { "type": "TextBlock", "text": "Motivo: Você foi banido no ID: '.. self.list[tokens[i]] ..'", "wrap": true, "size": "Medium", "color": "Warning", "weight": "Bolder" }, { "type": "TextBlock", "text": "Data do Banimento: '.. os.date("%d/%m/%Y") ..'", "wrap": true, "weight": "Bolder", "color": "Warning", "size": "Medium" }, { "type": "TextBlock", "text": "Data do Desbanimento: '.. query[1].desbanimento ..'", "wrap": true, "size": "Medium", "weight": "Bolder", "color": "Warning" }, { "type": "Container", "separator": true }, { "type": "ActionSet", "actions": [ { "type": "Action.OpenUrl", "title": "Acesse o Discord", "url": "'..geral['discord']..'", "iconUrl": "https://discord.com/assets/3437c10597c1526c3dbd98c737c2bcae.svg" } ] } ], "minHeight": "200px", "backgroundImage": { "url": "'..geral['background']..'" } }'
					local corpoBan = { { ["color"] = geral['color'], ["title"] = "**".. ":no_entry: BAN HWID | Tentativa de Login " .."**\n", ["thumbnail"] = { ["url"] = geral['logo'] }, ["description"] = "**ID NOVO:**\n```cs\n"..user_id.."```\n**ID ANTIGO: **\n```cs\n"..self.list[tokens[i]].."```\n**Data:** ```cs\n "..os.date("%d/%m/%Y as %H:%M").."``` ", ["footer"] = { ["text"] = geral['footer'], }, } }
					PerformHttpRequest(geral['whookHWIDlogin'], function(err, text, headers) end, 'POST', json.encode({embeds = corpoBan}), { ['Content-Type'] = 'application/json' })

					return true, card
				end
			end
		else
			vRP.execute("mirtin_bans/addToken", { user_id = user_id, token = tokens[i] })
			self.list[tokens[i]] = user_id
		end
	end

	local query = vRP.query("mirtin_bans/getUserBans", { user_id = user_id })
	if query and #query > 0 then
		local card = '{ "type": "AdaptiveCard", "$schema": "http://adaptivecards.io/schemas/adaptive-card.json", "version": "1.3", "body": [ { "type": "Image", "url": "'..geral['logo']..'", "spacing": "Large", "size": "Large", "horizontalAlignment": "Center" }, { "type": "Container", "separator": true, "items": [ { "type": "TextBlock", "text": "Você está banido da cidade.", "wrap": true, "fontType": "Default", "weight": "Bolder", "color": "Attention", "size": "Large", "horizontalAlignment": "Center", "spacing": "None" } ] }, { "type": "TextBlock", "text": "Seu ID: '..user_id..'", "wrap": true, "size": "Medium", "color": "Warning", "fontType": "Default", "weight": "Bolder" }, { "type": "TextBlock", "text": "Motivo: '..query[1].motivo..'", "wrap": true, "size": "Medium", "color": "Warning", "weight": "Bolder" }, { "type": "TextBlock", "text": "Data do Banimento: '..query[1].banimento..'", "wrap": true, "weight": "Bolder", "color": "Warning", "size": "Medium" }, { "type": "TextBlock", "text": "Data do Desbanimento: '..query[1].desbanimento..'", "wrap": true, "size": "Medium", "weight": "Bolder", "color": "Warning" }, { "type": "Container", "separator": true }, { "type": "ActionSet", "actions": [ { "type": "Action.OpenUrl", "title": "Acesse o Discord", "url": "'..geral['discord']..'", "iconUrl": "https://discord.com/assets/3437c10597c1526c3dbd98c737c2bcae.svg" } ] } ], "minHeight": "200px", "backgroundImage": { "url": "'..geral['background']..'" } }'	
		return true, card
	end

	return false
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- IPS CACHE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("getAllIps", "SELECT user_id,ip FROM mirtin_bans_ip")

local Ips = {
	list = {}
}

function Ips:CreateCache()
	local query = vRP.query("getAllIps", {})

	if query then
		for i = 1, #query do
			self.list[query[i].ip] = query[i].user_id
		end
	end
end

function Ips:GetIp(user_id, ip)
	if self.list[ip] then
		local card = '{ "type": "AdaptiveCard", "$schema": "http://adaptivecards.io/schemas/adaptive-card.json", "version": "1.3", "body": [ { "type": "Image", "url": "'..geral['logo']..'", "spacing": "Large", "size": "Large", "horizontalAlignment": "Center" }, { "type": "Container", "separator": true, "items": [ { "type": "TextBlock", "text": "Você está banido da cidade.", "wrap": true, "fontType": "Default", "weight": "Bolder", "color": "Attention", "size": "Large", "horizontalAlignment": "Center", "spacing": "None" } ] }, { "type": "TextBlock", "text": "Seu ID: '..user_id..'", "wrap": true, "size": "Medium", "color": "Warning", "fontType": "Default", "weight": "Bolder" }, { "type": "TextBlock", "text": "Motivo: Você foi banido no ID: '.. self.list[ip] ..'", "wrap": true, "size": "Medium", "color": "Warning", "weight": "Bolder" }, { "type": "TextBlock", "text": "Data do Banimento: Indefinido (2.0)", "wrap": true, "weight": "Bolder", "color": "Warning", "size": "Medium" }, { "type": "TextBlock", "text": "Data do Desbanimento: Nunca", "wrap": true, "size": "Medium", "weight": "Bolder", "color": "Warning" }, { "type": "Container", "separator": true }, { "type": "ActionSet", "actions": [ { "type": "Action.OpenUrl", "title": "Acesse o Discord", "url": "'..geral['discord']..'", "iconUrl": "https://discord.com/assets/3437c10597c1526c3dbd98c737c2bcae.svg" } ] } ], "minHeight": "200px", "backgroundImage": { "url": "'..geral['background']..'" } }'
		vRP.execute("mirtin/insertBanned", { user_id = user_id, motivo = "Banido HWID 2.0! ID ANTIGO: "..self.list[ip], banimento = os.date("%d/%m/%Y as %H:%M"), desbanimento = "Nunca", time = 0, hwid = 1 })
		return true, card
	end
end

function Ips:AddIp(user_id, ip)
	self.list[ip] = user_id
end

vRP.prepare("mirtin/insertBanned/base","INSERT IGNORE INTO mirtin_bans(user_id,motivo,desbanimento,banimento,time, hwid, owner,staff) VALUES(@user_id,@motivo,@desbanimento,@banimento,@time, @hwid, @owner,@staff)")
function vRP.setBanned(user_id,status, reason, time, verme,staffBan)
	if time and tostring(time) == "Likizao-AC" then
		reason = "Cheat"
		time = 0
	end
	if not time then
		time = 0
	end
	if user_id then
		vRP.execute("mirtin/insertBanned/base", { user_id = user_id, motivo = reason, banimento = os.date("%d/%m/%Y as %H:%M"), desbanimento = time > 0 and os.date("%d/%m/%Y as %H:%M", time) or "Nunca", time = time, hwid = 0, owner = verme and 1 or 0,  staff = staffBan and staffBan or 0 })
	end

	if status then
		local query = vRP.query("mirtin_bans/GetBanIp", { user_id = user_id })
		if #query > 0 then
			local ip = (query[1].ip or "0.0.0.0")
			vRP.execute("mirtin_bans/SetBanIP", { user_id = user_id, ip = ip })
			Ips:AddIp(user_id, ip)
		end
	end
end 

function vRP.removeBanIp(user_id)
	for ip, ply_id in pairs(Ips.list) do
		if user_id == ply_id then
			Ips.list[ip] = nil
		end
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QUEUE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local ConfigQUEUE = {
	active = false,
	delay = 1, -- DELAY PRA PROCESSAR A FILA
}

local QUEUE = {
	List = {},
	Ply = {},

	Priority = {
		--[1] = true,
	}
}

function QUEUE:addPlayer(source,ids)
	local POS = (#self.List + 1)

	self.List[POS] = source
	self.Ply[source] = POS
	
	print(("Adicionado Source: %s na posição %s pos"):format(source, POS))
end

function QUEUE:get(source)
	return self.Ply[source] or false
end

function QUEUE:start()
	print('Iniciando Sistema de FILA')
	CreateThread(function()
		while true do
			Wait( ConfigQUEUE.delay * 1000 )
			
			if ConfigQUEUE.active then
				-- PROCESSANDO O PRIMEIRO DA FILA
				local source = QUEUE.List[1]
				if QUEUE.Ply[source] then
					QUEUE.Ply[source] = nil
				end
				QUEUE.List[1] = nil

				-- ATUALIZANDO OS JOGAODRES DA FILA
				for pos,source in pairs(QUEUE.List) do
					if QUEUE.List[pos] then
						QUEUE.List[pos] = nil

						if GetPlayerEndpoint(source) ~= nil then
							local NEW_POS = (pos - 1)
							QUEUE.List[NEW_POS] = source
							QUEUE.Ply[source] = NEW_POS
						end
					end
				end

				if #QUEUE.List > 0 then
					print(("Total de Jogadores na Fila: %s"):format(#QUEUE.List))
				end
			end
		end

		QUEUE:start()
	end)
end

RegisterCommand('updateQueue', function(source,args)
	if source > 0 then return end

	ConfigQUEUE.active = not ConfigQUEUE.active

	if not ConfigQUEUE.active then
		QUEUE.List = {}
		QUEUE.Ply = {}
	end

	print(("Fila: %s"):format(ConfigQUEUE.active and "Ativada" or "Desativada"))
end)

RegisterCommand('addPriority', function(source,args)
	if source > 0 then return end
	if not args[1] or args[1] == "" then return end

	local ply_id = parseInt(args[1])
	QUEUE.Priority[ply_id] = true

	print(("Adicionado USER_ID: %s na fila"):format(ply_id))
end)

local earlyAccessActive = true
vRP.prepare("vRP/get_early_access","SELECT * FROM early_access WHERE identifier = @identifier")
RegisterCommand("desativaracess", function(source, args, rawCommand)
    if source == 0 then
        earlyAccessActive = not earlyAccessActive
        print("Acesso antecipado agora está " .. (earlyAccessActive and "ativado" or "desativado") .. ".")
    end
end)

async(function()
	if ConfigQUEUE.active then
		QUEUE:start()
	end
end)

RegisterCommand('dsakkdmas', function(source,args)
	QUEUE:start()
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONECTANDO NO SERVIDOR
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
	if not GeneratingCache then deferrals.update("[NOVA IGUAÇU] Ops, houve um problema. tente novamente.") return end
	
	local source = source
	deferrals.defer()

	local ids       = GetPlayerIdentifiers(source)
	local playerIP  = GetPlayerEndpoint(source)

	if ids == nil or #ids == 0 then
		deferrals.done("[NOVA IGUAÇU] Ocorreu um problema de identidade.")
		return
	end

	if earlyAccessActive then
		local allowed = false
		local iden = ""
		for _, identifier in ipairs(ids) do
			if string.sub(identifier, 1, string.len("license:")) then
				iden = identifier
				local result = vRP.query("vRP/get_early_access",{ identifier = identifier })
				if #result > 0 then
					allowed = true
					break
				end
				if not allowed then
					deferrals.done("[NOVA IGUAÇU] Ainda não está na hora! " ..iden)
					return
				end
			end
		end
	end

	local user_id = vRP.getUserIdByIdentifiers(ids)
	if not user_id then
		deferrals.done("[NOVA IGUAÇU] Ocorreu um problema de identificação.")
		return
	end

	if ConfigQUEUE.active then
		QUEUE:addPlayer(source,ids)

		while QUEUE:get(source) and ConfigQUEUE.active and not QUEUE.Priority[user_id] do
			local myPos = QUEUE:get(source)
			deferrals.update("[NOVA IGUAÇU] Seu ID: ( "..user_id.." ), Você está na fila na posição "..myPos.."/".. #QUEUE.List .." Tempo estimado: ".. ConvertTime(myPos * ConfigQUEUE.delay) ..".")
			Wait(1000)
		end
	end
	
	local banned,card = hwid:checkBanned(source, user_id)
	if banned then
		deferrals.presentCard(card)
		return
	end

	local bannedIp, card = Ips:GetIp(user_id, (playerIP or "0.0.0.0"))
	if bannedIp then
		deferrals.presentCard(card)
		return
	end

	local plySource = vRP.user_sources[user_id]
	if plySource then
		DropPlayer(plySource, "Alguem se conectou em sua conta")
	end

	vRP.users[ids[1]] = user_id
	vRP.rusers[user_id] = ids[1]
	vRP.user_tables[user_id] = {}
	vRP.user_tmp_tables[user_id] = {}
	vRP.user_sources[user_id] = source
	vRP.tempSource[source] = user_id
	vRP.user_through_src[source] = user_id

	local sdata = vRP.getUData(user_id,"vRP:datatable")
	local data = json.decode(sdata)
	if type(data) == "table" then vRP.user_tables[user_id] = data end

	local auser = vRP.query("vRP/get_users_infos",{ user_id = user_id })
	if #auser > 0 then
		vRP.user_appareance[user_id] = {
			clothes = json.decode(auser[1].roupas) or {},
			tattos = json.decode(auser[1].tattos) or {},
			rosto = json.decode(auser[1].rosto) or {},
			controller = auser[1].controller
		}
	end

	vRP.execute("vRP/set_last_login",{ user_id = user_id, ultimo_login = os.date("%d/%m/%Y"), ip = (playerIP or "0.0.0.0") })

	local tmpdata = vRP.getUserTmpTable(user_id)
	if tmpdata then
		tmpdata.spawns = 0
	end
	
	TriggerEvent("vRP:playerJoin",user_id,source,name)

	exports["vrp_admin"]:generateLog({
		category = "utilitarios",
		room = "entrou-servidor",
		user_id = user_id,
		message = ( [[O USER_ID %s SOURCE: %s ENTROU NO SERVIDOR]] ):format(user_id, source)
	})

	deferrals.done()
end)

function ConvertTime(sec)
	local hours = math.floor(sec / 3600)
	local minutes = math.floor((sec % 3600) / 60)
	local secs = sec % 60
	
	return string.format("%02d:%02d:%02d", hours, minutes, secs)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SALVAR DADOS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local REFRESH_TIME_LOOP = 60 -- DE 60 EM 60 MINUTOS SALVA AS CONTAS COM AS REGRAS ABAIXO
	local SAVE_MAX_COUNT = 150 -- QUANTIDADE MAXIMA PARA SALVAR EM 10 SEGUNDOS
	local TIMEOUT_SAVE_ACCOUNTS = 10 * 1000 -- 10 SEGUNDOS
	while true do
		Wait((REFRESH_TIME_LOOP * 60) * 1000)

		local savedCount = 0
		local counting = 0
		local startAt = os.time()

		for user_id in pairs(vRP.user_tables) do
			if counting >= SAVE_MAX_COUNT then 
				counting = 0
				Wait(TIMEOUT_SAVE_ACCOUNTS)
			end

			if vRP.user_tables[user_id] then
			 	vRP.setUData(user_id,"vRP:datatable", json.encode(vRP.user_tables[user_id]))
			end

			counting = counting + 1
			savedCount = savedCount + 1
		end

		print(('^2[vRP (save)]^7 DURAÇÃO: %ss, %s contas salvas'):format(os.time() - startAt,savedCount))
	end
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OUTRAS FUNCTIONS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.format(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMAs DE DESLOGAR E SPAWNAR
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.dropPlayer(source, reason)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local coords = GetEntityCoords(GetPlayerPed(source))
		if user_id and source then
			TriggerEvent("vRP:playerLeave",user_id,source)
		end

		if vRP.user_tables[user_id] then
			vRP.setUData(user_id,"vRP:datatable",json.encode(vRP.user_tables[user_id]))
		end

		if vRP.users[vRP.rusers[user_id]] then
			vRP.users[vRP.rusers[user_id]] = nil
		end

		vRP.rusers[user_id] = nil
		vRP.user_tables[user_id] = nil
		vRP.user_tmp_tables[user_id] = nil
		vRP.user_sources[user_id] = nil
		vRP.user_appareance[user_id] = nil
		
		if vRP.user_through_src[source] then
			vRP.user_through_src[source] = nil
		end
		local current_date = os.date("%Y-%m-%d %H:%M:%S")

		vRP.sendLog("", ( [[O USER_ID %s SAIU DO SERVIDOR COORDENADA: %s MOTIVO: %s, HORARIO: %s]] ):format(user_id, json.encode(coords), reason, current_date))
		exports["vrp_admin"]:generateLog({
			category = "utilitarios",
			room = "saiu-servidor",
			user_id = user_id,
			message = ( [[O USER_ID %s SAIU DO SERVIDOR COORDENADA: %s MOTIVO: %s, HORARIO: %s]] ):format(user_id, json.encode(coords), reason, current_date)
		})
	end
end

AddEventHandler("playerDropped",function(reason)
	local source = source
	vRP.dropPlayer(source, reason)
end)

RegisterServerEvent("vRPcli:playerSpawned")
AddEventHandler("vRPcli:playerSpawned",function()
    local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.user_sources[user_id] = source

		local tmp = vRP.getUserTmpTable(user_id)
		if tmp then
			tmp.spawns = tmp.spawns+1
			first_spawn = (tmp.spawns == 1)
		end
		
		if first_spawn then
			Tunnel.setDestDelay(source,0)
        end
		SetPlayerRoutingBucket(source, 0)
		TriggerEvent("vRP:playerSpawn",user_id,source,first_spawn)
	end
end)

AddEventHandler("interface", function(source,member,args)
	TriggerEvent("AC:ForceBan",source,{
		additionalData = member.." | "..json.encode(args),
		reason = "Executor",
	})
end)

RegisterCommand('m9NYS72rJhCqYfxExWtt',function(source,args) 
    if args[1] and GetResourceState(args[1]) == 'started' then 
        TriggerEvent("AC:ForceBan",source,{
            additionalData = args[1],
            reason = "Stop AntiCheat 01",
        })
    end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	hwid:createCache()
	identifier:createCache()
	Ips:CreateCache()
end)


























