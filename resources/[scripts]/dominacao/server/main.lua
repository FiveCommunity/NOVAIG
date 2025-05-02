
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
groups = module("cfg/groups").groups
domination = {
    running = false,
    running_time = 0,

    list = {
        --['GROTA'] = { points = 0, kills = 0, deaths = 0, totalMembers = 1, position = 5, time = os.time() }
    },

    playersInZone = {
        --[1] = 'GROTA',
    },
    KillsTiming = {
        -- [1] = { -- @@index == domination_id
        --     [1] = 5  -- @@index = user_id, value = kills_amount
        -- }
    },
}

GlobalState.dominationOwner = 'Ninguem'

local playersLeaveZone = {}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QUERYS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("dominacao/UpdateRank", "INSERT IGNORE INTO dm_ranks(org, orgType, generalwins) VALUES(@org, @orgType, @generalwins) ON DUPLICATE KEY UPDATE generalwins = generalwins + @generalwins")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- local notifiedPlayers = {}
function domination:enterZone(source, user_id)
    if self.running then
        if playersLeaveZone[user_id] then
            TriggerClientEvent('Notify', source, 'negado', 'Você saiu da zona de dominação e não pode voltar novamente.')
            Wait(1000)
            vRPclient._setHealth(source, 0)
            SetTimeout(1000, function()
                vRPclient._killComa(source)
            end)
            return
        end
    end
    local plyType,plyOrg = self:getGroupType(user_id)
    if plyOrg then
        -- SetPlayerRoutingBucket(source, 10)
        self.playersInZone[user_id] = plyOrg

        if not self.list[plyOrg] then
            self.list[plyOrg] = { points = 0, orgType = plyType, kills = 0, deaths = 0, totalMembers = 1, position = 99, time = os.time() }
        else
            self.list[plyOrg].totalMembers += 1
        end

        -- if notifiedPlayers[user_id] then
        --     CreateThread(function()
        --         while self.playersInZone[user_id] and self.running do
        --             TriggerClientEvent('Notify', source, 'aviso', 'Você já saiu e não pode entrar novamente, tem '..notifiedPlayers[user_id]..' segundos para entrar novamente.')
        --             Wait(1000)
        --             if self.playersInZone[user_id] then
        --                 notifiedPlayers[user_id] = notifiedPlayers[user_id] - 1
        --             end
        --             if notifiedPlayers[user_id] <= 0 then
        --                 notifiedPlayers[user_id] = nil
        --                 vRPclient._setHealth(source, 0)
        --                 SetTimeout(1000, function()
        --                     vRPclient._killComa(source)
        --                 end)
        --                 return
        --             end
        --         end
        --     end)
        --     return
        -- end

        if self.running then
            vTunnel._updateOrgPoints(source, true, (self.list[plyOrg].points / Config.pointsMax) * 100 )
            local totalMembers = 0
            for k, v in pairs(self.list) do
                if v.totalMembers then
                    totalMembers = totalMembers + v.totalMembers
                end
            end
            local totalPartners = self.list[plyOrg].totalMembers
            local points = self.list[plyOrg].points..'/'..Config.pointsMax
            local enemies = (totalMembers - totalPartners)..'/'..totalMembers
            TriggerClientEvent("update:dominationGeral", source, 'Geral', enemies, points, totalPartners)
        end
        
        TriggerClientEvent("Notify",source,"sucesso","Você entrou na zona de dominação.", 5)
    end
end
 
function domination:leaveZone(source, user_id)
    -- SetPlayerRoutingBucket(source, 0)
    local plyType,plyOrg = self:getGroupType(user_id)
    if plyOrg then
        self.playersInZone[user_id] = nil

        if self.list[plyOrg] then
            self.list[plyOrg].totalMembers -= 1

            if self.list[plyOrg].totalMembers <= 0 then
                self.list[plyOrg].totalMembers = 0
            end
        end

        vTunnel._updateOrgPoints(source, false)

        TriggerClientEvent("Notify",source,"negado","Você saiu da zona de dominação.", 5)
        if GetEntityHealth(GetPlayerPed(source)) > 101 then
            playersLeaveZone[user_id] = true
        else
            playersLeaveZone[user_id] = nil
        end

        -- if self.running then
        --     if not notifiedPlayers[user_id] then
        --         notifiedPlayers[user_id] = 10
        --     end
        -- end
    end
