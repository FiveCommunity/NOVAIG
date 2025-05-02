local isOpened = false
src.toggleScreen = function(isOpened, data)
  if not isOpened then 
    SendNUIMessage({ action = 'close' })
    SetNuiFocus(false, false)
    return;
  end
  
  SetNuiFocus(true, true)
  SendNUIMessage({ action = 'open', data = data })
end

src.removeScreen = function()
  isOpened = false
  SendNUIMessage({ action = 'close' })
  SetNuiFocus(false, false)
end

-- ajustar depois
CreateThread(function()
  while true do
    local timeSleep = 1000
    local ped = PlayerPedId()
    if isOpened then 
      timeSleep = 0
      DisableControlAction(1, 19, true)
    end
    FreezeEntityPosition(ped, isOpened)
    Wait(timeSleep)
  end
end)