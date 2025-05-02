local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_farms",src)
vSERVER = Tunnel.getInterface("vrp_farms")

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local isOpenned = false
local blips = {}
local in_rota = false
local itemRoute = ""
local itemName = ""
local bancadaName = ""
local itemAmountRoute = 0
local itemMinAmountRoute = 0
local itemMaxAmountRoute = 0
local itemNumRoute = 0
local segundos = 0


RegisterNUICallback('dev_tools', function(data, cb)
    vSERVER._DevTools()
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MENUS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function openNui(bancada, itens, bBancada)
	if not isOpenned then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true, bancada = bancada, itens = itens,  bancadaName = bBancada })
		isOpenned = true
	end
end

RegisterNUICallback("closeNui", function(data, cb)
	if isOpenned then
		SetNuiFocus(false, false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
		isOpenned = false
	end
end)

RegisterNUICallback("fabricarItem", function(data, cb)
	vSERVER.fabricarItem(data.item, data.minAmount, data.maxAmount, data.bancada,data.direction)
end)

function src.closeNui()
	SetNuiFocus(false, false)
	TransitionFromBlurred(1000)
	SendNUIMessage({ hidemenu = true })
	isOpenned = false
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR MENU
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local time = 1000
		if not isOpenned and not in_rota then 
			for k,v in pairs(cfg.initRoutesPositions)  do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(v.coords[1],v.coords[2],v.coords[3])
				local distance = GetDistanceBetweenCoords(v.coords[1],v.coords[2],cdz,x,y,z,true)

				if distance <= 1.5 then
					DrawText3D(v.coords[1],v.coords[2],v.coords[3], v.text)
					time = 5
					if IsControlJustPressed(0,38) and vSERVER.checkPermission(v.perm) then
						local bName,bItens,bBancada = vSERVER.requestBancada(v.type)
						if bName and bItens then
							openNui(bName,bItens,bBancada)
						end
					end
				end
				
			end
		end

		Citizen.Wait(time)
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ROTAS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.iniciarRota(item, itemName2, minAmount, maxAmount, bancada,direction)
	if not in_rota then
		in_rota = true
		itemNumRoute = 1
		bancadaName = bancada
		itemRoute = item
		itemName = itemName2
		itemMinAmountRoute = minAmount
		itemMaxAmountRoute = maxAmount
		itemAmountRoute = math.random(itemMinAmountRoute,itemMaxAmountRoute)
		--exports["lotus-hud"]:setMinimapActive(true)

		CriandoBlip(itemNumRoute, bancadaName,direction)

		async(function()
			while in_rota do
				local time = 1000
				local ped = PlayerPedId()
				local pedCoords = GetEntityCoords(ped)
				-- if bancadaName == "ILHA" then
				-- 	local distance = #(pedCoords - cfg.ilhaRoutes[parseInt(itemNumRoute)].coords)
				-- 	if distance <= 15.0 then
				-- 		time = 5
				-- 		DrawMarker(21,cfg.ilhaRoutes[parseInt(itemNumRoute)].coords[1],cfg.ilhaRoutes[parseInt(itemNumRoute)].coords[2],cfg.ilhaRoutes[parseInt(itemNumRoute)].coords[3],0,0,0,0,180.0,130.0,1.0,1.0,0.5, 25,140,255,180 ,1,0,0,1)

				-- 		if distance <= 2.0 then
				-- 			if IsControlJustReleased(1, 51) and segundos <= 0 and not IsPedInAnyVehicle(PlayerPedId()) then 
				-- 				segundos = 5

				-- 				if vSERVER.giveItem(itemRoute, parseInt(itemAmountRoute)) then
				-- 					itemNumRoute = itemNumRoute + 1

				-- 					if itemNumRoute > #cfg.ilhaRoutes then
				-- 						itemNumRoute = 1
				-- 					end

				-- 					itemAmountRoute = math.random(itemMinAmountRoute,itemMaxAmountRoute)
				-- 					RemoveBlip(blips)
				-- 					CriandoBlip(itemNumRoute, bancadaName)
				-- 				end
				-- 			end
				-- 		end
				-- 	end
				-- elseif bancadaName == "BENNYS" then
				-- 	local distance = #(pedCoords - cfg.bennysRoutes[parseInt(itemNumRoute)].coords)
				-- 	if distance <= 15.0 then
				-- 		time = 5
				-- 		DrawMarker(21,cfg.bennysRoutes[parseInt(itemNumRoute)].coords[1],cfg.bennysRoutes[parseInt(itemNumRoute)].coords[2],cfg.bennysRoutes[parseInt(itemNumRoute)].coords[3],0,0,0,0,180.0,130.0,1.0,1.0,0.5, 25,140,255,180 ,1,0,0,1)

				-- 		if distance <= 2.0 then
				-- 			if IsControlJustReleased(1, 51) and segundos <= 0 and not IsPedInAnyVehicle(PlayerPedId()) then 
				-- 				segundos = 5

				-- 				if vSERVER.giveItem(itemRoute, parseInt(itemAmountRoute)) then
				-- 					itemNumRoute = itemNumRoute + 1

				-- 					if itemNumRoute > #cfg.bennysRoutes then
				-- 						itemNumRoute = 1
				-- 					end

				-- 					itemAmountRoute = math.random(itemMinAmountRoute,itemMaxAmountRoute)
				-- 					RemoveBlip(blips)
				-- 					CriandoBlip(itemNumRoute, bancadaName)
				-- 				end
				-- 			end
				-- 		end
				-- 	end
				-- else


					if direction == "north" then
						routeIndexed = cfg.northRoutes
						indexedCoords = cfg.northRoutes[parseInt(itemNumRoute)].coords
						distance = #(pedCoords - indexedCoords)
					elseif direction == "south" then
						routeIndexed = cfg.southRoutes
						indexedCoords = cfg.southRoutes[parseInt(itemNumRoute)].coords
						distance = #(pedCoords - indexedCoords)
					else
						routeIndexed = cfg.allRoutes
						indexedCoords = cfg.allRoutes[parseInt(itemNumRoute)].coords
						distance = #(pedCoords - indexedCoords)
					end
					if distance <= 15.0 then
						time = 5
						DrawMarker(21,indexedCoords[1],indexedCoords[2],indexedCoords[3],0,0,0,0,180.0,130.0,1.0,1.0,0.5, 25,140,255,180 ,1,0,0,1)

						if distance <= 2.0 then
							if IsControlJustReleased(1, 51) and segundos <= 0 and not IsPedInAnyVehicle(PlayerPedId()) then 
								segundos = 5

								if vSERVER.giveItem(itemRoute, parseInt(itemAmountRoute), parseInt(itemNumRoute),bancadaName,direction) then
									vRP._playAnim(false,{{"pickup_object","pickup_low"}},false)
									itemNumRoute = itemNumRoute + 1
									if itemNumRoute > #routeIndexed then
										itemNumRoute = 1
									end

									itemAmountRoute = math.random(itemMinAmountRoute,itemMaxAmountRoute)
									RemoveBlip(blips)
									CriandoBlip(itemNumRoute, bancadaName, direction)
								end
							end
						end
					end
				-- end

				Citizen.Wait(time)
			end
		end)
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EM SERVIÇO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local time = 1000
		if in_rota then
			time = 5
			drawTxt("~w~Aperte ~r~F7~w~ se deseja finalizar a entrega.\nColete ~y~"..itemAmountRoute.."x "..itemName.."~w~.", 0.215,0.94)

			if IsControlJustPressed(0, 168) and not IsPedInAnyVehicle(PlayerPedId()) then
				in_rota = false
				itemRoute = ""
				itemName = ""
				itemAmountRoute = 0
				itemNumRoute = 0
				RemoveBlip(blips)
				--exports["lotus-hud"]:setMinimapActive(false)
			end
		end
		
		Citizen.Wait(time)
	end
end)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE DESMANCHE
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local segundos2 = 0
local desmanchando = false
local locations = {

	{ coords = vec3(1030.12,-140.08,74.32), range = 10.0, permission = "perm.desmanche" }, -- Motoclube
	{ coords = vec3(-229.49,-1324.61,30.89), range = 10.0, permission = "perm.desmanche" }, -- Bennys
	{ coords = vec3(-1560.13,-390.79,41.97), range = 10.0, permission = "perm.desmanche" }, -- Cohab
	{ coords = vec3(-1546.93,-413.43,41.99), range = 10.0, permission = "perm.baucohab" }, -- Cohab
	{ coords = vec3(-1162.56,-1703.96,4.75), range = 10.0, permission = "perm.desmanche" }, -- Baixada
	{ coords = vec3(86.87,-1970.34,20.74), range = 10.0, permission = "perm.desmanche" }, -- Roxos
	{ coords = vec3(1358.31,-2553.23,48.39), range = 10.0, permission = "perm.desmanche" }, -- Escocia

	{ coords = vec3(-1143.45,-1691.36,4.75), range = 10.0, permission = "perm.desmanche" }, -- CDD
	{ coords = vec3(730.05,-1088.5,22.16), range = 10.0, permission = "perm.desmanche" }, -- Lacoste
	{ coords = vec3(-233.11,-1325.57,30.89), range = 10.0, permission = "perm.desmanche" }, -- Bennys	
	{ coords = vec3(1027.76,-2519.57,28.29), range = 10.0, permission = "perm.desmanche" }, -- HellsAngels
	{ coords = vec3(1458.27,-2548.8,51.91), range = 10.0, permission = "perm.desmanche" }, -- Escocia

}

