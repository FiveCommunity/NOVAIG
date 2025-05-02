---@param userId number
---@return number
local function getUserVehicleCount(userId)
    local result = exports.oxmysql:executeSync('SELECT COUNT(*) as total FROM vrp_user_veiculos WHERE user_id = ?', { userId })
    return result and result[1] and result[1].total or 0
end

---@param userId number
---@return number
local function getCriminalRecordCount(userId)
    local result = exports.oxmysql:executeSync('SELECT COUNT(*) as total FROM mdt_criminal_records WHERE user_id = ?', { userId })
    return result and result[1] and result[1].total or 0
end

---@param userId number
---@return table
local function getUserCriminalRecords(userId)
    local result = exports.oxmysql:executeSync('SELECT * FROM mdt_criminal_records WHERE user_id = ?', { userId })
    if not result or #result == 0 then return {} end

    local history = {}
    for _, record in ipairs(result) do 
        table.insert(history, {
            description = record.description,
            officer = getUserName(record.officer_id),
            date = tonumber(record.date),
        })
    end

    table.sort(history, function(a, b) return a.date > b.date end)

    return history
end

---@param userId number
---@return table | nil
local function getUserVehicles(userId)
    local query = exports.oxmysql:executeSync('SELECT * FROM vrp_user_veiculos WHERE user_id = ?', { userId })
    if query and #query > 0 then
        local vehicles = {}
        for _, vehicle in ipairs(query) do 
            table.insert(vehicles, vehicle.veiculo)
        end

        return vehicles
    end

    return nil
end

---@param userId number
---@return boolean
local function hasGunLicense(userId)
    return vRP.hasPermission(userId, 'perm.portearmas')
end

---@param userId number
---@return number
function getUserFines(userId)
    local fines = vRP.getMultas(userId)
    return fines and fines > 0 and fines or 0
end

---@param userId number
---@param vehicle string
---@return number
local function getVehicleApprehensionCount(userId, vehicle)
    local result = exports.oxmysql:executeSync('SELECT COUNT(*) as total FROM mdt_vehicle_apprehensions WHERE user_id = ? AND vehicle = ?', { userId, vehicle })
    return result and result[1] and result[1].total or 0
end

---@param userId number
---@param vehicle string
---@return table
local function getVehicleApprehensionHistory(userId, vehicle)
    local result = exports.oxmysql:executeSync('SELECT * FROM mdt_vehicle_apprehensions WHERE user_id = ? AND vehicle = ?', { userId, vehicle })
    if not result or #result == 0 then return {} end

    local history = {}
    for _, record in ipairs(result) do 
        table.insert(history, {
            description = record.description,
            officer = getUserName(record.officer_id),
            date = tonumber(record.date),
        })
    end

    table.sort(history, function(a, b) return a.date > b.date end)

    return history
end

---@param userId number
---@param vehicle string
---@param description string
---@param officerId number
---@return void
local function addVehicleApprehension(userId, vehicle, description, officerId)
    local time = os.time()
    exports.oxmysql:insert('INSERT INTO mdt_vehicle_apprehensions (user_id, vehicle, description, officer_id, date) VALUES (?, ?, ?, ?, ?)', { userId, vehicle, description, officerId, time })
end

---@param nuserId number
---@return boolean
function ServerAPI.searchPassport(nuserId)
    local source = source
    local userId = validateUserAndOrganization(source)
    if not userId then return false end

    local nuserIdentity = vRP.getUserIdentity(nuserId)
    return nuserIdentity and true or false
end

---@param plate string
---@return table | boolean
function ServerAPI.searchPlate(plate)
    local source = source
    local userId = validateUserAndOrganization(source)
    if not userId then return false end

    local nuserId = vRP.getUserByRegistration(plate)
    return nuserId and getUserVehicles(nuserId) or false
end

---@param nuserId number
---@return table | boolean
function ServerAPI.getUser(nuserId)
    local source = source
    local userId = validateUserAndOrganization(source)
    if not userId then return false end

    local nuserIdentity = vRP.getUserIdentity(nuserId)
    if not nuserIdentity then return false end

    return {
        name = getUserName(nuserId),
        passport = nuserId,
        citizenSince = 1720920864,
        vehicles = getUserVehicleCount(nuserId),
        criminalRecords = getCriminalRecordCount(nuserId),
        gunLicense = hasGunLicense(nuserId),
        passages = getUserCriminalRecords(nuserId),
    }
end

---@param plate string
---@param vehicle string
---@return table | boolean
function ServerAPI.getVehicle(plate, vehicle)
    local source = source
    local userId = validateUserAndOrganization(source)
    if not userId then return false end

    local nuserId = vRP.getUserByRegistration(plate)
    if not nuserId then return false end

    return {
        plate = plate,
        owner = getUserName(nuserId),
        fines = getUserFines(nuserId),
        apprehensions = getVehicleApprehensionCount(nuserId, vehicle),
        history = getVehicleApprehensionHistory(nuserId, vehicle),
    }
end

---@param plate string
---@param vehicle string
---@param amount number
---@param reason string
---@return boolean
function ServerAPI.fineVehicle(plate, vehicle, amount, reason)
    local source = source
    local userId = validateUserAndOrganization(source)
    if not userId then return false end

    local nuserId = vRP.getUserByRegistration(plate)
    if not nuserId then return false end

    local fines = getUserFines(nuserId)
    vRP.updateMultas(nuserId, fines + amount)
    addVehicleApprehension(nuserId, vehicle, 'Veículo multado em R$' .. amount .. ' por ' .. reason, userId)
    TriggerClientEvent('Notify', source, 'sucesso', 'Veículo '..vehicle..' multado em R$' .. amount .. ' por ' .. reason)
    vRP.sendLog(Config.Webhooks.fine, '```prolog\n[VEÍCULO MULTADO]\n[PLACA]: '..plate..'\n[VEÍCULO]: '..vehicle..'\n[VALOR]: R$'..amount..'\n[MOTIVO]: '..reason..'\n[OFICIAL]: '..userId..'\n```')
    return true
end

---@param plate string
---@param vehicle string
---@param reason string
---@return boolean
function ServerAPI.arrestVehicle(plate, vehicle, reason)
    local source = source
    local userId = validateUserAndOrganization(source)
    if not userId then return false end

    local nuserId = vRP.getUserByRegistration(plate)
    if not nuserId then return false end

    local query = exports.oxmysql:executeSync('SELECT status FROM vrp_user_veiculos WHERE user_id = ? AND veiculo = ?', { nuserId, vehicle })
    if not query or #query <= 0 then
        return false
    end

    local status = tonumber(query[1].status)
    if not status or status > 0 then
        TriggerClientEvent('Notify', source, 'sucesso', 'Veículo já está apreendido!')
        return false
    end

    vRP.execute('vRP/set_status', { user_id = nuserId, veiculo = vehicle, status = 1 })
    addVehicleApprehension(nuserId, vehicle, 'Veículo apreendido por ' .. reason, userId)
    TriggerClientEvent('Notify', source, 'sucesso', 'Veículo apreendido com sucesso!')
    vRP.sendLog(Config.Webhooks.arrestVehicles, '```prolog\n[VEÍCULO APREENDIDO]\n[PLACA]: '..plate..'\n[VEÍCULO]: '..vehicle..'\n[MOTIVO]: '..reason..'\n[OFICIAL]: '..userId..'\n```')
    return true
end

---@param userId number
---@return void
function clearUserCriminalHistory(userId)
    exports.oxmysql:execute('DELETE FROM mdt_criminal_records WHERE user_id = ?', { userId })
end

exports('clearUserCriminalHistory', clearUserCriminalHistory)