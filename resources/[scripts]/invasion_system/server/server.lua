-- Variáveis globais
invasionsInCreation = {}
currentInvasion = {}
lastCoordsInvasion = {}
currentSpec = {}
local invitesInvasion = {}

-- Funções auxiliares
local function stringToArray(str)
    if type(str) == 'table' then return str end
    if type(str) ~= 'string' then return {} end

    local array = {}
    for value in string.gmatch(str, '([^,]+)') do
        table.insert(array, value:match("^%s*(.-)%s*$"))
    end
    return array
end

local function parseInt(str)
    local number = tonumber(str)
    return number and math.floor(number) or nil
end

local function parseFloat(str)
    str = str:gsub(",", ".")
    return tonumber(str) or nil
end

local function convertTime(timeStr)
    local currentDate = os.date("*t")
    local hour, minute = string.match(timeStr, "(%d+):?(%d*)")
    hour = tonumber(hour) or currentDate.hour
    minute = tonumber(minute) or 0

    return os.time({
        year = currentDate.year,
        month = currentDate.month,
        day = currentDate.day,
        hour = hour,
        minute = minute,
        sec = 0
    })
end

local function hasPermission(userId)
    for _, permission in ipairs(config.permissions) do
        if vRP.hasPermission(userId, permission) then
            return true
        end
    end
    return false
end

local function getAllFactions()
    local factions = {}
    local factionSet = {}
    
    for factionType, status in pairs(config.factionTypes) do
        if status then
            for name, data in pairs(groups) do
                if data._config then
                    local factionName = data._config.orgName
                    local factionType = data._config.orgType
                    if factionName and factionType and config.factionTypes[factionType] and not factionSet[factionName] then
                        table.insert(factions, factionName)
                        factionSet[factionName] = true
                    end
                end
            end
        end
    end
    return factions
end

-- Funções de validação
local function validateWeapons(weapons)
    if type(weapons) == 'string' then
        weapons = stringToArray(weapons)
    end

    if type(weapons) ~= 'table' then return false end

    for _, weaponName in ipairs(weapons) do
        local lowerWeaponName = weaponName:lower()
        if not config.weapons[lowerWeaponName] then
            local found = false
            for _, spawn in pairs(config.weapons) do
                if spawn:lower() == lowerWeaponName then
                    found = true
                    break
                end
            end
            if not found then return false end
        end
    end
    return true
end

local function setWeapons(weapons)
    local _weapons = {}
    
    if type(weapons) == 'string' then
        weapons = stringToArray(weapons)
    end

    for _, weaponName in ipairs(weapons) do
        local lowerWeaponName = weaponName:lower()
        if config.weapons[lowerWeaponName] then
            table.insert(_weapons, config.weapons[lowerWeaponName])
        else
            for _, spawn in pairs(config.weapons) do
                if spawn:lower() == lowerWeaponName then
                    table.insert(_weapons, spawn:upper())
                    break
                end
            end
        end
    end
    return _weapons
end

local function validateCoords(coords)
    if type(coords) == 'table' and #coords == 3 then
        return true
    elseif type(coords) == 'string' then
        local coordsArray = stringToArray(coords)
        return #coordsArray == 3
    end
    return false
end

local function setCoords(coords)
    if type(coords) == 'table' then
        for i, v in ipairs(coords) do
            coords[i] = tonumber(v)
        end
        return coords
    elseif type(coords) == 'string' then
        local coordsArray = stringToArray(coords)
        for i, v in ipairs(coordsArray) do
            coordsArray[i] = tonumber(v)
        end
        return coordsArray
    end
    return nil
end

-- Funções de gerenciamento de jogadores
local function resetPlayer(player, playerId)
    if playerId and lastCoordsInvasion[playerId] then
        vRPC._teleport(player, lastCoordsInvasion[playerId].x, lastCoordsInvasion[playerId].y, lastCoordsInvasion[playerId].z)
        lastCoordsInvasion[playerId] = nil
    end
    
    -- Reset de vida e estado
    vRPC._setHealth(player, 0)
    SetTimeout(1000, function()
        vRPC._killComa(player)
        SetTimeout(2000, function()
            vRPC._setHealth(player, 300)
            vRPC._DeletarObjeto(player)
            vRPC._stopAnim(player)
        end)
    end)

    -- Remoção de itens
    local energicoAmount = vRP.getInventoryItemAmount(playerId, "energetico")
    local bandagemAmount = vRP.getInventoryItemAmount(playerId, "bandagem")
    vRP.removeInventoryItem(playerId, "roupas", 1)
    vRP.removeInventoryItem(playerId, "energetico", math.min(energicoAmount, 15))
    vRP.removeInventoryItem(playerId, "bandagem", math.min(bandagemAmount, 5))

    -- Reset de armas
    vRPC._giveWeapons(player, {}, true)
end

-- Funções de cancelamento
local function cancelInvasionForPlayers(playersSource, rules, teams)
    for _, playerData in next, playersSource do
        local player = playerData.source
        local playerId = vRP.getUserId(tonumber(player))
        if playerId then
            clientAPI.hide(player)
            vRPC._giveWeapons(player, {}, true)
            currentInvasion[playerId] = nil
            clientAPI._updateCurrentInvasion(tonumber(player), false)
            SetPlayerRoutingBucket(player, 0)

            resetPlayer(player, playerId)

            TriggerClientEvent('Notify', player, 'sucesso', 'A criação da invasão foi cancelada.')
        end
    end