function src.returnLocations()
	return locations
end

Citizen.CreateThread(function()
    while true do
    local time = 1000
    local ped = PlayerPedId()
	local pedCoords = GetEntityCoords(ped)
		for k,v in pairs(locations) do
			local distance = #(pedCoords - v.coords)
			if distance <= v.range then
				if not desmanchando and not IsPedInAnyVehicle(ped) then
					time = 5

					local veh = getVehicleRadius(5)
					local coordsVehicle = GetOffsetFromEntityInWorldCoords(veh, 0.0, 0.0, 1.0)
					local distanceVeh = GetDistanceBetweenCoords(pedCoords, coordsVehicle.x,coordsVehicle.y,coordsVehicle.z,true)
					if distanceVeh <= 2.0 then
						time = 5
						DrawText3Ds2(coordsVehicle.x,coordsVehicle.y,coordsVehicle.z,"Pressione [~b~E~w~] para desmanchar esse veiculo.")
						if IsControlJustReleased(1, 51) and segundos2 <= 0 and vSERVER.checkPermission(v.permission) then
							segundos2 = 0
							local mPlaca,mName,mNet,mPortaMalas,mPrice,mLock,mModel = vRP.ModelName(5) 
							desmancharVeiculo(veh,mPlaca,mName,mNet,mPortaMalas,mPrice,mLock,mModel)
                            -- exports['bm_module']:setInDesmanche(true)

						end
					end

				end
			end
		end
        Citizen.Wait(time)
    end
end)

