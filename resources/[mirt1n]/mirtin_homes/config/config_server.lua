
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("mirtin_homes",src)
Proxy.addInterface("mirtin_homes",src)

vCLIENT = Tunnel.getInterface("mirtin_homes")
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MAIN
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
config = {} -- Não mexer
cl_config = {} -- Não Mexer
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local antibug = {}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
config.license = "main" -- não mexa aqui ( isso server para updates exclusivos )
config.oxmysql = true -- CASO USE OXMYSQL
config.createTable = true -- Depois de ligar o script pela 1x coloque false
config.voip = "pma-voice2" -- [ tokovoip / pma-voice / pma-voice2 ]

config.interiors = {
    [1] = { name = "Classe D", coords = vec3(151.43,-1007.8,-98.99), coordsArmario = vec3(151.8,-1000.85,-980.99), coordsBau = vec3(151.29,-1003.09,-98.99), priceInterior = 5000, perm = nil, display = true }, -- ID 1
    [2] = { name = "Classe C",  coords = vec3(3978.17,7451.57,418.68), coordsArmario = vec3(3973.95,7453.23,4180.68), coordsBau = vec3(3974.86,7459.79,418.68), priceInterior = 10000, perm = nil, display = true  }, -- ID 2
    [3] = { name = "Classe B", coords = vec3(3377.81,7944.56,386.15), coordsArmario = vec3(3381.02,7960.54,3840.95), coordsBau = vec3(3382.47,7933.93,385.55), priceInterior = 5000000, perm = nil,  display = true }, -- ID 3
    [4] = { name = "Classe A", coords = vec3(3989.08,7714.15,445.46), coordsArmario = vec3(4006.78,7722.4,4390.26), coordsBau = vec3(3995.14,7725.98,445.46), priceInterior = 7000000, perm = nil,  display = true }, -- ID 4
    [5] = { name = "exclusivo01", coords = vec3(3969.1,7356.19,421.54), coordsArmario = vec3(3966.04,7347.14,4160.15), coordsBau = vec3(3949.46,7357.03,416.13), priceInterior = nil, perm = nil, display = false }, -- ID 5
}

config.mode = "ADM" -- [ ADM, PLAYER ] Escolha o Modo de quem escolhe o interior da casa
config.nationgarages = true -- Caso use nation garages coloque true.

config.lotus = true
config.iptuValue = 0.13-- 7% preço da propriedade
config.iptuVencimento = 7 -- Dias Antes do SELLHOUSE para liberar o pagamento do IPTU ** ATENCAO **
config.sellHouseIptu = 14 -- Dias que a Casa vai ser vendida 

config.permissionLocalizar = "perm.policia" -- Permissao para ter acesso ao comando /home localizar
config.permissionLocalizar2 = "developer.permissao" -- Permissao para ter acesso ao comando /home localizar
config.permissionVer = "perm.policia" -- Permissao para ter acesso ao comando /home ver
config.permissionVer2 = "developer.permissao" -- Permissao para ter acesso ao comando /home ver


config.ipvaVencimento = 15 -- Dias para o vencimento do IPVA ( CASO USE MEU SISTEMA DE GARAGEM )

config.MaxHouses = 3
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMANDOS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('criarcasa445', function(source,args) -- Comando criarcasa
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "perm.top1") then -- permissao para criar a casa
            local plyCoords = GetEntityCoords(GetPlayerPed(source))
            local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]

            local tipo = vRP.prompt(source, "Digite o tipo da propriedade", "casa,apartamento")
            if tipo ~= "" and tipo == "casa" or tipo == "apartamento" then
                local valor = vRP.prompt(source, "Digite o valor da propriedade: ", "")
                if valor ~= "" and tonumber(valor) then
                    if tipo == "apartamento" then

                        if config.mode == "ADM" then
                            local text = ""
                            for k,v in pairs(config.interiors) do
                                text = text.."["..k.."] "..v.name.."\n"
                            end

                            local interior = vRP.prompt(source, "Digite o ID do interior: ", text)
                            if interior ~= "" and tonumber(interior) then
                                if config.interiors[parseInt(interior)] then
                                    local chaves = vRP.prompt(source, "Digite o total de chaves dessa propriedade: ", "")
                                    if chaves ~= "" and tonumber(chaves) then
                                        local minBau = vRP.prompt(source, "Digite o peso do bau: ", "")
                                        if minBau ~= "" and tonumber(minBau) then
                                            local permissao = vRP.prompt(source, "Digite a permissao de quem pode comprar: ", "perm.nil")
                                            if permissao ~= "" then
                                                criarApartamento(interior, tipo, valor, chaves, minBau, {tD(x),tD(y),tD(z)}, permissao)
                                                TriggerClientEvent("Notify",source,"sucesso","Você criou esta propriedade, para criar a garagem use <b>/criargaragem</b>", 5000)
                                            end
                                        end
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Esse Interior não existe.", 5000)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Digite o ID do interior corretamente.", 5000)
                            end
                        else
                            local chaves = vRP.prompt(source, "Digite o total de chaves dessa propriedade: ", "")
                            if chaves ~= "" and tonumber(chaves) then
                                local minBau = vRP.prompt(source, "Digite o peso do bau: ", "")
                                if minBau ~= "" and tonumber(minBau) then
                                    local permissao = vRP.prompt(source, "Digite a permissao de quem pode comprar: ", "perm.nil")
                                    if permissao ~= "" then
                                        criarApartamento(1, tipo, valor, chaves, minBau, {tD(x),tD(y),tD(z)}, permissao)
                                        TriggerClientEvent("Notify",source,"sucesso","Você criou esta propriedade, para criar a garagem use <b>/criargaragem</b>", 5000)
                                    end
                                end
                            end
                        end

                    elseif tipo == "casa" then
                        if config.mode == "ADM" then
                            local text = ""
                            for k,v in pairs(config.interiors) do
                                text = text.."["..k.."] "..v.name.."\n"
                            end

                            local interior = vRP.prompt(source, "Digite o ID do interior: ", text)
                            if interior ~= "" and tonumber(interior) then
                                if config.interiors[parseInt(interior)] then
                                    local minBau = vRP.prompt(source, "Digite o peso do bau: ", "")
                                    if minBau ~= "" and tonumber(minBau) then
                                        local permissao = vRP.prompt(source, "Digite a permissao de quem pode comprar: ", "perm.nil")
                                        if permissao ~= "" then
                                            criarCasa(interior, tipo, valor, minBau, {tD(x),tD(y),tD(z)}, permissao)
                                            TriggerClientEvent("Notify",source,"sucesso","Você criou esta propriedade, para criar a garagem use <b>/criargaragem</b>", 5000)
                                        end
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Esse Interior não existe.", 5000)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Digite o ID do interior corretamente.", 5000)
                            end
                        else
                            local minBau = vRP.prompt(source, "Digite o peso do bau: ", "")
                            if minBau ~= "" and tonumber(minBau) then
                                local permissao = vRP.prompt(source, "Digite a permissao de quem pode comprar: ", "perm.nil")
                                if permissao ~= "" then
                                    criarCasa(1, tipo, valor, minBau, {tD(x),tD(y),tD(z)}, permissao)
                                    TriggerClientEvent("Notify",source,"sucesso","Você criou esta propriedade, para criar a garagem use <b>/criargaragem</b>", 5000)
                                end
                            end
                        end

                    end
                end
            end
        end
    end
