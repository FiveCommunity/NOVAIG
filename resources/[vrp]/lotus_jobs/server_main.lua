local WeebHook = "https://discord.com/api/webhooks/1111487093470932993/iBvPNO2OCupx4z1HIb6oUXS2f7dMSfz5CrK2akCYKJ3zq2a5LjwncYBGwkFFvnB0CMoA"

function SendLog(content)
    PerformHttpRequest(WeebHook, function(err, text, headers) end, 'POST', json.encode({content = content}), { ['Content-Type'] = 'application/json' })
end

function RegisterTunnel.requestPlate()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local identity = vRP.getUserIdentity(user_id)

    return identity.registro
end