------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
propriedades = {}
proprietarios = {}
dentroProp = {}
houseOwner = {}

GlobalState.houseOwner = {}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
criarApartamento = function(interior, tipo,price,chaves, minBau, coords, permissao)
    if config.oxmysql then
        local rows = exports["oxmysql"]:executeSync([[ INSERT INTO mirtin_homes(`interior`,`tipo`,`price`,`chaves`,`minBau`,`coords`,`permissao`) VALUES (?,?,?,?,?,?,?) ]], { interior,tipo,price,chaves,minBau,json.encode({x=coords[1],y=coords[2],z=coords[3]}),permissao })
        if rows then
            local id = rows.insertId
            local newCoords = { x=coords[1], y=coords[2], z=coords[3] }

            propriedades[id] = { interior = interior, tipo = tipo, price = price, coords = newCoords, garagem = "{}", chaves = parseInt(chaves), minBau = minBau, maxMoradores = 5, permissao = permissao, porta = true }

            vCLIENT._updatePropriedadeID(-1, id, propriedades[id])
        end
    else
        vRP.execute("mirtin/criarPropriedade", { interior = interior, tipo = tipo, price = price, chaves = chaves, minBau = minBau, coords = json.encode({x=coords[1],y=coords[2],z=coords[3]}), permissao = permissao })
        refreshHomes()
    end
end

criarCasa = function(interior, tipo,price,minBau, coords, permissao)
    if config.oxmysql then
        local rows = exports["oxmysql"]:executeSync([[ INSERT INTO mirtin_homes(`interior`,`tipo`,`price`,`chaves`,`minBau`,`coords`,`permissao`) VALUES (?,?,?,?,?,?,?) ]], { interior,tipo,price,1,minBau,json.encode({x=coords[1],y=coords[2],z=coords[3]}),permissao })
        if rows then
            local id = rows.insertId
            local newCoords = { x=coords[1], y=coords[2], z=coords[3] }

            propriedades[id] = { interior = interior, tipo = tipo, price = price, coords = newCoords, garagem = "{}", chaves = 1, minBau = minBau, maxMoradores = 5, permissao = permissao, porta = true }

            vCLIENT._updatePropriedadeID(-1, id, propriedades[id])
        end
    else
        vRP.execute("mirtin/criarPropriedade", { interior = interior, tipo = tipo, price = price, chaves = 1, minBau = minBau, coords = json.encode({x=coords[1],y=coords[2],z=coords[3]}), permissao = permissao })
        refreshHomes()
    end
end

criarGaragem = function(id, coords, spawnCoords)
    local id = parseInt(id)
    if id then
        local value = { garagem = { x = coords[1], y = coords[2], z = coords[3] }, spawn = { x = spawnCoords[1], y = spawnCoords[2], z = spawnCoords[3], h = spawnCoords[4]  } }
        vRP.execute("mirtin/criarGaragem", { houseID = id, garagem = json.encode(value) })

        propriedades[id] = { interior = propriedades[id].interior, tipo = propriedades[id].tipo, price = propriedades[id].price, coords = propriedades[id].coords, garagem = value, chaves = parseInt(propriedades[id].chaves), minBau = propriedades[id].minBau, maxMoradores = 5, permissao = propriedades[id].permissao, porta = propriedades[id].porta }
        vCLIENT._updatePropriedadeID(-1, id, propriedades[id])

        if config.lotus then
            TriggerEvent("mirtin:getGarages", propriedades, id)
        end
    end
end

deletarPropriedade = function(id)
    local id = parseInt(id)
    if id then
        vRP.execute("mirtin/deletarPropriedade", { houseID = id })
        vRP.execute("mirtin/deleteUsers", { houseID = id })

        propriedades[parseInt(id)] = nil
        vCLIENT._updatePropriedadeID(-1, id, nil)
    end
end

