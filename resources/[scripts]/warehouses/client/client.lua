-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNNEL
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface(GetCurrentResourceName())
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function openInterface()
    TransitionToBlurred(1000)
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'open' })  
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function closeInterface()
    TransitionFromBlurred(1000)
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Warehouses:Close",function()
    closeInterface()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do 
        local Wait = 1000
        local Ped = PlayerPedId()
        if not IsPedInAnyVehicle(Ped) then 
            local Distance = #(GetEntityCoords(Ped) - WarehouseState)
            if Distance <= 5 then 
                Wait = 0
                DrawText3D(WarehouseState.x,WarehouseState.y,WarehouseState.z,"[~g~E~w~] - IMOBILIÁRIA")
                DrawMarker(1,WarehouseState.x,WarehouseState.y,WarehouseState.z - 1.7,0,0,0,0,0,0,1.0,1.0,1.0, 170, 255, 0,155, 1,1,1,1)
                if IsControlJustPressed(0,38) and Distance <= 1.5 then 
                    openInterface()
                end
            end
        end
        Citizen.Wait(Wait)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do 
        local Wait = 1000
        local Ped = PlayerPedId()
        if not IsPedInAnyVehicle(Ped) then 
            for k,v in pairs(Warehouses) do 
                local Distance = #(GetEntityCoords(Ped) - v.Chest)
                if Distance <= 5 then 
                    Wait = 0
                    DrawText3D(v["Chest"].x,v["Chest"].y,v["Chest"].z,"[~g~E~w~] - BAÚ")
                    DrawMarker(1,v["Chest"].x,v["Chest"].y,v["Chest"].z - 1.7,0,0,0,0,0,0,1.0,1.0,1.0, 170, 255, 0,155, 1,1,1,1)
                    if IsControlJustPressed(0,38) and Distance <= 1.5 then 
                        vSERVER.propertyChest(k)
                    end
                end
            end
  
        end
        Citizen.Wait(Wait)
    end
end)

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