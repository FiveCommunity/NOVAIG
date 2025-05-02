local historyCache = {}

---@param userId number
---@param organization string
---@param message string
local function insertLogIntoDatabase(userId, organization, message, date)
    exports.oxmysql:execute(
        'INSERT INTO mdt_logs(user_id, organization, description, date) VALUES (?, ?, ?, ?)', 
        { userId, organization, message, date }
    )
end

---@param userId number
---@param organization string
---@param message string
---@param date number
local function cacheLog(userId, organization, message, date)
    if not historyCache[organization] then
        historyCache[organization] = {}
    end

    table.insert(historyCache[organization], {
        userId = userId,
        message = message,
        date = date
    })
end

---@param userId number
---@param organization string
---@param message string
function addLog(userId, organization, message)
    local date = os.time()
    cacheLog(userId, organization, message, date)
    insertLogIntoDatabase(userId, organization, message, date)
end

---@param record table
---@return table
local function mapHistoryRecord(record)
    return {
        id = record.userId,
        name = getUserName(record.userId),
        action = record.message,
        date = tonumber(record.date)
    }
end

---@param organization string
---@return table
local function orderHistoryByDate(organization)
    if not historyCache[organization] then return {} end

    local history = {}
    for _, record in ipairs(historyCache[organization]) do
        table.insert(history, mapHistoryRecord(record))
    end

    table.sort(history, function(a, b)
        return a.date > b.date
    end)

    for index = 1, #history do
        history[index].id = index
    end

    return history
end

---@return table | boolean
function ServerAPI.getHistory()
    local userId = validateUserAndOrganization(source)
    if not userId then return false end

    local organization = getUserOrganization(userId)
    if not organization then return false end

    local history = orderHistoryByDate(organization)

    local jsonHistory = {}
    for _, record in ipairs(history) do
        table.insert(jsonHistory, {
            id = record.id,
            name = record.name,
            action = record.action,
            date = tonumber(record.date)
        })
    end

    return jsonHistory
end

---@return void
local function loadLogsFromDatabase()
    local query = exports.oxmysql:executeSync('SELECT * FROM mdt_logs')
    if not query or #query == 0 then return end

    for _, record in ipairs(query) do
        cacheLog(record.user_id, record.organization, record.description, record.date)
    end
end

CreateThread(function()
    Wait(2000)
    loadLogsFromDatabase()
end)