
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","mirtin_homes")

src = {}
Tunnel.bindInterface("mirtin_homes",src)
vSERVER = Tunnel.getInterface("mirtin_homes")
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MAIN
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
config = {} -- Não mexer
sv_config = {} -- Não mexer

CreateThread(function()
    sv_config = vSERVER.ServerConfig()
end)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
config.limitZone = 30.0 -- Limite se o player se afastar muito ou nao carregar a casa, teleportar para o blip de entrada.
config.imagemDir = "http://177.54.148.31:4020/veiculos/" -- Diretorio das imagens dos veiculos

config.drawlable = function(id, coords, tipo, porta)
    if tipo == "apartamento" then -- Configure a mensagem / blip que ira aparecer na propriedade
        DrawText3Ds(coords.x, coords.y, coords.z+0.5, "~w~[Propriedade: ~g~"..tonumber(id).."~w~]\n~w~[~g~E~w~] entrar/sair\n~w~[~g~F~w~] comprar")
		DrawMarker(21,coords.x, coords.y, coords.z-0.7,0,0,0,0,0,130.0,0.5,1.0,0.5, 0,255,0,180 ,1,0,0,1)
	elseif tipo == "casa" then -- Configure a mensagem / blip que ira aparecer na propriedade
		if porta then
			DrawText3Ds(coords.x, coords.y, coords.z+0.5, "~w~[PROPRIEDADE: ~g~"..tonumber(id).."~w~]\n~w~[~g~E~w~] entrar/sair\n~w~[~g~L~w~] destrancar\n~w~Porta: ~r~Fechada ")
			DrawMarker(21,coords.x, coords.y, coords.z-0.7,0,0,0,0,0,130.0,0.5,1.0,0.5, 255,0,0,180 ,1,0,0,1)
		else
			DrawText3Ds(coords.x, coords.y, coords.z+0.5, "~w~[PROPRIEDADE: ~g~"..tonumber(id).."~w~]\n~w~[~g~E~w~] entrar/sair\n~w~[~g~L~w~] trancar\n~w~Porta: ~g~Aberta ")
			DrawMarker(21,coords.x, coords.y, coords.z-0.7,0,0,0,0,0,130.0,0.5,1.0,0.5, 0,255,0,180 ,1,0,0,1)
		end
	elseif tipo == "garagem" then
		DrawMarker(36,coords.x, coords.y, coords.z,0,0,0,0,0,130.0,0.5,1.0,0.5, 0,255,0,180 ,1,0,0,1)
	elseif tipo == "armario" then
		DrawMarker(0,coords.x, coords.y, coords.z,0,0,0,0,0,130.0, 0.5,0.5,0.5, 0,255,0,180 ,1,0,0,1)
	elseif tipo == "bau" then
		DrawMarker(30,coords.x, coords.y, coords.z-0.3,0,0,0,0,0,130.0, 0.5,1.0,0.5, 0,255,0,180 ,1,0,0,1)
    end
end

config.lang = {
	trancar = function() return TriggerEvent("Notify","importante","Você <b>trancou</b> a porta.", 5) end, -- Notificacao quando a porta trancar
	destrancar = function() return TriggerEvent("Notify","importante","Você <b>destrancou</b> a porta.", 5) end, -- Notificacao quando a porta destrancar
	trancada = function() return TriggerEvent("Notify","importante","A porta esta <b>trancada</b>, destranque para entrar.", 5) end, -- Notificacao quando a porta estiver trancada
	notownerGaragem = function() return TriggerEvent("Notify","importante","Você não tem acesso á essa garagem.", 5) end, -- Notificacao quando o jogador não tem acesso a garagem
	veiculoSpawnado = function() return TriggerEvent("Notify","importante","Este veiculo ja se encontra fora da garagem.", 5) end, -- Notificacao quando o veiculo ja esta fora da garagem
	apGaragem = function() return TriggerEvent("Notify","importante","As vagas de garagem no apartamento é apenas para o proprietario", 5) end, -- Notificacao quando o veiculo ja esta fora da garagem
	notAccess = function() return TriggerEvent("Notify","importante","Você não possui acesso a isso.", 5000) end -- Notificacao quando o veiculo ja esta fora da garagem
}

config.animLock = function() -- Animacao trancar/destrancar porta
	vRP._playAnim(true,{{"veh@mower@base","start_engine"}},false) -- Animacao
	Wait(2000) -- Tempo da Animacao
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGS GARAGEM
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src.tuningVehicle = function(custom, veh) -- Sua função de aplicar tunagem
	TriggerServerEvent("nation:syncApplyMods", custom,VehToNet(veh))
end

src.deleteVehicle = function(veh) -- Sua função de deletar veiculo
    exports['nova_garage']:deleteVehicle(source, veh)
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGS BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src.allDispHouses = function() -- Blips do comando /home disp
    houseOwner = GlobalState.houseOwner
    
    for k,v in pairs(propriedades) do
        if houseOwner[k] == nil or v.tipo == "apartamento" then
            local blip = AddBlipForCoord(v.coords.x,v.coords.y,v.coords.z)
            SetBlipSprite(blip,411)
            SetBlipAsShortRange(blip,true)
            SetBlipColour(blip,2)
            SetBlipScale(blip,0.4)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Propriedade Disponivel")
            EndTextCommandSetBlipName(blip)
            
            SetTimeout(15000,function() if DoesBlipExist(blip) then RemoveBlip(blip) end end)
        end
    end
