--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE CACHE
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local cache = {}
cache['getUserIdentity'] = {}
cache['getUserByRegistration'] = {}
cache['getUserByPhone'] = {}

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QUERYS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_user_identity","SELECT * FROM vrp_user_identities WHERE user_id = @user_id")
vRP.prepare("vRP/init_user_identity","INSERT IGNORE INTO vrp_user_identities(user_id,registro,telefone,nome,sobrenome,idade) VALUES(@user_id,@registro,@telefone,@nome,@sobrenome,@idade)")
vRP.prepare("vRP/update_user_identity","UPDATE vrp_user_identities SET nome = @nome, sobrenome = @sobrenome, idade = @idade, registro = @registro, telefone = @telefone WHERE user_id = @user_id")
vRP.prepare("vRP/get_userbyreg","SELECT user_id FROM vrp_user_identities WHERE registro = @registro")
vRP.prepare("vRP/get_userbyphone","SELECT user_id FROM vrp_user_identities WHERE telefone = @telefone")
vRP.prepare("vRP/update_user_first_spawn","UPDATE vrp_user_identities SET nome = @nome, sobrenome = @sobrenome, idade = @idade WHERE user_id = @user_id")

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.getUserIdentity(user_id)
	if user_id then
		if cache['getUserIdentity'][user_id] == nil then
			local rows = vRP.query("vRP/get_user_identity",{ user_id = user_id })
			if #rows > 0 then
				cache['getUserIdentity'][user_id] = rows[1]
			end
		end

		return cache['getUserIdentity'][user_id] or false
	end
end

function vRP.updateIdentity(user_id)
	if user_id then
		cache['getUserIdentity'][user_id] = nil
	end
end 

function vRP.getUserByRegistration(registration)
	if registration then
		registration = registration:gsub(" ", "")
		
		if cache['getUserByRegistration'][registration] == nil then
			local rows = vRP.query("vRP/get_userbyreg",{ registro = registration or "" })
			if #rows > 0 then
				cache['getUserByRegistration'][registration] = rows[1].user_id
			end
		end

		return cache['getUserByRegistration'][registration] or false
	end

	return false
end

function vRP.getUserByPhone(phone)
	if cache['getUserByPhone'][phone] == nil then
		local rows = vRP.query("vRP/get_userbyphone",{ telefone = phone or "" })
		if #rows > 0 then
			cache['getUserByPhone'][phone] = rows[1].user_id
		end
	end

	return cache['getUserByPhone'][phone] or false
end

function vRP.getVehiclePlate(plate)
    return vRP.getUserByRegistration(plate)
end

function vRP.generateStringNumber(format)
	local abyte = string.byte("A")
	local zbyte = string.byte("0")
	local number = ""
	for i=1,#format do
		local char = string.sub(format,i,i)
    	if char == "D" then number = number..string.char(zbyte+math.random(0,9))
		elseif char == "L" then number = number..string.char(abyte+math.random(0,25))
		else number = number..char end
	end
	return number
end

function vRP.generateRegistrationNumber(cbr)
	local user_id = nil
	local registration = ""
	repeat
	  registration = vRP.generateStringNumber("LLLDLDLL")
	  user_id = vRP.getUserByRegistration(registration)
	until not user_id
  
	return registration
  end

function vRP.generatePhoneNumber()
	local user_id = nil
	local telefone = ""

	repeat
		telefone = vRP.generateStringNumber("DDD-DDD")
		user_id = vRP.getUserByPhone(telefone)
	until not user_id

	return telefone
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EVENTOS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerJoin",function(user_id,source,name)
	if not vRP.getUserIdentity(user_id) then
		local registration = vRP.generateRegistrationNumber()
		local phone = vRP.generatePhoneNumber()
		vRP.execute("vRP/init_user_identity",{ user_id = user_id, registro = registration, telefone = phone, nome = "Individuo", sobrenome = "Indigente", idade = 18 })
	end
end)

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	local identity = vRP.getUserIdentity(user_id)
	if identity then
		vRPclient._setRegistrationNumber(source,identity.registro or "DDDDDD")
	end
end)
