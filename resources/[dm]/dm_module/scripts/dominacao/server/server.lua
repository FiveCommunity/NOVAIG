------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QUERYS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("dm_ranks/UpdateRank", "INSERT IGNORE INTO dm_ranks(org, orgType, wins) VALUES(@org, @orgType, @wins) ON DUPLICATE KEY UPDATE wins = wins + @wins")
vRP.prepare("dm_ranks/TopRanks", "SELECT * FROM dm_ranks ORDER BY wins DESC")
vRP.prepare("dm_ranks/SelectRanks", "SELECT * FROM dm_ranks WHERE orgType = @orgType ORDER BY wins DESC")
vRP.prepare("dm_ranks/RankDominas", "SELECT * FROM dm_ranks ORDER BY generalwins DESC")

local playtimeCache = {}
local minIds = 15000
-- local notifiedPlayers = {}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
groups = module("cfg/groups").groups
local Domination = {
    Running = {
        --[1] = { user_id = 10, org = "Mafia01", orgType = 'Armas' },
    },

    Owners = {
        --[1] = "Mafia01" @@index = domination_id, @@value = orgName
    },

    PlayersZones = {
        --[1] = 1 @@index = user_id, @@value = domination_id
    },

    Cooldown = {
        --[1] = os.time() @@index = domination_id, @@value = time stamp 
    },

    KillsTiming = {
        -- [1] = { -- @@index == domination_id
        --     [1] = 5  -- @@index = user_id, value = kills_amount
        -- }
    },

    KillsInZone = {
        -- [1] = {
            --[1] = true,
        -- }
    }
}

local playersLeaveZone = {}
local dominationTable = {}

CreateThread(function()
    GlobalState.isDominationActive = true
    for i = 1, #DominationConfig.Zones do
        dominationTable[i] = 'available'
    end

    GlobalState.dominationsStatus = dominationTable
end)

