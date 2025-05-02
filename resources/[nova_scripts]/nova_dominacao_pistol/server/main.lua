
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
groups = module("cfg/groups").groups
dominationPistol = {
    running = false,
    running_time = 0,

    list = {
        --['GROTA'] = { points = 0, kills = 0, deaths = 0, totalMembers = 1, position = 5, time = os.time() }
    },

    playersInZone = {
        --[1] = 'GROTA',
    },
    KillsTiming = {
        -- [1] = { -- @@index == dominationPistol_id
        --     [1] = 5  -- @@index = user_id, value = kills_amount
        -- }
    },

    ZonesDominateds = {
        -- ['A'] = "YAKUZA",
        -- ['B'] = 'GROTA',
    }

}

GlobalState.dominationPistolOwner = 'Ninguem'

local playersLeaveZone = {}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- local notifiedPlayers = {}
function dominationPistol:enterZone(source, user_id)
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

        if plyOrg == GlobalState.dominationOwner then
            TriggerClientEvent('Notify', source, 'negado', 'Você já dominou a dominação geral.')
            Wait(1000)
            vRPclient.setHealth(source, 101)
            return
        end

        self.playersInZone[user_id] = plyOrg

        if not self.list[plyOrg] then
            self.list[plyOrg] = { points = 0, orgType = plyType, kills = 0, deaths = 0, totalMembers = 1, position = 99, time = os.time() }
        else
            self.list[plyOrg].totalMembers += 1
        end

        vTunnel._setUserOrg(source, plyOrg)

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
           
            TriggerClientEvent("dom_pistol:createMarker",source, self.markers)

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
            TriggerClientEvent("update:dominationGeral", source, 'Pistola', enemies, points, totalPartners)
        end
        
        TriggerClientEvent("Notify",source,"sucesso","Você entrou na zona de dominação.", 5)
    end
end
 
function dominationPistol:leaveZone(source, user_id)
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

function dominationPistol:requestInit(source, user_id)
    local plyType,plyOrg = self:getGroupType(user_id)
    if not plyOrg then
        TriggerClientEvent("Notify",source,"negado","Você não está em uma organização responsavel por esse local.",6000)
        return
    end

    vRP.sendLog("https://discord.com/api/webhooks/1262796902634623106/NZ9G95YMiAj4ZzeQqvD84AF8o8lCmOt1IZQ23oIco7wZQUCCt3OWJA_F7emv1yVlsjza", "```Passaporte : "..user_id.." iniciou a dominação Geral ```")

    dominationPistol:start()
end

function dominationPistol:checkStart()
    return self.running
end

