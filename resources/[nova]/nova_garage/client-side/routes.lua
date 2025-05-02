local function RegisterRoutes()
  local routes = {

    ["SELL_VEHICLE"] = function(vehicleData)
      serverFunctions.sellVehicle(vehicleData)
      return true
    end,

    ["LEND_VEHICLE"] = function(vehicleData)
      serverFunctions.addKeyCarForOtherUser(vehicleData)
      return true
    end,

    ["PULL_NEAREST"] = function(data)
      serverFunctions.storeProximityVehicle(20.0)
    end,

    ["GET_GARAGE"] = function()
      return requestVehiclesUserTable()
    end,
    ["TAKE_OUT"] = function(vehicleData) -- RETIRAR O VEÍCULO
      spawnVehicle(vehicleData)
      clientFunctions.closeNui()
      return true
    end,
    ["PULL"] = function(vehicleData) -- GUARDAR O VEÍCULO
      pullVehicle(vehicleData)
      clientFunctions.closeNui()
      return true
    end,

    ["CLOSE"] = function()
      clientFunctions.closeNui()
      return true
    end
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
  SendNUIMessage({ action = "open" })
end

function clientFunctions.closeNui()
  SendNUIMessage({ action = "close" })
  SetNuiFocus(false, false)
end

exports('getVehicleName', function(vehicle)
  return serverFunctions.getVehicleName(vehicle)
end)

exports('getVehicleTrunk', function(vehicle)
  return serverFunctions.getVehicleTrunk(vehicle)
end)

exports("foundGarageByPermission", function (perm)
  for _, garage in pairs(garagesLocs) do
    if garage.permiss == perm then
      return garage
    end
  end
  return {}
end)

function DrawText3DAlways(x, y, z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  if not onScreen then
      return
  end

  local playerCoords = GetEntityCoords(PlayerPedId())
  local distance = #(playerCoords - vector3(x, y, z))
  local scale = 1.0 / math.max(distance, 1.0) * 2.0
  scale = math.min(scale, 0.35)
  scale = math.max(scale, 0.2)

  SetTextScale(scale, scale)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 255)
  SetTextOutline()
  SetTextCentre(true)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(_x, _y)
end

RegisterNetEvent('garage:showBlips', function(org)
  CreateThread(function()
      local coordsInMap = exports["nova_garage"]:foundGarageByPermission('perm.'..(org:lower()))
      if not coordsInMap or not next(coordsInMap) then
        return
      end
      if not coordsInMap.coords then
        return
      end

      local coords = vec3(coordsInMap.coords.x, coordsInMap.coords.y, coordsInMap.coords.z)
      if not coords then return end

      local endTime = GetGameTimer() + (1000 * 60 * 2)
      while GetGameTimer() < endTime do
          Wait(0)
          DrawText3DAlways(coords.x, coords.y, coords.z + 1.0, "Garagem")
      end
  end)
end)