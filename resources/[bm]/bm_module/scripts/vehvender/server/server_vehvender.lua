function RegisterTunnel.requestVehInfos(info, data)
    if GetInvokingResource() ~= nil then return end

    local source = source
    local user_id = vRP.getUserId(source)

    if not user_id then return end

    if info == "requestList" then
        local query = vRP.query("bm_module/garages/getAllUserVehicles", { user_id = user_id })

        local t = {}
        if #query > 0 then
            for k in pairs(query) do
                local class = exports.nova_garage:getVehicleType(query[k].veiculo)
                if class ~= nil and class ~= "vip" then
                    t[#t + 1] = { vehicle = query[k].veiculo, nome = exports.nova_garage:getVehicleName(query[k].veiculo) }
                end
            end
        end

        return t or {}
    end

    if info == "sell" then
        local status, time = exports['vrp']:getCooldown(user_id, "veh")

        if status then
            exports['vrp']:setCooldown(user_id, "veh", 3)

            if not data.index or data.index == "" then return end

            local query = vRP.query("bm_module/dealership/getVehicle", { user_id = user_id, vehicle = data.index })
            if #query <= 0 then
                TriggerClientEvent("Notify",source,"negado","Você não possui esse veiculo em sua garagem.", 5)
                return
            end

            local vehName = exports.nova_garage:getVehicleName(data.index)
            local nuser_id = data.id
            if nuser_id == "" or nuser_id == nil then
                TriggerClientEvent("Notify",source,"negado","Digite o ID corretamente.", 5)
                return
            end
            nuser_id = parseInt(nuser_id)

            local query = vRP.query("bm_module/dealership/getVehicle", { user_id = nuser_id, vehicle = data.index })
            if #query > 0 then
                TriggerClientEvent("Notify",source,"negado","O jogador já possuí esse veículo na garagem.", 5)
                return
            end

            if data.index == "wrbrickade" or data.index == "pounder2" then 
                TriggerClientEvent("Notify",source,"negado","Você não pode transferir este veiculo.", 5)
                return
            end
            
            local rows = vRP.query("vRP/get_veiculos_status", {user_id = user_id, veiculo = data.index})
            if rows[1] then
                if rows[1].status == 1 then
                    TriggerClientEvent("Notify",source,"negado","Você não pode transferir um veiculo desmanchado e/ou detido!", 5)
                    return
                elseif rows[1].status == 2 then
                    TriggerClientEvent("Notify",source,"negado","Você não pode transferir um veiculo desmanchado e/ou detido!", 5)
                    return
                end
            end

            local nsource = vRP.getUserSource(nuser_id)
            if not nsource or nuser_id == user_id then
                TriggerClientEvent("Notify",source,"negado","Este cidadão não se encontra na cidade no momento.", 5)
                return
            end

            if GetEntityHealth(GetPlayerPed(nsource)) <= 105 then 
                TriggerClientEvent("Notify",source,"negado","Este cidadão se encontra morto/desmaiado, infelizmente não é possivel vender o veículo agora!", 5)
                return 
            end

            local maxCars, totalCars = exports["nova_dealership"]:getUserAmountCars(nuser_id)
            if totalCars >= maxCars then
                TriggerClientEvent("Notify",nsource,"negado","Você não possui mais vagas na garagem.", 5)
                return
            end
            

            local price = data.value
            if price == "" or price == nil then
                TriggerClientEvent("Notify",source,"negado","Digite o preço corretamente.", 5)
                return
            end
            price = parseInt(price)

            TriggerClientEvent("Notify",source,"sucesso","Você enviou a proposta para o jogador... aguarde.", 5)

            local buyVehicle = vRP.request(nsource, "Você deseja comprar o veiculo <b>"..vehName.."</b> por "..vRP.format(price).." ?", 30)
            if not buyVehicle then
                TriggerClientEvent("Notify",source,"negado","O Jogador recusou sua proposta.", 5)
                TriggerClientEvent("Notify",nsource,"negado","Você recusou a proposta.", 5)
                return
            end

            if not vRP.tryFullPayment(nuser_id, price) then
                TriggerClientEvent("Notify",source,"negado","O Jogador não possui dinheiro.", 5)
                TriggerClientEvent("Notify",nsource,"negado","Você não possui dinheiro.", 5)
                return
            end

            TriggerClientEvent("Notify",source,"sucesso","Você vendeu esse veiculo.", 5)
            TriggerClientEvent("Notify",nsource,"sucesso","Você comprou esse veiculo.", 5)
            

            vRP._giveBankMoney(user_id, price)
            
            vRP._execute("bm_module/garages/updateOwnerVehicle", { new_owner = nuser_id, user_id = user_id, veiculo = data.index, portamalas = json.encode({}) })

            vRP.sendLog("https://discord.com/api/webhooks/1313521220918181959/5y4_MOprYJErmiBofbcdUvMneIODQElVKP9wxxABQdD7-Tf605QWDSJNh_4f2qT51vc2", "[COMPROU] " ..nuser_id.. " | [VENDEU] "..user_id.." | VALOR "..price.." | VEICULO: "..vehName.."")
            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "vender-veiculo-player",
                user_id = user_id,
                message = ( [[O USER_ID %s VENDEU O VEICULO %s PARA O USER_ID %s PELO VALOR %s]] ):format(user_id, vehName, nuser_id, price)
            })
        end
        return
    end

    if info == "keyAdd" then
        local status, time = exports['vrp']:getCooldown(user_id, "veh")

        if status then
            exports['vrp']:setCooldown(user_id, "veh", 3)

            local nuser_id = data.id
            if nuser_id == "" or nuser_id == nil then
                TriggerClientEvent("Notify",source,"negado","Digite o ID corretamente.", 5)
                return
            end
            nuser_id = parseInt(nuser_id)
            local nsource = vRP.getUserSource(nuser_id)

            if not nsource or nuser_id == user_id then
                TriggerClientEvent("Notify",source,"negado","Este cidadão não se encontra na cidade no momento.", 5)
                return
            end

            local acceptKeys = vRP.request(nsource, "Você deseja aceitar a chave desse veiculo?", 30)
            if not acceptKeys then
                TriggerClientEvent("Notify",source,"negado","O Cidadão recusou suas chaves.", 5)
                return
            end
            
            if not vehKeys[user_id..":"..data.index] then
                vehKeys[user_id..":"..data.index] = {}
            end

            vehKeys[user_id..":"..data.index][nuser_id] = data.index
            TriggerClientEvent("Notify",source,"sucesso","Você adicionou o id: "..nuser_id.." em seu veiculo.", 5)
        end
    end

    if info == "keyRem" then
        local status, time = exports['vrp']:getCooldown(user_id, "veh")

        if status then
            exports['vrp']:setCooldown(user_id, "veh", 3)

            local nuser_id = data.id
            if nuser_id == "" or nuser_id == nil then
                TriggerClientEvent("Notify",source,"negado","Digite o ID corretamente.", 5)
                return
            end
            nuser_id = parseInt(nuser_id)

            if vehKeys[user_id..":"..data.index] then
                vehKeys[user_id..":"..data.index][nuser_id] = nil
                TriggerClientEvent("Notify",source,"negado","Você removeu a chave do id: "..nuser_id..".", 5)
            end
        end
    end

end

