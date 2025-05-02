---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE LOGS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("site/insert_user", "INSERT IGNORE INTO `site-accounts`(staff_id, discord_id) VALUES(@staff_id, @discord_id)")
vRP.prepare("site/list_users", "SELECT * FROM `site-accounts`")
vRP.prepare("site/delete_user", "DELETE FROM `site-accounts` WHERE staff_id = @staff_id")

-- local API_KEY = 'DWHdnDnj#38j111MNj4A3R8skP'
-- local API_URL = 'https://lotusgroup.k8s.dacsistemas.com.br/logcentralizer/altarj/api/'

-- local QUEUE_URL = "https://rabbitmq.k8s.kubosoft.com.br/gw/publish?queue=fivem.lotusgroup.altarj"

function generateLog(payload)
    payload.time = os.time()

    local content = {
		properties = {
			delivery_mode = 2,
			content_type = "application/json"
		},
		routing_key = "",
        payload = json.encode(payload),
		payload_encoding = "string"
	}

    PerformHttpRequest(QUEUE_URL, function(err, text, headers)
    end, 'POST', json.encode(content), { ['Authorization'] = 'Basic bG90dXNncm91cDoxMjM0' })
end

exports('generateLog', generateLog)

function GenerateUser(payload)
	local result

    PerformHttpRequest(API_URL.."user/create/", function(err, text, headers)
		result = err
        -- print(result)
    end, 'POST', json.encode(payload), { 
		['Content-Type'] = "application/json",
		['API-KEY'] = API_KEY
	})

	while result == nil do
		Wait(1000)
	end

	return result
end

function RemoveUser(user)
	local result

    PerformHttpRequest(API_URL.."user/delete/"..user, function(err, text, headers)
		result = err
    end, 'DELETE', json.encode(payload), { 
		['API-KEY'] = API_KEY
	})

	while result == nil do
		Wait(1000)
	end

	return result
end

local authorizedUsers = {
    [553] = true,
}

RegisterCommand('criar-usuario', function(source,args)
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    -- 3323 é o JONH
    if vRP.hasPermission(user_id, "developer.permissao") or authorizedUsers[user_id] then

        local staff_id = vRP.prompt(source, "Digite o ID Do Staff: ", 0)
        if not staff_id or staff_id == "" then return end
        staff_id = parseInt(staff_id)
        staff_src = vRP.getUserSource(staff_id)
        
        local discord_id = vRP.prompt(source, "Digite o Discord ID do Staff: ", "")
        if not staff_id or discord_id == "" then return end

        if tonumber(staff_id) ~= nil and tonumber(discord_id) ~= nil then
            local Result = GenerateUser({
                FiveMId = staff_id,
                DiscordId = discord_id,
            })
    
            if not Result then
                TriggerClientEvent("Notify",source,"negado","Houve um problema ao liberar o acesso ao LOG, contate algum responsavel.", 60000)
                return
            end
    
            if staff_src then
                TriggerClientEvent("Notify",staff_src,"sucesso","Você foi liberado para acessar o sistema de LOGS!", 60000)
            end 
    
            TriggerClientEvent("Notify",source,"sucesso","Liberação ao sistema de LOGS realizada com sucesso!", 60000)
            vRP.execute('site/insert_user', { 
                staff_id = staff_id,
                discord_id = discord_id
            })
        else
            TriggerClientEvent("Notify",source,"sucesso","Os IDS informados devem ser um número.", 60000)
        end
    end
end)

RegisterCommand('deletar-usuario', function(source,args)
	local user_id = vRP.getUserId(source)

	if vRP.hasPermission(user_id, "developer.permissao") or authorizedUsers[user_id] then 

        local ply_id = vRP.prompt(source, "Digite o User_Id: ", "")
        if ply_id == "" or not ply_id or not tonumber(ply_id) then
            return
        end

		local Result = RemoveUser(ply_id)

		if not Result then
			TriggerClientEvent("Notify",source,"negado","Houve um problema ao deletar e desconectar essa conta, contate algum responsavel.", 60000)
			return
		end

		TriggerClientEvent("Notify",source,"sucesso","Conta desconectada e deletada do site de logs com sucesso.", 60000)

		vRP.execute("site/delete_user", { 
			staff_id = ply_id 
		})
	end
end)

