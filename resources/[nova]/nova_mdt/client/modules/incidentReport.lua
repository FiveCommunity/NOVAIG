RegisterNUICallback('getReports', function(data, cb)
    cb(ServerAPI.getIncidentsReports())
end)

RegisterNUICallback('createReport', function(data, cb)
    local involved = data.involved
    local description = data.description
    if not involved or not description then
        return cb(false)
    end

    cb(ServerAPI.createIncidentReport(involved, description))
end)

RegisterNUICallback('DELETE_INSIDENT', function(data, cb)
    local insidentId = tonumber(data)
    if not insidentId then
        return cb(false)
    end

    cb(ServerAPI.deleteIncidentReport(insidentId))
end)