RegisterCommand('desativardominas', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then 
        return 
    end

    if not vRP.hasPermission(userId, 'developer.permissao') and not vRP.hasPermission(userId, 'perm.respilegal') then 
        return 
    end

    GlobalState.isDominationActive = not GlobalState.isDominationActive
    if GlobalState.isDominationActive then 
        TriggerClientEvent('Notify', source, 'sucesso', 'Dominações ativadas.')
    else 
        TriggerClientEvent('Notify', source, 'negado', 'Dominações desativadas.')
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local minMembers = {
    ['fArmas'] = 1,
    ['fMunicao'] = 1
}

function Domination:RequestInit(source, user_id, data)
    if not GlobalState.isDominationActive then 
        return false, TriggerClientEvent("Notify",source,"negado","Dominações desativadas.",6000)
    end
    local plyType,plyOrg = Domination:GetGroupType(user_id)

    local DominationType = DominationConfig.Zones[data.id].name
    if DominationType ~= "fGeral" then
        if (not plyType or DominationType ~= plyType) then
            TriggerClientEvent("Notify",source,"negado","Você não possui permissão para dominar essa area.",6000)
            return false 
        end
    end

    if self.Running[data.id] then
        TriggerClientEvent("Notify",source,"negado","Está area já está em andamento, mate quem está dominando.",6000)
        return
    end

    if (self.Owners[data.id] == plyOrg) then -- VALIDAR SE BATE COM A ORG DELE
        TriggerClientEvent("Notify",source,"negado","Você já possui o controle dessa area.",6000)
        return
    end
 
    local permToInit = vRP.hasPermission(user_id,'perm.gerente'..plyOrg:lower()) or vRP.hasPermission(user_id,'perm.lider'..plyOrg:lower())
    if not permToInit then 
        return false, TriggerClientEvent("Notify",source,"negado","Você não possuí permissão para iniciar a dominação.",5)
    end

    if minMembers[plyType] then
        local perm = vRP.getUsersByPermission('perm.'..plyOrg:lower())

        if #perm < minMembers[plyType] then
            TriggerClientEvent("Notify",source,"negado","Você precisa de "..#perm.."/"..minMembers[plyType].." membro(s) online para conseguir puxar essa area..",6000)
            return
        end
    end

    if self.Cooldown[data.id] and self.Cooldown[data.id] - os.time() >= 0 then
        TriggerClientEvent("Notify",source,"negado","Aguarde ".. (self.Cooldown[data.id] - os.time()) .." segundo(s) para dominar esta area..",6000)
        return
    end
    self.Cooldown[data.id] = (os.time() + 10)

    TriggerClientEvent("Notify",source,"sucesso","Você iniciou a dominação nessa area.",6000)

    Domination:Init(data.id, { user_id = user_id, source = source, org = plyOrg, orgType = plyType })
    vRP.sendLog("https://discord.com/api/webhooks/1334944410252742707/4ZjsO5dobME8IU2SJwgrASVhDSSvJBzKjss2kfT7__MRC7lj7Rr8yd4aMYATTxA4ykYw", "```Passaporte : "..user_id.." iniciou a dominação de "..plyType.." ```")
    vTunnel.showEmblem(source, plyType,true)
    CreateThread(function()      
        local users = vRP.getUsersByPermission('perm.ilegal')
        for l,w in pairs(users) do
            local player = vRP.getUserSource(parseInt(w))
            if player  ~= source then
                vTunnel.showEmblem(player, plyType,true)
            end
        end
    end)
    return true
end

CreateThread(function()
    Wait(5000)
    while true do
        for zoneId, status in pairs(dominationTable) do
            if status ~=  'available' then
                if not Domination.Running[zoneId] then
                    if Domination.Cooldown[zoneId] and Domination.Cooldown[zoneId] - os.time() < 0 then
                        dominationTable[zoneId] = 'available'
                        GlobalState.dominationsStatus = dominationTable
                    end
                end
            end
        end
        Wait(1000)
    end
end)

local function enemysInZone(zoneId, plyOrg)
    local enemysTotal = 0
    for k, v in pairs(Domination.PlayersZones) do 
        if v == zoneId then 
            local plyType, nearestOrg = Domination:GetGroupType(k)
            if plyOrg ~= nearestOrg then 
                enemysTotal = enemysTotal + 1
            end
        end
    end
    return enemysTotal
end

function Domination:transferOwnership(zoneId, userId)
    local nSource = vRP.getUserSource(userId)
    if not nSource then 
        self:Cancel(zoneId, "[DOMINACAO] A zona de conflito foi controlada, um dos invasores fugiram.")
        return 
    end

    local plyType, plyOrg = Domination:GetGroupType(userId)
    if not plyType or not plyOrg then 
        self:Cancel(zoneId, "[DOMINACAO] A zona de conflito foi controlada, um dos invasores fugiram.")
        return 
    end

    if self.Running[zoneId] then
        self.Running[zoneId].user_id = userId
        self.Running[zoneId].org = plyOrg
        self.Running[zoneId].orgType = plyType
        TriggerClientEvent('Notify', nSource, 'sucesso', 'Você tomou o controle da zona de dominação.')
    end

    for ply_id,zone_id in pairs(Domination.PlayersZones) do
        async(function()
            local plySrc = vRP.getUserSource(ply_id)
            if not plySrc then return end

            if (zone_id == zoneId) then
                vTunnel._updateDomination(plySrc, zoneId, true, false, nSource)
            end
        end)
    end
    
    vTunnel._updateDomination(-1, zoneId, true, false, nSource)
    vTunnel.updateTimer(-1, nSource, zoneId, self.Running[zoneId].counter)
    print("Transferindo controle da zona de dominação "..zoneId.." para "..plyOrg)
end

function Domination:Init(zone_id, ply)
    if not GlobalState.isDominationActive then 
        return false, TriggerClientEvent("Notify",ply.source,"negado","Dominações desativadas.",6000)
    end
    self.Running[zone_id] = { user_id = ply.user_id, org = ply.org, orgType = ply.orgType }
    dominationTable[zone_id] = 'running'
    GlobalState.dominationsStatus = dominationTable

    CreateThread(function()
        local zone_id = zone_id
        -- local counter = (DominationConfig.Zones[zone_id].time * 60)
        self.Running[zone_id].counter = (DominationConfig.Zones[zone_id].time * 60)

        while self.Running[zone_id] do
            self.Running[zone_id].counter -= 1

            local plyId = self.Running[zone_id].user_id
            local plySrc = vRP.getUserSource(plyId)

            local plyPed = GetPlayerPed(plySrc) 
            if (plyPed == 0) then
                self:Cancel(zone_id, "[DOMINACAO] A zona de conflito foi controlada, um dos invasores fugiram.")
                return
            end

            -- local plyHealth = GetEntityHealth(plyPed)
            -- if plyHealth <= 101 then
            --     self:Cancel(zone_id, "[DOMINACAO] A zona de conflito foi controlada, um dos invasores morreu.")
            --     return
            -- end

            if self.Running[zone_id].counter <= 0 then
                self:Finish(zone_id, self.Running[zone_id])
                return
            end

            Wait( 1000 )
        end
    end)

    Citizen.CreateThread(function()
        local zone_id = zone_id
        local zoneConfig = DominationConfig.Zones[zone_id]
        local zoneName = zoneConfig.name and DominationConfig.FormatNames[zoneConfig.name]
        
        while self.Running[zone_id] do
            local attackerZone = self.Running[zone_id].org
            if next(self.PlayersZones) then 
                local playersInZone = {}
                for userId, domination_id in pairs(self.PlayersZones) do 
                    if domination_id == zone_id then 
                        table.insert(playersInZone, userId)
                    end
                end
    
                for _, userId in ipairs(playersInZone) do
                    local playerSource = vRP.getUserSource(tonumber(userId))
                    if playerSource then 
                        local totalPartners = 0
                        local plyType, plyOrg = Domination:GetGroupType(userId)
                        if plyType and plyOrg then
                            local membersOnline = vRP.getUsersByPermission("perm."..plyOrg:lower())
        
                            for _, memberId in pairs(membersOnline) do 
                                if self.PlayersZones[memberId] == zone_id then 
                                    local Source = vRP.getUserSource(tonumber(memberId))
                                    if Source and GetEntityHealth(GetPlayerPed(Source)) > 101 then 
                                        totalPartners = totalPartners + 1
                                    end
                                end
                            end
                            
                            TriggerClientEvent("update:domination", playerSource, zoneName, enemysInZone(zone_id, plyOrg), attackerZone, totalPartners)
                        end
                    end
                end
            end

            Wait(1000)
        end
    end)

    Domination:AlertMessages("[DOMINACAO] Uma zona de conflito esta sendo dominada nesse momento.")
    vTunnel._updateDomination(-1, zone_id, true, false, ply.source)
end

function Domination:Cancel(zone_id, reason)
    self.Running[zone_id] = nil
    self.KillsTiming[zone_id] = nil

    if playersLeaveZone[zone_id] then
        playersLeaveZone[zone_id] = nil
    end

    Domination:AlertMessages(reason)
    dominationTable[zone_id] = 'available'
    GlobalState.dominationsStatus = dominationTable

    if type(zone_id) == 'table' then
        return
    end
    vTunnel._updateDomination(-1, zone_id, nil)
    -- notifiedPlayers[zone_id] = nil
end

function Domination:Finish(zone_id, ply)
    -- GIVAR DROGAS
    if DominationConfig.Zones[zone_id].reward then
        DominationConfig.Zones[zone_id].reward(ply.user_id)
    end

    if playersLeaveZone[zone_id] then
        playersLeaveZone[zone_id] = nil
    end

    dominationTable[zone_id] = 'dominated'
    GlobalState.dominationsStatus = dominationTable

    -- RESETANDO / ATUALIZANDO VARIAVEIS
    self.Running[zone_id] = nil
    self.KillsTiming[zone_id] = nil
    self.Owners[zone_id] = ply.org
    self.Cooldown[zone_id] = (os.time() + DominationConfig.Zones[zone_id].cooldown * 60)
    -- notifiedPlayers[zone_id] = nil
    -- ANUNCIANDO VENCEDOR
    exports.oxmysql:execute('INSERT INTO dm_ranks(org, orgType, wins) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE wins = wins + 1', { ply.org, DominationConfig.FormatNames[ply.orgType], 1 })
    Domination:AlertMessages(("[DOMINACAO] Organização %s venceu a dominação."):format(ply.org))
    local nSource = vRP.getUserSource(ply.user_id)
    local userCoords = GetEntityCoords(GetPlayerPed(nSource))
    local userOrg = vRP.getUserGroupOrg(ply.user_id)
    vRP.sendLog('https://discord.com/api/webhooks/1344064409835667528/-xOAhAD3AZ1f_uzD46fhHJ571mYkpW6TrdT7jr07oDl8i1iXDXGIJGUCkpMmDnBOZ9TH', 
    '```Passaporte: '..ply.user_id..'\nDominacao: '..ply.org..'\nCoordenadas: '..userCoords.x..', '..userCoords.y..', '..userCoords.z..'\nOrg do usuário: '..userOrg..'```')
    
    
    -- DESLIGANDO DOMINACAO DO CLIENTE
    if type(zone_id) == 'table' then
        return
    end

    vTunnel._updateDomination(-1, zone_id, nil, ply.org)

    -- SISTEMA DE RANKS
    -- vRP.execute("dm_ranks/UpdateRank", { org = ply.org, orgType = DominationConfig.FormatNames[ply.orgType], wins = 1 })

    -- ATUALIZAR NO BANCO DE DADOS
    if DominationConfig.saveDB then
        local data = vRP.getSData("dm_dominacao", {})
        local result = json.decode(data) or {}
        if data then
            result[tostring(zone_id)] = { zone = DominationConfig.Zones[zone_id].name, org = ply.org }
            vRP.setSData("dm_dominacao", json.encode(result))
        end
    end

    -- AVISAR MEMBROS DA ORGANIZACAO
    local perm = 'perm.'..ply.org:lower()
    local plys = vRP.getUsersByPermission(perm)
    for _,user_id in pairs(plys) do
        local src = vRP.getUserSource(user_id)
        if src then
            TriggerClientEvent("Notify", src, "aviso","Sua organização venceu a dominação e recebeu um bonus no farm.")
        end
    end

end

function Domination:GetGroupType(user_id)
    local plyGroup = vRP.getUserGroupByType(user_id, "org")
    if plyGroup == "" and not groups[plyGroup] then return false end
    
    return (groups[plyGroup]._config and groups[plyGroup]._config.orgType or false), (groups[plyGroup]._config and groups[plyGroup]._config.orgName or false)
end
exports('GetGroupType', function(user_id)
    local plyGroup = vRP.getUserGroupByType(user_id, 'org')
    if plyGroup == '' and not groups[plyGroup] then
        return false
    end

    return (groups[plyGroup]._config and groups[plyGroup]._config.orgType or false), (groups[plyGroup]._config and
        groups[plyGroup]._config.orgName or
        false)
end)
function Domination:EnterArea(user_id, domination_id)
    self.PlayersZones[user_id] = domination_id
    if not vRP.hasPermission(user_id, 'developer.permissao') and not vRP.hasGroup(user_id, 'respilegallotusgroup@445') and not vRP.hasGroup(user_id, 'gestaolotusgroup@445') then
        if Domination.Running[domination_id] and playersLeaveZone[domination_id] and playersLeaveZone[domination_id][user_id] then
            TriggerClientEvent('Notify', vRP.getUserSource(user_id), 'aviso', 'Você já saiu e não pode entrar novamente.')
            Wait(1000)
            vRPclient._setHealth(vRP.getUserSource(user_id), 0)
            SetTimeout(1000, function()
                vRPclient._killComa(vRP.getUserSource(user_id))
            end)
        end
    end

    -- if Domination.Running[domination_id] and notifiedPlayers[domination_id] and notifiedPlayers[domination_id][user_id] then
    --     CreateThread(function()
    --         while self.PlayersZones[user_id] and Domination.Running[domination_id] do
    --             TriggerClientEvent('Notify', vRP.getUserSource(user_id), 'aviso', 'Você já saiu e não pode entrar novamente, tem '..notifiedPlayers[domination_id][user_id]..' segundos para entrar novamente.')
    --             Wait(1000)
    --             if self.PlayersZones[user_id] then
    --                 notifiedPlayers[domination_id][user_id] = notifiedPlayers[domination_id][user_id] - 1
    --             end
    --             if notifiedPlayers[domination_id][user_id] <= 0 then
    --                 notifiedPlayers[domination_id][user_id] = nil
    --                 vRPclient._setHealth(vRP.getUserSource(user_id), 0)
    --                 SetTimeout(1000, function()
    --                     vRPclient._killComa(vRP.getUserSource(user_id))
    --                 end)
    --                 break
    --             end
    --         end
    --     end)
    -- end
end

function Domination:LeaveArea(user_id, domination_id)
    -- SetPlayerRoutingBucket(vRP.getUserSource(user_id), 0)
    self.PlayersZones[user_id] = nil
    if Domination.Running[domination_id] then
        if not playersLeaveZone[domination_id] then
            playersLeaveZone[domination_id] = {}
        end
        playersLeaveZone[domination_id][user_id] = true
    end
    -- if Domination.Running[domination_id] and not notifiedPlayers[domination_id] then
    --     if not notifiedPlayers[domination_id] then
    --         notifiedPlayers[domination_id] = {}
    --     end
    --     notifiedPlayers[domination_id][user_id] = 10
    -- end
end

function Domination:AlertMessages(message)
    if type(message) == 'table' then
        return
    end

    TriggerClientEvent('chatMessage', -1, {
        prefix = 'Dominação',
        prefixColor = '#000',
        title = 'AVISO',
        message = message
    })    
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterTunnel.RequestInit = function(data)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    return Domination:RequestInit(source, user_id, data)
end

local AlertTimer = {}
RegisterTunnel.EnterZone = function(domination_id, running)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local userOrg = vRP.getUserGroupOrg(user_id)
    if userOrg and userOrg ~= '' and exports.vrp_admin:isOrgBlocked(userOrg) then
        TriggerClientEvent('Notify', source, 'negado', 'Sua facção está bloqueada por 12 horas de entrar em qualquer dominacao')
        Wait(1000)
        vRPclient.setHealth(source, 101)
        return
    end
    
    if not userOrg or (userOrg == '' or not vRP.hasPermission(user_id, 'perm.ilegal')) then
        TriggerClientEvent('Notify', source, 'negado', 'Você não pertence ao ilegal, portando não pode entrar nessa zona')
        Wait(1000)
        vRPclient.setHealth(source, 101)
        return
    end

    if userOrg == GlobalState.dominationOwner then
        TriggerClientEvent('Notify', source, 'negado', 'Você já dominou a dominação geral.')
        Wait(1000)
        vRPclient.setHealth(source, 101)
        return
    end

    Domination:EnterArea(user_id, domination_id)
    vTunnel.showEmblem(source, nil,true)
    -- SetPlayerRoutingBucket(source, 10)

    if not hasPlayedHours(user_id) then
        TriggerClientEvent("Notify", source, "negado", "Você precisa de 2 horas jogadas para participar de uma dominação.")

        if not AlertTimer[user_id] then
            AlertTimer[user_id] = 10
        end

        CreateThread(function()
            while AlertTimer[user_id] > 0 do
                TriggerClientEvent('Notify', source, 'negado', "Saia imediatamente dessa área, caso contrário você vai morrer em " .. AlertTimer[user_id] .. " segundo(s).")

                if not Domination.PlayersZones[user_id] then
                    return
                end

                Wait(2000)
                AlertTimer[user_id] = AlertTimer[user_id] - 2
            end

            if AlertTimer[user_id] <= 0 then
                vRPclient.setHealth(source, 101)
            end
        end)

        return false
    end

    if Domination.KillsInZone[domination_id] and Domination.KillsInZone[domination_id][user_id] then
        if (Domination.KillsInZone[domination_id][user_id] - os.time()) > 0 then
            local time = (Domination.KillsInZone[domination_id][user_id] - os.time())
            TriggerClientEvent('Notify', source, 'negado', "Aguarde " .. math.floor((time / 3600)) .. "h:" .. math.floor((time / 60) % 60) .. "m:" .. (time % 60) .. "s" .. " segundo(s) para ter acesso a esse local novamente.")

            CreateThread(function()
                while Domination.PlayersZones[user_id] do
                    if not AlertTimer[user_id] then
                        AlertTimer[user_id] = 10
                    end

                    TriggerClientEvent('Notify', source, 'negado', "Saia Imediatamente dessa área, caso contrário você vai morrer em " .. AlertTimer[user_id] .. " segundo(s).")

                    if AlertTimer[user_id] <= 0 then
                        AlertTimer[user_id] = nil
                        vRPclient._setHealth(source, 101)
                    end

                    if AlertTimer[user_id] then
                        AlertTimer[user_id] = AlertTimer[user_id] - 2
                    end

                    Wait(2000)
                end
            end)

        else
            if Domination.KillsInZone[domination_id] and Domination.KillsInZone[domination_id][user_id] then
                Domination.KillsInZone[domination_id][user_id] = nil
                AlertTimer[user_id] = nil
            end
        end
    end
end

RegisterCommand('resetkills', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then 
        return 
    end

    if not vRP.hasPermission(userId, 'developer.permissao') and not vRP.hasGroup(userId, 'respilegallotusgroup@445') and not vRP.hasGroup(userId, 'gestaolotusgroup@445') then 
        return 
    end

    if not args[1] then 
        return 
    end

    local zoneType = args[1]
    local zoneIndex = nil
    for index, zone in pairs(DominationConfig.Zones) do 
        if zone.name == zoneType then 
            zoneIndex = index
            break
        end
    end

    if not zoneIndex then 
        return 
    end
    
    Domination.KillsInZone[zoneIndex] = {}
    AlertTimer = {}
    playersLeaveZone[zoneIndex] = nil
    
    TriggerClientEvent('Notify', source, 'sucesso', "Todas as mortes e restrições da zona "..zoneType.." foram resetadas.")
    vRP.sendLog('https://discord.com/api/webhooks/1315131739001327686/mG-RCmh3EtRNSx4Rpi87JTeR6229wNcA3WEd7v-a-nV9lDzD5LvElzY6fmqXGu6kGmFH', '```prolog\n[ID]: ' .. userId .. '\n[RESETOU DOMINACAO]: '..zoneType..'\n[DATA]: ' .. os.date('%d/%m/%Y %H:%M:%S') .. '```')
end)

RegisterTunnel.LeaveZone = function(domination_id)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    Domination:LeaveArea(user_id, domination_id)
end

RegisterTunnel.CancelDomination = function(domination_id)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end
    if not domination_id or domination_id == 0 then return end
    if Domination.Running[domination_id] then
        print('Cancelando a dominacao', json.encode(Domination.Running[domination_id], { indent = true }))
    end
    
    if Domination.Running[domination_id] and Domination.Running[domination_id].user_id and Domination.Running[domination_id].user_id == user_id then 
        Domination:Cancel(domination_id, "[DOMINACAO] A Zona de conflito foi controlada, um dos invasores fugiram.")
    end
end

RegisterTunnel.SendKillFeed = function(data)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end
    if data.zone and not Domination.Running[data.zone] then return end

    local t = {}
    local videntity = vRP.getUserIdentity(user_id)

    t.victim = videntity.nome.. ' '..videntity.sobrenome
    t.weapon = data.weapon
    t.killer = 0

    local dominationOwnerId = Domination.Running[data.zone].user_id

    if (data.attacker > 0) then
        local kuser_id = vRP.getUserId(data.attacker)
        local kidentity = vRP.getUserIdentity(kuser_id)

        t.killer = kidentity.nome.. ' '..kidentity.sobrenome 

        -- SISTEMA DE KILL STREAK
        if not Domination.KillsTiming[data.zone] then Domination.KillsTiming[data.zone] = {} end

        if not Domination.KillsTiming[data.zone][kuser_id] then Domination.KillsTiming[data.zone][kuser_id] = 0 end
        Domination.KillsTiming[data.zone][kuser_id] += 1

        SetTimeout(20*1000, function() if Domination.KillsTiming[data.zone] then Domination.KillsTiming[data.zone][kuser_id] -= 1 end end)

        local ksource = vRP.getUserSource(kuser_id)
        if not ksource then return end

        vTunnel._updateKillStreak(ksource, Domination.KillsTiming[data.zone][kuser_id])

        if (dominationOwnerId == user_id) then
            Domination:transferOwnership(data.zone, kuser_id)
        end
    else
        if (dominationOwnerId == user_id) then
            Domination:Cancel(data.zone, "[DOMINACAO] A Zona de conflito foi controlada, um dos invasores morreu.")
        end
    end

    if not Domination.KillsInZone[data.zone] then Domination.KillsInZone[data.zone] = {} end
    Domination.KillsInZone[data.zone][user_id] = (os.time() + DominationConfig.delayDeath * 60)
    for ply_id,zone_id in pairs(Domination.PlayersZones) do
        async(function()
            local plySrc = vRP.getUserSource(ply_id)
            if not plySrc then return end

            if (zone_id == data.zone) then
                vTunnel._syncDeath(plySrc, t)
            end
        end)
    end
end

RegisterTunnel.TopRanks = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local query = vRP.query('dm_ranks/TopRanks', {})
    
    local topRanks = {}
    local listRanks = {}
    for i = 1, #query do
        if #topRanks < 3 then
            topRanks[i] = { org = query[i].org, orgType = query[i].orgType, wins = query[i].wins, position = i } 
        end

        if i >= 4 then
            listRanks[i] = { org = query[i].org, orgType = query[i].orgType, wins = query[i].wins, position = i } 
        end
    end

    return {topRanks,listRanks}
end

RegisterTunnel.getRank = function(orgType)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end


    if orgType == "DominasGeral" then
        local query = vRP.query('dm_ranks/RankDominas', {})
        local listRanks = {}
        for i = 1, #query do
            listRanks[i] = { org = query[i].org, orgType = query[i].orgType, wins = query[i].generalwins, position = i } 
        end
    
        return listRanks
    else 
        local query = vRP.query('dm_ranks/SelectRanks', { orgType = orgType })
        local listRanks = {}
        for i = 1, #query do
            listRanks[i] = { org = query[i].org, orgType = query[i].orgType, wins = query[i].wins, position = i } 
        end
    
        return listRanks
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CREATE MODE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.SendZone(zone)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local FormatZones = ""

        for i = 1, #zone do
            if i == #zone then
                FormatZones = FormatZones.. "    vec3("..tD(zone[i].x)..","..tD(zone[i].y)..","..tD(zone[i].z)..")"
            else
                FormatZones = FormatZones.. "    vec3("..tD(zone[i].x)..","..tD(zone[i].y)..","..tD(zone[i].z).."),\n"
            end
        end

        vRPclient.prompt(source, "Copie sua zona: ", "coordsZone = { -- CORDENADAS DA ZONA DE DOMINAÇÃO ( LIGUE OS PONTOS EM LINHA RETAS SEM CRUZAR )\n"..FormatZones.."\n},")
    end
end

RegisterCommand('create_zone', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "admin.permissao") then
            vTunnel._openCreateMode(source)
        end
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    local data = vRP.getSData("dm_dominacao", {})
    local result = json.decode(data) or {}
    if data then
        for index,v in pairs(result) do
            index = parseInt(index)

            Domination.Owners[index] = v.org
        end
    end

    SetTimeout(2000,function()
        vTunnel._syncBlipsDomination(-1, Domination.Owners)
    end)
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HANDLERS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function loadPlaytime(user_id)
    local result = exports.oxmysql:executeSync('SELECT playtime FROM player_playtime WHERE user_id = ?', {user_id})
    if result and #result > 0 then
        return result[1].playtime
    else
        exports.oxmysql:execute('INSERT INTO player_playtime (user_id, playtime) VALUES (?, ?)', {user_id, 0})
        return 0
    end
end

local function savePlaytime(user_id, playtime)
    exports.oxmysql:execute('UPDATE player_playtime SET playtime = ? WHERE user_id = ?', {playtime, user_id})
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    if user_id then
        vTunnel._syncBlipsDomination(source, Domination.Owners)

        for index in pairs(Domination.Running) do
            vTunnel._updateDomination(source, index, true, false, (vRP.getUserSource(Domination.Running[index].user_id) or 0) )
        end

        if user_id > minIds then
            playtimeCache[user_id] = {
                startTime = os.time(),
                playtime = loadPlaytime(user_id)
            }
        end
    end
end)

AddEventHandler("vRP:playerLeave",function(user_id,source)
    for index,v in pairs(Domination.Running) do
        if v.user_id == user_id then
            Domination:Cancel(index, "[DOMINACAO] A zona de conflito foi controlada, um dos invasores fugiram.")
        end
    end

    if user_id > minIds and playtimeCache[user_id] then
        local sessionTime = os.time() - playtimeCache[user_id].startTime
        local totalTime = playtimeCache[user_id].playtime + sessionTime
        savePlaytime(user_id, totalTime)
        playtimeCache[user_id] = nil
    end
end)

function hasPlayedHours(user_id)
    if user_id < minIds then
        return true
    end

    if playtimeCache[user_id] then
        local sessionTime = os.time() - playtimeCache[user_id].startTime
        local totalTime = playtimeCache[user_id].playtime + sessionTime
        return totalTime >= 86400
    else
        playtimeCache[user_id] = {
            startTime = os.time(),
            playtime = loadPlaytime(user_id)
        }

        return playtimeCache[user_id].playtime >= 86400
    end

    return false
end

exports('hasPlayedHours', hasPlayedHours)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OTHERS COMMANDS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dominacao', function(source,args)
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local formatMessage = ""

   
    for zone_id in pairs(DominationConfig.Zones) do
        local OwnerZone = "Ninguem"
        if Domination.Owners[zone_id] then
            OwnerZone = Domination.Owners[zone_id]
        end

        local AvaliableZone = "Disponivel"
        if Domination.Cooldown[zone_id] then
            local time = (Domination.Cooldown[zone_id] - os.time())
            if time > 0 then
                AvaliableZone = math.floor((time / 3600)).."h:".. math.floor((time / 60) % 60) .."m:"..(time % 60).."s"
            else
                AvaliableZone = "Disponivel"
            end
        end
    
        formatMessage = formatMessage.. "Zona: "..DominationConfig.FormatNames[DominationConfig.Zones[zone_id].name].. "<br>Dono: "..OwnerZone.. "<br>Status: "..AvaliableZone.." <br><br>"
    end


    formatMessage = formatMessage.. "Zona: Geral<br>Dono: "..GlobalState.dominationOwner.. "<br>Status: "..(GlobalState.dominationOwner and "Vencida" or "Disponivel").." <br><br>"

    local ownerDomination, timeReaming = exports['nova_dominacao_pistol']:statusDominationPistol()

    formatMessage = formatMessage .. "Zona: Pistola<br>Dono: "..ownerDomination .. "<br>Status: ".. timeReaming .. "<br><br>"

    TriggerClientEvent("Notify",source,"importante","Lista das Zonas: <br><br>"..formatMessage, 15)
end)


