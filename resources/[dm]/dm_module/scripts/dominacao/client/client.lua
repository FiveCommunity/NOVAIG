------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Domination = {
    Owners = {},
    Running = {},
    RunningBlips = {}
}

local Ply = {
    inZone = false,
    inZoneId = 0,

    Running = false,
    Counter = 0,
}

local Zones = {
    Blips = {}
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS DOMINATION
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Domination:Owner(index)
    return self.Owners[index] and self.Owners[index] or "Ninguem"
end

function Domination:setDomination(index, status, owner, owner_src)
   self.Running[index] = status

    if status or owner then
        SendNUIMessage({ "UPDATE_NUI", "domfeed",  { action = 'emblem', payload = { type = DominationConfig.Zones[index].name, mode = status and 'init' or 'finish' } } })
    end

    -- SE A DOMINACAO ESTIVER RODANDO
    if self.Running[index] then
        self.RunningBlips[index] = AddBlipForRadius(DominationConfig.Zones[index].blip.x,DominationConfig.Zones[index].blip.y,DominationConfig.Zones[index].blip.z, 100.0)
        SetBlipColour(self.RunningBlips[index], 1)
        SetBlipAlpha(self.RunningBlips[index], 80)
    else
        if self.RunningBlips[index] then
            RemoveBlip(self.RunningBlips[index])
            self.RunningBlips[index] = nil
        end
    end

   -- SISTEMA DE COROA NA CABEÇA
   if status then
        CreateThread(function()
            while self.Running[index] do
                local myPed = PlayerPedId()
                local pedSource = GetPlayerFromServerId(owner_src)
                local ped = GetPlayerPed(pedSource)
                local pedCoords = GetEntityCoords(ped)

                if (myPed ~= ped) and pedCoords then
                    DrawMarker(42,pedCoords.x, pedCoords.y, pedCoords.z+0.9 ,0,0,0, 90.0, 0,0, 0.2,1.0,0.2, 255,222,0,180 ,0,0,0,1)
                end

                Wait(0)
            end
        end)
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS PLAYERS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Ply:StartDomination(zone_id, counter)
    self.Running = true
    self.Counter = counter

    CreateThread(function()
        while self.Counter > 0 and Domination.Running[zone_id] do
            drawTxt("Você está dominando essa area aguarde ~g~"..self.Counter.."~w~ segundo(s) para domina-la e fique vivo!",4,0.5,0.93,0.50,255,255,255,180)
            Wait(0)
        end
    end)

    CreateThread(function()
        while self.Counter > 0 and Domination.Running[zone_id] do
            self.Counter -= 1
            Wait(1000)
        end
    end)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS OTHERS PLAYERS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Ply:EnterZone(domination_id, running)
    if not GlobalState.isDominationActive then
        return
    end
    vTunnel._EnterZone(domination_id, running)

    Ply.inZone = true
    Ply.inZoneId = domination_id

    local dominationName = DominationConfig.FormatNames[DominationConfig.Zones[domination_id].name]
    exports["nova_extras"]:toggleDomination(true,dominationName)
end

function Ply:LeaveZone()
    local ZONE_ID = self.inZoneId
    vTunnel._LeaveZone(ZONE_ID)

    self.inZone = false
    self.inZoneId = 0

    if self.Running then
        vTunnel._CancelDomination(ZONE_ID)

        self.Running = false
        self.Counter = 0
    end
    exports["nova_extras"]:toggleDomination(false)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterTunnel.updateDomination = function(domination_id, status, owner, owner_src)
    
    if status then
        Ply.inZone = false
    end

    Domination:setDomination(domination_id, status, owner, owner_src)

    if owner then
        Domination.Owners[domination_id] = owner
    end

    Zones:RefreshBlips()
end

RegisterTunnel.syncDeath = function(data)
    SendNUIMessage({ "UPDATE_NUI", "domfeed",  { action = 'notifyKill', payload = { killer = data.killer, victim = data.victim, weapon = data.weapon } } })
end 

RegisterTunnel.updateKillStreak = function(amount)
    SendNUIMessage({ "UPDATE_NUI", "domfeed",  { action = 'killStreak', payload = amount  } })
end

RegisterTunnel.showEmblem = function(dominationType,status)
    SendNUIMessage({'SHOW_NUI', 'domfeed'})
    if dominationType then
        SendNUIMessage({ "UPDATE_NUI", "domfeed",  { action = 'emblem', payload = { type = dominationType, mode = status and 'init' or 'finish' } } })
        Wait(5000)
        SendNUIMessage({'CLOSE_NUI'})
    end
    SendNUIMessage({'SHOW_NUI', 'domfeed'})
end

RegisterTunnel.syncBlipsDomination = function(data)
    for index, org in pairs(data) do
        Domination.Owners[index] = org
    end

    Zones:RefreshBlips()
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MAIN THREAD
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local SLEEP_TIME = 1000
        local plyCoords = GetEntityCoords(PlayerPedId())

        for index=1, #DominationConfig.Zones do
            local zone = DominationConfig.Zones[index]
            local dist = #(plyCoords - zone.blip)
            if dist <= 10 then
                SLEEP_TIME = 0

                DrawText3Ds(zone.blip.x, zone.blip.y, zone.blip.z, "~r~["..DominationConfig.FormatNames[zone.name].."] ~n~~w~Controlada: ~b~"..Domination:Owner(index).."~n~ ~w~Pressione ~b~[E]~w~ para dominar esta area ")
                DrawMarker(27,zone.blip[1],zone.blip[2],zone.blip[3]-0.95,0,0,0,0, 0,0,1.5,1.5,1.5, 255,0,0, 180,0,0,0,1)
                if IsControlJustPressed(0,38) and dist <= 1.5 then
                    if not GlobalState.Dominations then 
                        TriggerEvent("Notify","negado","As dominações estão desativadas temporariamente.",5000)
                    else
                        local Response = vTunnel.RequestInit({ id = index })
                        if Response then
                            Ply:StartDomination(index, (DominationConfig.Zones[index].time * 60))
                        end
                    end
                end
            end
        end

        Wait( SLEEP_TIME )
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OTHERS THREAD
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local SLEEP_TIME = 1000
        local plyCoords = GetEntityCoords(PlayerPedId())

        for index = 1, #DominationConfig.Zones do
            local dist = #(plyCoords - DominationConfig.Zones[index].blip)
            if dist <= 650 then
                SLEEP_TIME = 0
                drawPoly(index)
            end
        end

        Wait( SLEEP_TIME )
    end
end)

