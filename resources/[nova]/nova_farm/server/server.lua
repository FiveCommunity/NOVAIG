local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

ServerAPI = {}
Tunnel.bindInterface(GetCurrentResourceName(), ServerAPI)
ClientAPI = Tunnel.getInterface(GetCurrentResourceName())

local orgsMultiplier <const> = {}
local usersRoutes <const> = {}
local usersRoutesCooldown <const> = {}
local usersAttemptTracker <const> = {}

local ATTEMPT_LIMIT <const> = 3
local ATTEMPT_WINDOW <const> = 5

--- @param userId integer
--- @param permissions table
--- @return boolean
local function hasPermission(userId, permissions)
    for _, permission in ipairs(permissions) do
        if vRP.hasPermission(userId, permission) then
            return true
        end
    end
    return false
end

--- @param userId integer
--- @return number
local function calculateDominationMultiplier(userId)
    local multiplier = 1.0
    local _, orgName = exports['dm_module']:GetGroupType(userId)
    local domination = exports['dm_module']:GetUserDomination(userId)
    
    local hasDomination = domination and domination.zones and #domination.zones > 0
    local hasGlobalDomination = orgName and GlobalState.dominationOwner == orgName
    local hasPistolDomination = exports['nova_dominacao_pistol']:isBoostDominationPistol(orgName)


    if hasGlobalDomination then
        multiplier = 3.0
    elseif hasDomination or hasPistolDomination then
        multiplier = 2.0
    end

    return multiplier
end

--- @param userId integer
--- @return number
local function getUserMultiplier(userId)
    local multiplier = calculateDominationMultiplier(userId)
    local userOrg = vRP.getUserGroupOrg(userId)
    
    if userOrg and userOrg ~= '' and orgsMultiplier[userOrg] then
        if os.time() <= orgsMultiplier[userOrg].endTime then
            multiplier = (multiplier == 1.0) and 2.0 or (multiplier + Config.coinMultiplier)
        end
    end

    if multiplier > 4.0 then
        multiplier = 4.0
    end

    return multiplier
end

--- @param userId integer
--- @param routeType string
--- @return table
local function organizeRoutesToClient(userId, routeType)
    local routes = {}
    for _, route in ipairs(Config.Rewards[routeType]) do
        table.insert(routes, {
            name = route.name,
            icon = Config.imageURL .. '/' .. route.image .. '.png',
            coins = Config.coinAmount,
            multiplier = getUserMultiplier(userId),
        })
    end
    return routes
end

--- @param index integer
--- @return void
function ServerAPI.openRoutes(index)
    local source = source
    local userId = vRP.getUserId(source)

    if not Config.Routes[index] or not hasPermission(userId, Config.Routes[index].permissions) or not Config.Rewards[Config.Routes[index].rewardType] then
        return
    end

    ClientAPI.openRoutes(source, organizeRoutesToClient(userId, Config.Routes[index].rewardType))
    usersRoutes[userId] = { routeIndex = index, initialized = false }
end

--- @return boolean
function ServerAPI.boostRoute()
    local source = source
    local userId = vRP.getUserId(source)

    if not userId then return false end

    local userOrg = vRP.getUserGroupOrg(userId)
    if not userOrg or userOrg == '' or not vRP.tryGetInventoryItem(userId, 'coin', 1) then
        TriggerClientEvent('Notify', source, 'negado', 'Você não possui moedas suficientes.')
        return false
    end

    if orgsMultiplier[userOrg] then
        if os.time() <= orgsMultiplier[userOrg].endTime then
            orgsMultiplier[userOrg].endTime = orgsMultiplier[userOrg].endTime + Config.coinTime
        else
            orgsMultiplier[userOrg] = { endTime = os.time() + Config.coinTime }
        end
    else
        orgsMultiplier[userOrg] = { endTime = os.time() + Config.coinTime }
    end

    TriggerClientEvent('Notify', source, 'sucesso', 'Você aumentou o tempo de coleta dobrada da sua facção em ' .. Config.coinTime .. ' segundos.')

    return true
end

--- @param routeName string
--- @param region string
--- @return boolean
function ServerAPI.startRoute(routeName, region)
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then return false end

    if usersRoutes[userId] and usersRoutes[userId].initialized then
        TriggerClientEvent('Notify', source, 'negado', 'Você já está em uma rota ativa.')
        return false
    end

    local routeIndex = usersRoutes[userId].routeIndex
    local rewardType = Config.Routes[routeIndex].rewardType
    local rewards = Config.Rewards[rewardType]

    local existsRoute = false
    if not rewards then return end
    for _, reward in ipairs(rewards) do
        if reward.name == routeName then
            existsRoute = true
            break
        end
    end

    if not existsRoute then return end

    local routeType = Config.Routes[routeIndex].routeType
    if not Config.RouteBlips[routeType] then return end

    local region = (region == 'north') and 'North' or 'South'
    local blips = Config.RouteBlips[routeType][region]
    if not blips then return end

    ClientAPI.startRoute(source, routeType, region)
    usersRoutes[userId] = { routeIndex = routeIndex, initialized = true, actualIndex = 1, routeRegion = region, routeName = routeName }
    TriggerClientEvent('Notify', source, 'sucesso', 'Você iniciou a rota. Para cancelar aperta F7')
