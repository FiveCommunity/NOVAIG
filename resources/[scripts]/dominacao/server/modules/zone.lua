------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function domination:updateKill(data)
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
            TriggerClientEvent('dominacao:nui:killstreak', ply_src)
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
                TriggerClientEvent("update:dominationGeral", ply_src, 'Geral', enemies, points, totalPartners)
            end
        end)
    end

    -- FEIJONTS
    for index in pairs(self.list) do
        local org = self.list[index]

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

        -- self.list[#list + 1] = { 
        --     points = org.points or 0,
        --     name = index or "Indefinido",
        --     kills = org.kills or 0,
        --     deaths = org.deaths or 0,
        --     time = convertSecondsToMinute(os.time() - org.time) or 0
        -- }

        -- if self.list[index].points >= Config.pointsMax then
        --     for k, v in pairs(self.list) do
        --         local name = v.name 
        --         local points = v.points 
        --         exports.oxmysql:query("INSERT IGNORE INTO dm_ranks_geral(org, orgType, points) VALUES(@org, @orgType, @points) ON DUPLICATE KEY UPDATE points = points + @points",{ org = name, orgType = org.orgType, points = points })
        --     end
        --     self.list[index] = nil
        --     print('Organizacao Vencedora: '..list[1].name.. ' motivo: PONTUACAO.')

        --     GlobalState.dominationOwner = index

        --     local usersNotify = vRP.getUsersByPermission('perm.ilegal')
        --     for l,w in pairs(usersNotify) do
        --         local playerSource = vRP.getUserSource(parseInt(w))
        --         if playerSource then 
        --             TriggerClientEvent('notifyDomFinished', playerSource)
        --         end
        --     end

        --     for ply_id, ply_org in pairs(self.playersInZone) do
        --         async(function()
        --             local ply_src = vRP.getUserSource(ply_id)
        --             if ply_src then
        --                 vTunnel._updateOrgPoints(ply_src, false)
        --             end
        --         end)
        --     end

        --     self.list = {}
        --     self.running = false
        --     break
        -- end
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.updateKill(data)
   return domination:updateKill(data)
end