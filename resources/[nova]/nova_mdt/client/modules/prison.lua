RegisterNUICallback('getUserForArrest', function(data, cb)
    local nuserId = tonumber(data.id)
    if not nuserId then
        return cb(false)
    end

    cb(ServerAPI.getUserForArrest(nuserId))
end)

RegisterNUICallback('arrest', function(data, cb)
    local nuserId = tonumber(data.userArrest.id)
    local mounths = tonumber(data.userArrest.mounths)
    local bail = data.userArrest.bail
    local totalFine = tonumber(data.userArrest.totalFine)
    local totalBail = tonumber(data.userArrest.totalBail)
    local crimes = data.userArrest.crimes
    local mitigatingFactors = data.userArrest.mitigatingFactors
    if not nuserId or not mounths or not totalFine or not totalBail or not crimes or not mitigatingFactors then
        return cb(false)
    end

    local data = ServerAPI.arrestUser(nuserId, mounths, bail, totalFine, totalBail, crimes, mitigatingFactors)
    if data then
        closeNui()
    end

    cb(data)
end)