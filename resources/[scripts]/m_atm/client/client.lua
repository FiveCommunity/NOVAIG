local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
serverAPI = Tunnel.getInterface(GetCurrentResourceName())
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local timeRobbery = 0
local inExecution = false
local modelThermal = GetHashKey("hei_prop_heist_thermite_flash")
local modelBag = GetHashKey('p_ld_heist_bag_s_pro_o')
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISH ROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
local function onFinishRobberys(robberyId)
	vRP._stopAnim()
	timeRobbery = 0
	inExecution = false
	serverAPI.onRobberyEnd(robberyId)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISH ROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	Citizen.Wait(500)

	RegisterKeyMapping("cancelRobbery", "Cancelar Roubo", "keyboard", "M")
	RegisterCommand("cancelRobbery", function(_, args, rawCommand)
		if inExecution then 
			onFinishRobberys(nil)
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 1000
		local playerPed = PlayerPedId()
		if not inExecution and GetEntityHealth(playerPed) > 101 then 
			if not IsPedInAnyVehicle(playerPed) and GetSelectedPedWeapon(playerPed) == GetHashKey("WEAPON_UNARMED") then 
				local playerCoords = GetEntityCoords(playerPed)
				for k,v in pairs(coordsRobberys) do 
					local playerDistance = #(playerCoords - vec3(v.coords.x,v.coords.y,v.coords.z))
					if playerDistance <= 1 then 
						timeDistance = 0
						drawTxt("PRESSIONE  ~r~G~w~  PARA INICIAR O ROUBO",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(0,47) and serverAPI.startRobbery(k,coordsRobberys[k].requires) then
							timeRobbery = v.time
							inExecution = true
							--[[IR ATÉ O CAIXA PRA PLANTAR]]
							local nearDistance = #(playerCoords - vec3(v.coords.x,v.coords.y,v.coords.z))
							if nearDistance <= 3 then
								TaskGoStraightToCoord(playerPed, v.coords.x, v.coords.y, v.coords.z , 1.0, 100000, v.coords.w, 2.0)
								if nearDistance <= 0.3 then
								  	ClearPedTasks(playerPed)
								  	SetEntityHeading(playerPed, v.coords.w)
								end
							end

							--[[AI AQUI É BOA BOA]]


							LoadModel(modelThermal)
							Citizen.Wait(10)
							LoadModel(modelBag)
							Citizen.Wait(10)

							local entityThermal = CreateObject(modelThermal, (v.coords.x + v.coords.y + v.coords.z)-20, true, true)
							local bagProp4 = CreateObject(modelBag, playerCoords-20, true, false)
							SetEntityAsMissionEntity(entityThermal, true, true)
							SetEntityAsMissionEntity(bagProp4, true, true)

							local boneIndexf1 = GetPedBoneIndex(playerPed, 28422)
							local bagIndex1 = GetPedBoneIndex(playerPed, 57005)
							Citizen.Wait(500)

							AttachEntityToEntity(entityThermal, playerPed, boneIndexf1, 0.0, 0.0, 0.0, 180.0, 180.0, 0, 1, 1, 0, 1, 1, 1)
							AttachEntityToEntity(bagProp4, playerPed, bagIndex1, 0.3, -0.25, -0.3, 300.0, 200.0, 300.0, true, true, false, true, 1, true)


							RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
							while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge') do
								Wait(100)
							end

							vRP._playAnim(false,{{'anim@heists@ornate_bank@thermal_charge','thermal_charge'}},false)


							Citizen.Wait(2500)
							DetachEntity(bagProp4, 1, 1)
							FreezeEntityPosition(bagProp4, true)
							Citizen.Wait(2500)
							FreezeEntityPosition(bagProp4, false)
							AttachEntityToEntity(bagProp4, playerPed, bagIndex1, 0.3, -0.25, -0.3, 300.0, 200.0, 300.0, true, true, false, true, 1, true)
							Citizen.Wait(1000)
							DeleteEntity(bagProp4)

							DeleteEntity(entityThermal)
							ClearPedTasks(playerPed)
							
							TriggerEvent("vrp_sound:distance", GetPlayerServerId(PlayerId()), 0.8, 'bomb_25', 0.5)
							TriggerEvent("Notify","importante","A Bomba irá explodir em 5 segundos, se afaste...")

							Citizen.Wait(5000)

							serverAPI._policeAlert()
							AddExplosion(v.coords.x,v.coords.y,v.coords.z,2 , 100.0, true, false, true, false)


							if GetEntityHealth(playerPed) <= 101 or not inExecution then 
								onFinishRobberys(k)
							end
							
							Citizen.CreateThread(function()
								local announceSound = 0		
								while announceSound <= timeRobbery and inExecution do
									local distanceAtm = #(GetEntityCoords(playerPed) - vec3(v.coords.x, v.coords.y, v.coords.z))
									if distanceAtm <= 15 then 
										TaskGoStraightToCoord(playerPed, v.coords.x, v.coords.y, v.coords.z , 5.0, 100000, v.coords.w, 2.0)	
										if distanceAtm <= 1.5 then 
											announceSound = announceSound + 1
											vRP._playAnim(false,{{"oddjobs@shop_robbery@rob_till", "loop"}},true)
			
			
											local response = serverAPI.paymentRobbery(k,coordsRobberys[k].coords)
											if not response then 
												onFinishRobberys(k)
												break
											end
										end
									end
									Citizen.Wait(1000)
								end
							end)
	

						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOAD MODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadModel(model)
    Citizen.CreateThread(function()
        while not HasModelLoaded(model) do
            RequestModel(model)
          	Citizen.Wait(1)
        end
    end)
end
