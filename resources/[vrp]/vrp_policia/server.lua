local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_policia",src)
Proxy.addInterface("vrp_policia",src)

vCLIENT = Tunnel.getInterface("vrp_policia")

local idgens = Tools.newIDGenerator()

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Itens Ilegais
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local blackItens = {
	"algemas",
	"chave_algemas",
	"c4",
	--"bolsadinheiro",
	"masterpick",
	"pendrive",
	"furadeira",
	"lockpick",
	"m-aco",
	"m-capa_colete",
	"m-corpo_ak47_mk2",
	"m-corpo_g3",
	"m-corpo_machinepistol",
	"m-corpo_pistol_mk2",
	"m-corpo_shotgun",
	"papel",
	"podemd",
	"fibradecarbono",
	"poliester",
	"m-corpo_smg_mk2",
	"m-corpo_snspistol_mk2",
	"m-gatilho",
	"zincocobre",
	"polvora",
	"pecadearma",
	"metal",
	"molas",
	"gatilho",
	"m-malha",
	"aluminio",
	"m-tecido",
	"c-cobre",
	"c-ferro",
	"c-fio",
	"c-polvora",
	"l-alvejante",
	"folhamaconha",
	"maconha",
	"cogumelo",
	"haxixe",
	"lancaperfume",
	"resinacannabis",
	"pastabase",
	"cocaina",
	"acidolsd",
	"body_armor",
	"capuz",
	"dirty_money",
	"scubagear",
	"relogioroubado",
	"colarroubado",
	"anelroubado",
	"brincoroubado",
	"pulseiraroubada",
	"carnedepuma",
	"carnedelobo",
	"carnedejavali",
	"lsd",
	"morfina",
	"opiopapoula",
	"heroina",
	"opio",
	"anfetamina",
	"respingodesolda",
	"metanfetamina",
	"tartaruga",
	"balinha",
	"WEAPON_SNSPISTOL_MK2",
	"AMMO_SNSPISTOL_MK2",
	"WEAPON_PISTOL_MK2",
	-- "WEAPON_PISTOL",
	-- "AMMO_PISTOL",
	"WEAPON_MILITARYRIFLE",

	
	"WEAPON_FIREWORK",
	"WEAPON_SNOWBALL",
	"WEAPON_BZGAS",

	"WEAPON_GUSENBERG",
	"WEAPON_PISTOL50",
	"WEAPON_HATCHET",
	"AMMO_PISTOL_MK2",
	"WEAPON_COMBATPISTOL",
	"WEAPON_COMBATPDW",
	"AMMO_COMBATPISTOL",
	"WEAPON_MACHINEPISTOL",
	"AMMO_MACHINEPISTOL",
	"WEAPON_SMG_MK2",
	"AMMO_SMG_MK2",
	"WEAPON_SMG",
	"AMMO_SMG",
	"WEAPON_ASSAULTSMG",
	"WEAPON_MICROSMG",
	"AMMO_ASSAULTSMG",
	"WEAPON_SAWNOFFSHOTGUN",
	"AMMO_SAWNOFFSHOTGUN",
	"WEAPON_PUMPSHOTGUN_MK2",
	"AMMO_PUMPSHOTGUN_MK2",
	"WEAPON_ASSAULTRIFLE_MK2",
	"AMMO_ASSAULTRIFLE_MK2",
	"WEAPON_ASSAULTRIFLE",
	"AMMO_ASSAULTRIFLE",
	"AMMO_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_SPECIALCARBINE",
	"AMMO_SPECIALCARBINE_MK2",
	"WEAPON_AKPENTEDE90_RELIKIASHOP",
	"AMMO_AKPENTEDE90_RELIKIASHOP",
	"WEAPON_AKDEFERRO_RELIKIASHOP",
	"AMMO_AKDEFERRO_RELIKIASHOP",
	"WEAPON_AK472",
	"AMMO_AK472",
	"WEAPON_AR10PRETO_RELIKIASHOP",
	"AMMO_AR10PRETO_RELIKIASHOP",
	"WEAPON_AR15BEGE_RELIKIASHOP",
	"AMMO_AR15BEGE_RELIKIASHOP",
	"WEAPON_ARPENTEACRILICO_RELIKIASHOP",
	"AMMO_ARPENTEACRILICO_RELIKIASHOP",
	"WEAPON_ARDELUNETA_RELIKIASHOP",
	"AMMO_ARDELUNETA_RELIKIASHOP",
	"WEAPON_ARLUNETAPRATA",
	"AMMO_ARLUNETAPRATA",
	"WEAPON_ARTAMBOR",
	"AMMO_ARTAMBOR",
	"WEAPON_G3LUNETA_RELIKIASHOP",
	"AMMO_G3LUNETA_RELIKIASHOP",
	"WEAPON_GLOCKDEROUPA_RELIKIASHOP",
	"AMMO_GLOCKDEROUPA_RELIKIASHOP",
	"WEAPON_HKG3A3",
	"AMMO_HKG3A3",
	"WEAPON_HK_RELIKIASHOP",
	"AMMO_HK_RELIKIASHOP",
	"WEAPON_PENTEDUPLO1",
	"AMMO_PENTEDUPLO1",
	"WEAPON_50_RELIKIASHOP",
	"AMMO_50_RELIKIASHOP",
	"WEAPON_CARBINERIFLE",
	"AMMO_CARBINERIFLE",
	"WEAPON_CARBINERIFLE_MK2",
	"AMMO_CARBINERIFLE_MK2",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_PARAFAL",
	"WEAPON_ADVANCEDRIFLE",
	"AMMO_SPECIALCARBINE",
	"WEAPON_STUNGUN",
	"WEAPON_PETROLCAN",
	"AMMO_PETROLCAN",
	"AMMO_BZGAS",
	
	"weapon_pistol_mk2",
    "ammo_pistol_mk2",
    "weapon_machinepistol",
    "ammo_machinepistol",
    "weapon_smg",
    "ammo_smg",
    "weapon_assaultrifle_mk2",
    "ammo_assaultrifle_mk2",
    "weapon_snspistol_mk2",
    "ammo_snspistol_mk2",
    "weapon_specialcarbine_mk2",
    "ammo_specialcarbine_mk2",
    "weapon_smg_mk2",
    "ammo_smg_mk2",
    "weapon_heavysniper",
    "ammo_heavysniper",
    "weapon_microsmg",
    "ammo_microsmg",
    "weapon_pumpshotgun_mk2",
    "ammo_pumpshotgun_mk2",

	"WEAPON_AKCROMO",
	"AMMO_AKCROMO",
	"WEAPON_ARRELIKIASHOPFEMININO1",
	"AMMO_ARRELIKIASHOPFEMININO1",
	"WEAPON_ARRELIKIASHOPFEMININO2",
	"AMMO_ARRELIKIASHOPFEMININO2",
	"WEAPON_ARVASCO",
	"AMMO_ARVASCO",
	"WEAPON_CHEYTAC",
	"AMMO_CHEYTAC",
	"WEAPON_G3RELIKIASHOPFEMININO",
	"AMMO_G3RELIKIASHOPFEMININO",
	"WEAPON_GLOCKRAJADA",
	"AMMO_GLOCKRAJADA",
	"WEAPON_GLOCKRELIKIASHOPFEMININO0",
	"AMMO_GLOCKRELIKIASHOPFEMININO0",
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PEGAR RG
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choice_pedirrg = {function(source,choice)
    local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,4)
	if user_id then
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			local identity = vRP.getUserIdentity(nuser_id)
			local carteira = vRP.getMoney(nuser_id)
			local trabalho = vRP.getUserGroupByType(nuser_id, "job") if (trabalho == nil or trabalho == "") or (trabalho == "Vendedor de Drogas" or trabalho == "Traficante de Tartartuga" or trabalho == "Hacker" or trabalho == "Cacador" or trabalho == "Clandestino") then trabalho = "Desempregado" end
			local porte
			if (vRP.hasGroup(nuser_id, "Porte de Armas")) then porte = 'Possui' else porte = 'Não Possui' end

			local getWarrant = vRP.query("NVK/getWarrant", {user_id = nuser_id})

			local procurado = next(getWarrant) and "Procurado" or "Não Procurado"

			if vCLIENT.enviarIdentidade(source, true, identity.user_id, identity.nome,identity.sobrenome,identity.idade,identity.registro,identity.telefone,vRP.format(carteira),trabalho, porte, procurado) then
				TriggerClientEvent("Notify",nplayer,"importante","O Policial esta checando seu documento.", 5)
				if vRP.request(source, "Deseja fechar a identidade do individuo?", 120) then
					vCLIENT._enviarIdentidade(source, false) else vCLIENT.enviarIdentidade(source, false)
				end
            end
        else
            TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
		end
	end
end}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ALGEMAR
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choice_algemar = {function(source,choice)
    local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local nplayer = vRPclient.getNearestPlayer(source,3)
		if GetEntityHealth(GetPlayerPed(source)) <= 105 then return end

		if vRP.hasPermission(user_id, "perm.policia") then
			if not vRP.checkPatrulhamento(user_id) then
				return
			end
		end

		if nplayer then
			if not vCLIENT.checkAnim(nplayer) and not vRP.hasPermission(user_id, "admin.permissao") and not vRP.hasPermission(user_id, 'perm.policia') and not vRP.hasPermission(user_id, 'developer.permissao') then
				TriggerClientEvent("Notify",source,"importante","O jogador não está rendido.", 5)
				return
			end

			local inZone = vCLIENT.inSafe(source)

			local hasAdminPermission = vRP.hasPermission(user_id,'admin.permissao') or vRP.hasPermission(user_id,'moderador.permissao') or vRP.hasPermission(user_id,'suporte.permissao') or vRP.hasGroup(user_id, 'ajudantelotusgroup@445')
			if inZone and not hasAdminPermission then 
				return false, TriggerClientEvent("Notify",source,"importante","O jogador está em uma safezone.", 5)
			end

			local TargetId = vRP.getUserId(nplayer)
			if vRP.getInventoryItemAmount(user_id, "algemas") >= 1 or vRP.hasPermission(user_id, 'developer.permissao') or vRP.hasPermission(user_id, "perm.core") or vRP.hasPermission(user_id, "perm.pf") or vRP.hasPermission(user_id, "perm.cot") or vRP.hasPermission(user_id, "perm.policiacivil") or vRP.hasPermission(user_id, "perm.policia") or vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
				TriggerEvent("dk:removeItem", user_id, "algemas", 1)
				local status, time = exports['vrp']:getCooldown(user_id, "algemard")
				if status then
					exports['vrp']:setCooldown(user_id, "algemard", 5)
					if vRPclient._isHandcuffed(nplayer) then
						TriggerClientEvent("vrp_sound:source",source,'uncuff',0.4)
						TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.4)
						vRPclient._setHandcuffed(nplayer, false)
					else
						vCLIENT.arrastar(nplayer,source)
						vRPclient._playAnim(source,false,{{"mp_arrest_paired","cop_p2_back_left"}},false)
						vRPclient._playAnim(nplayer,false,{{"mp_arrest_paired","crook_p2_back_left"}},false)
						SetTimeout(3500,function()
							vRPclient._stopAnim(source,false)
							vRPclient._toggleHandcuff(nplayer)
							vCLIENT._arrastar(nplayer,source)
							TriggerClientEvent("vrp_sound:source",source,'cuff',0.1)
							TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
							vRPclient._setHandcuffed(nplayer, true)
						end)

						vRP.sendLog("https://discord.com/api/webhooks/1313515578517880862/3mi7qQB3KRw-0zqtIZGE-KoaO1uidczVI74E2HpDXzC9k0VYLChoglvWg5_9yVgnG8SH","O ID: "..user_id.." Algemou o Passaporte :"..(TargetId or "?").."")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Aguarde para algemar novamente.", 5)
				end
			end
		end
	end
