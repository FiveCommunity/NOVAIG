------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local VEHICLES_BLOCKS = {}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.requestTunning(data)
    local user_id = getUserId(source)
    if not user_id then return end

    local owner_id = getUserByRegistration(data.plate)
    if not owner_id then return end

    local entity = NetworkGetEntityFromNetworkId(data.vehicle)
    if not entity or entity <= 0 or not DoesEntityExist(entity) then return end

    if VEHICLES_BLOCKS[entity] then return end
    VEHICLES_BLOCKS[entity] = true
    
    local vehName = getVehicleName(data.model, data.name)
    local tunning = getSData('mirtin_tunning:'..owner_id.."veh_"..vehName) or {}
    if not next(tunning) then return end

    if tunning.suspHeight then
        Entity(entity).state:set('suspHeight', tunning.suspHeight, true)
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local SUSPENSION = {}
local COOLDOWN = {}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.UpdateSuspension(veh, direction, players)
    local source = source
    local user_id = getUserId(source)
    if not user_id then 
        return
    end

    local entity = NetworkGetEntityFromNetworkId(veh)
    if not entity or entity <= 0 and not DoesEntityExist(entity) then
        return
    end

    if direction ~= 'up' and direction ~= 'superUp' and direction ~= 'down' and direction ~= 'superDown' and direction ~= 'maxDown' then
        return
    end

    for i = 1, #players do
        local plySrc = players[i]
        if GetPlayerPed(plySrc) ~= 0 then
            vTunnel._syncSuspension(plySrc, veh, direction)
        end
    end
end

function RegisterTunnel.requestVehicle(data)
    local source = source
    local user_id = getUserId(source)
    if not user_id then
        return
    end

    local requireItem = Config.SuspensionConfig.requireItem
    if not hasPermission(user_id, 'admin.permissao') then
        if requireItem.active and getInventoryItemAmount(user_id, requireItem.item) <= 0 and not hasPermission(user_id, Config.SuspensionConfig.permissions.vip_permission) then
            TriggerClientEvent('Notify', source, 'negado', 'Você precisa do item <b>'..vRP.getItemName(requireItem.item)..'</b> para abrir a suspensão a AR.')
            return false
        end
    end

    local entity = NetworkGetEntityFromNetworkId(data.vehicle)
    if not entity or entity <= 0 and not DoesEntityExist(entity) then
        return false
    end

    local owner_id = getUserByRegistration(data.plate)
    if not owner_id then
        return Config.Langs['vehicleNotFoundPlayer'](source)
    end
    
    if owner_id ~= user_id then
        return false
    end

    local vehName = getVehicleName(data.model, data.name)
    local tunning = getSData('mirtin_tunning:'..owner_id.."veh_"..vehName) or {}
    if tunning.installed then
        return true
    end

    if hasPermission(user_id, 'admin.permissao') or hasPermission(user_id, Config.SuspensionConfig.permissions.vip_permission) then
        if not tunning.installed then
            tunning.installed = false

            setSData('mirtin_tunning:'..user_id.."veh_"..vehName, tunning)
        end

        return true
    end

    return false
end

function RegisterTunnel.saveSuspensionVehicle(data)
    local source = source
    local user_id = getUserId(source)
    if not user_id then 
        return
    end

    if COOLDOWN[user_id] and (COOLDOWN[user_id] - os.time()) > 0 then
        return
    end
    COOLDOWN[user_id] = (os.time() + 5)

    local entity = NetworkGetEntityFromNetworkId(data.vehicle)
    if not entity or entity <= 0 and not DoesEntityExist(entity) then
        return
    end

    local owner_id = getUserByRegistration(data.plate)
    if not owner_id then
        return Config.Langs['vehicleNotFoundPlayer'](source)
    end

    if owner_id ~= user_id then
        return
    end

    -- Syncando com o jogadores
    Entity(entity).state:set('suspHeight', data.height, true)

    -- Salvando no banco de dados
    local vehName = getVehicleName(data.model, data.name)
    local tunning = getSData('mirtin_tunning:'..user_id.."veh_"..vehName) or {}
    tunning.suspHeight = data.height

    setSData('mirtin_tunning:'..user_id.."veh_"..vehName, tunning)
end

function RegisterTunnel.savePressureVehicle(data)
    local source = source
    local user_id = getUserId(source)
    if not user_id then 
        return
    end

    local entity = NetworkGetEntityFromNetworkId(data.vehicle)
    if not entity or entity <= 0 and not DoesEntityExist(entity) then
        return
    end

    local owner_id = getUserByRegistration(data.plate)
    if not owner_id then
        return Config.Langs['vehicleNotFoundPlayer'](source)
    end

    if owner_id ~= user_id then
        return
    end

    local veh = getUData(user_id, 'mirtin_tunning:vehicles') or {}
    local vehName = getVehicleName(data.model, data.name)
    if not veh[vehName] then
        veh[vehName] = {}
    end

    veh[vehName][data.set] = { pressure = data.pressure, height = data.height }

    setUData(user_id, 'mirtin_tunning:vehicles', veh)
end

function RegisterTunnel.setPressure(data, players)
    local source = source
    local user_id = getUserId(source)
    if not user_id then 
        return
    end

    local entity = NetworkGetEntityFromNetworkId(data.vehicle)
    if not entity or entity <= 0 and not DoesEntityExist(entity) then
        return
    end

    local owner_id = getUserByRegistration(data.plate)
    if not owner_id then
        return Config.Langs['vehicleNotFoundPlayer'](source)
    end

    if owner_id ~= user_id then
        return
    end

    local veh = getUData(user_id, 'mirtin_tunning:vehicles') or {}
    local vehName = getVehicleName(data.model, data.name)
    if not veh[tostring(vehName)] or not veh[tostring(vehName)][data.set] then
        return
    end

    local veh = veh[vehName][data.set]
    for i = 1, #players do
        local plySrc = players[i]
        if GetPlayerPed(plySrc) ~= 0 then
            vTunnel._syncSuspension(plySrc, data.vehicle, "setPressure", { pressure = veh.pressure, height = veh.height })
        end
    end

    return { pressure = pressure }
end

function RegisterTunnel.requireTunning(data)
    local source = source
    local user_id = getUserId(source)
    if not user_id then 
        return
    end

    local entity = NetworkGetEntityFromNetworkId(data.vehicle)
    if not entity or entity <= 0 and not DoesEntityExist(entity) then
        return
    end

    local owner_id = getUserByRegistration(data.plate)
    if not owner_id then
        return Config.Langs['vehicleNotFoundPlayer'](source)
    end

    local vehName = getVehicleName(data.model, data.name)
    local tunning = getSData('mirtin_tunning:'..owner_id.."veh_"..vehName) or {}
    if tunning and tunning.installed then
        return Config.Langs['vehicleAlreadyInstalled'](source)
    end

    tunning.installed = true

    setSData('mirtin_tunning:'..owner_id.."veh_"..vehName, tunning)

    return true
end