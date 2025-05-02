local combatlog = {}

function lRoubos.getPermission(perm)
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 
    return vRP.hasPermission(user_id,perm)
end

function lRoubos.getHistoric(i,j)
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 
    if not vRP.hasPermission(user_id,Config.Roubos.cmdPermission) then return false end
    local data = lotusRoubos:getHistoricRobberys(i,j)
    return data
end

function lRoubos.createPreset(i)
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 

    if not vRP.hasPermission(user_id,'developer.permissao') then 
        vRP.setBanned(user_id, true, '(Tunnel) Create Preset Roubos', _, _, 2)
        return 
    end 

    local data = lotusRoubos:createPreset(i)
    return data
end

function lRoubos.deletePreset(i)
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 

    if not vRP.hasPermission(user_id,'developer.permissao') then 
        vRP.setBanned(user_id, true, '(Tunnel) Delete Preset Roubos', _, _, 2)
        return 
    end 

    local data = lotusRoubos:deletePreset(i)
    return data
end

function lRoubos.getPresets()
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 
    local data = lotusRoubos:getDataPresets()
    return data
end

function lRoubos.getRobberies()
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 
    local data = lotusRoubos:getDataRobberies()
    return data
end

function lRoubos.getPresetsName()
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 
    local consult = vRP.query('lotusRoubos/getAllPresetsName')
    local response = {}
    if #consult > 0 then
        for k,v in next,consult do
            if v.name then
                table.insert(response,tostring(v.name))
            end
        end
    end
    return response
end

function lRoubos.cancelRobbery(i)
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 
    lotusRoubos:cancelRobbery(i)
end

function lRoubos.addRobbery(i)
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 
    local data = lotusRoubos:addRobbery(i)
    return data
end

function lRoubos.remRobbery(i)
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 
    local data = lotusRoubos:remRobbery(i)
    return data
end

function lRoubos.tryRobbery(i)
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 
    if vRP.hasPermission(user_id,Config.Roubos.policePermission) then 
        return false,'Você é policial, e não pode roubar!' 
    end
    local a,b,c = lotusRoubos:tryRobbery(user_id,i)
    return a,b,c
end


function lRoubos.tryStartRobbery(a,b,c)
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 

    local data = lotusRoubos:tryStartRobbery(a,b,c)
    return data
end

function lRoubos.approveRobbery(a,b)
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 
    local a,b = lotusRoubos:approveRobbery(a,b)
    return a,b
end

function lRoubos.GetMyTeam(obj)
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 
    for team, members in pairs(obj) do
        if type(members) == 'table' then
            for _, member in ipairs(members) do
                if type(member) == 'table' and member.id == user_id then return tostring(team) end
            end
        end
    end
    return nil
end

function lRoubos.getStateForGiveUp(team)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end 
    local InRobbery = { IsInRobbery(source) }
    local key,Team = InRobbery[3],InRobbery[4]
    if key and tostring(Team) == tostring(team) then
        if not tonumber(key) or type(ActualRobberies[tonumber(key)]) ~= 'table' then 
            return { status = false, msg = 'Erro ao pegar as informações de rendição!' }
        end
        local data = GetPlayerTable(source)
        local members = GetGiveUpMembers(tonumber(key),tostring(team))
        return { voted = not not data.giveup, playersAlreadyVoted = members }
    end
end

function lRoubos.voteRobberyGiveUp(i)
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 
    local data = lotusRoubos:voteRobberyGiveUp(i)
    return data
end

RegisterCommand('roubos',function(source,args)
    local source = source 
    local user_id = vRP.getUserId(source)
    if not user_id then return end 

    if not vRP.hasPermission(user_id,'developer.permissao') then 
        return 
    end 

    if not args[1] then 
        TriggerClientEvent('Notify', source, 'negado', 'Use /roubos listar ou /roubos deletar [ID]', 30000)
        return 
    end

    if args[1] == "listar" then 
        local data = lotusRoubos:listRobberys()
        TriggerClientEvent('Notify', source, 'sucesso', data, 30000)
    end 

    if args[1] == "deletar" then 
        if not tonumber(args[2]) then 
            TriggerClientEvent('Notify', source, 'negado', 'Você precisa informar o ID do roubo.', 30000)
            return false
        end


        if not ActualRobberies[tonumber(args[2])] then 
            TriggerClientEvent('Notify', source, 'negado', 'Roubo de ID '..tonumber(args[2])..' não encontrado.', 30000)
            return false
        end

        lotusRoubos:cancelRobbery(tonumber(args[2]))
        TriggerClientEvent('Notify', source, 'sucesso', 'Roubo de ID '..tonumber(args[2])..' deletado com sucesso.', data, 30000)
    end
end)

RegisterNetEvent('vRP:playerSpawn', function(user_id, source)
    vCLIENT._updateRobberyPoints(source,RobberyCache)
    local user_id = vRP.getUserId(source)
    if user_id and (combatlog or {})[user_id] then
        Wait(5000)
        TriggerClientEvent('robnotify',source,'aviso','Você deslogou na última ação, e voltou finalizado!',10000)
        vRPC.setHealth(source,100)
        combatlog[user_id] = nil
    end
end)

AddEventHandler("vRP:playerLeave",function(user_id,source)	
	if GlobalState.ServerRestart then 
		return 
	end

    if user_id then
        if selectMenu[source] and selectMenu[source] ~= nil then
            TriggerEvent('nova_roubos:tryrobnotify', tonumber(selectMenu[source]), 'importante', 'O roubo foi cancelado porque o responsável por escolher time deslogou.', 15000, 'bandits')
            TriggerEvent('nova_roubos:tryrobnotify', tonumber(selectMenu[source]), 'importante', 'O roubo foi cancelado porque o responsável por escolher time deslogou.', 15000, 'cops')
            lotusRoubos:cancelRobbery(tonumber(selectMenu[source]))
            selectMenu[source] = nil
        end
    end
end)	