end}


function src.algemar(inZone)
	local source = source
    local user_id = vRP.getUserId(source)
	if user_id ~= nil then		
		if vRP.getInventoryItemAmount(user_id, "algemas") >= 1 or vRP.hasPermission(user_id, "perm.algemar") or vRP.hasPermission(user_id, "perm.unizk") 
		or vRP.hasPermission(user_id, "perm.judiciario") or vRP.hasPermission(user_id, "perm.core") or vRP.hasPermission(user_id, "perm.disparo") 
		or vRP.hasPermission(user_id, "perm.pf") or vRP.hasPermission(user_id, "perm.policiacivil") or vRP.hasPermission(user_id, "perm.policia") 
		or vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id," suporte.permissao")
		or vRP.hasPermission(user_id, "perm.bombeirocivil") then
			TriggerEvent("dk:removeItem", user_id, "algemas", 1)
			local nplayer = vRPclient.getNearestPlayer(source,3)
			if GetEntityHealth(GetPlayerPed(source)) <= 105 then return end

			if nplayer then
				if not vRP.hasPermission(user_id, "admin.permissao") and not (vRP.hasPermission(user_id, 'perm.disparo') and vRP.checkPatrulhamento(user_id)) and not (vRP.hasPermission(user_id, 'perm.chamadosbombeiro') and vRP.checkPatrulhamento(user_id)) then 
					if not vCLIENT.checkAnim(nplayer) then
						return
					end
				end

				if vRP.hasPermission(user_id, "perm.disparo") then
					if not vRP.checkPatrulhamento(user_id) then
						return
					end
				end

				local hasAdminPermission = vRP.hasPermission(user_id,'admin.permissao') or vRP.hasPermission(user_id,'moderador.permissao') or vRP.hasPermission(user_id,'suporte.permissao')
				
				if inZone and not hasAdminPermission then 
					return false, TriggerClientEvent("Notify",source,"importante","O jogador está em uma safezone.", 5)
				end

				local nuser_id = vRP.getUserId(nplayer)
				if vRP.hasPermission(nuser_id, "developer.permissao") then
					return
				end

				if not vRPclient.isInVehicle(nplayer) then
					local status, time = exports['vrp']:getCooldown(user_id, "algemard")
					if status then
						exports['vrp']:setCooldown(user_id, "algemard", 5)
						if vRPclient.isHandcuffed(nplayer) then
							TriggerClientEvent("vrp_sound:source",source,'uncuff',0.4)
							TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.4)
							vRPclient._setHandcuffed(nplayer, false)
						else
							vCLIENT._arrastar(nplayer,source)
							vRPclient._playAnim(source,false,{{"mp_arrest_paired","cop_p2_back_left"}},false)
							vRPclient._playAnim(nplayer,false,{{"mp_arrest_paired","crook_p2_back_left"}},false)
							SetTimeout(3500,function()
								vRPclient._stopAnim(source,false)
								vRPclient._toggleHandcuff(nplayer)
								vCLIENT._arrastar(nplayer,source)
								TriggerClientEvent("vrp_sound:source",source,'cuff',0.1)
								TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
								vRPclient._setHandcuffed(nplayer, true)
							end)
						end
						vRP.sendLog('', 'ID '..user_id..' utilizou o algemar')
					else 
						TriggerClientEvent("Notify",source,"negado","Aguarde para algemar novamente.", 5)
					end
				end
			end
		end
	end