RegisterCommand('listar-usuarios', function(source,args)
	local user_id = vRP.getUserId(source)
	if not user_id then return end
	if vRP.hasPermission(user_id, "developer.permissao") then 

		local queries = vRP.query("site/list_users")
		local maxEntries = 1000
		local usersPerLog = 20
		local logData = {}
        local usersCounted = 0
        local logNumber = 1
        
        for i = 1, math.min(maxEntries, #queries) do
            if not logData[logNumber] then logData[logNumber] = "" end
            logData[logNumber] = logData[logNumber] .. string.format("[STAFF ID]: %s\n[DISCORD_ID]: %s\n\n", queries[i].staff_id, queries[i].discord_id)
            usersCounted = usersCounted + 1
        
            -- Quando a contagem de usuários atingir 20, aumente o número do log e resete a contagem
            if usersCounted == usersPerLog then
                logNumber = logNumber + 1
                usersCounted = 0
            end
        end
        
        for i = 1, logNumber do
            -- print("Número de usuários no bloco de log " .. i .. ": " .. ((i < logNumber and usersPerLog) or usersCounted))
            Log("```js\n[NUMBER] "..i.."\n" .. (logData[i] or "") .. "```")
            Wait(300)
        end
	end
end)

function Log(message)
	PerformHttpRequest("https://discord.com/api/webhooks/1113930158068486257/jkVMsmhh6k72bMUkxwMYYo9b3yOdLW6TdtWAwZA0zUg9fdVEk5x2e04v_gc3dU-JSUDo", function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
end

-- CreateThread(function()
--     PerformHttpRequest(API_URL.."city/disconectAll", function(err, text, headers)
-- 		if err == 200 then
--             -- print("^1[JOHN-LOGS]^0 ATENÇÃO: Todos os usuarios foram desconectados do sistema de logs.")
--         end

--     end, 'POST', json.encode({}), { 
--         ['Content-Type'] = "application/json",
-- 		['API-KEY'] = API_KEY
-- 	})
-- end)


local userConnects = {}

RegisterServerEvent('JohnLogs:checkPlayer', function(data, cb)
    -- if data.player_id == 1 or data.player_id == 2 or data.player_id == 3 or data.player_id == 21 or data.player_id == 22 or data.player_id == 23 or data.player_id == 664 or data.player_id == 677 then 
    --     cb({validation = true})
    --     userConnects[data.player_id] = true
    --     -- print(("^1[JOHN-LOGS]^0 O User_id ^2%s^0 utilizou bypass para conectar nas logs."):format(data.player_id))
    --     return
    -- end

    if not data.player_id then cb({ validation = false }) return end

    local user_id = data.player_id
    -- if user_id == 9 then
    --     cb({ validation = true })
    --     userConnects[user_id] = true
    --     -- print(("^1[JOHN-LOGS]^0 O User_id ^2%s^0 utilizou bypass para conectar nas logs."):format(user_id))
    --     return
    -- end

    local userActive = vRP.getUserSource(user_id)
    if not userActive then
        -- print(("^1[JOHN-LOGS]^0 O User_id ^2%s^0 tentou se conectar porem não está conectado no servidor."):format(user_id))
        cb({ validation = false }) 
        return
    end

    if vRP.hasPermission(user_id, 'staffoff.permissao') then
        -- print(("^1[JOHN-LOGS]^0 O User_id ^2%s^0 tentou se conectar porem não possuí permissão no servidor."):format(user_id))
        cb({ validation = false }) 
        return
    end

    if vRP.hasPermission(user_id, 'player.blips') then
        cb({ validation = true })
        userConnects[user_id] = true

        -- print(("^1[JOHN-LOGS]^0 O User_id ^2%s^0 se conectou ao site de logs com sucesso."):format(user_id))
        return
    end

    -- print(("^1[JOHN-LOGS]^0 O User_id ^2%s^0 não atende aos requisitos mínimos."):format(user_id))
    cb({ validation = false }) 
    return
end)

AddEventHandler("playerDropped", function(reason)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    -- if user_id == 9 then 
    --    return
    -- end

    if userConnects[user_id] then
        userConnects[user_id] = false

        PerformHttpRequest(API_URL.."user/revokeToken", function(err, text, headers)
            if err == 200 then
                -- print(("^1[JOHN-LOGS]^0 O User_id ^2%s^0 deslogou e foi desconectado do site de logs."):format(user_id))
            end
        end, 'POST', json.encode({fivem_id = user_id}), { 
            ['Content-Type'] = "application/json",
            ['API-KEY'] = API_KEY
        })
    end
end)

RegisterCommand('validar-usuario', function(source,args)
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    if not vRP.hasPermission(user_id, 'admin.permissao') then return end

    local ply_id = args[1]
    if ply_id == "" or not ply_id or not tonumber(ply_id) then
        return
    end

    if not userConnects[ply_id] then
        TriggerClientEvent('Notify',source,'negado',"Este Jogador não está ativo no site de logs.")
        return
    end

    local GENERATE_KEY = vRP.generateStringNumber("LDLDLD")
    TriggerClientEvent('Notify',source,'importante',"O code solicitado foi: "..GENERATE_KEY)

    PerformHttpRequest(API_URL.."user/checkCode/"..ply_id, function(err, text, headers)
        if err == 200 then
            -- print(("^1[JOHN-LOGS]^0 O Staff ID ^2%s^0 solicitou a validação do codigo ^2%s^0 para o User ID ^2%s^0."):format(user_id, GENERATE_KEY, ply_id))
        end
    end, 'POST', json.encode({ code = GENERATE_KEY }), { 
        ['Content-Type'] = "application/json",
        ['API-KEY'] = API_KEY
    })
end)
--[[
RegisterCommand('desconectar-usuarios', function(source,args)
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    if not vRP.hasPermission(user_id, 'developer.permissao') then return end

    TriggerClientEvent('Notify',source,'sucesso',"Todos os usuarios foram desconectados do sistema de logs.")

    PerformHttpRequest(API_URL.."city/disconectAll", function(err, text, headers)
		if err == 200 then
            -- print(("^1[JOHN-LOGS]^0 O Staff ID %s desconectou todos os usuarios do site de logs."):format(user_id))
        end

    end, 'POST', json.encode({}), { 
        ['Content-Type'] = "application/json",
		['API-KEY'] = API_KEY
	})
end)


RegisterCommand('force_quit', function(source)
    local user_id = vRP.getUserId(source)
    if not user_id then return end
    if userConnects[user_id] == true then
        userConnects[user_id] = false
        PerformHttpRequest(API_URL.."user/revokeToken", function(err, text, headers)
            if err == 200 then
                -- print(("^1[JOHN-LOGS]^0 O User_id ^2%s^0 deslogou e foi desconectado do site de logs."):format(user_id))
            end
        end, 'POST', json.encode({fivem_id = user_id}), { 
            ['Content-Type'] = "application/json",
            ['API-KEY'] = API_KEY
        })
    end
end)--]]