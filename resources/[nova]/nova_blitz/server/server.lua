local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

ServerAPI = {}
Tunnel.bindInterface(GetCurrentResourceName(), ServerAPI)
ClientAPI = Tunnel.getInterface(GetCurrentResourceName())

--- @param userId number
--- @return boolean
local function hasPermission(userId)
    assert(type(userId) == 'number', 'userId must be a number')

    local hasPermission = false
    for _, permission in pairs(Config.Permissions) do
        if permission.checkService then
            if not vRP.checkPatrulhamento(userId) then
                goto continue
            end
        end

        if permission.permType == 'group' then
            if vRP.hasGroup(userId, permission.perm) then
                hasPermission = true
                break
            end
        end

        if permission.permType == 'perm' then
            if vRP.hasPermission(userId, permission.perm) then
                hasPermission = true
                break
            end
        end

        ::continue::
    end

    return hasPermission
end

RegisterCommand(Config.MainCommand, function(source, args)
    local userId = vRP.getUserId(source)
    if not userId or not hasPermission(userId) then
        return
    end
    
    ClientAPI.openMenu(source)
end)

function ServerAPI.removeObject(netId)
    local entity = NetworkGetEntityFromNetworkId(netId)
    local hasProp = false
    for _, prop in pairs(Config.Props) do
        if prop == GetEntityModel(entity) then
            hasProp = true
            break
        end
    end

    if not hasProp then
        return
    end

    if DoesEntityExist(entity) then
        DeleteEntity(entity)
    end
end