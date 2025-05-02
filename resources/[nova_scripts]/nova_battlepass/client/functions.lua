function OpenBattlepassUI()
    SetNuiFocus(true,true)
    SendNUIMessage({ action = 'opened', data = true })
end

function CloseBattlepassUI()
    SetNuiFocus(false,false)
    SendNUIMessage({ action = 'opened', data = false })
end