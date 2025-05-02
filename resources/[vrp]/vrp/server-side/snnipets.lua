local pressetHooks = {
    ["ENTRADA"] = {""},
    ["SAIDA"] = {""},
    ["DROPAR"] = {""},
    ["ENVIAR"] = {""},
    ["EQUIPAR"] = {""},
    ["GARMAS"] = {""},
    ["SAQUEAR"] = {"https://discord.com/api/webhooks/1282362751276028039/VIrJj_bT8jRbtYLlRv_LwCDfvpa2ZjlvqOEZsuQzQYGRAhdohpo2xmVjCzjXGayZwHn3"},
    ["BAUCARRO"] = {""},
    ["BAUCASAS"] = {"https://discord.com/api/webhooks/1304881946366574742/a-eGEGBtcrC62eeYDOhoIvuENDkQc7FJm4XlvaUHHyuGVpL3i4gJbmJPPgxo5xpNVA0r"},
    ["CRASHS"] = {""},
    ["MORTE"] = {""},
    ["ROUBOGERAIS"] = {""},
    ["ROUBOAMMU"] = {""},
    ["ROUBOCAIXA"] = {""},
    ["ROUBOREGISTRADORA"] = {""},
    ["BANCODEPOSITAR"] = {""},
    ["BANCOSACAR"] = {""},
    ["BANCOENVIAR"] = {""},
    ["COMPRARVEICULO"] = {""},
    ["WL"] = {""},
    ["IDS"] = {""},
    ["TPTO"] = {""},
    ["TPTOME"] = {""},
    ["GOD"] = {""},
    ["GOID"] = {""},
    ["KICK"] = {""},
    ["CAPUZ"] = {""},
    ["BAN"] = {""},
    ["PRENDERADM"] = {""},
    ["AADM"] = {""},
    ["KILL"] = {""},
    ["ITEM"] = {""},
    ["TPWAY"] = {""},
    ["ACEITARCHAMADOADMIN"] = {""},
    ["GROUPADD"] = {""},
    ["GROUPREM"] = {""},
    ["SPAWNCAR"] = {""},
    ["MONEY"] = {""},
    ["BATERPONTOBENNYS"] = {""},
    ["BATERPONTOPOLICIA"] = {""},
    ["BATERPONTOHOSPITAL"] = {""},
    ["BATERPONTOADMIN"] = {""},
    ["PRENDER"] = {""},
    ["DESMANCHE"] = {""},
    ["COPYPRESET"] = {"https://discord.com/api/webhooks/1304882663307346063/grQh3PcNp-4QabU4LxpFj8U43yZlnJyUDniPAOXqHhJ2hiGiEto5QO1QHeUJk1nNXFex"},
    ["SETPRESET"] = {""},
    ["REVISTARADM"] = {""},
    ["VAULTADM"] = {""},
    ["HOUSEADMCHEST"] = {""},
    ["FUEL"] = {""},
    ["LOCKPICK"] = {""},
    ["ADDCARRO"] = {""},
    ["RENOMEAR"] = {""},
    ["CRAFT"] = {""},
    ["KITMALOKERO"] = {""},
    ["ITEMP"] = {""},
    ["GETITEM"] = {""},
    ["REMCARRO"] = {""},
    ["REC"] = {""},
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD WEEBHOOK
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.sendLog(weebhook, mensagge)
    if weebhook and mensagge then
        if pressetHooks[weebhook] ~= nil then
            SendWebhookMessage(pressetHooks[weebhook][1],mensagge)
        else
            SendWebhookMessage(weebhook,mensagge)
        end
    end
end

-- local api = "http://api.c1-tiny-x86-sao-paulo-1.dacsistemas.com.br:15672/api/exchanges/%2F/fivem.lotusgroup.capitalrj/publish"
-- function exports["vrp_admin"]:generateLog(payload)
--     payload.time = os.time()

--     local content = {
-- 		properties = {
-- 			delivery_mode = 2,
-- 			content_type = "application/json"
-- 		},
-- 		routing_key = "",
--         payload = json.encode(payload),
-- 		payload_encoding = "string"
-- 	}

--     PerformHttpRequest(api, function(err, text, headers)
--     end, 'POST', json.encode(content), { ['Authorization'] = 'Basic bG90dXNncm91cDoxMjM0' })
-- end

function SendWebhookMessage(webhook,message)
    if webhook ~= "none" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end

function vRP.log(file,info)
    file = io.open(file, "a")
    
    if file then
        file:write("» "..info.."\r")

        file:close()
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DESLOGAR DENTRO DA PROPRIEDADE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.atualizarPosicao(user_id,x,y,z)
    local data = vRP.getUserDataTable(user_id)
    if user_id then
        if data then
            data.position = { x = x, y = y, z = z }
        end
    end
end

function vRP.limparArmas(user_id)
    local data = vRP.getUserDataTable(user_id)
    if user_id then
        if data then
            data.weapons = {}
        end
    end
end