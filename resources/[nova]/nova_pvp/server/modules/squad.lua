------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SQUAD = {
    PLAYERS = {
        -- [1] = { 
        --     account_id = 10,
        --     clan = {
        --         tag = 'PCC',
        --         name = 'Primeiro Comando da Capital',
        --         color = '#FFF',
        --         eloName = 'Silver IV',
        --         points = {}
        --     }
        -- }
    }
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CreateTunnel.requestPlayerSquad()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    local user = ACCOUNTS.users[user_id]
    if not user then
        return
    end

    return SQUAD:findUser(user_id, user.data.user_id)
end

function CreateTunnel.requestSquad()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    local user = ACCOUNTS.users[user_id]
    if not user then
        return
    end

    local player = SQUAD.PLAYERS[user_id]
    if not player then
        return
    end

    local clanMembers, clanPoints = SQUAD:getMembers(player.clan.tag), 0
    local formatMembers = {}
    for i = 1, #clanMembers do
        formatMembers[i] = clanMembers[i]
        formatMembers[i].elo = PROFILE:getElo(clanMembers[i].points).index:match("%a+")

        clanPoints = clanPoints + clanMembers[i].points
    end

    local rank = SQUAD:getElo(clanPoints)
    return {
        tag = player.clan.tag, -- tag
        elo = rank.index:match("%a+"), -- o elo q o player ta
        name = player.clan.name, -- o nome do clã
        color = player.clan.color, -- cor escolhida
        eloName = rank.name,  -- Somar pontos de todos os membros e definir o elo do clan ( usar tabela playerRAnkings e multiplicar por 5 )
        points = { current = clanPoints, max = rank.requireNextLevel <= 0 and rank.firstLevelPoints or rank.requireNextLevel }, -- CURRENT = SOMA DE TODOS MEMBROS ( MAX = DEFINIR NA CONFIG POR RANKING )
        members = formatMembers
    }
end

function CreateTunnel.createSquad(data)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    local user = ACCOUNTS.users[user_id]
    if not user then
        return
    end

    -- if not vRP.hasGroup(user_id, 'clanpvp') then
    --     return
    -- end
    -- vRP.removeUserGroup(user_id, "clanpvp")

    data.leader = user.data.user_id
    data.tag = data.tag:upper()

    return SQUAD:create(source, data)
end

function CreateTunnel.inviteMember(id)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    local user = ACCOUNTS.users[user_id]
    if not user then
        return
    end

    local player = SQUAD.PLAYERS[user_id]
    if not player then
        return
    end

    local leader = player.account_id == player.clan.leader
    if not leader then
        return
    end

    local source_invite = vRP.getUserSource(id)
    if not source_invite then
        return TriggerClientEvent( "Notify", source, "negado", "O player nao esta online!", 5 )
    end

    local user_invite = ACCOUNTS.users[id]
    if not user_invite then
        return TriggerClientEvent( "Notify", source, "negado", "O Jogador precisa está com o menu aberto para receber o convite!", 5 )
    end

    TriggerClientEvent( "Notify", source_invite, "sucesso", "Você foi convidado para o clan "..player.clan.name.."!", 5 )
    TriggerClientEvent( "Notify", source, "sucesso", "Você convidou o jogador para o seu o clan "..player.clan.name.."!", 5 )
    local request = vRP.request(source_invite, "Você deseja entrar no clan "..player.clan.name.."?", 30)
    if request then
        TriggerClientEvent( "Notify", source, "sucesso", "O Jogador aceitou o convite!", 5 )
        SQUAD:setPlayerClan(source_invite, {
            tag = player.clan.tag,
            account_id = user_invite.data.user_id
        })
    end
end

function CreateTunnel.removeMember(id)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    local user = ACCOUNTS.users[user_id]
    if not user then
        return
    end

    local player = SQUAD.PLAYERS[user_id]
    if not player then
        return
    end

    local leader = player.account_id == player.clan.leader
    if not leader then
        return
    end

    SQUAD:removeMember(source, { tag = player.clan.tag, account_id = id })

    local clanMembers, clanPoints = SQUAD:getMembers(player.clan.tag), 0
    local formatMembers = {}
    for i = 1, #clanMembers do
        formatMembers[i] = clanMembers[i]
        formatMembers[i].elo = PROFILE:getElo(clanMembers[i].points).index:match("%a+")

        clanPoints = clanPoints + clanMembers[i].points
    end

    return formatMembers
end

function CreateTunnel.leaveSquad()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    local user = ACCOUNTS.users[user_id]
    if not user then
        return
    end

    local player = SQUAD.PLAYERS[user_id]
    if not player then
        return
    end

    return SQUAD:leave(source, {
        tag = player.clan.tag,
        hasLeader = user.data.user_id == player.clan.leader,
        account_id = user.data.user_id
    })
end

function CreateTunnel.updateSquadBanner(data)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    local user = ACCOUNTS.users[user_id]
    if not user then
        return
    end

    local player = SQUAD.PLAYERS[user_id]
    if not player then
        return
    end

    if not user.data.user_id == player.clan.leader then
        return
    end

    return SQUAD:updateBanner(source, {
        tag = player.clan.tag,
        color = data.color
    })
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function SQUAD:findUser(user_id, account_id)
    local p = promise.new()
    PerformHttpRequest(Config.route.."/clan/getUser", function(statusCode, response, headers)
        local data = {}
        if statusCode ~= 200 then
            p:resolve({ error = true })
            return
        end

        data = json.decode(response)
        p:resolve(data)
    end, "GET", json.encode({ user_id = account_id }), {
        ["Content-Type"] = "application/json"
    })

    local data = Citizen.Await(p)
    if data.error then
        return nil
    end

    if data.haveClan then
        self.PLAYERS[user_id] = {
            clan = data.clan,
            account_id = account_id
        }

        return { haveClan = true, clan = data.clan }
    end

    return { haveTicket = true }
    -- if vRP.hasGroup(user_id, 'clanpvp') then
    --     return { haveTicket = true }
    -- end

    -- return { haveClan = false }
end

function SQUAD:getMembers(tag)
    local p = promise.new()
    PerformHttpRequest(Config.route.."/clan/getClanMembers", function(statusCode, response, headers)
        local data = {}
        if statusCode ~= 200 then
            p:resolve({ error = true })
            return
        end

        data = json.decode(response)
        p:resolve(data)
    end, "GET", json.encode({ tag = tag }), {
        ["Content-Type"] = "application/json"
    })

    local data = Citizen.Await(p)
    return data.members
end

function SQUAD:create(source, body)
    local p = promise.new()
    PerformHttpRequest(Config.route.."/clan/createClan", function(statusCode, response, headers)
        local data = {}
        if statusCode ~= 201 and statusCode ~= 500 then
            p:resolve({ created = false, error = 'error '..statusCode })
            return
        end

        data = json.decode(response)
        p:resolve(data)
    end, "POST", json.encode(body), {
        ["Content-Type"] = "application/json"
    })

    local data = Citizen.Await(p)
    if not data.created then
        TriggerClientEvent( "Notify", source, "negado", data.error, 5 )
        return false
    end

    TriggerClientEvent("Notify", source, "sucesso", "Clan Criado com sucesso!", 5 )
    return true
end

function SQUAD:setPlayerClan(source, body)
    local p = promise.new()
    PerformHttpRequest(Config.route.."/clan/setPlayerClan", function(statusCode, response, headers)
        local data = {}
        if statusCode ~= 201 and statusCode ~= 500 then
            p:resolve({ enter = false, error = 'error '..statusCode })
            return
        end

        data = json.decode(response)
        p:resolve(data)
    end, "POST", json.encode(body), {
        ["Content-Type"] = "application/json"
    })

    local data = Citizen.Await(p)
    if not data.enter then
        TriggerClientEvent( "Notify", source, "negado", data.error, 5 )
        return false
    end

    TriggerClientEvent("Notify", source, "sucesso", "Você entrou no clan "..body.tag..".", 5 )
    return true
end

function SQUAD:removeMember(source, body)
    local p = promise.new()
    PerformHttpRequest(Config.route.."/clan/removeMember", function(statusCode, response, headers)
        local data = {}
        if statusCode ~= 201 and statusCode ~= 500 then
            p:resolve({ remove = false, error = 'error '..statusCode })
            return
        end

        data = json.decode(response)
        p:resolve(data)
    end, "POST", json.encode(body), {
        ["Content-Type"] = "application/json"
    })

    local data = Citizen.Await(p)
    if not data.remove then
        TriggerClientEvent( "Notify", source, "negado", data.error, 5 )
        return false
    end

    TriggerClientEvent("Notify", source, "sucesso", "Membro removido com sucesso!", 5 )
    return true
end
    
function SQUAD:leave(source, body)
    local p = promise.new()
    PerformHttpRequest(Config.route.."/clan/leaveClan", function(statusCode, response, headers)
        local data = {}
        if statusCode ~= 201 and statusCode ~= 500 then
            p:resolve({ leave = false, error = 'error '..statusCode })
            return
        end

        data = json.decode(response)
        p:resolve(data)
    end, "POST", json.encode(body), {
        ["Content-Type"] = "application/json"
    })

    local data = Citizen.Await(p)
    if not data.leave then
        TriggerClientEvent( "Notify", source, "negado", data.error, 5 )
        return false
    end

    TriggerClientEvent("Notify", source, "sucesso", "Você saiu do clan!", 5 )
    return true
end

function SQUAD:updateBanner(source, body)
    local p = promise.new()
    PerformHttpRequest(Config.route.."/clan/updateBanner", function(statusCode, response, headers)
        local data = {}
        if statusCode ~= 201 and statusCode ~= 500 then
            p:resolve({ update = false, error = 'error '..statusCode })
            return
        end

        data = json.decode(response)
        p:resolve(data)
    end, "POST", json.encode(body), {
        ["Content-Type"] = "application/json"
    })

    local data = Citizen.Await(p)
    if not data.update then
        TriggerClientEvent( "Notify", source, "negado", data.error, 5 )
        return false
    end

    TriggerClientEvent("Notify", source, "sucesso", "Banner atualizado com sucesso!", 5 )
    return true
end

function SQUAD:getElo(points)
    local rank = {
        index = 'nenhum',
        name = 'Nenhum',
        nextLevel = 0,
        requireNextLevel = 0
    }

    local formatRanks = {}
    for key, v in pairs(Config.ranks) do
        formatRanks[key * 5] = v
    end

    local keys = {}
    for k in pairs(formatRanks) do
        table.insert(keys, k)
    end
    table.sort(keys)

    local next_level_points = nil
    for i, necessaryPoints in ipairs(keys) do
        if points >= necessaryPoints then
            rank = formatRanks[necessaryPoints]
            next_level_points = keys[i + 1]
        end
    end

    if next_level_points then
        rank.nextLevel = next_level_points - points
        rank.requireNextLevel = next_level_points
    else
        rank.nextLevel = 0
        rank.requireNextLevel = 0
    end
    rank.firstLevelPoints = keys[1]
    
    return rank, first_elo_points
end