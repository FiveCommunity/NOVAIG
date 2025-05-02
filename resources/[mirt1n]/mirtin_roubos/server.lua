local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
GlobalState["RandomIdentifier_roubos"] = math.random(1000) + os.time()
src = {}
trap = {}
Tunnel.bindInterface(GlobalState["RandomIdentifier_roubos"],src)
Tunnel.bindInterface("mirtin_roubos",trap)
Tunnel.bindInterface("vrp_roubos",trap)
Proxy.addInterface(GlobalState["RandomIdentifier_roubos"],src)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local robberyList = {}
local block_roubar = {}
local idgens = Tools.newIDGenerator()
function trap.giveItem(item,tblCfg)
    local source = source
    local user_id = vRP.getUserId(source)

    DropPlayer(source, "KKKKKKKKKKKKKKKKK FRACO")
    vRP.setBanned(user_id,1)

end

local Robbery = {}
local RobberyCount = {}
robberyCount = {}
local lastCollectTime = {}
local allowedIdRobbery = {}

CreateThread(function()
    while true do
        robberyCount = {}
        Wait(30000)
    end

end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function src.giveItem(tblCfg)
    local source = source
    local user_id = vRP.getUserId(source)

    DropPlayer(source,":`(")
    vRP.setBanned(user_id,1, "Robbery INJECT MRT") 
    print(('%s INJECT ROBBERY'):format(user_id))

    -- local currentTime = os.time()
    -- local item = "dirty_money"

    -- if tblCfg.minValue ~= nil and tblCfg.maxValue ~= nil then
    --     amount = math.random(tblCfg.minValue,tblCfg.maxValue)
    -- else
    --     print(user_id..' setando nil no roubo')
    --     --DropPlayer(source,"Robbery Inject")
    --     vRP.setBanned(user_id,1, "Robbery INJECT ¹") 
    -- end

    -- if amount > 200 then
    --     print(user_id..' setando nil no roubo')
    --     --DropPlayer(source,"Robbery Inject")
    --     vRP.setBanned(user_id,1, "Robbery INJECT ¹") 
    -- end

    -- if user_id then
    --     if not Robbery[source] then
    --         print(user_id..' tentando spawnar dinheiro pelo roubos')
    --         -- DropPlayer(source,"Robbery Inject")
    --         -- vRP.setBanned(user_id,1, "Robbery INJECT ²") 
    --         return 
    --     end

    --     if not allowedIdRobbery[user_id] then
    --         print(user_id..' tentando spawnar dinheiro pelo roubos RNS')
    --         --DropPlayer(source,"Robbery Inject RNS")
    --         return
    --     end

    --     if Robbery[source].coords then
    --         local coords = GetEntityCoords(GetPlayerPed(source))
    --         local distance = #(Robbery[source].coords - coords)
    --         if distance > 50.0 then
    --             print("Bloqueando "..user_id.." | Roubos | Distancia: "..distance)
    --             --DropPlayer(source,"Robbery Inject")
    --             vRP.setBanned(user_id,1, "Robbery INJECT ³: "..distance) 
    --             return
    --         end
    --     end

    --     if item ~= "dirty_money" then 
    --         --DropPlayer(source,"Robbery Inject")
    --         vRP.setBanned(user_id,1, "Robbery INJECT 4: "..distance) 
    --         return 
    --     end

    --     if lastCollectTime[source] and currentTime - lastCollectTime[source] < tblCfg.collectCooldown then
    --         vRP.sendLog("https://canary.discord.com/api/webhooks/1101571307038064650/AwIDgwdvDVbG2oTw04-MCJCmYzWlDD8sQ863-Jq6OikeYHN56QG2kmp8J2BJaYZqHtUo", "USUARIO: "..user_id.. " tentou coletar dirty_money antes do tempo permitido. Intervalo permitido: 1s ou mais!")
    --         return
    --     end

    --     if not RobberyCount[source] then
    --         RobberyCount[source] = 1
    --     else
    --         RobberyCount[source] = RobberyCount[source] + 1
    --         if RobberyCount[source] > tblCfg.maxCollects then
    --             --DropPlayer(source, "Safadinho! Tentando pegar dinheiro a mais do roubo!")
    --             -- vRP.setBanned(user_id,1)
    --             vRP.sendLog("https://canary.discord.com/api/webhooks/1101571307038064650/AwIDgwdvDVbG2oTw04-MCJCmYzWlDD8sQ863-Jq6OikeYHN56QG2kmp8J2BJaYZqHtUo", "USUARIO: "..user_id.." tentou coletar dirty_money mais do que o permitido.")
    --             return
    --         end
    --     end
    --     if RobberyCount[source] ~= nil then
    --         vRP.giveInventoryItem(user_id, "dirty_money", amount, true)
    --     end
    --     lastCollectTime[source] = currentTime
    -- end
end

function src.checkRobbery(id)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if cfg.locationRoubos[id] == nil then return end

        local tipo = cfg.locationRoubos[id].type
        if tipo ~= nil then
            local infoRoubo = cfg.roubos[tostring(tipo)]
            local itensRoubo = infoRoubo.itens
            local permissRoubo = infoRoubo.permiss
            local inPtr = src.totalPtr()
            
            if permissRoubo ~= "perm.nil" then
                if not vRP.hasPermission(user_id, permissRoubo) then
                    TriggerClientEvent("Notify",source,"negado","Você não possui permissao para roubar esse local.", 5)
                    return
                end
            end

            for k,v in pairs(itensRoubo) do
                local itemAmount = vRP.getInventoryItemAmount(user_id, v)
                if itemAmount < 1 then
                    block_roubar[parseInt(user_id)] = true
                end
            end
            
            if block_roubar[user_id] then
                TriggerClientEvent("Notify",source,"negado","Você não possui os itens necessarios para roubar esse local.", 5)
            else
                if robberyList[id] == nil then
                    if inPtr >= infoRoubo.pmPTR then
                        for k,v in pairs(itensRoubo) do
                            vRP.tryGetInventoryItem(user_id, v, 1, true) 
                        end

                        local plyCoords = GetEntityCoords(GetPlayerPed(source))
                        if #(plyCoords - cfg.locationRoubos[id].coords) > 10 then
                            -- print(('%s INJECT CHECK ROBBERY'):format(user_id))
                            return
                        end
                        if allowedIdRobbery[user_id] and allowedIdRobbery[user_id] ~= id then
                            -- DropPlayer(source, "(LIKIZAO-AC)\n Spammando roubo!")
                            print("Robbery Warning: User "..user_id.." is trying to rob "..id.."; ", allowedIdRobbery[user_id])
                            return
                        end
                        if cfg.locationRoubos[id].type == "Loja" then
                            local i = 0
                            while i <= 10 do
                                robberyList[i] = infoRoubo.cooldown
                                i = i + 1
                            end
                        else
                            robberyList[id] = infoRoubo.cooldown
                        end
                        
                        exports["vrp"]:setBlockCommand(user_id, infoRoubo.tempo)

                        exports["vrp_admin"]:generateLog({
                            category = "roubos",
                            room = "roubos",
                            user_id = user_id,
                            message = ( [[O USER_ID %s ESTÁ ROUBANDO %s]] ):format(user_id, cfg.locationRoubos[id].type)
                        })

                        Robbery[source] = { coords = plyCoords }
                        RobberyCount[source] = 0
                        if not robberyCount[user_id] then
                            robberyCount[user_id] = {}
                        end
                        if #robberyCount[user_id] > 6 then
                            TriggerEvent("AC:ForceBan", source, {
                                reason = "ROUBO_ABUSO",
                                additionalData = "Roubou 6 locais em 30 segundos",
                                forceBan = false,
                            })
                            return
                        end
                        local hasIdxUsed = false
                        for i = 1, #robberyCount[user_id] do
                            if robberyCount[user_id][i] == id then
                                hasIdxUsed = true
                                return
                            end
                        end
                        if not hasIdxUsed then
                            robberyCount[user_id][#robberyCount[user_id]+1] = id
                        end
                        allowedIdRobbery[user_id] = id
                        StartUserRobbery(user_id)

                        return true
                    else
                        TriggerClientEvent("Notify",source,"negado","Sem policias em patrulhamento no momento. ", 5)
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Aguarde <b>"..robberyList[id].." segundo(s)</b> para roubar este local.", 5)
                end
            end
            

            block_roubar[user_id] = false
        end
    end
end


function src.cancelRobbery()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        RobberyCount[source] = nil
        lastCollectTime[source] = nil
        Robbery[source] = nil
        exports["vrp"]:setBlockCommand(user_id, 0)
        allowedIdRobbery[user_id] = false
    end
end

function StartUserRobbery(user_id)
    CreateThread(function()
        local user_id = user_id
        while allowedIdRobbery[user_id] do
            local robbery_id = allowedIdRobbery[user_id]
            local source = vRP.getUserSource(user_id)

            local plyCoords = GetEntityCoords(GetPlayerPed(source))
            if #(plyCoords - cfg.locationRoubos[robbery_id].coords) > 10 then
                -- print(('%s INJECT CHECK ROBBERY'):format(user_id))

                RobberyCount[source] = nil
                lastCollectTime[source] = nil
                Robbery[source] = nil
                exports["vrp"]:setBlockCommand(user_id, 0)
                allowedIdRobbery[user_id] = false

                break;
            end

            local type_robbery = cfg.locationRoubos[robbery_id].type
            if cfg.roubos[type_robbery] then
                RobberyCount[source] = (RobberyCount[source] + 1)

                if RobberyCount[source] > (cfg.roubos[type_robbery].tempo + 10) then
                    print(('%s INJECT COUNT ROBBERY'):format(user_id))

                    RobberyCount[source] = nil
                    lastCollectTime[source] = nil
                    Robbery[source] = nil
                    exports["vrp"]:setBlockCommand(user_id, 0)
                    allowedIdRobbery[user_id] = false
                    break
                end

                local amount = math.random(cfg.roubos[type_robbery].minValue,cfg.roubos[type_robbery].maxValue)
                vRP.giveInventoryItem(user_id, "dirty_money", amount, true)

                -- print(('USER_ID: %s RECEBEU: R$ %s ROUBO: %s'):format(user_id, amount, robbery_id))
            else
                break;
            end

            Wait(1000)
        end
    end)
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA NOTIFY
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.totalPtr()
    local policia = vRP.getUsersByPermission("perm.policia")	
    local contadorPOLICIA = 0
    for k,v in pairs(policia) do
        local patrulhamento = vRP.checkPatrulhamento(parseInt(v))
        if patrulhamento then
            contadorPOLICIA = contadorPOLICIA + 1
        end
    end
    
    return contadorPOLICIA
end 

function src.alertPolice(x,y,z,blipText, mensagem)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        exports['vrp']:alertPolice({ x = x, y = y, z = z, blipID = 161, blipColor = 63, blipScale = 0.5, time = 20, code = "911", title = blipText, name = mensagem})
    end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONTADOR DE ROUBOS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		
		for k,v in pairs(robberyList) do
			if v > 0 then
				robberyList[k] = v - 10
			end

			if robberyList[k] == 0 then
				robberyList[k] = nil
			end
		end

        Citizen.Wait(10000)
	end
end)