end)



local propertysHomes = { 
    [1] = { imterior = 1, chest = 150, price = 5000000 },
    [2] = { imterior = 2, chest = 300, price = 10000000 },
    [3] = { imterior = 3, chest = 500, price = 20000000 },
    [4] = { imterior = 4, chest = 700, price = 50000000 },
    [5] = { imterior = 5, chest = 1000, price = 100000000 },

}
RegisterCommand("casa", function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if not args[1] then return end 

    if not vRP.hasGroup(user_id,"TOP1") then return end
    
    local homeSelected = parseInt(args[1])
    if not propertysHomes[homeSelected] then return end 

    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    criarCasa(propertysHomes[homeSelected].interior, "casa", propertysHomes[homeSelected].price, propertysHomes[homeSelected].chest, {tD(playerCoords.x),tD(playerCoords.y),tD(playerCoords.z)}, "perm.nil")
    TriggerClientEvent("Notify",source,"sucesso","Você criou esta propriedade, para criar a garagem use <b>/criargaragem</b>", 5000)
end)



RegisterCommand('deletarcasa', function(source,args) -- Comando deletarcasa
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "perm.top1") then -- permissao para deletar a casa
            local idProp = vRP.prompt(source, "Digite o ID da propriedade: ", "")
            if idProp ~= nil and tonumber(idProp) then
                if src.checkIdHouse(idProp) then
                    deletarPropriedade(idProp)
                    TriggerClientEvent("Notify",source,"sucesso","Você apagou a propriedade <b>ID: "..idProp.."</b>.", 5000)
                else
                    TriggerClientEvent("Notify",source,"negado","Esta propriedade não existe.", 5000)
                end
            end
        end
    end
end)

RegisterCommand('criargaragem445', function(source,args) -- Comando deletarcasa
    local user_id = vRP.getUserId(source)
    if user_id then
        
        if vRP.hasPermission(user_id, "perm.top1") then -- permissao para deletar a casa
            local idProp = vRP.prompt(source, "Digite o ID da propriedade: ", "")
            if idProp ~= nil and tonumber(idProp) then
                if src.checkIdHouse(idProp) then
                    if vRP.hasGroup(user_id, "valegaragem") then
                        local owner = vRP.query("mirtin/selectProprietario", { proprietario = user_id })
                        if #owner > 0 then
                            for k,v in pairs(owner) do
                                if parseInt(idProp) == parseInt(v.houseID) then
                                    local plyCoords = GetEntityCoords(GetPlayerPed(source))
                                    local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]
                                    if vRP.request(source, "Posicione o veiculo e fique dentro dele", 60) then
                                        local spawnCoords = vCLIENT.getSpawnVehicle(source)
                                        if spawnCoords then
                                            vRP.removeUserGroup(user_id, "valegaragem")
                                            criarGaragem(idProp, {tD(x),tD(y),tD(z)}, spawnCoords)
                                            TriggerClientEvent("Notify",source,"sucesso","Você criou a garagem na propriedade <b>ID: "..idProp.."</b>.", 5000)
                                        else
                                            TriggerClientEvent("Notify",source,"negado","Você precisa está em um veiculo.", 5000)
                                        end
                                    end
                                    return
                                end
                            end

                            TriggerClientEvent("Notify",source,"negado","Está propriedade não é sua.", 5000)
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não possui uma casa.", 5000)
                        end

                        return
                    end

                    local plyCoords = GetEntityCoords(GetPlayerPed(source))
                    local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]
                    if vRP.request(source, "Posicione o veiculo e fique dentro dele", 60) then
                        local spawnCoords = vCLIENT.getSpawnVehicle(source)
                        if spawnCoords then
                            criarGaragem(idProp, {tD(x),tD(y),tD(z)}, spawnCoords)
                            TriggerClientEvent("Notify",source,"sucesso","Você criou a garagem na propriedade <b>ID: "..idProp.."</b>.", 5000)
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa está em um veiculo.", 5000)
                        end
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Esta propriedade não existe.", 5000)
                end
            end
        end
    end
end)

