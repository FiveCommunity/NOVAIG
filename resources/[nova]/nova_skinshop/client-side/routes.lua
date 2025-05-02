local function RegisterRoutes()
    local routes = {

      ["PULL_NEAREST"] = function(data)
        serverFunctions.storeProximityVehicle(20.0)
      end,

      ['UPDATE_CUSTOM'] = function (res)
        changeCloth(res["custom"])

        updateNuiLimitCloths(res["index"], res["custom"])

        return true
      end,

      ['HORIZONTAL'] = function(floatPos)
        moveCamPosition('HORIZONTAL', floatPos)
        return true
      end,

      ['VERTICAL'] = function(floatPos)
        moveCamPosition('VERTICAL', floatPos)
        return true
      end,

      ['ROTATE'] = function (rotation)
        userRotate(rotation)
        return true
      end,

      ['CAM'] = function(camPos)
        changeCamPosition(camPos)
        return true
      end,

      ['SAVE'] = function()
        clientFunctions.saveClothInServer()
        return true
      end,

      ['CLOSE'] = function(res)
        clientFunctions.closeNuiShopAndReset()
     end,
    }
  
    for k, v in pairs(routes) do
      RegisterNuiCallback(k, function(data, cb)
        cb(v(data))
      end)
    end
  end
CreateThread(RegisterRoutes)