---@param source number
---@param type string
---@param message string
---@return void
local function notifyUser(source, type, message)
    TriggerClientEvent('Notify', source, type, message)
end

---@param userId number
---@return void
local function removeUserWeapons(userId)
    local nSource = vRP.getUserSource(userId)
    if nSource then
        local weapons = vRP.clearWeapons(userId)
        vRPclient._replaceWeapons(nSource, {})
        vRP.clearInventory(userId)
    else
        vRP.clearInventory(userId)
    end
end

---@param userId number
---@param group string
---@param action string
---@return void
local function updateUserGroupData(userId, group, action)
    local query = exports.oxmysql:singleSync('SELECT * FROM vrp_user_data WHERE user_id = ? AND dkey = ?', { userId, 'vRP:datatable' })
    if query then
        local data = json.decode(query.dvalue)
        data.groups = data.groups or {}
        
        if action == "add" then
            if not data.groups[group] then
                data.groups[group] = true
            end
        elseif action == "remove" then
            if data.groups[group] then
                data.groups[group] = nil
            end
        end

        exports.oxmysql:execute('UPDATE vrp_user_data SET dvalue = ? WHERE user_id = ? AND dkey = ?', { json.encode(data), userId, 'vRP:datatable' })
    end
end

---@param userId number
---@param organization string
---@return boolean
local function requestConfirmation(source, organization)
    return vRP.request(source, 'Você deseja ser contratado para a organização '..organization..' ?', 30)
end

---@param userId number
---@param group string
---@return void
local function addUserGroup(userId, group)
    local nSource = vRP.getUserSource(userId)
    
    if nSource then
        if not vRP.hasGroup(userId, group) then
            vRP.addUserGroup(userId, group)
        end
    else
        updateUserGroupData(userId, group, "add")
    end
end

---@param userId number
---@param group string
---@return void
local function removeUserGroup(userId, group)
    local nSource = vRP.getUserSource(userId)
    
    if nSource then
        if vRP.hasGroup(userId, group) then
            vRP.removeUserGroup(userId, group)
        end
    else
        updateUserGroupData(userId, group, "remove")
    end
end

---@param nuserId number
---@param source number
---@return boolean
local function validateTargetUser(nuserId, source)
    local nSource = vRP.getUserSource(nuserId)
    if not nSource then
        notifyUser(source, 'negado', 'Esse usuário não está online.')
        return false
    end

    local targetOrganization = getUserOrganization(nuserId)
    if targetOrganization then
        notifyUser(source, 'negado', 'Esse usuário já faz parte de uma organização.')
        return false
    end

    local hasOrganization = vRP.getUserGroupOrg(nuserId)
    if hasOrganization then
        notifyUser(source, 'negado', 'Esse usuário já faz parte de uma organização.')
        return false
    end

    if vRP.hasGroup(nuserId, 'BlacklistPolicia') then
        notifyUser(source, 'negado', 'Esse usuário está na blacklist da policia.')
        return false
    end

    return true
end

---@param nuserId number
---@param role string
---@return boolean
function ServerAPI.contractMember(nuserId, role)
    local source = source
    local userId, organization = validateUserAndOrganizationAndPermission(source, 'canHire')
    if not userId then return false end

    local userRole = getUserRole(userId)
    if not userRole then return false end

    local userTier = getRoleTier(userRole, Config.Roles[organization])
    local roleTier = getRoleTier(role, Config.Roles[organization])
    if not userTier or not roleTier then return false end

    if userTier >= roleTier then
        notifyUser(source, 'negado', 'Você não pode contratar alguém para um cargo superior ou igual ao seu.')
        return false
    end

    if not validateTargetUser(nuserId, source) then return false end

    if not requestConfirmation(vRP.getUserSource(nuserId), organization) then return false end

    addUserGroup(nuserId, role)
    addUserToOrganization(userId, nuserId, organization, role)

    notifyUser(source, 'sucesso', 'O jogador ' .. nuserId .. ' foi contratado com sucesso para o cargo de ' .. role)
    notifyUser(vRP.getUserSource(nuserId), 'sucesso', 'Você foi contratado para a organização ' .. organization .. ' no cargo de ' .. role)

    vRP.sendLog(Config.Webhooks.contract, string.format('```prolog\n[USUARIO]: %s\n[ORGANIZACAO]: %s\n[CONTRATOU]: %s\n[CARGO]: %s\n[DATA]: %s\n```', userId, organization, nuserId, role, os.date('%d/%m/%Y %H:%M:%S')))
    addLog(userId, organization, 'Contratou o jogador #'..nuserId..' | '..getUserName(nuserId)..' no cargo de ' .. role)

    local query = exports.oxmysql:executeSync('SELECT * FROM mdt_users_rewards WHERE user_id = ? AND organization = ?', { nuserId, organization })
    if query and #query <= 0 then
        vRP.giveBankMoney(userId, Config.inviteReward)
        exports.oxmysql:execute('INSERT INTO mdt_users_rewards (user_id, organization) VALUES (?, ?)', { nuserId, organization })
    end

    return true