end

RegisterCommand('soltarh', function(source,args)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source, 3)
	local allowedIds = {
	}

	if user_id and nplayer then
		if allowedIds[user_id] or vRP.hasGroup(user_id,"respkidslotusgroup@445") or vRP.hasGroup(user_id,"respstreamerlotusgroup@445") or vRP.hasGroup(user_id,"resploglotusgroup@445") or vRP.hasGroup(user_id,"respstafflotusgroup@445") or vRP.hasGroup(user_id,"respkidsofflotusgroup@445") or vRP.hasPermission(user_id, "perm.resppolicia") or vRP.hasPermission(user_id, "diretor.permissao") or vRP.hasPermission(user_id, "perm.respilegal")  then
			vCLIENT._arrastar(source,nplayer)
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- RETIRAR MASCARA
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choice_rmascara = {function(source,choice)
    local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local nplayer = vRPclient.getNearestPlayer(source,3)
		if nplayer then
			vCLIENT._retirarMascara(nplayer)
		else
			TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
		end
	end
end} 
---SafeGetNearestPlayer - Prevenir falsificação no tunnel
---@param source any
---@param distance any
---@return nil
function SafeGetNearestPlayer(source, distance)
    local nplayer = vRPclient.getNearestPlayer(source, distance)
    if not nplayer or nplayer <= 0 then
        return nil
    end
	local srcCoords = GetEntityCoords(GetPlayerPed(source))
	local targetCoords = GetEntityCoords(GetPlayerPed(nplayer))
	--- distance+10 para prevenir inconsistências de coordenadas C-S
	if #(srcCoords - targetCoords) > (distance + 10) then
		return nil
	end
    return nplayer
