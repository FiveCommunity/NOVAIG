------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function dominationPistol:updateKill(data)
    local attacker_id,attacker_source = vRP.getUserId(data.attacker),data.attacker
    if not attacker_id then return end

    local attacker_identity = vRP.getUserIdentity(attacker_id)
    if not attacker_identity then return end

    local victim_id,victim_source = vRP.getUserId(data.victim),data.victim
    if not victim_id then return end

    local victim_identity = vRP.getUserIdentity(victim_id)
    if not victim_identity then return end

    local _,attackerOrg = self:getGroupType(attacker_id)
    if not attackerOrg then return end

    local _,victimOrg = self:getGroupType(victim_id)
    if not victimOrg then return end

    if attackerOrg == victimOrg then return end

    if not self.list[attackerOrg] or not self.list[victimOrg] then return end

    -- ATUALIZANDO SCOREBOARD
    self.list[attackerOrg].kills += 1
    self.list[attackerOrg].points += Config.pointsPerKill
    self.list[victimOrg].deaths += 1

    if (data.attacker > 0) then

        -- SISTEMA DE KILL STREAK
        if not self.KillsTiming['all'] then self.KillsTiming['all'] = {} end

        if not self.KillsTiming['all'][attacker_id] then self.KillsTiming['all'][attacker_id] = 0 end
        self.KillsTiming['all'][attacker_id] += 1

        SetTimeout(20*1000, function() if self.KillsTiming['all'] then self.KillsTiming['all'][attacker_id] -= 1 end end)

        local attacker_source = vRP.getUserSource(attacker_id)
        if not attacker_source then return end

        vTunnel._updateKillStreak(attacker_source, self.KillsTiming['all'][attacker_id])
    end

    -- ATUALIZANDO CHATKILL
    for ply_id in pairs(self.playersInZone) do
        async(function()
            local ply_src = vRP.getUserSource(ply_id)
            if not ply_src then return end

            local ply_org = self.playersInZone[ply_id]
            TriggerClientEvent('dominacao_pistol:nui:killstreak', ply_src)
            vTunnel._syncKillFeed(ply_src, {
                killer = ('%s %s'):format(attacker_identity.nome, attacker_identity.sobrenome),
                victim = ('%s %s'):format(victim_identity.nome, victim_identity.sobrenome),
                weapon = data.weapon
            })

            if ply_org == attackerOrg then
                local totalMembers = 0
                for k, v in pairs(self.list) do
                    if v.totalMembers then
                        totalMembers = totalMembers + v.totalMembers
                    end
                end

                local totalPartners = self.list[ply_org].totalMembers
                vTunnel._updateOrgPoints(ply_src, true, (self.list[ply_org].points / Config.pointsMax) * 100 )
                local enemies = (totalMembers - totalPartners)..'/'..totalMembers
                local points = self.list[ply_org].points..'/'..Config.pointsMax
                TriggerClientEvent("update:dominationGeral", ply_src, 'Pistola', enemies, points, totalPartners)
            end
        end)
    end

    -- FEIJONTS
    for index in pairs(self.list) do
        local org = self.list[index]

        for ply_id, ply_org in pairs(self.playersInZone) do
            if ply_org == index then

                if self.list[plyOrg].points >= Config.pointsMax then
                    dominationPistol:winDomination(plyOrg)
                    break
                end

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
                        TriggerClientEvent("update:dominationGeral", ply_src, 'Pistola', enemies, points, totalPartners)
                    end
                end)
            end
        end

        -- self.list[#list + 1] = { 
        --     points = org.points or 0,
        --     name = index or "Indefinido",
        --     kills = org.kills or 0,
        --     deaths = org.deaths or 0,
        --     time = convertSecondsToMinute(os.time() - org.time) or 0
        -- }

    
    end
end

