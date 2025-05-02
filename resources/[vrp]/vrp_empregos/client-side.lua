local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_empregos",src)
vSERVER = Tunnel.getInterface("vrp_empregos")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local zonas = {}
local blips = {}
local namedServico = nil
local veiculoS = 0
local veiculoS2 = 0
local actualService = nil
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR EM SERVICO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function checkInService()
	if namedServico == nil then
		return true
	else
		TriggerEvent("Notify","importante","Você precisa sair do serviço atual para iniciar outro.", 5)
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR ZONAS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function carregarZonas(tipo,blip, zone)
    if cfg.config[tipo] then
		if zone then 
			actualService = zone
			zonas = cfg.config[tipo].rotas[zone]
		else
			actualService = nil
			zonas = fg.config[tipo].rotas
		end
		namedServico = tipo

		for k,v in pairs(zonas) do
			zonas[k] = { coords = v.coords, visivel = true }
		end

        if blip then
            for k,v in pairs(zonas) do
				if v.visivel then
					blips[k] = AddBlipForCoord(v.coords[1],v.coords[2],v.coords[3])
					SetBlipSprite(blips[k], 1)
					SetBlipAsShortRange(blips[k] ,true)
					SetBlipColour(blips[k] ,5)
					SetBlipScale(blips[k], 0.3)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString("Coleta")
					EndTextCommandSetBlipName(blips[k])
				end
            end
        end

        return zonas
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER BLIPS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function removeBlips()
	if #blips > 0 then
		local i = 0
		while i <= #blips do
			RemoveBlip(blips[i])
			i = i + 1
		end
	end
end

function removeToBlip(id)
	if blips[id] then
		RemoveBlip(blips[id])
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CRIAR VEICULO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function criarVehicle(x,y,z,h,veiculo, extra)
	local allowedVehicles = {
		["tractor2"] = true,
		["ajmbox"] = true,
		["tractor2"] = true,
		["phantom"] = true,
		["trailerlogs"] = true,
		["trash3"] = true,
		["tiptruck"] = true,
		["bus"] = true,
		["dinghy"] = true,
		["taxi"] = true,
		["rebel"] = true
	}
	if not allowedVehicles[veiculo:lower()] then
		TriggerServerEvent("vrp_empregos:DASUDUNADNBWBd")
		return
	end
	local checkPos = GetClosestVehicle(x,y,z,3.001,0,71)
	if DoesEntityExist(checkPos) and checkPos ~= nil then
		TriggerEvent("Notify","importante","Todas as vagas estão ocupadas no momento.", 5)
		return false
	else
		if veiculo then
			local mhash = GetHashKey(veiculo)
			while not HasModelLoaded(mhash) do
				RequestModel(mhash)
				Citizen.Wait(10)
			end

			if HasModelLoaded(mhash) then
				local nveh = CreateVehicle(mhash,x,y,z,h,true,false)

				SetVehicleOnGroundProperly(nveh)
				SetVehicleNumberPlateText(nveh, vSERVER.checkPlate())
				SetEntityAsMissionEntity(nveh,true,true)
				SetModelAsNoLongerNeeded(mhash)

				if extra then
					veiculoS2 = nveh
				else
					veiculoS = nveh
				end
				
			end
		end
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DELETAR VEICULO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function deletarVehicle()
	if veiculoS > 0 then
		TriggerServerEvent("bm_module:deleteVehicles", VehToNet(veiculoS))
		veiculoS = 0
	end

	if veiculoS2 > 0 then
		TriggerServerEvent("bm_module:deleteVehicles", VehToNet(veiculoS2))
		veiculoS2 = 0
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SAIR DE SERVICO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function sairServico()
	namedServico = nil
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTOS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.checkInServico()
	return namedServico
end

function payment(tipo, quantidade, selecionado, mode)
	return vSERVER.payment(tipo, quantidade, selecionado, mode, actualService)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OUTRAS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

function DrawText3Ds(x,y,z,text)
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