end

local function cancelInvasionForSpec(players, rules)
    for _, playerId in ipairs(rules.specIds) do
        local tplayer = vRP.getUserSource(tonumber(playerId))
        if tplayer then
            clientAPI.hide(tplayer)
            currentSpec[playerId] = nil
            clientAPI._updateCurrentInvasion(tonumber(tplayer), false)
            clientAPI._stopSpec(tonumber(tplayer))
            SetPlayerRoutingBucket(tplayer, 0)

            local Ped = GetPlayerPed(tplayer)
            if DoesEntityExist(Ped) then
                SetEntityDistanceCullingRadius(Ped, 0.0)
            end

            resetPlayer(tplayer, vRP.getUserId(tonumber(tplayer)))

            TriggerClientEvent('Notify', tplayer, 'sucesso', 'A criação da invasão foi cancelada.')
        end
    end
end

-- Comandos e eventos
RegisterCommand(config.mainCommand, function(source, args)
    local userId = vRP.getUserId(source)
    if not userId or not hasPermission(userId) then
        return
    end

    if args[1] == "cancel" then
        local invasion = invasionsInCreation[tonumber(userId)]
        if not invasion then
            clientAPI.hide(source)
            invasionsInCreation[tonumber(userId)] = nil
            TriggerClientEvent('Notify', source, 'negado', 'Você não tem uma invasão em andamento.')
            return
        end

        local teams = invasion.teams
        local rules = invasion.rules
        
        if teams and type(teams.ready) == 'table' and teams.ready.teamOne and teams.ready.teamTwo and invasion.startGame then
            if invasion.inProgress then
                local playersSource = GetInvasionSources(invasion)
                if type(playersSource) ~= 'table' then return end

                cancelInvasionForPlayers(playersSource, rules, teams)
                cancelInvasionForSpec(rules.specIds, rules)

                clientAPI.hide(source)
                TriggerClientEvent('Notify', source, 'sucesso', 'A criação da invasão foi cancelada.')
                
                -- Deletar zona
                for zoneID, data in pairs(zoneStorage) do
                    if tonumber(data.staff) == tonumber(userId) then
                        zone:delete(zoneID)
                        break
                    end
                end

                invasionsInCreation[tonumber(userId)] = nil
            else
                TriggerClientEvent('Notify', source, 'negado', 'A invasão não foi iniciada.')
            end
        else
            if rules and rules.leaders then
                local redSource = vRP.getUserSource(tonumber(rules.leaders['redFaction']))
                local blueSource = vRP.getUserSource(tonumber(rules.leaders['blueFaction']))
                
                if redSource then
                    clientAPI.hide(redSource)
                    TriggerClientEvent('Notify', redSource, 'sucesso', 'A criação da invasão foi cancelada.')
                end
                if blueSource then
                    clientAPI.hide(blueSource)
                    TriggerClientEvent('Notify', blueSource, 'sucesso', 'A criação da invasão foi cancelada.')
                end
            end

            clientAPI.hide(source)
            TriggerClientEvent('Notify', source, 'sucesso', 'A criação da invasão foi cancelada.')
            invasionsInCreation[tonumber(userId)] = nil
        end
    else
        if invasionsInCreation[tonumber(userId)] then
            TriggerClientEvent('Notify', source, 'negado', 'Você já tem uma invasão em andamento.')
            return
        end
        clientAPI.visibility(source)
    end
end)

-- Funções da API do servidor
function serverAPI.getAllFactions()
    return getAllFactions()
end

function serverAPI.selectedFactions(data)
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then return { validated = false } end

    local rightFaction, leftFaction = data.rightFaction, data.leftFaction
    if rightFaction == leftFaction then return { validated = false } end

    if rightFaction and leftFaction then
        if not invasionsInCreation[tonumber(userId)] then
            invasionsInCreation[tonumber(userId)] = {
                teams = {
                    right = rightFaction,
                    left = leftFaction
                }
            }
        end
        return { validated = true }
    end
    return { validated = false }
end

function serverAPI.setRules(data)
    local source = source
    local userId = vRP.getUserId(source)
    if not userId or not hasPermission(userId) or not invasionsInCreation[tonumber(userId)] then
        return { validated = false }
    end

    local rounds = data.round
    local addRules = data.addRules
    local armoreds = data.armoreds
    local weaponsTeamOne = data.weaponsTeamOne
    local weaponsTeamTwo = data.weaponsTeamTwo
    local redTeamPlayers = data.redTeamPlayers
    local blueTeamPlayers = data.blueTeamPlayers
    local helicopters = data.helicopters
    local time = data.time

    if validateWeapons(weaponsTeamOne) and validateWeapons(weaponsTeamTwo) then
        local weaponsOneSet = setWeapons(weaponsTeamOne)
        local weaponsTwoSet = setWeapons(weaponsTeamTwo)

        invasionsInCreation[tonumber(userId)].rules = {
            staffId = userId,
            startTime = convertTime(time),
            rounds = rounds,
            currentRound = 1,
            weaponsTeamOne = weaponsOneSet,
            weaponsTeamTwo = weaponsTwoSet,
            aditionalRules = addRules,
            armoredsVehicles = parseInt(armoreds),
            helicopters = parseInt(helicopters),
            redFactionTotalPlayers = parseInt(redTeamPlayers),
            blueFactionTotalPlayers = parseInt(blueTeamPlayers)
        }

        return { validated = true }
    end

    return { validated = false }
