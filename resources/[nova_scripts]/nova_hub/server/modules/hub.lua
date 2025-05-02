CreateThread(function()
    if not ConfigHub or not next(ConfigHub) then
        for _, services in pairs(ServicesList) do

            local staffsRoles = {}

            if StaffRoles and next(StaffRoles) then
                for _, role in pairs(StaffRoles) do
                    table.insert(staffsRoles, role)
                end
            end

            ConfigHub = {
                afterCallMessage = 'NÃO TEM PESSOAS SUFICIENTE NO MOMENTO VÁ ATÉ NOSSO DISCORD',
                noHelpMessage = 'VOCÊ FEZ SEU CHAMADO AGUARDE SER ATENDIDO',
                permissions = staffsRoles,
            }
        end
        SaveResourceFile(GetCurrentResourceName(), "./hub.config.json", json.encode(ConfigHub, {indent = true}))
    end
end)

function Server.receiveCall(textRequest, src)
    local _source = (src or source)

    local user_id = vRP.getUserId(_source)

    if not user_id then return end

    if GetPlayerRoutingBucket(_source) == 5 then
        TriggerClientEvent('Notify', _source, 'negado', 'Você não pode fazer chamados em outra dimensão.')
        return
    end

    if Client.inDomination(source) then
        TriggerClientEvent('Notify', _source, 'negado', 'Você não pode fazer chamados em uma dominação.')
        return
    end

    -- local status, time = exports['vrp']:getCooldown(user_id, "lotus_hub:call")
    -- if status then
    --     exports['vrp']:setCooldown(user_id, "lotus_hub:call", 2 * 60)
    -- else
        
    --     local minutes = math.floor(time / 60)
    --     local seconds = time % 60
        
    --     local timeAmount
    --     if minutes > 0 then
    --         timeAmount = minutes .. " minuto" .. (minutes > 1 and "s" or "")
    --         if seconds > 0 then
    --             timeAmount = timeAmount .. " e " .. seconds .. " segundo" .. (seconds > 1 and "s" or "")
    --         end
    --     else
    --         timeAmount = seconds .. " segundo" .. (seconds > 1 and "s" or "")
    --     end
        
    --     TriggerClientEvent('Notify', _source, 'negado', 'Aguarde '..timeAmount..' até efetuar outro chamado.')
    --     return 
    -- end

    if not user_id then return end

    local CategoryIndex = ServiceName[user_id] or DefaultService
    local ServiceRequired = ServicesList[CategoryIndex]
    local category = CategoryIndex

    if not ServiceRequired.isStaff then
        local price = ServiceRequired.price
        if price and price > 0 then
            if not vRP.tryFullPayment(user_id, price) then
                return TriggerClientEvent("Notify", _source, "negado", "Você não tem dinheiro suficiente para fazer esse chamado.")
            end
        end
    end

    if UsersCalls[user_id] and next(UsersCalls[user_id]) then
        local callCategory = UsersCalls[user_id]
        local call = CallsCache[callCategory][user_id]
        if call then
            if GetGameTimer() < call.time then
                local callTime = parseInt((CallsCache[user_id].time - GetGameTimer()) / 1000)
                TriggerClientEvent("Notify", _source, "negado", "Aguarde <b>"..callTime.." segundos</b>.", 5000)
                return
            end
        end
    end

    local pCoords = GetEntityCoords(GetPlayerPed(_source))
    local locationRequest = vec3(ceil(pCoords.x), ceil(pCoords.y), ceil(pCoords.z))
    local identity = vRP.getUserIdentity(user_id)

    if not CallsCache[category] then CallsCache[category] = {} end

    if not CallsIDCounter[category] then
        CallsIDCounter[category] = 0
    end
    CallsIDCounter[category] = CallsIDCounter[category] + 1
    local newID = CallsIDCounter[category]

    local isNovat = (LastIdInServer - user_id) <= HubCalls.HighUserId.counterBeforeLastId
    
    CallsCache[category][user_id] = {
        id = newID,
        createdAt = os.time(),
        target_id = user_id,
        target_source = _source,
        name = identity.nome .. " " .. identity.sobrenome .. "#" .. user_id,
        message = textRequest,
        timerDelete = GetGameTimer() + HubCalls.timerShowFinishCall[category],
        location = locationRequest,
        category = ServiceRequired.label,
        category_index = CategoryIndex,
        accepted = false,
        isNovat = isNovat,
    }

    local usersRequest = vRP.getUsersByPermission(ServiceRequired.perm)
    
    local function sendCall(_source, user, category)
        local callDisabled = StaffsHub[tostring(user)] and StaffsHub[tostring(user)].disableCalls or false
        local mutedCalls = StaffsHub[tostring(user)] and StaffsHub[tostring(user)].muteCalls or false

        Client.receiveCalls(_source, CallsCache[category], CallsCache[category][user_id], callDisabled)

        local notificationTAB = Ranking[category] and Ranking[category][user] and Ranking[category][user].notification or false

        if not mutedCalls and not notificationTAB then
            -- TriggerClientEvent("vrp_sound:source", _source, "alert_hub", 0.5)
        end
    end

    if usersRequest and next(usersRequest) then
        TriggerClientEvent("Notify", _source, "sucesso", ConfigHub.afterCallMessage)
        for _, user in pairs(usersRequest) do
            local source = vRP.getUserSource(user)
            if source then
                if ServiceRequired.isStaff then
                    if StaffsInService[user] or Server.ignoreExpPermission(user) then
                        sendCall(source, user, category)
                    end
                else
                    if vRP.checkPatrulhamento(user) then
                        sendCall(source, user, category)
                    end
                end
            end
        end
    else
        return TriggerClientEvent("Notify", source, "negado", ConfigHub.noHelpMessage)
    end
