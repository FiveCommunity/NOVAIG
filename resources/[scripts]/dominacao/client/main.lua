------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
player = {
    inZone = false,
}

domination = {
    running = false
}

blip = 0

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function enterZone()
    player.inZone = true

    exports["nova_extras"]:toggleDominationGeral(true, 'Geral')

    vTunnel.enterZone()
end

function leaveZone()
    player.inZone = false

    exports["nova_extras"]:toggleDominationGeral(false, 'Geral')

    vTunnel.leaveZone()
end

function RegisterTunnel.inDomination()
    return player.inZone
end

exports("inDomination",function()
    return player.inZone
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MAIN THREADS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    Wait(1000)
    while true do
        local SLEEP_TIME = 1000

        local dist = #(GetEntityCoords(PlayerPedId()) - Config.coordsBlip)
        if dist <= 500 and GetEntityHealth(PlayerPedId()) >= 101 then
            SLEEP_TIME = 0
            
            local inZone = getPlyInZone()
            if inZone then
                if not player.inZone then
                    enterZone()
                end

                -- if not domination.running then
                --     if dist <= 10.0 then
                --         DrawText3Ds(Config.coordsBlip.x, Config.coordsBlip.y, Config.coordsBlip.z, "~r~[DOMINACAO GERAL] ~n~~w~Controlada: ~b~"..GlobalState.dominationOwner.."~n~ ~w~Pressione ~b~[E]~w~ para dominar esta area ")
                --         DrawMarker(27,Config.coordsBlip[1],Config.coordsBlip[2],Config.coordsBlip[3]-0.95,0,0,0,0, 0,0,1.5,1.5,1.5, 255,0,0, 180,0,0,0,1)

                --         if IsControlJustPressed(0,38) and dist < 5.0 and GetEntityHealth(PlayerPedId()) > 101 then
                --             vTunnel._requestInit()
                --         end
                --     end
                -- end

                if player.inZone then
                    if GetEntityHealth(PlayerPedId()) < 101 then
                        leaveZone()
                        SendNUIMessage({action = "setVisible", data = false}) 
                    end
                end

            else
                if player.inZone then
                    leaveZone()
                    SendNUIMessage({action = "setVisible", data = false}) 
                end
            end
            drawPoly()
        else
            if player.inZone then
                leaveZone()
                SendNUIMessage({action = "setVisible", data = false})
            end
        end

        Wait(SLEEP_TIME)
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- STATEBAG
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler('dominationOwner', 'global', function(_,_,value)
    Wait(1000)
    updateBlip()
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OTHERS FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function updateBlip()
    if blip > 0 then
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end
    
    blip = AddBlipForCoord(Config.coordsBlip.x,Config.coordsBlip.y,Config.coordsBlip.z)
    SetBlipScale(blip, 0.5)
    SetBlipSprite(blip, 84)
    SetBlipColour(blip, 1)
    SetBlipAsShortRange(blip,true)
    BeginTextCommandSetBlipName("STRING")

    AddTextComponentString( ("[ %s ] Dominado Por: %s"):format('Geral', GlobalState.dominationOwner) )
    EndTextCommandSetBlipName(blip)
end

function drawPoly()
    local playerPed = GetPlayerPed(-1)
    local Zone = Config.coordsPolyZone
    local j = #Zone
    for i = 1, #Zone do
        local zone = Zone[i]
        if i < #Zone then
            local p2 = Zone[i+1]
            showWall(zone, p2)
        end
    end
    if #Zone > 2 then
        local firstPoint = Zone[1]
        local lastPoint = Zone[#Zone]
        showWall(firstPoint, lastPoint)
    end
end

function showWall(p1, p2)
    local bottomLeft = vector3(p1[1], p1[2], p1[3] - 100)
    local topLeft = vector3(p1[1], p1[2],  p1[3] + 100)
    local bottomRight = vector3(p2[1], p2[2], p2[3] - 100)
    local topRight = vector3(p2[1], p2[2], p2[3] + 100)

    DrawPoly(bottomLeft, topLeft, bottomRight, GlobalState.GlobalDominationColor[1], GlobalState.GlobalDominationColor[2], GlobalState.GlobalDominationColor[3], GlobalState.GlobalDominationColor[1] == 175 and 250 or 150)
    DrawPoly(topLeft, topRight, bottomRight, GlobalState.GlobalDominationColor[1], GlobalState.GlobalDominationColor[2], GlobalState.GlobalDominationColor[3], GlobalState.GlobalDominationColor[1] == 175 and 250 or 150)
    DrawPoly(bottomRight, topRight, topLeft, GlobalState.GlobalDominationColor[1], GlobalState.GlobalDominationColor[2], GlobalState.GlobalDominationColor[3], GlobalState.GlobalDominationColor[1] == 175 and 250 or 150)
    DrawPoly(bottomRight, topLeft, bottomLeft, GlobalState.GlobalDominationColor[1], GlobalState.GlobalDominationColor[2], GlobalState.GlobalDominationColor[3], GlobalState.GlobalDominationColor[1] == 175 and 250 or 150)
end

function getPlyInZone()
    local plyCoords = GetEntityCoords(PlayerPedId())
    local inZone = false
    local tZone = {}
    local min = 1000.0

    local dist = #(Config.coordsBlip - GetEntityCoords(PlayerPedId()))
    if dist < min then
        min = dist

        local Zone = Config.coordsPolyZone
        local j = #Zone
        for i = 1, #Zone do
            if (Zone[i][2] < plyCoords.y and Zone[j][2] >= plyCoords.y or Zone[j][2] < plyCoords.y and Zone[i][2] >= plyCoords.y) then
                if (Zone[i][1] + ( plyCoords[2] - Zone[i][2] ) / (Zone[j][2] - Zone[i][2]) * (Zone[j][1] - Zone[i][1]) < plyCoords.x) then
                    inZone = not inZone;
                end
            end
            j = i;
        end
    end

    return inZone
end

CreateThread(function()
    updateBlip()
end)

local blockedVehicles = {
    [GetHashKey('termine')] = true,
    [GetHashKey('wrarmoredcayenne')] = true,
    [GetHashKey('wrarmoredm3g80c')] = true,
    [GetHashKey('wrarmoredm5')] = true,
    [GetHashKey('wrarmoredmacan')] = true,
    [GetHashKey('wrarmoredrs7')] = true,
    [GetHashKey('wrarmoredx7m60i')] = true,
    [GetHashKey('wrbb64')] = true,
    [GetHashKey('nimbus16')] = true,
    [GetHashKey('xmasirisrora')] = true,
    [GetHashKey('conada')] = true,
}

CreateThread(function()
    while true do
        local timeDistance = 1000
        local ped = PlayerPedId()
        if player.inZone then
            timeDistance = 0
            if IsPedInAnyVehicle(ped) and blockedVehicles[GetEntityModel(GetVehiclePedIsIn(ped, false))] then
                TaskLeaveVehicle(ped, GetVehiclePedIsIn(ped, false), 0)
            end
        end
        Wait(timeDistance)
    end
end)