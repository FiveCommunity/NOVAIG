-- Funções de busca e consulta
GetInvasionByTeam = function(team)
    for _, invasion in pairs(invasionsInCreation) do 
        if invasion.teams['left'] == team or invasion.teams['right'] == team then 
            return invasion.rules.staffId
        end
    end
end

GetSideByTeam = function(teams, team)
    if teams['left'] == team then 
        return 'teamOne', 'blue'
    elseif teams['right'] == team then
        return 'teamTwo', 'red'
    end
end

GetInvasionByLeader = function(id)
    for _, invasion in pairs(invasionsInCreation) do 
        if invasion and invasion.rules then 
            if tonumber(invasion.rules.leaders['redFaction']) == id or tonumber(invasion.rules.leaders['blueFaction']) == id then
                return invasion.rules.staffId
            end
        end
    end
end

-- Funções de contagem e verificação
CountPlayersAccept = function(index, side)
    local accepts = 0
    for invIndex, invasion in pairs(invasionsInCreation) do
        if invIndex == index and invasion.teams.players[side].accepted then 
            accepts = accepts + 1
        end
    end
    return accepts
end

-- Funções de busca de jogador
GetInvasionByPlayer = function(id)
    for _, invasion in pairs(invasionsInCreation) do 
        for _, player in ipairs(invasion.teams.players['teamOne']) do
            if player.accepted and player.value == id then
                return invasion.rules.staffId, 'teamOne'
            end
        end
        for _, player in ipairs(invasion.teams.players['teamTwo']) do
            if player.accepted and player.value == id then
                return invasion.rules.staffId, 'teamTwo'
            end
        end
    end
end

GetPlayerTable = function(source)
    local userId = vRP.getUserId(source)
    for _, invasion in pairs(invasionsInCreation) do 
        for _, team in ipairs({'teamOne', 'teamTwo'}) do
            for _, player in ipairs(invasion.teams.players[team]) do
                if player.accepted and player.value == userId then
                    return player
                end
            end
        end
    end
end

-- Funções de gerenciamento de jogadores
local function processTeamPlayers(players, team, teamSide, playersSource)
    for k, player in ipairs(players) do
        if player.accepted and not player.quit then
            local tplayer = vRP.getUserSource(player.value)
            if tplayer then
                clientAPI.hide(tplayer)
                players[k].source = tplayer
                players[k].team = teamSide
                players[k].alive = (GetEntityHealth(GetPlayerPed(tplayer)) > 101) or false
                players[k].kills = 0
                players[k].quit = false
                table.insert(playersSource, {source = tplayer, team = team})
            end
        end
    end
    
end

GetStartInvasionSources = function(invasion)
    local playersSource = {}
    local teams = invasion.teams

    processTeamPlayers(teams.players['teamOne'], 'teamOne', teams.left, playersSource)
    processTeamPlayers(teams.players['teamTwo'], 'teamTwo', teams.right, playersSource)

    return playersSource
end

-- Funções de atualização de status
local function updatePlayerStatus(teams, teamName)
    for k, player in ipairs(teams.players[teamName]) do
        if player.accepted then
            local tplayer = vRP.getUserSource(player.value)
            if tplayer then
                teams.players[teamName][k].alive = (GetEntityHealth(GetPlayerPed(tplayer)) > 101) or false
            else
                teams.players[teamName][k].quit = true
                teams.players[teamName][k].alive = false
            end
        end
    end
end

StartInvasionSources = function(invasion)
    local teams = invasion.teams
    updatePlayerStatus(teams, 'teamOne')
    updatePlayerStatus(teams, 'teamTwo')
end

GetInvasionSources = function(invasion)
    local playersSource = {}
    local teams = invasion.teams

    for _, teamName in ipairs({'teamOne', 'teamTwo'}) do
        for _, player in ipairs(teams.players[teamName]) do
            if player.accepted and not player.quit then
                local tplayer = vRP.getUserSource(player.value)
                if tplayer then
                    table.insert(playersSource, {source = tplayer, team = teamName})
                end
            end
        end
    end
    return playersSource
end