comprarPropriedade = function(user_id, tipo, id, interior)
    local id = parseInt(id)
    if id then
        if config.lotus then
            if config.oxmysql then
                local rows = exports["oxmysql"]:executeSync([[INSERT INTO mirtin_users_homes (tipo,houseID,proprietario,interior,iptu) VALUES (?,?,?,?,?) ]], { tipo,id,user_id,interior,(os.time() + config.sellHouseIptu*24*60*60) })
                if rows then
                    local rowsID = rows.insertId
                    if rowsID then
                        if proprietarios[user_id] == nil then
                            proprietarios[user_id] = {}
                        end
        
                        proprietarios[user_id][tostring(id)] = { id = rowsID, houseID = id, proprietario = user_id, moradores = "{}", interior = interior, iptu = (os.time() + config.sellHouseIptu*24*60*60), maxChaves = parseInt(propriedades[parseInt(id)].chaves) }
                    end
                end
            else
                vRP.execute("mirtin/comprarPropriedade", { tipo = tipo, houseID = id, proprietario = user_id, interior = interior, iptu = (os.time() + config.sellHouseIptu*24*60*60) })
                refreshMoradores()
            end
        else
            if config.oxmysql then
                local rows = exports["oxmysql"]:executeSync([[INSERT INTO mirtin_users_homes (tipo,houseID,proprietario,interior,iptu) VALUES (?,?,?,?,?) ]], { tipo,id,user_id,interior,os.time() })
                if rows then
                    local rowsID = rows.insertId
                    if rowsID then
                        if proprietarios[user_id] == nil then
                            proprietarios[user_id] = {}
                        end
        
                        proprietarios[user_id][tostring(id)] = { id = rowsID, houseID = id, proprietario = user_id, moradores = "{}", interior = interior, iptu = os.time(), maxChaves = parseInt(propriedades[parseInt(id)].chaves) }
                    end
                end
            else
                vRP.execute("mirtin/comprarPropriedade", { tipo = tipo, houseID = id, proprietario = user_id, interior = interior, iptu = os.time() })
                refreshMoradores()
            end
        end
    end
end