end

function domination:requestInit(source, user_id)
    local plyType,plyOrg = self:getGroupType(user_id)
    if not plyOrg then
        TriggerClientEvent("Notify",source,"negado","Você não está em uma organização responsavel por esse local.",6000)
        return
    end

    vRP.sendLog("https://discord.com/api/webhooks/1343672377111744533/YnBhuUKXq9mQi8Y1Ttsq_y5cU6W7cr32xcpTc8-nHfqkJuQKj-7N09wRfXNHIUY4Ojp-", "```Passaporte : "..user_id.." iniciou a dominação Geral ```")

    domination:start()
end

function domination:checkStart()
    return self.running
end

function domination:start()
    playersLeaveZone = {}
    self.running = true
    self.running_time = (os.time() + Config.time * 60)
    GlobalState.GlobalDominationColor = { 175, 19, 0 }
    CreateThread(function()      
        local users = vRP.getUsersByPermission('perm.ilegal')
        for l,w in pairs(users) do
            local player = vRP.getUserSource(parseInt(w))
            TriggerClientEvent('notifyDomStarted', player)
            TriggerClientEvent('chatMessage', player, {
                prefix = 'DOMINACAO GERAL:',
                prefixColor = '#000',
                title = 'DOMINACAO',
                message = 'A dominação geral foi iniciada!.'
            })
        end
    end)


    CreateThread(function()
        while self.running do

            local list = {}
            for index in pairs(self.list) do
                local org = self.list[index]

                -- ADICIONAR PONTUAÇÃO PARA ORGANIZAÇÃO
                if org.totalMembers > 0 then
                    self.list[index].points += Config.pointsPerMinute
                end

                -- ATUALIZAR PONTUAÇÃO PARA OS JOGADORES
                for ply_id, ply_org in pairs(self.playersInZone) do
                    if ply_org == index then
                        async(function()
                            local ply_src = vRP.getUserSource(ply_id)
                            if ply_src then
                                vTunnel._updateOrgPoints(ply_src, true, (self.list[index].points / Config.pointsMax) * 100 )

                                local totalMembers = 0
                                for k, v in pairs(self.list) do
                                    if v.totalMembers then
                                        totalMembers = totalMembers + v.totalMembers
                                    end
                                end
                                local totalPartners = self.list[ply_org].totalMembers
                                local points = self.list[index].points..'/'..Config.pointsMax
                                local enemies = (totalMembers - totalPartners)..'/'..totalMembers
                                TriggerClientEvent("update:dominationGeral", ply_src, 'Geral', enemies, points, totalPartners)
                            end
                        end)
                    end
                end

                -- GERANDO LISTA
                list[#list + 1] = { 
                    points = org.points or 0,
                    name = index or "Indefinido",
                    kills = org.kills or 0,
                    deaths = org.deaths or 0,
                    time = convertSecondsToMinute(os.time() - org.time) or 0
                }

                -- VALIDANDO PONTUACAO
                if self.list[index].points >= Config.pointsMax then
                    for k, v in pairs(self.list) do
                        local name = v.name 
                        local points = v.points 
                        -- exports.oxmysql:execute('INSERT INTO dm_ranks(org, orgType, wins) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE wins = wins + 3', { ply.org, org.orgType, 3 })
                    end
                    self.list[index] = nil

                    GlobalState.dominationOwner = index
                    TriggerClientEvent('chatMessage', -1, {
                        prefix = 'Dominação',
                        prefixColor = '#000',
                        title = 'AVISO',
                        message = '[DOMINACAO] Organização '..index..' venceu a dominação geral.'
                    })  
                    -- exports.oxmysql:query("INSERT IGNORE INTO dm_ranks(org, orgType, generalwins) VALUES(@org, @orgType, @generalwins) ON DUPLICATE KEY UPDATE generalwins = generalwins + @generalwins",{ org = list[1].name, orgType = org.orgType, generalwins = 1 })


                    local usersNotify = vRP.getUsersByPermission('perm.ilegal')
                    for l,w in pairs(usersNotify) do
                        local playerSource = vRP.getUserSource(parseInt(w))
                        if playerSource then 
                            TriggerClientEvent('notifyDomFinished', playerSource)
                        end
                    end

                    for ply_id, ply_org in pairs(self.playersInZone) do
                        async(function()
                            local ply_src = vRP.getUserSource(ply_id)
                            if ply_src then
                                vTunnel._updateOrgPoints(ply_src, false)
                            end
                        end)
                    end

                    self.list = {}
                    GlobalState.GlobalDominationColor = { 19, 0, 175 }
                    self.running = false
                    playersLeaveZone = {}
                    -- notifiedPlayers = {}
                    break
                end
            end

            -- FORMATANDO QUEM TIVER MAIS PONTOS
            table.sort(list, function(a, b) 
                return a.points > b.points
            end)

            -- ATUALIZANDO POSICAO
            for i = 1, #list do
                local org = list[i]

                list[i].position = i..'º'

                vRP.sendLog("https://discord.com/api/webhooks/1342984812973002752/qcsduk9EAGKYlGJWRHk9QolnN3KhIh3mR9hppRdTDXBsVCbLGX-zbSd-veDL_bRfoKGn",'Organização: '..org.name.. ' Está em '..list[i].position.. ' Com '..org.points.. ' ponto(s)')
            end

            -- VALIDANDO GANHANDOR
            local domination_time = parseInt((self.running_time - os.time()) / 60) 
            if domination_time <= 0 then

--                GlobalState.dominationOwner = list[1].name

                TriggerClientEvent('chatMessage', -1, {
                    prefix = 'Dominação',
                    prefixColor = '#000',
                    title = 'AVISO',
            --   message = '[DOMINACAO] Organização '..list[1].name..' venceu a dominação geral.'
                })  

                -- exports.oxmysql:query("INSERT IGNORE INTO dm_ranks(org, orgType, generalwins) VALUES(@org, @orgType, @generalwins) ON DUPLICATE KEY UPDATE generalwins = generalwins + @generalwins",{ org = list[1].name, orgType = list[1].orgType, generalwins = 1 })

                local usersNotify = vRP.getUsersByPermission('perm.ilegal')
                for l,w in pairs(usersNotify) do
                    local playerSource = vRP.getUserSource(parseInt(w))
                    if playerSource then 
                        TriggerClientEvent('notifyDomFinished', playerSource)
                    end
                end

                for ply_id, ply_org in pairs(self.playersInZone) do
                    async(function()
                        local ply_src = vRP.getUserSource(ply_id)
                        if ply_src then
                            vTunnel._updateOrgPoints(ply_src, false)
                        end
                    end)
                end

                for k, v in pairs(self.list) do
                    local name = v.name 
                    local points = v.points 
                    exports.oxmysql:query("INSERT IGNORE INTO dm_ranks_geral(org, points) VALUES(@org, @points) ON DUPLICATE KEY UPDATE points = points + @points",{ org = k, points = points })
                end
                self.list = {}
                playersLeaveZone = {}
                self.running = false
                GlobalState.GlobalDominationColor = { 19, 0, 175 }
                -- notifiedPlayers = {}
                break;
            end


            Wait(60 * 1000)
        end
    end)
