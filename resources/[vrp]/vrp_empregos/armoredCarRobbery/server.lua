local robberiesInUse = {}
local allowedPayments = {}
local cooldownPlayers = {}

local pedsSpawned = {}
local carsSpawned = {}

local userIdInService = {}

--[ LOCAL FUNCTION MANAGEMENT ]

local function checkRobberiesAvailables()
	local user_id = vRP.getUserId(source)
	local accountantRobberys = 0

	if cooldownPlayers[user_id] then
		if os.time() - cooldownPlayers[user_id] <= Config.cooldownIniteRobbery then
			local seconds = Config.cooldownIniteRobbery - (os.time() - cooldownPlayers[user_id])
			TriggerClientEvent("Notify",source,"importante","Aguarde "..seconds.." Segundos antes de iniciar outro roubo.")
			return
		end
	end

	for i = 1, #Config.randomJobs do
		if not robberiesInUse[i] then
			accountantRobberys = accountantRobberys + 1
		end
	end
	
	if accountantRobberys <= 0 then
		return false
	end

	return true
end

--[ CHECK AVALIABLE ROBBERYS AND COOLDOWN ]--

function src.initeRobbery()
	local user_id = vRP.getUserId(source)
	local accountantRobberys = checkRobberiesAvailables()

	if not accountantRobberys then
		return false
	end

	local avaliableRobbery = false

	while not avaliableRobbery do
		indexRobbery = math.random(1,#Config.randomJobs)
		if not robberiesInUse[indexRobbery] then
			robberiesInUse[indexRobbery] = user_id
			avaliableRobbery = true
		end

		Wait(100)
	end

	--[ PROTECTION ]--

	allowedPayments[user_id] = true
	cooldownPlayers[user_id] = os.time()

	return true,indexRobbery
end

--[ PAYMENT FUNCTION PROTECT ]--

function src.finishRobberyPayment()
	local user_id = vRP.getUserId(source)

	if not allowedPayments[user_id] then
		print("Possivel Re-Run de eventos")
		return
	end

	for k,v in pairs (Config.rewardsItens) do
		local chance = math.random(100)
		if chance <= v.chance then
			local amount = math.random(v.min,v.max)
			vRP.giveInventoryItem(user_id,v.item,amount,true)
		end
	end

	allowedPayments[user_id] = false

end

--[ ALERT POLICE ]--

function src.alertPolices(coords)
	if Config.notifyPolice then
		exports['vrp']:alertPolice({ x = coords[1], y = coords[2], z = coords[3], blipID = 161, blipColor = 63, blipScale = 0.5, time = 30, code = "911", title = "Carro Forte", name = "Rota de carro forte iniciada, faça a escolta dos motoristas e da carga." })
	end
end

--[ DELETE ENTITYS SYNC SERVER-SIDE ]--

function src.deleteEntitys(vehicle,tablePeds,indexRobbery)
	local source = source
	local user_id = vRP.getUserId(source)
	print("DELETE ENTITYS")
	print(user_id)
	-- if vehicle then
	-- 	local entityServer = NetworkGetEntityFromNetworkId(vehicle)

	-- 	if DoesEntityExist(entityServer) then
	-- 		DeleteEntity(entityServer)
	-- 		carsSpawned[user_id] = nil
	-- 	end
	-- end
	
	-- if tablePeds then
	-- 	for k,v in pairs (tablePeds) do
	-- 		if DoesEntityExist(NetworkGetEntityFromNetworkId(v)) then
	-- 			DeleteEntity(NetworkGetEntityFromNetworkId(v))
	-- 		end
	-- 	end
	-- 	pedsSpawned[user_id] = nil
	-- end

	if robberiesInUse[indexRobbery] then
		robberiesInUse[indexRobbery] = false
	end

	if userIdInService[source] then
		userIdInService[source] = nil
	end
end

--[ DELETE ENTITYS SYNC SERVER-SIDE ]--

function src.registerEntitys(vehicle,tablePeds,indexRobbery)
	local source = source
	local user_id = vRP.getUserId(source)

	if vehicle then
		local entityServer = NetworkGetEntityFromNetworkId(vehicle)
		carsSpawned[user_id] = entityServer
	end
	
	if tablePeds then
		local pedsServer = {}
		for k,v in pairs (tablePeds) do
			local ped = NetworkGetEntityFromNetworkId(v)
			pedsServer[ped] = true
		end
		pedsSpawned[user_id] = pedsServer
	end

	if indexRobbery then
		userIdInService[source] = indexRobbery
	end
end

--[ PLAYER DROPPED ]--

AddEventHandler('playerDropped', function (reason)
	local source = source
	if userIdInService[source] then
		local user_id = vRP.getUserId(source)
		if pedsSpawned[user_id] then
			for k,v in pairs (pedsSpawned[user_id]) do
				if DoesEntityExist(k) then
					DeleteEntity(k)
				end
			end
			pedsSpawned[user_id] = nil
		end
	
		if carsSpawned[user_id] then
			if DoesEntityExist(carsSpawned[user_id]) then
				DeleteEntity(carsSpawned[user_id])
				carsSpawned[user_id] = nil
			end
		end
	
		for k,v in pairs (robberiesInUse) do
			if v == user_id then
				robberiesInUse[user_id] = false
			end
		end
	end
end)