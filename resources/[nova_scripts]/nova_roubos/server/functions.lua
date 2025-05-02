RobberyCache = {}
ActualRobberies = {} 
RequestRobberies = {}
setmetatable(RobberyCache, {__index = table}) setmetatable(ActualRobberies, {__index = table})
selectMenu = {}

lotusRoubos = {}
lotusRoubos.__index = lotusRoubos

function lotusRoubos.new()
    local self = setmetatable({}, lotusRoubos)
    return self
end

----==={ THREADS (CITIZEN) }===----
        
CreateThread(function()
    Wait(3000)
        
    UpdateRobberyPoints()
end)

function IsInRobbery(source, user) -- VERIFICA SE A PESSOA ESTÁ NO ROUBO, SE ESTIVER, RETORNA TRUE, NOME DO ROUBO, KEY DO ROUBO, NOME DO TIME, KEY DO PLAYER NO TIME DELE 
    if not tonumber(source) then return end
    local user_id = user or vRP.getUserId(source)
    if user_id then
        for robberyKey, robberyData in next, ActualRobberies do
            for teamKey, teamData in next, robberyData do 
                if type(teamData) == 'table' then  
                    for playerIndex = 1, #teamData do  
                        if tonumber(teamData[playerIndex].id) == user_id then 
                            return true, tostring(ActualRobberies[robberyKey].name), tonumber(robberyKey), tostring(teamKey), tonumber(playerIndex)
                        end
                    end
                end
            end 
        end
    end
    return false
end

function UpdateRobberyPoints()
    local update = {}
    setmetatable(update, { __index = table })
    local result = vRP.query('lotusRoubos/getPoint')
    for k,v in next,result do
        update:insert({ preset = v.preset, cds = json.decode(v.cds), count = v.count })
    end
    RobberyCache = update
    vCLIENT._updateRobberyPoints(-1,RobberyCache)
end

function IsPointInCache(count) -- FUNÇÃO QUE DELETA O POINT DE ROUBO DO CACHE
    if not count then return end
    for k,v in next,RobberyCache do
        if v.count == count then
            return true
        end
    end
    return false
end

function DeleteRobberyInCache(count)
    if not count then return end
    for k,v in next,RobberyCache do
        if v.count == count then
            RobberyCache[k] = nil
            return
        end
    end
end

function GenerateRobKey(name,point) -- CRIAR A KEY DO ROUBO
    ActualRobberies:insert({ name = name, point_key = point })
    return #ActualRobberies
end

function GetMinCopsFromProjection(obj)
    local list = {}
    for _, v in pairs(obj) do
        local cops = tonumber(v.cops)
        if cops and not v.disable then
            table.insert(list, cops)
        end
    end
    
    return #list > 0 and math.min(table.unpack(list)) or 0
end