RegisterCommand('home', function(source,args) -- Comando gerais das casas
    local user_id = vRP.getUserId(source)
    if user_id then

        if args[1] == "list" then
            local owner = vRP.query("mirtin/selectProprietario", { proprietario = user_id })
            if #owner == 0 then
                TriggerClientEvent("Notify",source,"negado","Você não possui nenhuma propriedade.", 5000)
                return
            end

            local props = ""
            for k,v in pairs(owner) do
                props = props.."^2(ID: "..v.houseID..")^0 localizada em ^2 "..vCLIENT.getStreetName(source, propriedades[v.houseID].coords.x,propriedades[v.houseID].coords.y,propriedades[v.houseID].coords.z).."^0 .\n"
            end

            TriggerClientEvent('chatMessage', source, {
                type = 'default',
                title = 'PROPRIEDADES',
                message = props
            })
            return
        end

        if args[1] == "iptu" and tonumber(args[2]) then
            local owner = src.checkIsOwner(user_id, tonumber(args[2]))
            if not owner then
                TriggerClientEvent("Notify",source,"negado","Você não é o proprietario dessa casa.", 5)
                return
            end

            if owner.iptu <= os.time() + config.iptuVencimento*24*60*60 then
                TriggerClientEvent("Notify",source,"negado","O IPTU de sua propriedade está <b>vencido</b>.<br> pague para evitar que sua casa seja vendida automaticamente. <br> <b>Caso deseje pagar pressione [Y]</b><br><b>Caso não deseje pagar pressione [U]</b>", 5)
                local price = propriedades[tonumber(args[2])].price*config.iptuValue
                price = tonumber(price)

                if price <= 1000 then
                    price = 1000
                end

                if vRP.hasPermission(user_id, "perm.supremorj") then
                    price = 1
                elseif vRP.hasPermission(user_id, "perm.belarp") then
                    price = price * 0.5
                elseif vRP.hasPermission(user_id, "perm.rubi") then
                    price = price * 0.75
                elseif vRP.hasPermission(user_id, "perm.safira") then
                    price = price * 0.9
                else
                    price = price
                end

                if tonumber(args[2]) == 319 then
                    price = 1
                end
                
                local payment = vRP.request(source, "Deseja fazer o pagamento do IPTU de sua propriedade no valor de <b>$ "..price.."</b>", 30)
                if not payment then
                    return
                end

                if vRP.tryFullPayment(user_id, price) then
                    print("ID: "..user_id.. " PAGOU: "..price.. " CASA: "..owner.id)
                    
                    vRP.execute("mirtin/updateIptu", { iptu = (os.time() + config.sellHouseIptu*24*60*60) , id = owner.id })
                    TriggerClientEvent("Notify",source,"sucesso","Você pagou o IPTU de sua propriedade.<br><b>Vencimento: "..os.date("%d/%m/%Y", (os.time() + config.sellHouseIptu*24*60*60 - config.iptuVencimento*24*60*60)).." </b>", 5)

                    vRP.sendLog('https://discord.com/api/webhooks/1313520349815640124/99iaBDzTQzD1wYmHuIiZbmmOpC8IPvNWW4f3mlaXVbgyBmQ7HyTPYuICh57YP6bUk_i_','ID '..user_id..' pagou R$'..price..' no IPTU de sua propriedade: '..owner.id)
                    
                    if proprietarios[user_id] == nil then
                        proprietarios[user_id] = {}
                    end

                    proprietarios[user_id][owner.id] = { id = proprietarios[user_id][owner.id].id, houseID = proprietarios[user_id][owner.id].houseID, proprietario = proprietarios[user_id][owner.id].proprietario, moradores = proprietarios[user_id][owner.id].moradores, interior = proprietarios[user_id][owner.id].interior, iptu = os.time(), maxChaves = propriedades[owner.id].chaves }
                end

                return
            end

            TriggerClientEvent("Notify",source,"importante","Status: <b>EM DIA</b>.<br>Vencimento: <b>"..os.date("%d/%m/%Y", owner.iptu - config.iptuVencimento*24*60*60).."</b><br>OBS: <b>Mantenha o pagamento em dia e evite que sua casa seja vendida automaticamente.</b>", 5)

            return
        end

        if args[1] == "disp" then
            TriggerClientEvent("Notify",source,"sucesso","Você ativou as marcações das casas/apartamentos disponivel no mapa.", 5000)
            vCLIENT.allDispHouses(source)
            return
        end

        if args[1] == "moradores" and tonumber(args[2]) then
            local moradores = src.getMoradores(user_id, tonumber(args[2]))
            if not moradores then
                TriggerClientEvent("Notify",source,"negado","Você não é o proprietario dessa casa.", 5000)
                return
            end

            return
        end

        if args[1] == "localizar" and tonumber(args[2]) then
            if vRP.hasPermission(user_id, config.permissionLocalizar) or vRP.hasPermission(user_id, config.permissionLocalizar2) or vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "perm.resplog") or vRP.hasPermission(user_id, "perm.respilegal") then

                if propriedades[tonumber(args[2])] == nil then
                    TriggerClientEvent("Notify",source,"negado","Esta propriedade não existe.", 5000)
                    return
                end

                vRPclient._setGPS(source, propriedades[tonumber(args[2])].coords.x,propriedades[tonumber(args[2])].coords.y)
                TriggerClientEvent("Notify",source,"sucesso","Você está localizando a propriedade <b>"..tonumber(args[2]).."</b>", 5000)
                return
            else
                TriggerClientEvent("Notify",source,"negado","Você não possui permissão.", 5000)
                return
            end
        end

        if args[1] == "dono" and tonumber(args[2]) then
            if not vRP.hasPermission(user_id, "admin.permissao") then
                TriggerClientEvent("Notify",source,"negado","Você não possui permissão.", 5000)
                return
            end
            local owner2 = vRP.query("mirtin/ownerPropriedade", { houseID = tonumber(args[2]) })
            if #owner2 > 0 then
                local idcasa = nil
                local idproprietario = nil
                for k,v in pairs(owner2) do
                    idproprietario = v.proprietario
                end
                TriggerClientEvent('Notify', source,'sucesso', '[PROPRIETARIO]: '..idproprietario.." ", 30000)
            else
                TriggerClientEvent('Notify', source,'sucesso', 'Está propriedade está livre!', 10000)
                return
            end

            return
        end
        
        if args[1] == "info" and tonumber(args[2]) then
            if not vRP.hasPermission(user_id, "perm.imobiliaria") and (not vRP.hasPermission(user_id, "developer.permissao") or not vRP.hasPermission(user_id, "diretor.permissao") or not vRP.hasPermission(user_id, "perm.resplog")) then
                TriggerClientEvent("Notify",source,"negado","Você não possui permissão.", 5000)
                return
            end
            local owner2 = vRP.query("mirtin/ownerPropriedade", { houseID = tonumber(args[2]) })
            if #owner2 > 0 then
                local idcasa = nil
                local idproprietario = nil
                for k,v in pairs(owner2) do
                    idproprietario = v.proprietario
                end
                local identity = vRP.getUserIdentity(tonumber(idproprietario))
                TriggerClientEvent('Notify', source,'sucesso', '[PROPRIETARIO]: '..idproprietario.."<br> [TELEFONE] "..identity.telefone.."", 30000)
            else
                TriggerClientEvent('Notify', source,'sucesso', 'Está propriedade está livre!', 10000)
                return
            end

            return
        end

        if args[1] == "ver" and tonumber(args[2]) then
            if vRP.hasPermission(user_id, config.permissionLocalizar) or vRP.hasPermission(user_id, "perm.respilegal") or vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "perm.resplog") or vRP.hasPermission(user_id, config.permissionLocalizar2) then


                local owner = vRP.query("mirtin/selectProprietario", { proprietario = tonumber(args[2]) })
                if #owner == 0 then
                    TriggerClientEvent("Notify",source,"negado","Este jogador não possui nenhuma propriedade.", 5000)
                    return
                end

                local props = ""
                for k,v in pairs(owner) do
                    props = props.."^2(ID: "..v.houseID..")^0 localizada em ^2 "..vCLIENT.getStreetName(source, propriedades[v.houseID].coords.x,propriedades[v.houseID].coords.y,propriedades[v.houseID].coords.z).."^0 .\n"
                end

                TriggerClientEvent('chatMessage', source, {
                    type = 'default',
                    
                    title = 'PROPRIEDADES',
                    message = props
                })

                return
            else
                TriggerClientEvent("Notify",source,"negado","Você não possui permissão.", 5000)
            end
        end

        if args[1] == "vender" and tonumber(args[2]) then
            local owner = src.checkIsOwner(user_id, tonumber(args[2]))
            if not owner then
                TriggerClientEvent("Notify",source,"negado","Você não é o proprietario dessa casa.", 5)
                return
            end

            local nplayer = vRPclient.getNearestPlayer(source, 3)
            if nplayer == nil then
                TriggerClientEvent("Notify",source,"negado","Nenhum jogador proximo.", 5)
                return
            end

            local nuser_id = vRP.getUserId(nplayer)
            local value = vRP.prompt(source, "Digite o valor que deseja vender", "")
            if value == "" or value == nil or not tonumber(value) or tonumber(value) <= 0 then
                TriggerClientEvent("Notify",source,"negado","Digite o valor corretamente.", 5)
                return
            end

            local confirm = vRP.request(source, "Tem certeza que você deseja vender essa propriedade por <b>$ "..vRP.format(value).."</b> para o id <b>"..nuser_id.."</b>?", 30)
            if not confirm then
                return
            end
            TriggerClientEvent("Notify",source,"importante","Proposta enviada... aguarde o jogador", 5)

            local confirm = vRP.request(nplayer, "Você deseja comprar esta propriedade por <b>$ "..vRP.format(value).."</b> do id <b>"..user_id.."</b>?", 30)
            if not confirm then
                return
            end

            if GetPlayerRoutingBucket(source) ~= 0 or GetPlayerRoutingBucket(nplayer) ~= 0 then
                TriggerClientEvent("Notify",source,"negado","O comprador e o vendedor precisam estar fora da casa", 5)
                TriggerClientEvent("Notify",nplayer,"negado","O comprador e o vendedor precisam estar fora da casa", 5)
                return 
            end

            if not vRP.tryFullPayment(nuser_id, parseInt(value)) then
                TriggerClientEvent("Notify",source,"negado","O Jogador não possui dinheiro.", 5)
                TriggerClientEvent("Notify",nplayer,"negado","Você não possui dinheiro.", 5)
                return
            end

            vRP.giveMoney(user_id, parseInt(value))
            TriggerClientEvent("Notify",source,"sucesso","O Jogador aceitou a proposta, <b>propriedade vendida.</b>", 5)
            TriggerClientEvent("Notify",nplayer,"sucesso","Parabens!!!, você acabou de comprar essa propriedade.", 5)

            vRP.sendLog("https://discord.com/api/webhooks/1313520191447240734/6NsSoZeLj8A_2RyGWnrMl5sxGUzlEKsDsWO-Nr3Ufkv5dj6JM8DIIo6qFRhA6w2JupgS", "```prolog\n[USER_ID]: "..user_id.."\n[VENDEU A CASA]: "..tonumber(args[2]).."\n[VALOR]: "..value.."\n[PARA]: "..nuser_id.."```")
            

            vRP.execute("mirtin/updateOwner", { proprietario = nuser_id, id = owner.id })
            vRP.execute("mirtin/updateBau", { bau = "{}", id = owner.id }) -- Limpa o baú ao vender a casa

            if proprietarios[nuser_id] == nil then
                proprietarios[nuser_id] = {}
            end

            if  proprietarios[user_id][owner.id] then
                proprietarios[nuser_id][owner.id] = { id = proprietarios[user_id][owner.id].id, houseID = proprietarios[user_id][owner.id].houseID, proprietario = proprietarios[user_id][owner.id].proprietario, moradores = proprietarios[user_id][owner.id].moradores, interior = proprietarios[user_id][owner.id].interior, iptu = os.time(), maxChaves = propriedades[owner.id].chaves }
                proprietarios[user_id][owner.id] = nil
            end
            
            return
        end

        
        TriggerClientEvent('chatMessage', source, {
            type = 'default',
            
            title = 'PROPRIEDADES',
            message = "^1[COMANDOS]: \n^2/home list ^0 - mostra lista dos ids de suas propriedades\n^2/home disp^0 - mostra a lista de propriedades disponivel para comprar\n^2/home iptu [houseID]^0 - para consultar/pagar o iptu\n^2/home moradores [houseID]^0 - mostra a lista de moradores em sua propriedade\n^2/home vender [houseID]^0 - vende a sua propriedade\n^2/home localizar [houseID]^0 - localiza a propriedade no mapa (policiais)\n^2/home ver [userID] ^0 - ve a lista de propriedades do jogador (policiais)   "
        })
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE PROPRIEDADES
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src.comprarPropriedade = function(id, tipo)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local allprops = vRP.query("mirtin/selectProprietario", { proprietario = user_id })
        if #allprops >= config.MaxHouses then
            TriggerClientEvent("Notify",source,"negado","Limite de casas atingido", 5000)
            return
        end

        local owner = vRP.query("mirtin/ownerPropriedade", { houseID = id })

        if tipo == "casa" then
            if #owner > 0 then
                return true
            end

            if propriedades[id].permissao ~= "perm.nil" then
                if not vRP.hasPermission(user_id, propriedades[id].permissao) then
                    TriggerClientEvent("Notify",source,"negado","Você não tem permissao pra comprar essa propriedade.", 5000)
                    return
                end
            end

            if antibug[id] or not antibug[id] == nil then
                return
            end
            antibug[id] = true

            local confirm = vRP.request(source, "Esta propriedade não possui um proprietario deseja comprar-la?", 30) 
            if not confirm then
                antibug[id] = false
                return
            end

            if config.mode == "ADM" then
                if vRP.hasGroup(user_id, "valecasa") then
                    if vRP.request(source, "Você deseja comprar está propriedade pelo seu <b>Vale Casa</b> ?", 30) then
                        vRP.removeUserGroup(user_id, "valecasa")
                        comprarPropriedade(user_id, tipo, id, parseInt(propriedades[id].interior))
                        TriggerClientEvent("Notify",source,"sucesso","Parabens, Você acaba de adquirir essa propriedade digite <b>/home</b> para acessar os comandos.", 5000)
                        antibug[id] = false
                        return
                    end
                end

                local pagamento = parseInt(propriedades[id].price)
                if vRP.hasGroup(user_id, "valecasa5kk") then
                    if pagamento > 0 and pagamento <= 5000000 then
                        if vRP.request(source, "Você deseja comprar está propriedade pelo seu <b>Vale Casa 5KK</b> ?", 30) then
                            vRP.removeUserGroup(user_id, "valecasa5kk")
                            comprarPropriedade(user_id, tipo, id, parseInt(propriedades[id].interior))
                            TriggerClientEvent("Notify",source,"sucesso","Parabens, Você acaba de adquirir essa propriedade digite <b>/home</b> para acessar os comandos.", 5000)
                            antibug[id] = false
                            return
                        end
                    end
                end

                if vRP.hasGroup(user_id, "valecasa7kk") then
                    if pagamento > 0 and pagamento <= 7000000 then
                        if vRP.request(source, "Você deseja comprar está propriedade pelo seu <b>Vale Casa 7KK</b> ?", 30) then
                            vRP.removeUserGroup(user_id, "valecasa7kk")
                            comprarPropriedade(user_id, tipo, id, parseInt(propriedades[id].interior))
                            TriggerClientEvent("Notify",source,"sucesso","Parabens, Você acaba de adquirir essa propriedade digite <b>/home</b> para acessar os comandos.", 5000)
                            antibug[id] = false
                            return
                        end
                    end
                end

                if vRP.hasGroup(user_id, "valecasa10kk") then
                    if pagamento > 0 and pagamento <= 10000000 then
                        if vRP.request(source, "Você deseja comprar está propriedade pelo seu <b>Vale Casa 10KK</b> ?", 30) then
                            vRP.removeUserGroup(user_id, "valecasa10kk")
                            comprarPropriedade(user_id, tipo, id, parseInt(propriedades[id].interior))
                            TriggerClientEvent("Notify",source,"sucesso","Parabens, Você acaba de adquirir essa propriedade digite <b>/home</b> para acessar os comandos.", 5000)
                            antibug[id] = false
                            return
                        end
                    end
                end
                
                if vRP.hasGroup(user_id, "valecasa100kk") then
                    if pagamento > 0 and pagamento <= 100000000 then
                        if vRP.request(source, "Você deseja comprar está propriedade pelo seu <b>Vale Casa 100KK</b> ?", 30) then
                            vRP.removeUserGroup(user_id, "valecasa100kk")
                            comprarPropriedade(user_id, tipo, id, parseInt(propriedades[id].interior))
                            TriggerClientEvent("Notify",source,"sucesso","Parabens, Você acaba de adquirir essa propriedade digite <b>/home</b> para acessar os comandos.", 5000)
                            antibug[id] = false
                            return
                        end
                    end
                end

                if propriedades[id].permissao == "valecasa.permissao" then
                    TriggerClientEvent("Notify",source,"negado","Você so pode comprar essa propriedade com vale-casa..", 5000)
                    antibug[id] = false
                    return
                end
               
                if vRP.request(source, "Você deseja comprar está propriedade por <b>$ ".. vRP.format(pagamento) .. " </b> ?", 30) then
                    if vRP.tryFullPayment(user_id, parseInt(pagamento)) then
                        comprarPropriedade(user_id, tipo, id, parseInt(propriedades[id].interior))
                        TriggerClientEvent("Notify",source,"sucesso","Parabens, Você acaba de adquirir essa propriedade digite <b>/home</b> para acessar os comandos.", 5000)
                        vRP.sendLog('https://discord.com/api/webhooks/1313519711643766856/WdN_oGMSw1Gyk8-mowthpseGB6kMNgvoPLnR66beOjnTBkrNH36XDRN3YDvflbdcY_6A', "```prolog\n[USER_ID]: "..user_id.."\n[COMPROU A CASA]: "..id.."\n[VALOR]: "..pagamento.."```")
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não possui dinheiro.", 5000)
                    end
                end
            end

            antibug[id] = false
            return
        end  

        if tipo == "apartamento" then
            if id == 2156 and vRP.hasGroup(user_id, 'valeapartamento') then
                if vRP.request(source, "Você deseja comprar está propriedade pelo seu <b>Vale Apartamento</b> ?", 30) then
                    vRP.removeUserGroup(user_id, "valeapartamento")
                    comprarPropriedade(user_id, tipo, id, parseInt(propriedades[id].interior))
                    TriggerClientEvent("Notify",source,"sucesso","Parabens, Você acaba de adquirir essa propriedade digite <b>/home</b> para acessar os comandos.", 5000)
                    antibug[id] = false
                    vRP.sendLog('', 'O USUARIO '..user_id..' COMPROU A PROPRIEDADE COM VALE APARTAMENTO '..id)
                    return
                end
            end

            if #owner >= propriedades[id].chaves then
                TriggerClientEvent("Notify",source,"negado","O numero de vagas nesse apartamento está cheia.", 5000)
                return
            end

            local owner2 = vRP.query("mirtin/allAPOwner", { houseID = id, proprietario = user_id })
            if #owner2 > 0 then
                TriggerClientEvent("Notify",source,"negado","Você já possui uma propriedade aqui.", 5000)
                return
            end

            if propriedades[id].permissao ~= "perm.nil" then
                if not vRP.hasPermission(user_id, propriedades[id].permissao) then
                    TriggerClientEvent("Notify",source,"negado","Você não tem permissao pra comprar essa propriedade.", 5000)
                    return
                end
            end

            if antibug[id] or not antibug[id] == nil then
                return
            end
            antibug[id] = true

            local confirm = vRP.request(source, "Esta propriedade não possui um proprietario deseja comprar-la?", 30)
            if not confirm then
                antibug[id] = false
                return
            end

            if config.mode == "ADM" then
                if vRP.hasGroup(user_id, "valecasa") then
                    if vRP.request(source, "Você deseja comprar está propriedade pelo seu <b>Vale Casa</b> ?", 30) then
                        vRP.removeUserGroup(user_id, "valecasa")
                        comprarPropriedade(user_id, tipo, id, parseInt(propriedades[id].interior))
                        TriggerClientEvent("Notify",source,"sucesso","Parabens, Você acaba de adquirir essa propriedade digite <b>/home</b> para acessar os comandos.", 5000)
                        antibug[id] = false
                        vRP.sendLog('', 'O USUARIO '..user_id..' COMPROU A PROPRIEDADE COM VALE CASA'..id)
                        return
                    end
                end

                local pagamento = parseInt(propriedades[id].price)
                if vRP.hasGroup(user_id, "valecasa5kk") then
                    if pagamento > 0 and pagamento <= 5000000 then
                        if vRP.request(source, "Você deseja comprar está propriedade pelo seu <b>Vale Casa 5KK</b> ?", 30) then
                            vRP.removeUserGroup(user_id, "valecasa5kk")
                            comprarPropriedade(user_id, tipo, id, parseInt(propriedades[id].interior))
                            TriggerClientEvent("Notify",source,"sucesso","Parabens, Você acaba de adquirir essa propriedade digite <b>/home</b> para acessar os comandos.", 5000)
                            antibug[id] = false
                            vRP.sendLog('', 'O USUARIO '..user_id..' COMPROU A PROPRIEDADE COM VALE CASA'..id)
                            return
                        end
                    end
                end

                if vRP.hasGroup(user_id, "valecasa7kk") then
                    if pagamento > 0 and pagamento <= 7000000 then
                        if vRP.request(source, "Você deseja comprar está propriedade pelo seu <b>Vale Casa 7KK</b> ?", 30) then
                            vRP.removeUserGroup(user_id, "valecasa7kk")
                            comprarPropriedade(user_id, tipo, id, parseInt(propriedades[id].interior))
                            TriggerClientEvent("Notify",source,"sucesso","Parabens, Você acaba de adquirir essa propriedade digite <b>/home</b> para acessar os comandos.", 5000)
                            antibug[id] = false
                            vRP.sendLog('', 'O USUARIO '..user_id..' COMPROU A PROPRIEDADE COM VALE CASA'..id)
                            return
                        end
                    end
                end

                if vRP.hasGroup(user_id, "valecasa10kk") then
                    if pagamento > 0 and pagamento <= 10000000 then
                        if vRP.request(source, "Você deseja comprar está propriedade pelo seu <b>Vale Casa 10KK</b> ?", 30) then
                            vRP.removeUserGroup(user_id, "valecasa10kk")
                            comprarPropriedade(user_id, tipo, id, parseInt(propriedades[id].interior))
                            TriggerClientEvent("Notify",source,"sucesso","Parabens, Você acaba de adquirir essa propriedade digite <b>/home</b> para acessar os comandos.", 5000)
                            antibug[id] = false
                            vRP.sendLog('', 'O USUARIO '..user_id..' COMPROU A PROPRIEDADE COM VALE CASA'..id)
                            return
                        end
                    end
                end
                
                if vRP.hasGroup(user_id, "valecasa100kk") then
                    if pagamento > 0 and pagamento <= 100000000 then
                        if vRP.request(source, "Você deseja comprar está propriedade pelo seu <b>Vale Casa 100KK</b> ?", 30) then
                            vRP.removeUserGroup(user_id, "valecasa100kk")
                            comprarPropriedade(user_id, tipo, id, parseInt(propriedades[id].interior))
                            TriggerClientEvent("Notify",source,"sucesso","Parabens, Você acaba de adquirir essa propriedade digite <b>/home</b> para acessar os comandos.", 5000)
                            antibug[id] = false
                            vRP.sendLog('', 'O USUARIO '..user_id..' COMPROU A PROPRIEDADE COM VALE CASA'..id)
                            return
                        end
                    end
                end

                if propriedades[id].permissao == "valecasa.permissao" then
                    TriggerClientEvent("Notify",source,"negado","Você so pode comprar essa propriedade com vale-casa..", 5000)
                    antibug[id] = false
                    return
                end
               
                if vRP.request(source, "Você deseja comprar está propriedade por <b>$ ".. vRP.format(pagamento) .. " </b> ?", 30) then
                    if vRP.tryFullPayment(user_id, parseInt(pagamento)) then
                        comprarPropriedade(user_id, tipo, id, parseInt(propriedades[id].interior))
                        TriggerClientEvent("Notify",source,"sucesso","Parabens, Você acaba de adquirir essa propriedade digite <b>/home</b> para acessar os comandos.", 5000)
                        vRP.sendLog('', 'USUARIO '..user_id..' COMPROU A PROPRIEDADE '..id)
                    else
                        TriggerClientEvent("Notify",source,"negado","Você não possui dinheiro.", 5000)
                    end
                end
            end
            
            antibug[id] = false
            return
        end
        
    end
