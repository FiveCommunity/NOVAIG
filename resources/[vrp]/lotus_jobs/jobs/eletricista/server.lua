--------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------------------------------------------------------------------------------
Eletricist = {
    ActualRoute = {},
    Alerts = {}
}

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
--------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.EletricistCollect(Route)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    -- VERIFICANDO SE EXISTE UMA ROTA VALIDA
    local ActualRoute = Eletricist.ActualRoute[user_id]
    if not ActualRoute then
        --print(("^1[ANTI-INJECT] (Eletricist) ^0USER_ID %s NOT ROUTE DEFINED"):format(user_id))

        Eletricist.ActualRoute[user_id] = 1
        return Eletricist.ActualRoute[user_id]
    end

    -- VERIFICANDO SE A ROTA FOR DIFERENTE DAS IGUAIS
    if ActualRoute ~= Route then
        Eletricist:AddUserAlert(user_id)
        --print(("^1[ANTI-INJECT] (Eletricist) ^0USER_ID %s ROUTE %s COLLECTED ROUTE %s"):format(user_id, ActualRoute, Route))
        
        return Eletricist.ActualRoute[user_id]
    end

    -- VERIFICAR COORDENADAS
    local PlyCoords = GetEntityCoords(GetPlayerPed(source))
    local Coords = eletricistConfig.Routes[ActualRoute].coords
    local Dist = #(vec3(Coords.x,Coords.y,Coords.z) - PlyCoords)
    if Dist >= 30 then
        Eletricist:AddUserAlert(user_id)
        --print(("^1[ANTI-INJECT] (Eletricist) ^0USER_ID %s DISTANCE TO ROUTE %s"):format(user_id, Dist))

        return Eletricist.ActualRoute[user_id]
    end

    -- VERIFICANDO TEMPO DAS ULTIMAS COLETAS
    local status, time = exports['vrp']:getCooldown(user_id, "EletricistReward")
    if not status then
        Eletricist:AddUserAlert(user_id)
        --print(("^1[ANTI-INJECT] (Eletricist) ^0USER_ID %s VERY FAST FARMING %s REMANING SECONDS"):format(user_id, time))
        return Eletricist.ActualRoute[user_id]
    end

    -- VERIFICANDO ALERTAS
    local UserAlerts = Eletricist:CheckUserAlert(user_id)
    if UserAlerts >= 5 then
        --print(("^1[ANTI-INJECT] (Eletricist) ^0 USER_ID %s TO %s ALERTS"):format(user_id, UserAlerts))
        SendLog(("```lua\nUSER_ID: %s\nTOTAL DE ALERTAS: %s\nEMPREGO: %s```"):format(user_id, UserAlerts, "Eletricistador"))

        return Eletricist.ActualRoute[user_id]
    end

    -- VERIFICANDO PARA NUNCA GERAR A MESMA ROTA.
    Eletricist.ActualRoute[user_id] = math.random(#eletricistConfig.Routes)
    while Eletricist.ActualRoute[user_id] == ActualRoute do
        Eletricist.ActualRoute[user_id] = math.random(#eletricistConfig.Routes)
        Wait(1000)
    end

    -- ENVIAR PAGAMENTO
    vRP.giveMoney(user_id, eletricistConfig.Payment)

    exports['vrp']:setCooldown(user_id, "EletricistReward", 7)

    return Eletricist.ActualRoute[user_id]
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------------------------------------------------------------------------------
function Eletricist:AddUserAlert(user_id)
    if not self.Alerts[user_id] then self.Alerts[user_id] = 0 end
    
    self.Alerts[user_id] += 1
end

function Eletricist:CheckUserAlert(user_id)
    return self.Alerts[user_id] or 0
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER SPAWN
--------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	Eletricist.ActualRoute[user_id] = 1
end)
