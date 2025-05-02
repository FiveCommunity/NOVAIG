local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

Server = {}
Tunnel.bindInterface(GetCurrentResourceName(), Server)
Client = Tunnel.getInterface(GetCurrentResourceName())

Ranking = {}
CallsCache = {}
UsersCalls = {}
UsersInServiceCategory = {}
CallsIDCounter = {}
ServiceName = {}

ConfigHub = (json.decode(LoadResourceFile(GetCurrentResourceName(), "./hub.config.json")) or {})
StaffsHub = (json.decode(LoadResourceFile(GetCurrentResourceName(), "./users.config.json")) or {})

LastIdInServer = 0

CreateThread(function()
    Wait(1000)
    local ranking = vRP.query("lotus_hub/getRanking")
    if ranking and next(ranking) then
        for _, rankUser in pairs(ranking) do
            if rankUser and next(rankUser) then

                if not Ranking[rankUser.service] then Ranking[rankUser.service] = {} end

                Ranking[rankUser.service][rankUser.user_id] = {
                    name = rankUser.name or "Não identificado",
                    calls = rankUser.calls or 0,
                    hours = rankUser.hours or 0,
                    stars = rankUser.stars or 0,
                    totalstars = rankUser.totalstars or 0,
                    service = rankUser.service,
                    notification = true,
                }
            end
        end
    end
end)

RegisterCommand("resetrankchamados", function (source, args)
    local user_id = vRP.getUserId(source)

    if not user_id then return end

    local perms = {
        { permType = 'perm', perm = 'developer.permissao' },
    }

    local hasPerm = false
    for _, perm in pairs(perms) do
        if perm.permType == 'perm' then
            hasPerm = vRP.hasPermission(user_id, perm.perm)
        elseif perm.permType == 'group' then
            hasPerm = vRP.hasGroup(user_id, perm.perm)
        end

        if hasPerm then
            break
        end
    end

    if not hasPerm then return end


    local serviceRequired = args[1]

    if not serviceRequired or serviceRequired == ' ' then
        return TriggerClientEvent('Notify', source,  'negado', 'Precisa coloca o serviço que deseja resetar.')
    end

    if not ServicesList[serviceRequired] then
        local servicesList = ''

        for serviceName, _ in pairs(ServicesList) do
            servicesList = servicesList .. ' ' .. serviceName .. ','
        end

        TriggerClientEvent('Notify', source, 'negado', 'Existe somente essas categorias de serviço: '..servicesList, 15000)
        return
    end

    vRP.execute("lotus_hub/deleteRanking", { service = serviceRequired })

    Ranking[serviceRequired] = {}

    TriggerClientEvent('Notify', source, 'sucesso', 'Ranking do serviço ' .. serviceRequired .. ' resetado com sucesso!', 5000)
end)

CreateThread(function()
    vRP.execute("lotus_hub/createTable")
end)

function ceil(n)
    n = math.ceil(n * 100) / 100
    return n
end