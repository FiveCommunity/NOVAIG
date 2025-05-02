
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.getPermissions(role)
    local source = source
    local user_id = getUserId(source)
    if not user_id then return end

    local user = Organizations.Members[user_id]
    if not user then return end
    local default = {
        promote = false,
        demote = false,
        dismiss = false,
        withdraw = false,
        deposit = false,
        message = false,
        alerts = false,
        invite = false,
        chat = false,
        leader = false
    }
    return Organizations.Permissions[user.groupType] and Organizations.Permissions[user.groupType][role] or default
end

function RegisterTunnel.updatePermissions(role_id, perms)
    local source = source
    local user_id = getUserId(source)
    if not user_id then return end

    local user = Organizations.Members[user_id]
    if not user then return end

    local hasPermission = Organizations.Permissions[user.groupType] and Organizations.Permissions[user.groupType][user.group].leader or false
    if not hasPermission then
        return
    end

    if Organizations.Permissions[user.groupType] and Organizations.Permissions[user.groupType][role_id] then
        Organizations.Permissions[user.groupType][role_id] = perms
    end

    vRP.execute('mirtin_orgs_v2/UpdatePermissions', { organization = user.groupType, permissions = json.encode(Organizations.Permissions[user.groupType]) })

    return true
end

function RegisterTunnel.updateConfig(data)
    local source = source
    local user_id = getUserId(source)
    if not user_id then return end

    local user = Organizations.Members[user_id]
    if not user then return end

    local hasPermission = Organizations.Permissions[user.groupType] and Organizations.Permissions[user.groupType][user.group].leader or false
    if not hasPermission then
        return
    end

    vRP.execute('mirtin_orgs_v2/updateFacInfo', { organization = user.groupType, discord = data.discord })

    return data.discord 
end

function RegisterTunnel.updateRadio(data)
    local source = source
    local user_id = getUserId(source)
    local orgName = nil
    if not user_id then return end
    
    local user = Organizations.Members[user_id]
    if not user then return end

    local hasPermission = Organizations.Permissions[user.groupType] and Organizations.Permissions[user.groupType][user.group].leader or false
    if not hasPermission then
        return false
    end
    vRP.execute('mirtin_orgs_v2/updateRadio', {organization = user.groupType, radio = data.frequency})
    return data.frequency
end

function RegisterTunnel.updatePreset(data)
    local source = source
    local user_id = getUserId(source)
    local orgName = nil
    if not user_id then return end
    
    local user = Organizations.Members[user_id]
    if not user then return end

    local hasPermission = Organizations.Permissions[user.groupType] and Organizations.Permissions[user.groupType][user.group].leader or false
    if not hasPermission then
        return false
    end
    vRP.execute('mirtin_orgs_v2/updatePresets', {organization = user.groupType, presets = json.encode(data)})
    return data
end