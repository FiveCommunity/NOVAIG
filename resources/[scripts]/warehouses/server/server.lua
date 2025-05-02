-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNNEL
-----------------------------------------------------------------------------------------------------------------------------------------
cO = {}
Tunnel.bindInterface(GetCurrentResourceName(), cO)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local BuyedPropertys = {}
local oxmysql = exports.oxmysql
-----------------------------------------------------------------------------------------------------------------------------------------
-- AVALIABLE PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
function cO.avaliablePropertys()
    local source = source 
    local userId = vRP.getUserId(source)
    if not userId then return end 

    local Callback = {}
    for k,v in pairs(Warehouses) do 
        if BuyedPropertys[k] then 
            goto continue
        end


        table.insert(Callback,k)
        ::continue::
    end

    return Callback
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function cO.propertyChest(propertyName)
    local source = source 
    local userId = vRP.getUserId(source)
    if not userId then return end 

    local query = oxmysql:query_async("SELECT weight FROM warehouses WHERE name = @name AND user_id = @user_id",{ name = propertyName, user_id = userId })
    if query[1] then 
        TriggerClientEvent("Warehouses:Chest",source,"",propertyName,query[1].weight)
        return true 
    end

    TriggerClientEvent("Notify",source,"negado","Você não possuí acesso.",5000)
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
function cO.playerPropertys()
    local source = source 
    local userId = vRP.getUserId(source)
    if not userId then return end 

    local wareHouses = {}
    local consult = oxmysql:query_async("SELECT name FROM warehouses WHERE user_id = @id",{ id = userId })
    if #consult > 0 then 
        wareHouses = consult 
    end

    return wareHouses
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTY INFOS
-----------------------------------------------------------------------------------------------------------------------------------------
function cO.propertysInfos(propertyName)
    local source = source 
    local userId = vRP.getUserId(source)
    if not userId then return end 

    if not Warehouses[propertyName] then 
        return false 
    end

    local propertyInfos = {}
    local propertyMembers = {}
    local queryResult = oxmysql:query_async("SELECT * FROM warehouses WHERE name = @name", { name = propertyName })

    for _, warehouse in ipairs(queryResult) do 
        local playerIdentity = vRP.getUserIdentity(warehouse.user_id)
        if playerIdentity then 
            table.insert(propertyMembers, { 
                name = playerIdentity.nome .. " " .. playerIdentity.sobrenome,
                uid = warehouse.user_id
            })
        end

        if warehouse.owner == 1 and warehouse.tax then 
            propertyInfos.chest = warehouse.weight
            propertyInfos.rentTime = "Expira em " .. os.date("%d/%m/%Y às %H:%M", warehouse.tax)
            if warehouse.renamed then 
                propertyInfos.renamed = warehouse.renamed
            end 
        end
    end

    propertyInfos.members = propertyMembers
    return propertyInfos, propertyName
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
function cO.buyPropertys(propertyName)
    local source = source 
    local userId = vRP.getUserId(source)
    if not userId then return end 

    if not Warehouses[propertyName] then 
        return false 
    end

    if BuyedPropertys[propertyName] then 
        return false, TriggerClientEvent("Notify",source,"negado","Ocorreu um erro.",5000)
    end

    local Response = vRP.tryFullPayment(userId,parseInt(Warehouses[propertyName]["Price"]))
    if Response then 
        TriggerClientEvent("Warehouses:Close",source)

        oxmysql:query("INSERT INTO warehouses(user_id,name,owner,tax,weight) VALUES(@user_id,@name,1,@tax,@weight)",{
            user_id = userId,
            name = propertyName,
            tax = (os.time() + 24 * TaxDays * 60 * 60),
            weight = Warehouses[propertyName].Weight["Default"]
        })

        TriggerClientEvent("Notify",source,"sucesso","Compra realizada com sucesso.",5000)

        BuyedPropertys[propertyName] = true 
        return true 
    end

    return false, TriggerClientEvent("Notify",source,"negado","Saldo Insuficiente.",5000)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EDIT PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
