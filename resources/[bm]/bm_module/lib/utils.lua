function sendToDiscord(weebhook, message)
	PerformHttpRequest(weebhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = message}), { ['Content-Type'] = 'application/json' })
end
