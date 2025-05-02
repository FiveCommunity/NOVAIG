Bennys = {}

Bennys.__index = Bennys

-----------------------------------------------------------------------------------------------------------------------------------------
-- START
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    vRP.prepare("stancetuning/remTuning","DELETE FROM stancetuning WHERE stance = @stance")
    vRP.prepare("stancetuning/getTuning","SELECT tuning FROM stancetuning WHERE stance = @stance")
    vRP.prepare("stancetuning/setTuning","REPLACE INTO stancetuning(stance,tuning) VALUES(@stance,@value)")
    vRP.prepare("stancetuning/setPreset","REPLACE INTO stancetuning(stance,car,tuning,name,type) VALUES(@stance,@car,@value,@name,@type)")
    vRP.prepare("stancetuning/getPresets","SELECT * FROM stancetuning WHERE type = @type")
    vRP.prepare("stancetuning/initTable","CREATE TABLE IF NOT EXISTS `stancetuning` (`stance` varchar(100) NOT NULL,`tuning` text DEFAULT NULL,`car` varchar(100) NOT NULL DEFAULT 'stance',`name` varchar(100) NOT NULL DEFAULT 'stance',`type` varchar(10) NOT NULL DEFAULT 'stance',PRIMARY KEY (`stance`),KEY `stance` (`stance`)) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;")
    
    vRP.execute("stancetuning/initTable")
end)

function Bennys.new()
    local self = setmetatable({}, Bennys)
    return self
end

function Bennys:saveAttribute(playerId,data)
    if playerId then 
        local source = source
        local amount = parseInt(data[1][1])
        if amount == nil or parseInt(amount) <= 0 then
            amount = 5000
        end

        local vehuser = vRP.getUserByRegistration(data[1][3])
        if vehuser then
            if vRP.tryFullPayment(playerId, amount) then
                vRP.execute("vRP/update_tuning",{ user_id = vehuser, veiculo = data[1][2], tunagem = json.encode(data[1][4]) })
                TriggerClientEvent("Notify",source,"sucesso","Modificações aplicadas com <b>sucesso</b><br >Você pagou <b>$ "..vRP.format(tonumber(amount)).."<b>.", 5)
                vRP.sendLog('https://discord.com/api/webhooks/1340976243813646357/hSsydNaw_kcegzIpDyN7MXMCjhFu0ky3dQ5r7hJ17SwuReCWqJolYXrdfdO1ELfM1y8u', 'USUARIO '..playerId..' APLICOU MODIFICAÇÕES NO VEÍCULO '..data[1][2]..' DO USUÁRIO '..vehuser.. '. MODIFICAÇÕES: '..json.encode(data[1][4]))
                return true
            else
                TriggerClientEvent("Notify",source,"negado","Você não possui dinheiro suficiente.", 5)
            end
        end
    end 
    return false
end
     
function Bennys:infosStance()
    local source = source
    local vehiclePlate, modelName, vehicleNet, trunkStatus, vehiclePrice, vehicleLock = vRPC.ModelName(source, 7)
    local userId = vRP.getUserByRegistration(vehiclePlate)
    
    if userId and modelName then 
        local stanceTuning = vRP.query("stancetuning/getTuning", { stance = "stance:"..vehiclePlate..":"..modelName })
        local stanceBTuning = vRP.query("stancetuning/getTuning", { stance = "stanceb:"..vehiclePlate..":"..modelName })
        
        if #stanceBTuning > 0 then
            local stanceB = json.decode(stanceBTuning[1]["tuning"])
            local stance = nil
            
            if #stanceTuning > 0 then
                stance = json.decode(stanceTuning[1]["tuning"])
            end
            
            return stance, stanceB
        end
    end
    return nil, nil
end

function getItem(playerId)
    if Config.Bennys.stance.needItem then
        return vRP.tryGetInventoryItem(playerId,Config.Bennys.stance.item,1,true)
    end
    return true
end

GlobalState["Stance"] = {}

function Bennys:applyCustom(playerId,type,data)
    local source = source
    print('linha 78',playerId)
    if playerId then 
        local vehiclePlate,modelName,vehicleNet,_,_,_,_,_,vehicleEnt = vRPC.ModelName(source, 7)

        local userId = vRP.getUserByRegistration(vehiclePlate)
        print(userId,'linha 82')
        if userId then 
            print('linha 85')
            if getItem(playerId) then 
                vRP.execute("stancetuning/setTuning",{ stance = "stance:"..userId..":"..modelName, value = json.encode(data) })
                TriggerClientEvent('Notify',source,"sucesso","Configurações aplicadas com sucesso")
            	local Stance = GlobalState["Stance"]
                Stance[data.networkVeh] = data
                GlobalState:set("Stance",Stance,true)
            end
        end
    end
end