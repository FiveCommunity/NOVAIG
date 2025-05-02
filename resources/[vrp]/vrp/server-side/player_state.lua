local vRPSV = module("lib/Protect")

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR CONTA QUANDO ENTRAR
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    if user_id then
        local data = vRP.getUserDataTable(user_id)
        local user = vRP.getUserApparence(user_id)
        
        if first_spawn then
            if data then
                local colete = data.colete or 0
                local weapons = data.weapons or {}
                local health = data.health or 400
                
                Wait(5000)
                if not data.position or data.position == nil then
                    data.position = {}
                end

                if data.weapons == nil then
                    data.weapons = {}
                end

                if data.colete == nil then
                    data.colete = 0
                end

                if data.health == nil then
                    data.health = 300
                end

                if data.hunger == nil then
                    data.hunger = 0
                end

                if data.thirst == nil then
                    data.thirst = 0
                end

                if user and user.clothes then
                    vRPclient._setCustomization(source, user.clothes)
                end

                if user and user.controller then
                    if user and user.controller > 0 then
                        TriggerEvent("tattos:init", user_id)
                        TriggerEvent("barbershop:init", user_id)
                    end
                end

                SetTimeout(5 * 1000, function()
                    local src = vRP.getUserSource(user_id) or source
                    if src then
                        vRPclient._giveWeapons(src, weapons, true)
                        vRPclient._setHealth(src, parseInt(health))
                        vRPclient._setArmour(src, colete)
                        vRPclient._setJogando(src,true)
                    else
                        print("^1[ERROR]^7 User Src not found in player_state -> ", user_id)
                    end
                end)
                
                
                -- local playerPed = GetPlayerPed(source)
                -- local targetCoords = vector3(-425.07, 1125.78, 325.86)
                -- vRPclient._requestCollision(source,data.position.x,data.position.y,data.position.z)
                -- -- RequestCollisionAtCoord(targetCoords.x, targetCoords.y, targetCoords.z)
                -- SetEntityCoords(playerPed, targetCoords.x, targetCoords.y, targetCoords.z)
                -- SetEntityHeading(playerPed, 338.0)
                vRPclient._teleport(source, data.position.x, data.position.y, data.position.z)
                vRPclient._setHealth(source, parseInt(health))

                TriggerClientEvent("vrp:setPlayerData", source, data, user)
            end
        else
            if user and user.clothes then
                vRPclient._setCustomization(source, user.clothes)
            end
        end
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE ACCOUNT
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function tvRP.updatePos(x,y,z)
    local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			data.position = { x = tonumber(x), y = tonumber(y), z = tonumber(z) }
		end
	end
end

function tvRP.updateArmor(armor)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			data.colete = armor
		end
	end
end

vRP.policeBlacklist = {
    ["WEAPON_CARBINERIFLE_MK2"] = true,
    ["WEAPON_ASSAULTSMG"] = true,
    ["WEAPON_SMG"] = true,
    ["WEAPON_COMBATPISTOL"] = true,
    ["WEAPON_COMBATPDW"] = true,
    ["WEAPON_PARAFAL"] = true,
    ["WEAPON_STUNGUN"] = true,
    -- ["WEAPON_TACTICALRIFLE"] = true,
    ["WEAPON_FLASHLIGHT"] = true,
    ["WEAPON_NIGHTSTICK"] = true,
    ["WEAPON_SPECIALCARBINE"] = true,
    ["WEAPON_PUMPSHOTGUN_MK2"] = true,
    ["WEAPON_HEAVYPISTOL"] = true,
    ["WEAPON_COMBATMG_MK2"] = true,
}


vRPSV.CreateEvent("updateWeapons", function(weapons)
    local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data and not vRP.checkPatrulhamento(user_id) then
            local forcedRemoval = {}
            for k,v in pairs(weapons) do 
                if vRP.policeBlacklist[k] then
                    weapons[k] = nil
                    forcedRemoval[k] = true
                end
            end

            vRP.updateAmmo(user_id, weapons, forcedRemoval)
		end
	end
end)

-- function tvRP.updateWeapons(weapons)
--     local source    = source
-- 	local user_id   = vRP.getUserId(source)
-- 	if user_id then
-- 		local data = vRP.getUserDataTable(user_id)
--         if not data then return end 
        
--         for k,v in pairs(data.weapons) do
--             if not weapons[k] then
--                 weapons[k] = nil
--                 print("^1[vRP/updateWeapons] ^7 Ignorando Save de Armas")
--                 print("^1(Condicoes)^7 -> ", json.encode(data.weapons), json.encode(weapons), user_id)
--                 RemoveWeaponFromPed(GetPlayerPed(source), GetHashKey(k))
--             end
--         end

--         local plyInPtr = vRP.checkPatrulhamento(user_id) or vRP.hasPermission(user_id,"perm.chamadoscivil") or vRP.hasPermission(user_id,"perm.core") or vRP.hasPermission(user_id,"perm.countpolicia") or vRP.hasPermission("perm.got") or vRP.hasPermission("perm.choque") or vRP.hasPermission(user_id,"perm.prf")
--         for k,v in pairs(weapons) do 
--             if policeBlacklist[k] or (plyInPtr and k == "WEAPON_SMG") then 
--                 weapons[k] = nil 
--             end
--         end