end

src.myHouseBlip = function(coords) -- Blips da propriedades dos players
	local blip = AddBlipForCoord(coords.x,coords.y,coords.z)
	SetBlipSprite(blip,411)
	SetBlipAsShortRange(blip,true)
	SetBlipColour(blip,36)
	SetBlipScale(blip,0.4)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Minha propriedade")
	EndTextCommandSetBlipName(blip)
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OTIMIZAÇÃO ( NAO MEXA AQUI )
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local time = 1000
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        if in_interior then
            local distance = #(pedCoords - infoInterior.coords)
            if distance >= config.limitZone then
                SetEntityCoords(PlayerPedId(), infoInterior.coords[1],infoInterior.coords[2],infoInterior.coords[3])
            end

            local distance = #(pedCoords - infoInterior.coords)
            if distance <= 2.0 then
                time = 1
                config.drawlable(infoInterior.houseID, infoInterior.coords, infoInterior.tipo, propriedades[infoInterior.houseID].porta)

                if infoInterior.tipo == "casa" then
                    if IsControlJustReleased(1, 182) and segundos <= 0 then
                        segundos = 3

                        if vSERVER.checkEnterHouse(infoInterior.houseID) then
                            
                            if propriedades[infoInterior.houseID].porta then
                                config.animLock()
                                propriedades[infoInterior.houseID].porta = false
                                config.lang['destrancar']()
                            else
                                config.animLock()
                                propriedades[infoInterior.houseID].porta = true
                                config.lang['trancar']()
                            end

                            vSERVER.syncLock(infoInterior.houseID, propriedades[infoInterior.houseID].porta)
                        end
                    end

                    if IsControlJustReleased(1, 51) and segundos <= 0 then
                        segundos = 3

                        if not propriedades[infoInterior.houseID].porta then
                            vSERVER.sairPropriedade(infoInterior.houseID)
                        else
                            config.lang['trancada']()
                        end
                    end

                elseif infoInterior.tipo == "apartamento" then
                    if IsControlJustReleased(1, 51) and segundos <= 0 then
                        segundos = 3

                        vSERVER.sairPropriedade(infoInterior.houseID)
                    end
                end
            end
        else 
            if length(nearestHouse) > 0 then
                for k in pairs(nearestHouse) do 
                    local distance = #(pedCoords - vec3(nearestHouse[k].coords.x,nearestHouse[k].coords.y,nearestHouse[k].coords.z))
                    if distance <= 5.0 then
                        time = 5
                        config.drawlable(k, vec3(nearestHouse[k].coords.x,nearestHouse[k].coords.y,nearestHouse[k].coords.z), nearestHouse[k].tipo, nearestHouse[k].porta)
                        if distance <= 2.0 then
                            if nearestHouse[k].tipo == "casa" then
                                if IsControlJustReleased(1, 182) and segundos <= 0 then
                                    segundos = 3

                                    if vSERVER.checkEnterHouse(k) then
                                        
                                        if nearestHouse[k].porta then
                                            config.animLock()
                                            nearestHouse[k].porta = false
                                            config.lang['destrancar']()
                                        else
                                            config.animLock()
                                            nearestHouse[k].porta = true
                                            config.lang['trancar']()
                                        end

                                        vSERVER.syncLock(k, nearestHouse[k].porta)
                                    end
                                end

                                if IsControlJustReleased(1, 51) and segundos <= 0 then
                                    segundos = 3

                                    if not nearestHouse[k].porta then
                                        vSERVER.entrarPropriedade(k, nearestHouse[k].tipo)
                                    else
                                        if vSERVER.comprarPropriedade(k, tostring(nearestHouse[k].tipo)) then
                                            config.lang['trancada']()
                                        end
                                    end
                                end

                            elseif nearestHouse[k].tipo == "apartamento" then
                                if IsControlJustReleased(1, 51) and segundos <= 0 then
                                    segundos = 3
                                    vSERVER.interfone(k)
                                end

                                if IsControlJustReleased(1, 145) and segundos <= 0 then
                                    segundos = 3
                                    vSERVER.comprarPropriedade(k, tostring(nearestHouse[k].tipo))
                                end
                            end
                        end
                    end
                end
            end
        end

        Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
    while true do 
        local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
        if not in_interior then
            for k in pairs(propriedades) do
                local distance = #(pedCoords - vec3(propriedades[k].coords.x,propriedades[k].coords.y,propriedades[k].coords.z))
                if distance < 10 then
                    nearestHouse[k] = propriedades[k]
                elseif nearestHouse[k] then
                    nearestHouse[k] = nil
                end
            end
        end
        
        Citizen.Wait(1000)
    end
end)