end

function serverAPI.setMoreRules(data)
    local source = source
    local userId = vRP.getUserId(source)
    if not userId or not hasPermission(userId) or not invasionsInCreation[tonumber(userId)] then
        return { validated = false }
    end

    local redTeamLeader = data.redTeamLeader
    local blueTeamLeader = data.blueTeamLeader
    local blueTeamSpawnCds = data.blueTeamSpawnCds
    local redTeamSpawnCds = data.redTeamSpawnCds
    local specIds = data.specIds
    local blueTeamBetValue = data.blueTeamBetValue
    local redTeamBetValue = data.redTeamBetValue

    if not validateCoords(redTeamSpawnCds) or not validateCoords(blueTeamSpawnCds) then
        return { validated = false }
    end

    local rules = invasionsInCreation[tonumber(userId)].rules
    local redSource = vRP.getUserSource(tonumber(redTeamLeader))
    local blueSource = vRP.getUserSource(tonumber(blueTeamLeader))

    if redSource and blueSource then
        local firstFactionSpawn = setCoords(redTeamSpawnCds)
        local secondFactionSpawn = setCoords(blueTeamSpawnCds)

        rules.specIds = stringToArray(specIds)
        rules.spawns = {
            redFaction = firstFactionSpawn,
            blueFaction = secondFactionSpawn
        }
        rules.leaders = {
            redFaction = redTeamLeader,
            blueFaction = blueTeamLeader
        }
        rules.bets = {
            redFaction = parseFloat(redTeamBetValue) or 2.0,
            blueFaction = parseFloat(blueTeamBetValue) or 2.0
        }

        return { validated = true }
    end
    return { validated = false }
end

function serverAPI.requestInvasion()
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then return false end

    local invasion = invasionsInCreation[tonumber(userId)]
    if not invasion or not invasion.rules or not invasion.teams then
        return false
    end

    local rules = invasion.rules
    local teams = invasion.teams

    -- Inicialização das estruturas de dados
    if not teams.players then
        teams.players = {}
        teams.kills = {}
        teams.points = {}
        teams.ready = {}
    end

    if not teams.players.teamOne then
        teams.players.teamOne = {}
        teams.kills.teamOne = 0
        teams.ready.teamOne = false
        teams.points.teamOne = 0
    end

    if not teams.players.teamTwo then
        teams.players.teamTwo = {}
        teams.kills.teamTwo = 0
        teams.ready.teamTwo = false
        teams.points.teamTwo = 0
    end

    local identity = vRP.getUserIdentity(userId) or { nome = 'Desconhecido', sobrenome = 'Desconhecido' }
    local name = identity.nome .. " " .. identity.sobrenome

    local redSource = vRP.getUserSource(tonumber(rules.leaders.redFaction))
    local blueSource = vRP.getUserSource(tonumber(rules.leaders.blueFaction))

    if blueSource and redSource then
        currentInvasion[tonumber(rules.leaders.blueFaction)] = userId
        currentInvasion[tonumber(rules.leaders.redFaction)] = userId

        local createData = function(teamOne, teamTwo)
            return {
                time = rules.time,
                teamOne = teamOne,
                teamTwo = teamTwo,
                staff = identity.nome
            }
        end

        local dataRed = createData(teams.right, teams.left)
        local dataBlue = createData(teams.left, teams.right)

        clientAPI.requestInvasion(redSource, dataRed)
        clientAPI.requestInvasion(blueSource, dataBlue)

        return true
    end
    return false
end