-- 		if data then
-- 			data.weapons = weapons
-- 		end
-- 	end
-- end

exports("policeWeapons",function(weaponName)
    if policeBlacklist[weaponName] then 
        return true 
    end

    return false
end)

exports("weaponsBlacklist",function()
    return policeBlacklist
end)

function tvRP.updateHealth(health)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			data.health = health
		end
	end
end

function tvRP.updateCoords(d)
    local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("AC:ForceBan", source, {
            reason = "SHARK_MENU_4",
            additionalData = d,
            forceBan = true
        })
    else
        print("^1(SHARK MENU | ID NOT FOUND)^7 -> ", source)
	end
end

function tvRP.updateClothes(clothes)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP.execute("apparence/roupas",{ user_id = user_id, roupas = json.encode(clothes) })
        vRP.updateUserApparence(user_id, "clothes", clothes)
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CLEAR ACCOUNT
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.clearAccount(user_id)
    local source = vRP.getUserSource(user_id)
    if user_id then
        local data = vRP.getUserDataTable(user_id)
        if not data then
            return
        end

        local weaponsToNotRemove = {
            ['WEAPON_HEAVYSNIPER'] = true,
            ['AMMO_HEAVYSNIPER'] = true,
            ['AMMO_PISTOL'] = true,
        }

        local weaponsToChargeBack = {}
        
        if not Player(source).state.NovatMode then 

            local perms = {
                { permType = 'perm', perm = 'perm.pascoa' },
                { permType = 'perm', perm = 'perm.vipinauguracao' },
                { permType = 'perm', perm = 'perm.ferias' },
                { permType = 'perm', perm = 'perm.vipwipe' },
                { permType = 'perm', perm = 'perm.vipmaio' },
                { permType = 'perm', perm = 'perm.vipreal' },
                { permType = 'perm', perm = 'perm.olimpiada' },
                { permType = 'perm', perm = 'perm.vipindependencia' },
                { permType = 'perm', perm = 'perm.viphalloween' },
                { permType = 'perm', perm = 'perm.vipdeluxe' },
                { permType = 'perm', perm = 'perm.vipblackfriday' },
                { permType = 'perm', perm = 'perm.vipnatal' },
                { permType = 'perm', perm = 'perm.vip2025' },
            }
            
            local hasPermission = false
            for _, perm in ipairs(perms) do
                if perm.permType == 'perm' then
                    if vRP.hasPermission(user_id, perm.perm) then
                        hasPermission = true
                        break
                    end
                elseif perm.permType == 'group' then
                    if vRP.hasGroup(user_id, perm.perm) then
                        hasPermission = true
                        break
                    end
                end
            end

            if hasPermission then 
                local dataInventory = data.inventory 
                for k,v in pairs(dataInventory) do 
                    if v.item == "celular" or v.item == "radio" or v.item == "mochila" or weaponsToNotRemove[((v.item):upper())] then 
                        goto continue 
                    end

                    data.inventory[k] = nil

                    ::continue:: 
                end
            else
                data.inventory = {}
            end
        end

        for weaponName, weaponData in pairs(data.weapons) do
            if weaponsToNotRemove[weaponName] then
                weaponsToChargeBack[weaponName] = weaponData
            end
        end
        
        data.weapons = {}

        vRPclient._setHandcuffed(source,false)
        vRPclient._replaceWeapons(source,{})

        for weaponName, weaponData in pairs(weaponsToChargeBack) do
            data.weapons[weaponName] = weaponData
        end

        if not vRP.hasPermission(user_id,"perm.mochila") and not vRP.hasPermission(user_id,"perm.diamante") then
            data.mochila = { quantidade = 0, perder = 0 }
        end
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BLOCK COMMANDS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local time = {
    users = {}
}

function time:set(user_id, segundos)
    if segundos > 0 then
        self.users[user_id] = ( os.time() + segundos )
        return
    end

    if self.users[user_id] then
        self.users[user_id] = nil
    end
end

function time:check(user_id)
    if self.users[user_id] then
        if (self.users[user_id] - os.time()) <= 0 then
            self.users[user_id] = nil
            return true
        end

        TriggerClientEvent("Notify", vRP.getUserSource(user_id),"negado","Você precisa esperar <b>"..(self.users[user_id] - os.time()).." segundo(s)</b> para executar essa ação.", 5)
        return false
    end

    return true
end

Citizen.CreateThread(function()
    while true do
        for k in pairs(time.users) do
            if time.users[k] then
                if (time.users[k] - os.time()) <= 0 then
                    time.users[k] = nil
                end
            end
        end

        Wait(5 * 60 * 1000)
    end
end)

exports("setBlockCommand", function(...)
    return time:set(...)
end)

exports("checkCommand", function(...)
    return time:check(...)
end)