end

src.interfone = function(id) 
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    if user_id then
        local interfone = vRP.prompt(source, "Digite o Intefone: ", "")
        if interfone ~= nil and tonumber(interfone) then
            local ap = src.checkEnterAp(parseInt(user_id), id, parseInt(interfone))
            if ap == 1 then
                vCLIENT.enterAP(source, id, interfone)
                return
            end

            if ap == 2 then
                local pSource = vRP.getUserSource(parseInt(interfone))
                if pSource then 
                    TriggerClientEvent("Notify",source,"sucesso","Você tocou o interfone, aguarde o proprietario lhe atender.", 5000)
                    if vRP.request(pSource, "<b>INTERFONE:</b> O Cidadão <b>"..identity.nome.." "..identity.sobrenome.."</b> está tocando o interfone da sua propriedade <b>("..id..")</b> deseja permitir acesso? ", 30) then
                        vCLIENT.enterAP(source, id, interfone)
                    else
                        TriggerClientEvent("Notify",source,"negado","O proprietario não autorizou sua entrada.", 5000)
                    end

                    vRP.sendLog('', 'ID: '..user_id..' tocou o interfone da propriedade ('..id..') do ID: '..parseInt(interfone))
                else
                    TriggerClientEvent("Notify",source,"negado","O proprietario não se encontra na cidade.", 5000)
                end
                return
            end

            if ap == 3 then
                TriggerClientEvent("Notify",source,"negado","Este interfone não existe.", 5000)
                return
            end
        end
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DA GARAGEM
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src.myVehicles = function(user_id) -- Captura seus Veiculos
    local source = vRP.getUserSource(user_id)
    local myVehs = vRP.query("mirtin_homes/myVehicles", {user_id = user_id})

    local vehicles = {}
    for k,v in pairs(myVehs) do
        v["veiculo"] = v.veiculo
        v["name"] = string.upper(v.veiculo)
        v["placa"] = v.placa -- Caso nao use placa modificada troque por vRPclient.getRegistrationNumber(source)
        v["detido"] = v.status == 0 -- Se voce usa outro tipo de garagem, alterar para [ v.detido ]
        v["retido"] = v.status == 0 -- Se voce usa outro tipo de garagem, alterar para [ v.retido ]
        v["ipva"] = v.ipva+config.ipvaVencimento*24*60*60 > os.time()
        v["motor"] = v.motor
        v["lataria"] = v.lataria
        v["gasolina"] = v.gasolina
        vehicles[k] = v
    end

    return vehicles
