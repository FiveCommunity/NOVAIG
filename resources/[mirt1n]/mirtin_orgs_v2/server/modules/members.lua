
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BLACKLIST = {}

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.getMembers()
    local source = source
    local user_id = getUserId(source)
    if not user_id then return end

    local user = Organizations.Members[user_id]
    if not user then return end

    local FormatMembersList = {}
    for ply_id in pairs(Organizations.MembersList[user.groupType]) do
        local identity = getUserIdentity(ply_id)
        if not identity then goto next_player end

        local nuser = Organizations.Members[ply_id]
        if not nuser then goto next_player end

        local hasActive = (getUserSource(ply_id) and true) or false
        if Organizations.Members[ply_id] then
            if (not Organizations.Members[ply_id].joindate or not Organizations.Members[ply_id].lastlogin) then
                local timestamp = os.time()
                local query = vRP.query('mirtin_orgs_v2/GetAllUserInfo', { user_id = ply_id })
                if #query > 0 then
                    Organizations.Members[ply_id].joindate = query[1].joindate or timestamp
                    Organizations.Members[ply_id].lastlogin = query[1].lastlogin or timestamp
                    Organizations.Members[ply_id].timeplayed = query[1].timeplayed or 0
                else
                    Organizations.Members[ply_id].joindate = timestamp
                    Organizations.Members[ply_id].lastlogin = timestamp

                    exports["oxmysql"]:execute([[INSERT IGNORE INTO mirtin_orgs_player_infos(user_id, organization, joindate, lastlogin) VALUES(?,?,?,?)]], { ply_id, user.groupType, timestamp, timestamp })
                end
            end
        end
        local groupsGet = {}
        if Config.Groups[nuser.groupType] and Config.Groups[nuser.groupType].List and Config.Groups[nuser.groupType].List[nuser.group] and Config.Groups[nuser.groupType].List[nuser.group].prefix then
            groupsGet = Config.Groups[nuser.groupType].List[nuser.group].prefix
        end
        local tier = 10
        if nuser and Config.Groups[nuser.groupType] and Config.Groups[nuser.groupType].List and Config.Groups[nuser.groupType].List[nuser.group] and Config.Groups[nuser.groupType].List[nuser.group].tier then
            tier = Config.Groups[nuser.groupType].List[nuser.group].tier
        end
        
        FormatMembersList[#FormatMembersList + 1] = {
            id = ply_id,
            avatar = 'https://cdn.discordapp.com/icons/1220512491793289297/037858079290922918506b8a9714d8ca.webp',
            name = identity.name.. " "..identity.firstname,
            role = groupsGet,
            role_id = tier,
            status = hasActive,
            joinedAt = Organizations.Members[ply_id] and os.date('%d/%m/%Y %X',Organizations.Members[ply_id].joindate) or os.date('%d/%m/%Y %X'),
            lastLogin = Organizations.Members[ply_id] and os.date('%d/%m/%Y %X',Organizations.Members[ply_id].lastlogin) or os.date('%d/%m/%Y %X'),
            hours = Organizations.Members[ply_id] and Organizations.Members[ply_id].timeplayed or 0,
        }
        
        :: next_player ::
    end

    return FormatMembersList
end

function RegisterTunnel.inviteMember(playerId)
    local source = source
    local user_id = getUserId(source)
    if not user_id then return end

    local user = Organizations.Members[user_id]
    if not user then return end

    local hasPermission = Organizations.Permissions[user.groupType] and Organizations.Permissions[user.groupType][user.group].invite or false
    if not hasPermission then
        return
    end

    local ply_id = parseInt(playerId)
    if not ply_id then return end

    local ply_src = getUserSource(ply_id)
    if not ply_src then
        return Config.Langs['offlinePlayer'](source)
    end

    local nuser = Organizations.Members[ply_id]
    if nuser then
        return Config.Langs['alreadyFaction'](source)
    end

    if user_id == ply_id then
        return
    end

    local blackList = BLACKLIST:checkUser(ply_id) or 0
    if blackList and blackList > 0 then
        if (blackList - os.time()) > 0 then
            Config.Langs['alreadyBlacklist'](ply_src)
            Config.Langs['alreadyUserBlacklist'](source)
            return
        end
    end

    Config.Langs['sendInvite'](source)
    local request = request(ply_src, "Você está sendo convidado para a "..user.groupType.." deseja aceitar ?", 30)
    if request then
        local maxTier,setGroup = 0
        for group, v in pairs(Config.Groups[user.groupType].List) do
            if maxTier < v.tier then
                maxTier = v.tier
                setGroup = group
            end
        end

        if not setGroup then return end
        addUserGroup(ply_id, setGroup)

        Config.Langs['acceptInvite'](ply_src)
        Config.Langs['acceptedInvite'](source, ply_id)


        Organizations:AddUserGroup(ply_id, {
            group = setGroup,
            groupType = Organizations.List[setGroup]
        })
        
        SetTimeout(500, function()
            if Organizations.Members[ply_id] then
                vRP.execute('mirtin_orgs_v2/DeleteUserInfo', { user_id = ply_id })
                Organizations.Members[ply_id].joindate = os.time()
                Organizations.Members[ply_id].lastlogin = os.time()
                Organizations.Members[ply_id].timeplayed = 0
    
                exports["oxmysql"]:execute([[INSERT IGNORE INTO mirtin_orgs_player_infos(user_id, organization, joindate, lastlogin, timeplayed) VALUES(?,?,?,?,?)]], { ply_id, user.groupType, Organizations.Members[ply_id].joindate, Organizations.Members[ply_id].lastlogin, Organizations.Members[ply_id].timeplayed })
            end
        end)

        return true
    end

    return false
