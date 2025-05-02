-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare('mirtin_orgs_v2/GetOrganizationInfos', ' SELECT * FROM mirtin_orgs_info WHERE organization = @organization ')
vRP.prepare('mirtin_orgs_v2/GetOrgsPermissions', 'SELECT organization,permissions FROM mirtin_orgs_info')
vRP.prepare('mirtin_orgs_v2/GetGoalsConfig', 'SELECT organization,config_goals FROM mirtin_orgs_info')
vRP.prepare('mirtin_orgs_v2/GetOrgsSalary', 'SELECT organization,salary FROM mirtin_orgs_info')

vRP.prepare('mirtin_orgs_v2/getAlerts', 'SELECT alerts FROM mirtin_orgs_info WHERE organization = @organization')
vRP.prepare('mirtin_orgs_v2/updateAlerts',
    'UPDATE mirtin_orgs_info SET alerts = @alerts WHERE organization = @organization')

vRP.prepare('mirtin_orgs_v2/updatePresets',
    'UPDATE mirtin_orgs_info SET presets = @presets WHERE organization = @organization')

vRP.prepare('mirtin_orgs_v2/updateRadio', 'UPDATE mirtin_orgs_info SET radio = @radio WHERE organization = @organization')

vRP.prepare('mirtin_orgs_v2/UpdatePermissions',
    'UPDATE mirtin_orgs_info SET permissions = @permissions WHERE organization = @organization')

vRP.prepare('mirtin_orgs_v2/updateFacInfo',
    'UPDATE mirtin_orgs_info SET discord = @discord WHERE organization = @organization')

vRP.prepare('mirtin_orgs_v2/GetAllUsersInfo', "SELECT * FROM mirtin_orgs_player_infos")
vRP.prepare('mirtin_orgs_v2/GetAllUserInfo', "SELECT * FROM mirtin_orgs_player_infos WHERE user_id = @user_id")
vRP.prepare('mirtin_orgs_v2/DeleteUserInfo', "DELETE FROM mirtin_orgs_player_infos WHERE user_id = @user_id")
vRP.prepare('mirtin_orgs_v2/DeleteUserInfoByGroup',
    "DELETE FROM mirtin_orgs_player_infos WHERE user_id = @user_id AND organization = @organization")
vRP.prepare('mirtin_orgs_v2/SetPlayerOrganization',
    "INSERT IGNORE INTO mirtin_orgs_player_infos(user_id, organization, joindate, lastlogin, timeplayed) VALUES(@user_id, @organization, @joindate, @lastlogin, @timeplayed)")

vRP.prepare('mirtin_orgs_v2/getInviteReward', "SELECT * FROM mirtin_orgs_invite_rewards WHERE user_id = @user_id")
vRP.prepare('mirtin_orgs_v2/setInviteReward',
    "INSERT IGNORE INTO mirtin_orgs_invite_rewards(user_id, organization, invite_userid) VALUES(@user_id, @organization, @invite_userid)")


vRP.prepare('mirtin_orgs_v2/updateSalary',
    'UPDATE mirtin_orgs_info SET salary = @salary WHERE organization = @organization')


vRP.prepare('mirtin_orgs_v2/CreateTable1',
    "CREATE TABLE IF NOT EXISTS `mirtin_orgs_goals` ( `user_id` int(11) NOT NULL, `organization` varchar(50) NOT NULL, `item` varchar(100) NOT NULL, `amount` int(11) NOT NULL DEFAULT 0, `day` int(11) NOT NULL, `month` int(11) NOT NULL, `step` int(11) DEFAULT 1, `reward_step` int(11) DEFAULT 0, UNIQUE KEY `user_id_organization_item_day` (`user_id`,`organization`,`item`,`day`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;")
vRP.prepare('mirtin_orgs_v2/CreateTable2',
    "CREATE TABLE IF NOT EXISTS `mirtin_orgs_info` ( `organization` varchar(50) NOT NULL, `alerts` text DEFAULT '{}', `logo` text DEFAULT NULL, `discord` varchar(150) DEFAULT '', `salary` int(11) DEFAULT 1000, `bank` int(11) DEFAULT 0, `bank_historic` text DEFAULT '{}', `permissions` text DEFAULT '{}', `config_goals` text DEFAULT '{}', PRIMARY KEY (`organization`) ) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;")
vRP.prepare('mirtin_orgs_v2/CreateTable3',
    "CREATE TABLE IF NOT EXISTS `mirtin_orgs_logs` ( `organization` varchar(50) DEFAULT NULL, `user_id` int(11) DEFAULT NULL, `role` varchar(50) DEFAULT NULL, `name` varchar(50) DEFAULT NULL, `description` varchar(200) DEFAULT NULL, `date` varchar(50) DEFAULT NULL, `expire_at` int(11) DEFAULT NULL ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;")