end

src.isMyVehicle = function(user_id, veiculo) -- Verifica se o veiculo realmente existe na garagem dele
    local source = vRP.getUserSource(user_id)
    local myVehs = vRP.query("mirtin_homes/isMyVehicle", {user_id = user_id, veiculo = veiculo})
    if #myVehs == 0 then -- Caso queira criar um LOG de tentativa de NUI injection
        TriggerClientEvent("Notify",source,"negado","Este Veiculo não existe na sua garagem.", 5)
        return
    end

    veiculo = myVehs[1] 
    ipva = veiculo.ipva+config.ipvaVencimento*24*60*60 < os.time()
    detido = veiculo.status > 0 -- Se voce usa outro tipo de garagem, alterar para [ veiculo.detido ]
    retido = veiculo.status > 0 -- Se voce usa outro tipo de garagem, alterar para [ veiculo.retido ]

    if ipva or detido or retido  then
        TriggerClientEvent("Notify",source,"negado","Veiculos com debito(s) pendente, vá ate alguma garagem para regularizar.", 5)
        return
    end

    return true
end

src.getCustomVehicle = function(user_id, veiculo) -- Captura a tunagem do veiculo
    local source = vRP.getUserSource(user_id)
    local myVehs = vRP.query("mirtin_homes/isMyVehicle", {user_id = user_id, veiculo = veiculo})
    if #myVehs == 0 then
        TriggerClientEvent("Notify",source,"negado","Ocorreu um Erro.", 5)
        return
    end

    return json.decode(myVehs[1].tunagem) or {}
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE BAU
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src.openBau = function(user_id, id, houseId, ownerId, interiorType)
    local source = vRP.getUserSource(user_id)
    local houseChestValue = propriedades[houseId].minBau
    if interiorType == 'apartamento' then
        houseId = tostring(houseId)..':'..tostring(ownerId)
    end
    TriggerClientEvent("mirt1n:myHouseChest", source, id, houseId, houseChestValue)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DO ARMARIO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src.CsalvarRoupa = function(id)
    local source = source 
    local user_id = vRP.getUserId(source)
    if user_id then
        local nameRoupa = vRP.prompt(source, "Digite o nome da roupa:", "")
        if nameRoupa == nil or nameRoupa == "" then
            TriggerClientEvent("Notify",source,"negado","Digite os parametros corretamente", 5000)
            return
        end
        
        if string.len(nameRoupa) <= 0 or string.len(nameRoupa) >= 30 then
            TriggerClientEvent("Notify",source,"negado","Digite 1-30 caracteres.", 5000)
            return
        end

        if src.salvarRoupas(id, nameRoupa, vRPclient.getCustomization(source)) then
            TriggerClientEvent("Notify",source,"sucesso","Você guardou a roupa <b>"..nameRoupa.."</b> no armario.", 5000)
        end
    end