function serverAPI.getRequestForId(otherId, team)
    local source = source
    local userId = vRP.getUserId(source)



    if not userId or userId == otherId then return false end

    local otherSource = vRP.getUserSource(otherId)
    if not otherSource then 
        print('Jogador não encontrado.')
        return false

    end

    local invasionIndex = GetInvasionByTeam(team)
    local invasion = invasionsInCreation[tonumber(invasionIndex)]
    if not invasion then
        print('Invasão não encontrada.')
        return false 
    end

    local rules = invasion.rules
    local teams = invasion.teams

    local teamSide, defTeamColor = GetSideByTeam(teams, team)
    local teamColor = defTeamColor == 'blue' and 'blueFactionTotalPlayers' or 'redFactionTotalPlayers'

    -- Verificações
    for _, specId in ipairs(rules.specIds) do
        if otherId == tonumber(specId) then
            print('Jogador é um espectador.')
            return { validated = false }
        end
    end

    if rules[teamColor] ~= 25 and CountPlayersAccept(invasionIndex, teamSide) >= rules[teamColor] then 
        print('Limite de jogadores atingido.')
        return { validated = false }
    end

    -- Gerenciamento de convites
    if not invitesInvasion[otherId] then
        print('Convite enviado.')
        invitesInvasion[otherId] = {
            team = team,
            source = source,
            accepted = false
        }
    end

    -- Verificação de jogador existente
    local playerFound = false
    for _, player in ipairs(teams.players['teamOne']) do
        if player.value == otherId then
            playerFound = true
            break
        end
    end

    if not playerFound then
        for _, player in ipairs(teams.players['teamTwo']) do
            if player.value == otherId then
                playerFound = true
                break
            end
        end
    end

    if not playerFound then
        print('Jogador adicionado.')
        table.insert(teams.players[teamSide], {
            value = otherId,
            accepted = false
        })
    else
        print('Jogador já adicionado.')
    end

    -- Timeout do convite
    SetTimeout(30000, function()
        if invitesInvasion[otherId] and not invitesInvasion[otherId]['accepted'] then
            invitesInvasion[otherId] = nil

            local redSource = vRP.getUserSource(tonumber(rules.leaders.redFaction))
            local blueSource = vRP.getUserSource(tonumber(rules.leaders.blueFaction))

            if blueSource then
                clientAPI.updatedSummoneds(blueSource, {
                    teamOne = teams.players.teamOne,
                    teamTwo = teams.players.teamTwo
                })
            end

            if redSource then
                clientAPI.updatedSummoneds(redSource, {
                    teamOne = teams.players.teamTwo,
                    teamTwo = teams.players.teamOne
                })
            end

            if otherSource then
                clientAPI.hide(otherSource)
                TriggerClientEvent('Notify', otherSource, 'negado', 'O tempo para aceitar o convite expirou.', 10000)
            end
        end
    end)

    clientAPI.sendRequestForId(otherSource, team)
    return { validated = true }
end

function serverAPI.statusRequestId(statusType, team)
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then 
        print('582 Jogador não encontrado.')
        return { validated = false } 
    end

    local invasionIndex = GetInvasionByTeam(team)
    local invasion = invasionsInCreation[tonumber(invasionIndex)]
    if not invasion then
        print('587 Invasão não encontrada.')
        return { validated = false } 
    end

    invitesInvasion[userId] = nil

    local rules = invasion.rules
    local teams = invasion.teams
    local teamSide, defTeamColor = GetSideByTeam(teams, team)
    local accepted = statusType == "accepted"

    -- Atualização do status do jogador
    local function updatePlayerStatus(teamPlayers)
        for _, player in ipairs(teamPlayers) do
            if player.value == userId then
                if not player.accepted then
                    player.accepted = accepted
                end
                return true
            end
        end
        return false
    end

    print('Linha 592 ')
    if not updatePlayerStatus(teams.players['teamOne']) and not updatePlayerStatus(teams.players['teamTwo']) then
        print('Linha 594 '..teamSide)
        table.insert(teams.players[teamSide], {
            value = userId,
            accepted = accepted
        })
    else
        print('Jogador já aceitou o convite.')
    end

    -- Atualização das interfaces
    local function updateTeamInterface(source, isBlue)
        if source then
            print('Linha 606 ')
            clientAPI.updatedSummoneds(source, {
                teamOne = isBlue and teams.players.teamOne or teams.players.teamTwo,
                teamTwo = isBlue and teams.players.teamTwo or teams.players.teamOne
            })
        end
    end

    local redSource = vRP.getUserSource(tonumber(rules.leaders.redFaction))
    local blueSource = vRP.getUserSource(tonumber(rules.leaders.blueFaction))

    updateTeamInterface(blueSource, true)
    updateTeamInterface(redSource, false)

    return { validated = true }
end

function serverAPI.removeSummonedId(data)
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then return { validated = false } end

    local invasionIndex = GetInvasionByTeam(data.team)
    local invasion = invasionsInCreation[tonumber(invasionIndex)]
    if not invasion then return { validated = false } end

    local teams = invasion.teams
    local rules = invasion.rules
    local playerFound = false

    -- Remoção do jogador
    local function removePlayer(teamPlayers)
        for i, player in ipairs(teamPlayers) do
            if player.value == tonumber(data.id) then
                table.remove(teamPlayers, i)
                return true
            end
        end
        return false
    end

    playerFound = removePlayer(teams.players['teamOne']) or removePlayer(teams.players['teamTwo'])

    if not playerFound then return { validated = false } end

    -- Atualização das interfaces
    local function updateTeamInterface(source, isBlue)
        if source then
            clientAPI.updatedSummoneds(source, {
                teamOne = isBlue and teams.players.teamOne or teams.players.teamTwo,
                teamTwo = isBlue and teams.players.teamTwo or teams.players.teamOne
            })
        end
    end

    local redSource = vRP.getUserSource(tonumber(rules.leaders.redFaction))
    local blueSource = vRP.getUserSource(tonumber(rules.leaders.blueFaction))

    updateTeamInterface(blueSource, true)
    updateTeamInterface(redSource, false)

    return { validated = true }
end

