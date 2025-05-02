function changeCamPosition(camPos)
  local playerPed = PlayerPedId()
  local camOffests = {
    ['hair'] = function()
      local playerCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0, 0.35 ,0.10)
      SetCamCoord(cam, playerCoords.x, playerCoords.y, playerCoords.z + 0.7)
    end,

    ['face'] = function()
      local playerCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0, 0.35 ,0.10)
      SetCamCoord(cam, playerCoords.x, playerCoords.y, playerCoords.z + 0.55)
    end,

    ['beard'] = function()
      local playerCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0, 0.30 ,0.10)
      SetCamCoord(cam, playerCoords.x, playerCoords.y, playerCoords.z + 0.49)
    end,
  }

  if camOffests[camPos] then
    camOffests[camPos]()
  end
end

local horizontalFloat = 0.0
local verticalFloat = 0.0
function moveCamPosition(camPos, floatPos)
  local camPositions = {
    ['VERTICAL'] = function()
      verticalFloat = floatPos
    end,

    ['HORIZONTAL'] = function()
      horizontalFloat = floatPos
    end,
  }

  if camPositions[camPos] then
      camPositions[camPos]()
  end

  local playerCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, (0.35 + horizontalFloat * 0.12) ,0.10)
  SetCamCoord(cam, playerCoords.x, playerCoords.y, (playerCoords.z + (verticalFloat == 0.0 and 0.55 or (verticalFloat * 0.7)))   )
end