end
function Server.toggleNotifications()
    local source = source
    local user_id = vRP.getUserId(source)

    if not user_id then return end

    if not UsersInServiceCategory[user_id] then return end

    local serviceCategory = UsersInServiceCategory[user_id]

    if Ranking[serviceCategory][user_id] then
        if Ranking[serviceCategory][user_id].notification then
            Ranking[serviceCategory][user_id].notification = false
            TriggerClientEvent("Notify",source,"sucesso","Você receberá mais notificações de chamados.")
        else
            Ranking[serviceCategory][user_id].notification = true
            TriggerClientEvent("Notify",source,"negado","Você não receberá notificações de chamados.")
        end
    else
        TriggerClientEvent("Notify",source,"negado","Verifique se você esta de ponto batido.")
    end    
end

function formatarMetros(numero)
    return string.format("%.2f", numero) .. "m"
end

local cooldownAccept = {}

function Server.callMenuAction(callParameters, action)
    local source = source
    local user_id = vRP.getUserId(source)

    if not callParameters or not next(callParameters) then return end

    local status, time = exports['vrp']:getCooldown(user_id, "lotus_hub:request")
    if status then
        exports['vrp']:setCooldown(user_id, "lotus_hub:request", 5)
    else
        TriggerClientEvent('Notify',source,'negado','Aguarde até 5 segundos para atualizar outro chamado.')
        return 
    end

    local actions = {
        ['accept'] = function()
            if vRP.hasGroup(user_id, 'ajudantelotusgroup@445') then
                TriggerClientEvent('Notify',source,'negado','Você não pode atender chamados.')
                return
            end

            local categoryCall = callParameters.category_index
            local target_id = callParameters.target_id

            local categoryToSave = categoryCall or "god"

            local target_source = vRP.getUserSource(target_id)
            local callCache = CallsCache[categoryCall] and CallsCache[categoryCall][target_id]

            if not callCache then 
                return TriggerClientEvent("Notify",source,"negado","Chamado já atendido.[1]") 
            end

            if callCache.accepted then 
                return TriggerClientEvent("Notify",source,"negado","Chamado já atendido.[2]") 
            end

            if not ServicesList[callCache.category_index].isStaff and cooldownAccept[user_id] then
                return TriggerClientEvent("Notify",source,"negado","Finalize o seu chamado para aceitar outro.")
            end

            CallsCache[categoryCall][target_id]['accepted'] = true

            CreateThread(function()
                Server.deleteCallInMenu(categoryCall, target_id)
            end)


            callCache = CallsCache[categoryCall] and CallsCache[categoryCall][target_id]
            if not callCache then 
                return TriggerClientEvent("Notify",source,"negado","Chamado já atendido.[3]") 
            end

            local identity = vRP.getUserIdentity(user_id)
            local userName = identity.nome .. " " .. identity.sobrenome

            TriggerClientEvent("Notify", target_source, "sucesso", "Chamado atendido por: " .. userName .. "#" .. user_id)

            local pCoords = GetEntityCoords(GetPlayerPed(target_source))
            local categoryService = ServicesList[callCache.category_index]

            if categoryService.isStaff then
                vRPclient.teleport(source, pCoords.x, pCoords.y, pCoords.z)
                vRP.sendLog('https://discord.com/api/webhooks/1319413744547397773/Cd42EwDjwtoGVnelifyVL71ZkmTol7fvHWj4mQfhstta2y2uR003s7q60mnnynQ1S00f', 
                    string.format('%s#%d aceitou o chamado de %s#%d nas coordenadas: %.2f, %.2f, %.2f', 
                    userName, user_id, vRP.getUserIdentity(target_id).nome, target_id, pCoords.x, pCoords.y, pCoords.z))
            else
                vRPclient.setGPS(source, pCoords.x, pCoords.y, pCoords.z)
                local userPed = GetEntityCoords(GetPlayerPed(source))
                local distance = #(pCoords - userPed)
                TriggerClientEvent('hub:notify', target_source, user_id, formatarMetros(distance))

                CreateThread(function()
                    cooldownAccept[user_id] = true
                    local startTime = os.time()
                    local isServiceFinished = false
                    TriggerClientEvent('Notify', target_source, 'sucesso', 'O atendente está a caminhon não saia do local para o chamado não ser cancelado.', 10)
                    while not isServiceFinished do
                        local userSource = vRP.getUserSource(user_id)
                        if not userSource then
                            TriggerClientEvent('Notify', target_source, 'negado', 'O atendente saiu e o chamado foi cancelado.', 10)
                            break
                        end
                        local targetSource = vRP.getUserSource(target_id)
                        if not targetSource then
                            TriggerClientEvent('Notify', userSource, 'negado', 'O cliente saiu e o chamado foi cancelado.', 10)
                            isServiceFinished = true
                            break
                        end

                        local ped = GetPlayerPed(userSource)
                        local targetPed = GetPlayerPed(targetSource)
                        local userCoords = GetEntityCoords(ped)
                        local targetCoords = GetEntityCoords(targetPed)
                        local distance = #(userCoords - pCoords)
                        if distance <= 30.0 then
                            isServiceFinished = true
                            break
                        end

                        local distanceTarget = #(targetCoords - pCoords)
                        if distanceTarget > 30.0 then
                            TriggerClientEvent('Notify', userSource, 'negado', 'O cliente saiu do local e o chamado foi cancelado.', 10)
                            TriggerClientEvent('Notify', targetSource, 'negado', 'Você saiu da área do chamado e ele foi cancelado.', 10)
                            isServiceFinished = true
                            break
                        end

                        if not isServiceFinished and distance > 30.0 and os.time() - startTime > 300 then
                            TriggerClientEvent("Notify", userSource, "negado", "Você não chegou ao local do chamado a tempo e o chamado foi cancelado.", 10)
                            break
                        end
                        Wait(1000)
                    end

                    cooldownAccept[user_id] = false

                    local price = categoryService.price
                    if vRP.getUserSource(target_id) then
                        TriggerClientEvent('close:callhud', vRP.getUserSource(target_id))
                    end
                    if price and price > 0 then
                        if not isServiceFinished then
                            vRP.giveBankMoney(target_id, price)
                            TriggerClientEvent('Notify', target_source, 'negado', 'O atendente não chegou a tempo e o pagamento de '..vRP.format(price)..' foi devolvido.', 10)
                        else
                            vRP.giveBankMoney(user_id, price)
                            TriggerClientEvent('Notify', source, 'negado', 'O chamado foi finalizado e seu pagamento de '..vRP.format(price)..' já foi debitado em sua conta.', 10)
                        end
                    end
                end)
            end

            if categoryService.isStaff then
                local waitFinishCall = Client.setAcceptedCall(source, callCache)
                if waitFinishCall == 'accepted' then
                    if target_source then
                        local FeedBackCall = Client.feedbackCall(target_source, callCache)

                        if not Ranking[categoryCall] then
                            Ranking[categoryCall] = {}
                        end

                        if not Ranking[categoryCall][user_id] then
                            Ranking[categoryCall][user_id] = {
                                calls = 0,
                                hours = 0,
                                stars = 0,
                                totalstars = 0,
                                name = userName,
                                service = categoryToSave,
                            }

                            vRP.execute("lotus_hub/createRanking", {
                                user_id = user_id,
                                calls = 0,
                                hours = 0,
                                stars = 0,
                                totalstars = 0,
                                name = userName,
                                service = categoryToSave,
                            })
                        end

                        Ranking[categoryCall][user_id].calls = Ranking[categoryCall][user_id].calls + 1

                        if type(FeedBackCall) == 'table' then
                            Ranking[categoryCall][user_id].stars = Ranking[categoryCall][user_id].stars + FeedBackCall.stars
                            Ranking[categoryCall][user_id].totalstars = Ranking[categoryCall][user_id].totalstars + FeedBackCall.stars
                        end

                        vRP.execute("lotus_hub/updateRanking", {
                            hours = Ranking[categoryCall][user_id].hours,
                            calls = Ranking[categoryCall][user_id].calls,
                            stars = Ranking[categoryCall][user_id].stars,
                            totalstars = Ranking[categoryCall][user_id].totalstars,
                            user_id = user_id,
                            name = userName,
                            service = categoryToSave,
                        })
                        TriggerClientEvent("Notify",target_source,"sucesso","Agradecemos pelo seu feedback.")
                    end
                end
            else
                if not Ranking[categoryCall] then
                    Ranking[categoryCall] = {}
                end

                if not Ranking[categoryCall][user_id] then
                    Ranking[categoryCall][user_id] = {
                        calls = 0,
                        name = userName,
                        service = categoryToSave,
                    }

                    vRP.execute("lotus_hub/createRanking", {
                        user_id = user_id,
                        calls = 0,
                        hours = 0,
                        stars = 0,
                        totalstars = 0,
                        name = userName,
                        service = categoryToSave,
                    })
                end

                Ranking[categoryCall][user_id].calls = Ranking[categoryCall][user_id].calls + 1

                vRP.execute("lotus_hub/updateRanking", {
                    hours = 0,
                    calls = Ranking[categoryCall][user_id].calls,
                    stars = 0,
                    totalstars = 0,
                    user_id = user_id,
                    name = userName,
                    service = categoryToSave,
                })
            end
        end,

        ['refuse'] = function()
            local categoryCall = callParameters.category_index
            local target_id = callParameters.target_id

            CreateThread(function()
                Server.deleteCallInMenu(categoryCall, target_id)
            end)

            local target_source = vRP.getUserSource(target_id)

            if target_source then
                TriggerClientEvent("Notify",target_source,"negado",ConfigHub.noHelpMessage)
            end
        end,
    }

    if actions[action] then
        actions[action]()
    end
