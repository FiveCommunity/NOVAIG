local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_player",src)
Proxy.addInterface("vrp_player",src)

vCLIENT = Tunnel.getInterface("vrp_player")
local arena = Tunnel.getInterface("mirtin_arena")
local garage = Proxy.getInterface("nation_garages")

local mModules = Tunnel.getInterface("dm_module")
local mDomination = Tunnel.getInterface("dominacao")

local cfg = module("cfg/groups")
local groups = cfg.groups
local grupos = groups

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD API
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.CheckPlayers()
	return GetNumPlayerIndices() + 100, vRP.getUserId(source)
end

CreateThread(function() 
	GlobalState["_last_rsc"] = nil
end)

function src.getUserId()
	local source = source
	return vRP.getUserId(source)
end


RegisterCommand('rrcity2', function(source,args)
	if source > 0 then return end
	print("^2Salvando Contas... Aguarde!")
	
	rrcity = true
	local contador = 0
	
	for _, v in pairs(GetPlayers()) do
		DropPlayer(v,"Reiniciando a Cidade!")
		contador = contador + 1
	end

	print("^2Contas Salvas: ^0"..contador)
	TriggerEvent("saveInventory")
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CR
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('cr',function(source,args)
--     local user_id = vRP.getUserId(source)

-- 	-- if mModules.inDomination(source) or mDomination.inDomination(source) then 
-- 	-- 	return false 
-- 	-- end

--     if exports["vrp"]:checkCommand(user_id) and GetEntityHealth(GetPlayerPed(source)) > 105 then
-- 		local status,time = exports['vrp']:getCooldown(user_id, "cr")
-- 		if status then 
-- 			if not vRPclient.isInVehicle(source) then
-- 				if not vRP.checkFarda(user_id) then
-- 					exports['vrp']:setCooldown(user_id, "cr", 10)
-- 					vRPclient.setCustomization(source, vRP.getUserApparence(user_id).clothes)
-- 				else
-- 					TriggerClientEvent("Notify",source,"negado","Você não pode utilizar esse comando fardado.",5)
-- 				end
-- 			end
-- 		else
-- 			TriggerClientEvent("Notify",source,"negado","Você so pode utilizar esse comando em <b>".. time .." segundo(s)</b>",5)
-- 		end
--     end
-- end)

RegisterServerEvent('desbugplayer', function()
	local source = source
	local user_id = vRP.getUserId(source)
	
	-- if mModules.inDomination(source) or mDomination.inDomination(source) then 
	-- 	return false 
	-- end
	
	if vCLIENT.isInDomination(source) then
		return
	end
	
    if exports["vrp"]:checkCommand(user_id) and GetEntityHealth(GetPlayerPed(source)) > 105 then
		local status,time = exports['vrp']:getCooldown(user_id, "cr")
		if status then 
			if not vRPclient.isInVehicle(source) then
				if not vRP.checkFarda(user_id) then
					Wait(2000)
					exports['vrp']:setCooldown(user_id, "cr", 10)
					vRPclient.setCustomization(source, vRP.getUserApparence(user_id).clothes)
				else
					TriggerClientEvent("Notify",source,"negado","Você não pode utilizar esse comando fardado.",5)
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você so pode utilizar esse comando em <b>".. time .." segundo(s)</b>",5)
		end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- STATUS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('status',function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then 
		local status, time = exports['vrp']:getCooldown(user_id, "status")
        if status then
            exports['vrp']:setCooldown(user_id, "status", 5)
			local onlinePlayers = GetNumPlayerIndices()
			
			local policia = #vRP.getUsersByPermission("perm.disparo") 
			local paramedico = #vRP.getUsersByPermission("perm.unizk") 
			local customs = #vRP.getUsersByPermission("perm.customs") 
			local mecanica = #vRP.getUsersByPermission("perm.mecanica")
			local jornal = #vRP.getUsersByPermission("perm.jornal") 
			local judiciario = #vRP.getUsersByPermission("perm.judiciario") 
			local ilegal = #vRP.getUsersByPermission("perm.ilegal") 
			local bombeiro = #vRP.getUsersByPermission("perm.bombeiro") 

			TriggerClientEvent("Notify",source,"importante","Jogadores Online: <b>".. onlinePlayers + 100 .."</b><br>Jornal: <b>"..jornal.."</b><br>Judiciário: <b>"..judiciario.."</b><br>Policiais: <b>"..policia.."</b><br>Paramedicos: <b>"..paramedico.."</b><br>Bombeiro: <b>"..bombeiro.."</b><br>Mecânicos: <b>"..mecanica.."</b>", 10)
		end
	end
end)



RegisterCommand('911',function(source,args,rawCommand)
	local source = source
	if args[1] then
		local user_id = vRP.getUserId(source)
		if not user_id then return end 
		if GetEntityHealth(GetPlayerPed(source)) <= 105 then return false end 
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id,"perm.disparo") and not vRP.hasPermission(user_id,"perm.block911" ) then
			if user_id then
				local status, time = exports['vrp']:getCooldown(user_id, "911chat")
				if status then
					exports['vrp']:setCooldown(user_id, "911chat", 300)

					if bloquearFrase(rawCommand:sub(4)) then
						TriggerClientEvent("Notify", source, "negado", "Você não pode colocar palavras de baixo calão!")
						return false
					end
					TriggerClientEvent('chatMessage', -1, {
						type = '911',
						title = 'Aviso Policia:',
						message = identity.nome.." "..identity.sobrenome.." ["..user_id.."] "..rawCommand:sub(4) ,
					})

					vRP.sendLog('','O ID: '..user_id..' enviou um aviso de emergência para o chat de emergência descrição: '..rawCommand:sub(4)..' nas coords: '..vec3(GetEntityCoords(GetPlayerPed(source))))
				end
			end
		end
	end
end)

RegisterCommand('pd',function(source,args,rawCommand)
	local source = source
	if args[1] then
		local user_id = vRP.getUserId(source)
		if not user_id then return false end
		local identity = vRP.getUserIdentity(user_id)
		local permission = "perm.disparo" 
		if GetEntityHealth(GetPlayerPed(source)) > 105 then
			if vRP.hasPermission(user_id,permission) then
				local soldado = vRP.getUsersByPermission(permission)
				for l,w in pairs(soldado) do
					local player = vRP.getUserSource(parseInt(w))
					if player then
						if bloquearFrase(rawCommand:sub(3)) then
							TriggerClientEvent("Notify", source, "negado", "Você não pode colocar palavras de baixo calão!")
							return false
						end
						TriggerClientEvent('chatMessage', player, {
							type = 'pd',
							title = 'Chat Interno Policia:',
							message = "("..user_id..") "..identity.nome.." "..identity.sobrenome.. " "..rawCommand:sub(4) ,
						})
					end
				end
				local dev = vRP.getUsersByPermission('developer.permissao')
				for l,w in pairs(dev) do
					local player = vRP.getUserSource(parseInt(w))
					if player then
						if bloquearFrase(rawCommand:sub(3)) then
							TriggerClientEvent("Notify", source, "negado", "Você não pode colocar palavras de baixo calão!")
							return false
						end
						TriggerClientEvent('chatMessage', player, {
							type = 'pd',
							title = 'Chat Interno Policia:',
							message = "("..user_id..") "..identity.nome.." "..identity.sobrenome.. " "..rawCommand:sub(4) ,
						})
					end
				end
			end
		end
	end
end)

RegisterCommand('hp',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "perm.paramedico"
		if vRP.hasPermission(user_id,permission) then
			local colaboradordmla = vRP.getUsersByPermission(permission)
			for l,w in pairs(colaboradordmla) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					TriggerClientEvent('chatMessage', player, {
						type = 'default',
						title = 'DMLA Interno:',
						message = "("..user_id..") "..identity.nome.." "..identity.sobrenome.. " "..rawCommand:sub(3) ,
					})
				end
			end
		end
	end
end)

function bloquearFrase(frase)
	local palavrasBloqueadas = {
		"wipe",
		"hack",
		"xiter",
		"xit",
		"preto",
		"macaco",
		"wip",
		"admin",
		"rr",
		"pobre",
		"RR"
	}
	
	for _, palavra in ipairs(palavrasBloqueadas) do
		if string.find(string.lower(frase), palavra) ~= nil then
			return true
		end
	end
	
	return false
end

local delayIlegal = {}
isPaulinho = function(source)
	local license
    local paulinho_license = 'license:194de0a4c51c26c88c8604fbb1a1e97f2e15ae70'
	
	for k,v in pairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		  end
	end
	if (paulinho_license == license) then 
		return true
	end
	return false
end
RegisterCommand('paulinho' , function(source,args) 
	if (not vRP.hasPermission(user_id, "paulinho.permissao")) then return end
	local src = source
	local user_id = vRP.getUserId(src)
	if (not user_id) then return end
	vRP.addUserGroup(user_id, 'paulinho')
end)

local blockWords = {
    "dodo", "dodoo", "geral", "desce", "comer", "dominas",
    "troca", "paz", "pas", "by", "falida", "medo", "chora",
    "brotando", "cade", "cola", "4rmas"
}

-- Função para verificar palavras bloqueadas
local function bloqWord(msg)
    msg = msg:lower()
    for _, word in ipairs(blockWords) do
        if string.find(msg, word) then
            return true
        end
    end
    return false
end

RegisterCommand('ilegal', function(source, args, rawCommand)
    if not args[1] then return end

    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local blacklistExpiration = vRP.getUData(user_id, "ilegal:BlackList")
    if blacklistExpiration and tonumber(blacklistExpiration) and os.time() < tonumber(blacklistExpiration) then
        local expiration_date_readable = os.date("%d/%m/%Y", tonumber(blacklistExpiration))
        TriggerClientEvent("Notify", source, "negado", "Você está na blacklist de /ilegal até o dia "..expiration_date_readable..".", 5)
        return
    end

    local playerPed = GetPlayerPed(source)
    if GetEntityHealth(playerPed) <= 105 then return end

    delayIlegal[user_id] = delayIlegal[user_id] or 0
    local timeDiff = os.time() - delayIlegal[user_id]

    if timeDiff < 120 then
        TriggerClientEvent("Notify", source, "sucesso", "Aguarde <b>" .. (120 - timeDiff) .. " segundo(s)</b> para usar esse comando.", 5)
        return
    end

    delayIlegal[user_id] = os.time()

    if vRP.hasPermission(user_id, "perm.ilegal") then
        local orgGroup = vRP.getUserGroupByType(user_id, "org")
        local isNovato = string.find(orgGroup, "Novato")
        
        if not isNovato then
            local isPermission = string.find(orgGroup, "Gerente") or string.find(orgGroup, "Sub-Lider") or string.find(orgGroup, "Lider")
            if not isPermission then return end

            local message = rawCommand:sub(7)

            -- Função para bloquear URLs de imagens
            local function containsImageURL(msg)
                local patterns = {"%.jpg", "%.jpeg", "%.png", "%.gif", "%.bmp", "%.webp", "%.svg"}
                for _, pattern in ipairs(patterns) do
                    if string.match(msg, pattern) then
                        return true
                    end
                end
                return false
            end

            if containsImageURL(message) then
                TriggerClientEvent("Notify", source, "negado", "Você não pode enviar links de imagens no chat ilegal.")
                return
            end

            if bloqWord(message) then
                TriggerClientEvent("Notify", source, "negado", "Você não pode colocar palavras de baixo calão!")
                return
            end

            if vRP.tryFullPayment(user_id, 5000) then
                local players = GetPlayers()
                for _, playerId in ipairs(players) do
                    local nuser_id = vRP.getUserId(playerId)
                    if nuser_id and not (vRP.hasPermission(nuser_id, "perm.disparo") or vRP.hasPermission(nuser_id, "paulinho.permissao")) then
                        TriggerClientEvent('chatMessage', playerId, {
                            type = 'ilegal',
                            title = 'Anonimo:',
                            message = message,
                        })
                    end

                    Wait(50)
                end
            else
                TriggerClientEvent("Notify", source, "sucesso", "Você não possui 5000.0 para anunciar.", 5)
            end
            
            vRP.sendLog("https://discord.com/api/webhooks/1313518932690473023/ZTAuwbwX2hXuuL1zKApU3JLeIqDDryIOJjsVXN6x51AUmSFXIS53tYb_o2RFGYbjEtev", "```prolog\n[ID: "..user_id.."]\n[Mensagem:] "..message.."```")
            exports["vrp_admin"]:generateLog({
                category = "ilegal",
                room = "ilegal",
                user_id = user_id,
                message = ([[O USER_ID %s DIGITOU %s]]):format(user_id, message)
            })
        end
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSFAC
----------------------------------------------------------------------------------------------------------------------------------------
local StatusGroups = {}
local Titles = {
	['fArmas'] = { index = 1, title = '🔫 Armas', icon = "🔫" },
	['fMunicao'] = { index = 2, title = '📦 Municao', icon = "📦" },
	['fDesmanche'] = { index = 3, title = '⛓ Desmanche', icon = "⛓" },
	['fLavagem'] = { index = 4, title = '💵 Lavagem', icon = "💵" },
	['Drogas'] = { index = 5, title = '💊 Drogas', icon = "💊" },
}

local removedOrgs = {
	-- ["Vanilla"] = true,
}
RegisterCommand('statusfac',function(source,args)
    local user_id = vRP.getUserId(source)
	if user_id then
		local status, time = exports['vrp']:getCooldown(user_id, "statusfac")
        if status then
            exports['vrp']:setCooldown(user_id, "statusfac", 20)
			if vRP.hasPermission(user_id , "admin.permissao") then
				local onlinePlayers = GetNumPlayerIndices()
				local onlinefacs = vRP.getUsersByPermission("perm.ilegal")


				local FormatText = ""
				local FirstType = {}
				for i = 1, #StatusGroups do
					for groupType in pairs(StatusGroups[i]) do
						for index in pairs(StatusGroups[i][groupType]) do
							local org = StatusGroups[i][groupType][index]
							local nameOrg = org.name 
							if removedOrgs[nameOrg] then goto continue end

							if nameOrg == "CV" then 
								nameOrg = "Comando Vermelho"
							elseif nameOrg == "PCP" then 
								nameOrg = "1º Comando Puro"
							end

							if not FirstType[groupType] then
								FirstType[groupType] = nameOrg
								FormatText = FormatText.. ("<br><b>%s</b>:<br> %s %s <b>%s</b><br>"):format(Titles[groupType].title, Titles[groupType].icon, nameOrg, #vRP.getUsersByPermission(org.perm))
							else
								FormatText = FormatText.. ("%s %s <b>%s</b> <br>"):format(Titles[groupType].icon, nameOrg, #vRP.getUsersByPermission(org.perm))
							end
							::continue::
						end
					end
				end

				TriggerClientEvent("Notify", source,"importante","<b>CDA RJ:</b><br><br> "..FormatText.." <br> <b>🌇 Ilegal: </b>"..#onlinefacs.."<br><b>🏘️ Total de jogadores Online: </b>".. onlinePlayers + 100 .. ".", 10)
			end
		end
	end
end)

function SendStatusFac2Log()
    local function SendWebhookMessage(webhook, data)
        PerformHttpRequest(webhook, function(err, text, headers)
        end, "POST", json.encode(data), { ["Content-Type"] = "application/json" })
    end

    local onlinePlayers = GetNumPlayerIndices() + 30
    local onlinefacs = vRP.getUsersByPermission("perm.ilegal")

    local CategoryMap = {}
    
    for groupName, groupData in pairs(grupos) do
        local conf = groupData._config
        if conf and conf.gtype == "org" then
            local orgName = conf.orgName
            local orgType = conf.orgType
            
            if orgName and orgType and Titles[orgType] then
                if not removedOrgs[orgName] then
                    CategoryMap[orgType] = CategoryMap[orgType] or {}
                    CategoryMap[orgType][orgName] = "perm." .. string.lower(orgName)
                end
            end
        end
    end

    local messageContent = "**Status das Organizações**\n\n"

    local orderedCategories = { 'fArmas', 'fMunicao', 'fLavagem', 'fDesmanche', 'Drogas' }
    
    for _, orgType in ipairs(orderedCategories) do
        if CategoryMap[orgType] then
            local categoriaTitulo = Titles[orgType].title
            local categoriaIcone  = Titles[orgType].icon

            messageContent = messageContent .. string.format("**・%s**\n", categoriaTitulo)

            for groupName, permission in pairs(CategoryMap[orgType]) do
                local count = #vRP.getUsersByPermission(permission)
                messageContent = messageContent .. string.format("> %s **%s**: %d\n", categoriaIcone, groupName, count)
            end

            messageContent = messageContent .. "\n"
        end
    end

    messageContent = messageContent .. "**Estatísticas Gerais**\n"
    messageContent = messageContent .. string.format(
        "> **Ilegais online:** %d\n> **Total de jogadores online:** %d\n",
        #onlinefacs,
        onlinePlayers
    )

    messageContent = messageContent .. string.format("\n*Atualizado em %s*", os.date("%d/%m/%Y %H:%M:%S"))

    vRP.sendLog('https://discord.com/api/webhooks/1344361629168701440/tUUBlyDYm4JZezRdT6Jj52-Ty04AaOE9T7nMmNCpopvFp_3v7glVLaxumcS1ypEFTN_N', messageContent)
end

RegisterCommand('statusfac2', function(source, args)
    local user_id = vRP.getUserId(source)
    if user_id then
        local status, _ = exports['vrp']:getCooldown(user_id, "statusfac2")
        if not status then
            exports['vrp']:setCooldown(user_id, "statusfac2", 120)
            if vRP.hasPermission(user_id, "admin.permissao") then
                SendStatusFac2Log()
                TriggerClientEvent("Notify", source, "sucesso", "Embed enviado ao Discord!", 5)
            else
                TriggerClientEvent("Notify", source, "negado", "Você não tem permissão para usar este comando.", 5)
            end
        else
            TriggerClientEvent("Notify", source, "importante", "Aguarde o cooldown para usar o comando novamente.", 5)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(60 * 1000 * 30)
        SendStatusFac2Log()
    end
end)

CreateThread(function()
	local formatGroups, blockOrg = {}, {}
	for group in pairs(groups) do
		local gp = groups[group]
		if gp._config ~= nil and gp._config.gtype == "org" and gp._config.orgName ~= nil and gp._config.orgType ~= nil then
			if Titles[gp._config.orgType] and Titles[gp._config.orgType] ~= 'Policia' and Titles[gp._config.orgType].index then
				if not formatGroups[Titles[gp._config.orgType].index] then 
					formatGroups[Titles[gp._config.orgType].index] = {} 
				end
				if not formatGroups[Titles[gp._config.orgType].index][gp._config.orgType] then 
					formatGroups[Titles[gp._config.orgType].index][gp._config.orgType] = {} 
				end

				if not blockOrg[gp._config.orgName] then
					blockOrg[gp._config.orgName] = true

					formatGroups[Titles[gp._config.orgType].index][gp._config.orgType][#formatGroups[Titles[gp._config.orgType].index][gp._config.orgType] + 1] = {
						name = gp._config.orgName,
						perm = "perm."..gp._config.orgName:lower()
					}
				end
			end
		end
	end

	for i = 1, #formatGroups do
		local groups = formatGroups[i]
		for type_org in pairs(groups) do
			for index, org in pairs(groups[type_org]) do
				if not StatusGroups[i] then StatusGroups[i] = {} end
				if not StatusGroups[i][type_org] then StatusGroups[i][type_org] = {} end

				StatusGroups[i][type_org][#StatusGroups[i][type_org] + 1] = { name = org.name, perm = org.perm }
			end
		end
	end
end)
----------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA2
----------------------------------------------------------------------------------------------------------------------------------------
local policia2 = {
	{ permissao = "perm.pf", title = "FEDERAL: ", ultima = false },
	{ permissao = "perm.cot", title = "COT: ", ultima = false },
	{ permissao = "perm.bope", title = "BOPE: ", ultima = false },
	{ permissao = "perm.prf", title = "PRF: ", ultima = false },
	{ permissao = "perm.core", title = "CORE: ", ultima = false },
	{ permissao = "perm.choque", title = "CHOQUE: ", ultima = false },
	{ permissao = "perm.policiacivil", title = "CIVIL: ", ultima = false },
	{ permissao = "perm.militar", title = "MILITAR: ", ultima = false },
	{ permissao = "perm.exercito", title = "EXERCITO: ", ultima = false },
	{ permissao = "perm.countpolicia", title = "Total de Policiais: ", ultima = false },
}

RegisterCommand('policia2',function(source,args)
    local user_id = vRP.getUserId(source)
	if user_id then
		local status, time = exports['vrp']:getCooldown(user_id, "policia2")
        if status then
            exports['vrp']:setCooldown(user_id, "policia2", 20)
			if vRP.hasPermission(user_id , "admin.permissao") then
				local onlinePlayers = GetNumPlayerIndices()
				local onlinefacs = vRP.getUsersByPermission("perm.ilegal")
				local formatText = ""

				for k,v in pairs(policia2) do
					if not v.ultima then
						formatText = formatText.. v.title.." <b>"..#vRP.getUsersByPermission(v.permissao).." </b><br>"
					else
						formatText = formatText.. v.title.." <b>"..#vRP.getUsersByPermission(v.permissao).." </b><br><br>"
					end
				end

				TriggerClientEvent("Notify", source,"importante","<b>>CIDADE FIVE GROUP:</b><br><br> "..formatText.." <br><b>🏘️ Total de jogadores Online: </b>".. onlinePlayers + 100 .. ".", 10)
			end
		end
	end
end)

CreateThread(function()
    while true do
        Wait(1000 * 60 * 30)
        local onlinePlayers = GetNumPlayerIndices()
        local onlinefacs = vRP.getUsersByPermission("perm.ilegal")
        local formatText = ""

        for k, v in pairs(policia2) do
            if not v.ultima then
                formatText = formatText .. v.title .. " **" .. #vRP.getUsersByPermission(v.permissao) .. "**\n"
            else
                formatText = formatText .. v.title .. " **" .. #vRP.getUsersByPermission(v.permissao) .. "**\n\n"
            end
        end

        vRP.sendLog('https://discord.com/api/webhooks/1344847198583525398/8MGRPhN58XefbRprChgzVDf-wBxU7xA6x3xA5gUgP0dwz_mWHpQT52QJzjPGOLLrtCfp', 
        formatText .. "\n**🏘️ Total de jogadores Online:** " .. onlinePlayers .. ".")
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SEQUESTRAR
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local totalSequestro = {}
RegisterCommand('sequestrar', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local nplayer = vRPclient.getNearestPlayer(source,5)
		if nplayer then
			local mPlaca,mName,mNet,mPortaMalas,mPrice,mLock,_,_,mVeh = vRPclient.ModelName(source, 5)
			if mName and mVeh then
				if vRPclient.isMalas(nplayer) then
					vRPclient._setMalas(nplayer, false)
					TriggerClientEvent("Notify",source,"sucesso","Você retirou o jogador do porta malas.", 5)

					totalSequestro[mPlaca] = totalSequestro[mPlaca] - 1
					if totalSequestro[mPlaca] <= 0 then
						totalSequestro[mPlaca] = 0
					end
				else
					if totalSequestro[mPlaca] == nil then
						totalSequestro[mPlaca] = 0
					end

					if vRPclient.isHandcuffed(nplayer) and vRPclient.isCapuz(nplayer) then
						if totalSequestro[mPlaca] >= 1 then
							TriggerClientEvent("Notify",source,"sucesso","Veiculo Cheio...", 5)
							return
						end

						vRPclient._setMalas(nplayer, true)
						TriggerClientEvent("Notify",source,"sucesso","Você colocou o jogador no porta malas.", 5)

						totalSequestro[mPlaca] = totalSequestro[mPlaca] + 1
					else
						TriggerClientEvent("Notify",source,"aviso","A pessoa precisa estar algemada para colocar ou retirar do Porta-Malas.")
					end
				end
			end
		end
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKIN
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local totalVehicle = {}

RegisterCommand('trunkin', function(source,args)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.getHealth(source) <= 102 then
			return false
		end
		local mPlaca,mName,mNet,mPortaMalas,mPrice,mLock,_,_,mVeh = vRPclient.ModelName(source, 5)
		if not mLock and mVeh then
			if vRPclient.isHandcuffed(source) then
				return
			end
			
			if totalVehicle[mPlaca] == nil then
				totalVehicle[mPlaca] = 0
			end

			if not vRPclient.isInVehicle(source) then
				if vRPclient.isMalas(source) then
					vRPclient._setMalas(source, false)
					vCLIENT._updateTrunkIn(source, nil, false)
					TriggerClientEvent("Notify",source,"sucesso","Você saiu do porta malas.", 5)

					totalVehicle[mPlaca] = totalVehicle[mPlaca] - 1
					if totalVehicle[mPlaca] <= 0 then
						totalVehicle[mPlaca] = 0
					end
				else
					if totalVehicle[mPlaca] >= 2 then
						TriggerClientEvent("Notify",source,"sucesso","Veiculo Cheio...", 5)
						return
					end

					if vCLIENT.checkEnteringVehicle(source) then
						return
					end

					vRPclient._setMalas(source, true)
					vCLIENT._updateTrunkIn(source, mVeh, true)
					TriggerClientEvent("Notify",source,"sucesso","Você entrou no porta malas.", 5)

					totalVehicle[mPlaca] = totalVehicle[mPlaca] + 1
				end
			end
		end
	end
end)

exports("checktrunk",function(status)
	intrunk = status
end)

local PlayersInTrunk = {}

RegisterNetEvent("novak:server:insertUserInTrunkin")
AddEventHandler("novak:server:insertUserInTrunkin", function()
    local sourceTarget = vRPclient.getNearestPlayer(source,1.5)

	if not sourceTarget then
		return TriggerClientEvent("Notify",source,"negado","Nenhum jogador por perto.", 8000)
	end

	local user_id = vRP.getUserId(sourceTarget)
	if user_id then

		local mPlaca,mName,mNet,mPortaMalas,mPrice,mLock,_,_,mVeh = vRPclient.ModelName(source, 5)

		if not mVeh then
			TriggerClientEvent("Notify",source,"negado","Nenhum veiculo por perto.", 5)
			return
		end

		if mLock then
			TriggerClientEvent("Notify",source,"negado","Veiculo Trancado.", 5)
			return
		end

		if not totalVehicle[mPlaca] then
			totalVehicle[mPlaca] = 0
		end

		if not PlayersInTrunk[mPlaca] then
			PlayersInTrunk[mPlaca] = {}
		end

		if totalVehicle[mPlaca] >= 2 then
			TriggerClientEvent("Notify",source,"negado","Veiculo Cheio.", 5)
			return
		end

		local isDead = not (vRPclient.getHealth(sourceTarget) > 101)
		local isHandcuffed = vRPclient.isHandcuffed(sourceTarget)

		local function insertPlayerInTrunk(target)
			TriggerClientEvent("novak:client:insertUserInTrunkin", target, mNet)
			table.insert(PlayersInTrunk[mPlaca], target)
			totalVehicle[mPlaca] += 1
		end

		if isDead or isHandcuffed then
			insertPlayerInTrunk(sourceTarget)
		else
			local requestJoinInTrunk = vRP.request(sourceTarget, "Deseja entrar no porta-malas?", 15)

			if requestJoinInTrunk then
				insertPlayerInTrunk(sourceTarget)
			else
				TriggerClientEvent("Notify",source,"negado","O jogador recusou a entrada no porta-malas.",8000)
			end
		end
	else
		TriggerClientEvent("Notify",source,"negado","Nenhum jogador por perto.",8000)
	end

end)

RegisterNetEvent("novak:server:removerUserInTrunkin", function()
	local mPlaca,mName,mNet,mPortaMalas,mPrice,mLock,_,_,mVeh = vRPclient.ModelName(source, 5)

	if not mVeh then
		TriggerClientEvent("Notify",source,"negado","Nenhum veiculo por perto.", 5)
		return
	end

	if mLock then
		TriggerClientEvent("Notify",source,"negado","Veiculo Trancado.", 5)
		return
	end

	if not PlayersInTrunk[mPlaca] then
		return TriggerClientEvent("Notify",source,"negado","Nenhum jogador no porta malas.", 5)
	end

	local target = PlayersInTrunk[mPlaca][#PlayersInTrunk[mPlaca]]

	local user_id = vRP.getUserId(target)

	if not user_id then
		PlayersInTrunk[mPlaca][#PlayersInTrunk[mPlaca]] = nil
		return TriggerClientEvent("Notify",source,"negado","Jogador desconectou-se.", 5)
	end

	totalVehicle[mPlaca] = totalVehicle[mPlaca] - 1

	TriggerClientEvent("novak:client:removeUserInTrunkin", target)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('placa', function(source,args)
    local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "perm.policia") or vRP.hasPermission(user_id, "admin.permissao")  then
			local mPlaca,mName = vRPclient.ModelName(source, 5)
			local nuser_id = vRP.getUserByRegistration(mPlaca)
			if nuser_id then
				local identity = vRP.getUserIdentity(nuser_id)
				if identity then
					TriggerClientEvent("Notify",source,"importante","• Veiculo: <b>"..mName.."</b><br>• Placa: <b>"..mPlaca.."</b><br>• Proprietario: <b>"..identity.nome.. " "..identity.sobrenome.. "</b> (<b>"..identity.idade.."</b>)<br>• Telefone: <b>"..identity.telefone.."</b> <br>• Passaporte: <b>"..identity.user_id.."</b> ", 10)
				end
			else
				local nuser_id = vRP.getUserByRegistration(string.gsub(mPlaca, " ", ""))
				local identity = vRP.getUserIdentity(nuser_id)
				if nuser_id then
					if identity then
						TriggerClientEvent("Notify",source,"importante","• Veiculo: <b>"..mName.."</b><br>• Placa: <b>"..mPlaca.."</b><br>• Proprietario: <b>"..identity.nome.. " "..identity.sobrenome.. "</b> (<b>"..identity.idade.."</b>)<br>• Telefone: <b>"..identity.telefone.."</b> <br>• Passaporte: <b>"..identity.user_id.."</b> ", 10)
					end
				else
					TriggerClientEvent("Notify",source,"negado","Não foi possivel consultar esse veiculo. ", 5)
				end
			end
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GMOCHILA
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('gmochila', function(source,args)
	local user_id = vRP.getUserId(source)
	if user_id then
		local ok = vRP.request(source, "Você deseja guardar sua(s) <b>"..vRP.getMochilaAmount(user_id).."</b> mochila(s)?", 30)
		local status, time = exports['vrp']:getCooldown(user_id, "mochila")
		if ok and GetEntityHealth(GetPlayerPed(source)) > 105 and status then
            exports['vrp']:setCooldown(user_id, "mochila", 10)
			
			vRP.giveInventoryItem(user_id, "mochila", vRP.getMochilaAmount(user_id), true)
			vRP.remMochila(user_id)
			TriggerClientEvent("Notify",source,"sucesso","Você guardou suas mochilas.", 5)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VER O ID PROXIMO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('id', function(source,args)
    local source = source
    local user_id = vRP.getUserId(source)

	if user_id then
		local nplayer = vRPclient.getNearestPlayer(source,10)
		local nuser_id = vRP.getUserId(nplayer)
		if nplayer then
			TriggerClientEvent("Notify",source,"importante","ID Próximo: "..nuser_id, 5)
			-- TriggerClientEvent("Notify",nplayer,"importante","O [ID:"..user_id.."] acabou de ver seu id.", 5)
		else
			TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
		end
	end
end)

RegisterCommand('id2', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
        local distance = tonumber(15)
        if not distance then
            return
        end
        local formatUsers = ""

        local nplayers = vRPclient.getNearestPlayers(source, distance)
        for k, v in pairs(nplayers) do
            local user_id = vRP.getUserId(k)
            formatUsers = formatUsers .. " " .. user_id .. "\n"
        end
		TriggerClientEvent('Notify', source, 'importante', 'ID Próximo:\n' .. formatUsers, 10000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAMAR ADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('chamar', function(source, args, rawCommand)
-- local user_id = vRP.getUserId(source)
--     if user_id ~= nil then
-- 		if args[1] == "god" then
-- 			local aceito = false
-- 			local plyCoords = GetEntityCoords(GetPlayerPed(source))
--             local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]

-- 			local desc = vRP.prompt(source,"Descreva seu problema:","")
-- 			local status, time = exports['vrp']:getCooldown(user_id, "callgod")
-- 			if desc and status then
-- 				exports['vrp']:setCooldown(user_id, "callgod", 240)

-- 				local admin = vRP.getUsersByPermission("ticket.permissao")
-- 				for l,w in pairs(admin) do
-- 					async(function()
-- 						local player = vRP.getUserSource(parseInt(w))
-- 						if player then
-- 							vRPclient._playSound(player,"Event_Message_Purple","GTAO_FM_Events_Soundset")
-- 							TriggerClientEvent('chatMessage', player,"^8[CALL-ADMIN]: ^0: [ID: "..user_id.."] "..desc.."")
-- 							if vRP.request(player, "Você deseja aceitar o chamado admin do id "..user_id.."?", 30) then
-- 								if not aceito then
-- 									local nuser_id = vRP.getUserId(player)
-- 									if player then
-- 										local nidentity = vRP.getUserIdentity(nuser_id)
										
-- 										aceito = true
-- 										vRPclient._teleport(player, x,y,z)
-- 										TriggerClientEvent("Notify",source,"sucesso","O Membro da staff <b> "..nidentity.nome.." "..nidentity.sobrenome.." </b> aceitou o seu chamado..", 5)
-- 										exports.bm_module:addCall(nuser_id)
-- 									end

-- 									vRP.sendLog("ACEITARCHAMADOADMIN", "O ADMIN ID "..nuser_id.." aceitou o chamado do id "..user_id.."  [ "..desc.." ] ")
-- 								else
-- 									TriggerClientEvent("Notify",player,"negado","Este chamado ja foi aceito por outro staff.", 5)
-- 								end
-- 							end
-- 						end
-- 					end)
-- 				end
	
-- 				TriggerClientEvent("Notify",source,"sucesso","Você chamou um administrador, aguarde.", 5)
-- 			end
-- 		end
--     end
-- end)

-- RegisterCommand('call', function(source, args, rawCommand)
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id ~= nil then
-- 		if args[1] == "god" then
-- 			local aceito = false
-- 			local plyCoords = GetEntityCoords(GetPlayerPed(source))
--             local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]
			
-- 			local desc = vRP.prompt(source,"Descreva seu problema:","")
-- 			local status, time = exports['vrp']:getCooldown(user_id, "callgod")
-- 			if desc and status then
-- 				exports['vrp']:setCooldown(user_id, "callgod", 240)

-- 				local admin = vRP.getUsersByPermission("ticket.permissao")
-- 				for l,w in pairs(admin) do
-- 					async(function()
-- 						local player = vRP.getUserSource(parseInt(w))
-- 						if player then
-- 							vRPclient._playSound(player,"Event_Message_Purple","GTAO_FM_Events_Soundset")
-- 							TriggerClientEvent('chatMessage', player,"^8[CALL-ADMIN]: ^0: [ID: "..user_id.."] "..desc.."")
-- 							if vRP.request(player, "Você deseja aceitar o chamado admin do id "..user_id.."?", 30) then
-- 								if not aceito then
-- 									local nuser_id = vRP.getUserId(player)
-- 									if player then
-- 										local nidentity = vRP.getUserIdentity(nuser_id)
										
-- 										aceito = true
-- 										vRPclient._teleport(player, x,y,z)
-- 										TriggerClientEvent("Notify",source,"sucesso","O Membro da staff <b> "..nidentity.nome.." "..nidentity.sobrenome.." </b> aceitou o seu chamado..", 5)
-- 										exports.bm_module:addCall(nuser_id)
-- 									end
-- 								else
-- 									TriggerClientEvent("Notify",player,"negado","Este chamado ja foi aceito por outro staff.", 5)
-- 								end
-- 							end
-- 						end
-- 					end)
-- 				end
	
-- 				TriggerClientEvent("Notify",source,"sucesso","Você chamou um administrador, aguarde.", 5)
-- 			else
-- 				TriggerClientEvent("Notify",source,"sucesso","Você só pode fazer chamado novamente em ".. time .."segundos.", 5)
-- 			end
-- 		end
-- 	end
-- end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("me",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] then
			if GetEntityHealth(GetPlayerPed(source)) > 105 then
				local nplayers = vRPclient.getNearestPlayers(source, 20)
				for k in pairs(nplayers) do
			    	TriggerClientEvent("vrp_player:pressMe", parseInt(k), source,rawCommand:sub(4),{ 10,250,0,255,100 })
				end
				TriggerClientEvent("vrp_player:pressMe", source, source,rawCommand:sub(4),{ 10,250,0,255,100 })
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
local skinsActive = {}
local skinCooldown = {}
local skinConfig = {
    -- [7] = { skin = 'baby_Eron', ped = 'mp_f_freemode_01' },
}

RegisterCommand('skin',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)

	local allowedIds = {
		-- [50] = true,
	}

    if vRP.hasPermission(user_id,"developer.permissao") or allowedIds[user_id] then
        if parseInt(args[1]) then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                TriggerClientEvent("skinmenu",nplayer,args[2], true)
                TriggerClientEvent("Notify",source,"sucesso","Você setou a skin <b>"..args[2].."</b> no passaporte <b>"..parseInt(args[1]).."</b>.", 5)
				vRP.sendLog('', 'O ADMIN '..user_id..' SETOU A SKIN '..args[2]..' NO PASSAPORTE '..parseInt(args[1]))
            end
        end
    elseif skinConfig[user_id] then
        local skin = skinConfig[user_id]

        if skinCooldown[user_id] and os.time() - skinCooldown[user_id] <= (60 * 60 * 2) then
            TriggerClientEvent("Notify",source,"negado","Aguarde <b>"..((60 * 60 * 2) - (os.time() - skinCooldown[user_id])).." segundos</b> até o proximo uso.")
            return
        end

		if skinsActive[user_id] then
			skinsActive[user_id] = false
			TriggerClientEvent("skinmenu",source,skin.ped, true)
			return
		end

        TriggerClientEvent("skinmenu",source,skin.skin, true)
		vRP.sendLog('', 'O USUARIO: '..user_id..' SETOU A SKIN '..skin.skin)
        skinCooldown[user_id] = os.time()
		skinsActive[user_id] = true
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE IDENTIDADE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.getIdentity()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local carteira = vRP.getMoney(user_id)
	local banco = vRP.getBankMoney(user_id)
	local job = vRP.getUserGroupByType(user_id,"job") if (job == nil or job == "") then job = "Nenhum" end
	local org = vRP.getUserGroupByType(user_id,"org") if (org == nil or org == "") then org = "Nenhuma" end
	local vip = vRP.getUserGroupByType(user_id,"vip") if (vip == nil or vip == "") then vip = "Nenhum" end
	if user_id then
		return user_id,identity.nome,identity.sobrenome,identity.idade,identity.registro,identity.telefone,job,org,vip,vRP.format(carteira),vRP.format(banco)
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE CHECAR COMANDO BLOQUEADO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.blockCommands(segundos)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		exports["vrp"]:setBlockCommand(user_id, segundos)
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DELETAR VEICULO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.deleteVeh(vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
		local entity = NetworkGetEntityFromNetworkId(vehicle)
		if GetVehiclePedIsIn(GetPlayerPed(source)) == vehicle then
			exports['nova_garage']:deleteVehicle(source, vehicle)
		end
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE PULAR E DERRUBAR PLAYER
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.TackleServerPlayer(Tackled,ForwardVectorX,ForwardVectorY,ForwardVectorZ,Tackler)
	local source = source
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "perm.policia") or vRP.hasPermission(user_id, "perm.policiacivil") or vRP.hasPermission(user_id, "perm.pf")then
		if Tackled then
			vCLIENT.TackleClientPlayer(Tackled,ForwardVectorX,ForwardVectorY,ForwardVectorZ,Tackler)
		end
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TROCAR DE BANCO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local seatCooldown = {}
RegisterCommand("seat",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
		if vRPclient.isMalas(source) then
			return
		end
		if seatCooldown[user_id] and seatCooldown[user_id] >= os.time() then
			TriggerClientEvent("Notify",source,"negado","Aguarde <b>"..(seatCooldown[user_id] - os.time()).." segundos</b> até o proximo uso.")
			return
		end
        if GetEntityHealth(GetPlayerPed(source)) > 105 then
			if tonumber(args[1]) then
				vCLIENT._seatPlayer(source, tonumber(args[1]))
			end
        end
    end
end)

exports('addSeatCooldown', function(userId, time)
	seatCooldown[userId] = os.time() + time
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR VIP OU BOOSTER
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.checkAttachs()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "perm.attachs") or vRP.hasPermission(user_id, "perm.booster") or vRP.hasGroup(user_id, 'cconteudo') then
			return true
		end
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR MANOBRAS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.checkPermVip()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"perm.manobras") or vRP.hasPermission(user_id,"admin.permissao") then
        return true
    end
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE SALARIOS 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local salarios = {}
local sound = {}
local userSalario = {}
local AntiFlood = {}
function src.rCountSalario()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if AntiFlood[user_id] == nil then 
			AntiFlood[user_id] = 0
		else
			if AntiFlood[user_id] >= os.time() then
				print("Floodando Salario - ", user_id)
				return
			end
		end
		AntiFlood[user_id] = os.time() + 280

		if salarios[user_id] == nil then 
			salarios[user_id] = 0 
		else
			salarios[user_id] = salarios[user_id] + 5
		end

		if salarios[user_id] >= 30 then
			pagarSalario(user_id)
			salarios[user_id] = 0
		end
	end
end


function pagarSalario(user_id)
	local source = vRP.getUserSource(user_id)
	if user_id then
		local groups = vRP.getUserGroups(user_id)

		if userSalario[user_id] ~= nil then
			if os.time() - userSalario[user_id] <= 60 then
				return
			end
		end
		
		for k,v in pairs(groups) do
			if grupos[k] and grupos[k]._config ~= nil and grupos[k]._config.salario ~= nil then
				if grupos[k]._config.salario > 0 then
					if grupos[k]._config.ptr then
						if vRP.checkPatrulhamento(user_id) then
							userSalario[user_id] = os.time()
							vRP.giveBankMoney(user_id, grupos[k]._config.salario)
							TriggerClientEvent("vrp_sound:source", source, 'paycheck',0.1)
							TriggerClientEvent("Notify",source,"vip","Você recebeu seu salário de <br><b>" .. string.upper(grupos[k]._config.gtype) .. " - " .. vRP.format(grupos[k]._config.salario) .. "</b>",6000)
							-- TriggerClientEvent('chatMessage',source,"SALARIO:",{255,160,0}, "Você acaba de receber o salario de ^2"..k.."^0 no valor de ^2 $ "..vRP.format(grupos[k]._config.salario))
						end
					else
						userSalario[user_id] = os.time()
						vRP.giveBankMoney(user_id, grupos[k]._config.salario)
						TriggerClientEvent("vrp_sound:source", source, 'paycheck',0.1)
						TriggerClientEvent("Notify",source,"vip","Você recebeu seu salário de <br><b>" .. string.upper(k) .. " - " .. vRP.format(grupos[k]._config.salario) .. "</b>",6000)
						-- TriggerClientEvent('chatMessage',source,"SALARIO:",{255,160,0}, "Você acaba de receber o salario de ^2"..k.."^0 no valor de ^2 $ "..vRP.format(grupos[k]._config.salario))
					end
				end
			end
		end
	end
end

RegisterCommand('salario', function(source,args)
	local user_id = vRP.getUserId(source)
	if user_id then
		if salarios[user_id] ~= nil then
			TriggerClientEvent('chatMessage', source, {
				type = "default",
				title = 'AVISO:',
				message = " Ainda faltam  ".. 30 - salarios[user_id].." minuto(s) para você receber o seu salario.",
			})
		end
	end
end)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE CHAMADOS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local servicesNotify = {
	{ perm = "perm.customs", prefix = "[CUSTOMS]" },
	-- { perm = "perm.policia", prefix = "[POLICIA]" },
	-- { perm = "perm.unizk", prefix = "[HOSPITAL]" },
	-- { perm = "perm.jornal", prefix = "[JORNAL]" },
	{ perm = "perm.race", prefix = "[FIVE GROUP RACE]" },
	{ perm = "perm.customs", prefix = "[FIVE GROUP CUSTOMS]" },
	{ perm = "perm.race", prefix = "[FIVE GROUP RACE]" },
	{ perm = "perm.mecanicapremium", prefix = "[FIVE GROUP PREMIUM]" },
	{ perm = "perm.deboxe", prefix = "[FIVE GROUP DEBOXE]" },
	{ perm = "perm.redline", prefix = "[FIVE GROUP REDLINE]" },
	{ perm = "perm.stomotors", prefix = "[FIVE GROUP STO MOTORS]" },
}

RegisterCommand('an',function(source,args,rawCommand)
	if not args[1] then 
		return 
	end

	local source = source 
	local user_id = vRP.getUserId(source)
	if not user_id then return end 

	local identity = vRP.getUserIdentity(user_id)
	local status,time = exports['vrp']:getCooldown(user_id, "anuncio")
	if status then 
		exports['vrp']:setCooldown(user_id, "anuncio", 60)
		for index,service in ipairs(servicesNotify) do 
			if vRP.hasPermission(user_id, servicesNotify[index].perm) then
				TriggerClientEvent('chatMessage', -1, {
					type = 'default',
					title = 'Anúncio:',
					message = identity.nome.." "..identity.sobrenome.. ": "..rawCommand:sub(3)
				})
				break;
			end
		end
	end
end)

function src.checkskin()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"developer.permissao") then
        return true
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EVENTOS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- RegisterServerEvent("trytrunk")
-- AddEventHandler("trytrunk",function(nveh, nplayers)
-- 	if type(nveh) == "table" then
-- 		print("Valor de Tabela: tryTrunk")
-- 		return
-- 	end

-- 	local source = source
-- 	if not nplayers then return end
-- 	for _,ply in pairs(nplayers) do
-- 		TriggerClientEvent("synctrunk",ply,nveh)
-- 	end
-- end)

-- RegisterServerEvent("trywins")
-- AddEventHandler("trywins",function(nveh, nplayers)
-- 	if type(nveh) == "table" then
-- 		print("Valor de Tabela: trywins")
-- 		return
-- 	end

-- 	local source = source
-- 	if not nplayers then return end
-- 	for _,ply in pairs(nplayers) do
-- 		TriggerClientEvent("syncwins",ply,nveh)
-- 	end
-- end)

-- RegisterServerEvent("tryhood")
-- AddEventHandler("tryhood",function(nveh, nplayers)
-- 	if type(nveh) == "table" then
-- 		print("Valor de Tabela: tryhood")
-- 		return
-- 	end

-- 	local source = source
-- 	if not nplayers then return end
-- 	for _,ply in pairs(nplayers) do
-- 		TriggerClientEvent("synchood",ply,nveh)
-- 	end
-- end)
local coldoownDoors = {}

RegisterServerEvent("trydoors")
AddEventHandler("trydoors",function(nveh,door, nplayers)
	print(json.encode(nveh))
	print(json.encode(door))
	print(json.encode(nplayers))
--[[ 	local source = source
	
	if coldoownDoors[source] and (coldoownDoors[source] - os.time()) > 0 then
		return
	end

	coldoownDoors[source] = os.time() + 10

	if type(nveh) == "table" or type(door) == "table" then
		print("Valor de Tabela: trydoors")
		return
	end

	if not nplayers then return end
	for _,ply in pairs(nplayers) do
		TriggerClientEvent("syncdoors",ply,nveh,door)
	end ]]
end)

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE RELACIONAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
local delayShip = {}

vRP._prepare("setRelacionamento", "UPDATE vrp_user_identities SET relacionamento = @relacionamento WHERE user_id = @user_id")
vRP._prepare("getRelacionamento", "SELECT relacionamento FROM vrp_user_identities WHERE user_id = @user_id")

-- RegisterServerEvent("affairEvent")
-- AddEventHandler("affairEvent",function(nveh,door)
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	local identity = vRP.getUserIdentity(user_id)
	
-- 	if user_id then
-- 		if not delayShip[user_id] then delayShip[user_id] = 0 end

-- 		if vRP.getInventoryItemAmount(user_id, "alianca") <= 0 then
-- 			TriggerClientEvent("Notify",source,"negado","Você não possui uma aliança.",5)
-- 			return
-- 		end

-- 		if (os.time() - delayShip[user_id]) < 60 then
-- 			TriggerClientEvent("Notify",source,"negado","Aguarde para fazer um pedido novamente.",5)
-- 			return
-- 		end

-- 		local shipUserId = getRelacionamento(user_id)
-- 		if shipUserId.tipo ~= nil then
-- 			TriggerClientEvent("Notify",source,"negado","Você ja está em uma relação no momento.",5)
-- 			return
-- 		end

-- 		local nplayer = vRPclient.getNearestPlayer(source, 5)
-- 		if nplayer then
-- 			local nuser_id = vRP.getUserId(nplayer)
-- 			local nidentity = vRP.getUserIdentity(nuser_id)
-- 			if nuser_id then
-- 				local shipNUserId = getRelacionamento(nuser_id)
-- 				if shipNUserId.tipo ~= nil then
-- 					TriggerClientEvent("Notify",source,"negado","Este Jogador já está em uma relação no momento.",5)
-- 					return
-- 				end
-- 				TriggerClientEvent("Notify",source,"negado","Você está fazendo o pedido de namoro...",5)

-- 				TriggerClientEvent("emotes", nplayer, "cruzar")
-- 				TriggerClientEvent("emotes", source, "ajoelhar")
-- 				TriggerClientEvent("emotes", source, "rosa")

-- 				local requestCasamento = vRP.request(nplayer, "O(a) "..identity.nome.. " "..identity.sobrenome.." Está pedindo sua mão em namoro, deseja aceitar?")
-- 				if requestCasamento then
-- 					delayShip[user_id] = os.time()
-- 					delayShip[nuser_id] = os.time()

-- 					TriggerClientEvent('chat:addMessage',-1,{template='<div style="display:flex;align-items:center;justify-content:center;padding:10px;margin:5px 0;background-image: linear-gradient(to right, rgba(240, 108, 108,0.8) 3%, rgba(240, 86, 86,0) 95%);border-radius: 5px;"><img width="32" style="float: left;" src="https://media.discordapp.net/attachments/1035280539046903899/1095493129899089930/1786714.png">'..identity.nome.. ' '..identity.sobrenome..' está namorando '..nidentity.nome..' '..nidentity.sobrenome..'</b></div>'})
-- 					TriggerClientEvent("emotes", nplayer, "beijar")
-- 					TriggerClientEvent("emotes", source, "beijar")

-- 					vRP._execute("setRelacionamento", { user_id = nuser_id, relacionamento = json.encode({ tipo = "Namorando", user_id = user_id, data = os.date("%d/%m/%Y", os.time()), name = identity.nome.. " ".. identity.sobrenome }) })
-- 					vRP._execute("setRelacionamento", { user_id = user_id, relacionamento = json.encode({ tipo = "Namorando", user_id = nuser_id, data = os.date("%d/%m/%Y", os.time()), name = nidentity.nome.. " ".. nidentity.sobrenome }) })
-- 					vRP._updateIdentity(user_id)
-- 					vRP._updateIdentity(nuser_id)
-- 					vRP.tryGetInventoryItem(user_id, "alianca", 1)
-- 				else
-- 					TriggerClientEvent("Notify",source,"negado","Seu Pedido foi recusado.",5)
-- 				end
-- 			end
-- 		end
-- 	end
-- end)

-- RegisterServerEvent("marriedEvent")
-- AddEventHandler("marriedEvent",function(nveh,door)
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	local identity = vRP.getUserIdentity(user_id)
	
-- 	if user_id then
-- 		if not delayShip[user_id] then delayShip[user_id] = 0 end

-- 		if vRP.getInventoryItemAmount(user_id, "alianca") <= 0 then
-- 			TriggerClientEvent("Notify",source,"negado","Você não possui uma aliança.",5)
-- 			return
-- 		end

-- 		if (os.time() - delayShip[user_id]) < 60 then
-- 			TriggerClientEvent("Notify",source,"negado","Aguarde para fazer um pedido novamente.",5)
-- 			return
-- 		end

-- 		local shipUserId = getRelacionamento(user_id)
-- 		if shipUserId.tipo ~= nil then
-- 			if shipUserId.tipo == "Casado(a)" then
-- 				TriggerClientEvent("Notify",source,"negado","Sossega! Você já está Casado(a).",5)
-- 				return
-- 			end

-- 			local nplayer = vRPclient.getNearestPlayer(source, 5)
-- 			if nplayer then
-- 				local nuser_id = vRP.getUserId(nplayer)
-- 				local nidentity = vRP.getUserIdentity(nuser_id)
-- 				if nuser_id then
-- 					if shipUserId.user_id == nuser_id then
-- 						TriggerClientEvent("Notify",source,"negado","Você está fazendo o pedido de casamento...",5)

-- 						local requestCasamento = vRP.request(nplayer, "O(a) "..identity.nome.. " "..identity.sobrenome.." Está pedindo você em casamento, deseja aceitar?")
-- 						if requestCasamento then
-- 							delayShip[user_id] = os.time()
-- 							delayShip[nuser_id] = os.time()
-- 							TriggerClientEvent('chat:addMessage',-1,{template='<div style="display:flex;align-items:center;justify-content:center;padding:10px;margin:5px 0;background-image: linear-gradient(to right, rgba(240, 108, 108,0.8) 3%, rgba(240, 86, 86,0) 95%);border-radius: 5px;"><img width="32" style="float: left;" src="https://media.discordapp.net/attachments/1035280539046903899/1095493129899089930/1786714.png">'..identity.nome.. ' '..identity.sobrenome..' e '..nidentity.nome..' '..nidentity.sobrenome..' acabaram de se casar.</b></div>'})
					
-- 							vRP._execute("setRelacionamento", { user_id = nuser_id, relacionamento = json.encode({ tipo = "Casado(a)", user_id = user_id, data = os.date("%d/%m/%Y", os.time()), name = identity.nome.. " ".. identity.sobrenome }) })
-- 							vRP._execute("setRelacionamento", { user_id = user_id, relacionamento = json.encode({ tipo = "Casado(a)", user_id = nuser_id, data = os.date("%d/%m/%Y", os.time()), name = nidentity.nome.. " ".. nidentity.sobrenome }) })
-- 							vRP._updateIdentity(user_id)
-- 							vRP._updateIdentity(nuser_id)
-- 							vRP.tryGetInventoryItem(user_id, "alianca", 1)
-- 						else
-- 							TriggerClientEvent("Notify",source,"negado","Seu Pedido foi recusado.",5)
-- 						end
-- 					else
-- 						TriggerClientEvent("Notify",source,"negado","Essa pessoa não namora você.",5)
-- 					end
-- 				end
-- 			end
-- 		else
-- 			TriggerClientEvent("Notify",source,"negado","Você não está em uma relação no momento.",5)
-- 			return
-- 		end
-- 	end
-- end)

RegisterCommand('namorar', function(source,args)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local status, time = exports['vrp']:getCooldown(user_id, "namorar")
	if not status then
		return TriggerClientEvent("Notify",source,"negado","Você poderá utilizar esse comando novamente em: "..time,5)
	end
	exports['vrp']:setCooldown(user_id, "namorar", 60)
		
	if user_id then
		
		if vRP.getInventoryItemAmount(user_id, "alianca") <= 0 then
			TriggerClientEvent("Notify",source,"negado","Você não possui uma aliança.",5)
			return
		end

		local nplayer = vRPclient.getNearestPlayer(source, 5)
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				local nidentity = vRP.getUserIdentity(nuser_id)
				local shipNUserId = getRelacionamento(nuser_id)
				local shipUserId = getRelacionamento(user_id)

				if shipUserId.tipo ~= nil then
					local betrayedName = shipUserId.name

					TriggerClientEvent('chatMessage', -1, {
						prefix = 'ANUNCIO',
						title = 'NAMORO',
						message = 'AlÔ 🐂 '..betrayedName.. ' 🐂(a), '..identity.nome.. ' está tentando te trair com '..nidentity.nome,
						type = 'relationship', -- vip/relacionamento/termino
					})

					return TriggerClientEvent("Notify",source,"negado","Você está querendo trair alguém, não faça isso.",5)
				end

				if shipNUserId.tipo ~= nil then
					TriggerClientEvent("Notify",source,"negado","Este Jogador já está em uma relação no momento.",5)
					return
				end
				TriggerClientEvent("Notify",source,"negado","Você está fazendo o pedido de namoro...",5)

				TriggerClientEvent("emotes", nplayer, "cruzar")
				TriggerClientEvent("emotes", source, "ajoelhar")
				TriggerClientEvent("emotes", source, "rosa")

				local requestCasamento = vRP.request(nplayer, "O(a) "..identity.nome.. " "..identity.sobrenome.." Está pedindo sua mão em namoro, deseja aceitar?")
				if requestCasamento then

					TriggerClientEvent('chatMessage', -1, {
						prefix = 'ANUNCIO',
						title = 'NAMORO',
						message =  identity.nome.. ' '..identity.sobrenome..' está namorando '..nidentity.nome..' '..nidentity.sobrenome,
						type = 'relationship', -- vip/relacionamento/termino
					})

					TriggerClientEvent("emotes", nplayer, "beijar")
					TriggerClientEvent("emotes", source, "beijar")

					vRP._execute("setRelacionamento", { user_id = nuser_id, relacionamento = json.encode({ tipo = "Namorando", user_id = user_id, data = os.date("%d/%m/%Y", os.time()), name = identity.nome.. " ".. identity.sobrenome }) })
					vRP._execute("setRelacionamento", { user_id = user_id, relacionamento = json.encode({ tipo = "Namorando", user_id = nuser_id, data = os.date("%d/%m/%Y", os.time()), name = nidentity.nome.. " ".. nidentity.sobrenome }) })

					vRP._updateIdentity(nuser_id)
					vRP._updateIdentity(user_id)
					vRP.tryGetInventoryItem(user_id, "alianca", 1)
				else
					TriggerClientEvent("Notify",source,"negado","Seu Pedido foi recusado.",5)
				end
			end
		end
	end
end)

RegisterCommand('casar', function(source,args)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	

	local status, time = exports['vrp']:getCooldown(user_id, "casar")
	if not status then
		return TriggerClientEvent("Notify",source,"negado","Você poderá utilizar esse comando novamente em: "..time,5)
	end
	
	exports['vrp']:setCooldown(user_id, "casar", 60)
		
	if user_id then

		if vRP.getInventoryItemAmount(user_id, "alianca") <= 0 then
			TriggerClientEvent("Notify",source,"negado","Você não possui uma aliança.",5)
			return
		end

		local shipUserId = getRelacionamento(user_id)
		if shipUserId.tipo ~= nil then
			if shipUserId.tipo == "Casado(a)" then
				TriggerClientEvent("Notify",source,"negado","Sossega! Você já está Casado(a).",5)
				return
			end

			local nplayer = vRPclient.getNearestPlayer(source, 5)
			if nplayer then
				local nuser_id = vRP.getUserId(nplayer)
				local nidentity = vRP.getUserIdentity(nuser_id)
				if nuser_id then					
					if shipUserId.user_id == nuser_id then
						TriggerClientEvent("Notify",source,"negado","Você está fazendo o pedido de casamento...",5)

						local requestCasamento = vRP.request(nplayer, "O(a) "..identity.nome.. " "..identity.sobrenome.." Está pedindo você em casamento, deseja aceitar?")
						if requestCasamento then
							TriggerClientEvent('chatMessage', -1, {
								prefix = 'ANUNCIO',
								title = 'CASAMENTO',
								message =  identity.nome.. ' '..identity.sobrenome..' e '..nidentity.nome..' '..nidentity.sobrenome..' acabaram de se casar',
								type = 'relationship', -- vip/relacionamento/termino
							})	
					
							vRP._execute("setRelacionamento", { user_id = nuser_id, relacionamento = json.encode({ tipo = "Casado(a)", user_id = user_id, data = os.date("%d/%m/%Y", os.time()), name = identity.nome.. " ".. identity.sobrenome }) })
							vRP._execute("setRelacionamento", { user_id = user_id, relacionamento = json.encode({ tipo = "Casado(a)", user_id = nuser_id, data = os.date("%d/%m/%Y", os.time()), name = nidentity.nome.. " ".. nidentity.sobrenome }) })
							vRP._updateIdentity(user_id)
							vRP._updateIdentity(nuser_id)
							vRP.tryGetInventoryItem(user_id, "alianca", 1)
						else
							TriggerClientEvent("Notify",source,"negado","Seu Pedido foi recusado.",5)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Essa pessoa não namora você.",5)
					end
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você não está em uma relação no momento.",5)
			return
		end
	end
end)

RegisterCommand('terminar', function(source,args)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then

		local shipUserId = getRelacionamento(user_id)
		if shipUserId.tipo == nil then
			TriggerClientEvent("Notify",source,"negado","Você não pode terminar uma relação que não existe.",5)
			return
		end

		if shipUserId.tipo == "Namorando" then
			TriggerClientEvent('chatMessage', -1, {
				prefix = 'ANUNCIO',
				title = 'RELACIONAMENTO',
				message =  identity.nome.. ' '..identity.sobrenome..' e '..shipUserId.name..' terminaram o namoro.',
				type = 'relationship', -- vip/relacionamento/termino
			})		
			
			vRP._execute("setRelacionamento", { user_id = shipUserId.user_id, relacionamento = json.encode({}) })
			vRP._execute("setRelacionamento", { user_id = user_id, relacionamento = json.encode({}) })
			vRP._updateIdentity(user_id)
			vRP._updateIdentity(shipUserId.user_id)
			return
		end

		if shipUserId.tipo == "Casado(a)" then
			TriggerClientEvent('chatMessage', -1, {
				prefix = 'ANUNCIO',
				title = 'CARTÓRIO',
				message =  identity.nome.. ' '..identity.sobrenome..' e '..shipUserId.name..' terminaram o casamento.',
				type = 'relationship', -- vip/relacionamento/termino
			})		
			
			vRP._execute("setRelacionamento", { user_id = shipUserId.user_id, relacionamento = json.encode({}) })
			vRP._execute("setRelacionamento", { user_id = user_id, relacionamento = json.encode({}) })
			vRP._updateIdentity(user_id)
			vRP._updateIdentity(shipUserId.user_id)
		end
	end
end)

function getRelacionamento(user_id)
	local query = vRP.query("getRelacionamento", { user_id = user_id })
	if #query > 0 then
		return json.decode(query[1].relacionamento)
	end

	return false
end

function src.checkPermCor()
    local source = source
    local user_id = vRP.getUserId(source)
    -- if user_id == 9 then
    --     return true
    -- end
	return false
end

AddEventHandler("vRP:playerSpawn",function(user_id,source)
	if GetResourceState("dm_module") ~= "started" then return end

	local org = vRP.getUserGroupOrg(user_id)

	if not org then return end

	if not vRP.hasPermission(user_id, 'perm.ilegal') then return end

	local permission = "perm."..string.lower(org)

	TriggerClientEvent("novak:markerYouOrganization", source, permission, org)
end)