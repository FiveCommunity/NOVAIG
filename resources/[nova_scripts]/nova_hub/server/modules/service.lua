StaffsInService = {}

local serviceGroup = { 
    { ['inService'] = "adminlotusgroup@445", ['offService'] = "adminofflotusgroup@445", ["inDistance"] = true },
    { ['inService'] = "developerlotusgroup@445", ['offService'] = "developerofflotusgroup@445", ["inDistance"] = true },
    { ['inService'] = "moderadorlotusgroup@445", ['offService'] = "moderadorofflotusgroup@445", ["inDistance"] = true },
    { ['inService'] = "suportelotusgroup@445", ['offService'] = "suporteofflotusgroup@445", ["inDistance"] = true },
    { ['inService'] = "respilegallotusgroup@445", ['offService'] = "respilegalofflotusgroup@445", ["inDistance"] = true },
    { ['inService'] = "resploglotusgroup@445", ['offService'] = "resplogofflotusgroup@445", ["inDistance"] = true },
    { ['inService'] = "respeventoslotusgroup@445", ['offService'] = "respeventosofflotusgroup@445", ["inDistance"] = true },
    { ['inService'] = "resppolicialotusgroup@445", ['offService'] = "resppoliciaofflotusgroup@445", ["inDistance"] = true },
    { ['inService'] = "ajudantelotusgroup@445", ['offService'] = "ajudanteofflotusgroup@445", ["inDistance"] = true },
    { ['inService'] = "respstreamerlotusgroup@445", ['offService'] = "respstreamerofflotusgroup@445", ["inDistance"] = true },
}

local centerRadius = vec3(-535.8,-223.7,37.64)
local rangeDistance = 50

local permsIgnoreAddGroup = {
    { permType = 'group', perm = 'TOP1' },
    { permType = 'group', perm = 'developerlotusgroup@445' },
    { permType = 'perm', perm = 'developer.permissao' },
}

local logsURL = {
    ['JoinService'] = '',
    ['LeaveService'] = ''
}

local logsFormated = {
    ['joinService'] = function(serviceParam, user_id, identity)
        return  "```css\n** BATER PONTO **\n" .. os.date("[%d/%m/%Y as %X]") .. " [" ..
            string.upper(serviceParam.inService) .. "] O(a) [" .. identity.nome .. " " .. identity.sobrenome ..
            " (" .. user_id .. ")] acabou de entrar em expediente.```"
    end,
    ['leaveService'] = function(serviceParam, user_id, identity)
        if not serviceParam then
            return
        end
        return "```css\n** BATER PONTO **\n" .. os.date("[%d/%m/%Y as %X]") .. " [" ..
            string.upper(serviceParam.inService) .. "] O(a) [" .. identity.nome .. " " .. identity.sobrenome ..
            " (" .. user_id .. ")] acabou de sair em expediente.```"
    end
}

function Server.ignoreExpPermission(user_id)
    local hasPermission = false
    for _, perm in ipairs(permsIgnoreAddGroup) do
        if perm.permType == 'perm' then
            if vRP.hasPermission(user_id, perm.perm) then
                hasPermission = true
                break
            end
        elseif perm.permType == 'group' then
            if vRP.hasGroup(user_id, perm.perm) then
                hasPermission = true
                break
            end
        end
    end
    return hasPermission
end

