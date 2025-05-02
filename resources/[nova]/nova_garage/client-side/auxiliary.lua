length = function(array)
	local len = 0
	for i in pairs(array) do 
		if array[i] then
			len = len+1
		end
	end
	return len
end

GetClosestVehiclePlayer = function(range)

    local ped = PlayerPedId()
    local vehicles = GetGamePool("CVehicle")

    local vehID
    local min = range+0.0001
    local vehHash
    for i = 1, #vehicles do
        local veh = vehicles[i]
        local dist = #(GetEntityCoords(ped) - GetEntityCoords(veh))

        if IsEntityAVehicle(veh) and dist <= range then
            if dist < min then
                min = dist
                vehID = veh
                vehHash = GetEntityModel(veh)
            end
        end
    end

    return vehID,vehHash
end

CreateThread(function()
    TriggerEvent('updateVehList', listCars)

    while true do
        local time = 1000
        local pedCoords = GetEntityCoords(PlayerPedId())

        if segundos > 0 then
            segundos = segundos - 1
        end

        for i in pairs(garages) do
            if #(garages[i].coords - pedCoords) <= garages[i].blipDistance then
                nearestGarages[i] = garages[i]
            elseif nearestGarages[i] then
                nearestGarages[i] = nil
            end
        end

        Wait(time)
    end
end)
