 ----==={ VARIÁVEIS }===----

inPainel = false
RobberyPoints,blips,robberyHappen, robberyBlips = {},{},{}, {}
isInRobbery = false
inSelectTeam = false
ActualRobbery,Team = nil
setmetatable(blips, {__index = table})

----==={ COMANDOS }===----

RegisterCommand('lotus',function(source,args)
    local source = source
    if args[1] ~= 'roubos' then return end
    print('> open roubos')
    if vSERVER.getPermission(Config.Roubos.cmdPermission) then
        if not inPainel then 
            OpenNUI({action = 'openAdminPainel'},true)
        end
    else
        TriggerEvent('nova_roubos:robnotify','negado','Sem permissão!',8000)
    end
end)

function OpenScoreboard()
    if isInRobbery and not inPainel then
        if type(ActualRobbery) ~= 'table' then return end
        OpenNUI({ action = 'OpenScoreboard', robbery = ActualRobbery, team = Team or tostring(vSERVER.GetMyTeam(ActualRobbery)) },true)
    end
end

RegisterCommand('nova_roubos:openscoreboard', OpenScoreboard) -- COMANDO PARA ABRIR SCOREBOARD

CreateThread(function()
    RegisterKeyMapping('nova_roubos:openscoreboard','Abrir Scoreboard','KEYBOARD',tostring(Config.Roubos.openScoreboardKey))
    SetTimeout(2000, function() 
        OpenNUI({action = 'UpdatingHud', robbery = false},false) 
    end)
end)

----==={ THREADS (CITIZEN) }===----

 CreateThread(function() -- MARKER
    repeat
        local sleep = 1000
        local ped = PlayerPedId()
        local cds = GetEntityCoords(ped)
        for k,v in next,(RobberyPoints or {}) do
            local distance = #( cds - vec3(v.cds.x,v.cds.y,v.cds.z) )
            sleep = 1
            DrawMarker(21,v.cds.x,v.cds.y,v.cds.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,100,0,0,0,1)
            if distance < 1.5 then
                DrawText3D(v.cds.x,v.cds.y,v.cds.z, 'PRESSIONE ~r~E ~w~PARA ROUBAR')
                if IsControlJustPressed(0,38) and GetEntityHealth(ped) > 101 and not inPainel then
                    local err,msg,add = vSERVER.tryRobbery(v)
                    if err then
                        if msg then 
                            if not add or type(add) ~= 'table' or not add.key then return end
                            if type(add.proj) == 'table' then
                                local message = { action = 'BanditsTeam', key = add.key, name = err, nusers = msg, projection = add.proj, bandlimit = add.bandlimit  }
                                inSelectTeam = true
                                OpenNUI(message,true)
                            end
                        end
                    else
                        TriggerEvent('nova_roubos:robnotify','negado',tostring(msg),8000)
                    end
                end
            end
        end
        Wait(sleep)
    until false
end)

----==={ LISTA DE CALLBACKS }===----

local CallBacks = {
    ['openHistoricRobberys'] = function(data)
        if type(data) ~= 'table' then 
            return {}
        end

        data.limit = 50
        data.offset = 0
        if data.limit and data.offset then
            return vSERVER.getHistoric(data.offset,data.limit)
        end
    end,
    ['createPreset'] = function(data)
        if type(data) ~= 'table' then 
            return 
        end
        return vSERVER.createPreset(data)
    end,
    ['deletePreset'] = function(data)
        if not data.name then return end 
        return vSERVER.deletePreset(data.name)
    end,
    ['getPresets'] = function(data)
        return vSERVER.getPresets() 
    end,
    ['getRobberies'] = function(data)
        return vSERVER.getRobberies()
    end,
    ['getPresetsName'] = function(data)
        return vSERVER.getPresetsName() or {}
    end,
    ['getCoords'] = function(data)
        local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
        return { x = x or 0.0, y = y or 0.0, z = z or 0.0 }
    end,
    ['addRobbery'] = function(data)
        if not data.preset or not data.cds or not data.cds.x or not data.cds.y or not data.cds.z then 
            return 
        end
        return vSERVER.addRobbery(data)
    end,
    ['remRobbery'] = function(data)
        if data.count then
            return vSERVER.remRobbery(data.count)
        end
    end,
    ['takeBanditsForRob'] = function(data)
        inSelectTeam = false
        print('takeBanditsForRob',json.encode(data))
        if type(data) ~= 'table' or not data.key or not data.bandits or not data.hostages then 
            print('Algum dado não foi recebido!')
            return {status = false, msg = 'Algum dado não foi recebido!'} 
        end

        print('(Client) Linha 132')

        local response = vSERVER.tryStartRobbery(tonumber(data.key),data.bandits,data.hostages) -- INTRODUZIR KEY COMO PRIMEIRO PARÂMETRO, TIRAR O PARÂMETRO NAME, POIS DA PRA PEGAR O NAME SABENDO A KEY!
        print('(Client) Linha 133')
        if not response.status then 
            print(json.encode(response))
            TriggerServerEvent('nova_roubos:tryrobnotify', tonumber(data.key), 'negado', tostring(response.msg), 8000)
            vSERVER.cancelRobbery(data.key)
            return false
        end

        return response
    end,
    ['takeCopsForRob'] = function(data)
        CloseNUI()
        inSelectTeam = false
        if type(data) ~= 'table' or not tonumber(data.key) or not data.cops then 
            return 
        end
        local err,msg = vSERVER.approveRobbery(tonumber(data.key),data.cops)
        if not err then
            print(tostring(msg))
            TriggerServerEvent('nova_roubos:tryrobnotify', tonumber(data.key), 'negado', tostring(msg), 8000)
            vSERVER._cancelRobbery(data.key)
            return
        end

        stopTabletAnimation()
    end,
    ['getGiveUpInfos'] = function(data)
        local consult = vSERVER.getStateForGiveUp(Team)
        return consult
    end,
    ['voteGiveUpinRobbery'] = function(data)
        local result = vSERVER.voteRobberyGiveUp(Team)
        if result.status then
            CloseNUI()
        end
        return result
    end,
    ['initAction'] = function (data)
        print(json.encode(data))
    end,
    ['closePainel'] = function(data)
        CloseNUI()
        if data.key and inSelectTeam then
            TriggerServerEvent('nova_roubos:tryrobnotify', tonumber(data.key), 'negado', 'A seleção de time foi cancelada!', 8000)
            vSERVER.cancelRobbery(data.key)
            inSelectTeam = false
        end
    end,
}

local cfg = { API_ROUTE = tostring(GetCurrentResourceName())..'_API' }
RegisterNUICallback(cfg.API_ROUTE, function(data,cb)
        print('_API '..data.cb)
    local handler = CallBacks[tostring(data.cb)]
    if not handler then return end
    local res = handler(data)
    if res ~= nil then
        cb(res)
    end
end)