RegisterCommand('exp', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    local hasPerm = false
    for k, v in pairs(serviceGroup) do
        if vRP.hasGroup(user_id, v.inService) or vRP.hasGroup(user_id, v.offService) then
            hasPerm = true
            break
        end
    end

    for k, v in pairs(permsIgnoreAddGroup) do
        if v.permType == 'perm' then
            if vRP.hasPermission(user_id, v.perm) then
                hasPerm = true
                break
            end
        elseif v.permType == 'group' then
            if vRP.hasGroup(user_id, v.perm) then
                hasPerm = true
                break
            end
        end
    end

    if not hasPerm then
        return
    end
    
    local userName = identity.nome .. " " .. identity.sobrenome

    local function CreateRankingUser()
        if not Ranking["god"] then
            Ranking["god"] = {}
        end

        if not Ranking["god"][user_id] then
            Ranking["god"][user_id] = {
                name = userName,
                calls = 0,
                hours = 0,
                stars = 0,
                totalstars = 0,
                service = "god",
                notification = true,
            }

            vRP.execute("lotus_hub/createRanking", {
                user_id = user_id,
                name = userName,
                calls = 0,
                hours = 0,
                stars = 0,
                totalstars = 0,
                service = "god",
            })
        end
    end

    if user_id then
        local action = args[1]
        for k, serviceParam in pairs(serviceGroup) do
            local actions = {
                ['entrar'] = function()
                    if (vRP.hasGroup(user_id, serviceParam.offService) or vRP.hasGroup(user_id, serviceParam.inService)) and not StaffsInService[user_id] then

                        if not Server.ignoreExpPermission(user_id) then

                            local PlayerCoords = GetEntityCoords(GetPlayerPed(source))
                            local distance = #(PlayerCoords - centerRadius)

                            if distance > rangeDistance and serviceParam.inDistance then
                                TriggerClientEvent("Notify", source, "negado", "[STAFF] Você não está no local de expediente.", 5000)
                                return
                            end

                            vRP.addUserGroup(user_id, serviceParam.inService)
                        end

                        CreateRankingUser()
                        TriggerClientEvent("Notify", source, "sucesso", "[STAFF] Você entrou em Expediente.", 5000)

                        local playTime = Ranking[user_id] and Ranking[user_id].hours or 0

                        StaffsInService[user_id] = {
                            startTime = os.time(),
                            playTime = playTime
                        }

                        vRP.sendLog(logsURL['JoinService'], logsFormated['joinService'](serviceParam, user_id, identity))
                        if GetResourceState("vrp_admin") == "started" then
                            exports["vrp_admin"]:generateLog({
                                category = "admin",
                                room = "exp",
                                user_id = user_id,
                                message = ([[O ADMIN (%s) %s acabou de entrar em expediente]]):format(user_id, userName)
                            })
                        end
                    end
                end,
                ['sair'] = function()
                    if (vRP.hasGroup(user_id, serviceParam.offService) or vRP.hasGroup(user_id, serviceParam.inService)) and StaffsInService[user_id] then

                        if not Server.ignoreExpPermission(user_id) then

                            local PlayerCoords = GetEntityCoords(GetPlayerPed(source))
                            local distance = #(PlayerCoords - centerRadius)

                            if distance > rangeDistance and serviceParam.inDistance then
                                TriggerClientEvent("Notify", source, "negado", "[STAFF] Você não está no local de expediente.", 5000)
                                return
                            end

                            vRP.addUserGroup(user_id, serviceParam.offService)
                        end
                        
                        CreateRankingUser()
                        TriggerClientEvent("Notify", source, "negado", "[STAFF] Você saiu do Expediente.", 5000)
                            
                        vRP.sendLog(logsURL['LeaveService'], logsFormated['leaveService'](serviceParam, user_id, identity))
                        
                        local totalHours = 0

                        if Ranking["god"][user_id] then
                            local sessionTime = os.time() - (StaffsInService[user_id] and StaffsInService[user_id].startTime or os.time() - 1)
                            local totalTime = (StaffsInService[user_id] and StaffsInService[user_id].playTime or 0) + sessionTime
                            if totalTime > 0 then
                                totalHours = math.floor(totalTime / 3600)
                            end
                        end

                        vRP.execute("lotus_hub/updateRanking", {
                            user_id = user_id,
                            calls = Ranking[user_id] and Ranking[user_id].calls or 0,
                            hours = totalHours,
                            stars = Ranking[user_id] and Ranking[user_id].stars or 0,
                            totalstars = Ranking[user_id] and Ranking[user_id].totalstars or 0,
                            service = "god",
                        })

                        StaffsInService[user_id] = nil

                        if GetResourceState("vrp_admin") == "started" then
                            exports["vrp_admin"]:generateLog({
                                category = "admin",
                                room = "exp",
                                user_id = user_id,
                                message = ([[O ADMIN (%s) %s acabou de sair de expediente]]):format(user_id, userName)
                            })
                        end
                    elseif vRP.hasGroup(user_id, serviceParam.inService) and not StaffsInService[user_id] then
                        TriggerClientEvent("Notify", source, "negado", "[STAFF] Você não está em Expediente.", 5000)
                        if not Server.ignoreExpPermission(user_id) then
                            vRP.addUserGroup(user_id, serviceParam.offService)
                        end
                    end
                end
            }
            if actions[action] then
                actions[action]()
            end
        end
    end
end)

AddEventHandler('vRP:playerLeave', function(user_id, source)
    local identity = vRP.getUserIdentity(user_id)

    if not StaffsInService[user_id] then
        return
    end
    local sessionTime = os.time() - StaffsInService[user_id].startTime
    local totalTime = StaffsInService[user_id].playTime + sessionTime
    local totalHours = 0
    if totalTime > 0 then
        totalHours = math.floor(totalTime / 3600)
    end

    if not Ranking["god"] and not Ranking["god"][user_id] then
        return
    end

    vRP.execute("lotus_hub/updateRanking", {
        user_id = user_id,
        calls = Ranking["god"][user_id].calls,
        hours = totalHours,
        stars = Ranking["god"][user_id].stars,
        totalstars = Ranking["god"][user_id].totalstars,
        service = "god",
    })

    StaffsInService[user_id] = nil

    vRP.sendLog(logsURL['LeaveService'], logsFormated['leaveService'](serviceParam, user_id, identity))
end)
