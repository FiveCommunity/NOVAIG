----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONEXAO
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("hud",src)
vSERVER = Tunnel.getInterface("hud")

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local voice = 2
local talking = false
local radioDisplay = ""

local hours = 10
local minutes = 20

local flexDirection = "Norte"
local streetName = "Rua Boliva da Silva Mirto"

local cacheStreet = {}
local inZone = false
showHud = true
inFarm = false

local weapons = {
    [GetHashKey('WEAPON_PISTOL_MK2')] = 'Five-Seven',
    [GetHashKey('WEAPON_SNOWBALL')] = 'Bola de Neve',
    [GetHashKey('WEAPON_ASSAULTSMG')] = 'MTAR',
    [GetHashKey('WEAPON_MOLOTOV')] = 'MOLOTOV',
    [GetHashKey('WEAPON_SMG_MK2')] = 'Smg MK2',
    [GetHashKey('WEAPON_POOLCUE')] = 'Poolcue',
    [GetHashKey('WEAPON_GRENADE')] = 'WEAPON_GRENADE',
    [GetHashKey('WEAPON_MARKSMANPISTOL')] = 'WEAPON_MARKSMANPISTOL',
    [GetHashKey('WEAPON_BULLPUPSHOTGUN')] = 'WEAPON_BULLPUPSHOTGUN',
    [GetHashKey('GADGET_PARACHUTE')] = 'Paraquedas',
    [GetHashKey('WEAPON_BOTTLE')] = 'Bottle',
    [GetHashKey('WEAPON_COMBATMG')] = 'WEAPON_COMBATMG',
    [GetHashKey('WEAPON_MINISMG')] = 'WEAPON_MINISMG',
    [GetHashKey('WEAPON_SWEEPERSHOTGUN')] = 'WEAPON_SWEEPERSHOTGUN',
    [GetHashKey('WEAPON_ASSAULTRIFLE_MK2')] = 'AK MK2',
    [GetHashKey('WEAPON_CARBINERIFLE_MK2')] = 'M4MK2',
    [GetHashKey('WEAPON_BAT')] = 'Bastão de Beisebol',
    [GetHashKey('WEAPON_HEAVYSNIPER_MK2')] = 'WEAPON_HEAVYSNIPER_MK2',
    [GetHashKey('WEAPON_BALL')] = 'WEAPON_BALL',
    [GetHashKey('WEAPON_PUMPSHOTGUN_MK2')] = 'Pump Shotgun',
    [GetHashKey('WEAPON_FLASHLIGHT')] = 'Lanterna',
    [GetHashKey('WEAPON_COMBATPDW')] = 'Combat Pdw',
    [GetHashKey('WEAPON_COMBATPISTOL')] = 'Glock',
    [GetHashKey('WEAPON_SNSPISTOL_MK2')] = 'Fajuta',
    [GetHashKey('WEAPON_FIREWORK')] = 'Fogos',
    [GetHashKey('WEAPON_COMPACTRIFLE')] = 'WEAPON_COMPACTRIFLE',
    [GetHashKey('WEAPON_MACHINEPISTOL')] = 'Tec-9',
    [GetHashKey('WEAPON_MARKSMANRIFLE')] = 'WEAPON_MARKSMANRIFLE',
    [GetHashKey('WEAPON_AUTOSHOTGUN')] = 'WEAPON_AUTOSHOTGUN',
    [GetHashKey('WEAPON_PROXMINE')] = 'WEAPON_PROXMINE',
    [GetHashKey('WEAPON_REVOLVER')] = 'Revolver',
    [GetHashKey('WEAPON_COMBATSHOTGUN')] = 'WEAPON_COMBATSHOTGUN',
    [GetHashKey('WEAPON_MILITARYRIFLE')] = 'MilitaryRifle',
    [GetHashKey('WEAPON_RAYCARBINE')] = 'WEAPON_RAYCARBINE',
    [GetHashKey('WEAPON_BULLPUPRIFLE')] = 'WEAPON_BULLPUPRIFLE',
    [GetHashKey('WEAPON_GUSENBERG')] = 'Submetralhadora Thompson',
    [GetHashKey('WEAPON_HEAVYSHOTGUN')] = 'WEAPON_HEAVYSHOTGUN',
    [GetHashKey('WEAPON_FLARE')] = 'Sinalizador',
    [GetHashKey('WEAPON_KNIFE')] = 'Faca',
    [GetHashKey('WEAPON_STONE_HATCHET')] = 'WEAPON_STONE_HATCHET',
    [GetHashKey('WEAPON_GRENADELAUNCHER_SMOKE')] = 'WEAPON_GRENADELAUNCHER_SMOKE',
    [GetHashKey('WEAPON_CERAMICPISTOL')] = 'WEAPON_CERAMICPISTOL',
    [GetHashKey('WEAPON_ASSAULTRIFLE')] = 'AK 47',
    [GetHashKey('WEAPON_PIPEBOMB')] = 'WEAPON_PIPEBOMB',
    [GetHashKey('WEAPON_MICROSMG')] = 'MICROSMG',
    [GetHashKey('WEAPON_DAGGER')] = 'Dagger',
    [GetHashKey('WEAPON_MUSKET')] = 'WEAPON_MUSKET',
    [GetHashKey('WEAPON_RAYMINIGUN')] = 'WEAPON_RAYMINIGUN',
    [GetHashKey('WEAPON_SPECIALCARBINE')] = 'G36',
    [GetHashKey('WEAPON_GADGETPISTOL')] = 'WEAPON_GADGETPISTOL',
    [GetHashKey('WEAPON_APPISTOL')] = 'Ap Pistol',
    [GetHashKey('WEAPON_ASSAULTSHOTGUN')] = 'WEAPON_ASSAULTSHOTGUN',
    [GetHashKey('WEAPON_HEAVYPISTOL')] = 'HeavyPistol',
    [GetHashKey('WEAPON_HOMINGLAUNCHER')] = 'WEAPON_HOMINGLAUNCHER',
    [GetHashKey('WEAPON_PIPEWRENCH')] = 'WEAPON_PIPEWRENCH',
    [GetHashKey('WEAPON_MARKSMANRIFLE_MK2')] = 'WEAPON_MARKSMANRIFLE_MK2',
    [GetHashKey('WEAPON_RAYPISTOL')] = 'RayPistol',
    [GetHashKey('WEAPON_FIREEXTINGUISHER')] = 'WEAPON_FIREEXTINGUISHER',
    [GetHashKey('WEAPON_MINIGUN')] = 'WEAPON_MINIGUN',
    [GetHashKey('WEAPON_PETROLCAN')] = 'Galão de gasolina',
    [GetHashKey('WEAPON_HATCHET')] = 'Machados',
    [GetHashKey('WEAPON_DBSHOTGUN')] = 'WEAPON_DBSHOTGUN',
    [GetHashKey('WEAPON_DOUBLEACTION')] = 'DOUBLEACTION',
    [GetHashKey('WEAPON_REVOLVER_MK2')] = 'Revolver',
    [GetHashKey('WEAPON_COMPACTLAUNCHER')] = 'WEAPON_COMPACTLAUNCHER',
    [GetHashKey('WEAPON_STUNGUN')] = 'Tazer',
    [GetHashKey('WEAPON_BULLPUPRIFLE_MK2')] = 'WEAPON_BULLPUPRIFLE_MK2',
    [GetHashKey('WEAPON_SWITCHBLADE')] = 'SwitchBlade',
    [GetHashKey('WEAPON_SNIPERRIFLE')] = 'WEAPON_SNIPERRIFLE',
    [GetHashKey('WEAPON_KNUCKLE')] = 'Knuckle',
    [GetHashKey('WEAPON_SPECIALCARBINE_MK2')] = 'G3 MK2',
    [GetHashKey('WEAPON_NIGHTSTICK')] = 'WEAPON_NIGHTSTICK',
    [GetHashKey('WEAPON_SAWNOFFSHOTGUN')] = 'Shotgun',
    [GetHashKey('WEAPON_CROWBAR')] = 'CrowBar',
    [GetHashKey('WEAPON_RPG')] = 'WEAPON_RPG',
    [GetHashKey('WEAPON_GRENADELAUNCHER')] = 'WEAPON_GRENADELAUNCHER',
    [GetHashKey('WEAPON_HEAVYSNIPER')] = 'SNIPER',
    [GetHashKey('WEAPON_RAILGUN')] = 'WEAPON_RAILGUN',
    [GetHashKey('WEAPON_PISTOL50')] = 'Desert Eagle',
    [GetHashKey('WEAPON_SMG')] = 'SMG',
    [GetHashKey('WEAPON_HAMMER')] = 'Hammer',
    [GetHashKey('WEAPON_PISTOL')] = 'Pistol',
    [GetHashKey('WEAPON_GOLFCLUB')] = 'GolfClub',
    [GetHashKey('WEAPON_SNSPISTOL')] = 'WEAPON_SNSPISTOL',
    [GetHashKey('WEAPON_CARBINERIFLE')] = 'M4',
    [GetHashKey('WEAPON_PUMPSHOTGUN')] = 'WEAPON_PUMPSHOTGUN',
    [GetHashKey('WEAPON_HAZARDCAN')] = 'WEAPON_HAZARDCAN',
    [GetHashKey('WEAPON_DIGISCANNER')] = 'WEAPON_DIGISCANNER',
    [GetHashKey('WEAPON_NAVYREVOLVER')] = 'WEAPON_NAVYREVOLVER',
    [GetHashKey('WEAPON_HEAVYRIFLE')] = 'Rifle Pesado',
    [GetHashKey('WEAPON_SMOKEGRENADE')] = 'WEAPON_SMOKEGRENADE',
    [GetHashKey('WEAPON_BZGAS')] = 'Gas',
    [GetHashKey('WEAPON_ADVANCEDRIFLE')] = 'WEAPON_ADVANCEDRIFLE',
    [GetHashKey('WEAPON_MACHETE')] = 'Machete',
    [GetHashKey('WEAPON_PISTOL_MK2')] = 'Five-Seven',
}
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local sBuffer = {}
local cinto_seguranca = false
local ExNoCarro = false



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROGRESS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Progress")
AddEventHandler("Progress",function(time, prefix)
    if time >= 500 then
        time = time / 1000
    end
	SendNUIMessage({
        action = 'Progress',
        data = {
            seconds = parseInt(time),
            text = prefix and prefix or "Carregando"
        }
    })
end)