function serverAPI.teamReady()
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then return false end

    local invasionIndex = GetInvasionByLeader(userId)
    local invasion = invasionsInCreation[tonumber(invasionIndex)]
    if not invasion then return false end

    local rules = invasion.rules
    local teams = invasion.teams

    -- Determinação do time
    local teamKey = nil
    if tonumber(rules.leaders['blueFaction']) == userId then
        teamKey = 'teamOne'
    elseif tonumber(rules.leaders['redFaction']) == userId then
        teamKey = 'teamTwo'
    end

    if not teamKey or teams.ready[teamKey] then return end

    teams.ready[teamKey] = true

    -- Início da invasão quando ambos os times estão prontos
    if teams.ready.teamOne and teams.ready.teamTwo then
        local currentTime = os.time()
        local invasionTime = tonumber(rules.startTime)
        local delay = (invasionTime - currentTime) * 1000

        -- Inicialização de flags
        invasion.stopBet = false
        invasion.startGame = false
        invasion.inProgress = false

        -- Adição dos líderes aos times
        table.insert(teams.players['teamOne'], {
            value = tonumber(rules.leaders.blueFaction),
            accepted = true
        })
        table.insert(teams.players['teamTwo'], {
            value = tonumber(rules.leaders.redFaction),
            accepted = true
        })

        -- Ocultação das interfaces dos líderes
        local blueSource = vRP.getUserSource(tonumber(rules.leaders.blueFaction))
        local redSource = vRP.getUserSource(tonumber(rules.leaders.redFaction))
        if blueSource then clientAPI.hide(blueSource) end
        if redSource then clientAPI.hide(redSource) end

        local playersSource = GetStartInvasionSources(invasion)

        -- Função para iniciar a invasão para os jogadores
        local function startForPlayers(players, startFunc, spawnPoints)
            -- Timer para parar apostas
            SetTimeout(4 * 60000, function()
                invasion.stopBet = true
            end)

            for _, playerData in ipairs(players) do
                local player = playerData.source
                local playerId = vRP.getUserId(tonumber(player))
                if playerId then
                    local spawnPoint = (playerData.team == 'teamOne') and spawnPoints.blueFaction or spawnPoints.redFaction
                    local weaponTeam = (playerData.team == 'teamOne') and rules.weaponsTeamOne or rules.weaponsTeamTwo

                    if delay > 0 then
                        clientAPI.imminentInvasion(player, teams)
                    end

                    local Ped = GetPlayerPed(player)
                    local pedCoords = GetEntityCoords(Ped)

                    SetTimeout(delay, function()
                        -- Configuração inicial do jogador
                        lastCoordsInvasion[playerId] = pedCoords
                        SetPlayerRoutingBucket(player, tonumber(invasionIndex))
                        clientAPI.showTime(player, 1, "INVASAO COMEÇA EM:")

                        if playerData.team == "spectator" then
                            -- Configuração para espectadores
                            vRPC._toggleNoclip(player)
                            if DoesEntityExist(Ped) then
                                SetEntityDistanceCullingRadius(Ped, 999999999.0)
                            end
                            vRPC._teleport(player, spawnPoint[1], spawnPoint[2], spawnPoint[3]+15)
                            currentSpec[playerId] = invasionIndex
                            startFunc(player, invasion)
                        else
                            vRPC._giveWeapons(player, { }, true)
                           
                            -- Configuração para jogadores
                            clientAPI.blockControls(player, true, spawnPoint)
                            vRPC._teleport(player, spawnPoint[1], spawnPoint[2], spawnPoint[3])
                            currentInvasion[playerId] = invasionIndex
                            Wait(1 * 60000)

                            if GetPlayerRoutingBucket(player) ~= tonumber(invasionIndex) then 
                                SetPlayerRoutingBucket(player, tonumber(invasionIndex))
                                local staffSource = vRP.getUserSource(tonumber(invasionIndex))
                                if staffSource then 
                                    TriggerClientEvent('Notify',staffSource,'sucesso','Jogador '..playerId..' retornou a invasão após ter deslogado.')
                                end
                                vRPC._teleport(player, spawnPoint[1], spawnPoint[2], spawnPoint[3])
                            end
                            -- Equipamento do jogador
                            local weaponData = {}
                            for _, weapon in pairs(weaponTeam) do
                                weaponData[weapon] = {ammo = -1}
                            end
                            vRPC._giveWeapons(player, weaponData, false)
                            TriggerClientEvent('Weapon:Attachs', player)

                            -- Status inicial do jogador
                            vRPC._setArmour(player, 100)
                            vRPC._setHealth(player, 300)
                            vRP.giveInventoryItem(playerId, "bandagem", 5, true)
                            vRP.giveInventoryItem(playerId, "energetico", 15, true)
                            vRP.giveInventoryItem(playerId, "radio", 1, true)

                            print('block controls false 803')
                            clientAPI.blockControls(player, false)
                            invasion.startGame = true
                            invasion.inProgress = true
                            startFunc(player, invasion)
                        end
           
                        -- Sincronização da zona
                        for zoneID, data in pairs(zoneStorage) do
                            if tonumber(data.staff) == invasionIndex then
                                clientAPI.syncZone(player, data)
                                break
                            end
                        end
                    end)
                end
            end
        end

        startForPlayers(playersSource, clientAPI.startInvasion, rules.spawns)
        TriggerClientEvent('Notify', -1, 'shield', 'Uma invasão foi iniciada. Utilize /bet para realizar sua aposta.',60)
        -- Log de início da invasão
        local teamOneIds = {}
        for _, player in ipairs(teams.players['teamOne']) do
            table.insert(teamOneIds, player.value)
        end

        local teamTwoIds = {}
        for _, player in ipairs(teams.players['teamTwo']) do
            table.insert(teamTwoIds, player.value)
        end

        local specIds = rules.specIds
        local specString = table.concat(specIds, ', ')

        local logMessage = string.format(
            "Invasão iniciada: \nTime %s (IDs: %s), \nTime %s (IDs: %s), \nEspectadores (IDs: %s)",
            teams.left,
            table.concat(teamOneIds, ', '),
            teams.right,
            table.concat(teamTwoIds, ', '),
            specString
        )

        vRP.sendLog(
            'https://discord.com/api/webhooks/1319726323203309650/6VBgAm9MPEiDKrLqbCZj_mjgeBj-hphyg6sB0vJhgrU7RWk8A-5J8bg2wqzr8dyGRb9V',
            logMessage
        )

        -- Inicialização dos espectadores
        for _, specId in ipairs(rules.specIds) do
            local specPlayer = vRP.getUserSource(tonumber(specId))
            if specPlayer then
                startForPlayers(
                    {{ source = specPlayer, team = 'spectator' }},
                    clientAPI.startSpecInvasion,
                    rules.spawns
                )
            end
        end
    end
