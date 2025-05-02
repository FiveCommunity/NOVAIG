local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

ServerAPI = {}
Tunnel.bindInterface("vrp_animacoes",ServerAPI)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /e
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('e', function(source,args,rawCommand)
	TriggerClientEvent("emotes",source,args[1])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /e2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('e2', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasGroup(user_id,'Admin') or vRP.hasGroup(user_id,'Ceo') then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent("emotes",nplayer,args[1])
		end
	end
end)

RegisterCommand('e4',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"developer.permissao") then
		

		local distance = tonumber(args[2])
		if not distance then return end

		local nplayers = vRPclient.getNearestPlayers(source, distance)
		for k,v in pairs(nplayers) do
			async(function()
				TriggerClientEvent("emotes",parseInt(k),args[1])
			end)
		end

		TriggerClientEvent("Notify",source,"negado","Você usou e4 em "..distance.. " metro(s)", 5) 
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEIJAR PEDINDO PRA OUTRA PESSOA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("beijo",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRPclient.getNearestPlayer(source,2)
    if nplayer then
        local request = vRP.request(nplayer,"Deseja bejiar ?",10)
        if request then
            vRPclient.playAnim(source,true,{{"mp_ped_interaction","kisses_guy_a"}},false)    
            vRPclient.playAnim(nplayer,true,{{"mp_ped_interaction","kisses_guy_b"}},false)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PANO
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterServerEvent("tryclean")
-- AddEventHandler("tryclean",function(nveh)
-- 	TriggerClientEvent("syncclean",-1,nveh)
-- end)

function ServerAPI.checkCommands()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return exports["vrp"]:checkCommand(user_id)
    end

    return false
end