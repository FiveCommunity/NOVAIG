-- PREPARES
vRP.prepare("mirtin_orgs_v2/getChestLogs", "SELECT * FROM mirtin_orgs_logs WHERE organization = @organization ORDER BY expire_at DESC LIMIT 150")
vRP.prepare("mirtin_orgs_v2/addChestLog", "INSERT INTO mirtin_orgs_logs (organization, user_id, role, name, description, date, expire_at) VALUES(@organization, @id, @role, @name, @message, @time, @expire_at)")

-- CACHE LOGS
local chestLogCache = {}
local chestLogCacheAdd = {}

-- TUNNELS
function RegisterTunnel.getLogs()
    local source = source
    local user_id = getUserId(source)
    local t = {}

    if not user_id then return end

    local user = Organizations.Members[user_id]
    if not user then return end

    if chestLogCache[user.groupType] then
        t = chestLogCache[user.groupType]
        return t
    end

    local query = vRP.query('mirtin_orgs_v2/getChestLogs', { organization = user.groupType })
    for i = 1, #query do
        t[#t + 1] = {
            name = query[i].name,
            id = query[i].user_id,
            role = query[i].role,
            message = query[i].description,
            time = query[i].date,
            expire_at = query[i].expire_at
        }
    end

    chestLogCache[user.groupType] = t
    return t
end


-- EXPORTS
exports('addLogChest', function(user_id, action, item, amount)
    user_id = parseInt(user_id)

    if not user_id or not action or not item or not amount then
        print("[ERRO] Parâmetros inválidos em addLogChest:", user_id or "nil", action or "nil", item or "nil", amount or "nil")
        return
    end

    local user = Organizations.Members[user_id]
    if not user then return end

    local identity = getUserIdentity(user_id)
    if not identity then return end

    local role = "Sem cargo"
    if Config.Groups[user.groupType] and Config.Groups[user.groupType].List[user.group] then
        role = Config.Groups[user.groupType].List[user.group].prefix
    end

    local logEntry = {
        id = user_id,
        name = ('%s %s'):format(identity.nome or 'Desconhecido', identity.sorenome or ''),
        role = role,
        message = ('%s %dx %s'):format(action == 'withdraw' and 'Retirou' or 'Guardou', tonumber(amount) or 0, item or 'Desconhecido'),
        time = os.date('%d/%m/%Y %X'),
        expire_at = os.time() + (Config.Main.clearChestLogs * 86400)
    }

    if not chestLogCache[user.groupType] then
        chestLogCache[user.groupType] = {}
    end

    if not chestLogCacheAdd[user.groupType] then
        chestLogCacheAdd[user.groupType] = {}
    end

    table.insert(chestLogCache[user.groupType], logEntry)
    table.insert(chestLogCacheAdd[user.groupType], logEntry)
end)

-- SYNC DATABASE
local function syncChestLogsWithDatabase()
    for groupType, logs in pairs(chestLogCacheAdd) do
        if #logs > 0 then
            print(json.encode(logs))
            for _, log in ipairs(logs) do
                log.organization = groupType
                log.message = log.message or "Sem mensagem"
                log.time = log.time or os.date('%d/%m/%Y %X')

                vRP.execute('mirtin_orgs_v2/addChestLog', log)
            end
        end
        chestLogCacheAdd[groupType] = {}
    end
end


-- SYNC DATABASE
local function syncChestLogsWithDatabase()
    for groupType, logs in pairs(chestLogCacheAdd) do
        print(json.encode(logs))
        for _, log in ipairs(logs) do
            log.organization = groupType
            vRP.execute('mirtin_orgs_v2/addChestLog', log)
        end
        chestLogCacheAdd[groupType] = {}
    end
end

-- SAVE CACHE ON STOP
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print(('^2[%s] ^0Salvando logs no banco de dados!'):format(GetCurrentResourceName():upper()))
        syncChestLogsWithDatabase()
    end
end)