end

function RegisterTunnel.genMember(data)
    local source = source
    local user_id = getUserId(source)
    if not user_id then return end

    local user = Organizations.Members[user_id]
    if not user then return end

    local ply_id = tonumber(data.memberId)
    if not ply_id then return end

    local nuser = Organizations.Members[ply_id]
    if not nuser then return end

    -- Validando se ele e da mesma organização.
    if user.groupType ~= nuser.groupType then return end

    -- Validando as Açoes
    if data.action == 'promote' then
        local hasPermission = Organizations.Permissions[user.groupType] and Organizations.Permissions[user.groupType][user.group].promote or false
        if not hasPermission then
            return
        end


        local actual_tier,nactual_tier = Config.Groups[user.groupType].List[user.group].tier,Config.Groups[nuser.groupType].List[nuser.group].tier
        if actual_tier >= nactual_tier then return end
        
        local new_tier = (nactual_tier - 1)
        if new_tier <= 0 then new_tier = 1 end

        if actual_tier >= new_tier then
            return Config.Langs['bestTier'](source)
        end

        for group, v in pairs(Config.Groups[user.groupType].List) do
            if v.tier == new_tier then
                local ply_src = getUserSource(ply_id)
                if ply_src then
                    Config.Langs['youPromoved'](ply_src)
                    addUserGroup(ply_id, group)
                else
                    local data = getUserGroups(ply_id)
                    if data then
                        data[nuser.group] = nil
                        data[group] = true
            
                        Organizations:AddUserGroup(ply_id, {
                            group = group,
                            groupType = Organizations.List[group]
                        })

                        updateUserGroups(ply_id, data)
                    end
                end

                Config.Langs['youPromovedUser'](source, ply_id, Config.Groups[nuser.groupType].List[group].prefix)
                
                return {
                    role = Config.Groups[nuser.groupType].List[group].prefix,
                    role_id = nuser and Config.Groups[nuser.groupType].List[group].tier or 10,
                }
            end
        end
    end

    if data.action == 'demote' then
        local hasPermission = Organizations.Permissions[user.groupType] and Organizations.Permissions[user.groupType][user.group].demote or false
        if not hasPermission then
            return
        end

        local actual_tier,nactual_tier = Config.Groups[user.groupType].List[user.group].tier,Config.Groups[nuser.groupType].List[nuser.group].tier
        if actual_tier >= nactual_tier then   
            return Config.Langs['bestTier'](source)
        end

        local new_tier,maxTier = (nactual_tier + 1), 0
        for group, v in pairs(Config.Groups[user.groupType].List) do
            if maxTier < v.tier then
                maxTier = v.tier
            end

            if v.tier == new_tier then
                local ply_src = getUserSource(ply_id)
                if ply_src then
                    Config.Langs['youDemote'](ply_src)
                    addUserGroup(ply_id, group)
                else
                    local data = getUserGroups(ply_id)

                    if data then
                        data[nuser.group] = nil
                        data[group] = true
            
                        Organizations:AddUserGroup(ply_id, {
                            group = group,
                            groupType = Organizations.List[group]
                        })

                        updateUserGroups(ply_id, data)
                    end
                end

                Config.Langs['youDemoteUser'](source, ply_id, Config.Groups[nuser.groupType].List[group].prefix)
                
                return {
                    role = Config.Groups[nuser.groupType].List[group].prefix,
                    role_id = nuser and Config.Groups[nuser.groupType].List[group].tier or 10,
                }
            end
        end
    end

    if data.action == 'dismiss' then
        local hasPermission = Organizations.Permissions[user.groupType] and Organizations.Permissions[user.groupType][user.group].dismiss or false
        if not hasPermission then
            return
        end

        if ply_id == user_id then
            return Config.Langs['bestTier'](source)
        end

        local actual_tier,nactual_tier = Config.Groups[user.groupType].List[user.group].tier,Config.Groups[nuser.groupType].List[nuser.group].tier
        if actual_tier > nactual_tier then return end

        local ply_src = getUserSource(ply_id)
        if ply_src then
            removeUserGroup(ply_id, nuser.group)
            Config.Langs['youDismiss'](ply_src)
        else
            local data = getUserGroups(ply_id)

            if data then
                data[nuser.group] = nil
            end

            updateUserGroups(ply_id, data)

            Organizations:RemUserGroup(ply_id)
        end

        BLACKLIST:addUser(ply_id)
        Config.Langs['youDemoteUser'](source, ply_id,nuser.group)
        return true
    end

    return false
end

exports('remBL', function(user_id)
    user_id = parseInt(user_id)
    
    local source = getUserSource(user_id)
    if not source then return end

    BLACKLIST:remUser(user_id)
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function BLACKLIST:checkUser(user_id)
    local blacklist = vRP.getUData(user_id, 'facs:blacklist') or 0
    return tonumber(blacklist) or 0
end

function BLACKLIST:addUser(user_id)
    vRP.setUData(user_id,'facs:blacklist', os.time() + Config.Main.blackList * 86400)
end

function BLACKLIST:remUser(user_id)
    vRP.setUData(user_id,'facs:blacklist', 0)
end


