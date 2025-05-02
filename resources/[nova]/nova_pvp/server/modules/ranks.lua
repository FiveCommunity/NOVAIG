------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local RANKING = {}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CreateTunnel.requestRanking(type)
    local response = {}

    if (type == 'solo') then
        local players = RANKING:GetRanking('solo') or {}
        for _, player in pairs(players) do
            local elo = PROFILE:getElo(player.points).index:match("%a+")
            if elo == 'nenhum' then
                goto continue   	
            end

            response[#response + 1] = {
                name = player.nickname,
                clan = player.clan or 'Nenhum',
                wins = player.wins,
                kills = player.kills,
                points = player.points,
                status = ACCOUNTS.users_accounts[player.user_id] and true or false,
                elo = elo
            }

            ::continue::
        end
    end

    if (type == 'clans') then
        local clans = RANKING:GetRanking('clans') or {}
        for _, clan in pairs(clans) do
            local elo = SQUAD:getElo(clan.points).index:match("%a+")
            if elo == 'nenhum' then
                goto continue   	
            end

            response[#response + 1] = {
                name = clan.clan,
                clan = clan.clan,
                wins = clan.wins,
                kills = clan.kills,
                points = clan.points,
                status = false,
                elo = elo
            }

            ::continue::
        end
    end


    return response
end

function RANKING:GetRanking(type)
    local p = promise.new()
    PerformHttpRequest(Config.route.."/ranks/"..type, function(statusCode, response, headers)
        local data = {}
        if statusCode == 500 then
            p:resolve({ leave = false, error = 'error '..statusCode })
            return
        end

        data = json.decode(response)
        p:resolve(data)
    end, "GET")

    return Citizen.Await(p)
end