CreateThread(function()
    while true do
        local SLEEP_TIME = 1000

        local inZone,Zone = getPlyInZone()

        if inZone and GlobalState.isDominationActive then
            if not Ply.inZone then
                Ply:EnterZone(Zone.Index, Domination.Running[Zone.Index])
            end
        end

        if not inZone and Ply.inZone then
            Ply.inZone = false

            Ply:LeaveZone()
        end

        if not GlobalState.isDominationActive then  
            if Ply.inZone then
                Ply:LeaveZone()
            end
        end

        Wait( SLEEP_TIME )
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OTHERS FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function drawPoly(index)
    local playerPed = GetPlayerPed(-1)

    if DominationConfig.Zones[index] and GlobalState.isDominationActive then
        local Zone = DominationConfig.Zones[index].polyzone
        local j = #Zone
        for i = 1, #Zone do
            local zone = Zone[i]
            if i < #Zone then
                local p2 = Zone[i+1]
                showWall(zone, p2, index)
            end
        end
        if #Zone > 2 then
            local firstPoint = Zone[1]
            local lastPoint = Zone[#Zone]
            showWall(firstPoint, lastPoint, index)
        end
    end
end

function showWall(p1, p2, index)
    local bottomLeft = vector3(p1[1], p1[2], p1[3] - 100)
    local topLeft = vector3(p1[1], p1[2],  p1[3] + 100)
    local bottomRight = vector3(p2[1], p2[2], p2[3] - 100)
    local topRight = vector3(p2[1], p2[2], p2[3] + 100)

    local color = { 19, 175, 0 }
    if GlobalState.dominationsStatus and GlobalState.dominationsStatus[index] then
        if GlobalState.dominationsStatus[index] == 'running' then
            color = { 175, 19, 0 }
        elseif GlobalState.dominationsStatus[index] == 'dominated' then
            color = { 19, 0, 175 }
        end
    end

    DrawPoly(bottomLeft, topLeft, bottomRight, color[1], color[2], color[3], GlobalState.dominationsStatus[index] == 'running' and 250 or 150)
    DrawPoly(topLeft, topRight, bottomRight, color[1], color[2], color[3], GlobalState.dominationsStatus[index] == 'running' and 250 or 150)
    DrawPoly(bottomRight, topRight, topLeft, color[1], color[2], color[3], GlobalState.dominationsStatus[index] == 'running' and 250 or 150)
    DrawPoly(bottomRight, topLeft, bottomLeft, color[1], color[2], color[3], GlobalState.dominationsStatus[index] == 'running' and 250 or 150)
end

function getPlyInZone()
    local plyCoords = vector2(GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y) -- Apenas x e y
    local inZone = false
    local tZone = {}
    local min = 1000.0

    if GetEntityHealth(PlayerPedId()) <= 101 then
        return inZone
    end

    for k in pairs(DominationConfig.Zones) do
        if DominationConfig.Zones[k] then
            local dist = #(vector2(DominationConfig.Zones[k].blip.x, DominationConfig.Zones[k].blip.y) - plyCoords)

            if dist < min then
                min = dist

                local Zone = {}
                for _, coord in ipairs(DominationConfig.Zones[k].polyzone) do
                    table.insert(Zone, vector2(coord.x, coord.y))
                end
                local j = #Zone
                for i = 1, #Zone do
                    if (Zone[i].y < plyCoords.y and Zone[j].y >= plyCoords.y or Zone[j].y < plyCoords.y and Zone[i].y >= plyCoords.y) then
                        local slope = (plyCoords.y - Zone[i].y) / (Zone[j].y - Zone[i].y)
                        local xIntersect = Zone[i].x + slope * (Zone[j].x - Zone[i].x)
                        if xIntersect < plyCoords.x then
                            inZone = not inZone
                            tZone = { Index = k, Name = DominationConfig.Zones[k].name }
                        end
                    end
                    j = i
                end
            end
        end
    end

    if not inZone then
        tZone = {}
    end

    return inZone, tZone
end

RegisterTunnel.syncBlipDomination = function(index)
    if Domination.Owners[index] then
        Domination.Owners[index] = nil
    end

    Zones:RefreshBlips()
end

RegisterTunnel.inDomination = function()
    return Ply.inZone
end

exports("inDomination",function()
    return Ply.inZone
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- KILL FEED
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered", function(eventName, args)
    if eventName == "CEventNetworkEntityDamage" then
        local victim = args[1]
        if IsPedAPlayer(args[1]) and victim == PlayerPedId() and Ply.inZone then
            local plyHealth = GetEntityHealth(args[1])
            if plyHealth <= 101 then
                vTunnel._SendKillFeed({ 
                    zone = Ply.inZoneId,
                    attacker = GetPlayerServerId(NetworkGetPlayerIndexFromPed(args[2])),
                    weapon = args[7],
                })
            end
        end
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rank', function(source,args)
    SetNuiFocus(true, true)
    SendNUIMessage({ "SHOW_NUI", "domranking" })
end)

RegisterNUICallback('getInitial', function(data,cb)
    cb(vTunnel.TopRanks())
end)

RegisterNUICallback('getTopDominas', function(data,cb)
    cb(vTunnel.getDominasRank())
end)

RegisterNUICallback('getRanking', function(data,cb)
    cb(vTunnel.getRank(data.type))
end)

RegisterNUICallback('closeRanking', function(data, cb) 
    SendNUIMessage({'CLOSE_NUI'})
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Zones:RefreshBlips()

    for index in pairs(DominationConfig.Zones) do
        if self.Blips[index] then
            RemoveBlip(self.Blips[index])
        end

        self.Blips[index] = AddBlipForCoord(DominationConfig.Zones[index].blip.x,DominationConfig.Zones[index].blip.y,DominationConfig.Zones[index].blip.z)
        SetBlipScale(self.Blips[index], 0.5)
        SetBlipSprite(self.Blips[index], 84)
        SetBlipColour(self.Blips[index], 1)
        SetBlipAsShortRange(self.Blips[index],true)
        BeginTextCommandSetBlipName("STRING")

        AddTextComponentString( ("[ %s ] Dominado Por: %s"):format(DominationConfig.FormatNames[DominationConfig.Zones[index].name], Domination:Owner(index)) )
        EndTextCommandSetBlipName(self.Blips[index])
    end

end

CreateThread(function()
    Zones:RefreshBlips()
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CREATE MODE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local CreateZone = {
    inCreate = false,
    Zones = {}
}

function RegisterTunnel.openCreateMode()
    CreateZone:Init()
end

function CreateZone:Init()
    self.inCreate = true

    CreateThread(function()
        while self.inCreate do
            local plyId = PlayerPedId()
            local plyCoords = GetEntityCoords(plyId)

            drawTxt("~g~E~w~ PARA POSICIONAR "..#self.Zones.."º PONTO", 4, 0.10, 0.8, 0.50, 255, 255, 255, 180)
            drawTxt("~g~F~w~ PARA REMOVER ULTIMO PONTO", 4, 0.10, 0.83, 0.50, 255, 255, 255, 180)
            drawTxt("~r~BACKSPACE~w~ PARA CANCELAR.", 4, 0.10, 0.86, 0.50, 255, 255, 255, 180)
            drawTxt("~g~ENTER~w~ PARA CRIAR.", 4, 0.10, 0.89, 0.50, 255, 255, 255, 180)

            if IsControlJustPressed(0, 38) then
                self.Zones[#self.Zones + 1] = plyCoords
            end

            if IsControlJustPressed(0, 75) then
                self.Zones[#self.Zones] = nil
            end

            if IsControlJustPressed(0, 177) then
                self.inCreate = false
                self.Zones = {}

                TriggerEvent("Notify","negado","Você cancelou a criação da zona.")
            end

            if IsControlJustPressed(0, 201) then
                self.inCreate = false
                vTunnel._SendZone(self.Zones)

                self.Zones = {}
            end

            DebugPoly()

            Wait( 0 )
        end
    end)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OTHERS FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function DebugPoly()
    if CreateZone.inCreate then
        local playerPed = GetPlayerPed(-1)
        
        local Zone = CreateZone.Zones
        local j = #Zone
        for i = 1, #Zone do
            local zone = Zone[i]
            if i < #Zone then
                local p2 = Zone[i+1]
                showDebugWall(zone, p2)
            end
        end
    end
end

function showDebugWall(p1, p2)
    local bottomLeft = vector3(p1[1], p1[2], p1[3] - 100)
    local topLeft = vector3(p1[1], p1[2], p1[3] + 100)
    local bottomRight = vector3(p2[1], p2[2], p2[3] - 100)
    local topRight = vector3(p2[1], p2[2], p2[3] + 100)

    DrawPoly(bottomLeft, topLeft, bottomRight, 102, 0, 204, 255)
    DrawPoly(topLeft, topRight, bottomRight, 102, 0, 204, 255)
    DrawPoly(bottomRight, topRight, topLeft, 102, 0, 204, 255)
    DrawPoly(bottomRight, topLeft, bottomLeft, 102, 0, 204, 255)
end

function RegisterTunnel.updateTimer(ownerSource, zoneId, time)
    Domination.Running[zoneId] = false
    Wait(1000)
    Domination.Running[zoneId] = true
    if ownerSource == GetPlayerServerId(PlayerId()) then
        Ply:StartDomination(zoneId, time)
    end
end