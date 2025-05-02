RegisterNuiCallback('GetFarms', function(data, cb)
  cb(vTunnel.getFarms())
end)

RegisterNUICallback('GetGoals', function(data, cb)
  cb(vTunnel.getGoals())
end)

RegisterNUICallback('RedeemPrize', function(data, cb)
  local reward = vTunnel.rewardGoal()
  if reward then
    DeletarObjeto()
    SendNUIMessage({ action = 'close' })
    SetNuiFocus(false,false)
  end

  cb(reward)
end)

-- RegisterNUICallback('GetGoalsConfig', function(data, cb)
--   cb(vTunnel.getListGoals())
-- end)
  
RegisterNUICallback('EditMyGoal', function(data, cb)
  DeletarObjeto()
  SendNUIMessage({ action = 'close' })
  SetNuiFocus(false,false)

  cb(vTunnel.saveGoals(data))
end)