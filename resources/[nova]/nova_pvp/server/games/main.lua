------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ROOMS = {
    list = {
        ['ffa'] = {
            {
                owner_id = 0,
                oficial = true,
                id = 1, 
                index = 1,
                expire_at = (os.time() + (999 * 60)),
                rounds = 50,
                kills = 50,
                map = 'de_dust2',
                mode = 'ffa',
                weapon = 'Pistola MK2',
                players = { current = 0, max = 50 },
                currentPlayers = {},
                name = '[FFA] Sala Oficial 1', 
                private = false, 
                password = '', 
                image = 'http://177.54.148.31:4020/lotus/pvp_mapas/dust2.png'
            },

            {
                owner_id = 0,
                oficial = true,
                id = 2, 
                index = 2,
                expire_at = (os.time() + (999 * 60)),
                rounds = 50,
                kills = 50,
                map = 'clock_tower',
                mode = 'ffa',
                weapon = 'Carabina Especial',
                players = { current = 0, max = 50 },
                currentPlayers = {},
                name = '[FFA] Sala Oficial 2', 
                private = false, 
                password = '', 
                image = 'http://177.54.148.31:4020/lotus/pvp_mapas/clock.png'
            },

            {
                owner_id = 0,
                oficial = true,
                id = 3, 
                index = 3,
                expire_at = (os.time() + (999 * 60)),
                rounds = 50,
                kills = 50,
                map = 'mirage',
                mode = 'ffa',
                weapon = 'Pistola MK2',
                players = { current = 0, max = 50 },
                currentPlayers = {},
                name = '[FFA] Sala Oficial 3', 
                private = false, 
                password = '', 
                image = 'http://177.54.148.31:4020/lotus/pvp_mapas/mirage.png'
            },

            {
                owner_id = 0,
                oficial = true,
                id = 4, 
                index = 4,
                expire_at = (os.time() + (999 * 60)),
                rounds = 50,
                kills = 50,
                map = 'haven',
                mode = 'ffa',
                weapon = 'Carabina Especial',
                players = { current = 0, max = 50 },
                currentPlayers = {},
                name = '[FFA] Sala Oficial 4', 
                private = false, 
                password = '', 
                image = 'http://177.54.148.31:4020/lotus/pvp_mapas/haven.png'
            },
            
            {
                owner_id = 0,
                oficial = true,
                id = 5, 
                index = 5,
                expire_at = (os.time() + (999 * 60)),
                rounds = 50,
                kills = 50,
                map = 'treatro',
                mode = 'ffa',
                weapon = 'Pistola MK2',
                players = { current = 0, max = 50 },
                currentPlayers = {},
                name = '[FFA] Sala Oficial 5', 
                private = false, 
                password = '', 
                image = 'http://177.54.148.31:4020/lotus/pvp_mapas/treatro.png'
            }
        },

        ['gungame'] = {
            {
                owner_id = 0,
                oficial = true,
                id = 1, 
                index = 1,
                expire_at = (os.time() + (999 * 60)),
                rounds = 50,
                kills = 50,
                map = 'de_dust2',
                mode = 'gungame',
                weapon = 'Pistola',
                players = { current = 0, max = 50 },
                currentPlayers = {},
                name = '[GG] Sala Oficial 1', 
                private = false, 
                password = '', 
                image = 'http://177.54.148.31:4020/lotus/pvp_mapas/dust2.png'
            },

            {
                owner_id = 0,
                oficial = true,
                id = 2, 
                index = 2,
                expire_at = (os.time() + (999 * 60)),
                rounds = 50,
                kills = 50,
                map = 'clock_tower',
                mode = 'gungame',
                weapon = 'Pistola',
                players = { current = 0, max = 50 },
                currentPlayers = {},
                name = '[GG] Sala Oficial 2', 
                private = false, 
                password = '', 
                image = 'http://177.54.148.31:4020/lotus/pvp_mapas/clock.png'
            },

            {
                owner_id = 0,
                oficial = true,
                id = 3, 
                index = 3,
                expire_at = (os.time() + (999 * 60)),
                rounds = 50,
                kills = 50,
                map = 'mirage',
                mode = 'gungame',
                weapon = 'Pistola',
                players = { current = 0, max = 50 },
                currentPlayers = {},
                name = '[GG] Sala Oficial 3', 
                private = false, 
                password = '', 
                image = 'http://177.54.148.31:4020/lotus/pvp_mapas/mirage.png'
            },

            {
                owner_id = 0,
                oficial = true,
                id = 4, 
                index = 4,
                expire_at = (os.time() + (999 * 60)),
                rounds = 50,
                kills = 50,
                map = 'haven',
                mode = 'gungame',
                weapon = 'Pistola',
                players = { current = 0, max = 50 },
                currentPlayers = {},
                name = '[GG] Sala Oficial 4', 
                private = false, 
                password = '', 
                image = 'http://177.54.148.31:4020/lotus/pvp_mapas/haven.png'
            },
            
            {
                owner_id = 0,
                oficial = true,
                id = 5, 
                index = 5,
                expire_at = (os.time() + (999 * 60)),
                rounds = 50,
                kills = 50,
                map = 'treatro',
                mode = 'gungame',
                weapon = 'Pistola',
                players = { current = 0, max = 50 },
                currentPlayers = {},
                name = '[GG] Sala Oficial 5', 
                private = false, 
                password = '', 
                image = 'http://177.54.148.31:4020/lotus/pvp_mapas/treatro.png'
            }
        },

        ['teams'] = { }
    },

    owners = {
        -- [1] = {
        --     mode = 'ffa',
        --     index = 10,
        -- }
    },

    players = {
        -- [1] = { @user_id
        --     mode = 'ffa', @mode
        --     index = 1 @room_id
        -- }
    }
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ROOMS:Get(type)
    return {
        highscore = {'pedro', 'mirto', 'han'}, -- lista com o top 3, por ordem: 1, 2 e 3
        rooms = self.list[type] or {}
    }
end

function ROOMS:Create(data)
    data.players = tonumber(data.players) or 0
    
    if data.source and data.source > 0 then
        if self.owners[data.user_id] then
            TriggerClientEvent("Notify", data.source, "negado", "Você já possui uma sala criada!", 5 )
            return false
        end

        if data.players and data.players <= 1 or data.players > 15 then
            TriggerClientEvent("Notify", data.source, "negado", "Você precisa colocar pelo minimo 2 jogadores e no maximo 15.", 5 )
            return false
        end
    end

    if not self.list[data.mode] then
        self.list[data.mode] = {}
    end

    local id = (#self.list[data.mode] + 1)

    local players = {}
    if data.mode == 'teams' then
        players = { current = 1, max = data.players * 2 }
    else
        players = data.oficial and { current = 0, max = 50 } or { current = 1, max = data.players }
    end

    self.list[data.mode][id] = {
        owner_id = data.user_id,
        id = id, 
        index = data.index,
        oficial = data.oficial,
        expire_at = data.minutes and (os.time() + (data.minutes * 60)) or nil,
        rounds = data.rounds or data.kills,
        kills = data.kills,
        map = data.map.name,
        mode = data.mode,
        weapon = data.weapon,
        players = players,
        running = data.mode == 'teams' and false or false,
        currentPlayers = {},
        teamsPlayers = {},
        name = data.name, 
        private = data.private, 
        password = data.password, 
        image = data.map.image
    }

    if data.user_id and data.user_id > 0 then
        self.owners[data.user_id] = {
            index = id,
            mode = data.mode,
        }

        if data.mode == 'teams' then
            TEAMS:addPlayerTeam(self.list[data.mode][id], { source = data.source, user_id = data.user_id })

            Execute._forceOpenTeams(data.source, self.list[data.mode][id])
        else
            ROOMS:SetPlayerRoom({
                source = data.source,
                user_id = data.user_id,
                mode = data.mode,
                id = id,
            })
        end
    end

    return self.list[data.mode][id]
end

function ROOMS:Destroy(data, reason, forced, restart_script)
    print('Destroying room '..data.name..' with reason: '..reason)
    if not self.list[data.mode] or not self.list[data.mode][data.id] then
        return print('Tentando destruir uma sala não encontrada', data.mode, data.id)
    end

    local room = self.list[data.mode][data.id]
    if room.mode == 'teams' then
        if self.list[data.mode] and self.list[data.mode][data.id] then
            self.list[data.mode][data.id] = nil
        end
        
        self.owners[room.owner_id] = nil
        self.players[room.owner_id] = nil

        TriggerClientEvent('chatMessage', -1, {
            prefix = 'ARENA',
            prefixColor = '#000',
            title = 'PVP',
            message = reason
        })

        return
    end

    if not forced then -- SISTEMA DE PONTUAÇÃO
        if room.mode and Config.points[room.mode] then
            local points = Config.points[room.mode]

            local playerKills = {}
            for user_id, v in pairs(room.currentPlayers) do
                playerKills[#playerKills + 1] = {
                    user_id = user_id,
                    kills = v.kills 
                }
                
                local account = ACCOUNTS.users[user_id]
                if account and account.data then
                    -- ADICIONAR HISTORICO DE PARTIDAS
                    if not ACCOUNTS.users[user_id].data.last_matchs then
                        ACCOUNTS.users[user_id].data.last_matchs = {}
                    end

                    ACCOUNTS.users[user_id].data.last_matchs[#ACCOUNTS.users[user_id].data.last_matchs + 1] = {
                        type = room.mode,
                        win = false
                    } 
                    if #ACCOUNTS.users[user_id].data.last_matchs > 5 then
                        table.remove(ACCOUNTS.users[user_id].data.last_matchs, 1)
                    end

                    ACCOUNTS:updateMatchs({
                        user_id = account.data.user_id,
                        matchs = ACCOUNTS.users[user_id].data.last_matchs
                    })

                    -- ADICIONAR PONTOS
                    if room.players.current >= points.min_players then
                        local payment = math.floor(v.kills / points.kills.amount)
                        ACCOUNTS.users[user_id].data.points = (ACCOUNTS.users[user_id].data.points + payment)
                        ACCOUNTS:updatePoints({
                            user_id = account.data.user_id,
                            points = ACCOUNTS.users[user_id].data.points
                        })
                    end

                    -- ADICIONAR KILLS
                    ACCOUNTS:updateKills({
                        user_id = account.data.user_id,
                        kills = v.kills
                    })
                end
            end

            table.sort(playerKills, function(a, b) return a.kills > b.kills end)

            local winner_id = playerKills[1].user_id
            local account = ACCOUNTS.users[winner_id]
            if account and account.data then
                -- ADICIONAR HISTORICO DE PARTIDAS
                if ACCOUNTS.users[winner_id].data.last_matchs[#ACCOUNTS.users[winner_id].data.last_matchs] then
                    table.remove(ACCOUNTS.users[winner_id].data.last_matchs, #ACCOUNTS.users[winner_id].data.last_matchs)
                end
                
                ACCOUNTS.users[winner_id].data.last_matchs[#ACCOUNTS.users[winner_id].data.last_matchs + 1] = {
                    type = room.mode,
                    win = true
                }

                if #ACCOUNTS.users[winner_id].data.last_matchs > 5 then
                    table.remove(ACCOUNTS.users[winner_id].data.last_matchs, 1)
                end

                ACCOUNTS:updateMatchs({
                    user_id = account.data.user_id,
                    matchs = ACCOUNTS.users[winner_id].data.last_matchs
                })

                -- ADICIONAR PONTOS
                if room.players.current >= points.min_players then
                    ACCOUNTS.users[winner_id].data.points = (ACCOUNTS.users[winner_id].data.points + points.win)
                    ACCOUNTS:updatePoints({ 
                        user_id = account.data.user_id,
                        points = ACCOUNTS.users[winner_id].data.points
                    })
                end

                -- ADICIONAR WINS
                ACCOUNTS:updateWins({
                    user_id = account.data.user_id,
                    wins = 1
                })
            end
        end
    end

    for user_id, v in pairs(room.currentPlayers) do
        async(function()
            if GetPlayerPed(v.source) > 0 then
                Execute._destroyRoom(v.source)
                Player(v.source).state.inPvP = false
                TriggerClientEvent('flaviin:toggleHud', v.source, true)
    
                
                Wait(1000)
                SetPlayerRoutingBucket(v.source, 0)
            end
    
            self.owners[user_id] = nil
            self.players[user_id] = nil
        end)
    end

    TriggerClientEvent('chatMessage', -1, {
        prefix = 'ARENA',
        prefixColor = '#000',
        title = 'PVP',
        message = reason
    })


    if self.list[data.mode] and self.list[data.mode][data.id] then
        self.list[data.mode][data.id] = nil
    end

    -- Recriar Sala Oficial
    if not restart_script and room.oficial then
        ROOMS:Create({
            owner_id = 0,
            index = room.index,
            minutes = room.mode == 'gungame' and 30 or nil,
            oficial = room.oficial,
            rounds = 50,
            kills = 50,
            map = {
                name = room.map,
                image = room.image
            },
            mode = room.mode,
            weapon = room.weapon,
            players = { current = 0, max = 50 },
            currentPlayers = {},
            name = room.name, 
            private = data.private, 
            password = room.password
        })
    end
end

function ROOMS:SetPlayerRoom(data)
    if not self.list[data.mode] or not self.list[data.mode][data.id] then
        return TriggerClientEvent("Notify", data.source, "negado", "Sala não encontrada.", 5 )
    end

    local room = self.list[data.mode][data.id]
    if room.players.current >= room.players.max then
        return TriggerClientEvent("Notify", data.source, "negado", "Sala cheia.", 5 )
    end

    if room.owner_id ~= data.user_id then
        room.players.current = (room.players.current + 1)
    end

    -- Adicionado jogador na lista
    self.players[data.user_id] = {
        index = data.id,
        mode = data.mode,
    }

    -- Adicionado jogador na sala
    self.list[data.mode][data.id].currentPlayers[data.user_id] = {
        source = data.source,
        kills = 0,
        deaths = 0
    }

    -- Setando Açoes
    Player(data.source).state.inPvP = true
    SetPlayerRoutingBucket(data.source, room.id)

    SetTimeout(2000, function()
        SetPlayerRoutingBucket(data.source, room.id)
    end)

   local eventData = {
        source = data.source,
        user_id = data.user_id,
        mode = room.mode,
        map = room.map,
        weapon = room.weapon
    }
    
    TriggerEvent('join:game:'..data.mode, eventData)
    TriggerClientEvent('join:game:'..data.mode, data.source, eventData, room.expire_at and (room.expire_at - os.time()) or false)
    TriggerClientEvent('Notify', data.source, 'sucesso', 'Você entrou na sala '..room.name..' no modo '..room.mode..' para sair digite o comando /pvpoff !', 15000)
    TriggerClientEvent('flaviin:toggleHud', data.source, false)
end

function ROOMS:Join(data)
    if self.players[data.user_id] then
        return TriggerClientEvent("Notify", data.source, "negado", "Você já está em um modo PvP.", 5 )
    end

    local room = self.list[data.mode][data.id]
    if not room then
        return TriggerClientEvent("Notify", data.source, "negado", "Sala não encontrada.", 5 )
    end

    if room.players.current >= room.players.max then
        return TriggerClientEvent("Notify", data.source, "negado", "Sala cheia.", 5 )
    end

    data.expire_at = room.expire_at and (room.expire_at - os.time()) or false
    if room.mode == 'teams' then
        if TEAMS.STARTED_ROOMS[room.id] then
            return TriggerClientEvent("Notify", data.source, "negado", "Sala já iniciada.", 5 )
        end

        TEAMS:addPlayerTeam(room, { source = data.source, user_id = data.user_id })

        Execute._forceOpenTeams(data.source, room)
        return
    end

    self:SetPlayerRoom(data)

    return true
end

function ROOMS:Leave(source, user_id, leave)
    if not self.players[user_id] then return end

    local room = self.list[self.players[user_id].mode][self.players[user_id].index]
    if not room then return end

    local totalPlayers = (room.players.current - 1)
    self.list[self.players[user_id].mode][self.players[user_id].index].players.current = totalPlayers

    if totalPlayers <= 0 then
        return self:Destroy(room, 'A sala '..room.name..' foi destruida por não ter mais jogadores.', true)
    end

    if not leave then
        Execute._destroyRoom(source)
        Player(source).state.inPvP = false
        TriggerClientEvent('flaviin:toggleHud', source, true)

        Wait(1000)
        SetPlayerRoutingBucket(source, 0)
    end

    if room.currentPlayers[user_id] then
        room.currentPlayers[user_id] = nil
    end

    if self.owners[user_id] then
        self.owners[user_id] = nil
    end

    if self.players[user_id] then
        self.players[user_id] = nil
    end
end

function ROOMS:GetScoreboard(user_id)
    local player = self.players[user_id]
    if not player then return end

    local room = self.list[player.mode][player.index]
    if not room then return end

    local scoreboard = {}
    for user_id, v in pairs(room.currentPlayers) do
        local user = ACCOUNTS.users[user_id]
        if not user then goto next_player end

        local rank = PROFILE:getElo(user.data.points)
        local id = (#scoreboard + 1)
        scoreboard[id] = {
            elo = rank.index:match("%a+") ~= 'nenhum' and rank.index:match("%a+") or false,
            name = ACCOUNTS.users[user_id].data.nickname or 'N/A',
            ping = GetPlayerPing(v.source),
            kills = v.kills,
            deaths = v.deaths
        }

        if room.mode == 'gungame' then
            local currentWeapon = 'WEAPON_UNARMED'
            for i = 1, #Config.Gungame.weapons do
                if v.kills >= Config.Gungame.weapons[i].current_kills then
                    currentWeapon = Config.Gungame.weapons[i].weapon
                end
            end

            scoreboard[id].weapon = 'http://177.54.148.31:4020/lotus/pvp/'..currentWeapon..'.png'
        end

        :: next_player ::
    end
    table.sort(scoreboard, function(a, b) return a.kills > b.kills end)

    return scoreboard
end

function ROOMS:startTimer()
    while true do
        local rooms = self.list
        for mode, v in pairs(rooms) do
            for id, room in pairs(v) do
                pcall(function()
                    if not room.oficial and room.expire_at then
                        if room.expire_at and (room.expire_at - os.time()) < 0 then
                            self:Destroy(room, 'A sala '..room.name..' do modo '..room.mode..' acabou o tempo.', false)
                        end
                    end
    
                    if not room.oficial and room.players.current <= 0 then
                        self:Destroy(room, 'A sala '..room.name..' foi destruida por não ter mais jogadores.', true)
                    end
    
                    local players = room.currentPlayers
                    for user_id, v in pairs(players) do
                        local ping = GetPlayerPing(v.source)
                        if not ping or ping <= 0 then
                            self:Leave(v.source, user_id, true)
                        end
                    end

                    :: next_room ::
                end)
            end
        end

        Wait(1000)
    end
end

RegisterCommand('list_rooms', function(source,args)
    SaveResourceFile(GetCurrentResourceName(), 'rooms.json', json.encode(ROOMS.list, { indent = true }), -1)
    SaveResourceFile(GetCurrentResourceName(), 'owners.json', json.encode(ROOMS.owners, { indent = true }), -1)
    SaveResourceFile(GetCurrentResourceName(), 'players.json', json.encode(ROOMS.players, { indent = true }), -1)
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CreateTunnel.getRooms(type)
    return ROOMS:Get(type)
end

function CreateTunnel.CreateRoom(data)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    data.source = source
    data.user_id = user_id

    return ROOMS:Create(data)
end

function CreateTunnel.JoinRoom(data)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    data.source = source
    data.user_id = user_id

    return ROOMS:Join(data)
end

local blockKills = {}
function CreateTunnel.sendKillFeed(data)
    if not data.attacker or data.attacker <= 0 or GetPlayerPed(data.attacker) == 0 then
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

    local naccount = ACCOUNTS.users[nuser_id]
    if not naccount then return end

    local player = ROOMS.players[user_id]
    if not player then return end

    local room = ROOMS.list[player.mode][player.index]
    if not room then return end

    local killFeedData = {
        killer = account.data.nickname,
        victim = naccount.data.nickname,
        image = 'http://177.54.148.31:4020/inventario/'.. (Config.Images[data.weapon] or 'WEAPON_UNARMED') ..'.png'
    }

    if not ROOMS.list[player.mode][player.index].currentPlayers[user_id] then
        ROOMS.list[player.mode][player.index].currentPlayers[user_id] = {
            source = data.attacker,
            kills = 0,
            deaths = 0
        }
    end

    if not ROOMS.list[player.mode][player.index].currentPlayers[nuser_id] then
        ROOMS.list[player.mode][player.index].currentPlayers[nuser_id] = {
            source = data.victim,
            kills = 0,
            deaths = 0
        }
    end
    
    local kills = ROOMS.list[player.mode][player.index].currentPlayers[user_id].kills
    ROOMS.list[player.mode][player.index].currentPlayers[user_id].kills = (kills + 1)
    ROOMS.list[player.mode][player.index].currentPlayers[nuser_id].deaths = (ROOMS.list[player.mode][player.index].currentPlayers[nuser_id].deaths + 1)

    Execute._syncKills(data.attacker, ROOMS.list[player.mode][player.index].currentPlayers[user_id].kills)

    if (data.mode == 'gungame') then
        Execute._updateWeapon(data.attacker, kills)

        local lastWeapon = Config.Gungame.weapons[#Config.Gungame.weapons]
        if lastWeapon then
            if kills >= (lastWeapon.current_kills + 1) then
                ROOMS:Destroy(room, 'O '..account.data.nickname..' venceu o modo '..room.mode..' na '..room.map..' com '..kills..' kills.')
            end
        end
    end

    if (data.mode == 'ffa') then
        if kills and room.rounds and kills >= room.rounds then
            ROOMS:Destroy(room, 'O '..account.data.nickname..' venceu o modo '..room.mode..' na '..room.map..' com '..kills..' kills.')
        end
    end

    for user_id, v in pairs(room.currentPlayers) do
        if GetPlayerPed(v.source) > 0 and GetPlayerRoutingBucket(v.source) == room.id then
            Execute._syncKillFeed(v.source, killFeedData)
        end
    end
end

function CreateTunnel.requireScoreboard()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    return ROOMS:GetScoreboard(user_id)
end

function CreateTunnel.leaveRoom()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    return ROOMS:Leave(source, user_id)
end

CreateThread(function()
    ROOMS:startTimer()
end)

AddEventHandler('vRP:playerLeave',function(user_id, source)
    if ROOMS.players[user_id] then
        ROOMS:Leave(source, user_id, true)
    end
end)

AddEventHandler('onResourceStop',function(resource)
    if resource == GetCurrentResourceName() then
        for mode, v in pairs(ROOMS.list) do
            for id, room in pairs(v) do
                ROOMS:Destroy(room, 'O script foi reiniciado.', true, true)
            end
        end
    end
end)

RegisterCommand('destroy_arena', function(source,args)
    if source ~= 0 then return end
    for mode, v in pairs(ROOMS.list) do
        for id, room in pairs(v) do
            ROOMS:Destroy(room, 'O script foi reiniciado.', true)
        end
    end
end)