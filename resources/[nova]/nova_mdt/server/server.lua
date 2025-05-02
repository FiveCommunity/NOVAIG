local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

local config = module('cfg/groups')
local groupsConfig = config.groups

ServerAPI = {}
Tunnel.bindInterface(GetCurrentResourceName(), ServerAPI)
ClientAPI = Tunnel.getInterface(GetCurrentResourceName())

organizationUsers = {}
userOrganization = {}
local lastLoginCache = {}

local function createAllTables()
    exports.oxmysql:execute([[
        CREATE TABLE IF NOT EXISTS mdt_criminal_records (
            id INT AUTO_INCREMENT PRIMARY KEY,
            user_id INT,
            officer_id INT,
            description TEXT,
            date VARCHAR(255)
        )
    ]])
    exports.oxmysql:execute([[
        CREATE TABLE IF NOT EXISTS mdt_staff_criminal_records (
            id INT AUTO_INCREMENT PRIMARY KEY,
            user_id INT,
            officer_id INT,
            description TEXT,
            date VARCHAR(255)
        )
    ]])

    exports.oxmysql:execute([[
        CREATE TABLE IF NOT EXISTS mdt_vehicle_apprehensions (
            id INT AUTO_INCREMENT PRIMARY KEY,
            user_id INT,
            officer_id INT,
            vehicle VARCHAR(255),
            description TEXT,
            date VARCHAR(255)
        )
    ]])

    exports.oxmysql:execute([[
        CREATE TABLE IF NOT EXISTS mdt_incidents_reports (
            id INT AUTO_INCREMENT PRIMARY KEY,
            involved INT,
            officer_id INT,
            description TEXT,
            date VARCHAR(255)
        )
    ]])

    exports.oxmysql:execute([[
        CREATE TABLE IF NOT EXISTS mdt_logs (
            id INT AUTO_INCREMENT PRIMARY KEY,
            user_id INT,
            organization VARCHAR(255),
            description TEXT,
            date VARCHAR(255)
        )
    ]])

    exports.oxmysql:execute([[
        CREATE TABLE IF NOT EXISTS mdt_organizations (
            id INT AUTO_INCREMENT PRIMARY KEY,
            organization VARCHAR(255) UNIQUE,
            permissions TEXT DEFAULT '{}',
            image VARCHAR(255) DEFAULT ''
        )
    ]])

    exports.oxmysql:execute([[
        CREATE TABLE IF NOT EXISTS mdt_users_rewards (
            id INT AUTO_INCREMENT PRIMARY KEY,
            user_id INT,
            organization VARCHAR(255)
        )
    ]])
end

--- @return void
function initializeLastLoginCache()
    local query = exports.oxmysql:executeSync('SELECT id, ultimo_login FROM vrp_users')
    if query and #query > 0 then
        for _, data in ipairs(query) do 
            lastLoginCache[data.id] = data.ultimo_login
        end
    end
end

--- @param userId number
--- @return string
function getUserName(userId)
    local identity = vRP.getUserIdentity(userId)
    if not identity or not identity.nome or not identity.sobrenome then
        return 'Sem Nome'
    end
    return identity.nome .. ' ' .. identity.sobrenome
end

--- @param userId number
--- @return string
local function getUserLastLogin(userId)
    return lastLoginCache[userId] and lastLoginCache[userId] or '18/08/2024'
end

--- @param roles table
--- @return table<string>
local function buildRoleNamesList(roles)
    local roleNames = {}
    for _, roleData in ipairs(roles) do
        table.insert(roleNames, roleData.roleName)
    end
    return roleNames
end

--- @param roleNames table
--- @return string
local function buildQueryForRoles(roleNames)
    local queryParts = {}
    for _, roleName in ipairs(roleNames) do
        table.insert(queryParts, "dvalue LIKE '%" .. roleName .. "%'")
    end
    return 'SELECT * FROM vrp_user_data WHERE ' .. table.concat(queryParts, " OR ")
end

--- @param roleName string
--- @param roles table
--- @return number
function getRoleTier(roleName, roles)
    for tier, roleData in ipairs(roles) do
        if roleData.roleName == roleName then
            return tier
        end
    end
    return nil
end

--- @param dvalue string
--- @return table
local function parseUserData(dvalue)
    local userData = json.decode(dvalue)
    return userData.groups or {}
