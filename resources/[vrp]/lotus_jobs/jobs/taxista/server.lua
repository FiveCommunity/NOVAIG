--------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------------------------------------------------------------------------------
Taxi = {
    ActualRoute = {},
    Alerts = {}
}

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
--------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.myRegistration()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local identity = vRP.getUserIdentity(user_id)
    if not identity then return end

    return identity.registro
end

function RegisterTunnel.taxiPayment(Route)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    -- VERIFICANDO SE EXISTE UMA ROTA VALIDA
    local ActualRoute = Taxi.ActualRoute[user_id]
    if not ActualRoute then
        --print(("^1[ANTI-INJECT] (Taxi) ^0USER_ID %s NOT ROUTE DEFINED"):format(user_id))

        Taxi.ActualRoute[user_id] = 1
        return Taxi.ActualRoute[user_id]
    end

    -- VERIFICANDO SE A ROTA FOR DIFERENTE DAS IGUAIS
    if ActualRoute ~= Route then
        Taxi:AddUserAlert(user_id)
        --print(("^1[ANTI-INJECT] (Taxi) ^0USER_ID %s ROUTE %s COLLECTED ROUTE %s"):format(user_id, ActualRoute, Route))
        
        return Taxi.ActualRoute[user_id]
    end

    -- VERIFICAR COORDENADAS
    local PlyCoords = GetEntityCoords(GetPlayerPed(source))
    local Dist = #(TaxiConfig.Routes[ActualRoute].coords - PlyCoords)
    if Dist >= 10 then
        Taxi:AddUserAlert(user_id)
        --print(("^1[ANTI-INJECT] (Taxi) ^0USER_ID %s DISTANCE TO ROUTE %s"):format(user_id, Dist))

        return Taxi.ActualRoute[user_id]
    end

    -- VERIFICANDO TEMPO DAS ULTIMAS COLETAS
    local status, time = exports['vrp']:getCooldown(user_id, "TaxiReward")
    if not status then
        Taxi:AddUserAlert(user_id)
        --print(("^1[ANTI-INJECT] (Taxi) ^0USER_ID %s VERY FAST FARMING %s REMANING SECONDS"):format(user_id, time))
        return Taxi.ActualRoute[user_id]
    end

    -- VERIFICANDO ALERTAS
    local UserAlerts = Taxi:CheckUserAlert(user_id)
    if UserAlerts >= 3 then
        --print(("^1[ANTI-INJECT] (Taxi) ^0 USER_ID %s TO %s ALERTS"):format(user_id, UserAlerts))
        SendLog(("```lua\nUSER_ID: %s\nTOTAL DE ALERTAS: %s\nEMPREGO: %s```"):format(user_id, UserAlerts, "Minerador"))

        return Taxi.ActualRoute[user_id]
    end

    -- VERIFICANDO PARA NUNCA GERAR A MESMA ROTA.
    Taxi.ActualRoute[user_id] = math.random(#TaxiConfig.Routes)
    while Taxi.ActualRoute[user_id] == ActualRoute do
        Taxi.ActualRoute[user_id] = math.random(#TaxiConfig.Routes)
        Wait(1000)
    end

    -- ENVIAR PAGAMENTO
    local amount = math.random(TaxiConfig.Payment["min"],TaxiConfig.Payment["max"])
    vRP.giveInventoryItem(user_id,"money",amount,true)

    exports['vrp']:setCooldown(user_id, "TaxiReward", 10)

    return Taxi.ActualRoute[user_id]
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------------------------------------------------------------------------------
function Taxi:AddUserAlert(user_id)
    if not self.Alerts[user_id] then self.Alerts[user_id] = 0 end
    
    self.Alerts[user_id] += 1
end

function Taxi:CheckUserAlert(user_id)
    return self.Alerts[user_id] or 0
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	Taxi.ActualRoute[user_id] = 1
end)

