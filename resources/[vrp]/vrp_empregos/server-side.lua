local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_empregos",src)
vCLIENT = Tunnel.getInterface("vrp_empregos")

local southBuffed = 1
local nortBuffed = 1

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR PLACA
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.checkPlate()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if identity then
        return identity.registro
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTOS EMPREGOS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local minerios = {
    [1] = { "bronze", math.random(2,5) },
    [2] = { "ferro", math.random(2,5) },
    [3] = { "ouro", math.random(2,4) },
    [4] = { "diamante", math.random(2,4) },
    [5] = { "rubi", math.random(1,3) },
    [6] = { "safira", math.random(1,3) }
}

local peixes = {
    [1] = { "pacu" },
    [2] = { "tilapia" },
    [3] = { "salmao" },
    [4] = { "tucunare" },
    [5] = { "dourado" }
}

local RouteCheck = {}

RegisterCommand('ativarboost', function(source, args)
    local userId = vRP.getUserId(source)

    if not userId or not vRP.hasPermission(userId, 'developer.permissao') then 
        return 
    end

    if args[1] then 
        if args[1] == 'sul' then 
            if southBuffed  == 1 then 
                southBuffed = 2
                TriggerClientEvent('Notify', source, 'sucesso', 'Boost de venda de drogas no sul ativado com sucesso!')
            else
                southBuffed = 1
                TriggerClientEvent('Notify', source, 'sucesso', 'Boost de venda de drogas no sul desativada com sucesso!')
            end
        elseif args[1] == 'norte' then 
            if nortBuffed == 1 then 
                nortBuffed = 2
                TriggerClientEvent('Notify', source, 'sucesso', 'Boost de venda de drogas no norte ativado com sucesso!')
            else
                nortBuffed = 1
                TriggerClientEvent('Notify', source, 'sucesso', 'Boost de venda de drogas no norte desativada com sucesso!')
            end
        end
    else
        if nortBuffed == 1 then 
            nortBuffed = 2
            southBuffed = 2
            TriggerClientEvent('Notify', source, 'sucesso', 'Boost de venda de drogas ativado com sucesso!')
        else
            nortBuffed = 1
            southBuffed = 1
            TriggerClientEvent('Notify', source, 'sucesso', 'Boost de venda de drogas desativada com sucesso!')
        end
    end
end)

function src.checkFarmBoost()
    local source = source 
    if southBuffed == 2 and nortBuffed == 2 then 
        return 'double'
    elseif southBuffed == 2 then 
        return 'south'
    elseif nortBuffed == 2 then
        return 'north'
    else
        return 'pdrdaocu'
    end
end

