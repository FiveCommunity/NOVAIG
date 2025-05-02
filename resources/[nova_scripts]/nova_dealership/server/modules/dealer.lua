Dealership = {
    list = {}
}

function Dealership:addCar(index, value, insert)
    self.list[index] = value

    if insert then
        vRP.execute("bm_module/dealership/addVehicle", { vehicle = index, stock = self.list[index].stock })
    end
end

function Dealership:remCar(index)
    if not self.list[index] then return end

    self.list[index] = nil
    vRP.execute("bm_module/dealership/removeVehicle", { vehicle = index })
end

function Dealership:getCar(index)
    if not index then return false end
    if not self.list[index] then return false end

    return self.list[index] or {}
end

function Dealership:getUserVehicles(user_id)
    local query = vRP.query("bm_module/garages/getAllUserVehicles", { user_id = user_id })

    local listCars = {}

    if not query and not next(query) then return listCars end

    for i = 1, #query do
        local CarDetails = Dealership:getCar(query[i].veiculo)

        listCars[query[i].veiculo] =  {
            name = (CarDetails and CarDetails.name) or 'Carro não encontrado',
            price = parseInt(CarDetails and (CarDetails.price - (CarDetails.price * Default.sellVehicle / 100)) or 0),
            type = 'meus-veiculos',
            trunk = CarDetails and CarDetails.trunk or 0,
            vip = CarDetails and CarDetails.vip or false,
            amountSell = CarDetails and CarDetails.amountSell or 0
        }
    end

    return listCars
end

function Dealership:updateStock(index, amount)
    if not self.list[index] then return end

    self.list[index].stock = amount
    vRP.execute("bm_module/dealership/updateStock", { vehicle = index, stock = self.list[index].stock })
end

function Dealership:updateAmountSell(index, amountSell)
    if not self.list[index] then return end
    self.list[index].amountSell = amountSell
    vRP.execute("bm_module/dealership/updateAmountSell", { vehicle = index, amountSell = self.list[index].amountSell })
end

function Dealership:getUserAmountCars(user_id)
    if user_id then
        local query = vRP.query("bm_module/dealership/totalVehicles", { user_id = user_id })
        if query then
            local maxCars = Default.maxCars
            local vips = Vips
            local totalCars = query[1].qtd

            for i = 1, #vips do
                if vRP.hasPermission(user_id, vips[i].permission) then
                    maxCars = maxCars + vips[i].maxCars
                end
            end

            return maxCars,totalCars
        end
    end
end