end

RegisterNetEvent('invasion_system:playerKilled', function(killedBy)
    local victim = source
    local assasin = killedBy

    if victim and assasin then
        if tonumber(assasin) == -1 or tonumber(assasin) == tonumber(victim) then
            assasin = false
        end
    end

    print('>_ jogador morto: ', vRP.getUserId(victim), 'assasino: ', assasin)
    local invasionIndex, team = GetInvasionByPlayer(vRP.getUserId(victim))
    if not invasionIndex then 
        return
    end

    print('>_ jogador morto: ', vRP.getUserId(victim), 'invasão: ', invasionIndex, 'time: ', team)
    if assasin then
        local assasinIndex, assasinTeam = GetInvasionByPlayer(vRP.getUserId(assasin))
        if assasinIndex then
            if invasionIndex == assasinIndex then
                AnyKillInInvasion(tonumber(invasionIndex), {parseInt(victim), tostring(team)}, {parseInt(assasin), assasinTeam})
            end
        else 
            AnyKillInInvasion(tonumber(invasionIndex), {parseInt(victim), tostring(team)})
        end
    else 
        AnyKillInInvasion(tonumber(invasionIndex), {parseInt(victim), tostring(team)})
    end
end)

function serverAPI.openBet()
    -- local source = source
    -- local userId = vRP.getUserId(source)
    -- if not userId then
    --     return false
    -- end

    -- local invasion
    -- for index,_ in pairs (invasionsInCreation) do 
    --     invasion = invasionsInCreation[tonumber(index)]
    -- end

    -- print(invasion,'openBet')
    -- if invasion then 
    --     if invasion.stopBet then 
    --         TriggerClientEvent('Notify',source,'negado','O tempo para apostar foi encerrado.')
    --         return false
    --     end

    --     if not invasion.accumulatedMoney then 
    --         invasion.accumulatedMoney = 0
    --     end
    
    --     local infos = {
    --         show = true,
    --         team1 = { 
    --             name = invasion.teams.left, odd = invasion.rules.bets.blueFaction
    --         },
    --         team2 = { 
    --             name = invasion.teams.right, odd = invasion.rules.bets.redFaction
    --         },
    --         accumulatedMoney = invasion.accumulatedMoney
    --     }
    --     return infos, invasion.rules.staffId
    -- end
    -- TriggerClientEvent('Notify', source, 'negado', 'Não existe nenhuma invasão em andamento.')
    return false 
end

function serverAPI.processBet(data, invasionIndex)
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then
        return false
    end

    print('>_ Usuário ID '..userId..' está tentando apostar na invasão '..invasionIndex)
    local invasion = invasionsInCreation[tonumber(invasionIndex)]
    if not invasion then
        TriggerClientEvent('Notify', source, 'negado', 'Essa invasão não existe ou foi encerrada.')
        return false
    end

    if tonumber(data.value) < 0 or tonumber(data.value) == 0 then 
        return false 
    end

    if not invasion.rules.bets.bettors then 
        invasion.rules.bets.bettors = {}
    end

    if not data or not data.teamSelected or not data.teamSelected.name then
        TriggerClientEvent('Notify', source, 'negado', 'Seleção de time inválida.')
        return false
    end

    if vRP.tryFullPayment(userId, tonumber(data.value)) then
        invasion.accumulatedMoney = tonumber(invasion.accumulatedMoney) + tonumber(data.value)

        local playerFound = false
        for k, player in ipairs(invasion.rules.bets.bettors) do
            if player.user_id == userId and player.team == data.teamSelected.name then
                playerFound = true
                player.amount = tonumber(player.amount) + tonumber(data.value)
                TriggerClientEvent('Notify', source, 'sucesso', 'Você apostou R$'..tonumber(data.value)..' no time '..data.teamSelected.name..'. Sua aposta atual está em: R$'..player.amount)
                vRP.sendLog('https://discord.com/api/webhooks/1319726625192939570/exjV2b8CzaxGA57hPFzNCqpOTGWOioVslSXy-hw4E8cO4MdSB6n4ejWxbahuQbRVsvS6', 'Usuário ID '..userId..' apostou R$'..tonumber(data.value)..' no time '..data.teamSelected.name..'. Sua aposta atual está em: R$'..player.amount)
                break 
            end
        end

        if not playerFound then
            table.insert(invasion.rules.bets.bettors, {
                user_id = userId,
                amount = tonumber(data.value),
                team = data.teamSelected.name,
            })
            TriggerClientEvent('Notify', source, 'sucesso', 'Você apostou R$ '..tonumber(data.value)..' no time '..data.teamSelected.name)
            vRP.sendLog('https://discord.com/api/webhooks/1319726625192939570/exjV2b8CzaxGA57hPFzNCqpOTGWOioVslSXy-hw4E8cO4MdSB6n4ejWxbahuQbRVsvS6', 'Usuário ID '..userId..' apostou R$'..tonumber(data.value)..' no time '..data.teamSelected.name)
        end
    else
        TriggerClientEvent('Notify', source, 'negado', 'Você não possui dinheiro suficiente.')
    end
