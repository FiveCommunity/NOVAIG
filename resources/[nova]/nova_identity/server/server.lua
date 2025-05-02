identidade = {}
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")
Tunnel.bindInterface(GetCurrentResourceName(), identidade)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

vipGroups = {
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
	'altarj',
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




AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	if (not user_id) then return end
	if (identidade[tostring(user_id)]) then return end

	local query = exports["oxmysql"]:executeSync('SELECT avatarURL from smartphone_instagram WHERE user_id = ? ', { user_id })
	if (not query[1]) then return end

	identidade[tostring(user_id)] = {}
	identidade[tostring(user_id)].avatarURL = query[1].avatarURL
end)

identidade.getInfos = function()
	local src = source
	local user_id = vRP.getUserId(src)
	local porte
	local isStaff
	local avatarURL
	local currentVips = {}

	if (not user_id) then return end

	local identity = vRP.getUserIdentity(user_id)

	if (vRP.hasGroup(user_id, "Porte de Armas")) then porte = 'Possui' else porte = nil end

	isStaff = vRP.getUserGroupByType(user_id, "staff")

	if (isStaff == nil or isStaff == "") then
		isStaff = 'Não'
	end

	for k, v in pairs(vipGroups) do
		if (vRP.hasGroup(user_id, v)) then
			if v == 'VipWipe' then 
				currentVips[#currentVips + 1] = 'VIP INAUGURAÇÃO'
			else
				currentVips[#currentVips + 1] = v
			end
		end
	end

	if (identidade[tostring(user_id)]) then 
		avatarURL = identidade[tostring(user_id)].avatarURL
	end

	local org = vRP.getUserGroupByType(user_id, "org")
	if (org == nil or org == "") then
		org = "Não possui"
	end
	
	local spouse = json.decode(identity.relacionamento)

	local status_spouse = 'Solteiro(a)'
	if spouse and spouse.tipo then
		status_spouse = spouse.tipo
	end
	if (not spouse or identity.relacionamento == '{}') then
		spouse = 'Ninguém'
	elseif spouse and spouse.tipo then
		spouse = spouse.tipo..' '..(spouse.name and spouse.name or 'Não encontrado')
	end

	local infos = {
		action = "open",
		image = avatarURL,
		id = user_id,
		name = identity.nome .. " " .. identity.sobrenome,
		rg = identity.registro,
		birth = identity.idade,
		org = org,
		spouse = spouse, -- RETORNA O CONJUNGUE, o nome id ou número.
		status_spouse = status_spouse, -- STATUS CIVIL
		telephone = identity.telefone,
		wallet = vRP.getMoney(user_id),
		bank = vRP.getBankMoney(user_id),
		carry = porte,
		staff = isStaff,
		vips = currentVips,
	}
	return infos
end
