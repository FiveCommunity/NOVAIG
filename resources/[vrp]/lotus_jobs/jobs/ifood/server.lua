--------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------------------------------------------------------------------------------
Ifood = {
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

function RegisterTunnel.ifoodPayment(Route)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    -- VERIFICANDO SE EXISTE UMA ROTA VALIDA
    local ActualRoute = Ifood.ActualRoute[user_id]
    if not ActualRoute then
        --print(("^1[ANTI-INJECT] (Ifood) ^0USER_ID %s NOT ROUTE DEFINED"):format(user_id))

        Ifood.ActualRoute[user_id] = 1
        return Ifood.ActualRoute[user_id]
    end

    -- VERIFICANDO SE A ROTA FOR DIFERENTE DAS IGUAIS
    if ActualRoute ~= Route then
        Ifood:AddUserAlert(user_id)
        --print(("^1[ANTI-INJECT] (Ifood) ^0USER_ID %s ROUTE %s COLLECTED ROUTE %s"):format(user_id, ActualRoute, Route))
        
        return Ifood.ActualRoute[user_id]
    end

    -- VERIFICAR COORDENADAS
    local PlyCoords = GetEntityCoords(GetPlayerPed(source))
    local Dist = #(IfoodConfig.Routes[ActualRoute].coords - PlyCoords)
    if Dist >= 20 then
        Ifood:AddUserAlert(user_id)
        --print(("^1[ANTI-INJECT] (Ifood) ^0USER_ID %s DISTANCE TO ROUTE %s"):format(user_id, Dist))

        return Ifood.ActualRoute[user_id]
    end

    -- VERIFICANDO TEMPO DAS ULTIMAS COLETAS
    local status, time = exports['vrp']:getCooldown(user_id, "IfoodReward")
    if not status then
        Ifood:AddUserAlert(user_id)
        --print(("^1[ANTI-INJECT] (Ifood) ^0USER_ID %s VERY FAST FARMING %s REMANING SECONDS"):format(user_id, time))
        return Ifood.ActualRoute[user_id]
    end

    -- VERIFICANDO ALERTAS
    local UserAlerts = Ifood:CheckUserAlert(user_id)
    if UserAlerts >= 5 then
        --print(("^1[ANTI-INJECT] (Ifood) ^0 USER_ID %s TO %s ALERTS"):format(user_id, UserAlerts))
        SendLog(("```lua\nUSER_ID: %s\nTOTAL DE ALERTAS: %s\nEMPREGO: %s```"):format(user_id, UserAlerts, "Minerador"))

        return Ifood.ActualRoute[user_id]
    end

    -- VERIFICANDO PARA NUNCA GERAR A MESMA ROTA.
    Ifood.ActualRoute[user_id] = math.random(#IfoodConfig.Routes)
    while Ifood.ActualRoute[user_id] == ActualRoute do
        Ifood.ActualRoute[user_id] = math.random(#IfoodConfig.Routes)
        Wait(1000)
    end

    -- ENVIAR PAGAMENTO
    local amount = math.random(IfoodConfig.Payment["min"],IfoodConfig.Payment["max"])
    --vRP.giveMoney(user_id,amount)
    --local Reward = IfoodConfig.Payment[math.random(#IfoodConfig.Payment)]
    --vRP.giveInventoryItem(user_id, Reward.item, math.random(Reward.min, Reward.max), true)

    vRP.giveInventoryItem(user_id,"money",amount,true)

    exports['vrp']:setCooldown(user_id, "IfoodReward", 5)

    return Ifood.ActualRoute[user_id]
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------------------------------------------------------------------------------
function Ifood:AddUserAlert(user_id)
    if not self.Alerts[user_id] then self.Alerts[user_id] = 0 end
    
    self.Alerts[user_id] += 1
end

function Ifood:CheckUserAlert(user_id)
    return self.Alerts[user_id] or 0
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	Ifood.ActualRoute[user_id] = 1
end)

