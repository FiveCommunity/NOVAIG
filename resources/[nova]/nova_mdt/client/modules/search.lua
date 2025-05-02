RegisterNUICallback('searchPassport', function(data, cb)
    local nuserId = tonumber(data.id)
    if not nuserId then
        return cb(false)
    end

    cb(ServerAPI.searchPassport(nuserId))
end)

RegisterNUICallback('searchPlate', function(data, cb)
    local plate = data.plate
    if not plate then
        return cb(false)
    end

    cb(ServerAPI.searchPlate(plate))
end)

RegisterNUICallback('getUser', function(data, cb)
    local nuserId = tonumber(data.id)
    if not nuserId then
        return cb(false)
    end

    cb(ServerAPI.getUser(nuserId))
end)

RegisterNUICallback('getVehicle', function(data, cb)
    local plate = data.plate
    local vehicle = data.vehicle
    if not plate or not vehicle then
        return cb(false)
    end
    
    cb(ServerAPI.getVehicle(plate, vehicle))
end)

RegisterNUICallback('fineVehicle', function(data, cb)
    local plate = data.plate
    local vehicle = data.vehicle
    local amount = tonumber(data.amount)
    local reason = data.reason
    if not plate or not amount or not reason or not vehicle then
        return cb(false)
    end

    cb(ServerAPI.fineVehicle(plate, vehicle, amount, reason))
end)

RegisterNUICallback('arrestVehicle', function(data, cb)
    local plate = data.plate
    local vehicle = data.vehicle
    local reason = data.reason
    if not plate then
        return cb(false)
    end

    cb(ServerAPI.arrestVehicle(plate, vehicle, reason))
end)