refreshHomes = function()
    local rows = vRP.query("mirtin/allPropriedades", {})
    if rows then
        for k,v in pairs(rows) do
            propriedades[v.id] = { tipo = v.tipo, interior = v.interior, price = v.price, coords = json.decode(v.coords), garagem = json.decode(v.garagem), chaves = v.chaves, minBau = v.minBau, maxMoradores = v.maxMoradores, permissao = v.permissao, porta = true }
        end
        
        vCLIENT._updatePropriedades(-1, propriedades)
        TriggerEvent("mirtin:getGarages", propriedades)
        
        print("^2Propriedades Carregadas: ^0"..#rows)

        refreshMoradores()
    end
end

refreshMoradores = function()
    local rows2 = vRP.query("mirtin/allMoradores", {})
    if #rows2 > 0 then
        for k,v in pairs(rows2) do
            if propriedades[v.houseID] ~= nil then
                if proprietarios[v.proprietario] == nil then
                    proprietarios[v.proprietario] = {}
                end

                proprietarios[v.proprietario][v.houseID] = { id = v.id, houseID = v.houseID, proprietario = v.proprietario, moradores = v.moradores, interior = v.interior, iptu = v.iptu, maxChaves = propriedades[v.houseID].chaves }
                houseOwner[v.houseID] = true
            end
        end        
        GlobalState.houseOwner = houseOwner
    end
end

src.checkIdHouse = function(id)
    local houseId = #vRP.query("mirtin/selecionarPropriedade", { houseID = id })
    if houseId > 0 then
        return true
    end
end

src.returnPropriedades = function()
    return propriedades
end

function checkEnterHouse(user_id, id)
    local owner = vRP.query("mirtin/ownerPropriedade", { houseID = id })
    if #owner > 0 then
        if user_id == parseInt(owner[1].proprietario) then
            return true
        end

        local moradores = json.decode(owner[1].moradores)
        if moradores[tostring(user_id)] ~= nil then
            return true
        end

        if vRP.hasGroup(user_id, "developerlotusgroup@445") or vRP.hasPermission(user_id,"perm.resplog") or vRP.hasPermission(user_id, "diretor.permissao") then
            return true
        end
    end
    return false
end

src.checkEnterHouse = function(id)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local owner = vRP.query("mirtin/ownerPropriedade", { houseID = id })
        if #owner > 0 then
            if user_id == parseInt(owner[1].proprietario) then
                return true
            end

            local moradores = json.decode(owner[1].moradores)
            if moradores[tostring(user_id)] ~= nil then
                return true
            end

            if vRP.hasGroup(user_id, "developerlotusgroup@445") or vRP.hasPermission(user_id,"perm.resplog") or vRP.hasPermission(user_id, "diretor.permissao") then
                return true
            end
        end
    end
end

src.checkEnterAp = function(user_id, id, proprietario) -- return 1 = entra ap, return 2 = toca campanhia, return 3 nao existe esse numero
    local owner = vRP.query("mirtin/allAPOwner", { houseID = id, proprietario = proprietario })
    if #owner > 0 then 
        if parseInt(proprietario) == parseInt(user_id) then
            return 1
        end

        local moradores = json.decode(owner[1].moradores)
        if moradores[tostring(user_id)] ~= nil then
            return 1
        end

        if vRP.hasGroup(user_id, "developerlotusgroup@445") or vRP.hasPermission(user_id,"perm.resplog") or vRP.hasPermission(user_id, "diretor.permissao") then
            return 1
        end

        return 2
    else
        return 3
    end
end

src.syncLock = function(id, status)
    local source = source
    local user_id = vRP.getUserId(source)
    if checkEnterHouse(user_id, id) then
        propriedades[id].porta = status
        vCLIENT._updatePropriedadesLock(-1, id, status)
    else
        TriggerEvent("AC:ForceBan", source, {
            reason = "ABUSO_CASAS_6",
            additionalData = 'FORCANDO SYNCLOCK',
            forceBan = true
        })
    end
end

src.getInfoHouseId = function(id, tipo, proprietario)
    if tipo == "casa" then
        local rows = vRP.query("mirtin/allHomeOwner", { houseID = id  })
        local house = rows[1]

        if #rows > 0 then
            return house.id,house.tipo,house.houseID,house.proprietario,house.moradores,house.bau,house.armario,house.interior,house.iptu
        end

    elseif tipo == "apartamento" then
        local rows = vRP.query("mirtin/allAPOwner", { houseID = id, proprietario = proprietario })
        local house = rows[1]

        if #rows > 0 then
            return house.id,house.tipo,house.houseID,house.proprietario,house.moradores,house.bau,house.armario,house.interior,house.iptu
        end
        
    end
end

local validUsers = {}

exports("isUserValid", function(user_id)
    local src = vRP.getUserSource(user_id)
    local result = validUsers[user_id]
    if result and src and GetPlayerRoutingBucket(src) == result then
        return true
    end

    return false
end)

src.entrarPropriedade = function(id, houseTipo, proprietario)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if houseTipo ~= "apartamento" then
            if not propriedades[id] or propriedades[id].porta then
                TriggerEvent("AC:ForceBan", source, {
                    reason = "ABUSO_CASAS_5",
                    additionalData = 'FORCANDO PORTA | '..houseTipo..' | '..proprietario,
                    forceBan = false
                })
                return false
            end
        end
        local id,tipo,houseID,proprietario,moradores,bau,armario,interior,iptu = src.getInfoHouseId(id, houseTipo, proprietario)
        if proprietario ~= nil then
            if config.interiors[parseInt(interior)] ~= nil then
                local houseInterior = config.interiors[parseInt(interior)]
                if houseInterior then
               
                    houseInterior.id = id
                    houseInterior.tipo = tipo
                    houseInterior.houseID = houseID
                    houseInterior.proprietario = proprietario

                    dentroProp[user_id] = houseID
                    validUsers[user_id] = proprietario
                    SetPlayerRoutingBucket(source, proprietario)
                    vCLIENT._enterCLhouse(source, houseInterior)

                    if config.voip == "pma-voice" then
                        exports["pma-voice"]:updateRoutingBucket(source, proprietario)
                    end
                end
            end
        end
    end
end

src.sairPropriedade = function(id)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        dentroProp[user_id] = nil
        SetPlayerRoutingBucket(source, 0)
        vCLIENT._exitCLhouse(source, id)

        if config.voip == "pma-voice" then
            exports["pma-voice"]:updateRoutingBucket(source, 0)
        end
    end
end

src.checkIsOwner = function(user_id, id)
    local owner = vRP.query("mirtin/allAPOwner", { houseID = id, proprietario = user_id })
    if #owner > 0 then
        return owner[1]
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE GARAGEM
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src.openGaragem = function(id)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local vehicles = src.myVehicles(user_id)

        vCLIENT._openNUIGaragem(source, id, vehicles)
    end
end

src.checkOwnerVehicle = function(garagem, vehicle, placa, motor, lataria, gasolina)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local isMyVehicle = src.isMyVehicle(user_id, vehicle)
        local custom = src.getCustomVehicle(user_id, vehicle, placa)

        if isMyVehicle then
            vCLIENT._spawnarVeiculo(source, garagem, vehicle, placa, motor, lataria, gasolina, custom)
        end
    end
end

src.checkHouseGarage = function(id)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local owner = vRP.query("mirtin/ownerPropriedade", { houseID = id })
        if #owner > 0 then
            if user_id == parseInt(owner[1].proprietario) then
                return true
            end

            local moradores = json.decode(owner[1].moradores)
            if moradores[tostring(user_id)] ~= nil then
                return true
            end
        end

        return false
    end
end

src.checkAPGarage = function(id)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local owner = vRP.query("mirtin/ownerPropriedade", { houseID = id })
        if #owner > 0 then
            for k,v in pairs(owner) do
                if parseInt(v.proprietario) == parseInt(user_id) then
                    return true
                end
            end
        end

        return false
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE BAU
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src.getBau = function(id, houseID, ownerId, interiorType)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        src.openBau(user_id, id, houseID, ownerId, interiorType)
    end
end

src.checkOpenPermission = function(id, proprietario)
    local user_id = vRP.getUserId(source)
    if user_id then
        local owner = vRP.query("mirtin/allAPOwner", { houseID = id, proprietario = proprietario })
        
        if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "perm.resplog") then
            return true
        end

        if #owner > 0 then 
            if parseInt(proprietario) == parseInt(user_id) then
                return true
            end

            local moradores = json.decode(owner[1].moradores)
            if moradores[tostring(user_id)] ~= nil then
                return true
            end
        end

        return false
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE ARMARIO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src.getArmario = function(id, houseID)
    local rows = vRP.query("mirtin/allInfoHome", { id = id })
    if #rows > 0 then
        local armario = json.decode(rows[1].armario) or {}

        local formatArmario = {}
        for k,v in pairs(armario) do
            formatArmario[k] = v
        end

        return formatArmario
    end
