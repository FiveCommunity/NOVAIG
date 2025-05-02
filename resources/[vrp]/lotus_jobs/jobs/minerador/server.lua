--------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------------------------------------------------------------------------------
Miner = {
    ActualRoute = {},
    Alerts = {}
}

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
--------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.MinerCollect(Route)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    -- VERIFICANDO SE EXISTE UMA ROTA VALIDA
    local ActualRoute = Miner.ActualRoute[user_id]
    if not ActualRoute then
        --print(("^1[ANTI-INJECT] (Miner) ^0USER_ID %s NOT ROUTE DEFINED"):format(user_id))

        Miner.ActualRoute[user_id] = 1
        return Miner.ActualRoute[user_id]
    end

    -- VERIFICANDO SE A ROTA FOR DIFERENTE DAS IGUAIS
    if ActualRoute ~= Route then
        Miner:AddUserAlert(user_id)
        --print(("^1[ANTI-INJECT] (Miner) ^0USER_ID %s ROUTE %s COLLECTED ROUTE %s"):format(user_id, ActualRoute, Route))
        
        return Miner.ActualRoute[user_id]
    end

    -- VERIFICAR COORDENADAS
    local PlyCoords = GetEntityCoords(GetPlayerPed(source))
    local Dist = #(MinerConfig.Routes[ActualRoute].coords - PlyCoords)
    if Dist >= 30 then
        Miner:AddUserAlert(user_id)
        --print(("^1[ANTI-INJECT] (Miner) ^0USER_ID %s DISTANCE TO ROUTE %s"):format(user_id, Dist))

        return Miner.ActualRoute[user_id]
    end

    -- VERIFICANDO TEMPO DAS ULTIMAS COLETAS
    local status, time = exports['vrp']:getCooldown(user_id, "MinerReward")
    if not status then
        Miner:AddUserAlert(user_id)
        --print(("^1[ANTI-INJECT] (Miner) ^0USER_ID %s VERY FAST FARMING %s REMANING SECONDS"):format(user_id, time))
        return Miner.ActualRoute[user_id]
    end

    -- VERIFICANDO ALERTAS
    local UserAlerts = Miner:CheckUserAlert(user_id)
    if UserAlerts >= 5 then
        --print(("^1[ANTI-INJECT] (Miner) ^0 USER_ID %s TO %s ALERTS"):format(user_id, UserAlerts))
        SendLog(("```lua\nUSER_ID: %s\nTOTAL DE ALERTAS: %s\nEMPREGO: %s```"):format(user_id, UserAlerts, "Minerador"))

        return Miner.ActualRoute[user_id]
    end

    -- VERIFICANDO PARA NUNCA GERAR A MESMA ROTA.
    Miner.ActualRoute[user_id] = math.random(#MinerConfig.Routes)
    while Miner.ActualRoute[user_id] == ActualRoute do
        Miner.ActualRoute[user_id] = math.random(#MinerConfig.Routes)
        Wait(1000)
    end

    -- ENVIAR PAGAMENTO
    local Reward = MinerConfig.Payment[math.random(#MinerConfig.Payment)]
    if vRP.computeInvWeight(user_id)+vRP.getItemWeight(Reward.item)*Reward.max <= vRP.getInventoryMaxWeight(user_id) then
        vRP.giveInventoryItem(user_id, Reward.item, math.random(Reward.min, Reward.max), true)
    else
        TriggerClientEvent("Notify",source,"negado","Mochila cheia.", 5)
    end

    exports['vrp']:setCooldown(user_id, "MinerReward", 7)

    return Miner.ActualRoute[user_id]
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------------------------------------------------------------------------------
function Miner:AddUserAlert(user_id)
    if not self.Alerts[user_id] then self.Alerts[user_id] = 0 end
    
    self.Alerts[user_id] += 1
end

function Miner:CheckUserAlert(user_id)
    return self.Alerts[user_id] or 0
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER SPAWN
--------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	Miner.ActualRoute[user_id] = 1
end)
