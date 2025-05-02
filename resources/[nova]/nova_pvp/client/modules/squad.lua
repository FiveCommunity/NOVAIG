RegisterNuiCallback('OPEN_SQUAD', function(data, cb)
    local response = Execute.requestPlayerSquad()
    if not response then
        return cb(true)
    end

    if response.haveClan then
        SendNUIMessage({ action = 'open:squad' })
        return cb(true)
    end

    if response.haveTicket then
        SendNUIMessage({ action = 'open:registerSquad' })
        return cb(true)
    end

    SendNUIMessage({ action = 'open:notSquad' })
    cb(true)
end)

RegisterNuiCallback('GET_SQUAD', function(data, cb)
    cb(Execute.requestSquad())
end)

RegisterNuiCallback('REGISTER_SQUAD', function(data, cb)
    cb(Execute.createSquad(data))
end)

RegisterNuiCallback('INVITE_MEMBER', function(data, cb)
    cb(Execute.inviteMember(data.id))
end)

RegisterNuiCallback('REMOVE_MEMBER', function(data, cb)
    cb(Execute.removeMember(data.member.user_id))
end)

RegisterNuiCallback('QUIT_SQUAD', function(data, cb)
    cb(Execute.leaveSquad())
end)

RegisterNuiCallback('UPDATE_SQUAD_BANNER', function(data, cb)
    cb(Execute.updateSquadBanner(data))
end)