end

src.salvarRoupas = function(id, name, custom)
    local rows = vRP.query("mirtin/allInfoHome", { id = id })
    local roupa = json.decode(rows[1].armario)
    if #rows > 0 then
        roupa[name] = custom
        vRP.execute("mirtin_homes/updateArmario", { id = id, armario = json.encode(roupa) })

        return true
    end
end

src.usarRoupas = function(id, name)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local rows = vRP.query("mirtin/allInfoHome", { id = id })
        local roupa = json.decode(rows[1].armario)
        if #rows > 0 then
            src.CuseRoupas(user_id, name, roupa[name])
        end
    end
end

src.deletarRoupa = function(id, name)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local rows = vRP.query("mirtin/allInfoHome", { id = id })
        local roupa = json.decode(rows[1].armario)
        if #rows > 0 then
            roupa[name] = nil
            vRP.execute("mirtin_homes/updateArmario", { id = id, armario = json.encode(roupa) })
            src.CdeletarRoupa(user_id, name)
        end
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE MORADORES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src.checkAddMorador = function(id, houseID)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        src.CaddMorador(user_id, id, houseID)
    end
end

src.checkRemMorador = function(id, houseID, morador)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local rows = vRP.query("mirtin/allInfoHome", { id = id })
        local moradores = json.decode(rows[1].moradores) or {}
        if #rows > 0 then
            moradores[tostring(morador)] = nil
            vRP.execute("mirtin/updateMorador", { id = id, moradores = json.encode(moradores) } )
            src.CremoveMorador(user_id, id,houseID,morador)
        end
    end
