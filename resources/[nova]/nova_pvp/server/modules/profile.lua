------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROFILE = {}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CreateTunnel.requestProfile()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local user = ACCOUNTS.users[user_id]
    if not user then return end

    local clan = SQUAD:findUser(user_id, user.data.user_id)
    if clan and clan.haveClan then
        clan.tag = SQUAD.PLAYERS[user_id].clan.tag

        local clanMembers, clanPoints = SQUAD:getMembers(clan.tag), 0
        for _, member in ipairs(clanMembers) do
            clanPoints = clanPoints + member.points
        end

        local rank = SQUAD:getElo(clanPoints)
        clan.currentPoints = clanPoints
        clan.nextPoints = rank.requireNextLevel
        clan.elo = rank.index:match("%a+")
        clan.name = rank.name
        clan.firstLevelPoints = rank.firstLevelPoints
    end

    local rank = PROFILE:getElo(user.data.points)
    local solo = rank.index:match("%a+") ~= 'nenhum' and {
        elo = rank.index:match("%a+"),
        name = rank.name,
        points = {
            current = user.data.points,
            max = rank.requireNextLevel <= 0 and rank.firstLevelPoints or rank.requireNextLevel
        }
    } or false

    local squad = clan and clan.haveClan and clan.elo:match("%a+") ~= 'nenhum' and {
        elo = clan.elo:match("%a+"),
        name = clan.name,
        points = {
            current = clan.currentPoints,
            max = clan.nextPoints <= 0 and clan.firstLevelPoints or clan.nextPoints
        }
    } or false

    return {
        id = user.data.user_id,
        name = user.data.nickname,
        clan = clan and clan.haveClan and clan.tag or false,
        leader = SQUAD.PLAYERS[user_id] and SQUAD.PLAYERS[user_id].clan.leader == user.data.user_id or false,
        icon = '',
        color = user.data.color,
        banner = user.data.banner ~= 'default.png' and user.data.banner or nil,
        elos = {
            solo = solo,
            squad = squad
        },
        matchs = user.data.last_matchs or {}
    }
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function PROFILE:getElo(points)
    local rank = {
        index = 'nenhum',
        name = 'Nenhum',
        nextLevel = 0,
        requireNextLevel = 0
    }

    local keys = {}
    for k in pairs(Config.ranks) do
        table.insert(keys, k)
    end
    table.sort(keys)

    local next_level_points = nil
    for i, necessaryPoints in ipairs(keys) do
        if points >= necessaryPoints then
            rank = Config.ranks[necessaryPoints]
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
    rank.firstLevelPoints = keys[1] or 0

    return rank
end

