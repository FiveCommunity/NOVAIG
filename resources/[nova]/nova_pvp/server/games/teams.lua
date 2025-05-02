------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
TEAMS = {
    PLAYERS = {},
    STARTED_ROOMS = {}
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TEAMS:addPlayerTeam(room, player)
    local user = ACCOUNTS.users[player.user_id]
    if not user then return end

    local roomData = ROOMS.list[room.mode][room.id]

    -- Inicializa os times, caso ainda não existam
    roomData.teamsPlayers['ct'] = roomData.teamsPlayers['ct'] or {}
    roomData.teamsPlayers['tr'] = roomData.teamsPlayers['tr'] or {}

    local amountMembersCT = #roomData.teamsPlayers['ct']
    local amountMembersTR = #roomData.teamsPlayers['tr']
    local memberPerTeam = roomData.players.max / 2

    -- Verifica se ambos os times estão cheios
    if amountMembersCT >= memberPerTeam and amountMembersTR >= memberPerTeam then
        return
    end

    -- Decide o time baseado no número de jogadores
    local team_name
    if amountMembersCT <= amountMembersTR then
        team_name = 'ct'
    else
        team_name = 'tr'
    end

    local findRank = PROFILE:getElo(user.data.points)
    local rank = findRank.index:match("%a+") ~= 'nenhum' and findRank.index:match("%a+") or nil
    local findClan = SQUAD.PLAYERS[player.user_id] or false

    local gen_id = (#roomData.teamsPlayers[team_name] + 1)
    roomData.teamsPlayers[team_name][gen_id] = {
        user_id = player.user_id,
        leader = player.user_id == roomData.owner_id,
        name = user.data.nickname or "N/A",
        kills = 0,
        deaths = 0,
        elo = rank,
        clan = findClan and findClan.clan.tag or nil,
        banner = rank and '/images/ranking/'..rank..'.png' or nil
    }

    self.PLAYERS[player.user_id] = {
        id = room.id,
        team = team_name,
        mode = room.mode,
        name = user.data.nickname or "N/A",
        elo = rank,
        clan = findClan and findClan.clan.tag or nil,
        banner = rank and '/images/ranking/'..rank..'.png' or nil
    }

    TEAMS:syncTeams(room.id)
end

function TEAMS:getTeams(source, user_id)
    local player = self.PLAYERS[user_id]
    if not player then return end

    local room = ROOMS.list[player.mode][player.id]
    if not room then return end

    local formatTeams = room.teamsPlayers
    for team in pairs(room.teamsPlayers) do
        for i = 1, #room.teamsPlayers[team] do
            local player = room.teamsPlayers[team][i]
            if player.user_id == user_id then
                formatTeams[team][i].my = true
            else
                formatTeams[team][i].my = false
            end
        end
    end

    return formatTeams
end

function TEAMS:syncTeams(room_id)
    local roomData = ROOMS.list['teams'][room_id]
    if not roomData then return end

    for team in pairs(roomData.teamsPlayers) do
        for i = 1, #roomData.teamsPlayers[team] do
            local player = roomData.teamsPlayers[team][i]
            if not player then 
                goto next_player 
            end

            local ply_src = vRP.getUserSource(player.user_id)
            if not ply_src then
                goto next_player
            end

            Execute._syncTeams(ply_src, {
                id = roomData.id,
                owner_id = roomData.owner_id,
                name = roomData.name,
                image = roomData.image,
                players = roomData.players,
                weapon = roomData.weapon,
                rounds = roomData.rounds,
                mode = roomData.mode
            })

            :: next_player ::
        end
    end
end

function TEAMS:leaveTeam(source, user_id) -- lobby
    local player = self.PLAYERS[user_id]
    if not player then return end

    local room = ROOMS.list[player.mode][player.id]
    if not room then return end

    for team in pairs(room.teamsPlayers) do
        for i = 1, #room.teamsPlayers[team] do
            local player = room.teamsPlayers[team][i]
            if player and player.user_id == user_id then
                table.remove(room.teamsPlayers[team], i)

                if player.leader then
                    self:destroyLobby(room.id)
                end

                break
            end
        end
    end

    TEAMS:syncTeams(player.id)
end

function TEAMS:changeTeam(source, user_id)
    local player = self.PLAYERS[user_id]
    if not player then return end

    local room = ROOMS.list[player.mode][player.id]
    if not room then return end

    local myActualTeam = player.team
    local nextTeam = myActualTeam == 'ct' and 'tr' or 'ct'
    local player_info = {}
    for i = 1, #room.teamsPlayers[myActualTeam] do
        local player = room.teamsPlayers[myActualTeam][i]
        if player and player.user_id == user_id then
            self.PLAYERS[user_id].team = nextTeam

            table.remove(room.teamsPlayers[myActualTeam], i)

            room.teamsPlayers[nextTeam][#room.teamsPlayers[nextTeam] + 1] = player
        end
    end

    TEAMS:syncTeams(player.id)
end

function TEAMS:destroyLobby(room_id)
    local roomData = ROOMS.list['teams'][room_id]
    if not roomData then return end
    
    ROOMS:Destroy(roomData, 'A sala '..roomData.name..' foi destruida por não ter mais jogadores.', true)

    Wait(1000)
    for user_id, v in pairs(self.PLAYERS) do
        if v.id == room_id then
            local ply_src = vRP.getUserSource(user_id)
            if ply_src then
                Player(ply_src).state.inPvP = false
                TriggerClientEvent('flaviin:toggleHud', ply_src, true)

                Execute._destroyTeams(ply_src)
                SetPlayerRoutingBucket(ply_src, 0)
            end

            self.PLAYERS[user_id] = nil
        end
    end
end

function TEAMS:startGame(source, user_id)
    local player = self.PLAYERS[user_id]
    if not player then 
        return TriggerClientEvent('Notify', source, 'negado', 'Player não encontrado', 5)
    end

    local room = ROOMS.list[player.mode][player.id]
    if not room then 
        return TriggerClientEvent('Notify', source, 'negado', 'Sala não encontrada', 5)
    end

    if room.owner_id ~= user_id then 
        return TriggerClientEvent('Notify', source, 'negado', 'Você não é o dono da sala', 5)
    end

    local totalPlayersCt, totalPlayersTr = 0, 0
    for team, players in pairs(room.teamsPlayers) do
        for i = 1, #players do
            if team == 'ct' then
                totalPlayersCt = totalPlayersCt + 1
            else
                totalPlayersTr = totalPlayersTr + 1
            end
        end
    end

    -- if totalPlayersCt <= 0 or totalPlayersTr <= 0 then
    --     return TriggerClientEvent('Notify', source, 'negado', 'Não é possível iniciar o jogo com menos de 1 jogador em cada time', 5)
    -- end

    self.STARTED_ROOMS[room.id] = {
        ['ct'] = 0,
        ['tr'] = 0
    }

    local ct_slot = 0
    local tr_slot = 0
    for team, players in pairs(room.teamsPlayers) do
        for i = 1, #players do
            local player = players[i]
            local ply_src = vRP.getUserSource(player.user_id)
            if ply_src then
                if team == 'ct' then
                    ct_slot = ct_slot + 1
                else
                    tr_slot = tr_slot + 1
                end

                SetPlayerRoutingBucket(ply_src, (room.id + 10))
                Player(ply_src).state.inPvP = true
                TriggerClientEvent('flaviin:toggleHud', ply_src, false)

                Execute._startTeams(ply_src, team, {
                    weapon = room.weapon,
                    map = room.map,
                    mode = room.mode,
                    slot = team == 'ct' and ct_slot or tr_slot
                })
            end
        end
    end

    CreateThread(function()
        local roomId = room.id
        local roundTime = (Config.Teams.timePerRound * 60) + 1
        while self.STARTED_ROOMS[roomId] do
            roundTime = roundTime - 1
    
            local room = ROOMS.list['teams'][roomId]
            if not room then
                self.STARTED_ROOMS[roomId] = nil
                break
            end
    
            local players = room.teamsPlayers
            local totalPlayersCt, totalPlayersAliveCt = 0, 0
            local totalPlayersTr, totalPlayersAliveTr = 0, 0
    
            for team in pairs(players) do
                for i = 1, #players[team] do
                    local player = players[team][i]
                    local ply_src = vRP.getUserSource(player.user_id)
                    if not ply_src then
                        table.remove(players[team], i)
                        goto next_player
                    end

                    local room_id = (room.id + 10) 
                    if GetPlayerRoutingBucket(ply_src) ~= room_id then   
                        SetPlayerRoutingBucket(ply_src, room_id)
                    end
    
                    if team == 'ct' then
                        totalPlayersCt = totalPlayersCt + 1
    
                        if GetEntityHealth(GetPlayerPed(ply_src)) > 101 then
                            totalPlayersAliveCt = totalPlayersAliveCt + 1
                        end
                    else
                        totalPlayersTr = totalPlayersTr + 1
    
                        if GetEntityHealth(GetPlayerPed(ply_src)) > 101 then
                            totalPlayersAliveTr = totalPlayersAliveTr + 1
                        end
                    end
    
                    ::next_player::
                end
            end

            if self.STARTED_ROOMS[room.id]['tr'] >= room.rounds then
                self:DestroyRoom(room.id, 'A sala '..room.name..' foi finalizada tendo o time TR como vencedor.')
                break;
            end

            if self.STARTED_ROOMS[room.id]['ct'] >= room.rounds then
                self:DestroyRoom(room.id, 'A sala '..room.name..' foi finalizada tendo o time CT como vencedor.')
                break;
            end

            if totalPlayersTr == 0 or totalPlayersCt == 0 then
                self.STARTED_ROOMS[roomId] = nil
                self:DestroyRoom(roomId, 'A sala '..room.name..' foi destruida por não ter mais jogadores no time '..(totalPlayersTr == 0 and 'TR' or 'CT')..'.')
                break
            end

            if totalPlayersAliveCt == 0 then
                roundTime = (Config.Teams.timePerRound * 60) + 1
                self.STARTED_ROOMS[room.id]['tr'] = self.STARTED_ROOMS[room.id]['tr'] + 1
                self:forcePositions(room.id)
            end

            if totalPlayersAliveTr == 0 then
                roundTime = (Config.Teams.timePerRound * 60) + 1
                self.STARTED_ROOMS[room.id]['ct'] = self.STARTED_ROOMS[room.id]['ct'] + 1
                self:forcePositions(room.id)
            end

            if roundTime <= 0 then
                roundTime = (Config.Teams.timePerRound * 60) + 1
    
                if totalPlayersAliveCt >= totalPlayersAliveTr then
                    self.STARTED_ROOMS[room.id]['ct'] = self.STARTED_ROOMS[room.id]['ct'] + 1
                else
                    self.STARTED_ROOMS[room.id]['tr'] = self.STARTED_ROOMS[room.id]['tr'] + 1
                end
    
                self:forcePositions(room.id)
            end
    
            Wait(1000)
        end
    end)
    

    return true
end

function TEAMS:DestroyRoom(room_id, reason)
    local room = ROOMS.list['teams'][room_id]
    if not room then return end

    Wait(1000)
    for user_id, v in pairs(self.PLAYERS) do
        async(function()
            if v.id == room_id then
                local ply_src = vRP.getUserSource(user_id)
                if ply_src then
                    Player(ply_src).state.inPvP = false
                    TriggerClientEvent('flaviin:toggleHud', ply_src, true)
                    
                    Execute._destroyRoom(ply_src)
                    
                    SetPlayerRoutingBucket(ply_src, 0)
                end
    
                self.PLAYERS[user_id] = nil
            end
        end)
    end

    Wait(100)
    ROOMS:Destroy(room, reason, true)
end

function TEAMS:leaveTeams(source, user_id)
    print(1)
    local player = self.PLAYERS[user_id]
    if not player then return end

    print(2)

    local room = ROOMS.list[player.mode][player.id]
    if not room then return end

    print(3)

    for team in pairs(room.teamsPlayers) do
        for i = 1, #room.teamsPlayers[team] do
            local player = room.teamsPlayers[team][i]
            if player.user_id == user_id then
                table.remove(room.teamsPlayers[team], i)
                break
            end
        end
    end

    print(4)

    self.PLAYERS[user_id] = nil

    Player(source).state.inPvP = false
    TriggerClientEvent('flaviin:toggleHud', source, true)
    
    Execute._destroyRoom(source)

    SetPlayerRoutingBucket(source, 0)
end

function TEAMS:forcePositions(room_id)
    local room = ROOMS.list['teams'][room_id]
    if not room then return end

    local players = room.teamsPlayers
    local ct_slot = 0
    local tr_slot = 0
    for team in pairs(players) do
        for i = 1, #players[team] do
            local player = players[team][i]

            if team == 'ct' then
                ct_slot = ct_slot + 1
                local ply_src = vRP.getUserSource(player.user_id)
                if ply_src then
                    Execute._forcePositions(ply_src, 'ct', ct_slot, self.STARTED_ROOMS[room_id])
                end 
            else
                tr_slot = tr_slot + 1
                local ply_src = vRP.getUserSource(player.user_id)
                if ply_src then
                    Execute._forcePositions(ply_src, 'tr', tr_slot, self.STARTED_ROOMS[room_id])
                end
            end
        end
    end
end

function TEAMS:getScoreboardTeams(source, user_id)
    local player = self.PLAYERS[user_id]
    if not player then return end

    local room = ROOMS.list[player.mode][player.id]
    if not room then return end

    local formatTeams = {}
    for team in pairs(room.teamsPlayers) do
        for i = 1, #room.teamsPlayers[team] do
            local user = room.teamsPlayers[team][i]
            if not user then
                goto next_user
            end

            local ply_src = vRP.getUserSource(user.user_id)
            if not ply_src then
                goto next_user
            end

            formatTeams[#formatTeams + 1] = {
                elo = user.elo,
                name = user.name,
                ping = GetPlayerPing(ply_src),
                kills = user.kills,
                deaths = user.deaths,
                team = team
            }

            :: next_user ::
        end
    end

    return formatTeams
end

local blockKills = {}
function TEAMS:updateTeamsFeed(data)
    if data.attacker and data.attacker > 0 and GetPlayerPed(data.attacker) == 0 then
        return
    end

    if blockKills[data.attacker] and (blockKills[data.attacker] - os.time()) > 0 then
        return
    end	
    blockKills[data.attacker] = (os.time() + 1)

    local user_id = vRP.getUserId(data.attacker)
    if not user_id then return end

    local account = ACCOUNTS.users[user_id]
    if not account then return end

    local nsource = data.victim
    local nuser_id = vRP.getUserId(nsource)
    if not nuser_id then return end

    if GetEntityHealth(GetPlayerPed(nsource)) > 101 then 
        return 
    end

    local naccount = ACCOUNTS.users[nuser_id]
    if not naccount then return end

    local player = self.PLAYERS[user_id]
    if not player then return end

    local room = ROOMS.list[player.mode][player.id]
    if not room then return end

    local killFeedData = {
        killer = account.data.nickname,
        victim = naccount.data.nickname,
        image = 'http://177.54.148.31:4020/inventario/'.. (Config.Images[data.weapon] or 'WEAPON_UNARMED') ..'.png'
    }

    for team in pairs(room.teamsPlayers) do
        for i = 1, #room.teamsPlayers[team] do
            local player = room.teamsPlayers[team][i]
            local ply_src = vRP.getUserSource(player.user_id)
            if ply_src then
                Execute._syncKillFeed(ply_src, killFeedData)
            end

            if player.user_id == user_id then
                room.teamsPlayers[team][i].kills = (room.teamsPlayers[team][i].kills + 1)
            end

            if player.user_id == nuser_id then
                room.teamsPlayers[team][i].deaths = (room.teamsPlayers[team][i].deaths + 1)
            end
        end
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CreateTunnel.requestTeams()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    return TEAMS:getTeams(source, user_id)
end

function CreateTunnel.leaveTeam()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    return TEAMS:leaveTeam(source, user_id)
end

function CreateTunnel.leaveTeams()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    return TEAMS:leaveTeams(source, user_id)
end

function CreateTunnel.changeTeam()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    return TEAMS:changeTeam(source, user_id)
end

function CreateTunnel.startGame()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    return TEAMS:startGame(source, user_id)
end

function CreateTunnel.requireTeamsScoreboard()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    return TEAMS:getScoreboardTeams(source, user_id)
end

function CreateTunnel.updateTeamsFeed(data)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    return TEAMS:updateTeamsFeed(data)
end

RegisterCommand('bucket', function(source)
    print(GetPlayerRoutingBucket(source))
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HANDLERS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('vRP:playerLeave', function(user_id, source)
    local player = TEAMS.PLAYERS[user_id]
    if not player then return end

    TEAMS:leaveTeam(source, user_id)
end)