end
RegisterCommand('rmascara',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"perm.policia") or vRP.hasPermission(user_id,"perm.unizk") or vRP.hasPermission(user_id,"perm.bombeiro") then
		if user_id ~= nil then
			local nplayer = vRPclient.getNearestPlayer(source,3)
			if nplayer then
				vCLIENT._retirarMascara(nplayer)
			else
				TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
			end
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ARRASTAR
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choice_arrastar = {function(source,choice)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local nplayer = SafeGetNearestPlayer(source,3)
		if nplayer then
			if vRP.hasPermission(user_id, "perm.policia") or vRP.hasPermission(user_id,"perm.unizk") then
				if not vRP.checkPatrulhamento(user_id) then
					return
				end
			end

			local inZone = vCLIENT.inSafe(source)

			local hasAdminPermission = vRP.hasPermission(user_id,'admin.permissao') or vRP.hasPermission(user_id,'moderador.permissao') or vRP.hasPermission(user_id,'suporte.permissao')
			if inZone and not hasAdminPermission then 
				return false, TriggerClientEvent("Notify",source,"importante","O jogador está em uma safezone.", 5)
			end

			local nuser_id = vRP.getUserId(nplayer)

			vCLIENT._arrastar(nplayer,source)
		else
			TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
		end
	end
end}

local wbHook = "https://ptb.discord.com/api/webhooks/1313515513258840186/7q4vYAzomvStxSKah25dwS4H4juh2M8Caa5gC4W466NKNfe9MVQVJ87tY6F7lqAlqage"
local mecanicas = {
	['perm.deboxe'] = { coords = vec3(-327.86,-113.85,38.96), range = 60.0 },
	['perm.mecanica'] = { coords = vec3(-2220.38,-385.46,13.73), range = 60.0 },
	['perm.race'] = { coords = vec3(457.57,-1309.85,29.34), range = 60.0 },
}

function src.arrastar(inZone)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local allowedPermissions = {
            "perm.arrastar", "perm.arrastarCustoms", "perm.arrastarcustoms", "perm.arrastarmecanica",
			"perm.arrastarrace",
            "perm.jornal", "perm.policia", "perm.judiciario", "perm.pf",
            "perm.core", "perm.policiacivil", "admin.permissao", "moderador.permissao",
            "suporte.permissao", "perm.unizk", "perm.prf", "perm.bombeiro", "perm.bope", "perm.choque", "developer.permissao", "perm.bombeirocivil", "perm.dandara"
        }
		 
		local hasPermission = false
        for _, permission in ipairs(allowedPermissions) do
            if vRP.hasPermission(user_id, permission) then
                hasPermission = true
                break
            end
        end

		if vRP.hasGroup(user_id,"ajudantelotusgroup@445") then
			hasPermission = false
		end

		if vRP.hasGroup(user_id,"ajudanteofflotusgroup@445") then
			hasPermission = false
		end

		if user_id == 505 or user_id == 7362 then
			hasPermission = true
		end

		if not hasPermission then 
			return 
		end 

		if vRP.hasPermission(user_id, "perm.disparo") or vRP.hasPermission(user_id,"perm.unizk") or vRP.hasPermission(user_id,"perm.disparo") or vRP.hasPermission(user_id,"perm.bombeirocivil") then
			if not vRP.checkPatrulhamento(user_id) and not vRP.hasPermission(user_id, "developer.permissao") then
				return
			end
		end

		if GetEntityHealth(GetPlayerPed(source)) <= 105 then 
			return 
		end

		for k, v in pairs(mecanicas) do 	
			if vRP.hasPermission(user_id, k) then
				if not vRP.checkPatrulhamento(user_id) and not vRP.hasPermission(user_id, "developer.permissao") then
					return
				end

				local coords = GetEntityCoords(GetPlayerPed(source))
				if #(coords - v.coords) > v.range then
					return
				end
			end
		end

		if inZone and vRP.hasPermission(user_id, 'perm.disparo') then
			return false, TriggerClientEvent("Notify",source,"importante","O jogador está em uma safezone.", 5)
		end

		local nplayer = SafeGetNearestPlayer(source,3)

		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)

			if vRP.hasPermission(nuser_id, "developer.permissao") then
                TriggerClientEvent("Notify",source,"negado","É melhor não fazer isso!", 5)
                return
            end

			local coords = GetEntityCoords(GetPlayerPed(nplayer))
			local nuser_id = vRP.getUserId(nplayer)
			vCLIENT._arrastar(nplayer,source)

			if nuser_id then 
				vRP.sendLog(wbHook,"O ID : "..user_id.." segurou o id : "..nuser_id.." localização : "..coords.x..","..coords.y..","..coords.z)
			end
		end
	end
end

function src.arrastar2()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then

		local function hasPermGroups()
			local groups = {
				["developerlotusgroup@445"] = true,
				["top1"] = true
			}

			for k,v in pairs(groups) do 
				if vRP.hasGroup(user_id,k) then 
					return true 
				end
			end

			return false 
		end

		if user_id == 2 or hasPermGroups() then
			if GetEntityHealth(GetPlayerPed(source)) <= 105 then return end

			-- if vRP.hasPermission(user_id, "perm.policia") then 
			-- 	if not vRP.checkPatrulhamento(user_id) then
			-- 		return
			-- 	end
			-- else 
				local nplayer = SafeGetNearestPlayer(source,3)
				if nplayer then
					vCLIENT._arrastar2(nplayer,source)
				end
			--end
		end
	end
end

