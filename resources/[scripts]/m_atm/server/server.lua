local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
cO = {}
Tunnel.bindInterface(GetCurrentResourceName(),cO)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local paymentRobberys = {}
local cooldownAtms = {}
local playerInRobbery = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function cO.startRobbery(robberyId,robberyConfig)
	local source = source
	local userId = vRP.getUserId(source)
	if not userId then return end 

	if not robberyId or not robberyConfig then return end

	for _,v in pairs(playerInRobbery) do  
		if robberyId == v then
			TriggerClientEvent("Notify",source,"negado","O roubo já está ocorrendo.",5)
			return false
		end
	end

	
	local status, time = exports['vrp']:getCooldown(userId, "atmRobbery")
	if not status then
		TriggerClientEvent("Notify",source,"negado","Aguarde "..displayTimePlayed(time).." para efetuar outro roubo.",5)
		return false
	end
	

	if cooldownAtms[robberyId] and cooldownAtms[robberyId] >= os.time() then 
		TriggerClientEvent("Notify",source,"negado","O caixa está vazio, será reabastecido em "..displayTimePlayed((cooldownAtms[robberyId] - os.time())),5)	
		return false
	end

	local policesAmount = vRP.getUsersByPermission("perm.policia")
	if (#policesAmount or 0) < coordsRobberys[robberyId].polices then 
		TriggerClientEvent("Notify",source,"negado","Não existem policiais suficientes em serviço.",5)
		return false
	end
	
	local userItem = vRP.getInventoryItemAmount(userId, robberyConfig.item) >= robberyConfig.amount or false 
	if not userItem then 
		TriggerClientEvent("Notify",source,"negado","Você não possuí "..robberyConfig.amount.."x <b>"..robberyConfig.item.."</b>  para iniciar o roubo.",5)
		return false
	end


	playerInRobbery[userId] = robberyId 

	exports['vrp']:setCooldown(userId, "atmRobbery", 300)
	vRP.tryGetInventoryItem(userId, robberyConfig.item, robberyConfig.amount)

	return true 
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
function cO.paymentRobbery(robberyId,robberyCoords)
	local source = source
	local userId = vRP.getUserId(source)
	if not userId then return end 

	if not playerInRobbery[userId] then 
		return false 
	end

	if GetEntityHealth(GetPlayerPed(source)) <= 101 then 
		return false
	end
	
	
	local entityCoords = GetEntityCoords(GetPlayerPed(source))
	local entityDistance = #(entityCoords - vec3(robberyCoords.x,robberyCoords.y,robberyCoords.z))
	if entityDistance >= 15 then 
		return false 
	end

	
	if not paymentRobberys[userId] then 
		paymentRobberys[userId] = { max = coordsRobberys[robberyId].reward,  step = parseInt(coordsRobberys[robberyId].reward / coordsRobberys[robberyId].time), balance = 0 }
	end

	paymentRobberys[userId].balance = parseInt(paymentRobberys[userId].balance + paymentRobberys[userId].step)
	if parseInt(paymentRobberys[userId].balance) >= paymentRobberys[userId].max then 
		TriggerClientEvent("Notify",source,"sucesso","O roubo foi concluido. saia do local.",5)
		paymentRobberys[userId] = nil 
		return false 
	end

	vRP.giveInventoryItem(userId, "dirty_money", paymentRobberys[userId].step, true )
	return true 
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINALIZAR ROUBO E SETAR COOLDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
function cO.onRobberyEnd(robberyId)
	local source = source
	local userId = vRP.getUserId(source)
	if not userId then return end 

	if not robberyId then 
		robberyId = playerInRobbery[userId] 
	end 
	
	if not playerInRobbery[userId] then return end 

	cooldownAtms[robberyId] = os.time() + (coordsRobberys[robberyId].cooldown * 60)
	paymentRobberys[userId] = nil 
	playerInRobbery[userId] = nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALERTA DO POLICIA
-----------------------------------------------------------------------------------------------------------------------------------------
function cO.policeAlert()
	local source = source
	local userId = vRP.getUserId(source)
	if not userId then return end 

	if not playerInRobbery[userId] then return end 

	local entityCoords = GetEntityCoords(GetPlayerPed(source))
	if not entityCoords then return end 

	exports['vrp']:alertPolice({ x = entityCoords.x, y = entityCoords.y, z = entityCoords.z, blipID = 161, blipColor = 63, blipScale = 0.5, time = 20, code = "911", title = "Caixa Registradora", name = "O roubo começou no Caixa Eletrônico, dirija-se até o local e intercepte os assaltantes"})
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER LEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	if playerInRobbery[user_id] then 
		playerInRobbery[user_id] = nil 
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UTILS
-----------------------------------------------------------------------------------------------------------------------------------------
function displayTimePlayed(time)
    local days = math.floor(time/86400)
    local hours = math.floor(math.fmod(time, 86400)/3600)
    local minutes = math.floor(math.fmod(time,3600)/60)
    local seconds = math.floor(math.fmod(time,60))
    if days > 0 then
        return string.format("%d dia(s) e %d hora(s)",days,hours)
    elseif hours > 0 then
        return string.format("%d hora(s) e %d minuto(s)",hours,minutes)
    elseif minutes > 0 then        
        return string.format("%d minuto(s) e %d segundos",minutes,seconds)
    else
        return string.format("%d segundos",seconds)
    end
end