end

function serverAPI.payBet(invasionIndex, winner)
    print('>_ Está pagando as apostas.')

    local invasion = invasionsInCreation[tonumber(invasionIndex)]
    if not invasion then
        return false
    end

    local rules = invasion.rules
    local teams, teamSide = invasion.teams, nil

    if teams['left'] == winner then 
        teamSide = 'blueFaction'
    elseif teams['right'] == winner then
        teamSide = 'redFaction'
    end

    if not rules.bets.paidUsers then
        rules.bets.paidUsers = {}
    end

    if rules.bets.bettors and #rules.bets.bettors > 0 then 
        for _,player in pairs(rules.bets.bettors) do 
            print('>_ '..player.team.. ' Winner ' ..winner)
            if player.team == winner and not rules.bets.paidUsers[player.user_id] then 
                local tplayer = vRP.getUserSource(tonumber(player.user_id))
                if tplayer then 
                    rules.bets.paidUsers[player.user_id] = true
                    local odd = rules.bets[teamSide] or 1
                    local paymentOdd = tonumber(player.amount) * tonumber(odd)

                    TriggerClientEvent('Notify', tplayer, 'sucesso', 'Você recebeu R$ '..tonumber(paymentOdd)..' de sua aposta no time '..winner, 30)
                    vRP.giveBankMoney(tonumber(player.user_id), tonumber(paymentOdd))
                end
            end
        end
    end
end

function serverAPI.refuseInvasion()
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then
        return
    end

    local invasionIndex = GetInvasionByLeader(userId)
    local invasion = invasionsInCreation[tonumber(invasionIndex)]
    if not invasion then
        return
    end

    local rules = invasion.rules
    local redSource = vRP.getUserSource(tonumber(rules.leaders['redFaction']))
    local blueSource = vRP.getUserSource(tonumber(rules.leaders['blueFaction']))
    if redSource then 
        clientAPI.hide(redSource)
        TriggerClientEvent('Notify', redSource, 'sucesso', 'A invasão foi cancelada porque o lider ID '..userId..' recusou o convite.')
    end
    if blueSource then 
        clientAPI.hide(blueSource)
        TriggerClientEvent('Notify', blueSource, 'sucesso', 'A invasão foi cancelada porque o lider ID '..userId..' recusou o convite.')
    end

    local staffSource = vRP.getUserSource(invasionIndex)
    if staffSource then 
        clientAPI.hide(staffSource)
        TriggerClientEvent('Notify',staffSource,'negado','A invasão foi cancelada porque o lider ID '..userId..' recusou o convite.')
    end

    invasionsInCreation[tonumber(invasionIndex)] = nil
end

function serverAPI.cancelInvasion()
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then
        return
    end

    local invasion = invasionsInCreation[tonumber(userId)]
    if not invasion then
        return
    end

    TriggerClientEvent('Notify',staffSource,'negado','A criação da invasão foi cancelada.')

    invasionsInCreation[tonumber(invasionIndex)] = nil
end