function dominationPistol:start()
    playersLeaveZone = {}
    self.running = true
    self.running_time = (os.time() + Config.time * 60)

    self.markers = {}

    GlobalState.GlobalDominationPistolColor = { 175, 19, 0 }

    CreateThread(function()
        local users = vRP.getUsersByPermission('perm.ilegal')
        for _, user_id in pairs(users) do
            local player = vRP.getUserSource(parseInt(user_id))
            if player then
                TriggerClientEvent('notifyDomStarted', player)
                TriggerClientEvent('chatMessage', player, {
                    prefix = 'DOMINACAO PISTOLA:',
                    prefixColor = '#000',
                    title = 'DOMINACAO',
                    message = 'A dominação pistola foi iniciada!.'
                })
            end
        end
    end)

    -- Cria markers em todos os coordsDrawmarkers definidos
    for index, zoneInfo in ipairs(Config.coordsDrawmarkers) do
        self.markers[index] = {
            coords = zoneInfo,
            dominado = false,
            dominando = false,
            contestando = false,
            dominadoBy = 'Ninguem',
            orgsInZone = {},
        }
    end

    -- Thread principal da dominacao pistola
    CreateThread(function()

        local counterAirdrop = 0

        -- Envia o createMarker só para quem já está na zone (se houver alguém)
        for ply_id, ply_orgIndex in pairs(self.playersInZone) do
            async(function()
                local ply_src = vRP.getUserSource(ply_id)
                if ply_src then
                    TriggerClientEvent("dom_pistol:createMarker", ply_src, self.markers)
                end
            end)
        end

        while self.running do
            -- Monta uma lista para ordenar/visualizar as orgs
            local list = {}

            for orgName, orgData in pairs(self.list) do

                --------------------------------------------------------------------
                -- Adicionar pontos se tiverem zonas dominadas
                --------------------------------------------------------------------
                local totalZonesDominatedsPerOrg = {}
                for _, orgDominating in pairs(self.ZonesDominateds) do
                    totalZonesDominatedsPerOrg[orgDominating] = 
                        (totalZonesDominatedsPerOrg[orgDominating] or 0) + 1
                end

                -- Caso a org esteja dominando algo, incrementa os pontos
                local zonesCount = totalZonesDominatedsPerOrg[orgName] or 0
                if zonesCount > 0 then
                    -- Exemplo de tabela de pontos com base na quantidade de zonas
                    if Config.pointsWinPerZoneDominated[zonesCount] then
                        orgData.points = (orgData.points or 0) + Config.pointsWinPerZoneDominated[zonesCount]
                    end
                end

                --------------------------------------------------------------------
                -- Atualiza pontos na HUD para cada player da org
                --------------------------------------------------------------------
                for ply_id, ply_currentOrgName in pairs(self.playersInZone) do
                    if ply_currentOrgName == orgName then
                        if orgData.points >= Config.pointsMax then
                            -- Se atingiu o máximo de pontos, fim imediato da dominação
                            dominationPistol:winDomination(orgName)
                            return -- finaliza a thread da dominação
                        end
                        async(function()
                            local ply_src = vRP.getUserSource(ply_id)
                            if ply_src then
                                -- Envia atualização de pontos para o cliente
                                local percent = (orgData.points / Config.pointsMax) * 100
                                vTunnel._updateOrgPoints(ply_src, true, percent)
                                
                                -- Envia status geral
                                local totalMembers = 0
                                for _, data in pairs(self.list) do
                                    totalMembers = totalMembers + (data.totalMembers or 0)
                                end
                                local totalPartners = orgData.totalMembers or 0
                                local pointsText = (orgData.points or 0) .. '/' .. Config.pointsMax
                                local enemies = (totalMembers - totalPartners) .. '/' .. totalMembers
                                TriggerClientEvent("update:dominationGeral", ply_src, 'Pistola', enemies, pointsText, totalPartners)
                            end
                        end)
                    end
                end

                --------------------------------------------------------------------
                -- Adiciona a org atual na "list", que será ordenada
                --------------------------------------------------------------------
                list[#list + 1] = {
                    name   = orgName or "Indefinido",
                    orgType= orgData.orgType or "N/A",
                    points = orgData.points or 0,
                    kills  = orgData.kills or 0,
                    deaths = orgData.deaths or 0,
                    time   = convertSecondsToMinute(os.time() - (orgData.time or os.time()))
                }
            end

            -- Ordena quem tem mais pontos (maior -> menor)
            table.sort(list, function(a, b)
                return a.points > b.points
            end)

            ------------------------------------------------------------------------
            -- Aqui, se você quiser verificar periodicamente, list[1] é o maior
            -- mas no seu caso, você precisa só quando o tempo esgotar
            ------------------------------------------------------------------------

            -- Lida com Airdrop periódico
            counterAirdrop = counterAirdrop + 1
            if counterAirdrop >= Config.airdrop.timePerAirdrop then
                CreateThread(function()
                    counterAirdrop = 0
                    local randomCoords = Config.airdrop.locations[math.random(1, #Config.airdrop.locations)]
    
                    for ply_id in pairs(self.playersInZone) do
                        async(function()
                            local ply_src = vRP.getUserSource(ply_id)
                            if ply_src then
                                TriggerClientEvent('Notify', ply_src, 'sucesso', 'Airdrop caindo em sua proximidade!', 10000)
                            end
                        end)
                    end
    
                    exports['nova_airdrop']:createCustomAirdrop(randomCoords, Config.airdrop.rewards)
                end)

            end


            ------------------------------------------------------------------------
            -- Se o tempo dessa dominação chegou ao fim, define o vencedor
            ------------------------------------------------------------------------
            ---
            local dominationPistol_time = parseInt((self.running_time - os.time()) / 60)


            if dominationPistol_time <= 0 then
                
                -- Verifica quem está em primeiro lugar
                local winner = list and list[1] or false
                
                if winner then

                    GlobalState.dominationPistolOwner = winner.name

                    dominationPistol:winDomination(winner.name)
                    vRP.sendLog('https://discord.com/api/webhooks/1315116988133277827/ksyMDQgkvaY21qUS_pd0FvApmoueIEW9fn7LS_ER6lr-AIAseM5UgQgb9PAXSvBVWT88', 'A ORGANIZACAO '..winner.name..' DOMINOU A PISTOLA')

                else
                    GlobalState.dominationPistolOwner = 'Ninguem'
                end

                -- Notifica todo mundo que acabou
                local usersNotify = vRP.getUsersByPermission('perm.ilegal')
                for _, w in pairs(usersNotify) do
                    local playerSource = vRP.getUserSource(parseInt(w))
                    if playerSource then 
                        TriggerClientEvent('notifyDomFinished', playerSource)
                    end
                end

                -- Limpa a HUD de pontos pra todo mundo
                for ply_id in pairs(self.playersInZone) do
                    async(function()
                        local ply_src = vRP.getUserSource(ply_id)
                        if ply_src then
                            vTunnel._updateOrgPoints(ply_src, false)
                        end
                    end)
                end

                -- Atualiza cada org no banco com a pontuação que ela fez
                for orgName, orgData in pairs(self.list) do
                    local points = orgData.points or 0
                    exports.oxmysql:execute(
                      [[
                        INSERT INTO dm_ranks_pistol (org, points) 
                        VALUES (?, ?) 
                        ON DUPLICATE KEY UPDATE 
                          points = points + VALUES(points)
                      ]],
                      { orgName, points }
                    )
                end
                
                -- Reseta variáveis
                self.list = {}
                playersLeaveZone = {}
                self.running = false
                GlobalState.GlobalDominationPistolColor = { 19, 0, 175 }
                
                break
            end

            -- Aguarda 1 minuto até o próximo loop
            Wait(60 * 1000)
        end
    end)
end


RegisterNetEvent("aidrop:dominacao_pistol:rewardItem", function(params)
    local user_id = params.user_id
    local source = vRP.getUserSource(user_id)

    if source then
        for _, reward in ipairs(params.rewards) do
            TriggerClientEvent("dominacao_pistol:insertWeaponWhitelist", source, reward.item)
        end
    end
end)

function dominationPistol:requestList(user_id)
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
            time = parseInt((dominationPistol.running_time - os.time())) ,
            list = list
        }
    end
end

function dominationPistol:getGroupType(user_id)
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

    if not userOrg or (userOrg == '' or not vRP.hasPermission(user_id, 'perm.ilegal')) then
        TriggerClientEvent('Notify', source, 'negado', 'Você não pertence ao ilegal, portando não pode entrar nessa zona')
        vRPclient.setHealth(source, 101)
        return
    end

    -- if not exports['dm_module']:hasPlayedHours(user_id) then
    --     vRPclient.setHealth(source, 0)
    --     SetTimeout(1000, function()
    --         vRPclient._killComa(source)
    --     end)
    --     return false
    -- end

    return dominationPistol:enterZone(source, user_id)
end

function RegisterTunnel.leaveZone()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    return dominationPistol:leaveZone(source, user_id)
end

function RegisterTunnel.requestList()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    return dominationPistol:requestList(user_id)
end


local ResourceStarted = true
function RegisterTunnel.requestInit()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end
    if not ResourceStarted then return end

    return dominationPistol:requestInit(source, user_id)
end

function dominationPistol:reset()
    self.list = {}
    self.running = false
    self.running_time = 0
    self.playersInZone = {}
    self.dominationPistolOwner = nil
    playersLeaveZone = {}
    -- notifiedPlayers = {}

    if not dominationPistol:checkStart() then 
        dominationPistol:start()
    end

end

RegisterCommand('dominacaopistol', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then return end

    if not vRP.hasPermission(userId, 'developer.permissao') and not vRP.hasGroup(userId, 'respilegallotusgroup@445') then return end

    if not args[1] then return TriggerClientEvent('Notify', source, 'negado', 'Use /dominacaopistol [farmreset ou restart ou aidrdrop] [se for farmreset nome da org]', 8000) end

    local options = {
        ['restart'] = function()
            dominationPistol:reset()
            TriggerClientEvent('Notify', source, 'sucesso', 'Dominação reiniciada com sucesso.', 8000)
        end,

        ['orgreset'] = function()
            local organization = args[2]

            if not organization or organization == '' then
                return TriggerClientEvent('Notify', source, 'negado', 'Use /dominacaopistol orgreset [nome da organização]', 8000)
            end
            
            exports.oxmysql:query(
                'UPDATE dm_ranks_pistol SET boostFarmTS = 0, wins = GREATEST(wins - 1, 0) WHERE org = ?',
                { organization }
            )
            
            TriggerClientEvent('Notify', source, 'sucesso', 'Farm da organização '..organization..' resetado com sucesso.', 8000)
        end,

        ['airdrop'] = function()
            local randomCoords = Config.airdrop.locations[math.random(1, #Config.airdrop.locations)]
            exports['nova_airdrop']:createCustomAirdrop(randomCoords, Config.airdrop.rewards)
        end,
    }

    if options[args[1]] then
        options[args[1]]()
    else
        TriggerClientEvent('Notify', source, 'negado', 'Use /dominacaopistol [orgreset ou restart] [se for orgreset nome da org]', 8000)
    end
end)

CreateThread(function()
    Wait(2000)
    exports.oxmysql:query([[
        CREATE TABLE IF NOT EXISTS `dm_ranks_pistol` (
            `org` varchar(100) NOT NULL,
            `orgType` varchar(100) DEFAULT NULL,
            `boostFarmTS` varchar(100) DEFAULT '0',
            `points` int(11) DEFAULT 0,
            `wins` int(11) DEFAULT 0,
            PRIMARY KEY (`org`),
            UNIQUE KEY `org` (`org`)
        )
    ]])
end)

CreateThread(function()
    GlobalState.GlobalDominationPistolColor = { 19, 0, 175 }

    while true do 
        local actualHour = tonumber(os.date('%H')) -- Obtendo a hora atual
        local actualMinute = tonumber(os.date('%M')) -- Obtendo o minuto atual
        if not (Config.requestInit[tostring(actualHour)] and (type(Config.requestInit[tostring(actualHour)]) == "number" and actualMinute <= Config.requestInit[tostring(actualHour)])) then
            goto continue
        end

        if not dominationPistol:checkStart() then 
            dominationPistol:start()
        end

        ::continue::
        
        Wait(60 * 1000)
    end
end)