end

--- @param dateString string
--- @return number
local function convertDateToTimestamp(dateString)
    local day, month, year = dateString:match("(%d%d)/(%d%d)/(%d%d%d%d)")
    return os.time{day = tonumber(day), month = tonumber(month), year = tonumber(year), hour = 0, min = 0, sec = 0}
end

--- @param activityTime number
--- @return string
local function calculateActivityTime(activityTime)
    local time = os.time() - activityTime
    return string.format('%02d:%02d:%02d', math.floor(time / 3600), math.floor((time % 3600) / 60), time % 60)
end

--- @param userId number
--- @return table | nil
function getUserOrganization(userId)
    return userOrganization[userId]
end

--- @param queryResults table
--- @param roles table
--- @param organization string
--- @return void | boolean
local function cacheOrganizationMembers(queryResults, roles, organization)
    for _, row in ipairs(queryResults) do
        local userId = tonumber(row.user_id)
        if not userId or userOrganization[userId] then
            goto continue
        end
        local groups = parseUserData(row.dvalue)
        for roleName, _ in pairs(groups) do
            local tier = getRoleTier(roleName, roles)
            if tier then
                table.insert(organizationUsers[organization].members, {
                    userId = userId,
                    name = getUserName(userId),
                    lastLogin = getUserLastLogin(userId),
                    role = roleName,
                    tier = tier,
                    isOnline = vRP.getUserSource(userId) and true or false,
                    activityTime = os.time(),
                })
                userOrganization[userId] = organization
            end
        end

        ::continue::
    end
end

