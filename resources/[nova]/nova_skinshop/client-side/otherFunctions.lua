RegisterNetEvent("updateRoupas2")
AddEventHandler("updateRoupas2", function(custom)
	skinData = custom
	resetClothing(custom)
	serverFunctions.saveCloths(custom)
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETCLOTHING
-----------------------------------------------------------------------------------------------------------------------------------------
function resetClothing(data)
	local ped = PlayerPedId()

	if data["backpack"] == nil then
		data["backpack"] = {}
		data["backpack"]["item"] = 0
		data["backpack"]["texture"] = 0
	end

	SetPedComponentVariation(ped,4,data["pants"]["item"],data["pants"]["texture"],1)
	SetPedComponentVariation(ped,3,data["arms"]["item"],data["arms"]["texture"],1)
	SetPedComponentVariation(ped,5,data["backpack"]["item"],data["backpack"]["texture"],1)
	SetPedComponentVariation(ped,8,data["tshirt"]["item"],data["tshirt"]["texture"],1)
	SetPedComponentVariation(ped,9,data["vest"]["item"],data["vest"]["texture"],1)
	SetPedComponentVariation(ped,11,data["torso"]["item"],data["torso"]["texture"],1)
	SetPedComponentVariation(ped,6,data["shoes"]["item"],data["shoes"]["texture"],1)
	SetPedComponentVariation(ped,1,data["mask"]["item"],data["mask"]["texture"],1)
	SetPedComponentVariation(ped,10,data["decals"]["item"],data["decals"]["texture"],1)
	SetPedComponentVariation(ped,7,data["accessory"]["item"],data["accessory"]["texture"],1)

	if data["hat"]["item"] ~= -1 and data["hat"]["item"] ~= 0 then
		SetPedPropIndex(ped,0,data["hat"]["item"],data["hat"]["texture"],1)
	else
		ClearPedProp(ped,0)
	end

	if data["glass"]["item"] ~= -1 and data["glass"]["item"] ~= 0 then
		SetPedPropIndex(ped,1,data["glass"]["item"],data["glass"]["texture"],1)
	else
		ClearPedProp(ped,1)
	end

	if data["ear"]["item"] ~= -1 and data["ear"]["item"] ~= 0 then
		SetPedPropIndex(ped,2,data["ear"]["item"],data["ear"]["texture"],1)
	else
		ClearPedProp(ped,2)
	end

	if data["watch"]["item"] ~= -1 and data["watch"]["item"] ~= 0 then
		SetPedPropIndex(ped,6,data["watch"]["item"],data["watch"]["texture"],1)
	else
		ClearPedProp(ped,6)
	end

	if data["bracelet"]["item"] ~= -1 and data["bracelet"]["item"] ~= 0 then
		SetPedPropIndex(ped,7,data["bracelet"]["item"],data["bracelet"]["texture"],1)
	else
		ClearPedProp(ped,7)
	end
end

function clientFunctions.addSkinshop(id, coords, blip)
	locateShops[tostring(id)] = { coords.x, coords.y, coords.z, blip, true }
	if blip then
		blipsInMap[tostring(id)] = AddBlipForCoord(coords.x, coords.y, coords.z)
		SetBlipSprite(blipsInMap[tostring(id)], 73)
		SetBlipColour(blipsInMap[tostring(id)], 49)
		SetBlipScale(blipsInMap[tostring(id)], 0.5)
		SetBlipAsShortRange(blipsInMap[tostring(id)], true)
	end
end

function clientFunctions.removeSkinshop(id)
	locateShops[tostring(id)] = nil
	if DoesBlipExist(blipsInMap[tostring(id)]) then
		RemoveBlip(blipsInMap[tostring(id)])
		blipsInMap[tostring(id)] = nil
	end
end