vRP.prepare('mirtin_orgs_v2/CreateTable4',
    "CREATE TABLE IF NOT EXISTS `mirtin_orgs_player_infos` ( `user_id` int(11) NOT NULL, `organization` varchar(50) DEFAULT NULL, `joindate` int(11) DEFAULT 0, `lastlogin` int(11) DEFAULT 0, `timeplayed` int(11) DEFAULT 0, PRIMARY KEY (`user_id`) ) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;")
vRP.prepare('mirtin_orgs_v2/CreateTable5',
    [[ CREATE TABLE IF NOT EXISTS `mirtin_orgs_chat` (`id` INT AUTO_INCREMENT PRIMARY KEY,`organization` VARCHAR(100) NOT NULL,`user_id` INT NOT NULL,`message` TEXT NOT NULL,`author` VARCHAR(100) NOT NULL,`created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP);]])

vRP.prepare('mirtin_orgs_v2/CreateTable6',
    [[   CREATE TABLE IF NOT EXISTS `mirtin_partners` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`cds` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`name` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`note` INT(11) NULL DEFAULT '0',
	`description` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`icon` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`groups` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
	`updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	PRIMARY KEY (`id`) USING BTREE
)]])

vRP.prepare('mirtin_orgs_v2/CreateTable7',
    [[   CREATE TABLE IF NOT EXISTS `mirtin_organization_members` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`user_id` INT(11) NOT NULL,
	`group_type` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`member_data` VARCHAR(244) NOT NULL DEFAULT '' COLLATE 'utf8mb4_bin',
	`item` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`amount` INT(11) NOT NULL,
	`day` VARCHAR(2) NOT NULL COLLATE 'utf8mb4_general_ci',
	`month` VARCHAR(2) NOT NULL COLLATE 'utf8mb4_general_ci',
	`created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
	PRIMARY KEY (`id`) USING BTREE
)]])

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Organizations = {
    List = {
    },
    Permissions = {
    },
    Members = {
    },
    MembersList = {
    },

    timePlayed = {
    },

    Chat = {
    },

    hasOppenedOrg = {
    },

    payDayOrg = {
    },

    goalsConfig = {
    }
}

BANK = {
    cooldown = {}
}

local WARNS = {}
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Organizations:AddUserGroup(user_id, v)
    self.Members[user_id] = v

    if not self.MembersList[v.groupType] then
        self.MembersList[v.groupType] = {}
    end

    self.MembersList[v.groupType][user_id] = true
end

function Organizations:RemUserGroup(user_id, group)
    local groupType = self.Members[user_id] and self.Members[user_id].groupType or false
    if groupType and self.MembersList[groupType] then
        self.MembersList[groupType][user_id] = nil
    end

    if group then
        vRP.execute('mirtin_orgs_v2/DeleteUserInfoByGroup', { user_id = user_id, organization = group })
    else
        vRP.execute('mirtin_orgs_v2/DeleteUserInfo', { user_id = user_id })
    end

    self.Members[user_id] = nil
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- RECIVE HANDLERS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('vRP:playerJoinGroup', function(user_id, group)
    Wait(200)
    if Organizations.List[group] then
        Organizations:AddUserGroup(user_id, {
            group = group,
            groupType = Organizations.List[group]
        })
    end
end)

AddEventHandler('vRP:playerLeaveGroup', function(user_id, group)
    if Organizations.List[group] then
        Organizations:RemUserGroup(user_id, group)
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local nameOrg = {}
RegisterCommand(Config.Main.cmd, function(source, args)
    local user_id = getUserId(source)
    if not user_id then return end

    local user = Organizations.Members[user_id]
    if not user then
        return TriggerClientEvent('Notify', source, 'negado', 'Você não faz parte de nenhuma organização.', 5000)
    end

    if BANK.cooldown[user_id] and (BANK.cooldown[user_id] - os.time()) > 0 then
        TriggerClientEvent('Notify', source, 'negado',
            'Você precisa esperar <b>' ..
            (BANK.cooldown[user_id] - os.time()) .. '</b> segundos para usar o comando novamente.', 5000)
        return
    end
    BANK.cooldown[user_id] = (os.time() + 5)

    if args[1] then
        if not Config.Groups[args[1]] then
            TriggerClientEvent('Notify', source, 'negado', '<b>Organização</b> não encontrada.', 5000)
            return
        end
        if not Organizations.MembersList[args[1]] then
            TriggerClientEvent('Notify', source, 'negado', 'Você não faz parte desta organização.', 5000)
            return
        end
        nameOrg[source] = args[1]
    end

    vTunnel._OpenPainel(source)
end)

RegisterCommand(Config.Main.cmdAdm, function(source, args)
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    if not vRP.hasPermission(user_id, "admin.permissao") then return end

    local orgName = args[1]
    if not orgName or orgName == "" then
        return
    end

    if not Config.Groups[orgName] then
        return
    end

    local bestGroup = ""
    for group, v in pairs(Config.Groups[orgName].List) do
        if v.tier == 1 then
            bestGroup = group
        end
    end
    vRP.addUserGroup(user_id, bestGroup)

    Wait(1000)
    vTunnel._OpenPainel(source)
end)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.getFaction()
    local source = source
    local user_id = getUserId(source)
    local orgName = nil
    if not user_id then return end

    local user = Organizations.Members[user_id]
    if not user then return end

    if nameOrg[source] then
        orgName = nameOrg[source]
        user.groupType = orgName
    end

    local identity = getUserIdentity(user_id)
    if not identity then return end
    local query = vRP.query('mirtin_orgs_v2/GetOrganizationInfos', { organization = user.groupType })
    if #query == 0 then
        print("Houve um problema ao encontrar essa Organizacao no banco de dados")
        return
    end

    local leaderGroup, listRoles = '', {}
    for group, v in pairs(Config.Groups[user.groupType].List) do
        if v.tier == 1 then
            leaderGroup = group
        else
            listRoles[#listRoles + 1] = {
                prefix = v.prefix,
                group = group,
            }
        end
    end

    local totalMember, onlineMembers = 0, 0

    if not Config.Groups[user.groupType] then
        TriggerClientEvent('Notify', source, 'negado', '<b>Organização</b> não encontrada.', 5000)
        return
    end
    if Organizations.MembersList[user.groupType] then
        for ply_id in pairs(Organizations.MembersList[user.groupType]) do
            if vRP.hasPermission(ply_id, Organizations.Members[ply_id].group) then
                if not Organizations.Members[ply_id] then goto next_player end
                if Organizations.Members[ply_id].groupType ~= user.groupType then goto next_player end

                if not Organizations.timePlayed[ply_id] then
                    Organizations.timePlayed[ply_id] = os.time()
                end

                totalMember = (totalMember + 1)
                local plySrc = getUserSource(ply_id)
                if plySrc then
                    onlineMembers = (onlineMembers + 1)
                end

                if Organizations.Members[ply_id].group == leaderGroup then
                    if not vRP.hasPermission(ply_id, 'suporte.permissao') then
                        local identity = getUserIdentity(ply_id)
                        if not identity then goto next_player end

                        leader = ("%s %s #%d"):format(identity.name, identity.firstname, ply_id)
                    end
                end
            end

            :: next_player ::
        end
    end

    local function getTotalMembers(organization)
        if not organization then return 0 end

        local query = vRP.query("mirtin_orgs_v2/getTotalMembers", {
            organization = organization
        })

        return query[1] and query[1].total or 0
    end

    local function getOnlineMembers(organization)
        if not organization then return 0 end

        local onlineCount = 0
        local members = vRP.query("mirtin_orgs_v2/getOrgMembers", {
            organization = organization
        })

        for _, member in ipairs(members) do
            local source = vRP.getUserSource(member.user_id)
            if source then
                onlineCount = onlineCount + 1
            end
        end

        return onlineCount
    end

    vRP.prepare("mirtin_orgs_v2/getTotalMembers", [[
        SELECT COUNT(*) as total
        FROM mirtin_orgs_player_infos
        WHERE organization = @organization
    ]])

    vRP.prepare("mirtin_orgs_v2/getOrgMembers", [[
        SELECT user_id
        FROM mirtin_orgs_player_infos
        WHERE organization = @organization
    ]])

    if not Organizations.hasOppenedOrg[user.groupType] then Organizations.hasOppenedOrg[user.groupType] = {} end
    Organizations.hasOppenedOrg[user.groupType][user_id] = source
    local presets = json.decode(query[1].presets)
    return {
        user_id = user_id,
        preset = {
            male = (presets and presets.male or ""),
            female = (presets and presets.female or "")
        },
        logo = query[1] and (query[1].logo) or Config.Main.serverLogo,
        radio = query[1] and (query[1].radio),
        serverIcon = Config.Main.serverLogo,
        store = Config.Main.storeUrl,
        orgName = user.groupType,
        orgBalance = query[1] and (query[1].bank or ""),
        name = ('%s %s'):format(identity.name, identity.firstname),
        playerBalance = getBankMoney(user_id),
        roles = listRoles,
        salary = Organizations.payDayOrg[user.groupType] and Organizations.payDayOrg[user.groupType].amount or false,
        nextPayment = Organizations.payDayOrg[user.groupType] and
            (Organizations.payDayOrg[user.groupType].time - os.time()) or false,
        nextPaymentMax = Organizations.payDayOrg[user.groupType] and
            (Organizations.payDayOrg[user.groupType].salaryTime * 60) or false,
        goalReward = Organizations.goalsConfig[user.groupType] and
            Organizations.goalsConfig[user.groupType].info.defaultReward or 1000,
        discord = query[1] and (query[1].discord or ""),
        leader = Organizations:GetLeaderName(user.groupType),
        members = getTotalMembers(user.groupType),
        membersOnline = getOnlineMembers(user.groupType),
        warnings = json.decode(query[1].alerts) or {},
        permissions = Organizations.Permissions[user.groupType] and Organizations.Permissions[user.groupType]
            [user.group] or {}
    }
end

function Organizations:GetLeaderName(organization)
    if not organization then return "Sem Líder" end

    local leaderGroup = ""
    for group, v in pairs(Config.Groups[organization].List) do
        if v.tier == 1 then
            leaderGroup = group
            break
        end
    end

    if Organizations.MembersList[organization] then
        for user_id in pairs(Organizations.MembersList[organization]) do
            if Organizations.Members[user_id] and Organizations.Members[user_id].group == leaderGroup then
                if not vRP.hasPermission(user_id, 'suporte.permissao') then
                    local identity = getUserIdentity(user_id)
                    if identity then
                        return ("%s %s #%d"):format(identity.name, identity.firstname, user_id)
                    end
                end
            end
        end
    end

    return "Sem Líder"
end

function RegisterTunnel.addWarn(message)
    local source = source
    local user_id = getUserId(source)
    if not user_id then return end

    local user = Organizations.Members[user_id]
    if not user then return end

    local identity = getUserIdentity(user_id)
    if not identity then return end

    if message:len() < 2 then return end

    local historic = WARNS:addWarning(user.groupType, {
        author = ('%s %s'):format(identity.name, identity.firstname),
        author_id = user_id,
        message = message,
        author_avatar = '',
        date = os.date("%d/%m/%Y %X"),
    })

    if Organizations.hasOppenedOrg[user.groupType] then
        for ply_id, ply_src in pairs(Organizations.hasOppenedOrg[user.groupType]) do
            local ped = GetPlayerPed(ply_src)
            if ped == 0 then goto next_player end

            TriggerClientEvent('updateWarnings', ply_src, historic)

            :: next_player ::
        end
    end

    return historic
end

vRP.prepare("mirtin_orgs_v2/chat/saveMessage", [[
    INSERT INTO mirtin_orgs_chat
    (organization, user_id, message, author, created_at)
    VALUES (@organization, @user_id, @message, @author, CURRENT_TIMESTAMP)
]])

vRP.prepare("mirtin_orgs_v2/chat/getMessages", [[
    SELECT * FROM mirtin_orgs_chat
    WHERE organization = @organization
    ORDER BY created_at DESC
    LIMIT 100
]])

function RegisterTunnel.sendMessage(message)
    local source = source
    local user_id = getUserId(source)
    if not user_id then return end

    local identity = getUserIdentity(user_id)
    if not identity then return end

    local user = Organizations.Members[user_id]
    if not user then return end

    if not Organizations.Chat[user.groupType] then
        Organizations.Chat[user.groupType] = {}
    end

    local author = ('%s %s'):format(identity.name, identity.firstname)

    vRP.execute('mirtin_orgs_v2/chat/saveMessage', {
        organization = user.groupType,
        user_id = user_id,
        message = message,
        author = author
    })

    local gen_id = (#Organizations.Chat[user.groupType] + 1)
    Organizations.Chat[user.groupType][gen_id] = {
        message = message,
        author = author,
        author_id = user_id,
    }

    for ply_id, ply_src in pairs(Organizations.hasOppenedOrg[user.groupType]) do
        async(function()
            local ped = GetPlayerPed(ply_src)
            if not ped then return end

            TriggerClientEvent("updateChatMessage", ply_src, Organizations.Chat[user.groupType][gen_id])
        end)
    end
end

function RegisterTunnel.getChatMessages()
    local source = source
    local user_id = getUserId(source)
    if not user_id then return end

    local user = Organizations.Members[user_id]
    if not user then return end

    local messages = vRP.query('mirtin_orgs_v2/chat/getMessages', {
        organization = user.groupType
    })

    local formattedMessages = {}
    for _, msg in ipairs(messages) do
        formattedMessages[#formattedMessages + 1] = {
            message = msg.message,
            author = msg.author,
            author_id = msg.user_id
        }
    end

    return formattedMessages
end

function RegisterTunnel.close()
    local source = source
    local user_id = getUserId(source)
    if not user_id then return end

    local user = Organizations.Members[user_id]
    if not user then return end

    if Organizations.hasOppenedOrg[user.groupType] and Organizations.hasOppenedOrg[user.groupType][user_id] then
        Organizations.hasOppenedOrg[user.groupType][user_id] = nil
        nameOrg[source] = nil
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


function WARNS:addWarning(organization, data)
    local query = vRP.query('mirtin_orgs_v2/getAlerts', { organization = organization })
    if #query == 0 then return end

    local historic = json.decode(query[1].alerts) or {}

    table.insert(historic, 1, data)

    if #historic > 10 then
        table.remove(historic, 11)
    end

    vRP.execute('mirtin_orgs_v2/updateAlerts', { organization = organization, alerts = json.encode(historic) })

    return historic
end



-- function WARNS:addWarning(organization, data)
--     local query = vRP.query('mirtin_orgs_v2/getAlerts', { organization = organization })
--     if #query == 0 then return end

--     local historic = json.decode(query[1].alerts) or {}
--     if #historic > 10 then
--         table.remove(historic, 11)
--     end
--     historic[#historic + 1] = data

--     vRP.execute('mirtin_orgs_v2/updateAlerts', { organization = organization, alerts = json.encode(historic) })

--     return historic
-- end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CACHE FUNCTIONS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Organizations:FormatConfig()
    local first = {}
    for orgName in pairs(Config.Groups) do
        for Group in pairs(Config.Groups[orgName].List) do
            self.List[Group] = orgName

            if (Config.Main.createAutomaticOrganizations) then
                if not first[orgName] then
                    first[orgName] = true
                    exports["oxmysql"]:executeSync([[INSERT IGNORE INTO mirtin_orgs_info(organization) VALUES(?)]],
                        { orgName })
                end
            end
        end
    end

    self:GenerateCache()
end

function Organizations:GenerateCache()
    local time = os.time()
    print(('^1[%s] ^0Iniciando Cache dos jogadores.'):format(GetCurrentResourceName():upper()))

    local query = vRP.query('mirtin_orgs_v2/GetUsersGroup')
    local FormatUser = {}
    if not MIRTIN_MULTICHAR then
        for i = 1, #query do
            local ply = query[i]
            local plyData = json.decode(ply.dvalue) or {}

            FormatUser[ply.user_id] = (plyData.groups or {})
        end
    else
        for i = 1, #query do
            local ply = query[i]
            local plyData = json.decode(ply.groups) or {}

            FormatUser[ply.user_id] = plyData
        end
    end

    for user_id, groups in pairs(FormatUser) do
        for groupName in pairs(groups) do
            if self.List[groupName] then
                self:AddUserGroup(user_id, {
                    group = groupName,
                    groupType = self.List[groupName]
                })
            end
        end
    end

    print(('^2[%s] ^0Cache dos jogadores gerados com sucesso tempo %s segundo(s).'):format(
        GetCurrentResourceName():upper(), os.time() - time))
    FormatUser = {}

    self:VerifyPlayers()
    self:GenerateCachePermissions()
    self:GenerateCacheGoals()
end

function Organizations:GenerateCacheInfos()
    local query = vRP.query('mirtin_orgs_v2/GetAllUsersInfo', {})
    for i = 1, #query do
        local ply = query[i]
        if self.Members[ply.user_id] then
            self.Members[ply.user_id].joindate = ply.joindate
            self.Members[ply.user_id].lastlogin = ply.lastlogin
            self.Members[ply.user_id].timeplayed = ply.timeplayed
        else
            -- REMOVENDO INFORMACOES CASO NÃO FOR MAIS DA ORGANIZAÇÃO
            vRP.execute('mirtin_orgs_v2/DeleteUserInfo', { user_id = ply.user_id })
        end
    end
end

function Organizations:VerifyPlayers()
    local users = getUsers()
    for user_id, source in pairs(users) do
        local plyGroups = getUserMyGroups(user_id) or getUserGroups(user_id)
        for group in pairs(plyGroups) do
            if self.Members[user_id] then
                if self.List[self.Members[user_id].group] then
                    if not hasGroup(user_id, self.Members[user_id].group) then
                        self:RemUserGroup(user_id, self.Members[user_id].group)
                    end
                end
            end

            if self.List[group] then
                self:AddUserGroup(user_id, {
                    group = group,
                    groupType = self.List[group]
                })

                Organizations.timePlayed[user_id] = os.time()
            end
        end
    end

    self:GenerateCacheInfos()
end

function Organizations:GenerateCachePermissions()
    local query = vRP.query('mirtin_orgs_v2/GetOrgsPermissions', {})
    for i = 1, #query do
        local v = query[i]
        if not v then goto next_org end

        local insert_permission = {}
        if Config.Groups[v.organization] then
            for Group in pairs(Config.Groups[v.organization].List) do
                if v.permissions == "{}" then
                    if not self.Permissions[v.organization] then self.Permissions[v.organization] = {} end
                    if not self.Permissions[v.organization][Group] then self.Permissions[v.organization][Group] = {} end
                    for permission in pairs(Config.defaultPermissions) do
                        if Config.Groups[v.organization].List[Group].tier == 1 then
                            self.Permissions[v.organization][Group]['leader'] = true
                            self.Permissions[v.organization][Group][permission] = true
                        else
                            self.Permissions[v.organization][Group][permission] = false
                        end
                    end

                    insert_permission[v.organization] = true
                else
                    self.Permissions[v.organization] = json.decode(v.permissions) or {}
                end
            end

            if insert_permission[v.organization] then
                vRP.execute('mirtin_orgs_v2/UpdatePermissions',
                    { organization = v.organization, permissions = json.encode(self.Permissions[v.organization]) })
            end
        end

        :: next_org ::
    end

    insert_permission = {}
end

function Organizations:PayDay()
    local query = vRP.query('mirtin_orgs_v2/GetOrgsSalary', {})
    local t = {}
    for i = 1, #query do
        t[query[i].organization] = json.decode(query[i].salary) or {}
    end

    for org, v in pairs(Config.Groups) do
        if v.Config and v.Config.Salary.active then
            self.payDayOrg[org] = {
                time = os.time() + (v.Config.Salary.time * 60),
                amount = v.Config.Salary.amount,
                salaryTime = v.Config.Salary.time
            }
        end

        local salary = t[org]

        if type(salary) == "table" and salary.expire_at and (salary.expire_at - os.time() > 0) then
            self.payDayOrg[org] = {
                salaryTime = salary.time,
                time = os.time() + (salary.salaryTime * 60),
                amount = salary.amount,
                salarySetTime = salary.salaryTime
            }
        else

        end
    end




    CreateThread(function()
        while true do
            for org, v in pairs(self.payDayOrg) do
                if (v.time - os.time()) <= 0 then
                    self.payDayOrg[org].time = os.time() + (v.salarySetTime * 60)
                    local query = vRP.query('mirtin_orgs_v2/bank/getinfo', { organization = org })
                    if #query == 0 then
                        goto next_org
                    end

                    local bank_value = (query[1].bank + v.amount)
                    local generate_log = BANK:generateLog(json.decode(query[1].bank_historic), {
                        name = org,
                        type = "SALÁRIO FAC",
                        value = v.amount,
                        date = os.date('%d/%m/%Y %X'),
                    })

                    vRP.execute('mirtin_orgs_v2/bank/updateBank',
                        { organization = org, bank = (query[1].bank + v.amount), historic = json.encode(generate_log) })
                end

                :: next_org ::
            end
            Wait(1000)
        end
    end)
end

function Organizations:addPayday(user_id, time, amount, expire)
    local user = Organizations.Members[user_id]
    if not user then
        return false
    end

    self.payDayOrg[user.groupType] = {
        salaryTime = time,
        time = os.time() + (time * 60),
        amount = amount,
        expire_at = os.time() + (expire * 60 * 60 * 24)
    }

    vRP.execute('mirtin_orgs_v2/updateSalary', {
        organization = user.groupType,
        salary = json.encode(self.payDayOrg[user.groupType])
    })

    TriggerClientEvent('Notify', src, 'sucesso', 'Você renovou o seu <b>Salario de Facção</b>.', 5000)

    return true
end

exports('addOrganizationPayday', function(...)
    return Organizations:addPayday(...)
end)

function Organizations:GenerateCacheGoals()
    local query = vRP.query('mirtin_orgs_v2/GetGoalsConfig', {})
    for i = 1, #query do
        local v = query[i]
        if not v then goto next_org end


        local insert_permission = {}
        if Config.Groups[v.organization] and Config.Groups[v.organization].Config.Goals then
            local data = json.decode(query[i].config_goals) or {}
            if not data.info then
                data.info = { itens = {} }
                data.info.defaultReward = Config.Groups[v.organization].Config.Goals.defaultReward
                for item, maxAmount in pairs(Config.Groups[v.organization].Config.Goals.itens) do
                    if not data.info.itens[item] then
                        data.info.itens[item] = { max = maxAmount, needed = true }
                    end
                end
            else
                for item in pairs(data.info.itens) do
                    if not Config.Groups[v.organization].Config.Goals.itens[item] then
                        data.info.itens[item] = nil
                    end
                end

                for item, values in pairs(Config.Groups[v.organization].Config.Goals.itens) do
                    if not data.info[item] then
                        data.info.itens[item] = { max = data.info.itens[item].max, needed = data.info.itens[item].needed }
                    end
                end
                data.info.defaultReward = parseInt(data.info.defaultReward)
            end
            self.goalsConfig[v.organization] = data
        end

        :: next_org ::
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HANDLERS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("mirtin_orgs_v2:playerSpawn", function(user_id, source)
    if Organizations.Members[user_id] then
        Organizations.Members[user_id].lastlogin = os.time()
        Organizations.timePlayed[user_id] = os.time()

        exports["oxmysql"]:execute([[UPDATE mirtin_orgs_player_infos SET lastlogin = ? WHERE user_id = ?]],
            { Organizations.Members[user_id].lastlogin, user_id })
    end
end)

AddEventHandler("mirtin_orgs_v2:playerLeave", function(user_id)
    if Organizations.timePlayed[user_id] then
        if Organizations.Members[user_id] and Organizations.Members[user_id].timeplayed then
            Organizations.Members[user_id].timeplayed = Organizations.Members[user_id].timeplayed +
                (os.time() - Organizations.timePlayed[user_id])

            exports["oxmysql"]:execute([[UPDATE mirtin_orgs_player_infos SET timeplayed = ? WHERE user_id = ?]],
                { Organizations.Members[user_id].timeplayed, user_id })
        end
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DATABASE SETUP AND QUERIES
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local createPartnersTableQuery =
[[CREATE TABLE IF NOT EXISTS mirtin_partners ( id INT AUTO_INCREMENT PRIMARY KEY,cds TEXT,name VARCHAR(100),note INT DEFAULT 0,description TEXT,icon TEXT,groups TEXT,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);]]
vRP.prepare("createPartnersTable", createPartnersTableQuery)
vRP.prepare("insertPartner",
    [[INSERT INTO mirtin_partners (cds, name, note, description, icon, groups) VALUES (@cds, @name, @note, @description, @icon, @groups)]])
vRP.prepare("getPartners", [[SELECT * FROM mirtin_partners]])
vRP.prepare("getLastInsertedPartnerId", [[SELECT LAST_INSERT_ID() AS id]])
vRP.prepare("mirtin/delete_partner", "DELETE FROM mirtin_partners WHERE id = @id")
vRP.prepare("mirtin/get_partners", "SELECT * FROM mirtin_partners WHERE id = @id")
vRP.execute("createPartnersTable")

local function trim(str)
    return str:match("^%s*(.-)%s*$")
end

local function hasAccess(userGroups, partnerGroups)
    if not partnerGroups then return false end
    for group in string.gmatch(partnerGroups, "[^,]+") do
        local trimmedGroup = trim(group)
        if userGroups[trimmedGroup] then
            return true
        end
    end
    return false
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GET PARTNERS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function getFilteredPartners(user_id)
    local userGroups = vRP.getUserGroups(user_id)
    local allPartners = vRP.query("getPartners")
    local filteredPartners = {}

    for _, partner in ipairs(allPartners) do
        if hasAccess(userGroups, partner.groups) then
            local partnerCopy = {
                id = partner.id,
                cds = partner.cds,
                name = partner.name,
                note = partner.note,
                description = partner.description,
                icon = partner.icon
            }
            table.insert(filteredPartners, partnerCopy)
        end
    end
    return filteredPartners
end

RegisterNetEvent('getPartners')
AddEventHandler('getPartners', function()
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        local filteredPartners = getFilteredPartners(user_id)
        TriggerClientEvent('receivePartners', source, filteredPartners)
    else
        TriggerClientEvent('receivePartners', source, {})
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- POST PARTNERS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('addPartner')
AddEventHandler('addPartner', function(data)
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        local groups = {}
        local userGroups = vRP.getUserGroups(user_id)

        for groupName, groupData in pairs(Config.Groups) do
            if groupData.List then
                for listName, _ in pairs(groupData.List) do
                    if userGroups[listName] then
                        table.insert(groups, listName)
                    end
                end
            end
        end

        vRP.execute("insertPartner", {
            cds = data.cds or "",
            name = data.name or "",
            note = data.note or 0,
            description = data.description or "",
            icon = data.icon or "",
            groups = table.concat(groups, ",")
        })

        local updatedPartners = getFilteredPartners(user_id)

        TriggerClientEvent('receivePartners', source, updatedPartners)

        local result = vRP.query("getLastInsertedPartnerId")
        if result and result[1] and result[1].id then
            TriggerClientEvent("partnerAdded", source, true)
        else
            TriggerClientEvent("partnerAdded", source, false)
        end
    else
        TriggerClientEvent("partnerAdded", source, false)
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DELET PARTNERS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('deletePartner')
AddEventHandler('deletePartner', function(partnerId)
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        if partnerId then
            vRP.execute("mirtin/delete_partner", { id = tostring(partnerId) })

            TriggerClientEvent('partnerDeleted', source, partnerId)
        else
            TriggerClientEvent('notifications', source, "error", "Error deleting partner: Invalid ID")
        end
    else
        TriggerClientEvent('notifications', source, "error", "Error: Authentication failed")
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GET PARTNERS MARKET
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("get_all_coords", "SELECT id, cds, name FROM mirtin_partners")

RegisterServerEvent('mirtin_partners:server:GetAllCoords')
AddEventHandler('mirtin_partners:server:GetAllCoords', function()
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        local rows = vRP.query("get_all_coords", {})
        if #rows > 0 then
            local coordsList = {}
            for _, row in ipairs(rows) do
                table.insert(coordsList, {
                    id = row.id,
                    coords = json.decode(row.cds),
                    name = row.name
                })
            end
            TriggerClientEvent('mirtin_partners:client:ReceiveAllCoords', source, coordsList)
        end
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GET MEMBER ITEM LIST
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("mirtin_historico/get_all_members", [[
    SELECT
        m.id,
        m.user_id,
        m.group_type,
        m.member_data,
        m.item,
        m.amount,
        m.day,
        m.month,
        m.created_at
    FROM mirtin_organization_members m
    ORDER BY m.created_at DESC
]])

RegisterServerEvent('mirtin_historico:getHistorico')
AddEventHandler('mirtin_historico:getHistorico', function()
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id then
        print("Buscando histórico para user_id:", user_id)

        local identity = getUserIdentity(user_id)
        local playerName = identity and identity.name

        local playerGroups = {}
        for groupName, groupConfig in pairs(Config.Groups) do
            for cargo, data in pairs(groupConfig.List) do
                if vRP.hasGroup(user_id, cargo) then
                    table.insert(playerGroups, cargo)
                end
            end
        end

        if #playerGroups > 0 then
            local rows = vRP.query("mirtin_historico/get_all_members")

            if rows and type(rows) == "table" and #rows > 0 then
                local formattedData = {}
                for _, row in pairs(rows) do
                    if table.contains(playerGroups, row.group_type) then
                        local dateStr = string.format("%02d/%02d/%s",
                            tonumber(row.day) or 1,
                            tonumber(row.month) or 1,
                            os.date("%Y", os.time())
                        )

                        local formattedRow = {
                            name = row.member_data or 'DESCONHECIDO',
                            id = tonumber(row.user_id) or 0,
                            date = dateStr,
                            role = string.upper(row.group_type or 'DESCONHECIDO'),
                            amount = tonumber(row.amount) or 0,
                            status = true,
                            item = row.item or 'DESCONHECIDO'
                        }

                        table.insert(formattedData, formattedRow)
                    end
                end

                TriggerClientEvent('mirtin_partners:client:ReceiveData', source, formattedData)
            else
                TriggerClientEvent('mirtin_partners:client:ReceiveData', source, {})
            end
        else
            TriggerClientEvent('mirtin_partners:client:ReceiveData', source, {})
        end
    else
        TriggerClientEvent('mirtin_partners:client:ReceiveData', source, {})
    end
end)

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    vRP.execute("mirtin_orgs_v2/CreateTable1", {})
    vRP.execute("mirtin_orgs_v2/CreateTable2", {})
    vRP.execute("mirtin_orgs_v2/CreateTable3", {})
    vRP.execute("mirtin_orgs_v2/CreateTable4", {})
    vRP.execute("mirtin_orgs_v2/CreateTable5", {})
    vRP.execute("mirtin_orgs_v2/CreateTable6", {})
    vRP.execute("mirtin_orgs_v2/CreateTable7", {})
    Wait(10)
    Organizations:FormatConfig()
    Organizations:PayDay()
end)


AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        local border = string.rep("=", 40)
        print(string.format("^1%s", border))
        print("^5Script Finalizado - Five Community") 
        print(string.format("^1%s", border))
    end
end)