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
    ['CLOSE'] = function()
      SetNuiFocus(false, false)
      return true
    end
  }

  for k, v in pairs(routes) do
    RegisterNUICallback(k, function (data, cb)
      cb(v(data))
    end)
  end
end
CreateThread(RegisterRoutes)