RegisterNetEvent("progress")
AddEventHandler("progress",function(time, prefix)
    SendNUIMessage({
        action = 'Progress',
        data = {
            seconds = parseInt(time),
            text = prefix and prefix or "Carregando"
        }
    })
end)

exports('setZone', function(status)
    inZone = status
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREADHUD
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
        local inVehicle = IsPedInAnyVehicle(PlayerPedId())
		if showHud then
            updateDisplayHud(inVehicle)
		end

		Wait((inVehicle and 100 or 1000))
	end
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEDISPLAYHUD
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local inIsland = false

local islandZone = PolyZone:Create({
    vector2(-611.79052734375, 6500.4829101563),
    vector2(-2156.3820800781, 6041.4702148438),
    vector2(-2062.6142578125, 8893.5947265625),
    vector2(981.59326171875, 8066.7456054688)
}, {
    name="ilha",
    --minZ = 10.54435634613,
    --maxZ = 83.775909423828
})

islandZone:onPlayerInOut(function(naZona, _)
    inIsland = naZona
end)

local function getRegion()
    local ped = PlayerPedId()

    local cds = vec3(248.4,2855.13,43.52)
    local coords = GetEntityCoords(ped)

    if inIsland then
        return 'island'
    elseif coords.y <= cds.y then
        return 'south'
    else
        return 'north'
    end
end

function updateDisplayHud(inVehicle)
	local ped = PlayerPedId()
	local health = GetEntityHealth(ped)
	local maxHealth = GetEntityMaxHealth(ped)
	local armour = GetPedArmour(ped)

    -- Normaliza a vida para ficar entre 0 e 100
    local calcHealth = ((health - 100) / (maxHealth - 100)) * 100

    -- Caso a vida seja menor ou igual a 0, garantimos que ela seja exibida como 0
    if calcHealth < 0 then
        calcHealth = 0
    elseif calcHealth > 100 then
        calcHealth = 100
    end

	local assaultTime = false
    local region = getRegion()
    if region == 'island' then
        if tonumber(GlobalState.time[1]) >= 10 and tonumber(GlobalState.time[1]) < 18 then
            assaultTime = true
        else
            assaultTime = false
        end
    elseif region == 'south' then
        if tonumber(GlobalState.time[1]) >= 0 and tonumber(GlobalState.time[1]) < 3 then
            assaultTime = true
        else
            assaultTime = false
        end
    else
        if tonumber(GlobalState.time[1]) >= 3 and tonumber(GlobalState.time[1]) < 10 then
            assaultTime = true
        else
            assaultTime = false
        end
    end

    local current_weapon = GetSelectedPedWeapon(ped, true)
    local _,current_ammo = GetAmmoInClip(ped, current_weapon) 

    local weapon = {
        data = weapons[current_weapon] ~= nil and current_weapon ~= GetHashKey('WEAPON_UNARMED'),
        image = weapons[current_weapon],
        current = current_weapon ~= GetHashKey('WEAPON_UNARMED') and current_ammo or 0,
        max = current_weapon ~= GetHashKey('WEAPON_UNARMED') and (GetAmmoInPedWeapon(ped, current_weapon) - current_ammo) or 0,
    }

	if inVehicle then
		local vehicle = GetVehiclePedIsUsing(ped)
		local doorstatus = (GetVehicleDoorLockStatus(vehicle) == 2)
		local _,lights,highlights = GetVehicleLightsState(vehicle)
		local engine = GetVehicleEngineHealth(vehicle)/10
		local fuel = GetVehicleFuelLevel(vehicle)
		local speed = GetEntitySpeed(vehicle) * 3.6
		local rpm = GetVehicleCurrentRpm(vehicle) * 100
        local gear = GetVehicleCurrentGear(vehicle)
        local nitro = 0--[[ vSERVER.getVehicleQuantityNitro() ]]

		if lights == 1 and highlights == 0 then
			lights = 1
		end

		if highlights == 1 then
			lights = 2
		end

        -- @TODO Send user id in update action 
        SendNUIMessage({
            action = 'update',
            data = {
                id = LocalPlayer.state.userId,
                health = calcHealth,
                armour = armour,
                street = streetName,
                volume = voice,
                clock = hours..":"..minutes,
                frequency = radioDisplay,
                talking = talking,
                assaultTime = assaultTime,
                weapon = weapon,
                vehicle = {
                    data = true,
                    fuel = fuel,
                    engine = engine,
                    speed = math.floor(speed),
                    rpm = rpm,
                    seatbelt = cinto_seguranca,
                    lock = doorstatus,
                    march = gear,
                    light = lights,
                    nitro = nitro,
                },
                safezone = inZone,
                -- energy = exports.inventory:getEnergetico(),
            }
        })
	else
        SendNUIMessage({
            action = 'update',
            data = {
                id = LocalPlayer.state.userId,
                health = calcHealth,
                armour = armour,
                volume = voice,
                clock = hours..":"..minutes,
                frequency = radioDisplay,
                talking = talking,
                assaultTime = assaultTime,
                weapon = weapon,
                safezone = inZone,
                vehicle = {
                    data = false
                },
                -- energy = exports.inventory:getEnergetico(),
            }
        })
	end
end

local lastTimer = GetGameTimer()
CreateThread(function()
	while true do

		if showHud then
            local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local heading = GetEntityHeading(ped)
			

			if (GetGameTimer() - lastTimer) > 0 then
				local streetHash = GetStreetNameAtCoord(coords.x,coords.y,coords.z)
				if not cacheStreet[streetHash] then
					cacheStreet[streetHash] = GetStreetNameFromHashKey(streetHash)
				end
				streetName = cacheStreet[streetHash]

			 	lastTimer = (GetGameTimer() + 10000)
			end

			-- if heading >= 315 or heading < 45 then
			-- 	flexDirection = "Norte"
			-- elseif heading >= 45 and heading < 135 then
			-- 	flexDirection = "Oeste"
			-- elseif heading >= 135 and heading < 225 then
			-- 	flexDirection = "Sul"
			-- elseif heading >= 225 and heading < 315 then
			-- 	flexDirection = "Leste"
			-- end

			hours = GetClockHours()
			minutes = GetClockMinutes()
		
			if hours <= 9 then
				hours = "0"..hours
			end
		
			if minutes <= 9 then
				minutes = "0"..minutes
			end
		end

		Wait( 1000 )
	end
end)


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local types = {
	['vip'] = {
        title = 'vip',
        index = 'vip',
	},
	['sucesso'] = {
        title = 'SUCESSO',
        index = 'success',
	},
	['negado'] = {
        title = 'NEGADO',
        index = 'refused',
	},
	['importante'] = {
        title = 'IMPORTANTE',
        index = 'important',
	},
	['aviso'] = {
        title = 'AVISO',
        index = 'important'
	},
	['admin'] = {
		title = 'ADMINISTRAÇÃO',
		index = 'admin'
	},
    ['avisobombeiro'] = {
		title = 'BOMBEIRO',
		index = 'avisobombeiro'
	},
}

local notificationsEnabled = true
local cupomdisable = false

RegisterCommand('disable', function(source, args, rawCommand)
    if vSERVER.checkhud() then
        cupomdisable = not cupomdisable
        notificationsEnabled = not notificationsEnabled
        if cupomdisable then
            SendNUIMessage({ action = "showCupom", data = false })
        else
            SendNUIMessage({ action = "showCupom", data = true })
        end

        TriggerEvent("nova_hud:toggleRequests",source)
    end
end)

local cupomHide = true
RegisterCommand('ocultar', function()
    cupomHide = not cupomHide
    SendNUIMessage({ action = "showCupom", data = cupomHide })
end)

RegisterNetEvent("nova_hud:changeCupom")
AddEventHandler("nova_hud:changeCupom",function(status)
    cupomdisable = status
    SendNUIMessage({ action = "showCupom", data = cupomdisable })
end)


RegisterCommand('disablenotify', function(source, args, rawCommand)
    notificationsEnabled = not notificationsEnabled

    if notificationsEnabled then
        print("Notificações ativadas")
    else
        print("Notificações desativadas")
    end
end)

local cupomStatus = true
RegisterNetEvent("Lotus:SwitchCupom",function()
    cupomStatus = not cupomStatus
    SendNUIMessage({action = "showCupom", data = cupomStatus})
end)

exports('getChatAvaliable', function()
    return notificationsEnabled
end)

RegisterNetEvent("Notify")
AddEventHandler("Notify",function(type, message, time, title)
    if not notificationsEnabled then return end

	if not time or time == "" or time > 1000 then
		time = 5 
	end

	if (not types[type]) then return print(type .. ' does not exist') end

	if (not title) then
		title = types[type].title
	end
    
    SendNUIMessage({
        action = 'Notify',
        data = {
            type = types[type].index,
            title = title,
            message = message,
            time = time * 1000
        }
    })
end)

function isLeader(user_id) 
	local getGroup = vRP.getUserGroupByType(user_id, 'org')

	return string.find(getGroup, "Lider") ~= nil
end

RegisterNetEvent('flaviin:setPlayerTalking')
AddEventHandler('flaviin:setPlayerTalking', function(enable, name, user_id)
  if not enable then
    SendNUIMessage({
        action = 'talking',
        data = {
            type = 'remove',
            name = name,
            uid = user_id,
        }
      })
    return
  end

  SendNUIMessage({
    action = 'talking',
    data = {
        type = 'append',
        name = name,
        uid = user_id,
    }
  })
end)

local x = nil
local y = nil

local lastClickUser = nil
RegisterNUICallback('newLocation', function(data, cb)
    if lastClickUser and lastClickUser + 100 < GetGameTimer() then return cb(false) end
    lastClickUser = GetGameTimer()

  x = data.x
  y = data.y
  cb(true)
end)

RegisterNUICallback('messageSent', function(data, cb)
  if not notificationsEnabled then return end
  if not data.message or data.message == '' or data.message == 'null' then return end
  SetNuiFocus(false, false)
  SendNUIMessage({ action = 'notify:close' })

  vSERVER._messageSent(data.message)
end)

src.open = function()
  if not notificationsEnabled then return end
  SetNuiFocus(true, true)
  SendNUIMessage({ action = 'notify:open' })
end

local response = nil
RegisterNUICallback('returnResponse', function(data, cb)
  response = data
end)

RegisterCommand('+acceptrequest', function(data, cb)
  if response == nil then
    SendNUIMessage({ action = 'remove' })
    response = true
  end
end)

RegisterKeyMapping("+acceptrequest", "Aceitar chamado", "keyboard", "y")
src.request = function(message, xLocation, yLocation)
  if not notificationsEnabled then return end

  SendNUIMessage({
    action = 'notify:recruitment',
    message = message,
    x = xLocation,
    y = yLocation,
    time = 60000
  })
  
  while not response do
    Wait(50)
  end
  local result = response
  response = nil

  SetNewWaypoint(x, y)

  x = nil
  y = nil
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HUD
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hud",function(source,args)
	if not vSERVER.checkhud() then return end

    showHud = not showHud
    if showHud == true then
        SendNUIMessage({ action = 'open' })
    else 
        SendNUIMessage({ action = 'close' })
    end
end, false)