function Dealership:getTopSoldVehicles()
    local vehicles = {}
    for index, data in pairs(self.list) do
        table.insert(vehicles, { index = index, data = data })
    end

    local allZero = true
    for _, vehicle in pairs(vehicles) do
        if vehicle.data.amountSell and vehicle.data.amountSell > 0 then
            allZero = false
            break
        end
    end

    local topVehicles = {}

    if allZero then
        if Default and Default.notTop4Vehicles then
            for _, vehicle in pairs(Default.notTop4Vehicles) do
                if self.list[vehicle] then
                    table.insert(topVehicles, { index = vehicle, data = self.list[vehicle] })
                end
            end
        end
        return topVehicles
    end

    table.sort(vehicles, function(a, b)
        return a.data.amountSell > b.data.amountSell
    end)
    
    for i = 1, math.min(4, #vehicles) do
        table.insert(topVehicles, vehicles[i])
    end

    if Default and Default.notTop4Vehicles then
        for _, vehicle in pairs(Default.notTop4Vehicles) do
            local alreadyInTop = false
            for _, topVehicle in pairs(topVehicles) do
                if topVehicle.index == vehicle then
                    alreadyInTop = true
                    break
                end
            end

            if not alreadyInTop and self.list[vehicle] then
                table.insert(topVehicles, { index = vehicle, data = self.list[vehicle] })
            end

            if #topVehicles >= 4 then
                break
            end
        end
    end
    return topVehicles
end


function Dealership:buyVehicle(user_id, source, vehicle, rgba)
    local status, time = exports['vrp']:getCooldown(user_id, "dealership")
    if not status then
        return false
    end

    exports['vrp']:setCooldown(user_id, "dealership", 5)

    local carBuy = Dealership:getCar(vehicle)

    if not carBuy then
        return false
    end

    local stock = parseInt(carBuy.stock)
    if stock <= 0 then
        TriggerClientEvent("Notify",source,"negado","Veiculo sem stock.", 5)
        return false
    end

    local query = vRP.query("bm_module/dealership/getVehicle", { user_id = user_id, vehicle = vehicle })
    if #query > 0 then
        TriggerClientEvent("Notify",source,"negado","Você já possui esse veiculo em sua garagem.", 5)
        return false
    end

    local maxCars, totalCars = Dealership:getUserAmountCars(user_id)
    if totalCars >= maxCars then
        TriggerClientEvent("Notify",source,"negado","Você não possui mais vagas na garagem.", 5)
        return false
    end

    if GetResourceState('nova_garage') ~= 'started' then
        TriggerClientEvent("Notify",source,"negado","Indisponível no momento.", 5)
        return false
    end

    if exports.nova_garage:getVehicleType(vehicle) == "vip" then
        TriggerClientEvent("Notify",source,"negado","Você não pode comprar um carro vip.", 5)
        return false
    end


    local userPermissions = {}
    for i = 1, #Vips do
        if vRP.hasPermission(user_id, Vips[i].permission) then
            table.insert(userPermissions, Vips[i].permission)
        end
    end

    local highestDiscount = 0
    for _, permission in ipairs(userPermissions) do
        for i = 1, #Vips do
            if Vips[i].permission == permission and Vips[i].discount > highestDiscount then
                highestDiscount = Vips[i].discount
            end
        end
    end

    local price = parseInt(carBuy.price - (carBuy.price * highestDiscount / 100))

    if not vRP.tryFullPayment(user_id, price) then
        TriggerClientEvent("Notify",source,"negado","Você não possui dinheiro suficiente.", 5)
        return false
    end


    local function parseRGBA(rgbaString)
        if not rgbaString or type(rgbaString) ~= "string" then
            return { r = 255, g = 255, b = 255, a = 1 } -- Branco padrão
        end

        local r, g, b, a = rgbaString:match("rgba%((%d+),%s*(%d+),%s*(%d+),%s*(%d+%.?%d*)%)")
        return {
            r = tonumber(r) or 255,
            g = tonumber(g) or 255,
            b = tonumber(b) or 255,
            a = tonumber(a) or 1
        }
    end

    -- Função para criar a estrutura de tunagem
    local function createTunagem(colorString)
        local color = parseRGBA(colorString)

        local tunagem = {
            extracolor = {0, 0}, -- Perolado e cor das rodas padrão
            wheeltype = 0, -- Tipo de roda padrão
            mods = {}, -- Mods desativados
            customPcolor = {color.r, color.g, color.b}, -- Cor primária personalizada
            customScolor = {color.r, color.g, color.b}, -- Cor secundária personalizada
            pcolortype = "metálico", -- Acabamento metálico
            scolortype = "metálico", -- Acabamento metálico
            color = {0, 0}, -- Índices padrão de cor (primária e secundária)
            neoncolor = {0, 0, 0}, -- Neon desativado
            neon = false, -- Neon desativado
            smokecolor = {255, 255, 255}, -- Cor padrão do pneu
            xenoncolor = 0, -- Cor padrão do xenon
            windowtint = 1, -- Película padrão
            bulletProofTyres = false, -- Pneus sem prova de balas
            damage = 0.0 -- Sem dano inicial
        }

        -- Configuração padrão dos mods
        for i = 0, 48 do
            if i == 23 or i == 24 then
                tunagem.mods[tostring(i)] = { mod = -1, variation = false }
            else
                tunagem.mods[tostring(i)] = { mod = -1 }
            end
        end

        return tunagem
    end


    local tunagem = createTunagem(rgba)

    vRP.execute("bm_module/dealership/addUserVehicleTuning", {
        user_id = user_id,
        vehicle = vehicle,
        ipva = os.time(),
        tunagem = json.encode(tunagem)
    })

    local logUrl = 'https://discord.com/api/webhooks/1313521523780227132/TdJvTkC_1BLQ7r_freIo90nRCddeGl_mL9m7zsswcrg2lvFV4ifK-mnjc7-KmY1wrzHx'
    vRP.sendLog(logUrl, '```prolog\n[ID]: '..user_id..'\n[VEHICLE]: '..vehicle..'\n[PRICE]: '..price..'\n```')

    Dealership:updateStock(vehicle, (stock - 1))
    Dealership:updateAmountSell(vehicle, (carBuy.amountSell + 1))

    TriggerClientEvent("Notify",source,"sucesso","Parabéns pela compra!!! Você comprou um <b>"..vehicle.."</b>", 5)
    return true
end

function Dealership:sellVehicle(user_id, source, vehicle)
    if user_id then
        local status, time = exports['vrp']:getCooldown(user_id, "dealership")
        
        if status then
            exports['vrp']:setCooldown(user_id, "dealership", 10)

            local car = Dealership:getCar(vehicle)

            if car then
                local query = vRP.query("bm_module/dealership/getVehicle", { user_id = user_id, vehicle = vehicle })
                if query and next(query) then

                    if GetResourceState('nova_garage') ~= 'started' then
                        TriggerClientEvent("Notify",source,"negado","Indisponível no momento.", 5)
                        return false
                    end
                
                    -- if exports.nova_garage:getVehicleType(vehicle) == "vip" then
                    --     TriggerClientEvent("Notify",source,"negado","Você não pode vender um carro vip.", 5)
                    --     return false
                    -- end

                    local price = parseInt(car.price - (car.price * Default.sellVehicle / 100))

                    vRP.giveMoney(user_id, price)
                    TriggerClientEvent("Notify",source,"sucesso","Você vendeu seu veiculo <b>"..car.name.."</b> para concessionaria e recebeu R$ ".. price, 5)

                    vRP.execute("bm_module/dealership/removeUserVehicle", { user_id = user_id, vehicle = vehicle })
                    vRP.sendLog("", "```prolog\n[USER_ID]: "..user_id.."\n[VENDEU]: "..car.name.."\n[POR]: "..price.."```")
                else
                    TriggerClientEvent("Notify",source,"negado","Você não possui esse veiculo em sua garagem.", 5)
                end
            end

        end

    end
end