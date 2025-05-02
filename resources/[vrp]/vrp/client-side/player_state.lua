local vRPSV = module("lib/Protect")

if not vRPSV then
	vRPSV = {
		updateWeapons = function(...)
			print("^1Ignorando Weapon Save ^7")
		end
	}
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MAIN
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local jogando = false
local in_arena = false

function tvRP.setJogando(boolean)
	jogando = boolean
end

RegisterNetEvent("mirtin_survival:updateArena")
AddEventHandler("mirtin_survival:updateArena", function(boolean)
    in_arena = boolean
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SALVAMENTO DE DADOS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local old_health  = 0
	local old_armor   = 0
	local old_clothes = {}

	while true do
		if not LocalPlayer.state.inPvP and not in_arena and jogando then
			local new_weapons = tvRP.getWeapons()
			local new_clothes = tvRP.getCustomization()
			local new_health  = GetEntityHealth(PlayerPedId())
			local new_armor   = GetPedArmour(PlayerPedId())

			if not isTableEquals(old_clothes, new_clothes) then
				old_clothes = new_clothes
				vRPserver._updateClothes(old_clothes)
			end
			
			if old_health ~= new_health then
				old_health = new_health
				vRPserver._updateHealth(old_health)
			end

			if old_armor ~= new_armor then
				old_armor = new_armor
				vRPserver._updateArmor(old_armor)
			end

			
		end

		Citizen.Wait(2 * 60 * 1000)
	end 
end)