RegisterCommand('resetardominacao', function(source,args)
    local user_id = vRP.getUserId(source)
    
    if not user_id then return end
    if not vRP.hasPermission(user_id, 'admin.permissao') then return end

    local formatText = ""
    local zones = {}
    for index in pairs(DominationConfig.Zones) do
        local zone = DominationConfig.Zones[index]

        formatText = ('%s,'):format(zone.name).. formatText
        zones[zone.name] = index
    end

    local prompt = vRP.prompt(source, 'Escolha a Dominação que deseja resetar!', formatText)
    if prompt == "" or not prompt or not zones[prompt] then
        return
    end
    
    local zone_id = zones[prompt]
    Domination.Owners[zone_id] = nil
    Domination.Cooldown[zone_id] = 0
    Domination.PlayersZones = {}

    dominationTable[zone_id] = 'available'
    GlobalState.dominationsStatus = dominationTable

    vTunnel._syncBlipDomination(-1, zone_id)
    TriggerClientEvent('Notify',source,'sucesso','Você resetou essa zona de dominação.')

    local data = vRP.getSData("dm_dominacao", {})
    local result = json.decode(data) or {}
    if data then
        result[tostring(zone_id)] = nil

        vRP.setSData("dm_dominacao", json.encode(result))
    end

    vRP.sendLog('https://discord.com/api/webhooks/1345130607658926130/C7nEvduVtEHXXKReWSXaEEW1hMB8VcDQMH4s-TH9qygspUDAFhXP-KRski3Gw0iaMrXp', '```prolog\n[ID]: ' .. userId .. '\n[RESETOU DOMINACAO]: '..zoneType..'\n[DATA]: ' .. os.date('%d/%m/%Y %H:%M:%S') .. '```')
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
exports('GetUserDomination', function(user_id)
    local orgType, orgName = Domination:GetGroupType(user_id)
    if not orgName or not orgType then return end

    local orgDominationData = { orgName = orgName, orgType = orgType, zones = {} }
    local zoneFound = false

    for index in pairs(Domination.Owners) do
        local dominedOrg = Domination.Owners[index]
        if dominedOrg == orgName then
            zoneFound = true
            local zoneData = { zone = DominationConfig.FormatNames[DominationConfig.Zones[index].name] or DominationConfig.Zones[index].name, orgName = orgName, orgType = orgType }
            table.insert(orgDominationData.zones, zoneData)
        end
    end

    if zoneFound then
        return orgDominationData
    else
        return nil
    end
end)

GlobalState.Dominations = true 
RegisterCommand("sdominacao", function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    if vRP.hasPermission(user_id,"developer.permissao") or vRP.hasGroup(user_id, "TOP1") then 
        GlobalState.Dominations = not GlobalState.Dominations 
        if not GlobalState.Dominations then 
            TriggerClientEvent("Notify",-1,"negado","Dominações Desativadas",5)
        else
            TriggerClientEvent("Notify",-1,"negado","Dominações Ativadas",5)
        end
    end
end)

CreateThread(function()
    exports.oxmysql:execute('CREATE TABLE IF NOT EXISTS player_playtime (user_id INT UNIQUE, playtime INT NOT NULL DEFAULT 0)')
end)