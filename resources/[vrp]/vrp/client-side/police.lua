local noclip = false

function tvRP.toggleNoclip()
	noclip = not noclip
	local ped = PlayerPedId()
	if noclip then
		SetEntityInvincible(ped,false) --mqcu
		SetEntityVisible(ped,false,false)
	else
		SetEntityInvincible(ped,false)
		SetEntityVisible(ped,true,false)
	end
end

Citizen.CreateThread(function()
	while true do
		local time = 1000
		
		if noclip then
			time = 5

			local ped = PlayerPedId()
			local x,y,z = tvRP.getPosition()
			local dx,dy,dz = tvRP.getCamDirection()
			local speed = 1.0

			SetEntityVelocity(ped,0.0001,0.0001,0.0001)

			if IsControlPressed(0,21) then
				speed = 5.0
			end

			if IsControlPressed(0,32) then
				x = x+speed*dx
				y = y+speed*dy
				z = z+speed*dz
			end

			if IsControlPressed(0,269) then
				x = x-speed*dx
				y = y-speed*dy
				z = z-speed*dz
			end

			SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
		end
		Citizen.Wait(time)
	end
end)

local handcuffed = false
function tvRP.toggleHandcuff()
	handcuffed = not handcuffed
	SetEnableHandcuffs(PlayerPedId(),handcuffed)
	if handcuffed then
 		if GetEntityHealth(PlayerPedId()) >= 105 then
			tvRP.playAnim(true,{{"mp_arresting","idle"}},true)
		end
	else
		tvRP.stopAnim(true)
	end
end

function tvRP.setHandcuffed(flag)
	if handcuffed ~= flag then
		tvRP.toggleHandcuff()
	end
end

function tvRP.isHandcuffed()
	return handcuffed
end

Citizen.CreateThread(function()
	while true do
		local time = 10000
		if handcuffed then
			time = 3000
			if GetEntityHealth(PlayerPedId()) >= 105 then
				tvRP.playAnim(true,{{"mp_arresting","idle"}},true)
			end
		end

		Citizen.Wait(time)
	end
end)

function tvRP.putInNearestVehicleAsPassenger(radius)
	local veh = tvRP.getNearestVehicle(radius)
	if IsEntityAVehicle(veh) then
		for i=1,math.max(GetVehicleMaxNumberOfPassengers(veh),3) do
			if IsVehicleSeatFree(veh,i) then
				SetPedIntoVehicle(PlayerPedId(),veh,i)
				return true
			end
		end
	end
	return false
end

function tvRP.checkWeapon(weapon)
	local ped = PlayerPedId()
	if GetSelectedPedWeapon(ped) == GetHashKey(weapon) then
		return true
	end
end 

function tvRP.getAmmo(weapon)
	local ped = PlayerPedId()
	return GetAmmoInPedWeapon(ped, GetHashKey(weapon))
end 

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SEQUESTRO
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local mala = false

function tvRP.toggleMalas()
	mala    = not mala
	ped     = PlayerPedId()
	vehicle = tvRP.getNearestVehicle(7)

	if IsEntityAVehicle(vehicle) and GetVehicleClass(vehicle) ~= 8 and GetVehicleClass(vehicle) ~= 13 then
		if mala then
			AttachEntityToEntity(PlayerPedId(), vehicle, GetEntityBoneIndexByName(vehicle, "bumper_r"), 0.6, -0.4, -0.1, 60.0, -90.0, 180.0, false, false, false, true, 2, true)
			SetEntityVisible(PlayerPedId(), false)
			SetEntityInvincible(PlayerPedId(), false)
		else
			DetachEntity(PlayerPedId(), true, true)
			SetEntityVisible(PlayerPedId(), true)
			SetEntityInvincible(PlayerPedId(), false)
		end
		TriggerServerEvent("trymala", VehToNet(vehicle))
	end

	CreateThread(function()
		while mala do
			DisableControlAction(0,75)
			Wait( 0 )
		end
	end)
end

RegisterNetEvent("syncmala")
AddEventHandler("syncmala", function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleDoorOpen(v, 5, 0, 0)
				Citizen.Wait(1000)
				SetVehicleDoorShut(v, 5, 0)
			end
		end
	end
end)

function tvRP.setMalas(flag)
	if mala ~= flag then
		tvRP.toggleMalas()
	end
end

function tvRP.isMalas()
	return mala
end

function tvRP.getNoCarro()
	return IsPedInAnyVehicle(PlayerPedId())
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CAPUZ
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local capuz = false

function tvRP.setCapuz(flag)
	if flag then
		capuz = true
		tvRP.setDiv("capuz", ".div_capuz { background: #000; margin: 0; width: 100%; height: 100%; }", "")
		SetPedComponentVariation(PlayerPedId(), 1, 69, 2, 2)
	else
		capuz = false
		tvRP.removeDiv("capuz")
		SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 2)
	end
end

function tvRP.isCapuz()
	return capuz
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OUTROS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local time = 1000

		if mala or capuz or handcuffed then
			time = 5
			BlockWeaponWheelThisFrame()
			DisableControlAction(0, 20, true)
			DisableControlAction(0, 21, true)
			DisableControlAction(0, 22, true)
			DisableControlAction(0, 23, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 25, true)
			DisableControlAction(0, 29, true)
			DisableControlAction(0, 32, true)
			DisableControlAction(0, 33, true)
			DisableControlAction(0, 34, true)
			DisableControlAction(0, 35, true)
			DisableControlAction(0, 56, true)
			DisableControlAction(0, 57, true)
			DisableControlAction(0, 58, true)
			DisableControlAction(0, 73, true)
			DisableControlAction(0, 75, true)
			DisableControlAction(0, 137, true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 141, true)
			DisableControlAction(0, 142, true)
			DisableControlAction(0, 143, true)
			DisableControlAction(0, 166, true)
			DisableControlAction(0, 167, true)
			DisableControlAction(0, 170, true)
			DisableControlAction(0, 177, true)
			DisableControlAction(0, 178, true)
			DisableControlAction(0, 182, true)
			DisableControlAction(0, 187, true)
			DisableControlAction(0, 188, true)
			DisableControlAction(0, 189, true)
			DisableControlAction(0, 190, true)
			DisableControlAction(0, 243, true)
			DisableControlAction(0, 257, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 264, true)
			DisableControlAction(0, 268, true)
			DisableControlAction(0, 269, true)
			DisableControlAction(0, 270, true)
			DisableControlAction(0, 271, true)
			DisableControlAction(0, 288, true)
			DisableControlAction(0, 289, true)
			DisableControlAction(0, 311, true)
			DisableControlAction(0, 344, true)
		end

		Citizen.Wait(time)
	end
end)

