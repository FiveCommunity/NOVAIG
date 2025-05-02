function tvRP.getNearestVehicles(radius)
	local r = {}
	local px,py,pz = tvRP.getPosition()

	local vehs = {}
	local it,veh = FindFirstVehicle()
	if veh then
		table.insert(vehs,veh)
	end
	local ok
	repeat
		ok,veh = FindNextVehicle(it)
		if ok and veh then
			table.insert(vehs,veh)
		end
	until not ok
	EndFindVehicle(it)

	for _,veh in pairs(vehs) do
		local x,y,z = table.unpack(GetEntityCoords(veh,true))
		local distance = GetDistanceBetweenCoords(x,y,z,px,py,pz,true)
		if distance <= radius then
			r[veh] = distance
		end
	end
	return r
end

function tvRP.checkOffSetAndHoodOpen(vehicle,sentOpenHood)
	local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 3.0, 0.5))
	local x2,y2,z2 = table.unpack(GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -3.0, 0.5))
	local coordA = GetEntityCoords(GetPlayerPed(-1))

	if (GetDistanceBetweenCoords(coordA.x,coordA.y,coordA.z,x,y,z) < 1.5) or (GetDistanceBetweenCoords(coordA.x,coordA.y,coordA.z,x2,y2,z2) < 1.5) then
		if sentOpenHood then
			SetVehicleDoorOpen(vehicle,4,0,0)
		end
		return true,VehToNet(vehicle)
	else
		return false,-1
	end
end

function tvRP.getNearestVehicle(radius)
	local veh
	local vehs = tvRP.getNearestVehicles(radius)
	local min = radius+0.0001
	for _veh,dist in pairs(vehs) do
		if dist < min then
			min = dist
			veh = _veh
		end
	end
	return veh
end

function tvRP.ejectVehicle()
	local ped = PlayerPedId()
	if IsPedSittingInAnyVehicle(ped) then
		local veh = GetVehiclePedIsIn(ped,false)
		TaskLeaveVehicle(ped,veh,4160)
	end
end

function tvRP.isInVehicle()
	return IsPedSittingInAnyVehicle(PlayerPedId())
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MODELOS DOS VEICULOS
-----------------------------------------------------------------------------------------------------------------------------------------
local vehList = {}

AddEventHandler("updateVehList", function(value)
	vehList = value
end)

function tvRP.ModelName(radius)
	local veh = tvRP.getNearestVehicle(radius)
	if IsEntityAVehicle(veh) then
		local lock = GetVehicleDoorLockStatus(veh) >= 2
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		local v = vehList[GetEntityModel(veh)]
		if v then
			return GetVehicleNumberPlateText(veh),v.model,VehToNet(veh),v.trunk,parseInt(v.price),lock,GetDisplayNameFromVehicleModel(v.model),GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z)),veh
		end
	end
end