end

local function handleRapidAttempts(userId)
    local currentTime = os.time()

    if not usersAttemptTracker[userId] then
        usersAttemptTracker[userId] = { count = 0, startTime = currentTime }
    end

    local attemptData = usersAttemptTracker[userId]

    if (currentTime - attemptData.startTime) <= ATTEMPT_WINDOW then
        attemptData.count = attemptData.count + 1
        if attemptData.count >= ATTEMPT_LIMIT then
            print('USUÁRIO TENTATIVAS RÁPIDAS => ' .. userId)
            -- DropPlayer(vRP.getSource(userId), 'Você foi banido por tentativas rápidas de coleta de rota.')
            -- vRP.setBanned(userId, true)
            usersAttemptTracker[userId] = nil
            return true
        end
    else
        usersAttemptTracker[userId] = { count = 1, startTime = currentTime }
    end

    return false
end

--- @param route string
--- @param region string
--- @param index integer
--- @return boolean
function ServerAPI.collectRoute(route, region, index)
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then return false end

    if handleRapidAttempts(userId) then return false end

    local routeIndex = usersRoutes[userId].routeIndex
    local routeType = Config.Routes[routeIndex].routeType
    local rewardType = Config.Routes[routeIndex].rewardType
    local routeRegion = usersRoutes[userId].routeRegion
    local routeName = usersRoutes[userId].routeName
    
    if index ~= usersRoutes[userId].actualIndex then 
        print('SUSPEITO HACK ROTAS => ' .. userId .. ' | INDEX ESPERADO: ' .. usersRoutes[userId].actualIndex .. ' | INDEX RECEBIDO: ' .. index)
        return false 
    end

    if not Config.RouteBlips[routeType][routeRegion][index] then 
        print('SUSPEITO HACK ROTAS => ' .. userId)
        return false 
    end

    local currentTime = os.time()
    if usersRoutesCooldown[userId] and usersRoutesCooldown[userId].time and (currentTime - usersRoutesCooldown[userId].time < Config.routeCooldownTime) then
        -- print('COOLDOWN ROTAS => ' .. userId)
        TriggerClientEvent('Notify', source, 'negado', 'Espere '..(Config.routeCooldownTime - (currentTime - usersRoutesCooldown[userId].time))..' segundos para coletar.')
        return false
    end

    local coords = GetEntityCoords(GetPlayerPed(source))
    local blipCoords = Config.RouteBlips[routeType][routeRegion][index].coords
    local distance = #(coords - blipCoords)
    if distance >= 10.0 then 
        print('SUSPEITO HACK ROTAS => ' .. userId)
        return false 
    end

    usersRoutesCooldown[userId] = { time = currentTime }

    local rewards = Config.Rewards[rewardType]
    if not rewards then return false end

    for _, reward in ipairs(rewards) do
        if reward.name == routeName then
            for _, item in ipairs(reward.items) do
                local amount = math.random(item.min, item.max) * (getUserMultiplier(userId) + (routeRegion == 'North' and 1.0 or 0.0))
                if vRP.computeInvWeight(userId) + vRP.getItemWeight(item.item) * amount <= vRP.getInventoryMaxWeight(userId) then
                    vRP.giveInventoryItem(userId, item.item, amount, true)
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Mochila cheia.')
                    break
                end
            end
            break
        end
    end

    usersRoutes[userId].actualIndex = (usersRoutes[userId].actualIndex + 1 <= #Config.RouteBlips[routeType][routeRegion]) and usersRoutes[userId].actualIndex + 1 or 1
    return true
end

--- @param userId integer
--- @return void
local function finishRoute(userId)
    if not userId or not usersRoutes[userId] then return end

    usersRoutes[userId] = nil
    usersAttemptTracker[userId] = nil
    usersRoutesCooldown[userId] = nil
end

--- @return void
function ServerAPI.finishRoute()
    local source = source
    local userId = vRP.getUserId(source)
    
    finishRoute(userId)
    TriggerClientEvent('Notify', source, 'sucesso', 'Você finalizou a rota.')
end

AddEventHandler('vRP:playerLeave',function(userId, source)
    if not userId then return end

    finishRoute(userId)
end)