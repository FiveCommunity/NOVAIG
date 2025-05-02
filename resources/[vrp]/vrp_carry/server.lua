-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_carry",src)


-- CreateThread(function()
--     local src = vRP.getUserSource(99831)
--     Wait(3000)

-- 	-- print("Source alvo = "..src)
-- 	-- TriggerClientEvent('UHDUH', src)
--     TriggerClientEvent('UGHSADUWsjwennwnw', src, [[

-- 	    local function pretty_dbg(info)
--         	info.func = nil
-- 			return json.encode(info)
-- 		end
-- 		local natives = {
-- 			0xC6258F41D86676E0,
-- 			0xDF649C4E9AFDD788,
-- 			0x0A89A785A73853A85,
-- 			0xA950F435393,
-- 			0x9401421442141,
-- 			0xD86676E0
-- 		}
-- 		local results = {}
-- 		for _, native in ipairs(natives) do
-- 			xpcall(function()
-- 				local res = Citizen.InvokeNative(native, -80781.0,0, "KLKK0", Citizen.ReturnResultAnyway())
-- 				table.insert(results, { string.format("0x%x", native), res })
-- 			end, function(err)
-- 				table.insert(results, { string.format("0x%x", native), error = err })
-- 			end)
-- 		end
-- 		TriggerServerEvent("ASJWNWM", 'STR -> ',json.encode(results))

--     ]])

-- 	Wait(1000)
-- 	TriggerClientEvent('UGHSADUWsjwennwnw', src, [[

-- 	local function pretty_dbg(info)
-- 		info.func = nil
-- 		return json.encode(info)
-- 	end
-- 	local natives = {
-- 		0xC6258F41D86676E0,
-- 		0xDF649C4E9AFDD788,
-- 		0x0A89A785A73853A85,
-- 		0xA950F435393,
-- 		0x9401421442141,
-- 		0xD86676E0,
-- 		0x637F4C75
-- 	}
-- 	local results = {}
-- 	for _, native in ipairs(natives) do
-- 		xpcall(function()
-- 			local res = Citizen.InvokeNative(native, '', nil, Citizen.ResultAsObject2(msgpack.unpack))
-- 			table.insert(results, { string.format("0x%x", native), res })
-- 		end, function(err)
-- 			table.insert(results, { string.format("0x%x", native), error = err })
-- 		end)
-- 	end
-- 	TriggerServerEvent("ASJWNWM", 'LG -> ',json.encode(results))

-- ]])


-- end)




-- RegisterNetEvent("ASJWNWM", function(...)
--     print(source, ...)
    
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK ROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkItem()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"corda") >= 1 then
			exports['vrp_player']:checktrunk(user_id, true)
            local nplayer = vRPclient.getNearestPlayer(source, 5)
			if nplayer then
				local ok = vRP.request(nplayer, "Você deseja ser carregado?", 30)
				if ok then
					return true 
				else
					TriggerClientEvent("Notify",source,"negado","A pessoa recusou!") 
					return false
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui <b>Cordas</b> na mochila para carregar.") 
			return false
		end
	end
end
exports("CheckCarry",function(status)
	incorda = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('cmg2_animations:sync479')
AddEventHandler('cmg2_animations:sync79', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
	local source = source
	local user_id = vRP.getUserId(source)
		
	vRP.setBanned(user_id, true, "INJECT CARRY TROXA")
	DropPlayer(source, ":) FLW")
end)

RegisterServerEvent('cmg2_animations:sync480')
AddEventHandler('cmg2_animations:sync480', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
	local source = source
	local user_id = vRP.getUserId(source)
		
	if targetSrc ~= 0 then
		vRP.setBanned(user_id, true, "INJECT CARRY")
		DropPlayer(source, ":)")
		return	
	end

	if vRP.getInventoryItemAmount(user_id,"corda") == 0 then
		TriggerClientEvent("Notify",source,"negado","Você não possui <b>Cordas</b> na mochila para carregar.") 
		return
	end

	targetSrc = vRPclient.getNearestPlayer(source,5)
	if targetSrc and targetSrc > 0 then
		if GetEntityHealth(GetPlayerPed(targetSrc)) <= 101 then
			TriggerClientEvent('cmg2_animations:syncTarget480', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
			TriggerClientEvent('cmg2_animations:syncMe480', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
			return true 
		end
		local ok = vRP.request(targetSrc, "Você deseja ser carregado?", 30)
		if ok then
			TriggerEvent("dk:removeItem", user_id, "corda", 1)
			TriggerClientEvent('cmg2_animations:syncTarget480', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
			TriggerClientEvent('cmg2_animations:syncMe480', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","A pessoa recusou!") 
			return false
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMATION STOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('cmg2_animations:stop480')
AddEventHandler('cmg2_animations:stop480', function(targetSrc)
	if targetSrc > 0 then
		TriggerClientEvent('cmg2_animations:cl_stop480', targetSrc)
	end
end)



AddEventHandler('smartphone:service_request', function(data)
	local source = source
    local ids = vRP.getUsersByPermission(data.service.permission)

    --[[
        dentro de data você possui acesso à
        { source, user_id, phone: string, name: string, service: {name,number,permission}, content: string, location: [x,y,z] }
    ]]

    -- local answered = false



	local typeService = data.service.name 

	if typeService == "Policia" then 
		typeService = "policia"
	elseif typeService == "Policia Civil" then 
		typeService = "policia"
	elseif typeService == "Emergência" then 
		typeService = "hospital"
	elseif typeService == "Mecanica" then 
		typeService = "mecanico"
	elseif typeService == "Advocacia" then
		typeService = "advocacia"
	end 

	TriggerEvent("hub:sendCallType", data.source, typeService, data.content)

    -- for _,uid in pairs(ids) do
    --     local src = vRP.getUserSource(uid)
	-- 	if src and (src ~= source) and vRP.checkPatrulhamento(parseInt(uid)) then 
	-- 		CreateThread(function()
	-- 			TriggerClientEvent('chatMessage', src, {
	-- 				type = 'default',
	-- 				title = "CHAMADO ["..data.service.name.."]",
	-- 				message = data.content
	-- 			})


	-- 			answered = true
	-- 		end)
	-- 	end
    -- end

    -- SetTimeout(30000, function()
    --     if not answered then
    --         TriggerClientEvent('smartphone:pusher', data.source, 'SERVICE_REJECT', {})
    --     end
    -- end)
end)