RegisterCommand('soltarf', function(source,args)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source, 3)
	if user_id and nplayer then
		if vRP.hasPermission(user_id, 'developer.permissao') or vRP.hasGroup(user_id, 'TOP1') then
			vCLIENT._arrastar2(source,nplayer)
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONSULTAR MALAS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choice_consultarmalas = {function(source,choice)
    local user_id = vRP.getUserId(source)
	if user_id then
		local mPlaca,mName,mNet,mPortaMalas,mPrice,mLock = vRPclient.ModelName(source, 5)
		if mPlaca and not mLock and mPortaMalas ~= nil then
			local nuser_id = vRP.getUserByRegistration(mPlaca)

			local rows = vRP.query("vRP/get_portaMalas",{ user_id = parseInt(nuser_id), veiculo = string.lower(mName) }) or {}
			if #rows > 0 then
				local portaMalasData = json.decode(rows[1].portamalas)
				
				if not next(portaMalasData) then
					TriggerClientEvent("Notify", source, "negado", "Porta malas vazio.")
				else
					local itemList = {}
					
					for _, itemData in pairs(portaMalasData) do
						local itemName = itemData.item
						local itemAmount = itemData.amount
						table.insert(itemList, vRP.getItemName(itemName) .. " x" .. itemAmount)
					end
					
					TriggerClientEvent("Notify", source, "importante", "Itens no porta-malas:<br>" .. table.concat(itemList, "<br>"), 60)
				end
			else
				
				local rowsTmp = vRP.getSData("tmpChest:"..mName.."_"..mPlaca) or {}
				if #rowsTmp > 0 then
					local portaMalasData = json.decode(rowsTmp)
				
					if not next(portaMalasData) then
						TriggerClientEvent("Notify", source, "negado", "Porta malas vazio.")
					end 
	
					local itemList = {} 
					
					for _, itemData in pairs(portaMalasData) do
						local itemName = itemData.item
						local itemAmount = itemData.amount
						table.insert(itemList, vRP.getItemName(itemName) .. " x" .. itemAmount) 
					end
					
					TriggerClientEvent("Notify", source, "importante", "Itens no porta-malas:<br>" .. table.concat(itemList, "<br>"), 60)
				else
					TriggerClientEvent("Notify", source, "negado", "Porta-malas não encontrado.")
				end
			end
		end
	end
end}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COLOCAR NO VEICULO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choice_colocarveh = {function(source,choice)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,4)
	if user_id then
		if nplayer then
			if vRPclient.isHandcuffed(nplayer) then
				vRPclient._putInNearestVehicleAsPassenger(nplayer, 5)
				TriggerClientEvent("Notify",source,"sucesso","Voce colocou o cidadao no veiculo.", 5)
			else
				TriggerClientEvent("Notify",source,"negado","O Jogador não está algemado.", 5)
			end
		else
			TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
		end
	end
end}

RegisterCommand('cv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,4)
	if vRP.hasPermission(user_id,"perm.policia") or vRP.hasPermission(user_id,"perm.unizk") or vRP.hasPermission(user_id,"perm.bombeiro") or vRP.hasPermission(user_id,"admin.permissao") then 
		if user_id then
			if nplayer then
				if vRPclient.isHandcuffed(nplayer) then
					vRPclient._putInNearestVehicleAsPassenger(nplayer, 5)
					TriggerClientEvent("Notify",source,"sucesso","Voce colocou o cidadao no veiculo.", 5)
				else
					TriggerClientEvent("Notify",source,"negado","O Jogador não está algemado.", 5)
				end
			else
				TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
			end
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- RETIRAR DO VEICULO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choive_retirarveh = {function(source,choice)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,4)
	if user_id then
		if nplayer then
			if vRPclient.isHandcuffed(nplayer) then
				vRPclient._ejectVehicle(nplayer, {})
				TriggerClientEvent("Notify",source,"negado","Voce retirou o cidadao no veiculo.", 5)
			else
				TriggerClientEvent("Notify",source,"negado","O Jogador não está algemado.", 5)
			end
		else
			TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
		end
	end
end}