Citizen.CreateThread(function()
	local old_weapons = {}
	
	while true do
		if not LocalPlayer.state.inPvP and not in_arena and jogando then
			local new_weapons = tvRP.getWeapons()
			local plyCds = GetEntityCoords(PlayerPedId())

			if not isTableEquals(old_weapons, new_weapons) then
				old_weapons = new_weapons
				vRPSV.updateWeapons(old_weapons)
			end

			vRPserver._updatePos(plyCds.x, plyCds.y, plyCds.z)
		end

		Citizen.Wait(10000)
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ARMAS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local weapon_list = {}

local weapon_types = {
	"WEAPON_NAVYREVOLVER",
	"WEAPON_MILITARYRIFLE",
	"WEAPON_HAZARDCAN",
	"WEAPON_GADGETPISTOL",
	"WEAPON_COMBATSHOTGUN",
	"WEAPON_CERAMICPISTOL",
	"GADGET_PARACHUTE",
	"WEAPON_KNIFE",
	"WEAPON_KNUCKLE",
	"WEAPON_NIGHTSTICK",
	"WEAPON_HAMMER",
	"WEAPON_BAT",
	"WEAPON_GOLFCLUB",
	"WEAPON_CROWBAR",
	"WEAPON_BOTTLE",
	"WEAPON_DAGGER",
	"WEAPON_HATCHET",
	"WEAPON_MACHETE",
	"WEAPON_FLASHLIGHT",
	"WEAPON_SWITCHBLADE",
	"WEAPON_POOLCUE",
	"WEAPON_PIPEWRENCH",
	"WEAPON_STONE_HATCHET",
	"WEAPON_WRENCH",
	"WEAPON_BATTLEAXE",
	"WEAPON_AUTOSHOTGUN",
	"WEAPON_GRENADE",
	"WEAPON_STICKYBOMB",
	"WEAPON_PROXMINE",
	"WEAPON_BZGAS",
	"WEAPON_SMOKEGRENADE",
	"WEAPON_MOLOTOV",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_PETROLCAN",
	"WEAPON_FLARE",
	"WEAPON_BALL",
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	
	"WEAPON_FIREWORK",
	"WEAPON_SNOWBALL",
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_REVOLVER",
	"WEAPON_REVOLVER_MK2",
	"WEAPON_DOUBLEACTION",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_HEAVYRIFLE",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_STUNGUN",
	"WEAPON_FLAREGUN",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_RAYPISTOL",
	"WEAPON_MICROSMG",
	"WEAPON_MINISMG",
	"WEAPON_SMG",
	"WEAPON_SMG_MK2",
	"WEAPON_ASSAULTSMG",
	"WEAPON_COMBATPDW",
	"WEAPON_GUSENBERG",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_RAYCARBINE",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_CARBINERIFLE",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_PARAFAL",
	"WEAPON_TACTICALRIFLE",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_AKPENTEDE90_RELIKIASHOP",
	"WEAPON_AKDEFERRO_RELIKIASHOP",
	"WEAPON_AK472",
	"WEAPON_AR10PRETO_RELIKIASHOP",
	"WEAPON_AR15BEGE_RELIKIASHOP",
	"WEAPON_ARPENTEACRILICO_RELIKIASHOP",
	"WEAPON_ARDELUNETA_RELIKIASHOP",
	"WEAPON_ARLUNETAPRATA",
	"WEAPON_ARTAMBOR",
	"WEAPON_G3LUNETA_RELIKIASHOP",
	"WEAPON_GLOCKDEROUPA_RELIKIASHOP",
	"WEAPON_HKG3A3",
	"WEAPON_HK_RELIKIASHOP",
	"WEAPON_PENTEDUPLO1",
	"WEAPON_50_RELIKIASHOP",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_SWEEPERSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_MUSKET",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_DBSHOTGUN",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_RPG",
	"WEAPON_MINIGUN",
	"WEAPON_FIREWORK",
	"WEAPON_RAILGUN",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_RAYMINIGUN",
	"WEAPON_GRAJADA",
	"WEAPON_BARRET",
	"WEAPON_PIPEBOMB",

	"WEAPON_AKCROMO",
	"WEAPON_ARRELIKIASHOPFEMININO1",
	"WEAPON_ARRELIKIASHOPFEMININO2",
	"WEAPON_ARVASCO",
	"WEAPON_CHEYTAC",
	"WEAPON_G3RELIKIASHOPFEMININO",
	"WEAPON_GLOCKRAJADA",
	"WEAPON_GLOCKRELIKIASHOPFEMININO0"
}


function tvRP.getWeapons()
	local player = PlayerPedId()
	local ammo_types = {}
	local weapons = {}
	for k,v in pairs(weapon_types) do
		local hash = GetHashKey(v)
		if HasPedGotWeapon(player,hash) then
			if weapon_list[string.upper(v)] then 
				local weapon = {}
				weapons[v] = weapon
				local atype = Citizen.InvokeNative(0x7FEAD38B326B9F74,player,hash)
				if ammo_types[atype] == nil then
					ammo_types[atype] = true
					weapon.ammo = GetAmmoInPedWeapon(player,hash)
				else
					weapon.ammo = 0
				end
			else
				RemoveWeaponFromPed(player,hash)
				-- ExecuteCommand("m9NYS72rJhCqYfxExWtt vrp")
				print("^1[vRP] [WARNING] weapon ^7"..v.." ^1is not registered.^7")
			end
		end
	end
	return weapons
end

function tvRP.replaceWeapons(weapons)
	local old_weapons = tvRP.getWeapons()
	tvRP.giveWeapons(weapons,true)
	return old_weapons
end

function tvRP.giveWeapons(weapons,clear_before)
	local player = PlayerPedId()
	if clear_before then
		RemoveAllPedWeapons(player,true)
		weapon_list = {}
	end

	for k,weapon in pairs(weapons) do
		local hash = GetHashKey(k)
		local ammo = weapon.ammo or 0
		GiveWeaponToPed(player,hash,ammo,false)
		weapon_list[string.upper(k)] = weapon	
		TriggerEvent("systemWeapons:Apply",hash)						 
	end
end

function tvRP.getWeaponsLegal()
	return weapon_list
end

function tvRP.legalWeaponsChecker(weapon)
	local source = source
	local weapon = weapon
	local weapons_legal = tvRP.getWeaponsLegal()
	local ilegal = false
	local weapons_ilegal = {}						  
	for v, b in pairs(weapon) do
	  if not weapon_list[string.upper(v)] then
		printar("arma ilegal detectada")
		ilegal = true
		table.insert(weapons_ilegal, {name=string.upper(v),ammo=b.ammo})																   
	  end
	end
	if ilegal then
		tvRP.giveWeapons(weapons_legal, true)
		weapon = weapons_legal
		TriggerServerEvent("LOG:ARMASiawjdwai12312ojwda", weapons_ilegal)
	end
	return weapon
end

function tvRP.setArmour(amount)
	SetPedArmour(PlayerPedId(), amount)
	-- TriggerEvent("cagueidanese",amount)
end

function tvRP.getArmour()
	return GetPedArmour(PlayerPedId())
end

local function parse_part(key)
	if type(key) == "string" and string.sub(key,1,1) == "p" then
		return true,tonumber(string.sub(key,2))
	else
		return false,tonumber(key)
	end
end

function tvRP.getDrawables(part)
	local isprop, index = parse_part(part)
	if isprop then
		return GetNumberOfPedPropDrawableVariations(PlayerPedId(), index)
	else
		return GetNumberOfPedDrawableVariations(PlayerPedId(), index)
	end
end

function tvRP.getDrawableTextures(part, drawable)
	local isprop, index = parse_part(part)
	if isprop then
		return GetNumberOfPedPropTextureVariations(PlayerPedId(), index, drawable)
	else
		return GetNumberOfPedTextureVariations(PlayerPedId(), index, drawable)
	end
end

function tvRP.getCustomization()
	local ped = PlayerPedId()
	local custom = {}
	custom.pedModel = GetEntityModel(ped)

	for i = 0,11 do
		custom[i] = { GetPedDrawableVariation(ped,i),GetPedTextureVariation(ped,i),GetPedPaletteVariation(ped,i) }
	end

	for i = 0,7 do
		custom["p"..i] = { GetPedPropIndex(ped,i),math.max(GetPedPropTextureIndex(ped,i),0) }
	end

	return custom
end

function tvRP.getCustom()
    local ped = PlayerPedId()
    local custom = { GetPedDrawableVariation(ped,1),GetPedTextureVariation(ped,1),GetPedDrawableVariation(ped,5),GetPedTextureVariation(ped,5),GetPedDrawableVariation(ped,7),GetPedTextureVariation(ped,7),GetPedDrawableVariation(ped,3),GetPedTextureVariation(ped,3),GetPedDrawableVariation(ped,4),GetPedTextureVariation(ped,4),GetPedDrawableVariation(ped,8),GetPedTextureVariation(ped,8),GetPedDrawableVariation(ped,6),GetPedTextureVariation(ped,6),GetPedDrawableVariation(ped,11),GetPedTextureVariation(ped,11),GetPedDrawableVariation(ped,9),GetPedTextureVariation(ped,9),GetPedDrawableVariation(ped,10),GetPedTextureVariation(ped,10),GetPedPropIndex(ped,0),GetPedPropTextureIndex(ped,0),GetPedPropIndex(ped,1),GetPedPropTextureIndex(ped,1),GetPedPropIndex(ped,2),GetPedPropTextureIndex(ped,2),GetPedPropIndex(ped,6),GetPedPropTextureIndex(ped,6),GetPedPropIndex(ped,7),GetPedPropTextureIndex(ped,7) }
    return custom
end

function tvRP.setCustomization(custom)
	local r = async()
	Citizen.CreateThread(function()
        if custom then
            local mhash = nil

            if custom.pedModel then
                mhash = custom.pedModel
            end

            if mhash then
                while not HasModelLoaded(mhash) do
                    RequestModel(mhash)
                    Citizen.Wait(10)
                end

                if HasModelLoaded(mhash) then
                    local weapons = tvRP.getWeapons()
					local armour = GetPedArmour(PlayerPedId())
					local health = tvRP.getHealth()
					ClearPedBloodDamage(PlayerPedId())
					SetPlayerModel(PlayerId(), mhash)
					tvRP.setHealth(health)
					-- SetPedCanRagdoll(PlayerPedId(), false)
					tvRP.giveWeapons(weapons,true)
					tvRP.setArmour(armour)
					SetModelAsNoLongerNeeded(mhash)
                end
            end

            for k,v in pairs(custom) do
                if k ~= "pedModel" then
                    local isprop, index = parse_part(k)
					if isprop then
						if v[1] < 0 then
							ClearPedProp(PlayerPedId(),index)
						else
							SetPedPropIndex(PlayerPedId(),index,v[1],v[2],v[3] or 2)
						end
					else
						SetPedComponentVariation(PlayerPedId(),index,v[1],v[2],v[3] or 2)
					end
                end
            end

			TriggerEvent("reloadTattos")
			TriggerEvent("reloadFace") 
			
			SetPedMaxHealth(PlayerPedId(), 300)
			NetworkSetFriendlyFireOption(true)
			SetCanAttackFriendly(PlayerPedId(),true,true)
        end
        r()
    end)
    return r:wait()
end

exports("forceUpdateWeapons", function() 
	vRPSV.updateWeapons(tvRP.getWeapons())
end)