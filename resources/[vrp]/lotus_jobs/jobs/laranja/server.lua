--------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------------------------------------------------------------------------------
Orange = {
    ActualRoute = {},
    Alerts = {}
}

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
--------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.OrangeCollect(Route)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    -- VERIFICANDO SE EXISTE UMA ROTA VALIDA
    local ActualRoute = Orange.ActualRoute[user_id]
    if not ActualRoute then
        --print(("^1[ANTI-INJECT] (Orange) ^0USER_ID %s NOT ROUTE DEFINED"):format(user_id))

        Orange.ActualRoute[user_id] = 1
        return Orange.ActualRoute[user_id]
    end

    -- VERIFICANDO SE A ROTA FOR DIFERENTE DAS IGUAIS
    if ActualRoute ~= Route then
        Orange:AddUserAlert(user_id)
        --print(("^1[ANTI-INJECT] (Orange) ^0USER_ID %s ROUTE %s COLLECTED ROUTE %s"):format(user_id, ActualRoute, Route))
        
        return Orange.ActualRoute[user_id]
    end

    -- VERIFICAR COORDENADAS
    local PlyCoords = GetEntityCoords(GetPlayerPed(source))
    local Dist = #(orangeConfig.Routes[ActualRoute].coords - PlyCoords)
    if Dist >= 30 then
        Orange:AddUserAlert(user_id)
        --print(("^1[ANTI-INJECT] (Orange) ^0USER_ID %s DISTANCE TO ROUTE %s"):format(user_id, Dist))

        return Orange.ActualRoute[user_id]
    end

    -- VERIFICANDO TEMPO DAS ULTIMAS COLETAS
    local status, time = exports['vrp']:getCooldown(user_id, "OrangeReward")
    if not status then
        Orange:AddUserAlert(user_id)
        --print(("^1[ANTI-INJECT] (Orange) ^0USER_ID %s VERY FAST FARMING %s REMANING SECONDS"):format(user_id, time))
        return Orange.ActualRoute[user_id]
    end

    -- VERIFICANDO ALERTAS
    local UserAlerts = Orange:CheckUserAlert(user_id)
    if UserAlerts >= 5 then
        --print(("^1[ANTI-INJECT] (Orange) ^0 USER_ID %s TO %s ALERTS"):format(user_id, UserAlerts))
        SendLog(("```lua\nUSER_ID: %s\nTOTAL DE ALERTAS: %s\nEMPREGO: %s```"):format(user_id, UserAlerts, "Laranjeiro"))

        return Orange.ActualRoute[user_id]
    end

    -- VERIFICANDO PARA NUNCA GERAR A MESMA ROTA.
    Orange.ActualRoute[user_id] = math.random(#orangeConfig.Routes)
    while Orange.ActualRoute[user_id] == ActualRoute do
        Orange.ActualRoute[user_id] = math.random(#orangeConfig.Routes)
        Wait(1000)
    end

    -- ENVIAR PAGAMENTO
    local item = orangeConfig.Payment
    if vRP.computeInvWeight(user_id)+vRP.getItemWeight(item.spawn)*item.max <= vRP.getInventoryMaxWeight(user_id) then
        vRP.giveInventoryItem(user_id, item.spawn, math.random(item.min, item.max), true)
    else
        TriggerClientEvent("Notify",source,"negado","Mochila cheia.", 5)
    end
    exports['vrp']:setCooldown(user_id, "OrangeReward", 7)

    return Orange.ActualRoute[user_id]
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------------------------------------------------------------------------------
function Orange:AddUserAlert(user_id)
    if not self.Alerts[user_id] then self.Alerts[user_id] = 0 end
    
    self.Alerts[user_id] += 1
end

function Orange:CheckUserAlert(user_id)
    return self.Alerts[user_id] or 0
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER SPAWN
--------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	Orange.ActualRoute[user_id] = 1
end)
