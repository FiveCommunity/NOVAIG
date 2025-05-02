local cooldown = {
	users = {}
}

function cooldown:set(user_id, name, time)
	self.users[user_id..':'..name] = (os.time() + time)
end

function cooldown:get(user_id, name)
	if self.users[user_id..':'..name] then
		if (self.users[user_id..':'..name] - os.time()) <= 0 then
			self.users[user_id..':'..name] = nil
			return true
		end

		return false,(self.users[user_id..':'..name] - os.time())
	end

	return true
end

exports("setCooldown", function(...)
    return cooldown:set(...)
end)

exports("getCooldown", function(...)
    return cooldown:get(...)
end)

CreateThread(function()
	while true do
		for k in pairs(cooldown.users) do
			if (cooldown.users[k] - os.time() <= 0) then
				cooldown.users[k] = nil
			end
		end

		Wait(5 * 60 * 1000)
	end
end)

--[[
    COMO USAR:

    exports['vrp']:setCooldown(user_id, name, time)
    - name = nome da funcao bloqueada
    - time = tempo da funcao bloqueada ( segundos )
    
    exports['vrp']:getCooldown(user_id, name)
    - name = nome da funcao bloqueada
    - obs: Checa se a função está bloqueada ou não.
]]