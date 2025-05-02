------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local servico = false
local blips = {}
local zonas = {}
local segundos = 0
local selecionado = 0
local quantidade = 0
local mode = 0

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- INICIAR EMPREGO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local actualRegion = nil
local drogas = {
	["Drogas"] = {
		{ 
			iniciar = vec3(564.57,-1749.05,29.32),
			region = 'sul'
		},
		{ 
			iniciar = vec3(-435.57,6154.45,31.48),
			region = 'norte'
		}
	}
}

Citizen.CreateThread(function()
	while true do
		local time = 1000
		local ped = PlayerPedId()
		local playercoords = GetEntityCoords(ped)
		
		for k,v in pairs(drogas.Drogas) do
			if not servico then
				local distance = #(playercoords - v.iniciar)
				if distance <= 2.0 then
					time = 0
					DrawMarker(2,v.iniciar[1],v.iniciar[2],v.iniciar[3]-0.20, 0,0, 0,0, 0,0, 0.5, 0.4, 0.5, 229, 35, 149, 80, 1, 0, 0, 0)

					if IsControlJustReleased(1, 51) and segundos <= 0 and checkInService() and vSERVER.cooldowndrogas() then
						segundos = 10
						SendNUIMessage({ showmenu = true })
						local double = vSERVER.checkFarmBoost()
						SendNUIMessage({
							action = 'setRouteBuffed',
							route = double
						})
						SetNuiFocus(true, true)
						actualRegion = v.region
					end
				end
			end
		end

		Citizen.Wait(time)
	end
end)

RegisterNUICallback("closeNui", function()
	SetNuiFocus(false, false)
	actualRegion = nil
end)

RegisterNUICallback("security", function()
	servico = true
	mode = actualRegion == 'norte' and 2 or 1
	selecionado = 0
	zonas = carregarZonas("Drogas", false, actualRegion)
	if vSERVER.checkFarmBoost() then 
		SendNUIMessage({
			action = 'setRouteBuffed',
			route = actualRegion == 'sul' and 'south' or 'north'
		})
	else
		SendNUIMessage({
			action = 'setRouteBuffed',
			route = 'vaisefudepdr'
		})
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ZONAS DE VENDA
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local time = 1000

		if servico and selecionado >= 1 and segundos <= 0 then
			local ped = PlayerPedId()
			local playercoords = GetEntityCoords(ped)
			
			local distance = #(playercoords - vec3(zonas[selecionado].coords[1],zonas[selecionado].coords[2],zonas[selecionado].coords[3]))
			if distance <= 60.0 then
				time = 5
				DrawMarker(21,zonas[selecionado].coords[1],zonas[selecionado].coords[2],zonas[selecionado].coords[3],0,0,0,0,180.0,130.0,1.0,1.0,0.5, 25,140,255,180 ,1,0,0,1)

				if distance <= 1.5 then
					drawTxt("Aperte ~b~E~w~ para entregar a droga",0.5,0.96)
					if IsControlJustReleased(1, 51) and segundos <= 0 and not IsPedInAnyVehicle(PlayerPedId()) and vSERVER.checkItems(quantidade) then
						if payment("Drogas", quantidade, selecionado, mode) then
							segundos = 0

							vRP._playAnim(false,{{"mp_common","givetake1_a"}},true)
							TriggerEvent("progress",5,"Vendendo")

							--SetTimeout(5*1000, function()
							--	ClearPedTasks(GetPlayerPed(-1))
							--	
							--	selecionado = 0
							--	quantidade = 0
							--	RemoveBlip(blips)
							--end)
							SetTimeout(5*1000, function()
								ClearPedTasks(GetPlayerPed(-1))
								
								-- if mode > 1 then
								-- 	selecionado = 0
								-- end

								quantidade = 0
								RemoveBlip(blips)
							end)
						end
					end
				end
			end
		end

		Citizen.Wait(time)
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EM SERVIÇO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local time = 1000
		if servico then
			time = 5
			if mode > 1 then
				drawTxt("~r~(ARRISCADA) ~w~Aperte ~r~F7~w~ se deseja finalizar o expediente.\nEntregue as ~y~drogas~w~.", 0.215,0.94)
			else
				drawTxt("~g~(SEGURA) ~w~Aperte ~r~F7~w~ se deseja finalizar o expediente.\nEntregue as ~y~drogas~w~.", 0.215,0.94)
			end
			

			if IsControlJustPressed(0, 168) and not IsPedInAnyVehicle(PlayerPedId()) then
				servico = false
				selecionado = 0
				quantidade = 0
				mode = 0
				RemoveBlip(blips)
				sairServico()
				-- exports["mirtin_inventory"]:checkdrogas(false)

			end
		end
		
		Citizen.Wait(time)
	end
end)

--Citizen.CreateThread(function()
--	while true do
--		local time = math.random(1000,5000)
--
--        if servico and quantidade <= 0 then
--            selecionado = math.random(38)
--            quantidade = math.random(2,6)
--            TriggerEvent("Notify","importante","Estamos precisando de <b>"..quantidade.."x</b> dessa sua parada ai., traga o mais rapido possivel!.", 5)
--            CriandoBlip(selecionado)
--		end
--
--		Citizen.Wait(time)
--	end
--end)

Citizen.CreateThread(function()
	while true do
		local old_selecionado = 0
		local time = math.random(1000,5000)

        if servico and quantidade <= 0 and (mode == 1 or mode == 2) then
			selecionado = selecionado + 1
			if selecionado == #zonas then
				selecionado = 1
			end
            quantidade = math.random(1,5)
            TriggerEvent("Notify","importante","Estamos precisando de <b>"..quantidade.."x</b> dessa sua parada ai., traga o mais rapido possivel!.", 5)
            CriandoBlip(selecionado)
		elseif servico and quantidade <= 0 and (mode == 1 or mode == 2) then 
			old_selecionado = selecionado
            selecionado = math.random(#zonas)

			while old_selecionado == selecionado do
				selecionado = math.random(#zonas)
				Wait(1000)
			end

            quantidade = math.random(1,5)
            TriggerEvent("Notify","importante","Estamos precisando de <b>"..quantidade.."x</b> dessa sua parada ai., traga o mais rapido possivel!.", 5)
            CriandoBlip(selecionado)
		end

		Citizen.Wait(time)
	end
end)

Citizen.CreateThread(function()
	while true do
		local time = 1000
		if segundos >= 0 then
			segundos = segundos - 1

			if segundos <= 0 then
				segundos = 0
			end
		end
		Citizen.Wait(time)
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CriandoBlip(selecionado)
	blips = AddBlipForCoord(zonas[selecionado].coords[1],zonas[selecionado].coords[2],zonas[selecionado].coords[3])
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Droga")
	EndTextCommandSetBlipName(blips)
end