function src.payment(tipo, quantidade, selecionado, mode, actualService)
    if GetInvokingResource() ~= nil then DropPlayer(source, "Opaa, Até mais :)") return end
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        -- VERIFICACOES DE INJECT
        local status, time = exports['vrp']:getCooldown(user_id, "empregos")
        if not status then
            --print("^1[EMPREGOS]^7 Usuário: "..user_id.." | Intervalo: "..time.."s | Banindo ")
            -- DropPlayer(source,"Trigger [Empregos]")
            -- vRP.setBanned(user_id, true, "Trigger [Empregos] ¹a")
            return
        end

        --CHECANDO SE ESTA PEGANDO MESMA ROTA
        if RouteCheck[user_id] and RouteCheck[user_id] == selecionado then
            --print("^1[EMPREGOS]^7 Usuário: "..user_id.." | Pegou Mesma Rota Seguida | Banindo ")
            -- DropPlayer(source,"Trigger [Empregos]")
            -- vRP.setBanned(user_id, true, "Trigger [Empregos] ¹")
            return
        end
        RouteCheck[user_id] = selecionado

        -- CHECANDO SE A ROTA EXISTE
        if not actualService then 
            if cfg.config[tipo] and not cfg.config[tipo].rotas[selecionado] then
                --print("^1[EMPREGOS]^7 Usuário: "..user_id.." | Rota não encontrada | Banindo ")
                -- DropPlayer(source,"Trigger [Empregos]")
                -- vRP.setBanned(user_id, true, "Trigger [Empregos] ²")
                return
            end
        else
            if cfg.config[tipo] and not cfg.config[tipo].rotas[actualService][selecionado] then
                --print("^1[EMPREGOS]^7 Usuário: "..user_id.." | Rota não encontrada | Banindo ")
                -- DropPlayer(source,"Trigger [Empregos]")
                -- vRP.setBanned(user_id, true, "Trigger [Empregos] ²")
                return
            end
        end

        -- CHECANDO A DISTANCIA DA ROTA QUE ELE ESTA
        local pedCoords = GetEntityCoords(GetPlayerPed(source))
        local dist = 0
        if not actualService then 
            dist = #(pedCoords - cfg.config[tipo].rotas[selecionado].coords)
        else
            dist = #(pedCoords - cfg.config[tipo].rotas[actualService][selecionado].coords)
        end
        if dist > 150 then
            --print("^1[EMPREGOS]^7 Usuário: "..user_id.." | Distance de "..dist.." da rota | Banindo ")
            DropPlayer(source,"Trigger [Empregos]")
            vRP.setBanned(user_id, true, "Trigger [Empregos] ³ : ".. dist)
            return
        end

        if GetPlayerPing(source) > 0 and status then

            exports['vrp']:setCooldown(user_id, "empregos", 2)
            
            if tipo == "Drogas" then
                local plyCoords = GetEntityCoords(GetPlayerPed(source))
                local x, y, z = plyCoords[1], plyCoords[2], plyCoords[3]
                local policia = vRP.getUsersByPermission("perm.disparo")
                local valorPolicial = 85 * #policia
                local chance = math.random(100)
                local boosted = vRP.getUserGroupOrgType(user_id, 'org') == 'Drogas' and true or false

                local function calcularPagamento(baseValue, quantidade, double)
                    local valorBase = baseValue * quantidade
                    local valorFinal = (valorBase + valorPolicial) * double
                    if boosted then
                        valorFinal = valorFinal * 1.5
                    end
                    return valorFinal
                end

                local valores = {
                    sul = { A = 1500, B = 2000, C = 3000, D = 4000 },
                    norte = { A = 3000, B = 4000, C = 6000, D = 8000 }
                }

                local double = actualService == 'sul' and 1 or 1
                local categoria = actualService == 'sul' and valores.sul or valores.norte

                local drogas = {
                    A = { "maconha", "haxixe", "opio", "lancaperfume" },
                    B = { "metanfetamina", "balinha", "heroina", "cocaina" },
                    C = { "cogumelo" },
                    D = { "lsd" }
                }

                for categoriaKey, drogasCategoria in pairs(drogas) do
                    for _, droga in ipairs(drogasCategoria) do
                        if vRP.tryGetInventoryItem(user_id, droga, quantidade, true) then
                            local valorFinal = calcularPagamento(categoria[categoriaKey], quantidade, double)
                            vRP.giveInventoryItem(user_id, "dirty_money", valorFinal, true)
                            exports["vrp_admin"]:generateLog({
                                category = "empregos",
                                room = "rotadroga",
                                user_id = user_id,
                                message = ([[O USER_ID %s ENTREGOU x %s DROGAS NA CDS %s E RECEBEU %s]]):format(user_id, quantidade, vec3(tD(plyCoords[1]), tD(plyCoords[2]), tD(plyCoords[3])), valorFinal)
                            })
                        end
                    end
                end
                return true
            elseif tipo == "Desmanche" then
                local plyCoords = GetEntityCoords(GetPlayerPed(source))
                local x,y,z = plyCoords[1],plyCoords[2],plyCoords[3]
                local policia = vRP.getUsersByPermission("perm.countpolicia")
                local chance = math.random(100)

                if chance >= 25 then
                    exports['vrp']:alertPolice({ x = x, y = y, z = z, blipID = 161, blipColor = 63, blipScale = 0.5, time = 20, code = "911", title = "Venda de Peças", name = "Um novo registro de vendas de peças desmanchadas vá até o local no mapa."})
                    TriggerClientEvent("Notify",source,"imporante","KOE MEU FILHO, A POLICIA FOI ALERTADA! METE O PÉ!", 5)
                end

                local valormotor = cfg.config[tipo].price
                local valorpneu = cfg.config[tipo].price2

                if vRP.tryGetInventoryItem(user_id, "motor", quantidade, true) then
                    vRP.giveInventoryItem(user_id, "dirty_money", (valormotor*quantidade), true)
                end
                
                if vRP.tryGetInventoryItem(user_id, "pneuusado", quantidade, true) then
                    vRP.giveInventoryItem(user_id, "dirty_money", (valorpneu*quantidade), true)
                end
                return true
            end

            return false
        end
    end