-- Funções de verificação de estado da invasão
function IsInAndamentInvasion(key)
    local invasion = invasionsInCreation[tonumber(key)]
    if not invasion then 
        return false 
    end

    local teams = invasion.teams
    
    local teamOneAlive, teamTwoAlive = false, false
    for _, team in ipairs({'teamOne', 'teamTwo'}) do
        for _, player in ipairs(teams.players[team]) do
            local playerSrc = vRP.getUserSource(tonumber(player.value))
            if not player.quit and player.accepted and player.alive and playerSrc and GetPlayerRoutingBucket(playerSrc) == tonumber(key) then
                if team == 'teamOne' then 
                    teamOneAlive = true
                else 
                    teamTwoAlive = true 
                end
                break
            end
        end
    end

    if not teamOneAlive then 
        return false, teams.right
    elseif not teamTwoAlive then 
        return false, teams.left 
    end
    return true
end

-- Funções auxiliares
local function isValidInvasionKey(key)
    return key and tonumber(key) and type(invasionsInCreation[tonumber(key)]) == 'table'
end

local roundCooldown = GetGameTimer()

-- Funções de processamento de morte e finalização
local function processPlayerDeath(player, playerId, isSpec, teamName, winner)
    if playerId and lastCoordsInvasion[playerId] then
        clientAPI.hide(player)
        currentInvasion[playerId] = nil
        clientAPI._updateCurrentInvasion(player, false)

        local playerTeam = teamName == 'teamOne' and teams.left or teams.right
        if winner == playerTeam then
            TriggerClientEvent('invasion_system:winNotify', player)
        else
            TriggerClientEvent('invasion_system:winningNotify', player, winner)
        end

        SetPlayerRoutingBucket(player, 0)
        vRPC._teleport(player, lastCoordsInvasion[playerId]['x'], lastCoordsInvasion[playerId]['y'], lastCoordsInvasion[playerId]['z'])
        restoreHealth(player)
        lastCoordsInvasion[playerId] = nil
    end
end

