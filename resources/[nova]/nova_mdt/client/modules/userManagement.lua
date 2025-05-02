RegisterNuiCallback('contractMember', function(data, cb)
    local nuserId = tonumber(data.passport)
    local role = data.role
    
    cb(ServerAPI.contractMember(nuserId, role))
end)

RegisterNUICallback('demote', function(data, cb)
    local nuserId = tonumber(data.id)
    local data = ServerAPI.demoteMember(nuserId)
    if data then
        closeNui()
    end
    cb(data)
end)

RegisterNUICallback('promote', function(data, cb)
    local nuserId = tonumber(data.id)
    local data = ServerAPI.promoteMember(nuserId)
    if data then
        closeNui()
    end
    cb(data)
end)

RegisterNUICallback('dismiss', function(data, cb)
    local nuserId = tonumber(data.id)
    local data = ServerAPI.dismissMember(nuserId)
    if data then
        closeNui()
    end
    cb(data)
end)