RegisterNetEvent("flaviin:toggleHud", function(enabled)
	showHud = enabled
    
    if showHud then
        SendNUIMessage({ action = 'open' })
    else 
        SendNUIMessage({ action = 'close' })
    end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOICEMODE
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("pma-voice:setTalkingMode")
AddEventHandler("pma-voice:setTalkingMode",function(status)
	voice = status
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOICETALKING
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vrp_hud:VoiceTalking",function(status)
	talking = status
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HUD:RADIODISPLAY
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("lotus-hud:setRadioFrequency")
AddEventHandler("lotus-hud:setRadioFrequency",function(number)
	if parseInt(number) <= 0 then
		radioDisplay = ""
	else
		radioDisplay = parseInt(number)
	end
end)

AddEventHandler('onClientResourceStart', function (resourceName)
	if(GetCurrentResourceName() ~= resourceName) then
		return
	end

	showHud = true
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CINTO DE SEGURANCA
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local validModels = {
    [GetHashKey("WRF850POL")] = true,
    [GetHashKey("WRTIGER120FED")] = true,
    [GetHashKey("WRCB500FED")] = true,
    [GetHashKey("WRER34NFED")] = true,
    [GetHashKey("WRR1200PM")] = true,
    [GetHashKey("WRR1200PM")] = true,
    [GetHashKey("WRR1200PM")] = true,
    [GetHashKey("WRL200PRF")] = true,
    [GetHashKey("WRTIGER1200MCT")] = true,
    [GetHashKey("WRR1200EB")] = true,
} 
IsCar = function(veh)
    local model = GetEntityModel(veh)
    if validModels[model] then
        return true
    end
	local vc = GetVehicleClass(veh)
	return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end

IsBikeOrMotorcycle = function(veh)
	local vc = GetVehicleClass(veh)
	return vc == 8 or vc == 13
end

Citizen.CreateThread(function()
	while true do
		local timeDistance = 1000

		local ped = PlayerPedId()
		local car = GetVehiclePedIsIn(ped)
		if car ~= 0 and (ExNoCarro or IsCar(car)) then
			timeDistance = 0

			ExNoCarro = true
			if cinto_seguranca then
				DisableControlAction(0,75)
			end

			
			sBuffer[2] = sBuffer[1]
			sBuffer[1] = GetEntitySpeed(car)

			if sBuffer[2] ~= nil and not cinto_seguranca and GetEntitySpeedVector(car,true).y > 1.0 and sBuffer[1] > 10.25 and (sBuffer[2] - sBuffer[1]) > (sBuffer[1] * 0.255) then
				TaskLeaveVehicle(ped,GetVehiclePedIsIn(ped),4160)
			end

			if IsControlJustReleased(1,47) then
				if cinto_seguranca then
					TriggerEvent("vrp_sound:source","unbelt",0.5)
					cinto_seguranca = false
				else
					TriggerEvent("vrp_sound:source","belt",0.5)
                    SetPedCanBeKnockedOffVehicle(ped, false)
					cinto_seguranca = true
				end
			end
		elseif ExNoCarro then
			ExNoCarro = false
			cinto_seguranca = false
			sBuffer[1],sBuffer[2] = 0.0,0.0
		end
		Citizen.Wait(timeDistance)
	end
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


exports("setMinimapActive", function(status)
	inFarm = status
end)

exports('setNovat', function(toggle)
	SendNUIMessage({ action = 'isNovat', isNovat = toggle })
end)










































--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SYSTEM NITRO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local function f(n) return (n + 0.00001) end
function returnCoordBone(veh, bone, px, py, pz)
    local b = GetEntityBoneIndexByName(veh, bone)
    local bx, by, bz = table.unpack(GetWorldPositionOfEntityBone(veh, b))
    local ox2, oy2, oz2 = table.unpack(GetOffsetFromEntityGivenWorldCoords(veh, bx, by, bz))
    local vector = GetOffsetFromEntityInWorldCoords(veh, ox2 + f(px), oy2 + f(py), oz2 + f(pz))
    local x, y, z = table.unpack(vector)
    return x, y, z, vector
end

instalarKitNitro = function()
    if vSERVER.checkVehicleNitro() then
        TriggerEvent("Notify", "aviso", dict[0], 5)
        return
    end
    if vSERVER.checkVehicleBlackList() then
        TriggerEvent("Notify", "aviso", dict[10], 5)
        return
    end
    if not vSERVER.checkPermission() then
        TriggerEvent("Notify", "aviso", dict[1], 5)
        return
    end
    if not vSERVER.haveKitNitro() then
        TriggerEvent("Notify", "aviso", dict[11], 5)
        return
    end
    instalando = false
    instalado = false
    cancelado = false
    pEngine = 1
    Citizen.CreateThread(function()
        local threadCreate = false
        while not instalado and not cancelado do
            local w = 1000
            local ped = PlayerPedId()
            local pCDS = GetEntityCoords(ped)
            local veh = vRP.getNearestVehicle(5)
            local px, py, pz = table.unpack(pCDS)
            if not threadCreate then
                threadCreate = true
                Citizen.CreateThread(function()
                    while not instalado and not cancelado do
                        Citizen.Wait(1000)
                        pCDS = GetEntityCoords(ped)
                        vehicleInstall = vRP.getNearestVehicle(5)
                        if vehicleInstall ~= veh then
                            TriggerEvent("Notify", "aviso", dict[2], 5)
                            cancelado = true
                            threadCreate = false
                            TriggerServerEvent("tryCapo", VehToNet(veh), false)
                            ClearPedTasks(ped)
                            FreezeEntityPosition(ped, false)
                            FreezeEntityPosition(veh, false)
                            return
                        end
                    end
                end)
                for i, v in pairs(veiculosPositionEngine) do
                    local nveh = vSERVER.getInfosVeh(VehToNet(veh))
    
                    if nveh then
                        nveh = GetHashKey(nveh)
                    end
                    if GetHashKey(i) == nveh then
                        pEngine = v
                    end
                end
            end
            local x, y, z, vector = returnCoordBone(veh, "engine", 0, f(pEngine), 0)
            vector = vector3(x, y, pz)
            local dist = #(pCDS - vector)
            if dist < 11 then
                w = 5
                if not instalando then
                    DrawMarker(1, x, y, pz - 1.5, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.7, 0, 255, 0, 155, 0, 0, 0, 1)
                    DrawText3D(x, y, pz, "Pressione [~r~E~w~] para instalar o nitro.")
                end
                if dist < 2 and IsControlJustPressed(0, 38) and not instalando then
                    instalando = true
                    local h = GetEntityHeading(veh)
                    if pEngine < 0 then
                        h = h * -1
                    end
                    TriggerServerEvent("sync:alignMechanicAndCarHeading", h, 170)
                    Citizen.Wait(1000)
                    TriggerServerEvent("tryCapo", VehToNet(veh), true)
                    Citizen.Wait(500)
                    vSERVER.anim("mini@repair", "fixing_a_player", tempoInstalacaoKitNitro * 1000, false)
                    PlaySoundFromEntity(-1, "Bar_Unlock_And_Raise", veh, "DLC_IND_ROLLERCOASTER_SOUNDS", 0, 0)
                    FreezeEntityPosition(ped, true)
                    FreezeEntityPosition(veh, true)
                    TriggerEvent("progress", tempoInstalacaoKitNitro, dict[8])
                    SetTimeout(tempoInstalacaoKitNitro * 1000, function()
                        PlaySoundFrontend(-1, "Lowrider_Upgrade", "Lowrider_Super_Mod_Garage_Sounds", 1)
                        TriggerEvent("Notify", "aviso", dict[3], 5)
                        turbo = 100
                        instalado = true
                        instalando = false
                        vSERVER.setNitro(veh)
                        threadCreate = false
                        vehicleCheck = false
                        
                        TriggerServerEvent("tryCapo", VehToNet(veh), false)
                        
                        Citizen.Wait(1000)
                        ClearPedTasks(ped)
                        FreezeEntityPosition(ped, false)
                        FreezeEntityPosition(veh, false)
                    end)
                end
            end
            Citizen.Wait(w)
        end
    end)
end

recarregarNitro = function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    if not vSERVER.checkVehicleNitro() then
        TriggerEvent("Notify", "aviso", dict[4], 5)
        return
    end
    if not GetPedInVehicleSeat(veh, 1) or not GetPedInVehicleSeat(veh, 1) then
        TriggerEvent("Notify", "aviso", dict[5], 5)
        return
    end
    
    if math.ceil(GetEntitySpeed(veh) * 3.605936) >= 1 then
        TriggerEvent("Notify", "aviso", dict[6], 5)
        return
    end

    instalando2 = false
    instalado2 = false
    cancelado2 = false
    pEngine = 1
    Citizen.CreateThread(function()
        local threadCreate2 = false
        if not DoesEntityExist(veh) then return end
        while not instalado2 and not cancelado2 do
            local w = 1000
            local ped = PlayerPedId()
            local pCDS = GetEntityCoords(ped)
            local veh = vRP.getNearestVehicle(5)
            local px, py, pz = table.unpack(pCDS)
            if not threadCreate2 then
                threadCreate2 = true
                Citizen.CreateThread(function()
                    while not instalado2 and not cancelado2 do
                        Citizen.Wait(1000)
                        pCDS = GetEntityCoords(ped)
                        vehicleInstall2 = vRP.getNearestVehicle(5)
                        if vehicleInstall2~= veh then
                            TriggerEvent("Notify", "aviso", dict[2], 5)
                            cancelado2 = true
                            threadCreate2 = false
                            TriggerServerEvent("tryCapo", VehToNet(veh), false)
                            ClearPedTasks(ped)
                            FreezeEntityPosition(ped, false)
                            FreezeEntityPosition(veh, false)
                            return
                        end
                    end
                end)
                for i, v in pairs(veiculosPositionEngine) do
                    local nveh = vSERVER.getInfosVeh(VehToNet(veh))
    
                    if nveh then
                        nveh = GetHashKey(nveh)
                    end
    
                    if GetHashKey(i) == nveh then
                        pEngine = v
                    end
                end
            end
            local x, y, z, vector = returnCoordBone(veh, "engine", 0, f(pEngine), 0)
            vector = vector3(x, y, pz)
            local dist = #(pCDS - vector)
            if dist < 11 then
                w = 5
                if not instalando2 then
                    DrawMarker(1, x, y, pz - 1.5, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.7, 0, 255, 0, 155, 0, 0, 0, 1)
                    DrawText3D(x, y, pz, "Pressione [~r~E~w~] para recarregar o nitro!")
                end
                if dist < 2 and IsControlJustPressed(0, 38) and not instalando2 then
                    instalando2 = true
                    local h = GetEntityHeading(veh)
                    if pEngine < 0 then
                        h = h * -1
                    end
                    TriggerServerEvent("sync:alignMechanicAndCarHeading", h, 170)
                    Citizen.Wait(1000)
                    TriggerServerEvent("tryCapo", VehToNet(veh), true)
                    Citizen.Wait(500)
                    vSERVER.anim("mini@repair", "fixing_a_player", tempoParaTrocarGarrafaNitro * 1000, false)
                    PlaySoundFromEntity(-1, "Bar_Unlock_And_Raise", veh, "DLC_IND_ROLLERCOASTER_SOUNDS", 0, 0)
                    FreezeEntityPosition(ped, true)
                    FreezeEntityPosition(veh, true)
                    TriggerEvent("progress", tempoParaTrocarGarrafaNitro, dict[7])
                    SetTimeout(tempoParaTrocarGarrafaNitro * 1000, function()
                        PlaySoundFrontend(-1, "Lowrider_Upgrade", "Lowrider_Super_Mod_Garage_Sounds", 1)
                        TriggerEvent("Notify", "aviso", dict[9], 5)
                        instalado2 = true
                        instalando2 = false
                        vSERVER.setQtdNitro2(100, veh)
                        threadCreate2 = false
                        vehicleCheck2 = false
            
                        
                        TriggerServerEvent("tryCapo", VehToNet(veh), false)
                        
                        Citizen.Wait(1000)
                        ClearPedTasks(ped)
                        FreezeEntityPosition(ped, false)
                        FreezeEntityPosition(veh, false)
                    end)
                end
            end
            Citizen.Wait(w)
        end
    end)
end

RegisterNetEvent('install_nitro', function()
    if not instalando then
        instalarKitNitro()
    end
end)

RegisterNetEvent('recharge_nitro', function()
    recarregarNitro()
end)


local nitrooff = false
AddEventHandler("gameEventTriggered",function(eventName, args)
    if eventName == "CEventNetworkPlayerEnteredVehicle" then
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsUsing(ped)
        
        if veh and GetPedInVehicleSeat(veh, -1) == ped then
            if vSERVER.checkVehicleNitro() then
                nitrooff = true
            end
        end
    end
end)

src.createNitroValidation = function()
    Citizen.CreateThread(function()
        local turbo = 0
        local vehicleCheck = false
        local open = false

        while true do
            local wait = 1000
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsUsing(ped)
            local cooldown = false
            local cooldownTime = 30000
    
            if veh and GetPedInVehicleSeat(veh, -1) == ped and nitrooff then
                if not DoesEntityExist(veh) then return end
                   
                wait = 3
                local turboAtivado = false

                if not open and GetPedInVehicleSeat(veh, -1) == ped then
                    qnitro = vSERVER.getVehicleQuantityNitro()
                    SendNUIMessage({ action = "nitro:show", percentage = qnitro })
                    open = true
                end
                
                while IsControlPressed(0, 244) and not cooldown do
                    if not turboAtivado then
                        turboAtivado = true
                        turbo = vSERVER.getVehicleQuantityNitro()

                        Citizen.CreateThread(function()
                            while turboAtivado do
                                if turbo > 0 then
                                    turbo = turbo - 1
                                    local currentEngineHealth = GetVehicleEngineHealth(veh)
                                    if currentEngineHealth > 0 then
                                        local newEngineHealth = currentEngineHealth - 4 * (1000 / 1000)
                                        newEngineHealth = math.max(newEngineHealth, 0)
                                        SetVehicleEngineHealth(veh, newEngineHealth)
                                    end
                                    SendNUIMessage({ action = "nitro:show", percentage = turbo })
                                end
                                Citizen.Wait(tempoDuracaoTotalNitro * 10)
                            end
                        end)
                        Citizen.CreateThread(function()
                            while turboAtivado do
                                if turbo > 0 then
                                    MudarTela(true)
                                    SetVehicleLightTrailEnabled(veh, true)
                                    FogoNoScape(veh, f(TamanhoDoFogoNoEscape))
                                    SetVehicleCheatPowerIncrease(veh, f(AumentoDeTorqueAoUsarNitro))
                                    ModifyVehicleTopSpeed(veh, f(AumentoDeVelocidadeFinalAoUsarNitro))
                                else
                                    MudarTela(false)
                                    SetVehicleLightTrailEnabled(veh, false)
                                    SetVehicleCheatPowerIncrease(veh, 0.0)
                                    ModifyVehicleTopSpeed(veh, 0.0)
                                end
                                Citizen.Wait(100)
                            end
                        end)
                    end
                    Citizen.Wait(100)
                end
                    

                if turboAtivado then
                    MudarTela(false)
                    SetVehicleLightTrailEnabled(veh, false)
                    turboAtivado = false
                    SetVehicleCheatPowerIncrease(veh, 0.0)
                    ModifyVehicleTopSpeed(veh, 0.0)
                    Citizen.Wait(tempoDuracaoTotalNitro * 10)
                    vSERVER.setQtdNitro(turbo, veh)
                    cooldown = true
                    TriggerEvent("Notify","negado","O seu nitro esquentou demais, aguarde um 30 segundos até que o mesmo se resfrie por completo!", 5)
                    local cooldownEndTime = GetGameTimer() + cooldownTime
                    while GetGameTimer() < cooldownEndTime do
                        Citizen.Wait(100)
                    end
                    TriggerEvent("Notify","sucesso","Nitro pronto para utilização!", 5)
                    cooldown = false
                    open = false
                end
            end
            Citizen.Wait(wait)
        end
    end)
end


function FogoNoScape(CarroID, Longitude)
    local escapes = {
        "exhaust", "exhaust_2", "exhaust_3", "exhaust_4", "exhaust_5",
        "exhaust_6", "exhaust_7", "exhaust_8", "exhaust_9", "exhaust_10",
        "exhaust_11", "exhaust_12", "exhaust_13", "exhaust_14", "exhaust_15",
        "exhaust_16"
    }
    for k, v in ipairs(escapes) do
        BoneEscape = v
        local escapeID = GetEntityBoneIndexByName(CarroID, BoneEscape)
        if escapeID > -1 then
            local Escape = GetWorldPositionOfEntityBone(CarroID, escapeID)
            local localEscape = GetOffsetFromEntityGivenWorldCoords(CarroID, Escape)
            UseParticleFxAssetNextCall('core')
            StartParticleFxNonLoopedOnEntity('veh_backfire', CarroID, localEscape, 0.0, 0.0, 0.0, Longitude, false, false, false)
        end
    end
end

function MudarTela(status)
    if status == true then
        StopScreenEffect('RaceTurbo')
        StartScreenEffect('RaceTurbo', 0, false)
        SetTimecycleModifier('rply_motionblur')
    else
        SetTransitionTimecycleModifier('default', 0.35)
    end
end

RegisterNetEvent("apz:alignMechanicAndCarHeading")
AddEventHandler("apz:alignMechanicAndCarHeading", function(h, n)
    local ped = PlayerPedId()
    SetPedDesiredHeading(ped, tonumber(h - n))
end)

RegisterNetEvent("syncCapo")
AddEventHandler("syncCapo", function(index, open)
    if NetworkDoesNetworkIdExist(index) then
        local v = NetToVeh(index)
        if DoesEntityExist(v) then
            if IsEntityAVehicle(v) then
                if open then
                    SetVehicleDoorOpen(v, 4, 0, 0)
                else
                    SetVehicleDoorShut(v, 4, 0)
                end
            end
        end
    end
end)

function CreateVehicleLightTrail(vehicle, bone, scale)
    UseParticleFxAssetNextCall('core')
    local ptfx = StartParticleFxLoopedOnEntityBone('veh_light_red_trail', vehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, bone, scale, false, false, false)
    SetParticleFxLoopedEvolution(ptfx, "speed", 1.0, false)
    return ptfx
end

function StopVehicleLightTrail(ptfx, duration)
    Citizen.CreateThread(function()
        local startTime = GetGameTimer()
        local endTime = GetGameTimer() + duration
        while GetGameTimer() < endTime do
            Citizen.Wait(0)
            local now = GetGameTimer()
            local scale = (endTime - now) / duration
            SetParticleFxLoopedScale(ptfx, scale)
            SetParticleFxLoopedAlpha(ptfx, scale)
        end
        StopParticleFxLooped(ptfx)
    end)
end

local vehicles = {}
local particles = {}
function IsVehicleLightTrailEnabled(vehicle) return vehicles[vehicle] == true end
function SetVehicleLightTrailEnabled(vehicle, enabled)
    if not animacaoLanternaVeiculoAoUsarNitro then return end
    if IsVehicleLightTrailEnabled(vehicle) == enabled then return end
    if enabled then
        local ptfxs = {}
        local leftTrail = CreateVehicleLightTrail(vehicle, GetEntityBoneIndexByName( vehicle, "taillight_l"), 1.0)
        local rightTrail = CreateVehicleLightTrail(vehicle, GetEntityBoneIndexByName( vehicle, "taillight_r"), 1.0)
        table.insert(ptfxs, leftTrail)
        table.insert(ptfxs, rightTrail)
        vehicles[vehicle] = true
        particles[vehicle] = ptfxs
    else
        if particles[vehicle] and #particles[vehicle] > 0 then
            for _, particleId in ipairs(particles[vehicle]) do
                StopVehicleLightTrail(particleId, 100)
            end
        end
        vehicles[vehicle] = nil
        particles[vehicle] = nil
    end
end

RegisterNetEvent('nitro:__update')
AddEventHandler('nitro:__update', function(nitro, veh)
    if nitro then FogoNoScape(NetToVeh(veh), f(TamanhoDoFogoNoEscape)) end
end)

RegisterNetEvent('nitro:__update_screen')
AddEventHandler('nitro:__update_screen', function(bool, veh)
    veh = NetToVeh(veh)
    ped = PlayerPedId()
    if veh == GetVehiclePedIsUsing(ped) then
        MudarTela(bool)
        SetVehicleLightTrailEnabled(veh, bool)
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.003 + factor, 0.03, 41, 11, 41, 68)
end



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA CLIMATICO
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local minutes = 1
local hours = 10
local ativado = false
local actualWeather = "CLEAR"
local weathers = {
    "EXTRASUNNY",
    "CLEAR",
    "NEUTRAL",
    "SMOG",
    "FOGGY",
    "OVERCAST",
    "CLOUDS",
    "CLEARING",
    "RAIN",
    "THUNDER",
    "SNOW",
    "BLIZZARD",
    "SNOWLIGHT",
    "XMAS",
    "HALLOWEEN"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNC : COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("noite",function(source,args)
    minutes = parseInt(00)
    hours = parseInt(00)
    ativado = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNC : COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dia",function(source,args)
    minutes = parseInt(00)
    hours = parseInt(12)
    ativado = true
end)

RegisterCommand("desativartime",function(source,args)
    ativado = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNC : COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hora",function(source,args)
    if args[1] and args[2] then
        hours = parseInt(args[1])
        minutes = parseInt(args[2])
        ativado = true
    else
        TriggerEvent('Notify', 'negado', 'Utilize: /hora horas minutos')
    end
end)
--------------------------------------------------------------------------------------------------------------------------------
-- SYNC : CLIMA
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('clima', function(source, args)
    if args[1] then
        local weather = parseInt(args[1])
        if weather > 0 then
            if weathers[weather] then
                actualWeather = weathers[weather]
                ativado = true

                TriggerEvent('Notify', 'sucesso', 'Você mudou o clima para <b>'..actualWeather..'</b>.')
            end
        else
            TriggerEvent('Notify', 'negado', 'Você deve especificar um número de <b>1 a ' .. #weathers .. '</b>.')
        end
    else
        TriggerEvent('Notify', 'negado', 'Você deve especificar um número de <b>1 a ' .. #weathers .. '</b>.')
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNC : THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
local hora = 12
local minuto = 0
Citizen.CreateThread(function()
    while true do
        if ativado then
            SetWeatherTypeNow(GlobalState.ServerRestart and "THUNDER"  or actualWeather)
            SetWeatherTypePersist(GlobalState.ServerRestart and "THUNDER" or actualWeather)
            SetWeatherTypeNowPersist(GlobalState.ServerRestart and "THUNDER" or actualWeather)
            NetworkOverrideClockTime(hours,minutes,00)
        else
            NetworkOverrideClockTime( (GlobalState.time[1] or hora), (GlobalState.time[2] or minuto), 0)
            SetWeatherTypeNowPersist(GlobalState.ServerRestart and "THUNDER" or "CLEAR")
        end
        Citizen.Wait(1000)
    end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MAKAPOINTS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("NotifyMakapoints")
AddEventHandler("NotifyMakapoints",function(points)
    SendNUIMessage({
        action = 'makapoints',
        data = {
          visible = true,
          points = points
        }
    })
    Citizen.Wait(5000)
    SendNUIMessage({
        action = 'makapoints',
        data = {
          visible = false
        }
    })
end)



----------------------------------------------------------------------------------------------------
--- MINIMAP
----------------------------------------------------------------------------------------------------
--[[ local Default = 1920 / 1080
local ResolutionX, ResolutionY = GetActiveScreenResolution()
local AspectRatio = ResolutionX / ResolutionY
local AspectDiff = Default - AspectRatio
CreateThread(function ()
  UpdatePosition()
  while true do
    local ActualX,ActualY = GetActiveScreenResolution()
        if ResolutionX ~= ActualX or ResolutionY ~= ActualY then
            UpdatePosition()
        end

        Wait(10000)
  end
end)

function UpdatePosition()
  local ActualX,ActualY = GetActiveScreenResolution()
  AspectRatio = ResolutionX / ResolutionY

  if AspectRatio > Default then
    AspectDiff = Default - AspectRatio
    Offset = AspectDiff / 3.6
  end

  SetMinimapComponentPosition("minimap","L","B",-0.0045 + Offset,-0.035,0.175,0.225)
  SetMinimapComponentPosition("minimap_mask","L","B",0.020 + Offset,0.105,0.110,0.150)
  SetMinimapComponentPosition("minimap_blur","L","B",-0.02 + Offset,-0.01,0.265,0.225)

  SetBigmapActive(false,false)
end ]]

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'config', data = { show = false } })
    cb(true)
end)

RegisterCommand('trocarhud', function()
    SendNUIMessage({ action = 'config', data = { show = true } })
    SetNuiFocus(true, true)
end)

RegisterNetEvent('cupom:visible', function(status)
    status = not status
    SendNUIMessage({ action = 'showCupom',  data = status })
end)

RegisterCommand('noton', function(source, args)
    SendNUIMessage({ action = 'canNotificate', status = true })
    TriggerEvent('Notify', 'aviso', 'Notificações ligadas')
end)
  
RegisterCommand('notoff', function(source, args)
    TriggerEvent('Notify', 'aviso', 'Notificações desligadas')
    SendNUIMessage({ action = 'canNotificate', status = false })
end)

RegisterNetEvent('HideRecruitment', function(status)
    SendNUIMessage({ action = 'HideRecruitment', data = status })
end)

local isRecruitmentDisplayed = false
local currentSenderCoords = nil

RegisterNetEvent('lotus:recrutamento', function(message, org)
    local coordsInMap = exports["nova_garage"]:foundGarageByPermission('perm.'..(org:lower()))
	if coordsInMap and next(coordsInMap) then
		if coordsInMap.coords then
			currentSenderCoords = vec3(coordsInMap.coords.x, coordsInMap.coords.y, coordsInMap.coords.z)
		end
	end
    isRecruitmentDisplayed = true

    SendNUIMessage({
        action = "Announcement",
        data = {
            title = "RECRUTAMENTO",
            type = "recruitment",
            message = message,
            time = 15000,
        },
    })

    Citizen.SetTimeout(15000, function()
        isRecruitmentDisplayed = false
        currentSenderCoords = nil
    end)    
end)

CreateThread(function()
    while true do
        local timeDistance = 1000
        if isRecruitmentDisplayed and currentSenderCoords then
            timeDistance = 0
            if IsControlJustPressed(1, 246) and currentSenderCoords and currentSenderCoords.x and currentSenderCoords.y then
                SetNewWaypoint(currentSenderCoords.x, currentSenderCoords.y)
                TriggerEvent('Notify', 'sucesso', 'Localização marcada no mapa!')
            end
        end
        Wait(timeDistance)
    end
end)