-- Função principal de processamento de morte
function AnyKillInInvasion(key, victim, killer)
    if not isValidInvasionKey(key) or not victim or type(victim) ~= 'table' then return end

    local invasion = invasionsInCreation[tonumber(key)]
    if not invasion then return false end

    local teams = invasion.teams
    local rules = invasion.rules
    local victim_id, team = victim[1], victim[2]
    local killer_id, team2, kil, vic

    -- Processamento do killer
    if killer and type(killer) == 'table' then
        killer_id, team2 = killer[1], killer[2]
        local data_killer = GetPlayerTable(tonumber(killer_id))
        if type(data_killer) == 'table' then
            kil = data_killer.name
            if type(kil) ~= 'string' then
                local identity = vRP.getUserIdentity(vRP.getUserId(tonumber(killer_id)))
                kil = tostring(identity.nome) .. ' ' .. tostring(identity.sobrenome)
            end
        end
    else
        kil = 'Desconhecido'
    end

    -- Processamento da vítima
    local data_victim = GetPlayerTable(tonumber(victim_id))
    if type(data_victim) == 'table' then
        data_victim.alive = false
        vic = data_victim.source
        if type(vic) ~= 'string' then
            victim_id = tonumber(data_victim.value) or vRP.getUserId(tonumber(victim_id))
            local identity = vRP.getUserIdentity(tonumber(victim_id))
            vic = tostring(identity.nome) .. ' ' .. tostring(identity.sobrenome)
        end
    end

    local playersSource = GetInvasionSources(invasion)
    if type(playersSource) ~= 'table' then return end

    -- Atualização de kills
    local teamKill = team == "teamOne" and "teamTwo" or "teamOne"
    if team2 == nil then
        teams.kills[teamKill] = teams.kills[teamKill] + 1
    else
        teams.kills[team == "teamOne" and "teamTwo" or "teamOne"] = teams.kills[team == "teamOne" and "teamTwo" or "teamOne"] + 1
    end

    local hasInvasion, winner = IsInAndamentInvasion(tonumber(key))
    if hasInvasion then
        -- Atualização dos jogadores
        for _, playerData in next, playersSource do
            local player = playerData.source
            if vRP.getUserId(tonumber(player)) then
                TriggerClientEvent('invasion_system:killFeed', tonumber(player), vic, kil, tostring(team):lower(), tostring(team2):lower())
                clientAPI._updateCurrentInvasion(tonumber(player), invasion)
            end
        end

        -- Atualização dos espectadores
        for _, player in ipairs(rules.specIds) do
            local tplayer = vRP.getUserSource(tonumber(player))
            if tplayer then
                TriggerClientEvent('invasion_system:killFeed', tonumber(tplayer), vic, kil, tostring(team):lower(), tostring(team2):lower())
                clientAPI._updateCurrentInvasion(tonumber(tplayer), invasion)
            end
        end
        return
    end

    print("Invasão finalizada, vencedor: " .. winner)

    if roundCooldown > GetGameTimer() then
        print('Aguardando cooldown de round...')
        return false
    end

    -- Reset de contadores e início de novo round
    teams.kills['teamOne'] = 0
    teams.kills['teamTwo'] = 0
    roundCooldown = roundCooldown + 1500

    local playersStartSource = GetStartInvasionSources(invasion)

    local teamSide = teams['left'] == winner and 'teamOne' or 'teamTwo'
    teams.points[teamSide] = teams.points[teamSide] + 1

    -- Funções auxiliares de restauração
    local function restoreHealth(player)
        vRPC._setHealth(player, 0)
        SetTimeout(1000, function()
            vRPC._killComa(player)
            SetTimeout(2000, function()
                vRPC._setHealth(player, 300)
                vRPC._DeletarObjeto(player)
                vRPC._stopAnim(player)
            end)
        end)
    end

    local function giveItems(player, playerId)
        vRPC.setArmour(player, 100)
        vRPC._setHealth(player, 300)

        -- Remoção e adição de itens
        local items = {"energetico", "bandagem"}
        for _, item in ipairs(items) do
            local amount = vRP.getInventoryItemAmount(playerId, item)
            vRP.removeInventoryItem(playerId, item, amount)
            vRP.giveInventoryItem(playerId, item, 5)
        end
    end

    -- Verificação de condições de finalização
    if (rules.rounds == 3 and teams.points[teamSide] == 2) or 
       (rules.rounds == 5 and teams.points[teamSide] == 3) or 
       (tonumber(rules.currentRound) >= rules.rounds) then
        
        invasion.startGame = false
        invasion.inProgress = false

        local maxWaitTime = 1000
        local function finalizeInvasion()
            serverAPI.payBet(tonumber(key), winner)
            
            -- Remoção da zona
            local zoneFound = false
            for zoneID, data in pairs(zoneStorage) do
                if tonumber(data.staff) == tonumber(key) then
                    zone:delete(zoneID)
                    zoneFound = true
                    break
                end
            end

            if not zoneFound then
                print("Nenhuma zona encontrada para o staff: " .. tostring(key))
            end
            
            Wait(1000)
            invasionsInCreation[tonumber(key)] = nil
            print("Invasão finalizada com sucesso.")
        end

        local function processPlayer(player, playerId, isSpec, teamName)
            if playerId and lastCoordsInvasion[playerId] then
                -- Reset do player
                clientAPI.hide(player)
                currentInvasion[playerId] = nil
                clientAPI._updateCurrentInvasion(player, false)

                -- Notificações
                local playerTeam = teamName == 'teamOne' and teams.left or teams.right
                if winner == playerTeam then
                    TriggerClientEvent('invasion_system:winNotify', player)
                else
                    TriggerClientEvent('invasion_system:winningNotify', player, winner)
                end

                -- Teleporte e restauração
                SetPlayerRoutingBucket(player, 0)
                vRPC._teleport(player, lastCoordsInvasion[playerId]['x'], lastCoordsInvasion[playerId]['y'], lastCoordsInvasion[playerId]['z'])

                if not isSpec then
                    -- Remoção de itens
                    local items = {
                        {name = "energetico", amount = 15},
                        {name = "bandagem", amount = 5}
                    }
                    
                    for _, item in ipairs(items) do
                        local currentAmount = vRP.getInventoryItemAmount(playerId, item.name)
                        if currentAmount < item.amount then
                            vRP.removeInventoryItem(playerId, item.name, currentAmount)
                        else
                            vRP.removeInventoryItem(playerId, item.name, item.amount)
                        end
                    end
                    
                    vRPC._giveWeapons(player, {}, true)
                    restoreHealth(player)
                else
                    currentSpec[playerId] = nil
                    vRPC._toggleNoclip(player)
                    local Ped = GetPlayerPed(player)
                    if DoesEntityExist(Ped) then
                        SetEntityDistanceCullingRadius(Ped, 0.0)
                    end
                end

                lastCoordsInvasion[playerId] = nil
            end
        end

        -- Processamento de jogadores e espectadores
        for _, playerData in next, playersSource do
            local player = playerData.source
            local playerId = vRP.getUserId(tonumber(player))
            TriggerClientEvent('invasion_system:killFeed', player, vic, kil, team, team2)
            SetTimeout(maxWaitTime, function()
                processPlayer(player, playerId, false, playerData.team)
            end)
        end

        for _, player in ipairs(rules.specIds) do
            local tplayer = vRP.getUserSource(tonumber(player))
            if tplayer then
                local playerId = vRP.getUserId(tonumber(tplayer))
                SetTimeout(maxWaitTime, function()
                    processPlayer(tplayer, playerId, true)
                end)
            end
        end

        SetTimeout(maxWaitTime + 1000, function()
            finalizeInvasion()
        end)
    else
        -- Início de novo round
        invasion.inProgress = false
        rules.currentRound = rules.currentRound + 1

        local function startForPlayers(players, startFunc, spawnPoints)
            if not players or #players == 0 then
                print("Nenhum jogador encontrado para iniciar.")
                return
            end

            SetTimeout(1 * 10000, function()
                StartInvasionSources(invasion)
            end)

            for _, playerData in ipairs(players) do
                local player = playerData.source
                local playerId = vRP.getUserId(tonumber(player))
                
                if playerId then
                    -- Configuração inicial do player
                    clientAPI._updateCurrentInvasion(player, false)
                    SetPlayerRoutingBucket(player, tonumber(key))

                    -- Notificação
                    TriggerClientEvent('Notify', player, 'sucesso', 
                        '🎉 Time ' .. winner .. ' venceu o round! 🎉\n' ..
                        '🔄 Iniciando o Round ' .. rules.currentRound .. ''
                    , 30)

                    if playerData.team ~= "spectator" then
                        restoreHealth(player)
                    end 

                    SetTimeout(3000, function()
                        local spawnPoint = (playerData.team == 'teamOne') and spawnPoints.blueFaction or spawnPoints.redFaction

                        if playerData.team == "spectator" then
                            clientAPI.showTime(player, 1, ("ROUND %s COMEÇA EM:"):format(rules.currentRound))
                            vRPC._teleport(player, spawnPoint[1], spawnPoint[2], spawnPoint[3]+15)
                            currentSpec[playerId] = tonumber(key)
                            SetTimeout(8000, function()   
                                startFunc(player, invasion)
                                for zoneID, data in pairs(zoneStorage) do
                                    if tonumber(data.staff) == tonumber(key) then
                                        clientAPI.syncZone(player, data)
                                        break
                                    end
                                end
                            end)
                        else
                            -- Configuração de jogador normal
                            clientAPI.showTime(player, 1, ("ROUND %s COMEÇA EM:"):format(rules.currentRound))
                            clientAPI.blockControls(player, true, spawnPoint)
                            vRPC._giveWeapons(player, {}, true)
                            vRPC._teleport(player, spawnPoint[1], spawnPoint[2], spawnPoint[3])
                            currentInvasion[playerId] = tonumber(key)
                            Wait(1 * 60000)

                            if GetPlayerRoutingBucket(player) ~= tonumber(key) then 
                                SetPlayerRoutingBucket(player, tonumber(key))
                                local staffSource = vRP.getUserSource(tonumber(key))
                                if staffSource then 
                                    TriggerClientEvent('Notify',staffSource,'sucesso','Jogador '..playerId..' retornou a invasão após ter deslogado.')
                                end
                                vRPC._teleport(player, spawnPoint[1], spawnPoint[2], spawnPoint[3])
                            end

                            -- Equipamento do jogador
                            local weaponTeam = (playerData.team == 'teamOne') and rules.weaponsTeamOne or rules.weaponsTeamTwo
                            local weaponData = {}
                            for _, weapon in pairs(weaponTeam) do
                                weaponData[weapon] = {ammo = -1}
                            end
                            
                            vRPC._giveWeapons(player, weaponData, false)
                            TriggerClientEvent('Weapon:Attachs', player)
                            
                            giveItems(player, playerId)
                            clientAPI.blockControls(player, false)
                            invasion.inProgress = true
                            startFunc(player, invasion)
                            -- Sincronização de zona
                            for zoneID, data in pairs(zoneStorage) do
                                if tonumber(data.staff) == tonumber(key) then
                                    clientAPI.syncZone(player, data)
                                    break
                                end
                            end
                        end
                    end)
                else
                    print("playerId inválido para o jogador com source: " .. player)
                end
            end
        end

        -- Início para jogadores e espectadores
        startForPlayers(playersStartSource, clientAPI.startInvasion, rules.spawns)
        for _, specId in ipairs(rules.specIds) do
            local specPlayer = vRP.getUserSource(tonumber(specId))
            if specPlayer then
                startForPlayers({{source = specPlayer, team = 'spectator'}}, clientAPI.startSpecInvasion, rules.spawns)
            end
        end
    end
end