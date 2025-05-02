-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNNEL
-----------------------------------------------------------------------------------------------------------------------------------------
cO = {}
Tunnel.bindInterface(GetCurrentResourceName(), cO)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD START
-----------------------------------------------------------------------------------------------------------------------------------------
local SERVICE = false 
local HOMES = {}
Citizen.CreateThread(function()
    local VEHICLE = IsPedInAnyVehicle
    while true do
        local WAIT = 1000
        local PED = PlayerPedId()
        if not VEHICLE(PED) and not SERVICE then
            local COORDS = GetEntityCoords(PED) 
            local DISTANCE = #(COORDS - StartCoords)
            if DISTANCE <= 5 then 
                WAIT = 0
                DrawText3D(StartCoords.x,StartCoords.y,StartCoords.z,"[~r~E~w~] - INICIAR SERVIÇO")
                DrawMarker(1,StartCoords.x,StartCoords.y,StartCoords.z - 1.7,0,0,0,0,0,0,1.0,1.0,1.0, 165, 42, 42,155, 1,1,1,1)
                if IsControlJustPressed(0,38) and DISTANCE <= 1.5 then 
                    SERVICE = true
                    TriggerEvent("Notify","sucesso","Serviço iniciado, vá té uma das casas marcadas em seu mapa e efetue a limpeza.",5000)
                    START()
                end
            end

        end
        Citizen.Wait(WAIT)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- IN SERVICE FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function START()
    for ID,V in pairs(HomeBlips) do 
        HOMES[ID] = AddBlipForCoord(V.Start.x,V.Start.y,V.Start.z)            
        SetBlipSprite(HOMES[ID],411)
        SetBlipAsShortRange(HOMES[ID],true)
        SetBlipColour(HOMES[ID],46)
        SetBlipScale(HOMES[ID],0.4)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Casa")
        EndTextCommandSetBlipName(HOMES[ID])
    end


    Citizen.CreateThread(function()
        local SERVICE_BLIP = 0
        local SERVICE_INDEX = 0
        local SERVICE_CLEARED = {}

        local SERVICE_CLEANER = false
        while (SERVICE) do 
            local PED = PlayerPedId()
            local COORDS = GetEntityCoords(PED)
            if not next(HOMES) or GetEntityHealth(PED) <= 101 then 
                print("?")
                SERVICE = false
                if not next(HOMES) then 
                    TriggerEvent("Notify","sucesso","Você já limpou todas residências, inicie o serviço novamente.",5000)
                else
                    for k,v in pairs(HOMES) do 
                        if DoesBlipExist(HOMES[k]) then 
                            RemoveBlip(HOMES[k])
                        end
                    end
                    TriggerEvent("Notify","importante","Você finalizou o serviço!",5)
                end
                   
                HOMES = {}
                break
            end

            
            for ID,V in pairs(HomeBlips) do 
                if HOMES[ID] then 
                    if HomeBlips[SERVICE_BLIP] and SERVICE_CLEANER then 
                        if SERVICE_INDEX == #HomeBlips[SERVICE_BLIP].Service then 
                            TriggerEvent("Notify","sucesso","Você finalizou a limpeza da residência "..SERVICE_BLIP..", se dirija a outra residência para continuar trabalhando.",5000)

                            SERVICE_CLEANER = false
                            SERVICE_INDEX = 0
                            SERVICE_CLEARED = {}
                            if DoesBlipExist(HOMES[ID]) then 
                                RemoveBlip(HOMES[ID])
                                HOMES[ID] = nil 
                            end

                            vSERVER.Generate(SERVICE_BLIP)
                        end

                        for k,v in pairs(HomeBlips[SERVICE_BLIP].Service) do 
                            if not SERVICE_CLEARED[tostring(k)] then 
                                local DISTANCE = #(COORDS - v.coords)
                                if DISTANCE <= 7.5 then 
                                    DrawText3D(v.coords.x,v.coords.y,v.coords.z,"[~g~E~w~] - "..v.name)
                                    if IsControlJustPressed(0,38) and DISTANCE <= 1.2 then 
                                		FreezeEntityPosition(PED,true)
                                        ExecuteCommand(v.anim)
                                        TriggerEvent("Progress",v.time)
                                        Citizen.Wait(v.time)
                                        ExecuteCommand("clear")
                                		FreezeEntityPosition(PED,false)
                                        SERVICE_CLEARED[tostring(k)] = true
                                        SERVICE_INDEX = SERVICE_INDEX + 1
                                        
                                        if SERVICE_INDEX < #HomeBlips[SERVICE_BLIP].Service then 
                                            TriggerEvent("Notify","sucesso","Continue trabalhando na residência.",5000)
                                        end
                                    end 
                                end
                            end
                        end
                    end

                    if not SERVICE_CLEANER and SERVICE_INDEX == 0 then 
                        local DISTANCE = #(COORDS - vec3(V.Start.x,V.Start.y,V.Start.z))
                        if DISTANCE <= 5 then 
                            DrawText3D(V.Start.x,V.Start.y,V.Start.z,"[~g~E~w~] - INICIAR LIMPEZA")
                            if IsControlJustPressed(0,38) and DISTANCE <= 1.2 then 
                                SERVICE_BLIP = ID
                                SERVICE_CLEANER = true
                            end
                        end
                    end

                end
            end
            Citizen.Wait(0)
        end
    end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOP SERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("STOP_SERVICE", 'Encerrar o serviço de faxineiro', 'keyboard', 'F7')
RegisterCommand("STOP_SERVICE", function()
	if SERVICE then
        SERVICE = false
        for k,v in pairs(HOMES) do 
            if DoesBlipExist(HOMES[k]) then 
                RemoveBlip(HOMES[k])
            end
        end

        HOMES = {}
        TriggerEvent("Notify","importante","Você finalizou o serviço!",5)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK SERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cO.checkService()
    return SERVICE
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	SetTextFont(4)
	SetTextCentre(1)
	SetTextEntry("STRING")
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z,0)
	DrawText(0.0,0.0)
	local factor = (string.len(text) / 450) + 0.01
	DrawRect(0.0,0.0125,factor,0.03,10 ,10, 10,120)
	ClearDrawOrigin()
end