end

function Server.deleteCallInMenu(categoryService, callId)
    local callcache = CallsCache[categoryService][callId]
    
    if not callcache then return end
    

    local ServiceRequired = ServicesList[callcache.category_index]

    CallsCache[categoryService][callId] = nil
    
    
    local usersRequest = vRP.getUsersByPermission(ServiceRequired.perm)
    
    if usersRequest and next(usersRequest) then
        for _, user in pairs(usersRequest) do
            local source = vRP.getUserSource(user)
            if source and CallsCache[categoryService] and callId then
                Client.rejectSpecificCall(source, CallsCache[categoryService], callId)
            end
        end
    end
end

function Server.updateCallsInMenu(categoryService)
    local ServiceRequired = ServicesList[categoryService]
    
    local usersRequest = vRP.getUsersByPermission(ServiceRequired.perm)
    
    if usersRequest and next(usersRequest) then
        for _, user in pairs(usersRequest) do
            local source = vRP.getUserSource(user)
            if source and CallsCache[categoryService] and callId then
                Client.rejectSpecificCall(source, CallsCache[categoryService], callId)
            end
        end
    end
end

function Server.openServiceMenu()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local serviceCategory = nil
    local inPatrol = false

    if not ServicesList or not next(ServicesList) then return print('[BUG HUB] - SERVICES NOT FOUND') end

    for index, service in pairs(ServicesList) do
        if vRP.hasPermission(user_id, service.perm) then
            if service.checkPatrol then
                if vRP.checkPatrulhamento(user_id) then
                    inPatrol = true
                    serviceCategory = index
                else
                    TriggerClientEvent("Notify",source,"negado","Você precista estar de ponto batido para acessar o serviço: "..service.category)
                end
            else
                if not inPatrol then
                    serviceCategory = index
                end
            end
        end
    end

    if not serviceCategory then return TriggerClientEvent("Notify",source,"negado","Você não tem permissão.") end

    UsersInServiceCategory[user_id] = serviceCategory

    local ServiceRequired = ServicesList[serviceCategory]

    if not ServiceRequired or not next(ServiceRequired) then return TriggerClientEvent("Notify",source,"negado","Serviço não encontrado.") end

    if serviceCategory == "god" then
        if not StaffsInService[user_id] and not Server.ignoreExpPermission(user_id) then return TriggerClientEvent("Notify",source,"negado","Você não está de ponto batido. Use /exp extrar") end
    end

    TriggerClientEvent("Notify",source,"sucesso","Você abriu o chamado: "..ServiceRequired.category.."")

    local hasPermissionConfig = false

    local configHub = {}
    local rankingTable = {}

    if serviceCategory == "god" then
        configHub = ConfigHub

        for _, permission in pairs(StaffRoles) do
            if permission.hasPermission and vRP.hasGroup(user_id, permission.value) then
                hasPermissionConfig = true
                break
            end
        end
    
        if not hasPermissionConfig and vRP.hasPermission(user_id, "developer.permissao") then
            hasPermissionConfig = true
        end

        if hasPermissionConfig then
            if not StaffsHub[tostring(user_id)] then
                StaffsHub[tostring(user_id)] = {
                    disableCalls = false,
                    muteCalls = false,
                }
                SaveResourceFile(GetCurrentResourceName(), "./users.config.json", json.encode(StaffsHub, {indent = true}))
            end
        end

        configHub.hasPermission = hasPermissionConfig

        if StaffsHub and next(StaffsHub) then
            if StaffsHub[tostring(user_id)] then
                for index, value in pairs(StaffsHub[tostring(user_id)]) do
                    configHub[index] = value
                end    
            end
        end
    end

    if Ranking[serviceCategory] and next(Ranking[serviceCategory]) then
        for user_idRanking, ranking in pairs(Ranking[serviceCategory]) do
            local parameters = {
                user_id = user_idRanking,
                name = user_idRanking .. "-" .. (ranking.name or "Desconhecido"),
                calls = ranking.calls or 0,
                hours = ranking.hours or 0,
                stars = ranking.calls and ranking.calls > 0 and tonumber(string.format("%.1f", math.min((ranking.stars or 0) / ranking.calls, 5))) or 0,
            }
    
            table.insert(rankingTable, parameters)
        end
    end

    local callsRegistered = {}

    if CallsCache and next(CallsCache) then
        if CallsCache[ServiceRequired.category] then
            for _, calls in pairs(CallsCache[ServiceRequired.category]) do
                table.insert(callsRegistered, calls)
            end
        end
    end

    local isStaff = not inPatrol

    local parametersRequired = {}

    if isStaff then
        parametersRequired = {
            ranking = rankingTable,
            currentRankingPosition = user_id,
            config = configHub,
            calls = callsRegistered,
        }
    else
        parametersRequired = {
            serviceRanking = rankingTable,
            serviceCalls = callsRegistered,
        } 
    end

    parametersRequired.currentRankingPosition = user_id

    Client.openServiceMenu(source, parametersRequired, isStaff, serviceCategory)