function desmancharVeiculo(veh,mPlaca,mName,mVeh,mPortaMalas,mPrice,mLock,mModel)
    local ped = PlayerPedId()
    local time = 0
    if vSERVER.checkVehicleStatus(mPlaca,mName, VehToNet(veh)) then
        -- if vSERVER.checkItensD() then
            desmanchando = true
            vRP._playAnim(false,{{"mini@repair","fixing_a_player"}},true)
            async(function()
                while desmanchando do
                    Citizen.Wait(1000)
                    time = time+1

                    if time == 1 then
                        TriggerEvent("progress",40,"desmanchando")
                    elseif time == 5 then
                        SetVehicleUndriveable(veh, true)
                        SetVehicleDoorsLocked(veh,2)
                        SetVehicleAlarmTimeLeft(veh,30*1000)
                    elseif time == 10 then
                        SetVehicleColours(veh, 101 , 101)
                    elseif time == 15 then
                        SetVehicleTyreBurst(veh, 0, true, 1000)
                    elseif time == 20 then
                        SetVehicleTyreBurst(veh, 1, true, 1000)
                    elseif time == 25 then
                        SetVehicleTyreBurst(veh, 4, true, 1000)
                    elseif time == 28 then
                        SetVehicleTyreBurst(veh, 5, true, 1000)
                        vRP._playAnim(false,{task="WORLD_HUMAN_WELDING"},false)
                    elseif time == 33 then

                        SetVehicleDoorBroken(veh, 0, true)
                        SetVehicleDoorBroken(veh, 2, true)
                    elseif time == 35 then
                        SetVehicleDoorBroken(veh, 1, true)
                        SetVehicleDoorBroken(veh, 3, true)

                    elseif time == 38 then
                        SetVehicleDoorBroken(veh, 4, true)
                    elseif time == 39 then
                        SetVehicleDoorBroken(veh, 5, true)
                    elseif time == 40 then
                        
                        desmanchando = false
                        time = 0
                        vSERVER.pagarDesmanche(mPlaca,mName,mPrice,VehToNet(veh))
                        vRP._stopAnim(false)
                        -- exports['bm_module']:setInDesmanche(false)

                    end
            
                end
            end)
        -- end
	end