end

---@param nuserId number
---@return boolean
function ServerAPI.demoteMember(nuserId)
    local source = source
    local userId, organization = validateUserAndOrganizationAndPermission(source, 'canDemote')
    if not userId then return false end
    
    local userRole = getUserRole(userId)
    local currentRole = getUserRole(nuserId)
    if not userRole or not currentRole then return false end
    
    if not hasPermissionToRole(userId, organization, userRole, currentRole) then return false end
    
    local nextRole = getNextRole(organization, currentRole, 'demote')
    if not nextRole then return false end
    
    removeUserGroup(nuserId, currentRole)
    Wait(200)
    addUserGroup(nuserId, nextRole)
    updateUserRoleInOrganization(nuserId, organization, nextRole)

    notifyUser(source, 'sucesso', 'O jogador ' .. nuserId .. ' foi rebaixado com sucesso para o cargo de ' .. nextRole)

    vRP.sendLog(Config.Webhooks.demote, string.format('```prolog\n[USUARIO]: %s\n[ORGANIZACAO]: %s\n[REBAIXOU]: %s\n[CARGO]: %s\n[DATA]: %s\n```', userId, organization, nuserId, currentRole, os.date('%d/%m/%Y %H:%M:%S')))
    addLog(userId, organization, 'Rebaixou o jogador #'..nuserId..' | '..getUserName(nuserId)..' para o cargo de ' .. nextRole)
    return true
end

---@param nuserId number
---@return boolean
function ServerAPI.promoteMember(nuserId)
    local source = source
    local userId, organization = validateUserAndOrganizationAndPermission(source, 'canPromote')
    if not userId then return false end
    
    local currentRole = getUserRole(nuserId)
    if not currentRole then return false end
    
    local newRole = getNextRole(organization, currentRole, 'promote')
    if not newRole then return false end

    if not hasPermissionToRole(userId, organization, getUserRole(userId), newRole) then
        notifyUser(source, 'negado', 'Você não pode promover um membro para um cargo superior ou igual ao seu.')
        return false
    end
    
    removeUserGroup(nuserId, currentRole)
    Wait(200)
    addUserGroup(nuserId, newRole)
    updateUserRoleInOrganization(nuserId, organization, newRole)

    notifyUser(source, 'sucesso', 'O jogador ' .. nuserId .. ' foi promovido com sucesso para o cargo de ' .. newRole)

    vRP.sendLog(Config.Webhooks.promote, string.format('```prolog\n[USUARIO]: %s\n[ORGANIZACAO]: %s\n[PROMOVEU]: %s\n[CARGO]: %s\n[DATA]: %s\n```', userId, organization, nuserId, newRole, os.date('%d/%m/%Y %H:%M:%S')))
    addLog(userId, organization, 'Promoveu o jogador #'..nuserId..' | '..getUserName(nuserId)..' para o cargo de ' .. newRole)
    return true
end

---@param nuserId number
---@return boolean
function ServerAPI.dismissMember(nuserId)
    local source = source
    local userId = validateUserAndOrganization(source)
    if not userId then return false end

    local organization = getUserOrganization(userId)
    if not organization then return false end

    if userId ~= nuserId then
        local userRole = getUserRole(userId)
        local targetRole = getUserRole(nuserId)
        if not userRole or not targetRole then return false end

        if not hasPermissionToRole(userId, organization, userRole, targetRole) then
            notifyUser(source, 'negado', 'Você não pode demitir um membro com um cargo superior ou igual ao seu.')
            return false
        end
    end

    removeUserGroup(nuserId, getUserRole(nuserId))
    removeUserFromOrganization(nuserId, organization)
    removeUserWeapons(nuserId)

    notifyUser(source, 'sucesso', 'O jogador ' .. nuserId .. ' foi demitido com sucesso.')
    if userId == nuserId then
        notifyUser(source, 'sucesso', 'Você se demitiu com sucesso.')
    end

    vRP.sendLog(Config.Webhooks.dismiss, string.format('```prolog\n[USUARIO]: %s\n[ORGANIZACAO]: %s\n[DEMITIU]: %s\n[DATA]: %s\n```', userId, organization, nuserId, os.date('%d/%m/%Y %H:%M:%S')))
    addLog(userId, organization, 'Demitou o jogador #'..nuserId..' | '..getUserName(nuserId))
    return true
end