end

src.addMorador = function(id, morador, identidade)
    -- TODO: Vulneravel

    -- local rows = vRP.query("mirtin/allInfoHome", { id = id })
    -- local moradores = json.decode(rows[1].moradores) or {}
    -- if #rows > 0 then
    --     moradores[tostring(morador)] = identidade.nome.. " ".. identidade.sobrenome

    --     vRP.execute("mirtin/updateMorador", { id = id, moradores = json.encode(moradores) } )
    -- end
end

src.getMoradores = function(user_id, houseID)
   local source = vRP.getUserSource(user_id)
   local owner = vRP.query("mirtin/allAPOwner", { houseID = houseID, proprietario = user_id })
    if #owner > 0 then 
        local id = owner[1].id
        local moradores = json.decode(owner[1].moradores)

        vCLIENT._openNuiMoradores(source, houseID, id, moradores)
        return true
    else
        return false
    end
end

src.getNation = function()
    return not config.nationgarages
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EVENTOS PADROES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    if user_id then
        vCLIENT._updatePropriedades(source, propriedades)

        if proprietarios[user_id] ~= nil then
            for k,v in pairs(proprietarios[user_id]) do
                if v.iptu then
                    if v.iptu <= os.time() + config.iptuVencimento*24*60*60 then
                        local price = parseInt(propriedades[k].price*config.iptuValue) or 5000
                        TriggerClientEvent("Notify",source,"negado","O IPTU de sua propriedade ["..k.."] está <b>vencido</b>.<br> pague para evitar que sua casa seja vendida automaticamente. <br> <b>Caso deseje pagar pressione [Y]</b><br><b>Caso não deseje pagar pressione [U]</b>", 5)

                        if vRP.hasPermission(user_id, "perm.supremorj") then
                            price = 1
                        elseif vRP.hasPermission(user_id, "perm.altarj") then
                            price = price * 0.5
                        elseif vRP.hasPermission(user_id, "perm.belarp") then
                            price = price * 0.5
                        elseif vRP.hasPermission(user_id, "perm.rubi") then
                            price = price * 0.75
                        elseif vRP.hasPermission(user_id, "perm.safira") then
                            price = price * 0.9
                        else
                            price = price
                        end

                        local payment = vRP.request(source, "Deseja fazer o pagamento do IPTU de sua propriedade no valor de <b>$ "..price.."</b>", 30)
                        if not payment then
                            return
                        end
    
                        if vRP.tryFullPayment(user_id, price) then
                            TriggerClientEvent("Notify",source,"sucesso","Você pagou o IPTU de sua propriedade.<br><b>Vencimento: "..os.date("%d/%m/%Y", (os.time() + config.sellHouseIptu*24*60*60 - config.iptuVencimento*24*60*60)).." </b>", 5)
                            vRP._execute("mirtin/updateIptu", { iptu = (os.time() + config.sellHouseIptu*24*60*60) , id = v.id })
    
                            if proprietarios[user_id] == nil then
                                proprietarios[user_id] = {}
                            end
    
                            proprietarios[user_id][v.houseID] = { id = v.id, houseID = v.houseID, proprietario = v.proprietario, moradores = v.moradores, interior = v.interior, iptu = (os.time() + config.sellHouseIptu*24*60*60), maxChaves = propriedades[v.houseID].chaves }
                        end
                    end
                end
    
                vCLIENT._myHouseBlip(source, propriedades[v.houseID].coords)
            end
        end
    end
end)

AddEventHandler("vRP:playerLeave",function(user_id,source)
    if user_id then
        if dentroProp[user_id] ~= nil then
            vRP.atualizarPosicao(user_id, propriedades[dentroProp[user_id]].coords.x,propriedades[dentroProp[user_id]].coords.y,propriedades[dentroProp[user_id]].coords.z)
            SetPlayerRoutingBucket(source, 0)
            dentroProp[user_id] = nil 
        end
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OTHERS FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end

CreateThread(function()
    Wait(5000)
    refreshHomes()
end)