end

src.CuseRoupas = function(user_id, name, custom)
    local source = vRP.getUserSource(user_id)
    vRPclient._setCustomization(source, custom)
    TriggerClientEvent("Notify",source,"sucesso","Você utilizou a roupa <b>"..name.."</b> do armario.", 5000)
end

src.CdeletarRoupa = function(user_id, name)
    local source = vRP.getUserSource(user_id)
    TriggerClientEvent("Notify",source,"negado","Você apagou a roupa <b>"..name.."</b> do armario.", 5000)
end

src.ServerConfig = function()
    return config -- Retornar essas configurações para o client
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE MORADORES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src.CaddMorador = function(user_id, id, houseID)
    local source = vRP.getUserSource(user_id)
    local idMorador = vRP.prompt(source, "Digite o ID do morador: ", "")
    if idMorador == "" or not tonumber(idMorador) or idMorador == nil then
        TriggerClientEvent("Notify",source,"negado","Digite o ID corretamente.", 5000)
        return
    end

    local nsource = vRP.getUserSource(tonumber(idMorador))
    if not nsource then
        TriggerClientEvent("Notify",source,"negado","Jogador não se encontra na cidade.", 5000)
        return
    end

    if parseInt(user_id) == parseInt(idMorador) then
        TriggerClientEvent("Notify",source,"negado","Você não pode fazer isso.", 5000)
        return
    end

    TriggerClientEvent("Notify",source,"sucesso","Aguarde o jogador aceitar...", 5000)

    local accept = vRP.request(nsource, "O Proprietario da casa <b>"..houseID.."</b> esta te dando a chave, deseja aceitar?", 30)
    if not accept then
        TriggerClientEvent("Notify",source,"negado","O Jogador recusou sua proposta.", 5000)
        return
    end

    local identity = vRP.getUserIdentity(tonumber(idMorador))
    identity.nome = identity.nome
    identity.sobrenome = identity.sobrenome

    src.addMorador(id, tonumber(idMorador), identity)
    TriggerClientEvent("Notify",source,"sucesso","O Jogador aceitou, você adicinou o "..tonumber(idMorador).." como novo morador de sua propriedade", 5000)
