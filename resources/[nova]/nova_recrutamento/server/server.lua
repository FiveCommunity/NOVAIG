local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

local cfg = module('cfg/groups')

ServerAPI = {}
Tunnel.bindInterface(GetCurrentResourceName(), ServerAPI)
ClientAPI = Tunnel.getInterface(GetCurrentResourceName())

local usersWithProfession = {}
local requestOrganizations = {}
local totalRequestsByOrganization = {}

local function sendLog(message)
    local webhook = ''
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ content = message }), { ['Content-Type'] = 'application/json' })
end

CreateThread(function()
    local query = exports.oxmysql:executeSync('SELECT * FROM vrp_user_data WHERE dkey = "organization" AND dvalue = 1')
    if #query > 0 then 
        for _, v in pairs(query) do 
            usersWithProfession[v.user_id] = true 
        end
        Wait(50)
    end
end)

RegisterCommand(config.mainCommand, function(source, args)
    local userId = vRP.getUserId(source)
    
    if not userId then 
        return 
    end
    
    if usersWithProfession[userId] then 
        return 
    end
    
    local userOrganization = vRP.getUserGroupOrg(userId)
    
    if userOrganization then 
        return 
    end
    
    ClientAPI.openNui(source)
end)

local cooldownNotify =  {}

local function isUserInCooldown(source)
    if not cooldownNotify[source] then 
        return false
    end

    return cooldownNotify[source] > os.time()
end

local function sendNotify(org)
    local notified = {}
    for k, v in pairs(cfg.groups) do 
        if v._config and v._config.orgName and v._config.orgType and v._config.orgType == org and not notified[v._config.orgName] then 
            notified[v._config.orgName] = true
            local perm = 'perm.'..(v._config.orgType):lower()
            local users = vRP.getUsersByPermission(perm)
            for _, userId in pairs(users) do 
                local nSource = vRP.getUserSource(userId)
                if nSource and not isUserInCooldown(nSource) then 
                    TriggerClientEvent('Notify', nSource, 'importante', 'Sua organização recebeu uma nova pessoa interessada em se juntar a vocês, digite /rec para ver os detalhes')
                    cooldownNotify[nSource] = os.time() + 10
                end
            end
        end
    end
end

