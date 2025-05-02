------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local X1 = {
    list = {},
    owners = {},
    invites_user = {},
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function X1:Create(data)
    local ply_src = vRP.getUserSource(data.invited_id)
    if not ply_src or GetPlayerPed(ply_src) <= 0 then
        TriggerClientEvent('Notify', data.owner_source, 'negado', 'O usuário não está conectado no servidor.', 5000)
        return false
    end

    if self.owners[data.owner_id] then
        TriggerClientEvent('Notify', data.owner_source, 'negado', 'Você está em um X1 ou está com uma request pendente.', 5000)
        return false
    end

    if self.invites_user[data.invited_id] then
        TriggerClientEvent('Notify', data.owner_source, 'negado', 'Este jogador já recebeu uma request ou já está em um X1, aguarde.', 5000)
        return false
    end

    local isNear = false
    local pedCoords = GetEntityCoords(GetPlayerPed(ply_src))
    for _, coords in pairs(Config.coords) do       
        if #(pedCoords - vec3(coords.x,coords.y,coords.z)) <= 10 then
            isNear = true
        end
    end
    
    if not isNear then
        TriggerClientEvent('Notify', data.owner_source, 'negado', 'O Outro Jogador precisa estar perto da Arena para receber uma request.', 5000)
        return false
    end

    -- Formatando Usuário Invitado
    data.invited_source = ply_src
    data.accepted = 'waiting'

    data.ownerScore = 0
    data.invitedScore = 0
    data.invite_at = os.time()

    local gen_id = (#self.list + 1)
    self.list[gen_id] = data

    Execute._sendX1Invite(ply_src, {
        owner_username = data.owner_username,
        weapon = data.weapon,
        rounds = data.rounds,
        bet = data.bet,
        makapoints = data.makapoints,
    })

    self.invites_user[data.invited_id] = gen_id
    self.owners[data.owner_id] = gen_id

    while self.list[gen_id] and self.list[gen_id].accepted == 'waiting' do
        if (os.time() - self.list[gen_id].invite_at) > 10 then
            self.list[gen_id].accepted = 'refused'
        end

        Wait(1000)
    end

    -- Startar se aceitarem 
    if self.list[gen_id].accepted == 'accepted' then
        self:Start(gen_id)
    end

    -- Remover da lista se recusarem
    if self.list[gen_id].accepted == 'refused' then
        self.invites_user[data.invited_id] = nil
        self.owners[data.owner_id] = nil
        self.list[gen_id] = nil

        TriggerClientEvent('Notify', data.owner_source, 'sucesso', 'O usuário recusou o X1.', 5000)
    end
end

function X1:Start(id)
    local data = self.list[id]
    if not data then return end

    SetPlayerRoutingBucket(data.owner_source, id + 10)
    SetTimeout(2000,function() 
        SetPlayerRoutingBucket(data.owner_source, id + 10)
    end)
    Player(data.owner_source).state.inPvP = true
    TriggerClientEvent('flaviin:toggleHud', data.owner_source, false)
    TriggerClientEvent('join:game:x1', data.owner_source, { weapon = data.weapon, pos = 1 })

    SetPlayerRoutingBucket(data.invited_source, id  + 10)
    SetTimeout(2000,function() 
        SetPlayerRoutingBucket(data.invited_source, id  + 10)
    end)
    Player(data.invited_source).state.inPvP = true
    TriggerClientEvent('flaviin:toggleHud', data.invited_source, false)
    TriggerClientEvent('join:game:x1', data.invited_source, { weapon = data.weapon, pos = 2 })

    self.list[id].startAt = os.time()

    CreateThread(function()
        while self.list[id] and self.list[id].startAt and self.list[id].startAt > 0 do
            local time = (Config.X1.maxTime * 60) - (os.time() - self.list[id].startAt)
            if time <= 0 then
                self:End(id)
            end

            Wait(1000)
        end
    end)
end

function X1:End(id, winner_name, loser_name)
    local data = self.list[id]
    if winner_name then
        TriggerClientEvent('chatMessage', -1, {
            prefix = 'ARENA',
            prefixColor = '#000',
            title = 'PVP',
            message = 'O X1 foi finalizado, o vencedor foi ' .. winner_name .. ' contra ' .. loser_name .. ' por ' .. data.ownerScore .. ' / ' .. data.invitedScore .. ' .'
        })

        if winner_name == data.owner_username then
            local winner_id = vRP.getUserId(data.owner_source)
            local loser_id = vRP.getUserId(data.invited_source)

            if winner_id then
                if data.makapoints then
                    print('Pagar em MAKAPOINTS')
                else
                    if vRP.tryFullPayment(loser_id, data.bet) then
                        vRP.giveMoney(winner_id, data.bet)
                        TriggerClientEvent('Notify', data.owner_source, 'sucesso', 'Você ganhou R$ ' .. data.bet .. ' do X1.', 5000)
                    else
                        TriggerClientEvent('Notify', data.owner_source, 'negado', 'O Perdedor não tem dinheiro suficiente para pagar o X1.', 5000)
                    end
                end
            end
        end

        if winner_name == data.user then
            local winner_id = vRP.getUserId(data.invited_source)
            local loser_id = vRP.getUserId(data.owner_source)

            if winner_id then
                if data.makapoints then
                    print('Pagar em MAKAPOINTS')
                else
                    if vRP.tryFullPayment(loser_id, data.bet) then
                        vRP.giveMoney(winner_id, data.bet)
                        TriggerClientEvent('Notify', data.owner_source, 'sucesso', 'Você ganhou R$ ' .. data.bet .. ' do X1.', 5000)
                    else
                        TriggerClientEvent('Notify', data.owner_source, 'negado', 'O Perdedor não tem dinheiro suficiente para pagar o X1.', 5000)
                    end
                end
            end
        end
    end

    if GetPlayerPed(data.owner_source) > 0 then         
        TriggerClientEvent('end:game:x1', data.owner_source)
        TriggerClientEvent('flaviin:toggleHud', data.owner_source, true)

        vRPclient._giveWeapons(data.owner_source, {}, true)

        Player(data.owner_source).state.inPvP = false

        SetTimeout(1000,function()
            SetPlayerRoutingBucket(data.owner_source, 0)
        end)
    end

    if GetPlayerPed(data.invited_source) > 0 then
        TriggerClientEvent('end:game:x1', data.invited_source)

        Player(data.invited_source).state.inPvP = false
        TriggerClientEvent('flaviin:toggleHud', data.invited_source, true)

        vRPclient._giveWeapons(data.invited_source, {}, true)

        SetTimeout(1000,function()
            SetPlayerRoutingBucket(data.invited_source, 0)
        end)
    end

    self.list[id] = nil
    self.invites_user[data.invited_id] = nil
    self.owners[data.owner_id] = nil
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CreateTunnel.requestCreateX1(data)
    local source = source
    local user_id = vRP.getUserId(source)

    if not user_id then 
        return 
    end

    data.owner_id = user_id
    data.owner_source = source
    data.owner_username = ACCOUNTS.users[user_id] and ACCOUNTS.users[user_id].data.nickname or 'Não encontrado'
    data.invited_id = data.user

    return X1:Create(data)
end

function CreateTunnel.sendX1Status(status)
    local source = source
    local user_id = vRP.getUserId(source)

    if not user_id then return end

    local id = X1.invites_user[user_id]
    if not id then return end

    X1.list[id].accepted = status and 'accepted' or 'refused'
end

local blockKills = {}
function CreateTunnel.syncKillFeed(data)
    if not data.attacker or (data.attacker and data.attacker > 0 and GetPlayerPed(data.attacker) == 0) then
        return
    end

    if blockKills[data.attacker] and (blockKills[data.attacker] - os.time()) > 0 then
        return
    end	
    blockKills[data.attacker] = (os.time() + 1)

    local user_id = vRP.getUserId(data.attacker)
    if not user_id then 
        return 
    end

    local nsource = data.victim
    local nuser_id = vRP.getUserId(nsource)
    if not nuser_id then 
        return 
    end

    local id = X1.owners[nuser_id] or X1.invites_user[nuser_id]
    if not id then
        return
    end

    local data = X1.list[id]
    if not data then
        return
    end

    if user_id == data.owner_id then
        X1.list[id].ownerScore = data.ownerScore + 1
    else
        X1.list[id].invitedScore = data.invitedScore + 1
    end

    if X1.list[id].ownerScore >= data.rounds then
        local winner_name = vRP.getUserIdentity(data.owner_id)
        if not winner_name then
            winner_name = {
                nome = 'Individuo',
                sobrenome = 'Indigente',
            }
        end

        local loser_name = vRP.getUserIdentity(data.invited_id) 
        if not loser_name then
            loser_name = {
                nome = 'Individuo',
                sobrenome = 'Indigente',
            }
        end

        return X1:End(id, winner_name.nome .. ' '.. winner_name.sobrenome, loser_name.nome .. ' '.. loser_name.sobrenome)
    end

    if X1.list[id].invitedScore >= data.rounds then
        local winner_name = vRP.getUserIdentity(data.invited_id)
        if not winner_name then
            winner_name = {
                nome = 'Individuo',
                sobrenome = 'Indigente',
            }
        end

        local loser_name = vRP.getUserIdentity(data.owner_id) 
        if not loser_name then
            loser_name = {
                nome = 'Individuo',
                sobrenome = 'Indigente',
            }
        end

        return X1:End(id, winner_name.nome .. ' '.. winner_name.sobrenome, loser_name.nome .. ' '.. loser_name.sobrenome)
    end

    -- FORÇAR ATUALIZAR A POSICAO
    TriggerClientEvent('sync:x1:position', data.owner_source, {
        owner_score = X1.list[id].ownerScore,
        invited_score = X1.list[id].invitedScore,
    })

    TriggerClientEvent('sync:x1:position', data.invited_source, {
        owner_score = X1.list[id].ownerScore,
        invited_score = X1.list[id].invitedScore,
    })
end

function CreateTunnel.leaveX1()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    if X1.invites_user[user_id] then
        X1:End(X1.invites_user[user_id])
    end

    if X1.owners[user_id] then
        X1:End(X1.owners[user_id])
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HANDLERS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('playerDropped', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then 
        return 
    end

    if X1.invites_user[user_id] then
        X1:End(X1.invites_user[user_id])
    end

    if X1.owners[user_id] then
        X1:End(X1.owners[user_id] )
    end
end)