end


function getVehicleRadius(radius)
	local veh
	local vehs = getVehiclesRadius(radius)
	local min = radius+0.0001
	for _veh,dist in pairs(vehs) do
		if dist < min then
			min = dist
			veh = _veh
		end
	end
	return veh
end

function getVehiclesRadius(radius)
	local r = {}
	local px,py,pz = table.unpack(GetEntityCoords(PlayerPedId()))

	local vehs = {}
	local it,veh = FindFirstVehicle()
	if veh then
		table.insert(vehs,veh)
	end
	local ok
	repeat
		ok,veh = FindNextVehicle(it)
		if ok and veh then
			table.insert(vehs,veh)
		end
	until not ok
	EndFindVehicle(it)

	for _,veh in pairs(vehs) do
		local x,y,z = table.unpack(GetEntityCoords(veh,true))
		local distance = GetDistanceBetweenCoords(x,y,z,px,py,pz,true)
		if distance <= radius then
			r[veh] = distance
		end
	end
	return r
end


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x, y, z, text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end


function DrawText3Ds2(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end

function drawTxt(text,x,y)
	local res_x, res_y = GetActiveScreenResolution()

	SetTextFont(4)
	SetTextScale(0.3,0.3)
	SetTextColour(255,255,255,255)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)

	if res_x >= 2000 then
		DrawText(x+0.076,y)
	else
		DrawText(x,y)
	end
end

function CriandoBlip(selecionado, bancada,direction)
	if bancada == "ILHA" then
		blips = AddBlipForCoord(cfg.ilhaRoutes[parseInt(selecionado)].coords[1],cfg.ilhaRoutes[parseInt(selecionado)].coords[2],cfg.ilhaRoutes[parseInt(selecionado)].coords[3])
		SetBlipSprite(blips,1)
		SetBlipColour(blips,5)
		SetBlipScale(blips,0.4)
		SetBlipAsShortRange(blips,false)
		SetBlipRoute(blips,true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Coleta")
		EndTextCommandSetBlipName(blips)
	elseif bancada == "BENNYS" then
		blips = AddBlipForCoord(cfg.bennysRoutes[parseInt(selecionado)].coords[1],cfg.bennysRoutes[parseInt(selecionado)].coords[2],cfg.bennysRoutes[parseInt(selecionado)].coords[3])
		SetBlipSprite(blips,1)
		SetBlipColour(blips,5)
		SetBlipScale(blips,0.4)
		SetBlipAsShortRange(blips,false)
		SetBlipRoute(blips,true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Coleta")
		EndTextCommandSetBlipName(blips)
	elseif direction == "north" then
		blips = AddBlipForCoord(cfg.northRoutes[parseInt(selecionado)].coords[1],cfg.northRoutes[parseInt(selecionado)].coords[2],cfg.northRoutes[parseInt(selecionado)].coords[3])
		SetBlipSprite(blips,1)
		SetBlipColour(blips,5)
		SetBlipScale(blips,0.4)
		SetBlipAsShortRange(blips,false)
		SetBlipRoute(blips,true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Coleta")
		EndTextCommandSetBlipName(blips)
	elseif direction == "south" then
		blips = AddBlipForCoord(cfg.southRoutes[parseInt(selecionado)].coords[1],cfg.southRoutes[parseInt(selecionado)].coords[2],cfg.southRoutes[parseInt(selecionado)].coords[3])
		SetBlipSprite(blips,1)
		SetBlipColour(blips,5)
		SetBlipScale(blips,0.4)
		SetBlipAsShortRange(blips,false)
		SetBlipRoute(blips,true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Coleta")
		EndTextCommandSetBlipName(blips)
	else
		blips = AddBlipForCoord(cfg.allRoutes[parseInt(selecionado)].coords[1],cfg.allRoutes[parseInt(selecionado)].coords[2],cfg.allRoutes[parseInt(selecionado)].coords[3])
		SetBlipSprite(blips,1)
		SetBlipColour(blips,5)
		SetBlipScale(blips,0.4)
		SetBlipAsShortRange(blips,false)
		SetBlipRoute(blips,true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Coleta")
		EndTextCommandSetBlipName(blips)
	end
end

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