function dominationPistol:winDomination(plyOrg)

    local org = self.list[plyOrg]
    
    local currentTime = os.time()
    
    local boostDuration = Config.winDomination.timeBoostRunning * 60
    
    local boostFarmTS = currentTime + boostDuration

    exports.oxmysql:execute(
        [[
          INSERT INTO dm_ranks_pistol (org, orgType, wins, boostFarmTS) 
          VALUES (?, ?, ?, ?) 
          ON DUPLICATE KEY UPDATE 
            orgType = VALUES(orgType),
            wins = wins + 1,
            boostFarmTS = VALUES(boostFarmTS)
        ]],
        {
          plyOrg,
          org.orgType,
          1,
          tostring(boostFarmTS)
        }
    )

    self.list[plyOrg] = nil

    GlobalState.dominationPistolOwner = plyOrg

    CreateThread(function()
    
        local usersNotify = vRP.getUsersByPermission('perm.ilegal')
        for l,w in pairs(usersNotify) do
            local playerSource = vRP.getUserSource(parseInt(w))
            if playerSource then 
                TriggerClientEvent('notifyDomFinished', playerSource)
                TriggerClientEvent('chatMessage', playerSource, {
                    prefix = 'DOMINACAO PISTOLA:',
                    prefixColor = '#000',
                    title = 'DOMINACAO',
                    message = 'A ORGANIZAÇÃO '..string.upper(plyOrg)..' venceu a dominacao de pistola.'
                })
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

        local perm = 'perm.'..plyOrg:lower()
        local plys = vRP.getUsersByPermission(perm)
        for _,user_id in pairs(plys) do
            local src = vRP.getUserSource(user_id)
            if src then
                TriggerClientEvent("Notify", src, "aviso","Sua organização venceu a dominação e recebeu um bonus no farm.")
            end
        end

    end)

    self.list = {}
    GlobalState.GlobalDominationPistolColor = { 19, 0, 175 }
    self.running = false
    playersLeaveZone = {}
end

function dominationPistol:isBoostFarmActive(orgName)

    local row = exports.oxmysql:query_async(
        "SELECT boostFarmTS FROM dm_ranks_pistol WHERE org = ?",
        { orgName }
    )

    if row and next(row) then
        if not row[1].boostFarmTS then
            return false
        end

        local boostFarmTS = tonumber(row[1].boostFarmTS)

        return os.time() < boostFarmTS
    end

    return false
end

exports('isBoostDominationPistol', function (orgName)
    return dominationPistol:isBoostFarmActive(orgName)
end)

exports('statusDominationPistol', function()

    local function calculateTimeRemaining(hour, minutes)
        local currentHour = tonumber(os.date("%H"))
        local currentMinute = tonumber(os.date("%M"))

        local targetTotalMinutes = (hour * 60) + minutes
        local currentTotalMinutes = (currentHour * 60) + currentMinute

        local difference = targetTotalMinutes - currentTotalMinutes
        if difference < 0 then
            difference = difference + (24 * 60)
        end

        local hoursRemaining = math.floor(difference / 60)
        local minutesRemaining = difference % 60

        return difference, string.format("%dh %dmin", hoursRemaining, minutesRemaining)
    end

    local closestTime = nil
    local closestTimeString = nil

    for hour, minutes in pairs(Config.requestInit) do
        local timeDifference, timeString = calculateTimeRemaining(tonumber(hour), minutes)
        if not closestTime or timeDifference < closestTime then
            closestTime = timeDifference
            closestTimeString = timeString
        end
    end

    return GlobalState.dominationPistolOwner, closestTimeString
end)




function dominationPistol:updateMarker(data, source)
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local plyType,plyOrg = self:getGroupType(user_id)
    if not plyOrg then return end


    local pointsWin = 0
    local textChat = ''

    local oldOrg = self.markers[data.index]

    self.ZonesDominateds[data.marker.coords.label] = plyOrg

    if next(oldOrg) and oldOrg.dominadoBy ~= "Ninguem" and oldOrg.dominadoBy ~= plyOrg then
        if self.list[oldOrg.dominadoBy] then
            self.list[oldOrg.dominadoBy].points -= Config.pointsLostAfterLost
            if self.list[oldOrg.dominadoBy].points <= 0 then
                self.list[oldOrg.dominadoBy].points = 0
            end

            -- PONTOS QUE A FACÇÃO GANHA QUANDO DOMINA UMA ZONA JA DOMINADA
            if self.list[plyOrg] then
                self.list[plyOrg].points += Config.pointsPerMarkerDominated
                pointsWin = Config.pointsPerMarkerDominated
                textChat = 'A '..string.upper(plyOrg)..' capturou a zona dominada de '..string.upper(oldOrg.dominadoBy)..' e ganhou '..pointsWin..' pontos.'
            end
        end
    else
        -- PONTOS QUE A FACÇÃO GANHA QUANDO DOMINA UMA ZONA QUE NÃO ESTÁ DOMINADA
        if self.list[plyOrg] then
            self.list[plyOrg].points += Config.pointsPerMarkerNotDominated
            pointsWin = Config.pointsPerMarkerNotDominated
            textChat = 'A '..string.upper(plyOrg)..' capturou a zona '..string.upper(data.marker.coords.label)..' e ganhou '..pointsWin..' pontos.'
        end
    end

    self.markers[data.index].dominado = data.marker.dominado
    self.markers[data.index].dominadoBy = plyOrg
    self.markers[data.index].contestando = false


    local org = self.list[plyOrg]

    if self.list[plyOrg].points >= Config.pointsMax then
        dominationPistol:winDomination(plyOrg)
        return
    end

    for ply_id, ply_org in pairs(self.playersInZone) do
        async(function()
            local ply_src = vRP.getUserSource(ply_id)
            if ply_src then
                if textChat ~= '' then
                    TriggerClientEvent('chatMessage', ply_src, {
                        prefix = 'DOMINACAO PISTOLA:',
                        prefixColor = '#000',
                        title = 'DOMINACAO',
                        message = textChat
                    })
                end


                local totalMembers = 0
                for k, v in pairs(self.list) do
                    if v.totalMembers then
                        totalMembers = totalMembers + v.totalMembers
                    end
                end

                local totalPartners = self.list[ply_org].totalMembers
                vTunnel._updateOrgPoints(ply_src, true, (self.list[ply_org].points / Config.pointsMax) * 100 )
                local enemies = (totalMembers - totalPartners)..'/'..totalMembers
                local points = self.list[ply_org].points..'/'..Config.pointsMax
                TriggerClientEvent("update:dominationGeral", ply_src, 'Pistola', enemies, points, totalPartners)

                TriggerClientEvent('dom_pistol:updateMarkers', ply_src, self.markers)
                vTunnel._updateOrgPoints(ply_src, true, (self.list[ply_org].points / Config.pointsMax) * 100 )
            end
        end)
    end


