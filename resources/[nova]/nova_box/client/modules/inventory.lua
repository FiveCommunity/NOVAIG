RegisterNUICallback('GetInventory', function(data, cb)
  cb(Execute.getInventory())
end)

RegisterNUICallback('getBox', function(data, cb)
  local Crate
  for i, v in pairs(GlobalState.Crates) do
    if v.id == data then
      Crate = v
    end
  end

  cb({ boxName = Crate.name, image = Crate.image_url, drops = GlobalState.CratesItems[data] or {} })
end) 

RegisterNUICallback("boxOpened", function(data, cb)
  cb(Execute.openInventoryBox(data))
end)


RegisterNUICallback('Reward', function(data, cb)
  cb(Execute.paymentReward())
end)
