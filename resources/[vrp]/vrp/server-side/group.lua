--- OLD groups
local cfg = module("cfg/groups")
local groups = cfg.groups
local users = cfg.users
local selectors = cfg.selectors

function vRP.getGroupTitle(group)
    local g = groups[group]
    if g and g._config and g._config.title then
        return g._config.title
    end
    return group
end

function vRP.getUserGroups(user_id)
    local data = vRP.getUserDataTable(user_id)
    if data then
        if data.groups == nil then
            data.groups = {}
        end
        return data.groups
    else
        return {}
    end
end

local INDEX = setmetatable({}, {
    __index = function(self, user_id)
        if not user_id then
            return {}
        end

        local set = {}

        for group in pairs(vRP.getUserGroups(user_id)) do
            local config = groups[group] or {}

            for _, perm in ipairs(config) do
                set[perm] = true
            end
        end

        self[user_id] = set
        return set
    end,
})

AddEventHandler('vRP:playerLeave', function(user_id)
    INDEX[user_id] = nil
end)

function vRP.addUserGroup(user_id,group)
    if not vRP.hasGroup(user_id,group) then
        local user_groups = vRP.getUserGroups(user_id)
        local ngroup = groups[group]
        if ngroup then
            if ngroup._config and ngroup._config.gtype ~= nil then
                local _user_groups = {}
                for k,v in pairs(user_groups) do
                    _user_groups[k] = v
                end

                for k,v in pairs(_user_groups) do
                    local kgroup = groups[k]
                    if kgroup and kgroup._config and ngroup._config and kgroup._config.gtype == ngroup._config.gtype then
                        vRP.removeUserGroup(user_id,k)
                    end
                end
            end

            user_groups[group] = true
            INDEX[user_id] = nil
            local player = vRP.getUserSource(user_id)
            if ngroup._config and ngroup._config.onjoin and player ~= nil then
                ngroup._config.onjoin(player)
            end

            local gtype = nil
            if ngroup._config then
                gtype = ngroup._config.gtype
            end
            TriggerEvent("vRP:playerJoinGroup",user_id,group,gtype)
        end
    end
end

function vRP.getUsersByPermission(perm)
    local users = {}
    for k,v in pairs(vRP.rusers) do
        if vRP.hasPermission(tonumber(k),perm) then
            table.insert(users,tonumber(k))
        end
    end
    return users
end

function vRP.removeUserGroup(user_id,group)
    local user_groups = vRP.getUserGroups(user_id)
    local groupdef = groups[group]
    if groupdef and groupdef._config and groupdef._config.onleave then
        local source = vRP.getUserSource(user_id)
        if source then
            groupdef._config.onleave(source)
        end
    end

    local gtype = nil
    if groupdef._config then
        gtype = groupdef._config.gtype
    end

    TriggerEvent("vRP:playerLeaveGroup",user_id,group,gtype)
    user_groups[group] = nil
    INDEX[user_id] = nil
end

function vRP.hasGroup(user_id,group)
    local user_groups = vRP.getUserGroups(user_id)
    return (user_groups[group] ~= nil)
end

local func_perms = {}

function vRP.registerPermissionFunction(name,callback)
    func_perms[name] = callback
end

vRP.registerPermissionFunction("not",function(user_id,parts)
    return not vRP.hasPermission(user_id,"!"..table.concat(parts,".",2))
end)

vRP.registerPermissionFunction("is",function(user_id,parts)
    local param = parts[2]
    if param == "inside" then
        local player = vRP.getUserSource(user_id)
        if player then
            return vRPclient.isInside(player)
        end
    elseif param == "invehicle" then
        local player = vRP.getUserSource(user_id)
        if player then
            return vRPclient.isInVehicle(player)
        end
    end
end)

function vRP.hasPermission(user_id,perm)
    return INDEX[user_id][perm] ~= nil
end

function vRP.hasPermissions(user_id, perms)
    for k,v in ipairs(perms) do
        if vRP.hasPermission(user_id, v) then
            return true
        end
    end
    return false
end

function vRP.getUserGroupByType(user_id,gtype)
    local user_groups = vRP.getUserGroups(user_id)
    if gtype == 'job' and GetInvokingResource() == 'likizao_ac' then
        gtype = 'org'
    end
    for k,v in pairs(user_groups) do
        local kgroup = groups[k]
        if kgroup then
            if kgroup._config and kgroup._config.gtype and kgroup._config.gtype == gtype then
                return k
            end
        end
    end
    return ""
end

function vRP.getUserGroupOrg(user_id)
    local getGroup = vRP.getUserGroupByType(user_id, "org") or 0
    for k,v in pairs(groups) do
        if groups[k] and groups[k]._config ~= nil and k then
            local getOrg = groups[k]._config.orgName
            if k == getGroup then
                return getOrg
            end
        end
    end

    return false
end

function vRP.getUserGroupOrgType(user_id)
    local getGroup = vRP.getUserGroupByType(user_id, "org") or 0
    for k,v in pairs(groups) do
        if groups[k] and groups[k]._config ~= nil and k then
            local getOrgType = groups[k]._config.orgType
            if k == getGroup then
                return getOrgType
            end
        end
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    if first_spawn then
        local user = users[user_id]
        if user then
            for k,v in pairs(user) do
                vRP.addUserGroup(user_id,v)
            end
        end
    end

    local user_groups = vRP.getUserGroups(user_id)
    for k,v in pairs(user_groups) do
        local group = groups[k]
        if group and group._config and group._config.onspawn then
            group._config.onspawn(source)
        end
    end

    vRP.addUserGroup(user_id, "user")
end)