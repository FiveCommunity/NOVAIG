RegisterNUICallback('GetRewards', function(data, cb)
    cb(Execute.GetRewards())
end)

RegisterNUICallback('GetRanking', function(data, cb)
    cb(Execute.requestRanking())
end)

RegisterNUICallback('GetUserRanking', function(data, cb)
    cb(Execute.requestMyRanking())
end)

RegisterNUICallback('CanRescue', function(data, cb)
    cb(Execute.CanRescue())
end)

RegisterNUICallback('Rescue', function(data, cb)
    SendNUIMessage({ action = 'Close' })
    SetNuiFocus(false,false)
    
    cb(Execute.reward())
end)