--- @param organization string
--- @return void | boolean
local function createOrganizationCache(organization)
    local roles = Config.Roles[organization]
    if not roles then return end

    organizationUsers[organization] = { members = {} }

    local query = exports.oxmysql:executeSync(buildQueryForRoles(buildRoleNamesList(roles)))
    if #query > 0 then
        cacheOrganizationMembers(query, roles, organization)
    end

    print('Organization ' .. organization .. ' members cached, total: ' .. #organizationUsers[organization].members)
end

--- @return void
local function initializeOrganizationUsers()
    print('Initializing organization users...')
    initializeLastLoginCache()
    for organization in pairs(Config.Roles) do
        createOrganizationCache(organization)
    end
end

--- @param members table
--- @return table
local function orderOrganizationMembers(members)
    table.sort(members, function(a, b)
        if a.isOnline ~= b.isOnline then
            return a.isOnline and not b.isOnline
        elseif a.tier ~= b.tier then
            return a.tier < b.tier
        else
            return a.userId < b.userId
        end
    end)
    return members
end

--- @param members table
--- @return number
local function getOrganizationMembersOnline(members)
    local online = 0
    for _, member in ipairs(members) do
        if member.isOnline then
            online = online + 1
        end
    end
    return online
end

--- @param data table
--- @return table
local function organizeTableForClient(data)
    local organizedData = {members = {}, membersOnline = getOrganizationMembersOnline(data.members)}
    for _, member in ipairs(orderOrganizationMembers(data.members)) do
        table.insert(organizedData.members, {
            id = member.userId,
            name = member.name,
            role = {name = member.role, tier = member.tier},
            lastLogin = convertDateToTimestamp(member.lastLogin),
            online = member.isOnline,
        })
    end
    return organizedData
end

--- @param userId number
--- @return nil | string
function getUserRole(userId)
    local organization = getUserOrganization(userId)
    if not organization then return nil end

    local members = organizationUsers[organization].members

    for _, member in ipairs(members) do
        if member.userId == userId then
            return member.role
        end
    end

    return nil
end

function hasPermissionToRole(userId, organization, userRole, role)
    local roles = Config.Roles[organization]
    if not roles then return false end

    if hasStaffPermission(userId) then
        return true
    end

    local userRoleTier, roleTier
    for tier, roleData in ipairs(roles) do
        if roleData.roleName == userRole then
            userRoleTier = tier
        end
        if roleData.roleName == role then
            roleTier = tier
        end
    end

    return userRoleTier and roleTier and userRoleTier < roleTier
end

--- @param userId number
--- @param nuserId number
--- @param organization string
--- @param role string
--- @return boolean
function addUserToOrganization(userId, nuserId, organization, role)
    local organizationData = organizationUsers[organization]
    if not organizationData or not organizationData.members then return false end

    local tier = getRoleTier(role, Config.Roles[organization])
    if not tier then return false end

    table.insert(organizationData.members, {
        userId = nuserId,
        name = getUserName(nuserId),
        lastLogin = getUserLastLogin(nuserId),
        role = role,
        tier = tier,
        isOnline = true,
        activityTime = os.time(),
    })

    userOrganization[nuserId] = organization

    return true
end

--- @param nuserId number
--- @param organization string
--- @param newRole string
--- @return void
function updateUserRoleInOrganization(nuserId, organization, newRole)
    local organizationData = organizationUsers[organization]
    if not organizationData or not organizationData.members then return end

    for _, member in ipairs(organizationData.members) do
        if member.userId == nuserId then
            member.role = newRole
            member.tier = getRoleTier(newRole, Config.Roles[organization])
            break
        end
    end
end

--- @param nuserId number
--- @param organization string
--- @return void
function removeUserFromOrganization(nuserId, organization)
    local organizationData = organizationUsers[organization]
    if not organizationData or not organizationData.members then return end

    for i, member in ipairs(organizationData.members) do
        if member.userId == nuserId then
            table.remove(organizationData.members, i)
            break
        end
    end

    userOrganization[nuserId] = nil
end

--- @param userId number
--- @return void
AddEventHandler('vRP:playerSpawn', function(userId)
    if userId and getUserOrganization(userId) then
        for _, member in ipairs(organizationUsers[getUserOrganization(userId)].members) do
            if member.userId == userId then
                member.lastLogin = os.date('%d/%m/%Y')
                member.isOnline = true
                member.activityTime = os.time()
                break
            end
        end
    end
end)

--- @param userId number
--- @param source number
--- @return table
AddEventHandler('vRP:playerLeave', function(userId, source)
    if userId and getUserOrganization(userId) then
        for _, member in ipairs(organizationUsers[getUserOrganization(userId)].members) do
            if member.userId == userId then
                member.isOnline = false
                break
            end
        end
    end
end)

--- @return table
function ServerAPI.getOrganizationMembers()
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then return {} end

    local organization = getUserOrganization(userId)
    if not organization then return {} end

    local organizationData = organizationUsers[organization]
    if not organizationData then return {} end

    return organizeTableForClient(organizationData)
end

--- @return table<string>
function ServerAPI.getRolesToContract()
    local source = source
    local userId = vRP.getUserId(source)
    if not userId then return {} end

    local organization = getUserOrganization(userId)
    if not organization then return {} end

    local roles = Config.Roles[organization]
    if not roles then return {} end

    local roleNames = {}
    for _, roleData in ipairs(roles) do
        table.insert(roleNames, roleData.roleName)
    end

    return roleNames
end

--- @param userId number
--- @return string
function getInstagramImage(userId)
    local query = exports.oxmysql:singleSync('SELECT avatarURL FROM smartphone_instagram WHERE user_id = ?', { userId })
    if query then
        return query.avatarURL
    end

    return 'https://media.discordapp.net/attachments/1267599313845092426/1275614357597716510/image.png?ex=66c687f2&is=66c53672&hm=8680d3483da1c4f80696ff9abd13d94d93d429ca1e420793568be07232e70801&=&format=webp&quality=lossless'
end

--- @param userId number
--- @param source number
--- @return table | nil
local function getUserData(userId, source)
    local organization = getUserOrganization(userId)
    if not organization then return end

    local organizationData = organizationUsers[organization]
    if not organizationData then return end

    for _, member in ipairs(organizationData.members) do
        if member.userId == userId then
            return {
                name = member.name,
                role = member.role,
                image = getInstagramImage(userId),
                activityTime = calculateActivityTime(member.activityTime),
            }
        end
    end

    return nil
end

--- @param organization string
--- @param role string
--- @param action 'promote' | 'demote'
--- @return nil | string
function getNextRole(organization, role, action)
    local roles = Config.Roles[organization]
    if not roles then return nil end

    local roleTier = getRoleTier(role, roles)
    if not roleTier then return nil end

    if action == 'promote' then
        roleTier = roleTier - 1
    elseif action == 'demote' then
        roleTier = roleTier + 1
    end

    for tier, roleData in ipairs(roles) do
        if tier == roleTier then
            return roleData.roleName
        end
    end

    return nil
end

function getTotalUsersInRole(organization, role)
    local organizationData = organizationUsers[organization]
    if not organizationData then return 0 end

    local total = 0
    for _, member in ipairs(organizationData.members) do
        if member.role == role then
            total = total + 1
        end
    end

    return total
end

---@param source number
---@return number | nil
function validateUserAndOrganization(source)
    local userId = vRP.getUserId(source)
    if not userId then return nil end

    local organization = getUserOrganization(userId)
    if not organization then return nil end

    return userId
end

---@param source number
---@param permission string
---@return number|nil, string|nil
function validateUserAndOrganizationAndPermission(source, permission)
    local userId = vRP.getUserId(source)
    if not userId then return nil, nil end

    local organization = getUserOrganization(userId)
    if not organization or not isUserAuthorized(userId, permission) then return nil, nil end

    return userId, organization
end

RegisterCommand(Config.mainCommand, function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end
    local organization = getUserOrganization(userId)
    if not organization then return end
    local organizationData = organizationUsers[organization]
    if not organizationData then return end
    local userData = getUserData(userId, source)
    if not userData then return end
    ClientAPI._openOrganizationMenu(source, {
        org = {name = organization, icon = getOrganizationImage(organization)},
        user = userData,
        crimes = Config.crimes,
        mitigatingFactors = Config.mitigatingFactors,
    })
end)

function hasStaffPermission(userId)
    for _, perm in ipairs(Config.StaffPermissions) do
        if vRP.hasPermission(userId, perm) then
            return true
        end
    end

    return false
end

RegisterCommand(Config.staffCommand, function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    if not hasStaffPermission(userId) then
        return
    end

    if not args[1] then
        return
    end

    local organization = args[1]
    if not Config.Roles[organization] then
        return
    end

    local userOrg = getUserOrganization(userId)
    if userOrg then
        removeUserFromOrganization(userId, userOrg)
    end

    local firstRole = Config.Roles[organization][1].roleName
    local firstRoleTier = 1

    local organizationData = organizationUsers[organization]
    if not organizationData then return end

    vRP.addUserGroup(userId, firstRole)

    table.insert(organizationData.members, {
        userId = userId,
        name = getUserName(userId),
        lastLogin = getUserLastLogin(userId),
        role = firstRole,
        tier = firstRoleTier,
        isOnline = true,
        activityTime = os.time(),
    })

    userOrganization[userId] = organization

    local userData = getUserData(userId, source)
    if not userData then return end
    
    ClientAPI._openOrganizationMenu(source, {
        org = {name = organization, icon = getOrganizationImage(organization)},
        user = userData,
        crimes = Config.crimes,
        mitigatingFactors = Config.mitigatingFactors,
    })
end)

RegisterCommand('clearmdt', function(source, args)
    local userId = vRP.getUserId(source)
    if not hasStaffPermission(userId) then
        return
    end

    if not args[1] then
        return
    end

    local organization = args[1]
    if not Config.Roles[organization] then
        return
    end

    local orgData = organizationUsers[organization]
    if not orgData then
        return 
    end

    local members = orgData.members 
    if not members then
        return
    end

    TriggerClientEvent('Notify', source, 'aviso', 'Limpando o MDT '..organization..', aguarde...')

    for i, member in ipairs(members) do 
        if member.isOnline then
            vRP.removeUserGroup(member.userId, member.role)
        else
            local query = exports.oxmysql:singleSync('SELECT * FROM vrp_user_data WHERE user_id = ? AND dkey = ?', { member.userId, 'vRP:datatable' })
            if query then
                local data = json.decode(query.dvalue)
                data.groups = data.groups or {}
                
                if data.groups[group] then
                    data.groups[group] = nil
                end

                exports.oxmysql:execute('UPDATE vrp_user_data SET dvalue = ? WHERE user_id = ? AND dkey = ?', { json.encode(data), member.userId, 'vRP:datatable' })
            end
        end
        Wait(50)
    end

    orgData.members = {}

    TriggerClientEvent('Notify', source, 'sucesso', 'Organização limpa com sucesso!')
end)

CreateThread(function()
    createAllTables()
    initializeOrganizationUsers()
end)