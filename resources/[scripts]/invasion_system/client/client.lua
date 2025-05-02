-- State variables
state = {
    currentInvasion = {},
    isInInvasion = false,
    teamSide = nil,
    currentBet = nil,
    spectInvasion = false
}

-- UI Message Helpers
local function sendUIMessage(action, data)
    SendNUIMessage({action = action, data = data})
end

local function showTimedUIMessage(action, data, timeout)
    sendUIMessage(action, data)
    if timeout then
        SetTimeout(timeout, function()
            sendUIMessage(action, {show = false})
        end)
    end
end

-- Invasion Functions
function clientAPI.requestInvasion(data)
    sendUIMessage('open:invasion', {
        time = data.time,
        teamOne = data.teamOne,
        teamTwo = data.teamTwo,
        staff = data.staff
    })
    SetNuiFocus(true, true)
end

function clientAPI.updatedSummoneds(teams)
    sendUIMessage('updatedSummoneds', teams)
end

function clientAPI.sendRequestForId(team)
    state.teamSide = team
    SetNuiFocus(true, true)
    sendUIMessage('request', true)
end

function clientAPI.imminentInvasion(teams)
    showTimedUIMessage('imminentInvasion', {
        show = true,
        team1 = teams.left,
        team2 = teams.right
    }, 3 * 60000)
end

function clientAPI.showTime(time, label)
    sendUIMessage('imminentInvasion', {show = false})
    showTimedUIMessage('startNotification', {
        show = true,
        time = time,
        label = label
    }, 60000)
end

function clientAPI.startInvasion(invasion)
    state.isInInvasion = true
    state.currentInvasion = invasion
    
    sendUIMessage('scoreboard', {
        show = true,
        team1 = {
            name = invasion.teams.left,
            points = invasion.teams.kills['teamOne'],
            roundsWon = invasion.teams.points['teamOne']
        },
        team2 = {
            name = invasion.teams.right,
            points = invasion.teams.kills['teamTwo'],
            roundsWon = invasion.teams.points['teamTwo']
        },
        round = invasion.rules.rounds,
        currentRound = invasion.rules.currentRound
    })
end

