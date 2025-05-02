local incidentsReportsCache = {}

---@return table
function ServerAPI.getIncidentsReports()
    local incidentsReports = {}
    for _, record in ipairs(incidentsReportsCache) do
        table.insert(incidentsReports, {
            id = record.id,
            involved = '#'..record.involved..' | '..getUserName(record.involved),
            officer = '#'..record.officer..' | '..getUserName(record.officer),
            date = tonumber(record.date),
            description = record.description,
        })
    end

    return incidentsReports
end

---@param source number
---@param involved string
---@param description string
---@return number | boolean
function ServerAPI.createIncidentReport(involved, description)
    local source = source
    local userId = validateUserAndOrganization(source)
    if not userId then return false end
    
    local actualTimer = os.time()
    
    local result = exports.oxmysql:executeSync('INSERT INTO mdt_incidents_reports (involved, officer_id, date, description) VALUES (?, ?, ?, ?) RETURNING id', { involved, userId, actualTimer, description })
    if result and result[1] then
        local id = result[1].id
        table.insert(incidentsReportsCache, {
            id = id,
            involved = involved,
            officer = userId,
            date = actualTimer,
            description = description,
        })

        TriggerClientEvent('Notify', source, 'sucesso', 'Boletim registrado com sucesso!')
        return true
    end
    return false
end

---@param id number
---@return boolean
function ServerAPI.deleteIncidentReport(id)
    local source = source
    local result = exports.oxmysql:executeSync('DELETE FROM mdt_incidents_reports WHERE id = ?', { id })
    if result then
        for i, record in ipairs(incidentsReportsCache) do
            if record.id == id then
                table.remove(incidentsReportsCache, i)
                break
            end
        end

        TriggerClientEvent('Notify', source, 'negado', 'Boletim deletado com sucesso!')
        return true
    end
    return false
end

CreateThread(function()
    Wait(2000)
    local query = exports.oxmysql:executeSync('SELECT * FROM mdt_incidents_reports')
    if query and #query > 0 then
        for _, record in ipairs(query) do 
            table.insert(incidentsReportsCache, {
                id = record.id,
                involved = record.involved,
                officer = record.officer_id,
                date = tonumber(record.date),
                description = record.description,
            })
        end
    end
end)

exports('clearUserCriminalHistory', clearUserCriminalHistory)