end

function Server.saveConfig(parameters)
    local source = source

    local authorizedSaveHub = false
    local authorizedSaveStaffs = false

    local user_id = vRP.getUserId(source)

    local parametersHubConfig = {
        ['afterCallMessage'] = true,
        ['noHelpMessage'] = true,
        ['permissions'] = true,
    }

    for key, value in pairs(parameters) do
        if parametersHubConfig[key] then
            if ConfigHub[key] ~= nil then
                ConfigHub[key] = value
                authorizedSaveHub = true
            end
        else
            if not StaffsHub[tostring(user_id)] then
                StaffsHub[tostring(user_id)] = {}
            end

            StaffsHub[tostring(user_id)][key] = value
            authorizedSaveStaffs = true
        end
    end

    if authorizedSaveHub then
        SaveResourceFile(GetCurrentResourceName(), "./hub.config.json", json.encode(ConfigHub, {indent = true}))
    end

    if authorizedSaveStaffs then
        SaveResourceFile(GetCurrentResourceName(), "./users.config.json", json.encode(StaffsHub, {indent = true}))
    end
end

CreateThread(function()
    while true do
        if CallsCache and next(CallsCache) then
            for category, calls in pairs(CallsCache) do
                local authorizedUpdateCategory = false
                for id, call in pairs(calls) do
                    if call.timerDelete < GetGameTimer() then
                        authorizedUpdateCategory = true
                        if call.target_source then
                            TriggerClientEvent("Notify",call.target_source,"negado", ConfigHub.noHelpMessage)
                        end
                        CallsCache[category][id] = nil
                    end
                end

                if authorizedUpdateCategory then
                    CreateThread(function()
                        Server.updateCallsInMenu(category)  
                    end)
                end
            end
        end
        Wait(15 * 1000)
    end
end)

