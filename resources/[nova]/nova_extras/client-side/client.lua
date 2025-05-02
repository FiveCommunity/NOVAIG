local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local inScreen = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN INTERFONES
-----------------------------------------------------------------------------------------------------------------------------------------
function openInterfones(Title,Options)
    inScreen = Title
    SetNuiFocus(true,true)
    SendNUIMessage({ action = "open:intercom", title = inScreen, options = Options })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD INTERFONES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local WAIT = 1000
        local PED = PlayerPedId()
        if not inScreen and not IsPedInAnyVehicle() and GetEntityHealth(PED) > 101 then 
            for k,v in pairs(Interfones) do 
                local DISTANCE = #(GetEntityCoords(PlayerPedId()) - v.coords)
                if DISTANCE <= 8 then 
                    WAIT = 0
                    DrawText3D(v.coords.x,v.coords.y,v.coords.z,"[~r~E~w~] - INTERFONE")
                    DrawMarker(1,v.coords.x,v.coords.y,v.coords.z - 1.7,0,0,0,0,0,0,1.0,1.0,1.0, 165, 42, 42,155, 1,1,1,1)
                    if IsControlJustPressed(0,38) and DISTANCE <= 1.2 then 
                        openInterfones(k,v.options)
                    end
                end
            end

        end
        Citizen.Wait(WAIT)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INTERFONE OPTION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNuiCallback("INTERCOM_OPTION",function(Data,Callback)
    local messageOption = Data.option
    if inScreen and Interfones[inScreen] then 
        vSERVER.callMessage(inScreen,messageOption)
    end

    Callback(true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INTERFONE OPTION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNuiCallback("close",function(Data,Callback)
    SetNuiFocus(false,false)
    inScreen = false
    Callback(true)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE DOMINATION
-----------------------------------------------------------------------------------------------------------------------------------------
exports("toggleDomination",function(status,name)
    TriggerEvent('cupom:visible', status)
    if status then 
        SendNUIMessage({action = "open:domination"})
        SendNUIMessage({
            action = "update:domination",
            informations = {
                name = name,
                enemies = 0,
                organization = attackerName,
                allies = totalAllies
            }
        })
    else
        SendNUIMessage({action = "close:domination"})
    end
end)

RegisterNetEvent("update:domination",function(dominationName,partnersInfos,attackerName,totalAllies)
    SendNUIMessage({
        action = "update:domination",
        informations = {
            name = dominationName,
            enemies = partnersInfos,
            organization = attackerName,
            allies = totalAllies
        }
    })
end)



exports("toggleDominationGeral",function(status,name)
    TriggerEvent('cupom:visible', status)
    if status then 
        SendNUIMessage({action = "open:domination"})
        SendNUIMessage({
            action = "update:domination",
            informations = {
                name = name,
                enemies = 0,
                points = 0,
                allies = 0
            }
        })
    else
        SendNUIMessage({action = "close:domination"})
    end
end)

RegisterNetEvent("update:dominationGeral",function(dominationName,partnersInfos,points,totalAllies)
    SendNUIMessage({
        action = "update:domination",
        informations = {
            name = dominationName,
            enemies = partnersInfos,
            points = points,
            allies = totalAllies
        }
    })
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