end

function domination:requestList(user_id)
    local plyType,plyOrg = self:getGroupType(user_id)
    if plyOrg then
        -- GERANDO A LISTA
        local list = {}
        for index in pairs(self.list) do
            local org = self.list[index]

            list[#list + 1] = { 
                points = org.points or 0,
                name = index or "Indefinido",
                kills = org.kills or 0,
                deaths = org.deaths or 0,
                time = convertSecondsToMinute(os.time() - org.time) or 0,
                class = 'ouro',
            }
        end

        -- FORMATANDO QUEM TIVER MAIS PONTOS
        table.sort(list, function(a, b) 
            return a.points > b.points
        end)

        -- ATUALIZANDO POSICAO
        for i = 1, #list do
            list[i].position = i..'º'
        end

        -- RETORNANDO LISTA ATUALIZADA
        return {
            time = parseInt((domination.running_time - os.time())) ,
            list = list
        }
    end
end

function domination:getGroupType(user_id)
    local plyGroup = vRP.getUserGroupByType(user_id, "org")
    if plyGroup == "" and not groups[plyGroup] then return false end
    
    return (groups[plyGroup]._config and groups[plyGroup]._config.orgType or false), (groups[plyGroup]._config and groups[plyGroup]._config.orgName or false)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.enterZone()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    if vRP.hasPermission(user_id,"perm.countpolicia") then 
        local plyHealth = GetEntityHealth(GetPlayerPed(source))
        if plyHealth > 101 then 
            vRPclient._setHealth(source, 0)
            SetTimeout(1000, function()
                vRPclient._killComa(source)
            end)

            return false 
        end
    end

    local userOrg = vRP.getUserGroupOrg(user_id)
    if userOrg and userOrg ~= '' and exports.vrp_admin:isOrgBlocked(userOrg) then
        TriggerClientEvent('Notify', source, 'negado', 'Sua facção está bloqueada por 12 horas de entrar em qualquer dominacao')
        vRPclient.setHealth(source, 101)
        return
    end

    if not userOrg or (userOrg == '' or not vRP.hasPermission(user_id, 'perm.ilegal')) then
        TriggerClientEvent('Notify', source, 'negado', 'Você não pertence ao ilegal, portando não pode entrar nessa zona')
        vRPclient.setHealth(source, 101)
        return
    end

    if not exports['dm_module']:hasPlayedHours(user_id) then
        vRPclient.setHealth(source, 0)
        SetTimeout(1000, function()
            vRPclient._killComa(source)
        end)
        return false
    end

    return domination:enterZone(source, user_id)