CreateThread(function()
    while true do
        local lastId = vRP.query("lotus_hub/selectLastId")

        if lastId and next(lastId) then
            LastIdInServer = lastId[1].user_id
        end

        Wait(15 * 60 * 1000)
    end
end)

RegisterCommand("call",function(source,args,rawCmd)
    local user_id = vRP.getUserId(source)

    if not args[1] then return end

    if not ServicesList[args[1]] then return TriggerClientEvent('Notify', 'negado', 'Chamado não existente.') end

    ServiceName[user_id] = args[1]

    local ServiceRequired = ServicesList[args[1]]

    Client.openHelpByCategory(source, args[1])
end)

RegisterNetEvent("hub:sendCallType", function (src, category, content)
    local _source = src and src or source
    if not _source then return end

    local user_id = vRP.getUserId(tonumber(_source))
    if not user_id then return end
    if not ServicesList[category] then return TriggerClientEvent('Notify', _source, 'negado', 'Chamado não existente.') end
    ServiceName[user_id] = category

    Server.receiveCall(content, _source)
end)

RegisterNetEvent("hub:sendCall2", function()
    local source  = source
    local user_id = vRP.getUserId(source)

    if not user_id then return end

    ServiceName[user_id] = "god"

    local textRequest = "[Mensagem Automática] - Estou desmaiado, por favor me ajude."

    Server.receiveCall(textRequest, source)
end)

RegisterNetEvent("hub:sendFireCall", function ()
    local source = source
    local user_id = vRP.getUserId(source)

    if not user_id then return end

    ServiceName[user_id] = "bombeiro"

    local textRequest = "[Mensagem Automática] - Estou desmaiado, por favor me ajude."

    Server.receiveCall(textRequest, source)
end)