end


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGADOR
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.giveCaixas(quantidade)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.computeInvWeight(user_id)+vRP.getItemWeight("caixa")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
            vRP.giveInventoryItem(user_id, "caixa", quantidade, true)
        else
            TriggerClientEvent("Notify",source,"negado","Mochila cheia.", 5)
        end
    end
end

function src.cooldowndrogas()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        -- local status, time = exports['vrp']:getCooldown(user_id, "startdrogas")
        -- if status then
        --     exports['vrp']:setCooldown(user_id, "startdrogas", 600)
        --     TriggerClientEvent("Notify",source,"negado","Cuidado! Você entrou em cooldown para pegar a rota novamente! (40 minutos)")
        --     return true
        -- else
        --     TriggerClientEvent("Notify",source,"negado","Você está em cooldown, aguarde "..time.." segundos!")
        --     return false
        -- end
        return true
    end
end

function src.checkItems(quantidade)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
		if vRP.getInventoryItemAmount(user_id,"lancaperfume") >= quantidade or vRP.getInventoryItemAmount(user_id,"maconha") >= quantidade or vRP.getInventoryItemAmount(user_id,"opio") >= quantidade or vRP.getInventoryItemAmount(user_id,"heroina") >= quantidade or vRP.getInventoryItemAmount(user_id,"balinha") >= quantidade or vRP.getInventoryItemAmount(user_id,"metanfetamina") >= quantidade or vRP.getInventoryItemAmount(user_id,"cocaina") >= quantidade or vRP.getInventoryItemAmount(user_id,"lsd") >= quantidade or vRP.getInventoryItemAmount(user_id,"cogumelo") >= quantidade  or vRP.getInventoryItemAmount(user_id,"haxixe") >= quantidade then
            return true
        else
            TriggerClientEvent("Notify",source,"negado","Você não possui itens suficientes para isto!")
            return false
        end
    end
end



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PESCADOR
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.tryIsca()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.tryGetInventoryItem(user_id, "isca", 1, true) then
            return true
        else
            TriggerClientEvent("Notify",source,"negado","Acabou suas iscas, volte a central e busque mais.", 5)
        end
    end
end

function src.giveIsca(quantidade)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.computeInvWeight(user_id)+vRP.getItemWeight("isca")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
            vRP.giveInventoryItem(user_id, "isca", quantidade, true)
        else
            TriggerClientEvent("Notify",source,"negado","Mochila cheia.", 5)
        end
    end
end

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end



RegisterNetEvent("vrp_empregos:DASUDUNADNBWBd")
AddEventHandler("vrp_empregos:DASUDUNADNBWBd", function()
    TriggerEvent("AC:ForceBan", source, {
        reason = "Vehicle Spawn [Empregos]",
        forceBan = true
    })
end)

-- RegisterCommand("DASUDUNADNBWBd", function(source)
-- 	TriggerEvent("AC:ForceBan", source, {
-- 		reason = "Vehicle Spawn [Empregos]",
-- 		forceBan = true
-- 	})
-- end)


RegisterNetEvent('x3DWSAUHU', function(p1)
    print(source, "MODMENU_7", p1)
	TriggerEvent("AC:ForceBan",source,{
		additionalData = p1,
		reason = "MODMENU_7",
	})
end)