------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QUERYS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare('lotus_box/updateUser', 'INSERT IGNORE INTO lotusbox_hours(user_id, time) VALUES(@user_id, @time) ON DUPLICATE KEY UPDATE time = time + @time')
vRP.prepare('lotus_box/getRanks', 'SELECT * FROM lotusbox_hours ORDER BY time DESC LIMIT 10')
vRP.prepare('lotus_box/getMyRank', 'SELECT * FROM ( SELECT user_id, time, RANK() OVER (ORDER BY time DESC) AS pos FROM lotusbox_hours ) AS ranked_times WHERE user_id = @user_id; ')
vRP.prepare('lotus_box/getVehicle', 'SELECT * FROM vrp_user_veiculos WHERE user_id = @user_id and veiculo = @veiculo')

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PlayersTimed = {}
PlayersTimePlayed = {}
PlayersStep = {}

ActualRewardsItems = {}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('myHours', function(source,args)
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end

    print(PlayersTimePlayed[user_id] * 60)
    print(PlayersTimePlayed[user_id])
end)

function CreateTunnel.requestRanking()
    local query = vRP.query('lotus_box/getRanks', {})
    local t = {}
    for i = 1, #query do
        local identity = vRP.getUserIdentity(query[i].user_id)
        if not identity then goto next_player end

        t[#t + 1] = {
            name = ('%s %s #%s'):format(identity.nome, identity.sobrenome, query[i].user_id),
            time = query[i].time
        }

        :: next_player ::
    end

    return t
end

function CreateTunnel.requestMyRanking()
    local source = source

    local user_id = vRP.getUserId(source)
    if not user_id then 
        return 
    end

    local identity = vRP.getUserIdentity(user_id)
    if not identity then
        return
    end

    local payload = { pos = 999, name = ("%s %s #%s"):format(identity.nome, identity.sobrenome, user_id), time = 0 }

    local query = vRP.query('lotus_box/getMyRank' , { user_id = user_id })
    if #query > 0 then
        payload.time = query[1].time
        payload.pos = query[1].pos
    end

    return payload
end

function CreateTunnel.GetRewards()
    local source = source

    local user_id = vRP.getUserId(source)
    if not user_id then 
        return 
    end

    local ITEMS = {}
    for id, item in pairs(ActualRewardsItems) do
        if (item.type == 'item') then
            ITEMS[id] = Config.dir..item.spawn..'.png'
        elseif (item.type == 'car') then
            ITEMS[id] = Config.dirCars..item.spawn..'.png'
        else
            ITEMS[id] = Config.dirOthers..item.spawn..'.png'
        end
    end

    return ITEMS
end

function CreateTunnel.CanRescue()
    local source = source

    local user_id = vRP.getUserId(source)
    if not user_id then 
        return 
    end

    local actualStep = PlayersStep[user_id] 
    if not actualStep then
        actualStep = 0
    end
    actualStep = (actualStep + 1)

    local playerHours = PlayersTimePlayed[user_id]
    if not playerHours then
        PlayersTimePlayed[user_id] = 0
    end

    local canRescue = false
    if Config.AutoRandomizeRewards[actualStep] and playerHours and playerHours >= Config.AutoRandomizeRewards[actualStep].time then
        canRescue = true
    end

    return { actualReward = (actualStep - 1), canRescue = canRescue, playerTime = PlayersTimePlayed[user_id] * 60 }
end

function CreateTunnel.reward()
    local source = source

    local user_id = vRP.getUserId(source)
    if not user_id then 
        return 
    end

    local status, time = exports['vrp']:getCooldown(user_id, "box_cooldown")
    if not status then
        return
    end
    exports['vrp']:setCooldown(user_id, "box_cooldown", 2)

    local actualStep = PlayersStep[user_id] 
    if not actualStep then
        actualStep = 1
    end

    local playerHours = PlayersTimePlayed[user_id]
    if not playerHours then
        PlayersTimePlayed[user_id] = 0
    end

    if Config.AutoRandomizeRewards[actualStep] and playerHours >= Config.AutoRandomizeRewards[actualStep].time and ActualRewardsItems[actualStep] then
        local item = ActualRewardsItems[actualStep]

        if not PlayersStep[user_id] then
            PlayersStep[user_id] = 0
        end
        PlayersStep[user_id] = (PlayersStep[user_id] + 1)

        if item.type == 'item' then
            vRP.giveInventoryItem(user_id, item.spawn, item.amount, true)
        end

        if item.type == 'car' then
            vRP.execute("vRP/inserir_veh",{ veiculo = item.spawn, user_id = user_id, ipva = os.time(), expired = "{}" })
        end

        if item.type == 'makapoints' then
            vRP.giveMakapoints(user_id, item.amount)
        end

        return true
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    -- CASO ENSURAR SCRIPTS COM JOGADORES ONLINE
    local users = vRP.getUsers()
    for id, source in pairs(users) do
        if not PlayersTimed[id] then
            PlayersTimed[id] = os.time()
        end
    end

    -- Randomizar Lista de Itens
    for id in pairs(Config.AutoRandomizeRewards) do
        local items = Config.AutoRandomizeRewards[id].items

        if not ActualRewardsItems[id] then
            ActualRewardsItems[id] = Config.AutoRandomizeRewards[id].items[math.random(1,#items)]
        end
    end

    -- IDENTIFICAR ALGUM JOGADOR QUE BUGOU E NAO PASSOU PELO playerLeave
    while true do
        local users = vRP.getUsers()
        for id, source in pairs(users) do
            async(function()
                local ped = GetPlayerPed(source)
                local user_id = id
                if PlayersTimed[id] and (ped == 0) then
                    vRP.execute('lotus_box/updateUser', { user_id = user_id, time = (os.time() - PlayersTimed[user_id]) })
                    PlayersTimed[user_id] = nil
                end
    
                if ped > 0 then
                    if not PlayersTimePlayed[id] then
                        PlayersTimePlayed[id] = 0
                    end
    
                    PlayersTimePlayed[id] = (PlayersTimePlayed[id] + 1)
                end
            end)
        end

        Wait(60000)
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HANDLERS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('vRP:playerSpawn', function(user_id, source)
    if not PlayersTimePlayed[user_id] then
        PlayersTimePlayed[user_id] = 0
    end

    if PlayersTimed[user_id] then
        return
    end

    PlayersTimed[user_id] = os.time()
end)


AddEventHandler('vRP:playerLeave', function(user_id, source)
    if not PlayersTimed[user_id] then
        return
    end

    vRP.execute('lotus_box/updateUser', { user_id = user_id, time = (os.time() - PlayersTimed[user_id]) })

    PlayersTimed[user_id] = nil
end)