-- Spectator Mode
local function createSpectatorSystem()
    local spectator = {
        livePlayers = {},
        spectating = false,
        spectedPlayer = nil,
        currentIndex = 0,
        thread = nil
    }

    local function getLivePlayers()
        local players = {}
        if state.currentInvasion then
            for _, team in pairs({'teamOne', 'teamTwo'}) do
                for _, player in ipairs(state.currentInvasion.teams.players[team]) do
                    if player.accepted and player.alive then
                        player.emoji = team == 'teamOne' and '~b~' or '~r~'
                        table.insert(players, player)
                    end
                end
            end
        end
        return players
    end

    function spectator.spectatePlayer(data)
        if not data.source then return end
        
        local playerPed = GetPlayerPed(GetPlayerFromServerId(tonumber(data.source)))
        if playerPed and DoesEntityExist(playerPed) and GetEntityHealth(playerPed) > 101 then
            NetworkSetInSpectatorMode(true, playerPed)
            spectator.spectedPlayer = data
            
            local coords = GetEntityCoords(playerPed)
            SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z + 10.0)
    
            CreateThread(function()
                while spectator.spectedPlayer and spectator.spectedPlayer.value == data.value do
                    if not spectator.spectedPlayer.alive then
                        spectator.nextPlayer()
                        return
                    end
                    Wait(1000)
                end
            end)
        end
    end
    
    function spectator.start()
        state.spectInvasion = true
        SetEntityInvincible(PlayerPedId(), true)
        spectator.livePlayers = getLivePlayers()

        if state.currentInvasion then 
            sendUIMessage('scoreboard', {
                show = true,
                team1 = {
                    name = state.currentInvasion.teams.left,
                    points = state.currentInvasion.teams.kills['teamOne'],
                    roundsWon = state.currentInvasion.teams.points['teamOne']
                },
                team2 = {
                    name = state.currentInvasion.teams.right,
                    points = state.currentInvasion.teams.kills['teamTwo'],
                    roundsWon = state.currentInvasion.teams.points['teamOne']
                },
                round = state.currentInvasion.rules.rounds,
                currentRound = state.currentInvasion.rules.currentRound
            })
        end

        if #spectator.livePlayers > 0 then
            spectator.spectating = true
            spectator.currentIndex = #spectator.livePlayers
            spectator.spectatePlayer(spectator.livePlayers[spectator.currentIndex])
            spectator.startThread()
        end
    end

    function spectator.stop()
        spectator.spectating = false
        NetworkSetInSpectatorMode(false)
    end

    function spectator.nextPlayer()
        if not state.isInInvasion then
            return spectator.stop()
        end

        spectator.livePlayers = getLivePlayers()
        if #spectator.livePlayers == 0 then
            return spectator.stop()
        end

        spectator.currentIndex = (spectator.currentIndex % #spectator.livePlayers) + 1
        spectator.spectatePlayer(spectator.livePlayers[spectator.currentIndex])
    end

    function spectator.previousPlayer()
        if not state.isInInvasion then
            return spectator.stop()
        end

        spectator.livePlayers = getLivePlayers()
        if #spectator.livePlayers == 0 then
            return spectator.stop()
        end

        spectator.currentIndex = (spectator.currentIndex - 2) % #spectator.livePlayers + 1
        if spectator.currentIndex < 1 then
            spectator.currentIndex = #spectator.livePlayers
        end
        spectator.spectatePlayer(spectator.livePlayers[spectator.currentIndex])
    end

    function spectator.startThread()
        if spectator.thread then return end

        spectator.thread = CreateThread(function()
            while spectator.spectating do
                -- Handle controls
                if IsDisabledControlJustPressed(0, 174) or IsDisabledControlJustPressed(0, 34) or IsDisabledControlJustPressed(0, 24) then
                    spectator.nextPlayer()
                elseif IsDisabledControlJustPressed(0, 175) or IsDisabledControlJustPressed(0, 35) or IsDisabledControlJustPressed(0, 25) then
                    spectator.previousPlayer()
                elseif IsDisabledControlJustPressed(0, 23) then
                    spectator.stop()
                    break
                end

                -- Update UI
                if spectator.spectedPlayer then
                    local ped = GetPlayerPed(GetPlayerFromServerId(tonumber(spectator.spectedPlayer.source)))
                    if not DoesEntityExist(ped) or GetEntityHealth(ped) < 101 then
                        spectator.nextPlayer()
                    else
                        -- Draw player info
                        for _, player in ipairs(spectator.livePlayers) do
                            local pedPlys = GetPlayerPed(GetPlayerFromServerId(tonumber(player.source)))
                            local coordsMe = GetEntityCoords(pedPlys)
                            
                            if HasEntityClearLosToEntity(pedPlys, PlayerPedId(), 17) then
                                showMe3D(coordsMe.x, coordsMe.y, coordsMe.z + 1.2, 
                                    string.format("(ID): ~g~%s ~w~| %s%s", player.value, player.emoji, player.team),
                                    250, 0, 255, 100)
                            end
                        end

                        -- Draw UI text
                        drawText(string.format('SPECTANDO (ID): ~g~%s ~w~- %s', spectator.spectedPlayer.value, spectator.spectedPlayer.team),
                            4, 0.10, 0.8, 0.50, 255, 255, 255, 180)
                        drawText('~b~[A]~w~ VOLTAR', 4, 0.10, 0.83, 0.50, 100, 149, 237, 180)
                        drawText('~b~[D]~w~ PRÓXIMO.', 4, 0.10, 0.86, 0.50, 100, 149, 237, 180)
                        drawText('~r~[F]~w~ SAIR.', 4, 0.10, 0.89, 0.50, 100, 149, 237, 180)

                        -- Update collision
                        local coords = GetEntityCoords(ped)
                        if coords and coords.x and coords.y then
                            RequestCollisionAtCoord(coords.x, coords.y)
                        end
                    end
                end
                Wait(0)
            end
            spectator.thread = nil
        end)
    end

    return spectator
end

-- Initialize spectator system
local spectatorSystem = createSpectatorSystem()

function clientAPI.startSpecInvasion(infosInvasion)
    state.currentInvasion = infosInvasion
    state.isInInvasion = true
    spectatorSystem.start()
end

function clientAPI.stopSpec()
    spectatorSystem.stop()
end

function clientAPI.hitMarker()
    -- Implementation needed
end

function clientAPI.updateCurrentInvasion(obj)
    if obj and type(obj) == 'table' then
        state.currentInvasion = obj
        
        sendUIMessage('scoreboard', {
            show = true,
            team1 = {
                name = obj.teams.left,
                points = obj.teams.kills['teamOne'],
                roundsWon = obj.teams.points['teamOne']
            },
            team2 = {
                name = obj.teams.right,
                points = obj.teams.kills['teamTwo'],
                roundsWon = obj.teams.points['teamOne']
            },
            round = obj.rules.rounds,
            currentRound = obj.rules.currentRound
        })
    else
        state.currentInvasion = nil
        state.isInInvasion = false
        state.spectInvasion = false
        SetEntityInvincible(PlayerPedId(), false)
        clientAPI.hide()
    end
end

-- Commands
RegisterCommand("bet", function(source, args)
    local infos, current = serverAPI.openBet(args[1])
    if infos then
        state.currentBet = tonumber(current)
        SetNuiFocus(true, true)
        sendUIMessage('betPainel', infos)
    end
end)

RegisterCommand('spec_invasion', function(source, args)
    if not state.spectInvasion or #args < 1 and (spectatorSystem.spectating or vRP.hasPermission(user_id, "developer.permissao")) then return end

    local targetId = tonumber(args[1])
    for _, player in ipairs(spectatorSystem.livePlayers) do
        if player.value == targetId then
            if player.alive then
                spectatorSystem.spectating = true
                spectatorSystem.spectatePlayer(player)
                spectatorSystem.startThread()
                TriggerEvent('Notify', 'sucesso', 'Você está spectando o jogador: ' .. player.value)
                return
            end
            TriggerEvent('Notify', 'negado', 'O jogador está morto.')
            return
        end
    end
    TriggerEvent('Notify', 'negado', 'Jogador não encontrado ou não está vivo.')
end)

-- Exports
exports("inInvasion", function()
    return state.isInInvasion
end)