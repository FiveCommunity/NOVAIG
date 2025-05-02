RegisterNuiCallback('GetExtracts', function(data, cb)
    cb(vTunnel.getBankInfos())
end)

RegisterNuiCallback('Withdraw', function(data, cb)
    cb(vTunnel.transactionBank({ type = 'withdraw', amount = data.value }))
end)
    
RegisterNuiCallback('Deposit', function(data, cb)
    cb(vTunnel.transactionBank({ type = 'deposit', amount = data.value }))
end)

RegisterNetEvent('updateExtract', function(data)
    SendNUIMessage({ action = 'UpdateExtracts', data = data.extracts })
    SendNUIMessage({ action = 'UpdateBalance', data = data.balance })
    SendNUIMessage({ action = 'UpdatePlayerBalance', data = data.playerBalance })
end)
