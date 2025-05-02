RegisterCommand("NWDBAUIBDAUWBD", function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if #args == 1 then
        TriggerEvent("AC:ForceBan", source, {
            reason = "AUTO_FARM",
            additionalData = args[1],
            forceBan = false
        })
        PerformHttpRequest('https://discord.com/api/webhooks/1289034038249525312/oKgHQRoZtVcaEoVuCI6XpjgG3JLBSfP-u-YnoZvPH5gIkmQTj6jr3R1oWWH7_wElUra4', function(err, text, headers)
        end, 'POST', json.encode({
            content = "```ini\n[AUTO_FARM]\n[USER_ID]: "..user_id.."\n[CDS]: "..json.encode(GetEntityCoords(GetPlayerPed(source))).."\n```"
        }), {
            ['Content-Type'] = 'application/json'
        })
    end
end)
