local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_farms",src)
Proxy.addInterface("vrp_farms",src)

vCLIENT = Tunnel.getInterface("vrp_farms")


src.DevTools = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
         vRP.kick(source, "OPA!!! Bobinho, Não pode não..")
         vRP.setBanned(user_id, true)
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local validItems = {}
local RouteType = {}

CreateThread(function() 
    for k,v in pairs(cfg.bancadaNui) do 
        for item, data in pairs(v.itens) do 
            validItems[item] = {
                max = 30
            }
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GERAL
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.requestBancada(bancada)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local itens = {}
        local items = cfg.bancadaNui[bancada].itens
        if items then
            for k,v in pairs(items) do
                if vRP.getItemName(k) then
                    table.insert(itens,{ id = k, imagem = cfg.gerais["imagens"]..k..cfg.gerais["formatoImagens"], nome = vRP.getItemName(k), minAmount = 1, maxAmount = 2, action = k })
                end
            end
           
            return cfg.bancadaNui[bancada].bancadaName,itens,bancada
        end
    end
end
function src.fabricarItem(item, minAmout, maxAmount, bancada,direction)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local status, time = exports['vrp']:getCooldown(user_id, "farms")
        if status then 
            exports['vrp']:setCooldown(user_id, "farms", 10)

            vCLIENT._iniciarRota(source, item, vRP.getItemName(item), minAmout, maxAmount, bancada,direction)
            TriggerClientEvent("Notify",source,"importante","Você iniciou as rotas de <b>"..vRP.getItemName(item).."</b>.", 3)

            RouteType[user_id] = bancada

            vCLIENT._closeNui(source)
        else
            TriggerClientEvent("Notify",source,"negado","Aguarde <b>"..time.." segundo(s)</b> para iniciar novamente..", 3) 
        end
    end
end

function src.checkPermission(perm)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if perm == nil or vRP.hasPermission(user_id, perm) then
            return true
        end
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE FARM DE DROGAS
-----------------------------------------------------------------------------------------------------------------------------------------
local giveCount = {} 
local maxGiveAttempts = 10

function src.giveItem(item, quantidade, ponto, bancada,direction)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then

        if direction == "north" then
            routeIndexed = cfg.northRoutes[parseInt(ponto)].coords
        elseif direction == "south" then
            routeIndexed = cfg.southRoutes[parseInt(ponto)].coords
        else
            routeIndexed = cfg.allRoutes[parseInt(ponto)].coords
        end

        local Coords = routeIndexed
        if not Coords then return end

        if GetPlayerPed(source) > 0 then
            if vRP.computeInvWeight(user_id) + vRP.getItemWeight(item) * quantidade <= vRP.getInventoryMaxWeight(user_id) then
                
                -- VERIFICACAO DA MESA SELECIONADA
                local ActualRoute = RouteType[user_id]
                if not ActualRoute then
                    DropPlayer(source,"Opss! ♥")
                    vRP.setBanned(user_id, 1, "[FARMS] SPAWN ¹")
                    return
                end

                local ItemVerify = cfg.bancadaNui[ActualRoute].itens
                if not ItemVerify[item] then
                    DropPlayer(source,"Opss! ♥")
                    vRP.setBanned(user_id, 1, "[FARMS] SPAWN ²")
                    return 
                end

                -- OUTROS
                if not validItems[item] or quantidade <= 0 then
                    DropPlayer(source,"Tentou spawnar "..item.." x"..quantidade)
                    vRP.setBanned(user_id,1)
                    return
                end

                local status, time = exports['vrp']:getCooldown(user_id, "pegaritemrota")
                if not status and time > 0 then 
                    giveCount[user_id] = (giveCount[user_id] or 0) + 1
                    if giveCount[user_id] > maxGiveAttempts then
                        vRP.setBanned(user_id, true, "[VRP_EMPREGOS] - BANIDO POR TENTAR PEGAR ITEM DURANTE COOLDOWN")
                        vRP.setBanned(user_id,1, "TRIGGER EMPREGOS")
                        DropPlayer(source, "Banido por tentar pegar item durante cooldown")
                        return
                    end

                    TriggerClientEvent("Notify",source,"negado","Você não pode pegar ainda a rota, está em cooldown "..time,3)
                    return
                else
                    giveCount[user_id] = 0
                end
                exports['vrp']:setCooldown(user_id, "pegaritemrota", 2)

                if parseInt(ponto) == 0 or parseInt(ponto) == nil then
                    vRP.setBanned(user_id, true, "[VRP_EMPREGOS] - BANIDO PONTO ZERO")
                    vRP.setBanned(user_id,1)
                    DropPlayer(source, "Banido Ponto ZERO")
                    return
                end



                
                if routeIndexed ~= nil then
                    local distance = #(GetEntityCoords(GetPlayerPed(source)) - routeIndexed)
                    if distance <= 15 then 

                        for k,v in pairs(cfg.bancadaNui[bancada].itens) do

                            for i=1,#v.tableItens do
                                local amount = math.random(v.tableItens[i].min,v.tableItens[i].max)

                                if vRP.computeInvWeight(user_id)+vRP.getItemWeight(v.tableItens[i].item) * amount >= vRP.getInventoryMaxWeight(user_id) then
                                    TriggerClientEvent("Notify",source,"aviso","Sua mochila está cheia.")
                                    return false
                                end

                                vRP.giveInventoryItem(user_id, v.tableItens[i].item, amount, true)

                            end

                        end
                        return true
                    end
                end

            else
                TriggerClientEvent("Notify",source,"negado","Sua mochila está cheia.", 3) 
            end
        end
    end
end

 

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE DESMANCHE
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local desmanchando = {}

function src.checkVehicleStatus(mPlaca,mName, mNet)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        -- local Locations = vCLIENT.returnLocations(source)
        -- if next(Locations) then 
        --     local pedCoords = GetEntityCoords(GetPlayerPed(source))
        --     for k,v in pairs(Locations) do 
        --         local pedDistance = #(pedCoords - v.coords)
        --         if pedDistance > v.range then 
        --             return false
        --         end
        --     end 
        -- end
        
        if mName == "hornet" or mName == "Hornet" then
            TriggerClientEvent("Notify",source,"negado","Este veiculo nao pode ser desmanchado.", 5)
            return
        end

        if desmanchando[mPlaca] or desmanchando[mPlaca] ~= nil then
            TriggerClientEvent("Notify",source,"negado","Este veiculo ja esta sendo desmanchado.", 5)
            return
        end
        local nuser_id = vRP.getUserByRegistration(mPlaca)
        if nuser_id and (nuser_id ~= user_id) then
            -- local rows = vRP.query("vRP/get_veiculos_status", {user_id = nuser_id, veiculo = mName})
            local rows = exports.oxmysql:executeSync('SELECT * FROM vrp_user_veiculos WHERE user_id = ? AND veiculo = ?', { nuser_id, mName })
            if #rows == 0 or not rows[1] then
                local entity = NetworkGetEntityFromNetworkId(mNet)
                if DoesEntityExist(entity) and Entity(entity).state.orgVehicle then
                    desmanchando[mPlaca] = user_id
                    exports["vrp"]:setBlockCommand(user_id, 40)
                    return true
                else
                    print("Problemas desmanche - "..mName, nuser_id, mNet)
                    TriggerClientEvent("Notify",source,"negado","Este carro não pode ser desmanchado!", 5)
                    return
                end
            end
            if rows[1] then
                if rows[1].status == 0 then
                    desmanchando[mPlaca] = user_id
                    exports["vrp"]:setBlockCommand(user_id, 40)
                    return true
                else
                    TriggerClientEvent("Notify",source,"negado","Este veiculo ja se encontra detido/retido.", 5)
                end
            else
                TriggerClientEvent("Notify",source,"negado","Este veiculo não pode ser desmanchado.", 5)
            end
        else
            TriggerClientEvent("Notify",source,"negado","Este veiculo nao possui nenhum proprietario.", 5)
        end
    end
end

local webhooks = {
    ["Baixada"] = "https://discord.com/api/webhooks/1304686221146066985/hZ0UNdTnJedtVV6fp_GJKu8ez_hTEoX-26YoMG2FXrIbs1J-8eXJu_RGk6XM51MGFXaf",
    ["Roxos"] = "https://discord.com/api/webhooks/1304689068650528788/76MJ1h-RmRIK0ew5wrcqFm2ffmHpetilGTPDM-yVVUMFDwkGJw4YWRRC9pbIdAfbJRS6",
    ["Cohab"] = "https://discord.com/api/webhooks/1304688591636664362/_QKwDfOfIsGz6frCDA5ycGZseObAESoJK-AkDw0WCt6en1ZMA-MeH6sctwKHgeSMP9GN",
    ["Bennys"] = "https://discord.com/api/webhooks/1304687501096783882/I56kHjTMTllCFRjqOVGOsxbwGuvR_Cuntf-oPnOP2f81r7PYOIhLEpFvU2jCnHUsYUel",
    ["Motoclube"] = "https://discord.com/api/webhooks/1304687904580304906/KI6SdHkODSnUQvmROg5wf8XeqjdTKTDyc_l3vx48YlphCq2ls5GyMjaEI5dCJ8PIGkPp",

}

local timeFunction = {}
function src.pagarDesmanche(mPlaca,mName,mPrice,mVeh)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        -- 
        -- 
        -- 
        -- 
        -- 
        -- 
        -- 
        -- 
        -- 
        -- 

        -- if timeFunction[user_id] and timeFunction[user_id] > os.time() then 
        --     return false 
        -- end

        if not vRP.hasPermission(user_id, 'perm.desmanche') then return end

        local orgType, orgName = exports['dm_module']:GetGroupType(user_id)

        local nuser_id = vRP.getUserByRegistration(mPlaca)
        if nuser_id then
            local query = vRP.query("bm_module/garages/getStatus", { veiculo = mName, user_id = nuser_id })
            if #query > 0 and query[1].status == 0 then
                vRP.execute("vRP/set_status",{ user_id = nuser_id, veiculo = mName, status = 2})
                
                if mName == "hornet" or mName == "Hornet" then
                    TriggerClientEvent("Notify",source,"negado","Este veiculo nao pode ser desmanchado.", 5)
                    return
                end
                
                if desmanchando[mPlaca] == user_id then
                    local rows = vRP.query("vRP/get_nitro", {user_id = user_id, veiculo = mName})
                    if rows[1] then
                        local custom = json.decode(rows[1].nitro or {}) or {}
                        custom.nitro = nil
                        custom.nitro_q = nil
                        vRP.execute("vRP/update_nitro",{ user_id = user_id, veiculo = mName, nitro = json.encode(custom) })
                    end

                    -- COPIAR DAQ
                    local price = exports.nova_garage:getVehiclePrice(mName)
                    if price then
                        exports["vrp"]:setBlockCommand(user_id, 0)
   
                        vRP.giveInventoryItem(user_id, "dirty_money", price*0.15, true)

                        if webhooks[orgName] then
                            vRP.sendLog(webhooks[orgName], ( [[O USER_ID %s DESMANCHOU O VEICULO DO USER_ID %s VEICULO %s PLACA %s VALOR %s]] ):format(user_id, nuser_id, mName, mPlaca, vRP.format(price*0.15)))
                        end

                        exports["vrp_admin"]:generateLog({
                            category = "utilitarios",
                            room = "desmanche",
                            user_id = user_id,
                            message = ( [[O USER_ID %s DESMANCHOU O VEICULO DO USER_ID %s VEICULO %s PLACA %s VALOR %s]] ):format(user_id, nuser_id, mName, mPlaca, vRP.format(price*0.15))
                        })

                        exports['nova_garage']:deleteVehicle(source, mVeh)
                        timeFunction[user_id] = os.time() + 5
                    else
                        print("Problemas com preco do veiculo - "..mName)
                    end
                end
            end
            if #query == 0 then
                local entity = NetworkGetEntityFromNetworkId(mVeh)
                if DoesEntityExist(entity) and Entity(entity).state.orgVehicle then
                    local price = exports.nova_garage:getVehiclePrice(mName)
                    if price then
                        exports["vrp"]:setBlockCommand(user_id, 0)
                        
                        vRP.giveInventoryItem(user_id, "dirty_money", price*0.15, true)

                        vRP.sendLog('https://discord.com/api/webhooks/1313519012822388747/QNTbvTBEgQn-wlyy1z1s9glPkqEZR44pyIvFsshqSB1i_F1WbvGXWmontZYd5xumDCwa', ( [[O USER_ID %s DESMANCHOU O VEICULO DO USER_ID %s VEICULO %s PLACA %s VALOR %s]] ):format(user_id, nuser_id, mName, mPlaca, vRP.format(price*0.15)))

                        exports["vrp_admin"]:generateLog({
                            category = "utilitarios",
                            room = "desmanche",
                            user_id = user_id,
                            message = ( [[(ORG) O USER_ID %s DESMANCHOU O VEICULO DO USER_ID %s VEICULO %s PLACA %s VALOR %s]] ):format(user_id, nuser_id, mName, mPlaca, vRP.format(price*0.15))
                        })
                        vRP._execute("bm_module/garages/org/insertArrestedVehicle", {
                            user_id = nuser_id,
                            vehicle = mName
                        })
                        TriggerEvent("setOrgVehicleArrested", nuser_id, mName)
                        exports['nova_garage']:deleteVehicleFac(mVeh)
                        exports['nova_garage']:deleteVehicle(source, mVeh)
                        timeFunction[user_id] = os.time() + 5
                        return
                    else
                        print("Problemas com preco do veiculo - "..mName)
                    end
                end
            end
            desmanchando[mPlaca] = nil
        else
            TriggerClientEvent("Notify",source,"negado","Este veiculo nao possui nenhum proprietario.", 5)
        end
    end
end

local itensDesmanche = {
    ["macarico"] = 2,
}

function src.checkItensD()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local mensagem = ""
        local status = true

        for k,v in pairs(itensDesmanche) do
            if vRP.getInventoryItemAmount(user_id, k) < v then
                status = false
                mensagem = mensagem .. "Você não possui "..vRP.getItemName(k).." na quantidade de "..v..".<br>"
            end

            if status then
                vRP.tryGetInventoryItem(user_id, k, v) 
            end
        end

         if mensagem ~= "" then
             TriggerClientEvent("Notify",source,"negado",mensagem, 5)
         end

         return status
    end
end 