RegisterCommand('rv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,4)
	if vRP.hasPermission(user_id,"perm.disparo") or vRP.hasPermission(user_id,"perm.unizk") or vRP.hasPermission(user_id,"perm.bombeiro") or vRP.hasPermission(user_id,"admin.permissao") then 
		if user_id then
			if nplayer then
				if vRPclient.isHandcuffed(nplayer) then
					vRPclient._ejectVehicle(nplayer, {})
					TriggerClientEvent("Notify",source,"negado","Voce retirou o cidadao no veiculo.", 5)
				else
					TriggerClientEvent("Notify",source,"negado","O Jogador não está algemado.", 5)
				end
			else
				TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
			end
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- APREENDER ITENS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choice_apreenderitens = {
    function(source, choice)
        local user_id = vRP.getUserId(source)
        local nplayer = vRPclient.getNearestPlayer(source, 4)
        local nuser_id = vRP.getUserId(nplayer)
        if user_id then
            local status, time = exports['vrp']:getCooldown(user_id, "choice_apreenderitens")
            if status then
                exports['vrp']:setCooldown(user_id, "choice_apreenderitens", 60)
                -- if vRPclient._isHandcuffed(nplayer) then

                if nplayer then
                    local itemsConfiscated = {}


					local blockedItems = { 
						["molas"] = true,
						["metal"] = true,
						["gatilho"] = true,
						["pecadearma"] = true,
						["polvora"] = true,
						["zincocobre"] = true,
						["l-alvejante"] = true,
						["ferro"] = true,
						["aluminio"] = true,
						["fibradecarbono"] = true,
						["poliester"] = true,
						["ferro"] = true,
						["aluminio"] = true,
						["fibradecarbono"] = true,
						["poliester"] = true,
						["papel"] = true,
						["ferro"] = true,
						["aluminio"] = true,
						["fibradecarbono"] = true,
						["poliester"] = true,
						["folhamaconha"] = true,
						["pastabase"] = true,
						["podemd"] = true,
						["resinacannabis"] = true,
						["respingodesolda"] = true,
						["anfetamina"] = true,
						["opiopapoula"] = true,
						["morfina"] = true,
						["pastabase"] = true,
						["folhamaconha"] = true,
						["anfetamina"] = true,
						["resinacannabis"] = true,
						["opiopapoula"] = true,
						["morfina"] = true,
						["respingodesolda"] = true,
						["podemd"] = true,
					}

					local weapons = vRP.clearWeapons(nuser_id)

					for k,v in pairs(weapons) do
						exports.nova_apreender:seizeItem(user_id, 'weapon', 1)
						itemsConfiscated[#itemsConfiscated + 1] = ("%d %s"):format(v.ammo, k)
					end
					
                    for k, v in pairs(blackItens) do
						if v then
							local item = v:lower()
							-- if blockedItems[v] then goto continue end 
							local amount = vRP.getInventoryItemAmount(nuser_id, item)
							if amount and amount > 0 and vRP.tryGetInventoryItem(nuser_id,item,amount) then
								itemsConfiscated[#itemsConfiscated + 1] = ("%d %s"):format(amount, item)
								exports.nova_apreender:seizeItem(user_id, item, amount)

							end
						end
						-- ::continue::
                    end

					vRPclient._replaceWeapons(nplayer,{})
                    vCLIENT._updateWeapons(nplayer)

                    local confiscatedMessage = table.concat(itemsConfiscated, ", ")
                    if confiscatedMessage ~= "" then
                        TriggerClientEvent("Notify", nplayer, "negado", "Seus Itens ilegais foram apreendidos.", 5)
                        TriggerClientEvent("Notify", source, "sucesso", "Você aprendeu os itens ilegais.", 5)
                        TriggerClientEvent("Notify", nplayer, "importante", "Os guardas apreenderam seus itens.", 5)

						exports["vrp_admin"]:generateLog({
							category = "police",
							room = "apreended-item",
							user_id = user_id,
							message = ( [[O USER_ID %s APREENDEU OS ITENS ILEGAIS DO ID %s ITENS : %s]] ):format(user_id, nuser_id, confiscatedMessage)
						})

						vRP.sendLog("https://discord.com/api/webhooks/1313517568060821554/49bfdkHgleooA74cd5Q09TVZ5NRRRvyccst5Pk7UUgmG5bAlmGB1qDEOOIltp089r3AQ","O POLICIAL ID "..user_id.." APREENDEU OS ITENS ILEGAIS DO ID "..nuser_id..": "..confiscatedMessage)
                    else
                        TriggerClientEvent("Notify", source, "aviso", "O jogador não tinha itens ilegais.", 5)
                    end
                else
                    TriggerClientEvent("Notify", source, "negado", "Nenhum jogador proximo.", 5)
                end
                -- else
                --     TriggerClientEvent("Notify",source,"negado","Player não está algemado", 5)
                -- end
            else
                TriggerClientEvent("Notify", source, "negado", "Você está em cooldown: " .. time .. "s", 5)
            end
        end
    end
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONSULTAR VEICULO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choice_consultarveh = {function(source,choice)
    local user_id = vRP.getUserId(source)
	if user_id then
		local mPlaca,mName = vRPclient.ModelName(source, 5)
		local nuser_id = vRP.getUserByRegistration(mPlaca)
		if nuser_id then
			local identity = vRP.getUserIdentity(nuser_id)
			if identity then
				TriggerClientEvent("Notify",source,"importante","• Veiculo: <b>"..mName.."</b><br>• Placa: <b>"..mPlaca.."</b><br>• Proprietario: <b>"..identity.nome.. " "..identity.sobrenome.. "</b> (<b>"..identity.idade.."</b>)<br>• Telefone: <b>"..identity.telefone.."</b> <br>• Passaporte: <b>"..identity.user_id.."</b> ", 10)
			end
		else
			TriggerClientEvent("Notify",source,"negado","Não foi possivel consultar esse veiculo.", 5)
		end
	end
end}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- APREENDER VEICULO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local webhook_log = "https://discord.com/api/webhooks/1313517444492558397/uyHdedukEV-qGR9_JcWH2OzhViWx3GFSXq2z2alctVeGTFrnfWPpcQnusSx8pi0dCTW9"

local function sendLog(text)
    if webhook_log and webhook_log ~= "" then
        PerformHttpRequest(webhook_log, function(err, text, headers) end, "POST", json.encode({content = text}), { ["Content-Type"] = "application/json" })
    end
end

local choice_apv = {function(source, choice)
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    if not vRP.hasPermission(user_id, "perm.apreenderveh") then
        TriggerClientEvent("Notify", source, "negado", "Você não pode fazer isto!")
        return
    end

    local mPlaca, mName, mNetVeh = vRPclient.ModelName(source, 5)
    if not mPlaca or not mName then
        TriggerClientEvent("Notify", source, "importante", "Nenhum veículo próximo encontrado.")
        return
    end

    local nuser_id = vRP.getUserByRegistration(mPlaca)
    if not nuser_id then
        TriggerClientEvent("Notify", source, "importante", "Proprietário não encontrado para esta placa.")
        return
    end

    local rows = vRP.query("vRP/get_veiculos_status", { user_id = nuser_id, veiculo = mName })
    if not rows or #rows == 0 or not rows[1] or rows[1].status ~= 0 then
        TriggerClientEvent("Notify", source, "importante", "Este veículo já se encontra apreendido.")
        return
    end

    vRP.execute("vRP/set_status", { user_id = nuser_id, veiculo = mName, status = 1 })

    local identity = vRP.getUserIdentity(nuser_id)
    local logText = "ID " .. user_id .. " apreendeu:\n"

    local query = exports.oxmysql:singleSync('SELECT * FROM vrp_srv_data WHERE dkey = ?', { 'chest:u' .. nuser_id .. 'veh_' .. mName })
    if query then
        local malas = json.decode(query.dvalue) or {}
        for item, itemData in pairs(malas) do
            logText = logText .. itemData.amount .. "x " .. item .. "\n"
        end

        exports.oxmysql:execute('UPDATE vrp_srv_data SET dvalue = ? WHERE dkey = ?', { json.encode({}), 'chest:u' .. nuser_id .. 'veh_' .. mName })
    end

    local coords = vRPclient.getPosition(source)
    if coords then
        logText = logText .. "do veículo " .. mName .. " placa " .. mPlaca .. " do jogador " .. nuser_id .. " na posição " .. string.format("%.2f, %.2f, %.2f", coords.x, coords.y, coords.z)
    end

    sendLog(logText)
    
    exports['nova_garage']:deleteVehicle(source, vRPclient.getNearestVehicle(source, 5))

    if identity then
        TriggerClientEvent("Notify", source, "importante", "<b>VEÍCULO APREENDIDO:</b><br>• Veículo: <b>" .. mName .. "</b><br>• Placa: <b>" .. mPlaca .. "</b><br>• Proprietário: <b>" .. identity.nome .. " " .. identity.sobrenome .. "</b> (<b>" .. identity.idade .. "</b>)<br>• Telefone: <b>" .. identity.telefone .. "</b>", 15)
    end
end}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MULTAR
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choice_multar = {function(source,choice)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id, "Aluno") or vRP.hasGroup(user_id, "Recruta") then
			TriggerClientEvent("Notify",source,"negano","Você não pode fazer isto!")
			return false
		end


		local nplayer = vRPclient.getNearestPlayer(source,4)
		local nuser_id = vRP.getUserId(nplayer)
		if nplayer then
			local valorMulta = vRP.prompt(source, "Digite o valor da Multa: ", "")

			if tonumber(valorMulta) >= 1 and tonumber(valorMulta) <= 200000 then
				local motivoMulta = vRP.prompt(source, "Digite o motivo da Multa: ", "")
				if motivoMulta ~= nil and motivoMulta ~= "" then
					TriggerClientEvent("Notify",source,"importante","Você multou o cidadao em <b>$ "..vRP.format(valorMulta).."</b>", 5)
					TriggerClientEvent("Notify",nplayer,"importante","Você foi multado no valor de <b>$ "..vRP.format(valorMulta).."</b> pelo motivo <b>"..motivoMulta.."</b>", 5)
					vRP.execute("vRP/add_multa",{ user_id = nuser_id, multas = tonumber(valorMulta) })
					src.adicionarCriminal(nuser_id, "MULTA", motivoMulta)
					vRP.sendLog("https://discord.com/api/webhooks/1313517628249214986/COk7TU7kI5T_-jOgEnDXoMq0BSIVCKfRFrzLVDCVc06IeLhE6iQ_2Ikt7fOX42ZohrNz", "O "..user_id.." Multou o ID: "..nuser_id.." no valor de: R$ "..valorMulta)
				else
					TriggerClientEvent("Notify",source,"importante","Digite um motivo correto", 5)
				end
			else
				TriggerClientEvent("Notify",source,"importante","Digite um valor correto entre 1-500000 ", 5)
			end
		end
	end
end}

RegisterCommand('multarem',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"developer.permissao") then
			if args[1] then
				local nplayer = vRP.getUserSource(parseInt(args[2]))
				local nuser_id = vRP.getUserId(nplayer)
				if nplayer then
					TriggerClientEvent("Notify",source,"importante","A multa foi removida!", 5)
					TriggerClientEvent("Notify",nplayer,"importante","Sua multa total foi removida!", 5)
					vRP.execute("vRP/add_multa",{ user_id = nuser_id, multas = tonumber(0) })
				else
					TriggerClientEvent("Notify",source,"negado","O mesmo não se encontra na cidade!")
				end
			end
		end
	end
end)

RegisterCommand('multar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"perm.unizk") then
			local nplayer = vRPclient.getNearestPlayer(source,4)
			local nuser_id = vRP.getUserId(nplayer)
			if nplayer then
				local valorMulta = vRP.prompt(source, "Digite o valor da Multa: ", "")

				if tonumber(valorMulta) >= 1 and tonumber(valorMulta) <= 500000 then
					local motivoMulta = vRP.prompt(source, "Digite o motivo da Multa: ", "")
					if motivoMulta ~= nil and motivoMulta ~= "" then
						TriggerClientEvent("Notify",source,"importante","Você multou o cidadao em <b>$ "..vRP.format(valorMulta).."</b>", 5)
						TriggerClientEvent("Notify",nplayer,"importante","Você foi multado no valor de <b>$ "..vRP.format(valorMulta).."</b> pelo motivo <b>"..motivoMulta.."</b>", 5)
						vRP.execute("vRP/add_multa",{ user_id = nuser_id, multas = tonumber(valorMulta) })
						src.adicionarCriminal(nuser_id, "MULTA", motivoMulta)
						vRP.sendLog("", "O "..user_id.." Multou o ID: "..nuser_id.." no valor de: R$ "..valorMulta)

					else
						TriggerClientEvent("Notify",source,"importante","Digite um motivo correto", 5)
					end
				else
					TriggerClientEvent("Notify",source,"importante","Digite um valor correto entre 1-500000 ", 5)
				end
			end
		end
	end
end)

RegisterCommand('limparficha',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"perm.limparficha") or vRP.hasGroup(user_id, 'resppolicialotusgroup@445') or vRP.hasGroup(user_id, 'setport') 
	or vRP.hasPermission(user_id,"developer.permissao") or vRP.hasGroup(user_id, 'respjuridico') then
		if user_id then
			local nuser_id = tonumber(args[1])
			if nuser_id ~= nil then
				exports.nova_mdt:clearUserCriminalHistory(nuser_id)
				TriggerClientEvent("Notify",source,"sucesso","Você limpo a ficha do (ID: "..nuser_id..") .", 5)
			end
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FICHA CRIMINAL
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.adicionarCriminal(user_id, tipo, criminal)
	local source = vRP.getUserSource(user_id)
	local cCriminal = vRP.query("vRP/get_user_identity",{ user_id = user_id })
	if #cCriminal <= 0 then
		return
	end
	
	local gCriminal = json.decode(cCriminal[1].criminal) or nil
	if user_id then
	  gCriminal[os.time()] = {tipo = tipo, motivo = criminal}
	  vRP.execute("vRP/add_criminal",{ user_id = user_id, criminal = json.encode(gCriminal) })
	end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QTH
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('p', function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	local plyCoords = GetEntityCoords(GetPlayerPed(source))
    local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]
			
	local status, time = exports['vrp']:getCooldown(user_id, "barrap")
	if status then
		exports['vrp']:setCooldown(user_id, "barrap", 10)

		if user_id then
			if vRP.hasPermission(user_id, "perm.disparo") then
				local identity = vRP.getUserIdentity(user_id)
				exports['vrp']:alertPolice({ x = x, y = y, z = z, blipID = 304, blipColor = 3, blipScale = 0.7, time = 20, code = "911", title = "QTH", name = "QTH DE "..identity.nome.." "..identity.sobrenome.." ." })
			end
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFICAO DE DISPARO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.sendLocationFire(x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	local plyCoords = GetEntityCoords(GetPlayerPed(source))
    local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]
	
	if user_id then
		if not vRP.hasPermission(user_id, "perm.disparo") then
			exports['vrp']:alertPolice({ x = x, y = y, z = z, blipID = 161, blipColor = 63, blipScale = 0.5, time = 10, code = "911", title = "QRU Disparos", name = "Um novo registro de disparos foi registrado." })
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Sistema de ficha criminal
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.infoUser(user)
	local source = source 
	if user then
		local identity = vRP.getUserIdentity(parseInt(user))
		local infos = vRP.query("vRP/get_user_identity",{ user_id = user })
		local criminal = json.decode(infos[1].criminal)
		local prisoes = 0
		local avisos = 0

		for k,v in pairs(criminal) do 
			if v.tipo == "PRISAO" then
				prisoes = prisoes + 1
			end

			if v.tipo == "MULTA" then
				avisos = avisos + 1
			end
		end


		if identity then
			return infos[1].multas,identity.nome,identity.sobrenome,identity.registro,parseInt(identity.idade),prisoes,avisos
		end
	end
end

function src.arrestsUser(user)
	local source = source
	if user then
		local infos = vRP.query("vRP/get_user_identity",{ user_id = user })
		if #infos <= 0 then
			return
		end

		local criminal = json.decode(infos[1].criminal)
		local arrest = {}
		if infos then
			for k,v in pairs(criminal) do
				if v.tipo == "PRISAO" then
					table.insert(arrest,{ data = os.date("%d/%m/%Y", k), value = 0, info = v.motivo, officer = "Policia SX" })
				end
			end
			return arrest
		end
	end 
end

function src.ticketsUser(user)
	local source = source
	if user then
		local infos = vRP.query("vRP/get_user_identity",{ user_id = user })
		if #infos <= 0 then
			return
		end

		local criminal = json.decode(infos[1].criminal)
		local ticket = {}
		if infos then
			for k,v in pairs(criminal) do
				if v.tipo == "MULTA" then
					table.insert(ticket,{ data = os.date("%d/%m/%Y", k), value = 0, info = v.motivo, officer = "Policia SX" })
				end
			end
			return ticket
		end
	end
end

function src.warningsUser(user)
	local source = source
	if user then
		local warning = {}
		table.insert(warning,{ data = "Em Breve", value = "0", info = "Em Breve", officer = "Em Breve" })
		return warning
	end
end

function src.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"perm.policia")
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MENU
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP._registerMenuBuilder("police_menu", function(add, data)
	local user_id = vRP.getUserId(data.player)
	local nsource = vRP.getUserSource(user_id)
	if GetEntityHealth(GetPlayerPed(nsource)) <= 105 then 
		TriggerClientEvent("Notify",source,"negado","Você está morto, não pode abrir o insert.", 5)
		return 
	end

	if user_id then
		local choices = {}
        choices["01. Pedir RG"] = choice_pedirrg
        choices["02. Algemar"] = choice_algemar
        choices["03. Arrastar"] = choice_arrastar
		choices["05. Colocar Veiculo"] = choice_colocarveh
        choices["06. Retirar Veiculo"] = choive_retirarveh
		choices["07. Apreender Itens"] = choice_apreenderitens
		choices["08. Consultar Veiculo"] = choice_consultarveh
        choices["09. Apreender Veiculo"] = choice_apv
		choices["10. Visualizar Porta-Malas"] = choice_consultarmalas
		choices["11. Multar"] = choice_multar
		choices["12. Retirar Mascara"] = choice_rmascara
		add(choices)
	end
end)