end

src.CremoveMorador = function(user_id, id,houseID,morador)
    local source = vRP.getUserSource(user_id)
    TriggerClientEvent("Notify",source,"negado","Você removeu o id "..tonumber(morador).." de morador da sua propriedade", 5000)
end


Citizen.CreateThread(function()
    local query = vRP.query("mirtin/getHousesIPTU", {})
    if #query > 0 then
        for k, v in pairs(query) do
            local currentTime = os.time()
            local iptuDueDate = tonumber(v.iptu) + (config.iptuVencimento*24*60*60)
                
            if currentTime > iptuDueDate then
                -- TriggerClientEvent('chatMessage', -1, "^0A Propriedade ^1(ID: "..tonumber(v.houseID)..") ^0 foi vendida automaticamente por falta de pagamentos a impostos.")
                vRP.execute("mirtin/deleteUserProp", { id = v.id })
                print("ID CASA: "..v.houseID.. " DONO: "..v.proprietario.. " Vendida!")
                houseOwner[v.houseID] = nil
            end
        end

        GlobalState.houseOwner = houseOwner
    end
end)

RegisterCommand('sellh', function(source,args)
    local query = vRP.query("mirtin/getHousesIPTU", {})
    if #query > 0 then
        for k, v in pairs(query) do
            local currentTime = os.time()
            local iptuDueDate = tonumber(v.iptu) + (config.iptuVencimento*24*60*60)
                
            if currentTime > iptuDueDate then
                -- TriggerClientEvent('chatMessage', -1, "^0A Propriedade ^1(ID: "..tonumber(v.houseID)..") ^0 foi vendida automaticamente por falta de pagamentos a impostos.")
                vRP.execute("mirtin/deleteUserProp", { id = v.id })
                print("ID CASA: "..v.houseID.. " DONO: "..v.proprietario.. " Vendida!")
                houseOwner[v.houseID] = nil
                vRP.sendLog('', 'ID CASA: '..v.houseID.. ' DONO: '..v.proprietario.. ' Vendida!')
            end
        end

        GlobalState.houseOwner = houseOwner
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QUERYS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("mirtin/allPropriedades","SELECT * FROM mirtin_homes")
vRP.prepare("mirtin/allMoradores","SELECT * FROM mirtin_users_homes")
vRP.prepare("mirtin/criarPropriedade","INSERT INTO mirtin_homes(interior,tipo,price,chaves,minBau,coords,permissao) VALUES(@interior, @tipo,@price,@chaves,@minBau,@coords,@permissao);")
vRP.prepare("mirtin/selecionarPropriedade","SELECT * FROM mirtin_homes WHERE id = @houseID")
vRP.prepare("mirtin/deletarPropriedade","DELETE FROM mirtin_homes WHERE id = @houseID")
vRP.prepare("mirtin/comprarPropriedade","INSERT INTO mirtin_users_homes (tipo,houseID,proprietario,interior,iptu) VALUES(@tipo,@houseID,@proprietario,@interior,@iptu)")
vRP.prepare("mirtin/ownerPropriedade","SELECT * FROM mirtin_users_homes WHERE houseID = @houseID")
vRP.prepare("mirtin/allHomeOwner","SELECT * FROM mirtin_users_homes WHERE houseID = @houseID")
vRP.prepare("mirtin/allAPOwner","SELECT * FROM mirtin_users_homes WHERE houseID = @houseID AND proprietario = @proprietario")
vRP.prepare("mirtin/criarGaragem","UPDATE mirtin_homes SET garagem = @garagem WHERE id = @houseID")
vRP.prepare("mirtin_homes/myVehicles","SELECT * FROM vrp_user_veiculos WHERE user_id = @user_id")
vRP.prepare("mirtin_homes/isMyVehicle","SELECT * FROM vrp_user_veiculos WHERE user_id = @user_id AND veiculo = @veiculo ")
vRP.prepare("mirtin_homes/updateArmario","UPDATE mirtin_users_homes SET armario = @armario WHERE id = @id")
vRP.prepare("mirtin/allInfoHome","SELECT * FROM mirtin_users_homes WHERE id = @id")
vRP.prepare("mirtin/updateBau","UPDATE mirtin_users_homes SET bau = @bau WHERE id = @id") 
vRP.prepare("mirtin/updateMorador","UPDATE mirtin_users_homes SET moradores = @moradores WHERE id = @id")
vRP.prepare("mirtin/selectProprietario","SELECT * FROM mirtin_users_homes WHERE proprietario = @proprietario")
vRP.prepare("mirtin/updateIptu","UPDATE mirtin_users_homes SET iptu = @iptu WHERE id = @id")
vRP.prepare("mirtin/updateOwner","UPDATE mirtin_users_homes SET proprietario = @proprietario WHERE id = @id")
vRP.prepare("mirtin/deleteUserProp","DELETE FROM mirtin_users_homes WHERE id = @id")
vRP.prepare("mirtin/deleteUsers","DELETE FROM mirtin_users_homes WHERE houseID = @houseID")
vRP._prepare("mirtin/getHousesIPTU", "SELECT id,houseID,proprietario,iptu FROM mirtin_users_homes WHERE iptu < UNIX_TIMESTAMP()")
vRP._prepare("mirtin/createDB",[[ CREATE TABLE IF NOT EXISTS `mirtin_homes` ( `id` int(11) NOT NULL AUTO_INCREMENT, `tipo` varchar(15000) NOT NULL, `price` int(11) NOT NULL, `coords` varchar(50) NOT NULL, `garagem` text DEFAULT '{}', `chaves` int(11) DEFAULT NULL, `minBau` int(11) NOT NULL, `permissao` varchar(50) NOT NULL, `interior` int(11) NOT NULL DEFAULT 1, `maxMoradores` int(11) DEFAULT NULL, PRIMARY KEY (`id`) ) ENGINE=InnoDB DEFAULT CHARSET=latin1; ]])
vRP._prepare("mirtin/createDB2",[[ CREATE TABLE IF NOT EXISTS `mirtin_users_homes` ( `id` int(11) NOT NULL AUTO_INCREMENT, `tipo` varchar(50) NOT NULL, `houseID` int(11) NOT NULL, `proprietario` int(11) NOT NULL, `moradores` text DEFAULT '{}', `bau` text DEFAULT '{}', `armario` text DEFAULT '{}', `interior` int(11) NOT NULL, `iptu` int(11) NOT NULL, PRIMARY KEY (`id`) ) ENGINE=InnoDB DEFAULT CHARSET=latin1; ]])
config.newVersion = true -- NAO MEXER

CreateThread(function()
    if config.createTable then
        vRP.execute("mirtin/createDB", {})
        vRP.execute("mirtin/createDB2", {})
    end
end)

--[[ 
-- COLOCAR DENTRO DE QUALQUER MODULES DO VRP

function vRP.atualizarPosicao(user_id,x,y,z)
    local data = vRP.getUserDataTable(user_id)
    if user_id then
        if data then
            data.position = { x = x, y = y, z = z }
        end
    end
end 
]]