AddEventHandler("vRP:playerLeave",function(user_id,source)	
    if GlobalState.ServerRestart then 
		return 
	end

    if not user_id then
        return
    end

    if currentSpec[userId] then 
        local staffSource = vRP.getUserSource(tonumber(currentSpec[user_id]))
        if staffSource then 
            TriggerClientEvent('Notify',staffSource,'negado','Spectador '..user_id..' deslogou durante a invasão.', 10000)
        end
        return 
    end
    
    if currentInvasion[user_id] and currentInvasion[user_id] ~= nil then 
        local invasion = invasionsInCreation[tonumber(currentInvasion[user_id])]
        if not invasion then
            return
        end

        local teams = invasion.teams  
        print('[_908] Usuário deslogou ID '..user_id)
        if teams and teams.ready.teamOne and teams.ready.teamTwo then
            --if invasion.startGame then 
                local playerFound = false
                for _, team in ipairs({'teamOne', 'teamTwo'}) do
                    for _, player in ipairs(teams.players[team]) do
                        if not player.quit and player.accepted and player.value == user_id then
                            playerFound = true
                            player.quit = true 
                            player.alive = false
                            break
                        end
                    end 
                end
            
                if playerFound then
                    local staffSource = vRP.getUserSource(tonumber(currentInvasion[user_id]))
                    if staffSource then 
                        TriggerClientEvent('Notify',staffSource,'negado','Jogador '..user_id..' deslogou e seu status foi atualizado para morto.', 10000)
                    end

                    print('[_926] Usuário '..user_id..' deslogou e seu status foi atualizado para morto')
                    AnyKillInInvasion(tonumber(currentInvasion[user_id]), {parseInt(source), 'Deslogou'})
                end

                vRPC._giveWeapons(source, {}, true)
                currentInvasion[user_id] = nil
                return 
            --else
            --    local playerRemoved = false
            --    for i, player in ipairs(teams.players['teamOne']) do
            --        if player.accepted and player.value == user_id then
            --            table.remove(teams.players['teamOne'], i)
            --            playerRemoved = true
            --            break
            --        end
            --    end
--
            --    for i, player in ipairs(teams.players['teamTwo']) do
            --        if player.accepted and player.value == user_id then
            --            table.remove(teams.players['teamTwo'], i)
            --            playerRemoved = true
            --            break
            --        end
            --    end
--
            --    if playerRemoved then
            --        local staffSource = vRP.getUserSource(tonumber(user_id))
            --        if staffSource then
            --            TriggerClientEvent('Notify', staffSource, 'sucesso', 'Jogador ' .. user_id .. ' foi removido da invasão, pois desconectou durante o evento.')
            --        end
            --    end
            --    print(json.encode(invasion),'linha 1188')
            --    vRPC._giveWeapons(source, {}, true)
            --    currentInvasion[user_id] = nil
            --    return--]]
            --end
        end 

        local rules = invasion.rules
        if tonumber(rules.leaders['redFaction']) == user_id or tonumber(rules.leaders['blueFaction']) == user_id then
            local staffSource = vRP.getUserSource(tonumber(currentInvasion[user_id]))
            if staffSource then 
                clientAPI.hide(staffSource)
                TriggerClientEvent('Notify',staffSource,'negado','A invasão foi cancelada porque o lider ID '..user_id..' deslogou.')
            end

            local redSource = vRP.getUserSource(tonumber(rules.leaders['redFaction']))
            local blueSource = vRP.getUserSource(tonumber(rules.leaders['blueFaction']))
            if redSource then 
                clientAPI.hide(redSource)
                TriggerClientEvent('Notify', redSource, 'sucesso', 'A invasão foi cancelada porque o lider ID '..user_id..' deslogou.')
            end
            if blueSource then 
                clientAPI.hide(blueSource)
                TriggerClientEvent('Notify', blueSource, 'sucesso', 'A invasão foi cancelada porque o lider ID '..user_id..' deslogou.')
            end
        end

        vRPC._giveWeapons(source, {}, true)
        invasionsInCreation[tonumber(currentInvasion[user_id])] = nil
        currentInvasion[user_id] = nil
    end 
end)

AddEventHandler('vRP:playerSpawn', function(userId, source, first_spawn)
    if not userId then
        return 
    end

    if currentSpec[userId] then
        local specIndex = tonumber(currentSpec[userId])
        local staffSource = vRP.getUserSource(tonumber(key))
        if staffSource then 
            TriggerClientEvent('Notify',staffSource,'sucesso','Spectador '..userId..' retornou a invasão após ter deslogado.', 5000)
        end
        
        for zoneID, data in pairs(zoneStorage) do
            if tonumber(data.staff) == specIndex then
                clientAPI.syncZone(source, data)
                break
            end
        end

        local invasion = invasionsInCreation[specIndex]
        local rules = invasion.rules
        local spawnPoint = rules.spawns.blueFaction

        vRPC._toggleNoclip(source)
        local Ped = GetPlayerPed(source)
        if DoesEntityExist(Ped) then
            SetEntityDistanceCullingRadius(Ped, 999999999.0)
        end

        SetPlayerRoutingBucket(source, specIndex)
        vRPC._teleport(source, spawnPoint[1], spawnPoint[2], spawnPoint[3]+15)
        clientAPI.startSpecInvasion(source, invasionsInCreation[specIndex])
    end

    if currentInvasion[userId] then 
        local invasionIndex = tonumber(currentInvasion[userId])
        local invasion = invasionsInCreation[invasionIndex]
        if not invasion then
            return
        end

        local teams = invasion.teams
        if teams.ready.teamOne and teams.ready.teamTwo then
            local playerFound = false
            for _, team in ipairs({'teamOne', 'teamTwo'}) do
                for _, player in ipairs(teams.players[team]) do
                    if not player.quit and player.accepted and player.value == userId then
                        playerFound = true
                        player.quit = false
                        break
                    end
                end 
            end

            if playerFound then
                local staffSource = vRP.getUserSource(tonumber(currentInvasion[userId]))
                if staffSource then 
                    TriggerClientEvent('Notify',staffSource,'sucesso','Jogador '..userId..' retornou ao servidor após ter deslogado.', 10000)
                end
            end
        end
    end 
end)