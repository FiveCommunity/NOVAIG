local function RegisterRoutes()
    local routes = {
        ["CAM"] = function(camPos)
            changeCamPosition(camPos)
        end,

        ["HORIZONTAL"] = function(floatPos)
            moveCamPosition("HORIZONTAL", floatPos)
            return true
        end,

        ["VERTICAL"] = function(floatPos)
            moveCamPosition("VERTICAL", floatPos)
            return true
        end,

        ["CLOSE"] = function()
            clientFunctions.closeNuiShop(true)
            return true
        end,
        
        ["SAVE"] = function()
            clientFunctions.saveBarberShop()
        end,

        ["UPDATE_CUSTOM"] = function(data)
            changeBarber(data)
            return true
        end,

        ["ROTATE"] = function(rotation)
            userRotate(rotation)
            return true
        end,
    }

    for k, v in pairs(routes) do
        RegisterNUICallback(
            tostring(k),
            function(data, cb)
                cb(v(data))
            end
        )
    end
end
CreateThread(RegisterRoutes)

function clientFunctions.openNui(id, type)
    opennedGarageId = id
    opennedGarageType = type

    SetNuiFocus(true, true)
    SendNUIMessage({action = "open"})
    TriggerEvent("flaviin:toggleHud",false)
end

function clientFunctions.closeNui()
    SendNUIMessage({action = "close"})
    SetNuiFocus(false, false)
    TriggerEvent("flaviin:toggleHud",true)
end

function clientFunctions.addBarberShop(id, coords, blip)
	locations[tostring(id)] = { coords.x, coords.y, coords.z, blip, true }
	if blip then
        blipsInMap[tostring(id)] = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blipsInMap[tostring(id)], 71)
        SetBlipColour(blipsInMap[tostring(id)], 49)
        SetBlipScale(blipsInMap[tostring(id)], 0.5)
        SetBlipAsShortRange(blipsInMap[tostring(id)], true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Barbearia")
        EndTextCommandSetBlipName(blipsInMap[tostring(id)])
	end
end

function clientFunctions.removeBarberShop(id)
	locations[tostring(id)] = nil
	if DoesBlipExist(blipsInMap[tostring(id)]) then
		RemoveBlip(blipsInMap[tostring(id)])
		blipsInMap[tostring(id)] = nil
	end
end