function cO.editPropertys(propertyData,propertyAction)
    local source = source 
    local userId = vRP.getUserId(source)
    if not userId then return end 

    local propertyName = propertyData.property_id
    if not Warehouses[propertyName] then 
        return false 
    end

    if not BuyedPropertys[propertyName] or BuyedPropertys[propertyName] ~= userId then 
        return false, TriggerClientEvent("Notify",source,"negado","Você não possuí permissão.",5000)
    end


    if propertyAction == "rename" then 
        
        TriggerClientEvent("Warehouses:Close",source)
        local nameChange = vRP.prompt(source, "Insira o nome:", "")
        if not nameChange or nameChange == "" then return end 

        oxmysql:query("UPDATE warehouses SET renamed = @renamed WHERE name = @name",{ renamed = nameChange, name = propertyName })

        TriggerClientEvent("Notify",source,"sucesso","O nome foi atualizado.",5000)
        return true 
    elseif propertyAction == "remove-members" then 
        local memberId = parseInt(propertyData.member_id)
        if userId == memberId then 
            return false, TriggerClientEvent("Notify",source,"negado","Você não pode se remover.",5000)
        end

        oxmysql:query("DELETE FROM warehouses WHERE user_id = @id AND name = @name",{ name = propertyName, id = memberId })

        TriggerClientEvent("Notify",source,"sucesso","Membro removido.",5000)

        return true 
    elseif propertyAction == "add-members" then 
        TriggerClientEvent("Warehouses:Close",source)

        local maxMembers = oxmysql:query_async("SELECT COUNT(user_id) as quantidade FROM warehouses WHERE name = @name",{ name = propertyName })[1].quantidade or 0
        if (maxMembers + 1) > Warehouses[propertyName].Slots then 
            return false, TriggerClientEvent("Notify",source,"negado","Limite de chaves atingido.",5000)
        end

        local targetId = vRP.prompt(source, "Insira o passaporte que deseja adicionar:", userId)
        if targetId == "" or not parseInt(targetId) or parseInt(targetId) <= 0 then 
            return 
        end
        
        targetId = parseInt(targetId)
        local targetQuery = oxmysql:query_async("SELECT name FROM warehouses WHERE name = @name AND user_id = @user_id",{ name = propertyName, user_id = targetId })
        if targetQuery[1] then 
            return false, TriggerClientEvent("Notify",source,"negado","O seu amigo já está com a chave.",5000)
        end

        local playerIdentity = vRP.getUserIdentity(userId)
        local targetRequest = vRP.request(source, playerIdentity.nome.." "..playerIdentity.sobrenome.." te convidou para ter acesso a residência : "..propertyName..", deseja aceitar?", 60)
        if not targetRequest then 
            return false, TriggerClientEvent("Notify",source,"negado","O cidadão não aceitou o seu convite.",5000)
        end

        local query = oxmysql:query_async("SELECT weight FROM warehouses WHERE name = @name AND user_id = @user_id",{ name = propertyName, user_id = userId })
        if query[1] then      
            oxmysql:query("INSERT INTO warehouses(user_id,name,owner,tax,weight) VALUES(@user_id,@name,0,@tax,@weight)",{
                user_id = targetId,
                name = propertyName,
                tax = 0,
                weight = query[1].weight
            })

            TriggerClientEvent("Notify",source,"sucesso","O seu amigo foi adicionado.",5000)
            TriggerClientEvent("Notify",source,"sucesso","Você recebeu as chaves da residência : "..propertyName.." .",5000)

            return true 
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDICTIONAL FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function cO.propertyFunctions(propertyName,propertyAction)
    local source = source 
    local userId = vRP.getUserId(source)
    if not userId then return end 

    if not Warehouses[propertyName] then 
        return false 
    end

    if not BuyedPropertys[propertyName] or BuyedPropertys[propertyName] ~= userId then 
        return false, TriggerClientEvent("Notify",source,"negado","Você não possuí permissão.",5000)
    end

    if propertyAction == "garages" then 
        TriggerClientEvent("Warehouses:Close",source)

        local query = oxmysql:query_async("SELECT garages FROM warehouses WHERE name = @name AND user_id = @user_id",{ name = propertyName, user_id = userId })
        if query[1] and query[1].garages == 1 then 
            return false, TriggerClientEvent("Notify",source,"negado","Você já possuí garagem.",5000)
        end

        local requestRes = vRP.request(source, "Deseja adquirir garagem pra residência por <b>R$"..vRP.format(GaragePrice).."</b> ?", 60)
        if requestRes then 
            local paymentRes = vRP.tryFullPayment(userId,parseInt(GaragePrice))
            if not paymentRes then 
                return false, TriggerClientEvent("Notify",source,"negado","Você já possuí garagem.",5000)
            end

            oxmysql:query("UPDATE warehouses SET garages = 1 WHERE name = @name",{ name = propertyName })

            TriggerClientEvent("Notify",source,"sucesso","Você adquiriu a garagem.",5000)
            return true 
        end
    elseif propertyAction == "increase-weight" then 
        local query = oxmysql:query_async("SELECT weight FROM warehouses WHERE name = @name AND user_id = @user_id",{ name = propertyName, user_id = userId })
        if query[1] then      
            if query[1].weight >= Warehouses[propertyName].Weight["Max"] then 
                return false, TriggerClientEvent("Notify",source,"negado","Limite de peso atingido.",5000)
            end

            TriggerClientEvent("Warehouses:Close",source)

            local requestRes = vRP.request(source, "Deseja aumentar "..Warehouses[propertyName].Weight["Default"].."KG no baú por R$"..Warehouses[propertyName].Weight["Default"].." ?", 60)
            if requestRes then 
                local paymentRes = vRP.tryFullPayment(userId,parseInt(Warehouses[propertyName].Weight["Buy"]))
                if paymentRes then 
                    oxmysql:query("UPDATE warehouses SET weight = weight + @weight WHERE name = @name",{ weight = Warehouses[propertyName].Weight["Default"], name = propertyName })
                    TriggerClientEvent("Notify",source,"sucesso","Você aumentou "..Warehouses[propertyName].Weight["Default"].."KG no seu baú",5000)
                end
            else
                TriggerClientEvent("Notify",source,"negado","Saldo insuficiente.",5000)
            end
        end
    elseif propertyAction == "pay-tax" then 
        local query = oxmysql:query_async("SELECT tax FROM warehouses WHERE name = @name AND user_id = @user_id",{ name = propertyName, user_id = userId })
        if query[1] then      
            TriggerClientEvent("Warehouses:Close",source)

            local propertyTax = parseInt((Warehouses[propertyName]["Price"] * TaxPrice))
            local textMessage = os.time() > query[1].tax and "Suas taxas venceram, deseja realizar o pagamento por <b>R$"..vRP.format(propertyTax).."</b> ?" or "Suas taxas irão vencer em: <b>"..os.date("%d/%m/%Y às %H:%M", query[1].tax).."</b>, deseja realizar o pagamento agora?"
            
            local requestRes = vRP.request(source, textMessage, 60)
            if requestRes then 
                local paymentRes = vRP.tryFullPayment(userId,parseInt(Warehouses[propertyName].Weight["Buy"]))
                if not paymentRes then 
                    TriggerClientEvent("Notify",source,"negado","Saldo insuficiente.",5000)
                    return false
                end

                oxmysql:query("UPDATE warehouses SET tax = @tax WHERE name = @name AND user_id = @user_id",{ tax = os.time() + 24 * TaxDays * 60 * 60,  name = propertyName, user_id = userId })
                TriggerClientEvent("Notify",source,"sucesso","Pagamento realizado com sucesso.",5000)
                return true 
            end
        end

    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD SYNC
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    local query = oxmysql:query_async("SELECT name,tax,owner,user_id FROM warehouses")
    for _,v in pairs(query) do 
        if v.owner == 1 then 
            if v.tax ~= nil and v.tax > 0 and os.time() > v.tax then 
                if (os.time() + 24 * RemoveDays * 60 * 60) > v.tax then 
                    oxmysql:query("DELETE FROM warehouses WHERE name = @name",{ name = v.name })
                    local playerSource = vRP.getUserSource(v.user_id)
                    if playerSource then 
                        TriggerClientEvent("Notify",playerSource,"negado","As taxas da propriedade estão atrasadas e a propriedade foi entregue.",5000)
                    end

                    goto continue
                end

                local playerSource = vRP.getUserSource(v.user_id)
                if playerSource then 
                    local propertyTax = parseInt((Warehouses[v.name]["Price"] * TaxPrice))
                    local payTax = vRP.request(playerSource, "As taxas da propriedade "..v.name.." venceu, deseja pagar por R$"..vRP.format(propertyTax).." ?", 60)
                    if payTax and vRP.tryFullPayment(v.user_id,parseInt(propertyTax)) then 
                        oxmysql:query("UPDATE warehouses SET tax = @tax WHERE name = @name AND user_id = @user_id",{
                            tax = os.time() + 24 * TaxDays * 60 * 60,
                            name = v.name,
                            user_id = v.user_id
                        })

                        TriggerClientEvent("Notify",playerSource,"sucesso","As taxas foram pagas com sucesso, próxima cobrança em "..TaxDays.." dias.",5000)
                    end
                end
            end


            BuyedPropertys[v.name] = v.user_id
            ::continue::
        end
    end
end)