function GetMaxBanditsRobbery(projection, cops) 
    if not projection or type(projection) ~= 'table' then return 0 end
    local bandits = 0
    local numCops = tonumber(#cops)
    for k, v in pairs(projection) do
        local requiredCops = tonumber(v.cops)
        local maxBandits = tonumber(k)
        if requiredCops and maxBandits and requiredCops <= numCops and maxBandits > bandits then
            bandits = maxBandits
        end
    end
    return bandits
end

function GetCopsNeedRobbery(projection,bandits) -- RETORNA O MÁXIMO DE POLICIAIS PARA O ROUBO
    if not projection or type(projection) ~= 'table' then return end
    local sit, cops = projection[parseInt(bandits)], 0
    if type(sit) == 'table' and not sit.disable then
        cops = parseInt(sit.cops)
    end
    return cops
end


function GetRobberyCops(obj)
    if not obj or type(obj) ~= 'table' then return end

    local Cops = {}
    local inRobbery = IsInRobbery

    for _, user_id in next, obj do
        local source = vRP.getUserSource(user_id)
        if source and not inRobbery(source) then
            local identity = vRP.getUserIdentity(user_id) or {}
            local cargo = "?"

            for k, v in next, Config.Hierarquia do
                if vRP.hasGroup(user_id, tostring(v)) then
                    cargo = tostring(v)
                    break
                end
            end
            
            identity.nome = identity.nome or ''
            identity.sobrenome = identity.sobrenome or ''
            table.insert(Cops, { 
                ['name'] = tostring(identity.nome) .. ' ' .. tostring(identity.sobrenome), 
                ['id'] = parseInt(user_id), 
                ['cargo'] = tostring(cargo)  
            })
        end
    end

    -- Ordenar a tabela `Cops` em ordem alfabética pelo nome
    table.sort(Cops, function(a, b)
        return a.id < b.id
    end)

    return Cops
end

function GetRobberyBandits(source,radius) 
    if not source then return false end
    local Bandits = {}
    setmetatable(Bandits, {__index = table})
    local Nusers = vCLIENT.getNearestPlayers(source, radius) or {}
    local inRobbery = IsInRobbery
    Nusers[source] = {0.0, source}
    for k,v in pairs(Nusers) do
        if k then
            local nuser_id = vRP.getUserId(parseInt(k))
            if nuser_id then
                local nidentity = vRP.getUserIdentity(nuser_id)
                if not inRobbery(source) and not vRP.hasPermission(nuser_id, Config.Roubos.policePermission) then
                    Bandits:insert({ name = tostring(nidentity.nome).. " " ..tostring(nidentity.sobrenome),  id = parseInt(nuser_id), fixed = (tonumber(k) == source)})
                end
            end
        end
    end
    return Bandits    
end

local lock = false -- Variável de controle para evitar múltiplas aceitações

function GetBestCop(name, Rkey)
    local Oficiais = vRP.getUsersByPermission(Config.Roubos.policePermission)
    local aceitou = nil

    if #Oficiais < 1 then return false end

    for j, user_id in pairs(Oficiais) do
        local sourceOficial = vRP.getUserSource(tonumber(user_id))
        if sourceOficial and vRP.checkPatrulhamento(user_id) then
            -- Envia a solicitação para todos ao mesmo tempo
            CreateThread(function()
                local accept = vRP.request(sourceOficial, 'Deseja escolher o time do roubo ' .. tostring(name) .. '?', 15)
                if accept then
                    local v_value = vRP.prompt(sourceOficial, "Você realmente deseja montar o time do roubo " .. name .. "?", "Digite sim ou não")
                    if v_value and v_value:lower() == "sim" then
                        -- Verifica e bloqueia múltiplas aceitações
                        if not lock then
                            lock = true -- Bloqueia outras threads
                            aceitou = user_id
                            local identity = vRP.getUserIdentity(tonumber(user_id))
                            local nome = identity.nome .. ' ' .. identity.sobrenome

                            ActualRobberies[tonumber(Rkey)].policeaccept = tonumber(aceitou) or user_id

                            TriggerClientEvent('chatMessage', ActualRobberies[tonumber(Rkey)].pusher, {
                                type = 'default',
                                prefixColor = '#ff0000',
                                title = 'Roubo',
                                message = "Policial " .. nome .. " aceitou montar o time do roubo " .. name,
                            })

                            TriggerClientEvent('chatMessage', sourceOficial, {
                                type = 'default',
                                prefixColor = '#ff0000',
                                title = 'Roubo',
                                message = "Policial " .. nome .. " aceitou montar o time do roubo " .. name,
                            })
                        else
                            TriggerClientEvent("Notify", sourceOficial, "negado", "Já existe um policial montando o time do roubo.")
                        end
                    end
                end
            end)
        end
    end

    -- Aguarda um tempo máximo para o retorno (evita execução indefinida)
    local timeout = os.time() + 15
    while not aceitou and os.time() < timeout do
        Wait(100) -- Aguarda resposta
    end

    lock = false -- Libera o bloqueio após o processo

    if aceitou then
        local sourceOficial = vRP.getUserSource(tonumber(aceitou))
        return tonumber(aceitou), tonumber(sourceOficial)
    else
        print("Nenhum policial aceitou a solicitação.")
        return false
    end
end


function IsInAndamentRobbery(key)
    key = tonumber(key)
    if not key or type(ActualRobberies[key]) ~= 'table' then
        return
    end

    local vivo = false
    local winner

    for team, players in pairs(ActualRobberies[key]) do
        if type(players) == 'table' and (team == 'bandits' or team == 'cops') then
            vivo = false

            for _, player in ipairs(players) do
                if player.isvivo then
                    vivo = true
                    break
                end
            end

            if not vivo then
                winner = (team == 'bandits') and 'cops' or 'bandits'
                return false, winner
            end
        end
    end

    return true
end    

function GetGiveUpMembers(key, team) -- RETORNA A QUANTIDADE DE PESSOAS QUE VOTARAM NO ROUBO
    local actualKey = tonumber(key)
    
    if not key or not actualKey or type(ActualRobberies[actualKey]) ~= 'table' or type(ActualRobberies[actualKey][team]) ~= 'table' then 
        return false, 'Algo deu errado! (ERROR: 412)' 
    end
    
    local giveUp = {}
    for _, v in pairs(ActualRobberies[actualKey][team]) do
        if v.giveup then
            table.insert(giveUp, { name = v.name, id = v.id })
        end
    end
    
    return giveUp
end

function GetPlayerTable(source)
    source = tonumber(source)
    if not source then
        return
    end

    local inRobbery = {IsInRobbery(source)}
    local key, team, index = inRobbery[3], inRobbery[4], inRobbery[5]

    if key and team and index and ActualRobberies[key] and ActualRobberies[key][team] then
        return ActualRobberies[key][team][index]
    end
end

function InsertRobberyData(key, winner)
    -- Verifica se a key é válida e se existe um roubo ativo com essa key
    key = tonumber(key)
    if not key or type(ActualRobberies[key]) ~= 'table' then return end

    local data = ActualRobberies[key]
    local killfeed = {
        cops = data.cops or {},
        bandits = data.bandits or {},
        hostages = data.hostages or {}
    }

    ActualRobberies[key] = nil

    local name = tostring(data.name)
    local time = tonumber(data.init)
    local duration = os.time() - time

    CreateThread(function()
        vRP.execute('lotusRoubos/addHistoric', {
            name = name,
            winner = tostring(winner),
            duration = duration,
            killfeed = json.encode(killfeed),
            time = time
        })

        local function createKillfeedString(players)
            table.sort(players, function(a, b) return a.kills > b.kills end)
            local result = {}
            for _, player in ipairs(players) do
                local status = player.isvivo and 'Vivo' or 'Morto'
                table.insert(result, string.format("[%d] %s \n[💀]: %d kills | [❤️]: %s", player.id, player.name, player.kills, status))
            end
            return #result > 0 and "```ini\n" .. table.concat(result, "\n\n") .. "```\n" or ''
        end

        local copsString = createKillfeedString(killfeed.cops)
        local banditsString = createKillfeedString(killfeed.bandits)
        local hostagesString = createKillfeedString(killfeed.hostages)
        hostagesString = hostagesString ~= '' and hostagesString or '```Não houveram reféns na ação!```'

        local winnerTeam = winner:lower() == 'cops' and 'Policiais' or 'Bandidos'

        vRP.sendLog('https://discord.com/api/webhooks/1316796416508694599/KerB68YmObS2YfgnTiWGtb8xbw8EZp1Xzl7i69_kb0S0o2w1ZQ6FwmpEU3iFZdyLQn9F',string.format("**RELATÓRIO DO ROUBO %s:**\n**INICIO:** %s\n**FIM:** %s\n**DURAÇÃO:** %d segundos\n**BANDIDOS PARTICIPANTES:** %s\n**POLICIAIS PARTICIPANTES:** %s\n**REFÉNS:** %s\n**TIME VENCEDOR:** %s",
            name:upper(),
            os.date("[📅]: %d/%m/%Y [🕒]: %X", time),
            os.date("[📅]: %d/%m/%Y [🕒]: %X", os.time()),
            duration,
            banditsString,
            copsString,
            hostagesString,
            winnerTeam))
    end)
end

function AnyKillInRobbery(key, victim, reason, killer)
    if not key or not tonumber(key) or type(ActualRobberies[tonumber(key)]) ~= 'table' then 
        return 
    end
    
    if not victim or type(victim) ~= 'table' then 
        return 
    end
    
    local victim_id, team = victim[1], victim[2]
    local killer_id, team2, kil, vic

    if killer and type(killer) == 'table' then
        killer_id, team2 = killer[1], killer[2]
        local data_killer = GetPlayerTable(killer_id)
        
        if type(data_killer) == 'table' then 
            data_killer.kills = tonumber(data_killer.kills) + 1
            kil = data_killer.name
            
            if type(kil) ~= 'string' then 
                killer_id = tonumber(data_killer.id) or config.getUserId(killer_id)
                local identity = config.getUserIdentity(killer_id)
                kil = tostring(identity.nome) .. ' ' .. tostring(identity.sobrenome)
            end 
        end
    end
    
    local data_victim = GetPlayerTable(victim_id)
    if type(data_victim) == 'table' then 
        data_victim.isvivo = false
        vic = data_victim.name
        
        if type(vic) ~= 'string' then 
            victim_id = tonumber(data_victim.id) or config.getUserId(victim_id)
            local identity = config.getUserIdentity(victim_id)
            vic = tostring(identity.nome) .. ' ' .. tostring(identity.sobrenome)
        end 
    end
    
    -- SET ANY KILL IN ROBBERY
    local hasRobbery, winner = IsInAndamentRobbery(key)

    local InRobbery = GetRobberySources(key)
    if not InRobbery or type(InRobbery) ~= 'table' then
        return 
    end

    if hasRobbery then
        for _, playerId in ipairs(InRobbery) do
            TriggerClientEvent('killfeed', tonumber(playerId), vic, reason, kil, tostring(team):lower(), tostring(team2):lower())
            vCLIENT._updateActualRobbery(tonumber(playerId), ActualRobberies[key])
        end
        return
    end

    -- Se o roubo terminou, envia notificações de vencedor e atualiza os jogadores
    for _, playerId in ipairs(InRobbery) do
      --  local playerSource = vRP.getUserSource(playerId)
       -- if playerSource then
            TriggerClientEvent('killfeed', tonumber(playerId), vic, reason, kil, team, team2)
            TriggerClientEvent('winnernotify', tonumber(playerId), tostring(winner))
            
            vCLIENT._updateActualRobbery(tonumber(playerId), false)
      --  end 
    end

    -- Distribuir o dinheiro entre os membros vivos da equipe vencedora
    DistributeMoneyToWinners(winner, key)
    lotusRoubos:removeDrawmarker(key)
    -- Insere os dados do roubo
    InsertRobberyData(key, tostring(winner))
end

function DistributeMoneyToWinners(winner, key)
    local totalMoney = ActualRobberies[key].estimatedValue
    local winners = GetWinners(winner, key)
    local share = totalMoney / #winners

    for _, player in ipairs(winners) do
        if not vRP.hasPermission(player.id,Config.Roubos.policePermission) then
            vRP.giveInventoryItem(player.id, 'dirty_money', share)
        else 
            vRP.giveInventoryItem(player.id, 'money', share)
        end
    end
end

function GetWinners(winner, key)
    local winners = {}
    for _, player in ipairs(ActualRobberies[key][winner]) do
        table.insert(winners, player)
    end
    return winners
end

function GetRobberySources(key, team)
    key = tonumber(key)
    if not key or type(ActualRobberies[key]) ~= 'table' then
        return false, 'Algo deu errado! (ERROR: 438)'
    end

    local Sources = {}
    
    local function addSourcesFromTeam(teamTable)
        for _, player in ipairs(teamTable) do
            if type(player) == 'table' and player.source then
                table.insert(Sources, player.source)
            end
        end
    end

    if not team then
        for _, teamTable in pairs(ActualRobberies[key]) do
            if type(teamTable) == 'table' then
                addSourcesFromTeam(teamTable)
            end
        end
        return Sources
    end

    local teamTable = ActualRobberies[key][team]
    if type(teamTable) ~= 'table' then
        return false, 'Algo deu errado! (ERROR: 457)'
    end
    addSourcesFromTeam(teamTable)

    return Sources
end

function lotusRoubos:getHistoricRobberys(offset,limit)
    local winnerBeautifier = { cops = 'Policiais', bandits = 'Bandidos' }

    offset = tonumber(offset) or 0
    limit = tonumber(limit) or 1000

    local r, p, now = {}, 0, table.clone(ActualRobberies)

    if offset < #now then
        table.sort(now, function(a, b) return tonumber(a.init) > tonumber(b.init) end)
        
        for _, v in ipairs(now) do
            if p < limit and v.name and type(v.bandits) == 'table' and type(v.cops) == 'table' then
                p = p + 1
                if p > offset then
                    table.insert(r, {status = true,name = tostring(v.name),bandits = #v.bandits,cops = #(v.cops),hostages = #(v.hostages or {}),winner = 'Não Definido',players = { bandits = v.bandits or {}, cops = v.cops or {} }})
                end
            end
        end
    end

    if p >= limit then return r end

    offset = math.max(offset - p, 0)
    local occurred = vRP.query('lotusRoubos/getHistoric', { limit = parseInt(limit), offset = parseInt(offset) }) or {}
    for _, v in ipairs(occurred) do
        local k = json.decode(v.killfeed)
        if p < limit and v.name and v.winner and type(k) == 'table' then
            p = p + 1
            table.insert(r, {status = false,name = tostring(v.name),bandits = #k.bandits or {},cops = #(k.cops or {}),hostages = #(k.hostages or {}),winner = winnerBeautifier[tostring(v.winner):lower()] or 'Indefinido',players = { bandits = k.bandits or {}, cops = k.cops or {} }})
        end
    end
    return r,p
end

function lotusRoubos:createPreset(preset)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return { status = false, msg = 'Erro ao criar preset.' } 
    end 
    
    if not vRP.hasPermission(user_id,'developer.permissao') then 
        vRP.setBanned(user_id, true, '(Tunnel) Create Preset Roubos', _, _, 2)
        return { status = false, msg = 'Erro ao criar preset.' } 
    end 

    local data = preset.data
    if not data.name or not data.last_name then 
        return { status = false, msg = 'Houve algum problema na troca de informação, notifique o dono da cidade!' } 
    end
    
    data.projection = json.encode(data.projection or {})
    data.items = type(data.items) == 'table' and json.encode(data.items) or '[]'
    
    data.isminigame = nil
    data.minigame = data.minigame and tonumber(data.minigame) or 0
    
    data.ispermission = nil
    data.permission = data.permission or ''
    
    data.needmakinganim = nil
    data.animation = data.animation or ''
    data.animationtime = data.animationTime or 0
    data.iswanted = not not data.iswanted
    
    data.awarddarkmoney = data.awarddarkmoney or '0'
    data.awardmax = data.awardmax or 0
    data.awardmin = data.awardmin or 0
    data.cooldown = data.cooldown or 0
    
    local check = vRP.query('lotusRoubos/checkPreset', { name = data.last_name })
    
    if check[1] then
        for k,v in next,ActualRobberies do
            if v.name and v.name == data.last_name then
                return { status = false, msg = 'Existe um roubo em andamento com esse preset, portanto ele não pode ser editado!' } 
            end
        end

        vRP.execute('lotusRoubos/updatePreset', data)
        UpdateRobberyPoints()
    else
        vRP.execute('lotusRoubos/createPreset', data)
    end
    return { status = true, msg = 'O preset foi criado com sucesso!' }    
end

function lotusRoubos:deletePreset(name)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return { status = false, msg = 'Erro ao deletar preset' }
    end 
    
    if not vRP.hasPermission(user_id,'developer.permissao') then 
        vRP.setBanned(user_id, true, '(Tunnel) Delete Preset Roubos', _, _, 2)
        return { status = false, msg = 'Erro ao deletar preset' }
    end 

    for k,v in next,ActualRobberies do
        if tonumber(v.point_key) then
            local consult = vRP.query('lotusRoubos/getPointCount',{ count = v.point_key })
            if consult.preset == tostring(name) then
                return { status = false, msg = 'Existe um roubo em execução com esse preset!' }
            end
        end
    end
    vRP.execute('lotusRoubos/deletePreset', { name = tostring(name) })
    UpdateRobberyPoints()
    return { status = true, msg = 'Preset de roubo deletado com sucesso!' } 
end

function lotusRoubos:getDataPresets()
    local presets = vRP.query('lotusRoubos/getAllPresets') or {}
    if type(presets) ~= 'table' then return {} end
    for k, v in next, presets do
        if type(v) == 'table' then
            if v.projection then
                v.projection = json.decode(v.projection)
            end
            v.needmakinganim = type(v.animation) == 'string' and v.animation:len() > 0
            v.animationTime = parseInt(v.animationtime)
            v.ispermission = v.permission ~= ''
            v.isminigame = v.minigame > 0
            if not v.isminigame then
                v.minigame = 1
            end
            
            if v.items then
                v.items = json.decode(v.items)
                if type(v.items) ~= 'table' then 
                    v.items = {}
                end
            end
        end
    end
    return presets
end

function lotusRoubos:getDataRobberies()
    local source = source
    local consult = vRP.query('lotusRoubos/getPoint')
    if #consult > 0 then
        local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(source)))
        
        for k, v in ipairs(consult) do
            if type(v.cds) ~= 'table' then
                consult[k].cds = json.decode(v.cds)
            end
        end
        
        table.sort(consult, function(a, b)
            local distance1 = #(vec3(x, y, z) - vec3(a.cds.x, a.cds.y, a.cds.z))
            local distance2 = #(vec3(x, y, z) - vec3(b.cds.x, b.cds.y, b.cds.z))
            return distance1 < distance2
        end)
    end
    return consult
end

function lotusRoubos:addRobbery(data)
    local x, y, z = tonumber(data.cds.x), tonumber(data.cds.y), tonumber(data.cds.z)
    if not x or not y or not z then
        return { status = false, msg = 'As informações de coordenadas não chegaram como deveriam!' }
    end

    local check = vRP.query('lotusRoubos/getPreset', { name = data.preset or "" })
    if #check < 1 then
        return { status = false, msg = 'O preset especificado não foi encontrado!' }
    end

    vRP.execute('lotusRoubos/addPoint',{ preset = tostring(data.preset), cds = json.encode({x = x, y = y, z = z})})
    
    
    local count = vRP.query('lotusRoubos/getLastCount')
    if count and count[1] and count[1].count then
        RobberyCache:insert({ preset = data.preset, cds = {x=x,y=y,z=z}, count = tonumber(count[1].count) })
        vCLIENT._updateRobberyPoints(-1,RobberyCache)

        return { status = 'success', msg = 'Roubo criado com sucesso!' }
    else
        return { status = false, msg = 'Erro ao obter a contagem de roubos!' }
    end
end

function lotusRoubos:remRobbery(count)
    local count = tonumber(count)
    local robbery = IsPointInCache(count)
    if robbery then
        for k,v in next,ActualRobberies do
            if v.point_key and v.point_key == count then
                return { status = false, msg = 'O roubo selecionado tem uma ação em execução!' }
            end
        end

        DeleteRobberyInCache(count)
        vRP.execute('lotusRoubos/removePoint',{count = count})
        vCLIENT._updateRobberyPoints(-1,RobberyCache)
        return { status = true, msg = 'O roubo selecionado foi deletado!' }
    end
        
    return { status = false, msg = 'O roubo selecionado não existe' }
end

function lotusRoubos:tryRobbery(user_id, point)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id or not point then
        return false, 'Informações de usuário ou ponto estão faltando!'
    end

    local consult = vRP.query('lotusRoubos/getPreset', { name = point.preset })
    local obj = consult[1]
    if not obj then
        return false, 'Algo deu errado! (ERROR: 122)'
    end

    -- Verificação de roubo em andamento
    for k, v in pairs(ActualRobberies) do
        if v.name and v.name == tostring(obj.name) then
            return false, 'Aguarde o roubo em andamento acabar!'
        end
    end

    -- Verificação de permissão
    if type(obj.permission) == 'string' and obj.permission:len() > 0 and not vRP.hasPermission(user_id, tostring(obj.permission)) then
        return false, 'Você não possui permissão para fazer esse roubo!'
    end

    -- Verificação das coordenadas
    local x, y, z = tonumber(point.cds.x), tonumber(point.cds.y), tonumber(point.cds.z)
    if not x or not y or not z then
        return false, 'Coordenadas inválidas!'
    end

    local proj = json.decode(obj.projection)
    if type(proj) ~= 'table' then
        return false, 'Projeção inválida!'
    end

    local min = GetMinCopsFromProjection(proj)
    local cops = vRP.getUsersByPermission(Config.Roubos.policePermission)
    if #cops < min then
        return false, 'Policiais insuficientes em serviço!'
    end

    -- Verificação de cooldown
    local consult_timestamp = vRP.query('lotusRoubos/getHistoricWithName', { name = obj.name })
    local lastrob = tonumber(consult_timestamp[1] and consult_timestamp[1].time) or nil
    if not Config.Roubos.disableCooldown and lastrob then
        local lastime = os.time() - lastrob
        if tonumber(obj.cooldown) and lastime < tonumber(obj.cooldown) then
            local segundos = tonumber(obj.cooldown - lastime)
            return false, 'Os cofres do local estão vazios, aguarde ' .. segundos .. 's para roubá-los novamente!'
        end
    end

    -- Verificação de itens necessários
    local needItens
    if type(obj.items) == 'string' and obj.items:len() > 0 then
        needItens = json.decode(obj.items)
        if type(needItens) == 'table' then
            for _, v in pairs(needItens) do
                local itemName = tostring(v.name)
                local itemAmount = parseInt(v.amount)
                if vRP.getInventoryItemAmount(user_id, itemName) < itemAmount then
                    return false, 'Você não possui ' .. tostring(itemAmount) .. 'x do item ' .. tostring(vRP.getItemName(itemName)) .. ' na sua mochila!'
                end
            end
    
            -- Remover itens do inventário do usuário
            for _, v in pairs(needItens) do
                vRP.tryGetInventoryItem(user_id, tostring(v.name), parseInt(v.amount))
            end
        else
            return false, 'Ocorreu um erro inesperado! (E20)'
        end
    end

    if obj.awarddarkmoney and not tonumber(obj.awarddarkmoney) then
        obj.awarddarkmoney = 1
    end
    if obj.iswanted and not tonumber(obj.iswanted) then
        obj.iswanted = 1
    end

    local Rkey = GenerateRobKey(tostring(obj.name),tonumber(point.count))
    ActualRobberies[tonumber(Rkey)].cds = vec3(point.cds.x,point.cds.y,point.cds.z)
    ActualRobberies[tonumber(Rkey)].pusher = source
    ActualRobberies[tonumber(Rkey)].iswanted = parseInt(obj.iswanted) > 0
    ActualRobberies[tonumber(Rkey)].needItens = needItens
    ActualRobberies[tonumber(Rkey)].estimatedValue = math.random(parseInt(obj.awardmin),math.max(parseInt(obj.awardmax), parseInt(obj.awardmin)))
    ActualRobberies[tonumber(Rkey)].isDarkMoney = parseInt(obj.awarddarkmoney) > 0
    ActualRobberies[tonumber(Rkey)].animationTime = parseInt(obj.animationtime)
    ActualRobberies[tonumber(Rkey)].animation = tostring(obj.animation)

    selectMenu[source] = tonumber(Rkey)
    return tostring(obj.name), GetRobberyBandits(source, 50), { key = Rkey, proj = proj, bandlimit = GetMaxBanditsRobbery(proj, cops) }
end

function lotusRoubos:tryStartRobbery(key,bandits,hostages)
    local source = source
    if selectMenu[source] then
        selectMenu[source] = nil
    end

    if not key or not tonumber(key) or type(ActualRobberies[tonumber(key)]) ~= 'table' then 
        print('Algo deu errado! (ERROR: 150)')
        return {status = false,msg = 'Algo deu errado! (ERROR: 150)' }
    end
    if not bandits or not hostages or type(bandits) ~= 'table' or type(hostages) ~= 'table' then
        print('Os dados do alerta sofreram problemas no meio do envio!')
        return {status = false,msg = 'Os dados do alerta sofreram problemas no meio do envio!'}
    end

    local name = ActualRobberies[tonumber(key)].name
    CreateThread(function()
        for k,v in next,bandits do
            if v.id then
                local source = vRP.getUserSource(parseInt(v.id))
                if source then
                    bandits[k].source = source
                    bandits[k].isvivo = (GetEntityHealth(GetPlayerPed(source)) > 101)
                    bandits[k].kills = 0
                end
            end
        end
        for k,v in next,hostages do
            if v.id then
                local source = vRP.getUserSource(parseInt(v.id))
                if source then
                    hostages[k].source = source
                    hostages[k].isvivo = (GetEntityHealth(GetPlayerPed(source)) > 101)
                end
            end
        end
    end)
            

    ActualRobberies[tonumber(key)].bandits = bandits
    ActualRobberies[tonumber(key)].hostages = hostages

    local bandits,hostages = #bandits,#hostages

    local consult = vRP.query('lotusRoubos/getPreset',{name = name})
    if not consult then
        print('Algo deu errado! (ERROR: 181)')
        return { status = false, msg = 'Algo deu errado! (ERROR: 181)'} 
    end
    local obj = consult[1]

    if not obj then 
        print('Algo deu errado! (ERROR: 184)')
        return { status = false, msg = 'Algo deu errado! (ERROR: 184)'} 
    end
    local policial_id, policial_source = GetBestCop(name, key)

    if not policial_id and not policial_source then
        print('Nenhum policial aceitou montar um time para sua ação!')
        lotusRoubos:cancelRobbery(tonumber(key))
        return { status = false, msg = 'Nenhum policial aceitou montar um time para sua ação!' }
    end
    
    if not policial_id then
        policial_id = vRP.getUserId(policial_source)
    elseif not policial_source then
        policial_source = vRP.getUserSource(policial_id)
    end
    
    local needcops = GetCopsNeedRobbery(json.decode(obj.projection),bandits) or 0
    local policemans = vRP.getUsersByPermission(Config.Roubos.policePermission) or {}
    local cops = GetRobberyCops(policemans) or {}

    selectMenu[policial_source] = tonumber(key)
    vCLIENT.SelectCops(policial_source,tonumber(key),cops,needcops,bandits,hostages,name)
    SetTimeout(15 * 60 * 1000, function()
        if selectMenu[policial_source] then
            selectMenu[policial_source] = nil
            lotusRoubos:cancelRobbery(tonumber(key))
            print('O tempo para escolher os policiais acabou!')
            TriggerClientEvent('Notify',policial_source,'negado','O tempo para escolher os policiais acabou!')
        end
    end)
    return { status = true, msg = 'Os policiais já receberam o alerta do roubo, e estão montando um time para a ação!'}
end

function lotusRoubos:cancelRobbery(key)
    local robberyKey = tonumber(key) 

    if robberyKey and ActualRobberies[robberyKey] then
        local robbery = ActualRobberies[robberyKey]

        if type(robbery.needItens) == 'table' and robbery.pusher then
            local pusher = robbery.pusher
            local user_id = vRP.getUserId(pusher)
            if user_id then
                for _, item in pairs(robbery.needItens) do
                    vRP.giveInventoryItem(user_id, tostring(item.name), tonumber(item.amount))
                end
                vCLIENT._cancelRobbery(pusher)
            end
        end

        local InRobbery = GetRobberySources(key)
        if not InRobbery or type(InRobbery) ~= 'table' then
            return 
        end


        for _, playerSource in ipairs(InRobbery) do
            local playerId = vRP.getUserId(playerSource)
            vCLIENT._updateActualRobbery(tonumber(playerSource), false)
        end
    
        ActualRobberies[robberyKey] = nil
    end
end

function lotusRoubos:approveRobbery(key,rcops)
    local source = source
    if selectMenu[source] then
        selectMenu[source] = nil
    end
    if not key or not tonumber(key) or type(ActualRobberies[tonumber(key)]) ~= 'table' then return false,'Algo deu errado! (ERROR: 197)' end
    
    local name,bandits,hostages = ActualRobberies[tonumber(key)].name,ActualRobberies[tonumber(key)].bandits,ActualRobberies[tonumber(key)].hostages
    if not rcops or type(rcops) ~= 'table' then return false,'Os dados do roubo sofreram problemas no meio do envio!' end
   
    local consult = vRP.query('lotusRoubos/getPreset', { name = name })
    local obj = consult[1]
    if not obj then
        return false, 'Algo deu errado! (ERROR: 122)'
    end

    local proj = json.decode(obj.projection)
    if type(proj) ~= 'table' then
        return false, 'Projeção inválida!'
    end
   
    local min = GetMinCopsFromProjection(proj)
    if #rcops <= 0 or #rcops < min then 
        print('O policial destinado à escolha, não escolheu oficiais suficientes para o roubo!')
        TriggerClientEvent('Notify',vRP.getUserSource(ActualRobberies[tonumber(key)].policeaccept),'negado','O policial destinado à escolha, não escolheu oficiais suficientes para o roubo!', 5000)
        
        return false,'O policial destinado à escolha, não escolheu oficiais suficientes para o roubo!'
    end

    for k,v in next,rcops do
        if v.id then
            local source = vRP.getUserSource(parseInt(v.id))
            if source then
                rcops[k].source = source
                rcops[k].isvivo = (GetEntityHealth(GetPlayerPed(source)) > 101)
                rcops[k].kills = 0

                TriggerClientEvent("Notify",source,"sucesso","Você foi escalado para o roubo "..name.." dirija-se até o local.", 30000)
            end
        end
    end

    ActualRobberies[tonumber(key)].cops = rcops
    local cops,err,msg = ActualRobberies[tonumber(key)].cops
    if Config.Roubos.NeedAdminAuthorization then
    else 
        err,msg = "true",'Não foi necessário a aprovação de um staff!'
    end

    ActualRobberies[tonumber(key)].auth = nil
        
    if err == "true" then
        err = true
        lotusRoubos:StartRobbery(tonumber(key),bandits,cops,hostages)
    elseif err == "false" then
        err = false
    end
    return err,tostring(msg)
end

local function sendHudToParticipants(participants, robberyData, role)
    for _, participant in next, participants do
        local participantSource = vRP.getUserSource(tonumber(participant.id))
        if participantSource then
            vCLIENT._hudRobbery(participantSource, robberyData, role)
        end
    end
end

function lotusRoubos:createDrawmarker(coords, key)
    local data = ActualRobberies[key]
    if not data then return end 

    local robberry = {
        cops = data.cops or {},
        bandits = data.bandits or {},
        hostages = data.hostages or {}
    }

    for k,v in next,robberry.bandits do
        if v.id then
            local source = vRP.getUserSource(parseInt(v.id))
            if source then
                print('Criando drawmarker para bandido')
                vCLIENT._createDrawmarker(source, coords, key)
            end
        end
    end

    for k,v in next,robberry.cops do
        if v.id then
            local source = vRP.getUserSource(parseInt(v.id))
            if source then
                print('Criando drawmarker para policial')
                vCLIENT._createDrawmarker(source, coords, key)
            end
        end
    end
end 

function lotusRoubos:removeDrawmarker(key)
    local data = ActualRobberies[key]
    if not data then return end 
    
    local robberry = {
        cops = data.cops or {},
        bandits = data.bandits or {},
        hostages = data.hostages or {}
    }

    for k,v in next,robberry.bandits do
        if v.id then
            local source = vRP.getUserSource(parseInt(v.id))
            if source then
                vCLIENT._removeDrawmarker(source, key)
            end
        end
    end

    for k,v in next,robberry.cops do
        if v.id then
            local source = vRP.getUserSource(parseInt(v.id))
            if source then
                vCLIENT._removeDrawmarker(source, key)
            end
        end
    end
end 

function lotusRoubos:checkBanditInZone(key, bandits)
    Citizen.CreateThread(function()
        local coords = ActualRobberies[tonumber(key)].cds
        while ActualRobberies[tonumber(key)] do 
            local anyBanditInZone = true
            Citizen.Wait(1000)

            for k, v in next, bandits do
                local source = vRP.getUserSource(tonumber(v.id))
                if source then
                    local distance = #(GetEntityCoords(GetPlayerPed(source)) - vector3(coords.x, coords.y, coords.z))
                    if distance > 68 then 
                        anyBanditInZone = false
                    end
                end
            end

            if not anyBanditInZone and ActualRobberies[tonumber(key)] then 
                lotusRoubos:removeDrawmarker(tonumber(key))
                print('^1(nova_roubos) Roubo cancelado porque os bandidos sairam do perímetro.^0')
                TriggerEvent('nova_roubos:tryrobnotify', tonumber(key), 'importante', 'O roubo foi cancelado porque um dos bandidos sairam da área do roubo.', 15000, 'bandits')
                TriggerEvent('nova_roubos:tryrobnotify', tonumber(key), 'importante', 'O roubo foi cancelado porque os bandidos sairam da área do roubo.', 15000, 'cops')
                
                lotusRoubos:cancelRobbery(tonumber(key))
                break 
            end

        end 
    end)
end

function lotusRoubos:StartRobbery(key, bandits, cops, hostages) -- COMEÇAR O ROUBO
    if not key or not tonumber(key) or type(ActualRobberies[tonumber(key)]) ~= 'table' then 
        return false, 'Algo deu errado! (ERROR: 276)' 
    end
    if not bandits or type(bandits) ~= 'table' or not cops or type(cops) ~= 'table' or not hostages or type(hostages) ~= 'table' then 
        return 
    end

    local name = tostring(ActualRobberies[tonumber(key)].name)
    local copstext, banditstext, hostagestext = '', '', ''
    local robberyStarted = false
    local coords = ActualRobberies[tonumber(key)].cds
    lotusRoubos:createDrawmarker(coords,key)

    local timeLimit = 15 * 60 -- 10 minutos em segundos
    local startTime = os.time()

    local identity = vRP.getUserIdentity(tonumber(ActualRobberies[tonumber(key)].policeaccept))
    local nome = identity.nome .. ' ' .. identity.sobrenome

    TriggerClientEvent('chatMessage', -1, {
        type = 'default',
        prefixColor = '#ff0000',
        title = 'Roubo',
        message = "O policial "..nome.." montou o time do roubo "..name.." e está a caminho do local.",
    })
    
    
    Citizen.CreateThread(function()
        lotusRoubos:checkBanditInZone(tonumber(key), bandits)

        while not robberyStarted and ActualRobberies[tonumber(key)] do 
            local allCopsInZone = true
            local anyCopsAlive = true
            Citizen.Wait(1000)
            if not ActualRobberies[tonumber(key)] then
                break 
            end
    
            for k, v in next, cops do
                local source = vRP.getUserSource(tonumber(v.id))
                if source then
                    local distance = #(GetEntityCoords(GetPlayerPed(source)) - vector3(coords.x, coords.y, coords.z))
                    if distance > 68 then 
                        allCopsInZone = false
                    end 
                    if GetEntityHealth(GetPlayerPed(source)) <= 101 and anyCopsAlive then
                        anyCopsAlive = false
                    end
                end
            end
        
            if allCopsInZone and ActualRobberies[tonumber(key)] then
                robberyStarted = true
                lotusRoubos:removeDrawmarker(tonumber(key))
    
                ActualRobberies[tonumber(key)].init = os.time()

                sendHudToParticipants(cops, ActualRobberies[tonumber(key)], 'cops')
                sendHudToParticipants(bandits, ActualRobberies[tonumber(key)], 'bandits')
                sendHudToParticipants(hostages, ActualRobberies[tonumber(key)], 'hostages')
                break 
            elseif not anyCopsAlive and ActualRobberies[tonumber(key)] then
                lotusRoubos:removeDrawmarker(tonumber(key))

                print('^1(nova_roubos) Roubo cancelado porque um dos policiais acabou morrendo antes de começar a ação.^0')
                TriggerEvent('nova_roubos:tryrobnotify', tonumber(key), 'importante', 'O roubo foi cancelado porque um dos policiais acabou morrendo antes de começar a ação.', 15000, 'cops')
                TriggerEvent('nova_roubos:tryrobnotify', tonumber(key), 'importante', 'O roubo foi cancelado porque um dos policiais acabou morrendo antes de começar a ação.', 15000, 'bandits')
                lotusRoubos:cancelRobbery(tonumber(key))
                break
            elseif os.time() - startTime >= timeLimit and ActualRobberies[tonumber(key)] then
                lotusRoubos:removeDrawmarker(tonumber(key))

                print('^1(nova_roubos) Roubo cancelado porque os policiais não entraram no perímetro.^0')
                TriggerEvent('nova_roubos:tryrobnotify', tonumber(key), 'importante', 'O roubo foi cancelado porque os policias não entraram na área do roubo a tempo.', 15000, 'bandits')
                TriggerEvent('nova_roubos:tryrobnotify', tonumber(key), 'importante', 'O roubo foi cancelado porque vocês não entraram na área do roubo a tempo.', 15000, 'cops')

                lotusRoubos:cancelRobbery(tonumber(key))
                break
            end
        end
        
    end)
    

    for k, v in next, cops do
        local source = vRP.getUserSource(tonumber(v.id))
        if source then
            local dimension = tonumber(key)+55
            vCLIENT._initRobbery(source, ActualRobberies[tonumber(key)], 'cops')
            if coords then
                vCLIENT._createCopsBlip(source, coords, name, Config.Roubos.blipCooldown)
            end
        end
        copstext = copstext .. '[' .. tostring(v.id):match('%d+') .. '] ' .. tostring(v.name) .. '\n'
    end
    if copstext ~= '' then
        copstext = '```ini\n' .. copstext .. '```'
    end

    for k, v in next, bandits do
        local source = vRP.getUserSource(tonumber(v.id))
        if source then
            local dimension = tonumber(key)+55
            vCLIENT._initRobbery(source, ActualRobberies[tonumber(key)], 'bandits')

            banditstext = banditstext .. '[' .. tostring(v.id):match('%d+') .. '] ' .. tostring(v.name) .. '\n'
        end
    end
    if banditstext ~= '' then
        banditstext = '```ini\n' .. banditstext .. '```'
    end

    for k, v in next, hostages do
        local source = vRP.getUserSource(tonumber(v.id))
        if source then
            local dimension = tonumber(key)+55
            vCLIENT._initRobbery(source, ActualRobberies[tonumber(key)], 'hostages')
            hostagestext = hostagestext .. '[' .. tostring(v.id):match('%d+') .. '] ' .. tostring(v.name) .. '\n'
        end
    end
    if hostagestext == '' then
        hostagestext = '```Não houveram reféns na ação!```'
    else
        hostagestext = '```ini\n' .. hostagestext .. '```'
    end
end


function lotusRoubos:voteRobberyGiveUp(team)
    local source = source
    local InRobbery = { IsInRobbery(source) }
    local key, Team = InRobbery[3], InRobbery[4]
    
    if not (key and tostring(Team) == tostring(team)) then
        return { status = false, msg = 'Ocorreu um erro ao votar!' }
    end

    if not tonumber(key) or type(ActualRobberies[tonumber(key)]) ~= 'table' then
        return { status = false, msg = 'Algo deu errado! (ERROR: 420)' }
    end

    local data = GetPlayerTable(source)
    
    if data.giveup then
        return { status = false, msg = 'Você já votou!' }
    end
    
    data.giveup = true
    local members = GetGiveUpMembers(tonumber(key), tostring(team))
    local teamSources, err = GetRobberySources(tonumber(key), team)
    
    if type(teamSources) == 'table' and type(members) == 'table' and #teamSources == #members then
        local winner = (team == 'cops') and 'bandits' or 'cops'
        local teamBnt = { cops = 'policiais', bandits = 'bandidos' }
        local sources = GetRobberySources(tonumber(key))
        
        for _, v in ipairs(sources) do
            TriggerClientEvent('winnernotify', tonumber(v), tostring(winner))
            TriggerClientEvent('robnotify', v, 'aviso', 'O time dos ' .. tostring(teamBnt[team]) .. ' se renderam!', 15000)
            lotusRoubos:removeDrawmarker(tonumber(key))

            vCLIENT._updateActualRobbery(tonumber(v), false)
        end
        
        InsertRobberyData(tonumber(key), tostring(winner))
        return { status = true, msg = 'O roubo terminou, todos os integrantes do seu time desistiram!' }
    end

    if #members == 1 then
        TriggerEvent('nova_roubos:tryrobnotify', key, 'importante', 'Uma votação de desistência foi iniciada, abra o menu e vote!', 15000, team)
    else
        TriggerEvent('nova_roubos:tryrobnotify', key, 'importante', 'O passaporte ' .. tostring(data.id) .. ' votou para se render!', 8000, team)
    end
    
    return { status = true, msg = 'Você votou para se render!' }
end

function lotusRoubos:giveAwardRobbery(user_id,amount, moneytype)
    if user_id and amount and moneytype then 
        
        return true
    end
end

function lotusRoubos:listRobberys()
    local listRobberys = {}
    local message = "Lista de Roubos:\n"

    for k, v in pairs(ActualRobberies) do 
        local robberyInfo = string.format("Roubo ID %d:\n Nome: %s, Ladrões: %d, Policiais: %d, Reféns: %d\n", 
            k, v.name, #v.bandits, #v.cops, #v.hostages)
        table.insert(listRobberys, {key = k, name = v.name, bandits = #v.bandits, cops = #v.cops, hostages = #v.hostages})
        message = message .. robberyInfo
    end

    return message
end

function lotusRoubos:deleteRobbery(robberyKey)
    ActualRobberies[robberyKey] = nil
end

RegisterNetEvent('nova_roubos:playerKilled', function(killedBy, data)
    local victim = source
    local assasin = killedBy
    local reason = data.weaponhash
    local x, y, z = table.unpack(data.killerpos)
    local weaponed, weaponClass
    if victim and assasin then
        if tonumber(assasin) == -1 or tonumber(assasin) == tonumber(victim) then 
            assasin = false 
        else 
            if Config.Roubos.hitMarker then 
                TriggerClientEvent('robhitmarker', assasin)
            end
        end 

        local inRobbery, name, key, team = IsInRobbery(victim)
        if not tonumber(key) then 
            return
        end
        local inRobbery2, name2, key2, team2
        if assasin then
            inRobbery2, name2, key2, team2 = IsInRobbery(assasin)
        end

        if Config.DeathEvent.reasonsKill[tonumber(reason)] then
            local reasonData = Config.DeathEvent.reasonsKill[tonumber(reason)]
            if reasonData.reason and reasonData.weapon and reasonData.class then
                weaponClass = tostring(reasonData.class) 
                weaponed = Config.DeathEvent.WeaponClassIcons[weaponClass]
                reason = tostring(reasonData.reason)
            else
                weaponed = Config.DeathEvent.WeaponClassIcons.unarmed
                weaponClass = 'unarmed'
                reason = 'O motivo da morte do jogador não foi encontrado!' 
            end
        else
            weaponed = Config.DeathEvent.WeaponClassIcons.unarmed
            weaponClass = 'unarmed'
            reason = 'O motivo da morte do jogador não foi encontrado!' 
        end

        local teams = {cops = 'Policiais', bandits = 'Bandidos', hostages = 'Reféns'}
        if inRobbery then
            if assasin then
                if inRobbery2 then
                    if key == key2 then
                        AnyKillInRobbery(tonumber(key), {parseInt(victim), tostring(team)}, weaponed, {parseInt(assasin), team2})
                        return true
                    end
                else 
                    AnyKillInRobbery(tonumber(key), {parseInt(victim), tostring(team)}, weaponed)
                    return true
                end
            else 
                AnyKillInRobbery(tonumber(key), {parseInt(victim), tostring(team)}, weaponed)
                return true
            end
        end
    end
end)

RegisterNetEvent('nova_roubos:tryrobnotify', function(key,style,msg,time,team)
    local source = source
    if key ~= false then
        if not key or not tonumber(key) or type(ActualRobberies[tonumber(key)]) ~= 'table' then return end
        if type(style) ~= 'string' or type(msg) ~= 'string' or not tonumber(time) then return end

        local Sources = GetRobberySources(key,team)
        if type(Sources) ~= 'table' then return end
        for k,v in next,Sources do
            if tonumber(v) then
                TriggerClientEvent('nova_roubos:robnotify', tonumber(v), style, msg, tonumber(time) )
            end
        end
    else
        TriggerClientEvent('nova_roubos:robnotify', source, style, msg, tonumber(time) )
    end
end)