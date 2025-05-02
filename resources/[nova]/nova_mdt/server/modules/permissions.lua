local permissionsCache = {}
local organizationImagesCache = {}

local DEFAULT_IMAGE_URL = 'https://media.discordapp.net/attachments/1267599313845092426/1275614357597716510/image.png?ex=66c687f2&is=66c53672&hm=8680d3483da1c4f80696ff9abd13d94d93d429ca1e420793568be07232e70801&=&format=webp&quality=lossless'

---@param organization string
---@return string
function getOrganizationImage(organization)
    return organizationImagesCache[organization] or DEFAULT_IMAGE_URL
end

---@param userId number
---@param permission string
---@return boolean
function isUserAuthorized(userId, permission)
    local organization = getUserOrganization(userId)
    if not organization then return false end

    local userRole = getUserRole(userId)
    if not userRole then return false end

    local rolePermissions = permissionsCache[organization][userRole]
    if not rolePermissions then return false end

    return rolePermissions[permission] or false
end

---@param permissions table
---@param organization string
---@return table
local function sortPermissionsByTier(permissions, organization)
    local sortedPermissions = {}
    for _, permission in ipairs(permissions) do 
        local tier = getRoleTier(permission.name, Config.Roles[organization])
        sortedPermissions[tier] = permission
    end
    return sortedPermissions
end

---@return table|boolean
function ServerAPI.getRolesPermissions()
    local userId = validateUserAndOrganization(source)
    if not userId then return false end

    local organization = getUserOrganization(userId)
    if not organization then return false end

    local permissions = {}
    for role, perms in pairs(permissionsCache[organization]) do
        local enabledPermissions = {}
        for permission, isEnabled in pairs(perms) do 
            if isEnabled then
                table.insert(enabledPermissions, permission)
            end
        end

        table.insert(permissions, {
            name = role,
            members = getTotalUsersInRole(organization, role),
            permissions = enabledPermissions,
        })
    end

    return sortPermissionsByTier(permissions, organization)
end

---@param role table
---@return boolean
function ServerAPI.updateRolePermissions(role)
    local userId = validateUserAndOrganization(source)
    if not userId then return false end

    local organization = getUserOrganization(userId)
    if not organization then return false end

    local userTier = getRoleTier(getUserRole(userId), Config.Roles[organization])
    if userTier > 1 then return false end

    local rolePermissionsCache = permissionsCache[organization][role.name]
    if not rolePermissionsCache then return false end
 
    local updatedPermissions = {}
    for _, permission in ipairs(role.permissions) do
        updatedPermissions[permission] = true
    end

    for permission in pairs(rolePermissionsCache) do
        rolePermissionsCache[permission] = updatedPermissions[permission] or false
    end

    permissionsCache[organization][role.name] = rolePermissionsCache

    exports.oxmysql:execute('UPDATE mdt_organizations SET permissions = ? WHERE organization = ?', { json.encode(permissionsCache[organization]), organization })

    return true
end

CreateThread(function()
    Wait(2000)
    for organization, roles in pairs(Config.Roles) do 
        local query = exports.oxmysql:executeSync('SELECT * FROM mdt_organizations WHERE organization = ?', { organization })
        permissionsCache[organization] = query[1] and json.decode(query[1].permissions) or {}

        for _, role in ipairs(roles) do
            if not permissionsCache[organization][role.roleName] then
                permissionsCache[organization][role.roleName] = role.permissions
            end
        end

        exports.oxmysql:execute('INSERT INTO mdt_organizations (organization, permissions) VALUES (?, ?) ON DUPLICATE KEY UPDATE permissions = ?', { organization, json.encode(permissionsCache[organization]), json.encode(permissionsCache[organization]) })
    end
end)