function ServerAPI.selectOrganization(orgType)
    local source = source 
    local userId = vRP.getUserId(source)

    if not userId then 
        return 
    end

    if usersWithProfession[userId] then 
        return 
    end

    local org = config.organizations[orgType]

    if not org then 
        return 
    end

    if not requestOrganizations[org] then 
        requestOrganizations[org] = {}
    end

    local identity = vRP.getUserIdentity(userId)

    local userName = identity.nome..' '..identity.sobrenome
    local userPhone = identity.telefone
    requestOrganizations[org][#requestOrganizations[org] + 1] = { passport = userId, name = userName, phone = userPhone, time = math.random(1, 2) * 60 }
    usersWithProfession[userId] = true 
    vRP.setUData(userId, 'organization', 1)
    totalRequestsByOrganization[org] = (totalRequestsByOrganization[org] or 0) + 1
    sendLog('Organização '..org..' recebeu '..totalRequestsByOrganization[org]..' pedidos de recrutamento')
    sendNotify(org)
end

RegisterCommand(config.dashboardCommand, function(source, args)
    local userId = vRP.getUserId(source)

    if not userId then 
        return 
    end

    local userGroup = vRP.getUserGroupByType(userId, 'org')

    if not userGroup or userGroup == '' then 
        return 
    end

    if not vRP.hasPermission(userId, config.dashboardPermission) then 
        return 
    end

    ClientAPI.openDashboard(source)
end)

function ServerAPI.getRequests()
    local userId = vRP.getUserId(source)

    if not userId then 
        return {}
    end

    local userGroup = vRP.getUserGroupByType(userId, 'org')

    if not userGroup or userGroup == '' then 
        return {}
    end

    if not vRP.hasPermission(userId, config.dashboardPermission) then 
        return {}
    end

    local org = config.organizations[userGroup]
    local orgType = cfg.groups[userGroup]._config.orgType

    local requests = requestOrganizations[orgType] or {}
    return requests
end

function ServerAPI.gps(nuserId)
    local source = source 
    local userId = vRP.getUserId(source)

    if not userId then 
        return 
    end

    local userGroup = vRP.getUserGroupByType(userId, 'org')
    
    if not userGroup or userGroup == '' then 
        return 
    end

    if not vRP.hasPermission(userId, config.dashboardPermission) then
        return
    end

    local nSource = vRP.getUserSource(nuserId)
    
    if not nSource then 
        return 
    end
    
    local identity = vRP.getUserIdentity(userId)
    local phone = identity.telefone
    
    local coords = GetEntityCoords(GetPlayerPed(source))
    local userCoords = { coords.x, coords.y, coords.z }
    TriggerClientEvent('smartphone:createSMS', nSource, phone, 'Olá, vi o seu interesse em trabalhar conosco. Aqui está a localização de minha organização para você poder ser recrutado', userCoords)
end

function ServerAPI.call(nuserId, phone)
    local source = source 
    local userId = vRP.getUserId(source)

    if not userId then 
        return 
    end

    local userGroup = vRP.getUserGroupByType(userId, 'org')

    if not userGroup or userGroup == '' then 
        return 
    end

    if not vRP.hasPermission(userId, config.dashboardPermission) then
        return
    end

    local nSource = vRP.getUserSource(nuserId)

    if not nSource then 
        return 
    end

    ClientAPI._callUser(source, phone)
end

function ServerAPI.message(nuserId, phone, message)
    local source = source 
    local userId = vRP.getUserId(source)

    if not userId then 
        return 
    end

    local userGroup = vRP.getUserGroupByType(userId, 'org')

    if not userGroup or userGroup == '' then 
        return 
    end

    if not vRP.hasPermission(userId, config.dashboardPermission) then
        return
    end

    local nSource = vRP.getUserSource(nuserId)

    if not nSource then 
        return 
    end

    local identity = vRP.getUserIdentity(userId)
    local phone = identity.telefone

    TriggerClientEvent('smartphone:createSMS', nSource, phone, message)
end

RegisterCommand('fechar', function(source, args)
    local source = source 
    local userId = vRP.getUserId(source)

    if not userId then 
        return 
    end

    if usersWithProfession[userId] then 
        return 
    end

    ClientAPI._openNotify(source, false)
    usersWithProfession[userId] = true
    vRP.setUData(userId, 'organization', 1)
end)

function ServerAPI.tramp()
    local source = source 
    local userId = vRP.getUserId(source)

    if not userId then 
        return 
    end

    if usersWithProfession[userId] then 
        return 
    end

    ClientAPI._openNotify(source, false)
    usersWithProfession[userId] = true
    vRP.setUData(userId, 'organization', 1)
end

function ServerAPI.delete(nuserId)
    local source = source 
    local userId = vRP.getUserId(source)

    if not userId then 
        return 
    end

    local userGroup = vRP.getUserGroupByType(userId, 'org')

    if not userGroup or userGroup == '' then 
        return 
    end

    if not vRP.hasPermission(userId, config.dashboardPermission) then
        return
    end

    local org = config.organizations[userGroup]
    local orgType = cfg.groups[userGroup]._config.orgType

    local requests = requestOrganizations[orgType]
    if not requests then 
        return 
    end

    for index, data in pairs(requests) do 
        if data.passport == nuserId then 
            table.remove(requests, index)
            break
        end
    end
end

CreateThread(function()
    while true do 
        Wait(1000)
        for org, requests in pairs(requestOrganizations) do 
            for index = #requests, 1, -1 do 
                local data = requests[index]
                data.time = data.time - 1
                if data.time <= 0 then 
                    table.remove(requestOrganizations[org], index)
                end
            end
        end
    end
end)

AddEventHandler('vRP:playerSpawn', function(userId, source, first_spawn)
    if usersWithProfession[userId] then 
        return 
    end

    local userGroup = vRP.getUserGroupByType(userId, 'org')
    if userGroup and userGroup ~= '' then 
        return 
    end

    ClientAPI._openNotify(source, true)
end)