end

function dominationPistol:zoneContesting(data)
    self.markers[data.index].contestando = true

    for ply_id, ply_org in pairs(self.playersInZone) do
        async(function()
            local ply_src = vRP.getUserSource(ply_id)
            if ply_src then
                TriggerClientEvent('dom_pistol:updateMarkers', ply_src, self.markers)
            end
        end)
    end
end

function dominationPistol:updateMarkerDominando(params, source)

    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local plyType,plyOrg = self:getGroupType(user_id)
    if not plyOrg then return end

    self.markers[params.index].dominando = params.status

    if not params.status then
        local orgsInZone = self.markers[params.index].orgsInZone

        local authorizedRemove = true

        for k, v in pairs(orgsInZone) do
            if v == plyOrg then
                authorizedRemove = false
                break
            end
        end

        if authorizedRemove then
            self.markers[params.index].dominando = false
        end
    end

    if self.markers[params.index].dominado then
        if self.markers[params.index].dominadoBy ~= plyOrg then
            if self.markers[params.index].dominando then
                self.markers[params.index].dominado = false
            end
        end
    else
        if not self.markers[params.index].dominando then
            if self.markers[params.index].dominadoBy ~= "Ninguem" then
                self.markers[params.index].dominado = true
            end
        end
    end

    for ply_id, ply_org in pairs(self.playersInZone) do
        async(function()
            local ply_src = vRP.getUserSource(ply_id)
            if ply_src then
                TriggerClientEvent('dom_pistol:updateMarkers', ply_src, self.markers)
            end
        end)
    end
end

function dominationPistol:changeUsersInZone(data, index, status, source)
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local plyType,plyOrg = self:getGroupType(user_id)
    if not plyOrg then return end

    if status then
        local authorizedInsert = true

        for k, v in pairs(self.markers[index].orgsInZone) do
            if v == plyOrg then
                authorizedInsert = false
                break
            end
        end

        if authorizedInsert then
            table.insert(self.markers[index].orgsInZone, plyOrg)
        end
    else
        for k, v in pairs(self.markers[index].orgsInZone) do
            if v == plyOrg then
                table.remove(self.markers[index].orgsInZone, k)
                break
            end
        end
    end

    for ply_id, ply_org in pairs(self.playersInZone) do
        async(function()
            local ply_src = vRP.getUserSource(ply_id)
            if ply_src then
                TriggerClientEvent('dom_pistol:updateMarkers', ply_src, self.markers)
            end
        end)
    end
end


function dominationPistol:validateOtherOrgInMarker(data, index, source)
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local plyType,plyOrg = self:getGroupType(user_id)
    if not plyOrg then return end

    if self.markers[index].dominadoBy == plyOrg then
        return false
    end

    local params = {
        marker = data,
        index = index
    }

    dominationPistol:zoneContesting(params, source)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.updateKill(data)
   return dominationPistol:updateKill(data)
end

function RegisterTunnel.updateMarker(data)
    local source = source
    return dominationPistol:updateMarker(data, source)
end

function RegisterTunnel.validateOtherOrgInMarker(data, index)
    local source = source
    return dominationPistol:validateOtherOrgInMarker(data, index, source)
end

function RegisterTunnel.changeUsersInZone(data, index, status)
    local source = source
    return dominationPistol:changeUsersInZone(data, index, status, source)
end

function RegisterTunnel.updateMarkerDominando(params)
    local source = source
    return dominationPistol:updateMarkerDominando(params, source)
end