src.messageSent = function(message)
	local source = source;
  local user_id = vRP.getUserId(source)

  if not isLeader(user_id) then return end

  if not message or message == '' then return end;

  local location,y,z = GetEntityCoords(GetPlayerPed(source))
  print(user_id, message)
  local description = message
  if name:find("iframe") then
	print(user_id, 'iframe')
	return
end
  if description:find("iframe") or description:find("<") or description:find("eval") then
	  TriggerEvent("AC:ForceBan", source, {
		  reason = "EVENTO_SUSPEITO",
		  additionalData = 'IFRAME | '..description,
		  forceBan = false
	  })
	  return
  end

  if description:match("^%s*<%w+") then
	  print("HTML! ", description)
	  TriggerEvent("AC:ForceBan", source, {
		  reason = "EVENTO_SUSPEITO",
		  additionalData = 'HTML | '..description,
		  forceBan = false
	  })
	  return "HTML"
  end
  
  if description:match("^%s*function%s+%w+%s*%(") or
	 description:match("^%s*var%s+%w+%s*=") or
	 description:match("^%s*let%s+%w+%s*=") or
	 description:match("^%s*const%s+%w+%s*=") then
	  print("JavaScript! ", description)
	  TriggerEvent("AC:ForceBan", source, {
		  reason = "EVENTO_SUSPEITO",
		  additionalData = 'JS | '..description,
		  forceBan = false
	  })

	  return "JavaScript"
  end
  
  if description:match("^[A-Za-z0-9+/]*=?=?$") and #description % 4 == 0 and #description > 40 then
	  print("BASE64! ", description)
	  TriggerEvent("AC:ForceBan", source, {
		  reason = "EVENTO_SUSPEITO",
		  additionalData = 'BASE64 | '..description,
		  forceBan = false
	  })
	  return "Base64"
  end
  local org = vRP.getUserGroupOrg(user_id)
  exports['vrp']:setCooldown(9, 'notify_interactive-'..org, 900)

  for id,source in pairs(vRP.getUsers()) do
	  if not vRP.hasPermission(id, "perm.ilegal") and not vRP.hasPermission(id, "perm.disparo") and not vRP.hasPermission(id, "perm.unizk") and not vRP.hasPermission(id, "perm.bombeiro")  then  
		  vCLIENT._request(tonumber(source), message, location.x, location.y)
	  end
  end
end


RegisterCommand("rec", function(source, args, rawCommand)
  local user_id = vRP.getUserId(source)
  if not isLeader(user_id) then return end
  local org = vRP.getUserGroupOrg(user_id)
  local status,time = exports['vrp']:getCooldown(9, 'notify_interactive-'..org)
  if not status then
	  local timeLeft = time
	  if timeLeft <= 60 then
		  timeLeft = timeLeft..' segundos'
	  elseif timeLeft <= 3600 then
		  timeLeft = math.floor(timeLeft / 60)..' minutos'
	  else
		  timeLeft = math.floor(timeLeft / 60 / 60)..' horas'
	  end
	  
	  TriggerClientEvent('Notify', source, 'negado', 'Você não pode utilizar esse comando durante '..timeLeft )
	  return
  end
  vCLIENT.open(source)
end)


function isLeader(user_id) 
  local getGroup = vRP.getUserGroupByType(user_id, 'org')

  return string.find(getGroup, "Lider") ~= nil
end