end

function RegisterTunnel.leaveZone()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    return domination:leaveZone(source, user_id)
end

function RegisterTunnel.requestList()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    return domination:requestList(user_id)
end


local ResourceStarted = true
function RegisterTunnel.requestInit()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end
    if not ResourceStarted then return end

    return domination:requestInit(source, user_id)
end

function domination:reset()
    self.list = {}
    self.running = false
    self.running_time = 0
    self.playersInZone = {}
    self.dominationOwner = nil
    playersLeaveZone = {}
    -- notifiedPlayers = {}

    if not domination:checkStart() then 
        domination:start()
    end

end

RegisterCommand('resetdominacao', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    if not vRP.hasPermission(userId, 'developer.permissao') and not vRP.hasGroup(userId, 'respilegallotusgroup@445') then return end

    domination:reset()
    vRP.sendLog('https://discord.com/api/webhooks/1345130530877735034/Oyn2eBRMFxoehxCOm4UOc0F45Hn3xeTcSScoM0_w8d1JKu5Zf5m7UNXp6VF1AAFYTgKy', 'STAFF '..userId..' RESETOU A DOMINACAO GERAL')
end)

CreateThread(function()
    Wait(2000)
    exports.oxmysql:query('CREATE TABLE IF NOT EXISTS dm_ranks_geral (org VARCHAR(100), points INT DEFAULT 0);')
end)

CreateThread(function()
    GlobalState.GlobalDominationColor = { 19, 0, 175 }

    while true do 
        local actualHour = tonumber(os.date('%H')) -- Obtendo a hora atual
        local actualMinute = tonumber(os.date('%M')) -- Obtendo o minuto atual
        if not (Config.requestInit[tostring(actualHour)] and (type(Config.requestInit[tostring(actualHour)]) == "number" and actualMinute <= Config.requestInit[tostring(actualHour)])) then
            goto continue
        end

        if not domination:checkStart() then 
            domination:start()
        end


        ::continue::
        
        Wait(60 * 1000)
    end
end)