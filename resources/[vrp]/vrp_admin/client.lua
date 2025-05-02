local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","vrp_admin")

src = {}
Tunnel.bindInterface("vrp_admin",src)
vSERVER = Tunnel.getInterface("vrp_admin") 


function src.isInvincible()
	return GetPlayerInvincible(PlayerId())
end

CreateThread(function()
	if OnesyncEnableRemoteAttachmentSanitization then
		-- OnesyncEnableRemoteAttachmentSanitization(true)
	end
end)

-- local mModules = Proxy.getInterface("dm_module")
-- local mDomination = Proxy.getInterface("dominacao")

CreateThread(function() 
	local entityValidate = {}
    local _IsEntityVisible = IsEntityVisible
    local _DeleteEntity = DeleteEntity
    local _GetGamePool = GetGamePool
    local _Wait = Wait
    local _GetEntityModel = GetEntityModel
    local _GetEntityAttachedTo = GetEntityAttachedTo
    local _NetworkHasControlOfEntity = NetworkHasControlOfEntity
    local _NetworkGetEntityOwner = NetworkGetEntityOwner
	local _PlayerPedId = PlayerPedId
	local lastReport = 0
	local _NetworkGetEntityIsNetworked = NetworkGetEntityIsNetworked
	function GetAllPools()
		local pool = {}
        for k,v in ipairs(_GetGamePool("CObject")) do
			table.insert(pool, v)
		end
		for k,v in ipairs(_GetGamePool("CVehicle")) do
			table.insert(pool, v)
		end
		return pool
	end
    while true do
        local ped = _PlayerPedId()
		local myVehicle = GetVehiclePedIsIn(ped, false)
        for k,v in ipairs(GetAllPools("CObject")) do
            local attachedTo = _GetEntityAttachedTo(v)
            local owner = _NetworkGetEntityOwner(v)
            if (attachedTo == ped) and owner ~= -1 and owner ~= 128 then
				if not entityValidate[v] and GetGameTimer() - lastReport > 5000 then
					lastReport = GetGameTimer()
					TriggerServerEvent("likizao_module:reportAttachViolation", ObjToNet(v))
                    entityValidate[v] = true
				end
				local model = _GetEntityModel(v)
                DetachEntity(v, true, true)
                DetachEntity(ped, true, true)
				SetEntityCompletelyDisableCollision(v, true, false)
                print('^1[likizao]^7 Reporte para algum staff: ','Model: '..model, 'AttachedTo: '..attachedTo, 'ArcheType', GetEntityArchetypeName(v), 'Source do Cheater:', GetPlayerServerId(NetworkGetEntityOwner(v)), 'Name:', GetPlayerName(NetworkGetEntityOwner(v)))
            end
			if myVehicle > 0 and (attachedTo == myVehicle) and owner ~= -1 and owner ~= 128 then
				if not entityValidate[v] and GetGameTimer() - lastReport > 5000 then
					lastReport = GetGameTimer()
					TriggerServerEvent("likizao_module:reportAttachViolation_2", VehToNet(v))
                    entityValidate[v] = true
				end
				local model = _GetEntityModel(v)
                DetachEntity(v, true, true)
                print('^1[likizao]^7 Reporte para algum staff: ','Model: '..model, 'AttachedTo: '..attachedTo, 'ArcheType', GetEntityArchetypeName(v), 'Source do Cheater:', GetPlayerServerId(NetworkGetEntityOwner(v)), 'Name:', GetPlayerName(NetworkGetEntityOwner(v)))
			end
        end
        _Wait(0)
    end
end)
-- DYNAMIC MALAS...


local DeathViewer = {
	cache = {},
	DISTANCE_THREESHOLD = 30,
	enabled = false
}



function DeathViewer:Main()
	CreateThread(function() 
		while self.enabled do
			local sleep = 1000
			local coords = GetEntityCoords(PlayerPedId())
			for k, v in pairs(self.cache) do
				local targetPlayer = GetPlayerFromServerId(k)
				if targetPlayer ~= -1 then
					local targetPed = GetPlayerPed(targetPlayer)
					if GetEntityHealth(targetPed) <= 101 then
						local targetCoords = GetEntityCoords(targetPed)
						local distance = #(coords - targetCoords)
						if distance < self.DISTANCE_THREESHOLD then
							sleep = 1
							DrawTxt(targetCoords.x, targetCoords.y, targetCoords.z + 0.05, 'MORTO POR: ~r~'..v)
						end
					end
				end
			end
			Wait(sleep)
		end
	end)
end

RegisterNetEvent("DeathViewer:Toggle", function (data)
	DeathViewer.enabled = data
	if DeathViewer.enabled then
		DeathViewer:Main()
	end
end)
RegisterNetEvent("DeathViewer:Update", function (data)
	DeathViewer.cache = data
end)

function DrawTxt(x, y, z, text)
	local _, _x, _y = World3dToScreen2d(x, y, z)
    SetTextScale(0.37, 0.37)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
	DrawText(_x, _y)
end


local inTrunk = false

RegisterNetEvent("novak:client:insertUserInTrunkin")
AddEventHandler("novak:client:insertUserInTrunkin", function (vehicle)
	if not vehicle then return end

	vehicle = NetworkGetEntityFromNetworkId(vehicle)

	local player = PlayerPedId()

	if not inTrunk then
        if DoesEntityExist(vehicle) and not IsPedInAnyVehicle(player) and GetVehicleDoorLockStatus(vehicle) == 1  then
			local trunk = GetEntityBoneIndexByName(vehicle,"boot")

			if trunk ~= -1 then
				if GetVehicleDoorAngleRatio(vehicle,5) < 0.9 and GetVehicleDoorsLockedForPlayer(vehicle,PlayerId()) ~= 1 then
					SetCarBootOpen(vehicle)
					SetEntityVisible(player,false,false)
					Citizen.Wait(750)
					AttachEntityToEntity(player,vehicle,-1,0.0,-2.2,0.5,0.0,0.0,0.0,false,false,false,false,20,true)
					inTrunk = true
					Citizen.Wait(500)
					SetVehicleDoorShut(vehicle,5)
				end

				Citizen.CreateThread(function ()
					while inTrunk do
						if DoesEntityExist(vehicle) then			
							DisableControlAction(1,73,true)
							DisableControlAction(1,29,true)
							DisableControlAction(1,47,true)
							DisableControlAction(1,187,true)
							DisableControlAction(1,189,true)
							DisableControlAction(1,190,true)
							DisableControlAction(1,188,true)
							DisableControlAction(1,311,true)
							DisableControlAction(1,245,true)
							DisableControlAction(1,257,true)
							DisableControlAction(1,167,true)
							DisableControlAction(1,140,true)
							DisableControlAction(1,141,true)
							DisableControlAction(1,142,true)
							DisableControlAction(1,137,true)
							DisableControlAction(1,37,true)
							DisablePlayerFiring(player,true)
							if IsEntityVisible(player) then
								SetEntityVisible(player,false,false)
							end
						else
							inTrunk = false
							DetachEntity(player,false,false)
							SetEntityVisible(player,true,false)
							SetEntityCoords(player,GetOffsetFromEntityInWorldCoords(player,0.0,-1.5,-0.75))
						end
						Citizen.Wait(5)
					end
				end)
			end
		end
	end
end)

RegisterNetEvent("novak:client:removeUserInTrunkin")
AddEventHandler("novak:client:removeUserInTrunkin", function()
	if not inTrunk then return end

	local player = PlayerPedId()

	local vehicle = GetEntityAttachedTo(player)
	SetCarBootOpen(vehicle)
	Citizen.Wait(750)
	inTrunk = false
	DetachEntity(player,false,false)
	SetEntityVisible(player,true,false)
	SetEntityCoords(player,GetOffsetFromEntityInWorldCoords(player,0.0,-1.5,-0.75))
	Citizen.Wait(500)
	SetVehicleDoorShut(vehicle,5)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETA TODOS OS CARROS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("wld:delallveh")
AddEventHandler("wld:delallveh", function ()
    local totalvehc = 0
    local notdelvehc = 0

    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then SetVehicleHasBeenOwnedByPlayer(vehicle, false) SetEntityAsMissionEntity(vehicle, false, false) 
            DeleteVehicle(vehicle)
            if (DoesEntityExist(vehicle)) then 
                DeleteVehicle(vehicle)
            end
            if (DoesEntityExist(vehicle)) then notdelvehc = notdelvehc + 1 end
        end
        totalvehc = totalvehc + 1
    end
    local vehfrac = totalvehc
		TriggerEvent('chatMessage', 'ADMIN', {255, 0, 0}, "Foram deletados ^1"..vehfrac.."^0 veiculos do servidor.")
end)

local entityEnumerator = {
  __gc = function(enum)
    if enum.destructor and enum.handle then
      enum.destructor(enum.handle)
    end
    enum.destructor = nil
    enum.handle = nil
  end
}
CreateThread(function() 
	local _Wait = Wait
	local _MumbleGetTalkerProximity = MumbleGetTalkerProximity
	local _IsPedUsingScenario = IsPedUsingScenario
	local _PlayerPedId = PlayerPedId
	local prision = vec3(1664.76,2501.32,45.57)
	while true do
		if _MumbleGetTalkerProximity() > 50 then
			_Wait(3000)
			if _MumbleGetTalkerProximity() > 50 then
                _TriggerServerEvent('dbg_sv2', _MumbleGetTalkerProximity())
				break
			end
		end
		SetPedConfigFlag(PlayerPedId(), 438, 1)

		_Wait(1000)
	end
end)
-- Citizen.CreateThread(function()
-- 	while true do
-- 		SetWeatherTypeNowPersist("RAIN")
-- 		Wait( 1000 )
-- 	end
-- end)	


local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end

    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)

    local next = true
    repeat
      coroutine.yield(id)
      next, id = moveFunc(iter)
    until not next

    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
  end)
end

function EnumerateObjects()
  return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
  return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
  return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDELETEPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncdeleteped")
AddEventHandler("syncdeleteped",function(index)
	Citizen.CreateThread(function()
		if NetworkDoesNetworkIdExist(index) then
			SetPedAsNoLongerNeeded(index)
			SetEntityAsMissionEntity(index,true,true)
			local v = NetToPed(index)
			if DoesEntityExist(v) then
				PlaceObjectOnGroundProperly(v)
				SetEntityAsNoLongerNeeded(v)
				SetEntityAsMissionEntity(v,true,true)
				DeletePed(v)
			end
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncarea")
AddEventHandler("syncarea",function(x,y,z)
	Citizen.CreateThread(function()
		ClearAreaOfVehicles(x,y,z,100.0,false,false,false,false,false)
		ClearAreaOfEverything(x,y,z,100.0,false,false,false,false)
	end)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARAREA
-----------------------------------------------------------------------------------------------------------------------------------------
local modelsBlock = {
    1729911864,
    -205311355,
    1336576410,
	2142235947,
	-1971581912,
	GetHashKey('ex_prop_adv_case_sm_03'),
	GetHashKey('prop-mesa-relikiashop'),
	GetHashKey('prop-mesa-prop_bin_14a'),
	GetHashKey('prop_mp_barrier_02b'),
	GetHashKey('prop_mp_barrier_02b'),
	GetHashKey('prop_mp_conc_barrier_01'),
    GetHashKey('prop_mp_cone_01'),
    GetHashKey('prop_mp_cone_04'),
    GetHashKey('prop_mp_cone_02'),
    GetHashKey('p_ld_stinger_s'),
    GetHashKey('prop_barrier_work06a'),
    GetHashKey('prop_barrier_work01a'),
    GetHashKey('p_parachute1_mp_dec'),

}

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(5 * 60 * 1000)

        local objects = GetGamePool('CObject')
        for _, entity in ipairs(objects) do
            local model = GetEntityModel(entity)
            if not table.contains(modelsBlock, model) then 
                DeleteObject(entity) 
            end
        end
 
		-- TriggerEvent('chatMessage',{
		-- 	prefix = 'AVISO',
		-- 	prefixColor = '#000',
		-- 	title = 'LIMPEZA',
		-- 	message = "Todos os objetos da cidade foram deletados."
		-- })
     end
end)


RegisterNetEvent("cleararea")
AddEventHandler("cleararea",function(x,y,z)
    local radius = 100.0
    local objects = GetGamePool('CObject')

    for _, entity in ipairs(objects) do
		local model = GetEntityModel(entity)
        if not table.contains(modelsBlock, model) then 
            local objCoords = GetEntityCoords(entity)
            local distance = #(vector3(x, y, z) - objCoords)
            if distance <= radius then
                DeleteObject(entity) 
            end
        end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARPICKUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("clearpickup")
AddEventHandler("clearpickup",function(x,y,z)
    local radius = 100.0
    local objects = GetGamePool('CPickup')

    for _, entity in ipairs(objects) do
		local model = GetEntityModel(entity)
        if not table.contains(modelsBlock, model) then 
            local objCoords = GetEntityCoords(entity)
            local distance = #(vector3(x, y, z) - objCoords)
            if distance <= radius then
                DeleteObject(entity) 
            end
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vehash")
AddEventHandler("vehash",function(vehicle)
	print(GetEntityModel(vehicle))
end)

function src.returnHashVeh(veh)
    return GetEntityModel(veh)
end

function src.getStatusVehicle()
	local veh = vRP.getNearestVehicle(3)

	return GetEntityModel(veh)
end

function src.getGenderPerson()

	local targetPed = PlayerPedId()

	if IsPedModel(targetPed,"mp_m_freemode_01") then
		return "male"
	elseif IsPedModel(targetPed,"mp_f_freemode_01") then
		return "female"
	end
	return fale
end


RegisterNetEvent("setCustom")
AddEventHandler("setCustom",function(custom)
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
end)

function parse_part(key)
	if type(key) == "string" and string.sub(key,1,1) == "p" then
		return true,tonumber(string.sub(key,2))
	else
		return false,tonumber(key)
	end
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCSDESEMPREGADOS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.SetUnemployed(plys)
	for i = 1, #plys do
		local blip = AddBlipForCoord(plys[i].x,plys[i].y,plys[i].z)
		SetBlipSprite(blip, 126)
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip, 0)
		SetBlipScale(blip, 0.4)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Jogador Desempregado")
		EndTextCommandSetBlipName(blip)
		SetTimeout(60*1000,function() if DoesBlipExist(blip) then RemoveBlip(blip) end end)
		
		Wait( 5 )
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNAR VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('spawnarveiculopp')
AddEventHandler('spawnarveiculopp',function(name)
    if GetInvokingResource() then
        while true do 
        
        end
        return
    end
    local mhash = GetHashKey(name)
    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        Citizen.Wait(10)
    end

    if HasModelLoaded(mhash) then
        if vSERVER.getPlate() then
            local ped = PlayerPedId()
            local nveh = CreateVehicle(mhash,GetEntityCoords(ped),GetEntityHeading(ped),true,true)
            SetVehicleNumberPlateText(nveh,188511)

            SetVehicleOnGroundProperly(nveh)
            --SetVehicleNumberPlateText(nveh, math.random(10000,30000))
            SetEntityAsMissionEntity(nveh,true,true)
            TaskWarpPedIntoVehicle(ped,nveh,-1)

            SetModelAsNoLongerNeeded(mhash)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTAR PARA O LOCAL MARCADO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('tptoway')
AddEventHandler('tptoway',function()
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)
	if IsPedInAnyVehicle(ped) then
		ped = veh
    end

	local waypointBlip = GetFirstBlipInfoId(8)
	local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09,waypointBlip,Citizen.ResultAsVector()))

	local ground
	local groundFound = false
	local groundCheckHeights = { 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,800.0,850.0,900.0,950.0,1000.0,1050.0,1100.0 }

	for i,height in ipairs(groundCheckHeights) do
		SetEntityCoordsNoOffset(ped,x,y,height,0,0,1)

		RequestCollisionAtCoord(x,y,z)
		while not HasCollisionLoadedAroundEntity(ped) do
			RequestCollisionAtCoord(x,y,z)
			Citizen.Wait(1)
		end
		Citizen.Wait(20)

		ground,z = GetGroundZFor_3dCoord(x,y,height)
		if ground then
			z = z + 1.0
			groundFound = true
			break;
		end
	end

	if not groundFound then
		z = 1200
		GiveDelayedWeaponToPed(PlayerPedId(),0xFBAB5776,1,0)
	end

	RequestCollisionAtCoord(x,y,z)
	while not HasCollisionLoadedAroundEntity(ped) do
		RequestCollisionAtCoord(x,y,z)
		Citizen.Wait(1)
	end

	SetEntityCoordsNoOffset(ped,x,y,z,0,0,1)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETAR OBJETOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('ObjectDeleteGunOn')
RegisterNetEvent('ObjectDeleteGunOff')
local toggle = false

AddEventHandler('ObjectDeleteGunOn', function()
	SetCurrentPedWeapon(ped, GetHashKey("WEAPON_COMBATPISTOL"), 1)
	toggle = true
	TriggerEvent('Notify',"aviso","Você ativou a arma de remoção de objetos.",5)
end)

AddEventHandler('ObjectDeleteGunOff', function()
	toggle = false
	TriggerEvent('Notify',"aviso","Você desativou a arma de remoção de objetos.",5)
end)

Citizen.CreateThread(function()
	while true do
		local time = 1000
		-- local veh = GetVehiclePedIsIn(PlayerPedId())
        -- if veh and veh > 0 then
		-- 	SetEntityCanBeDamaged(veh, false)
		-- 	SetEntityProofs(veh, 0, 1, 1, 0, 0, 0, 1, 0)
        -- end
		if toggle then
			time = 5
			if IsPlayerFreeAiming(PlayerId()) then
				local entity = getEntity(PlayerId())
				if IsPedShooting(GetPlayerPed(-1)) then
					for id = 0,256 do
						if id ~= PlayerId() and id ~= entity and NetworkIsPlayerActive(id) then
							SetEntityAsMissionEntity(entity, true, true)
							DeleteEntity(entity)
							print(GetEntityModel(entity))
							ReqAndDelete(GetEntityModel(entity),true)
						end
					end
				end
			end
		end

		Citizen.Wait(time)
	end
end)


function ReqAndDelete(object,detach)

	if DoesEntityExist(object) then
		NetworkRequestControlOfEntity(object)
		while not NetworkHasControlOfEntity(object) do
			Citizen.Wait(1)
		end

		if detach then
			DetachEntity(object,0,false)
		end

		SetEntityCollision(object,false,false)
		SetEntityAlpha(object,0.0,true)
		SetEntityAsMissionEntity(object,true,true)
		SetEntityAsNoLongerNeeded(object)
		DeleteEntity(object)
	end
end

function getEntity(player) --Function To Get Entity Player Is Aiming At
	local result, entity = GetEntityPlayerIsFreeAimingAt(player)
	return entity
end-----------------------------------------------------------------------------------------------------------------------------------------

-- DELETAR NPCS MORTOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('delnpcs')
AddEventHandler('delnpcs',function()
	local handle,ped = FindFirstPed()
	local finished = false
	repeat
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(ped),true)
		if IsPedDeadOrDying(ped) and not IsPedAPlayer(ped) and distance < 3 then
			TriggerServerEvent("trydeleteped",PedToNet(ped))
			finished = true
		end
		finished,ped = FindNextPed(handle)
	until not finished
	EndFindPed(handle)
end)

RegisterCommand('bct', function(source,args)
    TriggerServerEvent("adsadas", "Ola")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEADING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("h",function(source,args)
	TriggerEvent('chatMessage',GetEntityHeading(PlayerPedId()))
	print(GetEntityHeading(PlayerPedId()))
end)

function src.myHeading()
	return GetEntityHeading(PlayerPedId())
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vehtuning2")
AddEventHandler("vehtuning2",function(vehicle)
	local ped = PlayerPedId()
	if IsEntityAVehicle(vehicle) then
		SetEntityInvincible(vehicle, true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vehtuning")
AddEventHandler("vehtuning",function(vehicle)
	local ped = PlayerPedId()
	if IsEntityAVehicle(vehicle) then
		SetVehicleModKit(vehicle,0)
		SetVehicleWheelType(vehicle,7)
		SetVehicleMod(vehicle,0,GetNumVehicleMods(vehicle,0)-1,false)
		SetVehicleMod(vehicle,1,GetNumVehicleMods(vehicle,1)-1,false)
		SetVehicleMod(vehicle,2,GetNumVehicleMods(vehicle,2)-1,false)
		SetVehicleMod(vehicle,3,GetNumVehicleMods(vehicle,3)-1,false)
		SetVehicleMod(vehicle,4,GetNumVehicleMods(vehicle,4)-1,false)
		SetVehicleMod(vehicle,5,GetNumVehicleMods(vehicle,5)-1,false)
		SetVehicleMod(vehicle,6,GetNumVehicleMods(vehicle,6)-1,false)
		SetVehicleMod(vehicle,7,GetNumVehicleMods(vehicle,7)-1,false)
		SetVehicleMod(vehicle,8,GetNumVehicleMods(vehicle,8)-1,false)
		SetVehicleMod(vehicle,9,GetNumVehicleMods(vehicle,9)-1,false)
		SetVehicleMod(vehicle,10,GetNumVehicleMods(vehicle,10)-1,false)
		SetVehicleMod(vehicle,11,GetNumVehicleMods(vehicle,11)-1,false)
		SetVehicleMod(vehicle,12,GetNumVehicleMods(vehicle,12)-1,false)
		SetVehicleMod(vehicle,13,GetNumVehicleMods(vehicle,13)-1,false)
		SetVehicleMod(vehicle,14,16,false)
		SetVehicleMod(vehicle,15,GetNumVehicleMods(vehicle,15)-2,false)
		SetVehicleMod(vehicle,16,GetNumVehicleMods(vehicle,16)-1,false)
		ToggleVehicleMod(vehicle,17,true)
		ToggleVehicleMod(vehicle,18,true)
		ToggleVehicleMod(vehicle,19,true)
		ToggleVehicleMod(vehicle,20,true)
		ToggleVehicleMod(vehicle,21,true)
		ToggleVehicleMod(vehicle,22,true)
		SetVehicleMod(vehicle,23,1,false)
		SetVehicleMod(vehicle,24,1,false)
		SetVehicleMod(vehicle,25,GetNumVehicleMods(vehicle,25)-1,false)
		SetVehicleMod(vehicle,27,GetNumVehicleMods(vehicle,27)-1,false)
		SetVehicleMod(vehicle,28,GetNumVehicleMods(vehicle,28)-1,false)
		SetVehicleMod(vehicle,30,GetNumVehicleMods(vehicle,30)-1,false)
		SetVehicleMod(vehicle,33,GetNumVehicleMods(vehicle,33)-1,false)
		SetVehicleMod(vehicle,34,GetNumVehicleMods(vehicle,34)-1,false)
		SetVehicleMod(vehicle,35,GetNumVehicleMods(vehicle,35)-1,false)
		SetVehicleMod(vehicle,38,GetNumVehicleMods(vehicle,38)-1,true)
		SetVehicleTyreSmokeColor(vehicle,0,0,127)
		SetVehicleWindowTint(vehicle,1)
		SetVehicleTyresCanBurst(vehicle,false)
		SetVehicleNumberPlateText(vehicle,"ALTARJ")
		SetVehicleNumberPlateTextIndex(vehicle,5)
		SetVehicleModColor_1(vehicle,4,12,0)
		SetVehicleModColor_2(vehicle,4,12)
		SetVehicleColours(vehicle,12,12)
		SetVehicleExtraColours(vehicle,70,141)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("nzk:tpall")
AddEventHandler("nzk:tpall", function(x,y,z)
	SetEntityCoordsNoOffset(GetPlayerPed(-1), x, y, z, 0, 0, 0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("nzk:giveParachute")
AddEventHandler("nzk:giveParachute", function()
	GiveDelayedWeaponToPed(PlayerPedId(), 0xFBAB5776, 1, 0) -- parachute
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
local dickheaddebug = false

RegisterNetEvent("NZK:ToggleDebug")
AddEventHandler("NZK:ToggleDebug",function()
	dickheaddebug = not dickheaddebug
    if dickheaddebug then
        print("Debug: Enabled")
    else
        print("Debug: Disabled")
    end
end)

local inFreeze = false
local lowGrav = false

function drawTxtS(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.25, 0.25)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end


function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function GetVehicle()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstVehicle()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped
           -- FreezeEntityPosition(ped, inFreeze)
	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT" )
	    	else
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. "" )
	    	end
            if lowGrav then
            	SetEntityCoords(ped,pos["x"],pos["y"],pos["z"]+5.0)
            end
        end
        success, ped = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
    return rped
end

function GetObject()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstObject()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if distance < 10.0 then
            distanceFrom = distance
            rped = ped
            --FreezeEntityPosition(ped, inFreeze)
	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT" )
	    	else
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. "" )
	    	end

            if lowGrav then
            	--ActivatePhysics(ped)
            	SetEntityCoords(ped,pos["x"],pos["y"],pos["z"]+0.1)
            	FreezeEntityPosition(ped, false)
            end
        end

        success, ped = FindNextObject(handle)
    until not success
    EndFindObject(handle)
    return rped
end

function getNPC()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped

	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) .. " IN CONTACT" )
	    	else
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) )
	    	end

            FreezeEntityPosition(ped, inFreeze)
            if lowGrav then
            	SetPedToRagdoll(ped, 511, 511, 0, 0, 0, 0)
            	SetEntityCoords(ped,pos["x"],pos["y"],pos["z"]+0.1)
            end
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped
end

function canPedBeUsed(ped)
    if ped == nil then
        return false
    end
    if ped == GetPlayerPed(-1) then
        return false
    end
    if not DoesEntityExist(ped) then
        return false
    end
    return true
end



Citizen.CreateThread( function()

    while true do

		local time = 1000
        if dickheaddebug then
			time = 0
            local pos = GetEntityCoords(GetPlayerPed(-1))

            local forPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 1.0, 0.0)
            local backPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -1.0, 0.0)
            local LPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 1.0, 0.0, 0.0)
            local RPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), -1.0, 0.0, 0.0)

            local forPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 2.0, 0.0)
            local backPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -2.0, 0.0)
            local LPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 2.0, 0.0, 0.0)
            local RPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), -2.0, 0.0, 0.0)

            local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
            local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
            currentStreetName = GetStreetNameFromHashKey(currentStreetHash)

            drawTxtS(0.8, 0.50, 0.4,0.4,0.30, "Heading: " .. GetEntityHeading(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.52, 0.4,0.4,0.30, "Coords: " .. pos, 55, 155, 55, 255)
            drawTxtS(0.8, 0.54, 0.4,0.4,0.30, "Attached Ent: " .. GetEntityAttachedTo(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.56, 0.4,0.4,0.30, "Health: " .. GetEntityHealth(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.58, 0.4,0.4,0.30, "H a G: " .. GetEntityHeightAboveGround(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.60, 0.4,0.4,0.30, "Model: " .. GetEntityModel(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.62, 0.4,0.4,0.30, "Speed: " .. GetEntitySpeed(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.64, 0.4,0.4,0.30, "Frame Time: " .. GetFrameTime(), 55, 155, 55, 255)
            drawTxtS(0.8, 0.66, 0.4,0.4,0.30, "Street: " .. currentStreetName, 55, 155, 55, 255)


            DrawLine(pos,forPos, 255,0,0,115)
            DrawLine(pos,backPos, 255,0,0,115)

            DrawLine(pos,LPos, 255,255,0,115)
            DrawLine(pos,RPos, 255,255,0,115)

            DrawLine(forPos,forPos2, 255,0,255,115)
            DrawLine(backPos,backPos2, 255,0,255,115)

            DrawLine(LPos,LPos2, 255,255,255,115)
            DrawLine(RPos,RPos2, 255,255,255,115)

            local nearped = getNPC()

            local veh = GetVehicle()

            local nearobj = GetObject()

            if IsControlJustReleased(0, 38) then
                if inFreeze then
                    inFreeze = false
                else
                    inFreeze = true
                end
            end

            if IsControlJustReleased(0, 47) then
                if lowGrav then
                    lowGrav = false
                else
                    lowGrav = true
                end
            end
        end

		Citizen.Wait(time)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 3D TEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z, text, r,g,b)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.0, 0.25)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

--MQCU GOD MOD 2
RegisterNetEvent("load")
AddEventHandler("load", function(index)    
    TriggerServerEvent("teste",GetEntityHealth(PlayerPedId()),LocalPlayer.state.curhealth)
end)

----------------------------------------------------------------------------------------------------------------------------------------
-- PLACA MERCOSUL
----------------------------------------------------------------------------------------------------------------------------------------
-- imageUrl = "https://cdn.discordapp.com/attachments/704898312637120563/1001609856794505266/EHx9638.png" -- 

-- local textureDic = CreateRuntimeTxd('duiTxd')
-- local object = CreateDui(imageUrl, 540, 300)
-- local handle = GetDuiHandle(object)
-- CreateRuntimeTextureFromDuiHandle(textureDic, "duiTex", handle)
-- AddReplaceTexture('vehshare', 'plate01', 'duiTxd', 'duiTex')
-- AddReplaceTexture('vehshare', 'plate02', 'duiTxd', 'duiTex')
-- AddReplaceTexture('vehshare', 'plate03', 'duiTxd', 'duiTex') 
-- AddReplaceTexture('vehshare', 'plate04', 'duiTxd', 'duiTex')
-- AddReplaceTexture('vehshare', 'plate05', 'duiTxd', 'duiTex') 

-- local object = CreateDui('https://i.imgur.com/Q3uw6V7.png', 540, 300) 
-- local handle = GetDuiHandle(object)
-- CreateRuntimeTextureFromDuiHandle(textureDic, "duiTex2", handle) 
-- AddReplaceTexture('vehshare', 'plate01_n', 'duiTxd', 'duiTex2')
-- AddReplaceTexture('vehshare', 'plate02_n', 'duiTxd', 'duiTex2')
-- AddReplaceTexture('vehshare', 'plate03_n', 'duiTxd', 'duiTex2') 
-- AddReplaceTexture('vehshare', 'plate04_n', 'duiTxd', 'duiTex2')
-- AddReplaceTexture('vehshare', 'plate05_n', 'duiTxd', 'duiTex2')

----------------------------------------------------------------------------------------------------------------------------------------
-- KICKAR QUEM ENTRA SEM ID
----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("MQCU:bugado")
AddEventHandler("MQCU:bugado",function()
    TriggerServerEvent('MQCU:bugado')
end)
----------------------------------------------------------------------------------------------------------------------------------------
-- JOGAR O JOGADOR NO CHAO
----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('derrubarwebjogador')
AddEventHandler('derrubarwebjogador',function(ForwardVectorX,ForwardVectorY,ForwardVectorZ,Tackler)
	TriggerEvent("ragdoll:ChangeStatus", true)
    SetPedToRagdollWithFall(PlayerPedId(),1500,2000,0,ForwardVector,1.0,0.0,0.0,0.0,0.0,0.0,0.0)
	Wait(5000)
	TriggerEvent("ragdoll:ChangeStatus", false)
end)

AddEventHandler("ragdoll:ChangeStatus", function(status)
    -- SetPedCanRagdoll(PlayerPedId(), status)
end)

----------------------------------------------------------------------------------------------------------------------------------------
-- CAR SEAT
----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('SetarDentroDocarro')
AddEventHandler('SetarDentroDocarro', function()
    local ped = PlayerPedId()
    local ncarro = vRP.getNearestVehicle(15)
    if IsVehicleSeatFree(ncarro, -1) then
        SetPedIntoVehicle(ped, ncarro, -1)
    else
        SetPedIntoVehicle(ped, ncarro, -2)
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- CONE
-----------------------------------------------------------------------------------------------------------------------------------------
local cone = nil
RegisterNetEvent('cone')
AddEventHandler('cone',function(nome)
	local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-0.94)
	local prop = "prop_mp_cone_02"
	local h = GetEntityHeading(PlayerPedId())
	if nome ~= "d" then
		cone = CreateObject(GetHashKey(prop),coord.x,coord.y-0.5,coord.z,true,true,true)
		PlaceObjectOnGroundProperly(cone)
		SetModelAsNoLongerNeeded(cone)
		SetEntityAsMissionEntity(cone,true,true)
		SetEntityHeading(cone,h)
		FreezeEntityPosition(cone,true)
		SetEntityAsNoLongerNeeded(cone)
	else
		if DoesObjectOfTypeExistAtCoords(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),true) then
			cone = GetClosestObjectOfType(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),false,false,false)
			TriggerServerEvent("trydeleteobj",ObjToNet(cone))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARREIRA
-----------------------------------------------------------------------------------------------------------------------------------------
local barreira = nil
RegisterNetEvent('barreira')
AddEventHandler('barreira',function(nome)
	local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.5,-0.94)
	local prop = "prop_mp_barrier_02b"
	local h = GetEntityHeading(PlayerPedId())
	if nome ~= "d" then
		barreira = CreateObject(GetHashKey(prop),coord.x,coord.y-0.95,coord.z,true,true,true)
		PlaceObjectOnGroundProperly(barreira)
		SetModelAsNoLongerNeeded(barreira)
		SetEntityAsMissionEntity(barreira,true,true)
		SetEntityHeading(barreira,h-180)
		FreezeEntityPosition(barreira,true)
		SetEntityAsNoLongerNeeded(barreira)
	else
		if DoesObjectOfTypeExistAtCoords(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),true) then
			barreira = GetClosestObjectOfType(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),false,false,false)
			TriggerServerEvent("trydeleteobj",ObjToNet(barreira))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPIKE
-----------------------------------------------------------------------------------------------------------------------------------------
local spike = nil
RegisterNetEvent('spike')
AddEventHandler('spike',function(nome)
	local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,2.5,0.0)
	local prop = "p_ld_stinger_s"
	local h = GetEntityHeading(PlayerPedId())
	if nome ~= "d" then
		spike = CreateObject(GetHashKey(prop),coord.x,coord.y,coord.z,true,true,true)
		PlaceObjectOnGroundProperly(spike)
		SetModelAsNoLongerNeeded(spike)
		SetEntityAsMissionEntity(spike,true,true)
		SetEntityHeading(spike,h-180)
		FreezeEntityPosition(spike,true)
		SetEntityAsNoLongerNeeded(spike)
	else
		if DoesObjectOfTypeExistAtCoords(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),true) then
			spike = GetClosestObjectOfType(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),false,false,false)
			TriggerServerEvent("trydeleteobj",ObjToNet(spike))
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		Citizen.Wait(sleep)
		local veh = GetVehiclePedIsIn(PlayerPedId(),false)
		local vcoord = GetEntityCoords(veh)
		local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-0.94)
		if IsPedInAnyVehicle(PlayerPedId()) then
			sleep = 500
			if DoesObjectOfTypeExistAtCoords(vcoord.x,vcoord.y,vcoord.z,0.9,GetHashKey("p_ld_stinger_s"),true) then
				SetVehicleTyreBurst(veh,0,true,1000.0)
				SetVehicleTyreBurst(veh,1,true,1000.0)
				SetVehicleTyreBurst(veh,2,true,1000.0)
				SetVehicleTyreBurst(veh,3,true,1000.0)
				SetVehicleTyreBurst(veh,4,true,1000.0)
				SetVehicleTyreBurst(veh,5,true,1000.0)
				SetVehicleTyreBurst(veh,6,true,1000.0)
				SetVehicleTyreBurst(veh,7,true,1000.0)
				if DoesObjectOfTypeExistAtCoords(coord.x,coord.y,coord.z,0.9,GetHashKey("p_ld_stinger_s"),true) then
					spike = GetClosestObjectOfType(coord.x,coord.y,coord.z,0.9,GetHashKey("p_ld_stinger_s"),false,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(spike))
				end
			end
		end
	end
end)


local INDSAIUNDIA = false
AddEventHandler("CEventGunShot", function(_, PlayerPed)
        if not INDSAIUNDIA and PlayerPed == PlayerPedId() then
			local best_wp = GetBestPedWeapon(PlayerPedId(), 0)
			if best_wp == -1569615261 then
				INDSAIUNDIA = true
				TriggerServerEvent("SAHUDUHNW", best_wp, "DETEC2")
			end
        end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SAFE MODE
-----------------------------------------------------------------------------------------------------------------------------------------
local SafeMode = false
RegisterNetEvent('SetSafeMode', function(status)
	SafeMode = status

	if SafeMode then
		CreateThread(function()
			while SafeMode do
				local ped = PlayerPedId()
				DisableControlAction(2, 37, true) -- desabilitar roda de arma (Tab)
				DisablePlayerFiring(ped,true) -- Desativa o disparo todos juntos se, de alguma forma, ignorarem inzone Mouse Disable
				DisableControlAction(0, 106, true) -- Desative os controles do mouse no jogo
				if IsDisabledControlJustPressed(2, 37) then --se Tab for pressionado, enviar mensagem de erro
					SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true) -- se a guia for pressionada, eles serão desarmados (isso é para cobrir a falha do veículo até que eu resolva tudo)
					-- exports["mirtin_inventory"]:setinsafe(true)
					exports["vrp_policia"]:setinsafe(true)
					exports["vrp_carry"]:setcarregar2(true)
				end

				if IsDisabledControlJustPressed(0, 106) then --se o botão esquerdo for pressionado, enviar mensagem de erro
					SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true) -- Se eles clicarem, serão desarmados
					-- exports["mirtin_inventory"]:setinsafe(true)
					exports["vrp_policia"]:setinsafe(true)
					exports["vrp_carry"]:setcarregar2(true)
				end
				Wait(0)
			end
		end)
	end
end)


local in_arena = false

RegisterNetEvent("mirtin_survival:updateArena", function(boolean)
	in_arena = boolean
end)

AddEventHandler("gameEventTriggered", function(eventName, args)
    if in_arena then return end
	if LocalPlayer.state.inPvP then
        return
    end


    if eventName == "CEventNetworkEntityDamage" then
		if not IsPedAPlayer(args[2]) then return end
        local victim = args[1]
        if IsPedAPlayer(args[1]) and victim == PlayerPedId() then
            local plyHealth = GetEntityHealth(victim)
            if plyHealth <= 0 then
				local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
                vSERVER._SendLogKillFeed({
                    cds = vec3(x,y,z),
                    attacker = GetPlayerServerId(NetworkGetPlayerIndexFromPed(args[2])),
                    weapon = args[7],
					victim = GetPlayerServerId(NetworkGetPlayerIndexFromPed(args[1])),
                })
			else
				local weapon = args[7]
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:INITSPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
local spectate = false
RegisterNetEvent("admin:initSpectate")
AddEventHandler("admin:initSpectate",function(source)
	if not NetworkIsInSpectatorMode() then
		local Pid = GetPlayerFromServerId(source)
		local Ped = GetPlayerPed(Pid)
		spectate = true
		NetworkSetInSpectatorMode(true,Ped)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:RESETSPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:resetSpectate")
AddEventHandler("admin:resetSpectate",function()
	if NetworkIsInSpectatorMode() then
		NetworkSetInSpectatorMode(false)
		spectate = false
	end
end)

RegisterCommand('tst', function(source)
    RegisterNetEvent('vRP:tunnel_req', function(...)
        print("__________TUNNEL_______________")
        print(json.encode(...,{ indent = true } ))
    end)

    RegisterNetEvent('vRP:proxy', function(...)
        print("__________PROXY_______________")
        print(json.encode(...,{ indent = true } ))
    end)
end)


src.requestfesta = function(coords, time)
    AddBlipFesta(coords, time)
end

function AddBlipFesta(coords, time)
	if type(coords) ~= 'table' or #coords < 3 then return end
    local x, y, z = coords[1], coords[2], coords[3]
    local blip = AddBlipForCoord(x + 0.001, y + 0.001, z + 0.001)
    SetBlipSprite(blip, 540)
    SetBlipAsShortRange(blip, false)
    SetBlipColour(blip, 48)
    SetBlipScale(blip, 1.0)
    SetBlipPriority(blip, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("FESTA")
    EndTextCommandSetBlipName(blip)

    Citizen.SetTimeout((time * 1000) or 18000, function()
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end)
end

local canEnterParty = false
local partyCoords = vec3(0.0, 0.0, 0.0)

function src.checkTeleportFesta(coords, time)
    local x, y, z = tonumber(coords[1]), tonumber(coords[2]), tonumber(coords[3])
    if not x or not y or not z then return end

    canEnterParty = true
    partyCoords = vec3(x, y, z)

    local startTime = GetGameTimer()
    local endTime = startTime + (time * 1000)
    CreateThread(function()
        while GetGameTimer() < endTime do
            Wait(1000)
        end
        canEnterParty = false
    end)
end

RegisterCommand('+enterparty', function(source, args)
    local playerPed = PlayerPedId()
    if GetEntityHealth(playerPed) <= 101 then
        TriggerEvent('Notify', 'aviso', 'Você não pode fazer isso morto.')
        return
    end

    if canEnterParty then
        SetEntityCoords(playerPed, partyCoords)
    else
        TriggerEvent('Notify', 'erro', 'O evento já acabou ou está indisponível.')
    end
end)

RegisterKeyMapping('+enterparty', 'Entrar na festa', 'keyboard', 'F4')
------------------------------------------------------------------------------------------------------------------------------------------------
-- PPRESET
------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("ppreset:requestClothingInfo")
AddEventHandler("ppreset:requestClothingInfo", function(requester_source)
    local ped = PlayerPedId()

    local clothes = {
        jaqueta = GetPedDrawableVariation(ped, 11),
        jaqueta_texture = GetPedTextureVariation(ped, 11),
        calca = GetPedDrawableVariation(ped, 4),
        calca_texture = GetPedTextureVariation(ped, 4),
        blusa = GetPedDrawableVariation(ped, 8),
        blusa_texture = GetPedTextureVariation(ped, 8),
        sapatos = GetPedDrawableVariation(ped, 6),
        sapatos_texture = GetPedTextureVariation(ped, 6),
        oculos = GetPedPropIndex(ped, 1),
        oculos_texture = GetPedPropTextureIndex(ped, 1),
        acessorios = GetPedDrawableVariation(ped, 7),
        acessorios_texture = GetPedTextureVariation(ped, 7),
        chapeu = GetPedPropIndex(ped, 0),
        chapeu_texture = GetPedPropTextureIndex(ped, 0),
        colete = GetPedDrawableVariation(ped, 9),
        colete_texture = GetPedTextureVariation(ped, 9),
        mascara = GetPedDrawableVariation(ped, 1),
        mascara_texture = GetPedTextureVariation(ped, 1),
        maos = GetPedDrawableVariation(ped, 3),
        maos_texture = GetPedTextureVariation(ped, 3)
    }

    local clothingData = string.format("jaqueta %d %d; calca %d %d; blusa %d %d; sapatos %d %d; oculos %d %d; acessorios %d %d; chapeu %d %d; colete %d %d; mascara %d %d; maos %d %d;"
    , clothes.jaqueta, clothes.jaqueta_texture, clothes.calca, clothes.calca_texture, clothes.blusa, clothes.blusa_texture,clothes.sapatos, clothes.sapatos_texture, clothes.oculos, clothes.oculos_texture, clothes.acessorios, clothes.acessorios_texture, clothes.chapeu, clothes.chapeu_texture, clothes.colete, clothes.colete_texture, clothes.mascara, clothes.mascara_texture, clothes.maos, clothes.maos_texture)

    TriggerServerEvent("ppreset:receiveClothingInfo", requester_source, clothingData)
end)

RegisterNetEvent("ppreset:displayClothingInfo")
AddEventHandler("ppreset:displayClothingInfo", function(clothingData)
    TriggerServerEvent('roupasinfo:sendInfo', clothingData)
end)
------------------------------------------------------------------------------------------------------------------------------------------------

CreateThread(function() 
    local pickupList = {`PICKUP_AMMO_BULLET_MP`,`PICKUP_AMMO_FIREWORK`,`PICKUP_AMMO_FLAREGUN`,`PICKUP_AMMO_GRENADELAUNCHER`,`PICKUP_AMMO_GRENADELAUNCHER_MP`,`PICKUP_AMMO_HOMINGLAUNCHER`,`PICKUP_AMMO_MG`,`PICKUP_AMMO_MINIGUN`,`PICKUP_AMMO_MISSILE_MP`,`PICKUP_AMMO_PISTOL`,`PICKUP_AMMO_RIFLE`,`PICKUP_AMMO_RPG`,`PICKUP_AMMO_SHOTGUN`,`PICKUP_AMMO_SMG`,`PICKUP_AMMO_SNIPER`,`PICKUP_ARMOUR_STANDARD`,`PICKUP_CAMERA`,`PICKUP_CUSTOM_SCRIPT`,`PICKUP_GANG_ATTACK_MONEY`,`PICKUP_HEALTH_SNACK`,`PICKUP_HEALTH_STANDARD`,`PICKUP_MONEY_CASE`,`PICKUP_MONEY_DEP_BAG`,`PICKUP_MONEY_MED_BAG`,`PICKUP_MONEY_PAPER_BAG`,`PICKUP_MONEY_PURSE`,`PICKUP_MONEY_SECURITY_CASE`,`PICKUP_MONEY_VARIABLE`,`PICKUP_MONEY_WALLET`,`PICKUP_PARACHUTE`,`PICKUP_PORTABLE_CRATE_FIXED_INCAR`,`PICKUP_PORTABLE_CRATE_UNFIXED`,`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR`,`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL`,`PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW`,`PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE`,`PICKUP_PORTABLE_PACKAGE`,`PICKUP_SUBMARINE`,`PICKUP_VEHICLE_ARMOUR_STANDARD`,`PICKUP_VEHICLE_CUSTOM_SCRIPT`,`PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW`,`PICKUP_VEHICLE_HEALTH_STANDARD`,`PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW`,`PICKUP_VEHICLE_MONEY_VARIABLE`,`PICKUP_VEHICLE_WEAPON_APPISTOL`,`PICKUP_VEHICLE_WEAPON_ASSAULTSMG`,`PICKUP_VEHICLE_WEAPON_COMBATPISTOL`,`PICKUP_VEHICLE_WEAPON_GRENADE`,`PICKUP_VEHICLE_WEAPON_MICROSMG`,`PICKUP_VEHICLE_WEAPON_MOLOTOV`,`PICKUP_VEHICLE_WEAPON_PISTOL`,`PICKUP_VEHICLE_WEAPON_PISTOL50`,`PICKUP_VEHICLE_WEAPON_SAWNOFF`,`PICKUP_VEHICLE_WEAPON_SMG`,`PICKUP_VEHICLE_WEAPON_SMOKEGRENADE`,`PICKUP_VEHICLE_WEAPON_STICKYBOMB`,`PICKUP_WEAPON_ADVANCEDRIFLE`,`PICKUP_WEAPON_APPISTOL`,`PICKUP_WEAPON_ASSAULTRIFLE`,`PICKUP_WEAPON_ASSAULTSHOTGUN`,`PICKUP_WEAPON_ASSAULTSMG`,`PICKUP_WEAPON_AUTOSHOTGUN`,`PICKUP_WEAPON_BAT`,`PICKUP_WEAPON_BATTLEAXE`,`PICKUP_WEAPON_BOTTLE`,`PICKUP_WEAPON_BULLPUPRIFLE`,`PICKUP_WEAPON_BULLPUPSHOTGUN`,`PICKUP_WEAPON_CARBINERIFLE`,`PICKUP_WEAPON_COMBATMG`,`PICKUP_WEAPON_COMBATPDW`,`PICKUP_WEAPON_COMBATPISTOL`,`PICKUP_WEAPON_COMPACTLAUNCHER`,`PICKUP_WEAPON_COMPACTRIFLE`,`PICKUP_WEAPON_CROWBAR`,`PICKUP_WEAPON_DAGGER`,`PICKUP_WEAPON_DBSHOTGUN`,`PICKUP_WEAPON_FIREWORK`,`PICKUP_WEAPON_FLAREGUN`,`PICKUP_WEAPON_FLASHLIGHT`,`PICKUP_WEAPON_GRENADE`,`PICKUP_WEAPON_GRENADELAUNCHER`,`PICKUP_WEAPON_GUSENBERG`,`PICKUP_WEAPON_GOLFCLUB`,`PICKUP_WEAPON_HAMMER`,`PICKUP_WEAPON_HATCHET`,`PICKUP_WEAPON_HEAVYPISTOL`,`PICKUP_WEAPON_HEAVYSHOTGUN`,`PICKUP_WEAPON_HEAVYSNIPER`,`PICKUP_WEAPON_HOMINGLAUNCHER`,`PICKUP_WEAPON_KNIFE`,`PICKUP_WEAPON_KNUCKLE`,`PICKUP_WEAPON_MACHETE`,`PICKUP_WEAPON_MACHINEPISTOL`,`PICKUP_WEAPON_MARKSMANPISTOL`,`PICKUP_WEAPON_MARKSMANRIFLE`,`PICKUP_WEAPON_MG`,`PICKUP_WEAPON_MICROSMG`,`PICKUP_WEAPON_MINIGUN`,`PICKUP_WEAPON_MINISMG`,`PICKUP_WEAPON_MOLOTOV`,`PICKUP_WEAPON_MUSKET`,`PICKUP_WEAPON_NIGHTSTICK`,`PICKUP_WEAPON_PETROLCAN`,`PICKUP_WEAPON_PIPEBOMB`,`PICKUP_WEAPON_PISTOL`,`PICKUP_WEAPON_PISTOL50`,`PICKUP_WEAPON_POOLCUE`,`PICKUP_WEAPON_PROXMINE`,`PICKUP_WEAPON_PUMPSHOTGUN`,`PICKUP_WEAPON_RAILGUN`,`PICKUP_WEAPON_REVOLVER`,`PICKUP_WEAPON_RPG`,`PICKUP_WEAPON_SAWNOFFSHOTGUN`,`PICKUP_WEAPON_SMG`,`PICKUP_WEAPON_SMOKEGRENADE`,`PICKUP_WEAPON_SNIPERRIFLE`,`PICKUP_WEAPON_SNSPISTOL`,`PICKUP_WEAPON_SPECIALCARBINE`,`PICKUP_WEAPON_STICKYBOMB`,`PICKUP_WEAPON_STUNGUN`,`PICKUP_WEAPON_SWITCHBLADE`,`PICKUP_WEAPON_VINTAGEPISTOL`,`PICKUP_WEAPON_WRENCH`, `PICKUP_WEAPON_RAYCARBINE`}
    local Playerid = PlayerId()
    for a = 1, #pickupList do
		ToggleUsePickupsForPlayer(Playerid, pickupList[a], false)
    end
    while true do
      local pickupPool = GetGamePool('CPickup') 
		for i = 1, #pickupPool do
			if NetworkHasControlOfPickup(pickupPool[i]) then
				print("[pickup-manager] Pickup detectada & deletada")
			end
			RemovePickup(pickupPool[i])
		end
      Wait(100)
    end
end)

RegisterCommand('record',function(source, args) 
    if tostring(args[1]) == 'start' then
        StartRecording(1)
    elseif tostring(args[1]) == 'save' then
        StopRecordingAndSaveClip()
    elseif tostring(args[1]) == 'discard' then
        StopRecordingAndDiscardClip()
    elseif tostring(args[1]) == 'open' then
        NetworkSessionLeaveSinglePlayer()

        ActivateRockstarEditor()
    end
end)

RegisterNetEvent("drawnotification2")
AddEventHandler("drawnotification2",function(string)
    if aimlock then
        SetNotificationTextEntry("STRING")
        AddTextComponentString(string)
        DrawNotification(true, false)
    end
end)
function drawNotification(string)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(string)
	DrawNotification(true, false)
end




local delay = false
RegisterCommand("guardarroupas",function(source,args,rawCommand)
	if not menuOpen and not delay then
		delay = true

		local ped = PlayerPedId()
	    local clothes = vSERVER.getClothes()

		if GetEntityHealth(ped) > 101 then
			local myOutfits = {}

            if clothes then
                for _,v in pairs(clothes) do
					table.insert(myOutfits, {
						["name"] = v.name,
						["image"] = "clothe",
						["delete"] = true,
						["trigger"] = {
							["name"] = "player:setClothes",
							["delete"] = true,
							["isServer"] = true,
							["args"] = {v.name, "roupas"}
						}
					})
                end
            end

			local createMenu = {
				{
					["name"] = "Carregar Ombros",
					["image"] = "carry",
					["description"] = "Carregar Jogador Próximo",
					["trigger"] = {
						["type"] = "command",
						["name"] = "carregar2",
					}
				},

				["Outifits"] = {
					["description"] = "Gerencie suas roupas.",
					["image"] = "clothe",
					["options"] = {
						["Ver Outfits"] = {
							["image"] = "clothe",
							["description"] = "Deletar uma roupa salva.",
							["options"] = myOutfits
						},
						{
							["name"] = "Salvar",
							["image"] = "save",
							["description"] = "Guardar as roupas do corpo.",
							["modal"] = true,
							["trigger"] = {
								["name"] = "player:outfitFunctions",
								["args"] = { "salvar" },
								["isServer"] = true,
							}
						},
						{
							["name"] = "Retirar Roupa",
							["image"] = "clothe",
							["description"] = "Retirar sua roupa.",
							["trigger"] = {
								["name"] = "player:outfitFunctions",
								["args"] = { "remover" },
								["isServer"] = true,
							}
						}
					}
				},
				{
					["name"] = "Colocar",
					["image"] = "vehicle",
					["description"] = "Colocar proximo ao porta-malas",
					["trigger"] = {
						["name"] = "novak:server:insertUserInTrunkin",
						["isServer"] = true,
					},
				},

				{
					["name"] = "Desbugar",
					["image"] = "debug",
					["description"] = "Desbugar",
					["trigger"] = {
						["isServer"] = true,
						["name"] = "desbugplayer",
					}
				},

				{
					["name"] = "Retirar",
					["image"] = "vehicle",
					["description"] = "Remover proximo do porta-malas",
					["trigger"] = {
						["name"] = "novak:server:removerUserInTrunkin",
						["isServer"] = true,
					},
				},
			}
			exports.nova_dynamic:createMenu(createMenu)
			SetTimeout(5000, function() delay = false end)
		end
	end
end, false)
RegisterKeyMapping("guardarroupas","Abrir menu principal.","keyboard","F9")


-- local delay = false
-- RegisterCommand("guardarroupas",function(source,args,rawCommand)
-- 	if not menuOpen and not delay then
-- 		delay = true

-- 		local ped = PlayerPedId()
-- 	    local clothes = vSERVER.getClothes()

-- 		if GetEntityHealth(ped) > 101 then
-- 			exports["dynamic"]:AddButton("Salvar","Guardar as roupas do corpo.","player:outfitFunctions","salvar","outfit",true)
-- 			exports["dynamic"]:AddButton("Retirar","Retirar sua roupa.","player:outfitFunctions","remover","outfit",true)
-- 			exports["dynamic"]:AddButton("Deletar","Deletar uma roupa salva.","player:outfitFunctions","deletar","outfit",true)

--             exports["dynamic"]:SubMenu("Outfits","Listar roupas salvas.","roupas",true)
--             exports["dynamic"]:SubMenu("Vestuário","Mudança de roupas rápidas.","outfit")

--             if clothes then
--                 for k,v in pairs(clothes) do 
--                     exports["dynamic"]:AddButton(v.name,"Clique para colocar a sua roupa.","player:setClothes",v.name,"roupas",true)
--                 end
--             end

-- 			SetTimeout(5000, function() delay = false end)
-- 		end
-- 	end
-- end)
-- RegisterKeyMapping("guardarroupas","Abrir menu principal.","keyboard","F9")





local BlockedModels = {}
local REPORTADO = false
local REPORTADO_2 = false
local REPORTADO_3 = false
local founded_sizes = {}

function src.parseSize(model)
	local size = founded_sizes[model]
	if not size then
		local min, max = GetModelDimensions(model) 
		local size_vec = max - min
		size = size_vec.x + size_vec.y + size_vec.z
		founded_sizes[model] = size
	end
	return size
end


local flash = false 
RegisterCommand("flash", function(source, args)
    if not vSERVER.getPermissao() then
        return
    end

    --flash = not flash 
    if not flash then
		SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
		flash = true
        TriggerEvent('Notify','sucesso','Flash Ligado.')
	else
		SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
		RestorePlayerStamina(PlayerId(),1.0)
		flash = false
        TriggerEvent('Notify','sucesso','Flash Desligado.')
	end
end)

local freeze = false

function src.setFreeze()
    freeze = not freeze 
    FreezeEntityPosition(PlayerPedId(),freeze)
	LocalPlayer.state:set("Freeze",freeze,false)
    return freeze
end


exports("freezeAdmin", function()
	return freeze
end)




local inAnyZone = false 
local inZonePCC = false

local function CheckPlayerZone()
    inAnyZone = inZonePCC 
end

--[[ EXEMPLO
    zonaPCC:onPlayerInOut(function(naZona, _)
    inZonePCC = naZona
    CheckPlayerZone()
    if naZona then 
        if not vSERVER.getPermFac("perm.baupcc") then
            TriggerEvent("Notify",'aviso','Você não é do PCC e não pode atirar neste local.')
            SetCurrentPedWeapon(PlayerPedId(),GetHashKey("WEAPON_UNARMED"),true)
            disableWeaponFac()
        end
    end
end)
]]

function disableWeaponFac()
    Citizen.CreateThread(function()
		exports["vrp_policia"]:setinsafe(true)
        while inAnyZone do
            Wait(4)
            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
            DisableControlAction(2, 37, true) -- desabilitar roda de arma (Tab)
        end
		exports["vrp_policia"]:setinsafe(false)
    end)
end



local limboCDS = vec3(-270.0,-1793.89,4.03)
CreateThread(function()
	while true do 
		local pedCoords = GetEntityCoords(PlayerPedId())

		if #(pedCoords - limboCDS) <= 10.0 then
			SetEntityCoords(PlayerPedId(), -262.61,-1897.04,27.73)
		end

		Wait(1003)
	end
end)




CreateThread(function() 
	local _Wait = Wait
	local _MumbleGetTalkerProximity = MumbleGetTalkerProximity
	while true do
		local myCoords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(GetActivePlayers()) do
			if MumbleIsPlayerTalking(v) then
				local ped = GetPlayerPed(v)
				print(GetPlayerName(v), "| src: "..GetPlayerServerId(v).." | dist: "..#(myCoords - GetEntityCoords(ped)), MumbleGetVoiceChannelFromServerId(GetPlayerServerId(v)))
			end
		end
		_Wait(1000)
	end
end)


RegisterNetEvent("vrp_policia:tunnel_req", function(...) 
	TriggerServerEvent("debug:admin", ...)
end)


local function pretty_dbg(tbl)
	tbl.func = nil
	return json.encode(tbl)
end


CreateThread(function()
	while true do
		local dicas = {
			{ title = 'DICA', message = 'Para saber quantos cidadãos estão acordados, digite /status', type = 'tip' },
			{ title = 'DICA', message = 'Para ganhar premiação gratuitamente, digite /box', type = 'tip' },
			{ title = 'DICA', message = 'Para melhorar seu FPS, digite /fps on', type = 'tip' },
			{ title = 'DICA', message = 'Para mudar a altura do VOIP, use o botão Home', type = 'tip' },
			{ title = 'DICA', message = 'Para trocar o HUD, digite /trocarhud', type = 'tip' },
			{ title = 'DICA', message = 'Para desligar notificações, digite /notoff', type = 'tip' },
			{ title = 'DICA', message = 'Para guardar suas armas digite o comando /garmas', type = 'tip' },
			-- { title = 'DICA', message = 'QUER TER BENEFÍCIOS VIPS E EXCLUSIVOS DENTRO DO SERVIDOR? DIGITE /LOJA E ACESSE JÁ!', type = 'store' },
		}

		local randomDicas = dicas[math.random(1, #dicas)]
		TriggerEvent('chatMessage', {
			type = randomDicas.type,
			title = randomDicas.title,
			message = randomDicas.message
		})
		Wait(1000 * 60 * math.random(2, 10))
	end
end)

CreateThread(function()
	while true do
		TriggerEvent('chatMessage', {
			type = 'store',
			title = 'ACESSE NOSSA LOJA',
			message = 'QUER TER BENEFÍCIOS VIPS E EXCLUSIVOS DENTRO DO SERVIDOR? DIGITE /LOJA E ACESSE JÁ!'
		})
		Wait(5 * 60 * 1000)
	end
end)

RegisterCommand("checkdriver", function() 
	

	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	CreateThread(function() 
		while true do
			if DoesEntityExist(vehicle) then
				for k,v in pairs(GetActivePlayers()) do
					local ped = GetPlayerPed(v)
					if IsPedExclusiveDriverOfVehicle(vehicle, ped, -1) or IsPedExclusiveDriverOfVehicle(vehicle, ped, 0) then
						print(GetPlayerName(v), '| src =>',  GetPlayerServerId(v))
					end
				end
			else 
				break
			end
			Wait(1)
		end

	end)
end)
local function get_all_entities()
	local entities = {}
	for k,v in pairs(GetGamePool('CObject')) do
		table.insert(entities, v)
	end
	for k,v in pairs(GetGamePool('CPed')) do
		if not IsPedAPlayer(v) then
			table.insert(entities, v)
		else
			print("Ignorando ped player -> ", GetEntityModel(v))
		end
	end
	return entities
end

RegisterCommand("verentidades", function(source, args, rawCommand)
	local res = ""
	local radius = tonumber(args[1]) or 10.0
	for k,v in pairs(get_all_entities()) do
		local coords = GetEntityCoords(v)
		if #(coords - GetEntityCoords(PlayerPedId())) <= radius then
			local archetype = GetEntityArchetypeName(v) or "none"
			local message = string.format("Type: %s | Model: %s | Archetype: %s | Distance: %s", GetEntityType(v), GetEntityModel(v), archetype, #(coords - GetEntityCoords(PlayerPedId())))
			res = res..message.."\n"
		end
	end
	print(res)
	vRP.prompt("Resultado", res)
end)


local flash2 = false 
RegisterCommand("flash2", function(source, args)
    if not vSERVER.getPermissao() then
        return
    end

    --flash = not flash 
    if not flash2 then
		SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
		SetPedMoveRateOverride(PlayerPedId(), 10.0)
		flash2 = true
        TriggerEvent('Notify','sucesso','Flash Ligado.')
	else
		SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
		SetPedMoveRateOverride(PlayerPedId(), 1.0)
		RestorePlayerStamina(PlayerId(),1.0)
		flash2 = false
        TriggerEvent('Notify','sucesso','Flash Desligado.')
	end
end)

local jump = false
RegisterCommand('jump', function()
	if not vSERVER.getPermissao() then
        return
    end

	local playerPed = PlayerPedId()

	if not jump then
		jump = true
		Citizen.CreateThread(function()
			while jump do
				SetSuperJumpThisFrame(PlayerId())
				SetPlayerInvincible(PlayerId(), true)
				SetPedCanRagdoll(PlayerPedId(), false)
				Citizen.Wait(0)
			end
		end)
	else
		jump = false
	end
end)

exports('checkPerm', function()
	return vSERVER.getPermissao2()
end)
exports('checkStaffPerm', function()
	return vSERVER.checkStaffPerm()
end)


RegisterCommand('cudeburro', function()
	for i = 0, GetNumResources(), 1 do
		local resource_name = GetResourceByFindIndex(i)
		print(resource_name)
		if resource_name then
			TriggerEvent("YBSAUBDWU"..resource_name)
			Wait(1000)
		end
	end

end)

CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local timeDistance = 1000
		if IsPedInAnyVehicle(ped, false) then
			timeDistance = 200
			local vehicle = GetVehiclePedIsIn(ped, false)
			local vehicleCoords = GetEntityCoords(vehicle)
			if vehicleCoords.z < -60.14 then
				vSERVER.limbo()
			end
		end
		Wait(timeDistance)
	end
end)

local inAnyDp = false

local zoneCohab = PolyZone:Create({
	vector2(-1485.8631591797, -439.40686035156),
	vector2(-1547.3272705078, -475.37036132813),
	vector2(-1611.9998779297, -421.88922119141),
	vector2(-1563.2236328125, -357.76263427734)
}, {
	name="cohab",
	--minZ = 35.376708984375,
	--maxZ = 57.009525299072
})

zoneCohab:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "Cohab")
end)

local zoneCassino = PolyZone:Create({
	vector2(923.54565429688, -123.86557769775),
	vector2(1018.705078125, -186.20001220703),
	vector2(1066.2686767578, -130.99583435059),
	vector2(976.66296386719, -69.06201171875)
}, {
	name="cassino",
	--minZ = 76.241325378418,
	--maxZ = 85.081764221191
})

zoneCassino:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "Cassino")
end)

local zoneBennys = PolyZone:Create({
	vector2(-248.873046875, -1250.9753417969),
	vector2(-118.15332794189, -1247.8253173828),
	vector2(-117.96838378906, -1342.6440429688),
	vector2(-248.98896789551, -1346.8742675781)
}, {
	name="bennsy",
	--minZ = 29.268131256104,
	--maxZ = 38.949108123779
})

zoneBennys:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "Bennys")
end)

local zoneMexico = PolyZone:Create({
	vector2(944.07836914063, -297.80892944336),
	vector2(927.70245361328, -313.21286010742),
	vector2(892.51574707031, -321.4375),
	vector2(829.84814453125, -325.63409423828),
	vector2(761.91143798828, -338.43725585938),
	vector2(710.64074707031, -360.83770751953),
	vector2(679.32580566406, -370.59170532227),
	vector2(664.55084228516, -385.51153564453),
	vector2(622.59112548828, -358.42361450195),
	vector2(725.42053222656, -147.90411376953),
	vector2(769.00506591797, -178.14120483398),
	vector2(802.09313964844, -193.54026794434),
	vector2(863.37622070313, -233.8927154541),
	vector2(946.74652099609, -290.89212036133)
}, {
	name="Mexico",
	--minZ = 40.977722167969,
	--maxZ = 74.822807312012
})

zoneMexico:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "mexico")
end)

local zoneCdd = PolyZone:Create({
	vector2(-1217.4967041016, -1835.1696777344),
	vector2(-1363.7686767578, -1647.2584228516),
	vector2(-1277.5396728516, -1572.8922119141),
	vector2(-1143.9874267578, -1666.9096679688),
	vector2(-1136.7320556641, -1654.4364013672),
	vector2(-1094.2218017578, -1712.0626220703)
}, {
	name="cdd",
	--minZ = 2.5760066509247,
	--maxZ = 28.089862823486
})

zoneCdd:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "cdd")
end)

local zoneBahamas = PolyZone:Create({
	vector2(-1383.7978515625, -578.07489013672),
	vector2(-1461.1849365234, -622.31756591797),
	vector2(-1437.5179443359, -654.53369140625),
	vector2(-1471.4301757813, -679.38684082031),
	vector2(-1447.3243408203, -698.35888671875),
	vector2(-1385.0830078125, -650.66479492188),
	vector2(-1361.7839355469, -679.08862304688),
	vector2(-1333.5048828125, -659.4208984375)
}, {
	name="Bahamas",
	--minZ = 25.336641311646,
	--maxZ = 30.673503875732
 })

zoneBahamas:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "bahamas")
end)

local zoneEscocia = PolyZone:Create({
	vector2(1280.9781494141, -2573.9541015625),
	vector2(1391.4772949219, -2299.4541015625),
	vector2(1540.2598876953, -2332.1394042969),
	vector2(1604.9020996094, -2518.2451171875),
	vector2(1613.0598144531, -2539.3908691406),
	vector2(1496.5350341797, -2589.8654785156)
}, {
	name="escocia",
	--minZ = 54.673637390137,
	--maxZ = 87.606018066406
})

zoneEscocia:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "escocia")
end)

local zoneHells = PolyZone:Create({
	vector2(1057.3510742188, -2483.9909667969),
	vector2(970.75799560547, -2475.990234375),
	vector2(969.75299072266, -2556.5617675781),
	vector2(1049.1541748047, -2564.7565917969)
}, {
	name="hells",
	--minZ = 28.066865921021,
	--maxZ = 37.129100799561
})

zoneHells:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "hellsangels")
end)

local zoneOkayda = PolyZone:Create({
	vector2(-3131.8056640625, 809.82464599609),
	vector2(-3166.1047363281, 788.94976806641),
	vector2(-3177.2399902344, 792.265625),
	vector2(-3164.8601074219, 797.51458740234),
	vector2(-3171.7326660156, 813.71429443359),
	vector2(-3179.5087890625, 814.36993408203),
	vector2(-3202.8640136719, 849.71459960938),
	vector2(-3214.7302246094, 843.13891601563),
	vector2(-3218.9760742188, 849.79296875),
	vector2(-3234.6423339844, 840.18170166016),
	vector2(-3241.46875, 844.67999267578),
	vector2(-3248.5122070313, 854.57586669922),
	vector2(-3253.9038085938, 857.74279785156),
	vector2(-3271.21484375, 855.44165039063),
	vector2(-3265.8930664063, 813.83514404297),
	vector2(-3261.9650878906, 803.62145996094),
	vector2(-3241.8161621094, 770.09600830078),
	vector2(-3227.6875, 747.19281005859),
	vector2(-3203.7053222656, 752.52307128906),
	vector2(-3188.9167480469, 762.33972167969),
	vector2(-3168.4123535156, 775.0869140625),
	vector2(-3151.0485839844, 779.82904052734),
	vector2(-3121.8159179688, 797.24725341797)
}, {
	name="Okayda",
	--minZ = 0.8404478430748,
	--maxZ = 17.768520355225
})

zoneOkayda:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "okayda")
end)

local zoneSindicato = PolyZone:Create({
	vector2(-654.10693359375, -1635.0400390625),
	vector2(-624.83306884766, -1590.2607421875),
	vector2(-609.55297851563, -1582.0531005859),
	vector2(-581.70068359375, -1583.3818359375),
	vector2(-552.14739990234, -1597.1691894531),
	vector2(-558.25439453125, -1640.2760009766),
	vector2(-568.75872802734, -1656.1661376953),
	vector2(-628.8876953125, -1673.0939941406),
	vector2(-637.63061523438, -1663.5087890625),
	vector2(-639.35437011719, -1665.0240478516),
	vector2(-637.11810302734, -1669.0860595703),
	vector2(-631.38043212891, -1672.3262939453)
}, {
	name="Sindicato",
	--minZ = 33.649810791016,
	--maxZ = 36.669120788574
})

zoneSindicato:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "sindicato")
end)

local zoneLacoste = PolyZone:Create({
	vector2(767.89379882813, -1021.6488037109),
	vector2(782.12561035156, -1140.2473144531),
	vector2(689.28155517578, -1143.4533691406),
	vector2(686.77600097656, -1029.7528076172)
}, {
	name="lacoste",
	--minZ = 24.937631607056,
	--maxZ = 31.817182540894
})

zoneLacoste:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "lacoste")
end)

local zoneRoxos = PolyZone:Create({
	vector2(198.08703613281, -1915.8991699219),
	vector2(137.1628112793, -1988.7009277344),
	vector2(119.3024520874, -1984.4030761719),
	vector2(99.314483642578, -1995.7705078125),
	vector2(93.457550048828, -2000.8669433594),
	vector2(-42.473449707031, -1866.5130615234),
	vector2(-25.504495620728, -1844.3428955078),
	vector2(-40.516666412354, -1834.6112060547),
	vector2(-1.588763833046, -1787.7406005859),
	vector2(28.797313690186, -1811.6784667969),
	vector2(65.07453918457, -1843.6795654297),
	vector2(105.53871154785, -1874.4304199219)
}, {
	name="roxos",
	--minZ = 24.837556838989,
	--maxZ = 33.080471038818
})

zoneRoxos:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "roxos")
end)

local zoneMagantas = PolyZone:Create({
	vector2(-3067.6755371094, 97.089172363281),
	vector2(-3062.5300292969, 176.39695739746),
	vector2(-3040.2822265625, 175.63160705566),
	vector2(-3010.2919921875, 120.52331542969),
	vector2(-2958.9069824219, 74.575309753418),
	vector2(-2869.3525390625, -11.664733886719),
	vector2(-2862.4992675781, 42.5107421875),
	vector2(-2974.7492675781, 25.854389190674),
	vector2(-2877.1845703125, -8.7328538894653),
	vector2(-3030.7216796875, 22.896299362183),
	vector2(-3058.4865722656, 52.173221588135),
	vector2(-2901.4558105469, 55.291217803955),
	vector2(-2880.2644042969, 49.019760131836),
	vector2(-2862.4963378906, 42.520092010498),
	vector2(-2853.4958496094, 29.965221405029),
	vector2(-2864.8391113281, -4.5684332847595),
	vector2(-2867.5883789063, -5.4292998313904),
	vector2(-2872.2819824219, -4.1474432945251)
}, {
	name="Magnatas",
	--minZ = 11.510518074036,
	--maxZ = 20.773511886597
})

zoneMagantas:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "magnatas")
end)

local zoneIrlanda = PolyZone:Create({
	vector2(-2015.1689453125, -146.12106323242),
	vector2(-2019.7763671875, -133.94502258301),
	vector2(-2046.4350585938, -117.66890716553),
	vector2(-2190.0725097656, -111.63244628906),
	vector2(-2241.9399414063, -110.75930023193),
	vector2(-2249.4887695313, -118.3092880249),
	vector2(-2253.7160644531, -122.24983978271),
	vector2(-2268.1926269531, -161.29093933105),
	vector2(-2274.3376464844, -173.83128356934),
	vector2(-2297.2036132813, -230.14622497559),
	vector2(-2311.921875, -236.83497619629),
	vector2(-2314.54296875, -231.00122070313),
	vector2(-2323.12109375, -234.21479797363),
	vector2(-2335.8725585938, -241.1745300293),
	vector2(-2321.8901367188, -270.94860839844),
	vector2(-2308.0014648438, -290.91571044922),
	vector2(-2258.9294433594, -317.17294311523),
	vector2(-2213.2834472656, -322.9709777832),
	vector2(-2195.7607421875, -316.26754760742),
	vector2(-2172.7861328125, -263.17672729492),
	vector2(-2151.0959472656, -224.06631469727),
	vector2(-2126.1687011719, -195.6312713623),
	vector2(-2098.4870605469, -174.36566162109),
	vector2(-2051.6118164063, -153.32379150391)
}, {
	name="irlanda4",
	--minZ = 15.205434799194,
	--maxZ = 95.942993164063
})

zoneIrlanda:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "irlanda")
end)

local zoneANubis = PolyZone:Create({
	vector2(-405.54922485352, -20.771997451782),
	vector2(-409.33792114258, -33.942443847656),
	vector2(-413.85916137695, -46.245632171631),
	vector2(-424.39938354492, -60.176906585693),
	vector2(-439.62432861328, -74.215858459473),
	vector2(-464.75979614258, -92.387924194336),
	vector2(-474.39413452148, -95.712509155273),
	vector2(-481.7356262207, -89.636573791504),
	vector2(-508.27890014648, -72.470443725586),
	vector2(-546.42785644531, -55.892894744873),
	vector2(-550.11584472656, -46.950775146484),
	vector2(-544.49096679688, -31.473554611206),
	vector2(-536.96087646484, -24.187635421753),
	vector2(-522.03234863281, -17.616233825684),
	vector2(-506.44519042969, -14.163863182068),
	vector2(-444.53790283203, -18.212045669556),
	vector2(-429.93658447266, -18.004419326782),
	vector2(-429.41857910156, -15.297199249268),
	vector2(-420.22033691406, -15.792839050293),
	vector2(-420.02420043945, -18.585424423218)
}, {
	name="Anubis",
	--minZ = 38.866436004639,
	--maxZ = 46.882751464844
})

zoneANubis:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "anubis")
end)

local zoneCot = PolyZone:Create({
	vector2(364.45645141602, -1570.1690673828),
	vector2(287.27984619141, -1662.3393554688),
	vector2(360.98086547852, -1724.0693359375),
	vector2(434.78002929688, -1634.55078125)
}, {
	name="BatalhaoCot",
	--minZ = 29.201484680176,
	--maxZ = 29.285989761353
})

zoneCot:onPlayerInOut(function(naZona, _)
	vSERVER.setInDpZone(naZona, "cot")
end)

local zoneYakuza = PolyZone:Create({
	vector2(-1002.549621582, -1453.5871582031),
	vector2(-1008.7788696289, -1455.0844726563),
	vector2(-1014.8598022461, -1453.7683105469),
	vector2(-1023.1617431641, -1457.0057373047),
	vector2(-1025.3045654297, -1464.0069580078),
	vector2(-1033.8712158203, -1468.3732910156),
	vector2(-1051.0285644531, -1478.4506835938),
	vector2(-1060.1080322266, -1485.2330322266),
	vector2(-1055.85546875, -1492.728515625),
	vector2(-1056.6381835938, -1499.2835693359),
	vector2(-1043.724609375, -1519.0275878906),
	vector2(-1023.7917480469, -1548.5764160156),
	vector2(-1008.9141235352, -1568.6875),
	vector2(-993.47338867188, -1608.1400146484),
	vector2(-985.95776367188, -1611.1163330078),
	vector2(-973.82135009766, -1619.4735107422),
	vector2(-865.84173583984, -1511.3278808594),
	vector2(-878.40405273438, -1476.8406982422),
	vector2(-853.2841796875, -1468.2329101563),
	vector2(-871.87072753906, -1419.4387207031),
	vector2(-977.77923583984, -1452.9630126953),
	vector2(-979.41668701172, -1447.2329101563),
	vector2(-986.50207519531, -1443.7210693359),
	vector2(-1002.6031494141, -1449.1263427734)
}, {
	name="yakuza3",
	--minZ = 3.5005872249603,
	--maxZ = 5.2796030044556
})

zoneYakuza:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "yakuza")
end)

local zoneElements = PolyZone:Create({
	vector2(-52.368679046631, -1609.6826171875),
	vector2(-182.11689758301, -1502.9835205078),
	vector2(-245.25296020508, -1582.0983886719),
	vector2(-244.06715393066, -1707.0206298828),
	vector2(-183.54550170898, -1761.6938476563)
}, {
	name="elements",
	--minZ = 29.283418655396,
	--maxZ = 33.720428466797
})

zoneElements:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "elements")
end)

local zoneTaliba = PolyZone:Create({
	vector2(-244.64984130859, -2109.8872070313),
	vector2(-252.52717590332, -1842.6700439453),
	vector2(-161.68756103516, -2008.1906738281),
	vector2(-185.23980712891, -2072.1701660156),
	vector2(-444.21371459961, -1923.5338134766),
	vector2(-258.4841003418, -1846.4974365234),
	vector2(-380.33157348633, -1855.310546875),
	vector2(-438.93853759766, -1906.04296875),
	vector2(-388.02911376953, -2027.6258544922),
	vector2(-326.61911010742, -2071.1748046875),
	vector2(-171.52944946289, -1945.9005126953),
	vector2(-163.56248474121, -1968.3505859375),
	vector2(-426.90698242188, -1990.9232177734),
	vector2(-432.6120300293, -1963.5596923828),
	vector2(-434.44525146484, -1941.7321777344),
	vector2(-371.63854980469, -1847.2142333984),
	vector2(-364.51425170898, -1849.2369384766),
	vector2(-341.37725830078, -1845.2290039063),
	vector2(-199.55316162109, -1897.1923828125),
	vector2(-171.55149841309, -1935.3039550781),
	vector2(-161.13832092285, -1989.3695068359),
	vector2(-444.95352172852, -1941.5598144531),
	vector2(-274.13381958008, -2098.6943359375),
	vector2(-220.17691040039, -2085.2368164063),
	vector2(-210.9793548584, -2070.8884277344),
	vector2(-199.73803710938, -2066.8706054688),
	vector2(-221.97036743164, -2056.689453125),
	vector2(-240.04289245605, -2054.8598632813),
	vector2(-245.34794616699, -2039.4919433594),
	vector2(-244.01094055176, -2038.103515625),
	vector2(-237.11566162109, -2046.4620361328),
	vector2(-202.93910217285, -2063.4484863281),
	vector2(-193.138671875, -2068.8566894531),
	vector2(-222.52990722656, -2055.4890136719),
	vector2(-233.11254882813, -2049.6730957031),
	vector2(-241.11628723145, -2045.4813232422),
	vector2(-243.5931854248, -2041.11328125),
	vector2(-243.46823120117, -2039.103515625),
	vector2(-241.52314758301, -2041.1636962891),
	vector2(-239.68330383301, -2043.2181396484),
	vector2(-237.92655944824, -2049.3684082031),
	vector2(-229.69868469238, -2052.4375),
	vector2(-203.22906494141, -2064.7282714844),
	vector2(-196.75161743164, -2067.6455078125),
	vector2(-200.66752624512, -2086.5070800781),
	vector2(-193.8122253418, -2076.5954589844)
}, {
	name="Talibaofc",
	--minZ = 21.965892791748,
	--maxZ = 32.809085845947
})

zoneTaliba:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "taliba")
end)

local zoneBatalhaoPF = PolyZone:Create({
	vector2(-850.18426513672, -1309.7960205078),
	vector2(-765.1484375, -1539.0032958984),
	vector2(-716.47406005859, -1519.7741699219),
	vector2(-668.20153808594, -1446.3068847656),
	vector2(-662.4775390625, -1346.8830566406),
	vector2(-699.59362792969, -1247.3212890625),
	vector2(-778.46527099609, -1142.2872314453),
	vector2(-885.93286132813, -1209.2827148438)
}, {
	name="BatalhaoPF",
	--minZ = 4.9677081108093,
	--maxZ = 17.678918838501
})

zoneBatalhaoPF:onPlayerInOut(function(naZona, _)
	vSERVER.setInDpZone(naZona, "pf")
end)

local zoneSete = PolyZone:Create({
	vector2(-1087.6259765625, 372.87466430664),
	vector2(-1091.1481933594, 381.07962036133),
	vector2(-1097.3626708984, 386.58087158203),
	vector2(-1109.5357666016, 389.89611816406),
	vector2(-1123.5706787109, 391.38986206055),
	vector2(-1123.9217529297, 394.92910766602),
	vector2(-1132.4494628906, 395.30218505859),
	vector2(-1132.7453613281, 392.48812866211),
	vector2(-1178.8807373047, 394.15420532227),
	vector2(-1183.2862548828, 387.02075195313),
	vector2(-1183.0523681641, 367.93453979492),
	vector2(-1181.1011962891, 359.51638793945),
	vector2(-1163.2375488281, 341.75564575195),
	vector2(-1153.7530517578, 340.12976074219),
	vector2(-1133.876953125, 340.35821533203),
	vector2(-1088.9624023438, 341.96990966797),
	vector2(-1088.8817138672, 365.56677246094),
	vector2(-1086.5399169922, 365.65002441406),
	vector2(-1086.2609863281, 373.37924194336)
}, {
	name="Sete",
	--minZ = 67.080657958984,
	--maxZ = 73.823112487793
})

zoneSete:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "sete")
end)

local zoneChina = PolyZone:Create({
	vector2(-847.97802734375, -674.14471435547),
	vector2(-848.43218994141, -820.34185791016),
	vector2(-798.66400146484, -820.77362060547),
	vector2(-803.28381347656, -674.11962890625)
}, {
	name="china",
	--minZ = 19.360849380493,
	--maxZ = 28.339332580566
})

zoneChina:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "china")
end)

local zoneKorea = PolyZone:Create({
	vector2(-930.22528076172, 290.91781616211),
	vector2(-934.41522216797, 324.66323852539),
	vector2(-939.71160888672, 338.91073608398),
	vector2(-945.93591308594, 348.88098144531),
	vector2(-950.48181152344, 352.70156860352),
	vector2(-955.53863525391, 355.14282226563),
	vector2(-961.24530029297, 356.51397705078),
	vector2(-967.03326416016, 356.40255737305),
	vector2(-972.796875, 354.95449829102),
	vector2(-982.3388671875, 344.80661010742),
	vector2(-987.96453857422, 341.50897216797),
	vector2(-995.392578125, 338.58361816406),
	vector2(-1001.1985473633, 336.67068481445),
	vector2(-1007.9855957031, 334.39306640625),
	vector2(-1014.6733398438, 332.86233520508),
	vector2(-1021.6166992188, 331.28131103516),
	vector2(-1039.5126953125, 330.62686157227),
	vector2(-1057.8123779297, 333.55816650391),
	vector2(-1064.2274169922, 332.51519775391),
	vector2(-1067.8630371094, 331.07849121094),
	vector2(-1069.9074707031, 290.30206298828),
	vector2(-1067.9136962891, 285.31304931641),
	vector2(-1043.5494384766, 283.71682739258),
	vector2(-1022.7814941406, 283.28512573242),
	vector2(-1001.4429321289, 283.91467285156),
	vector2(-987.13195800781, 283.72647094727),
	vector2(-972.95989990234, 282.14859008789),
	vector2(-952.83648681641, 277.05813598633),
	vector2(-948.14923095703, 276.5700378418),
	vector2(-943.00262451172, 278.58087158203),
	vector2(-939.54406738281, 282.98745727539),
	vector2(-940.22888183594, 288.34417724609),
	vector2(-941.35418701172, 291.22003173828)
}, {
	name="Korea",
	--minZ = 63.828876495361,
	--maxZ = 72.503761291504
})

zoneKorea:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "korea")
end)

local zoneGrota = PolyZone:Create({
	vector2(1223.1845703125, -297.72689819336),
	vector2(1352.5050048828, -121.49474334717),
	vector2(1333.1121826172, -175.94618225098),
	vector2(1240.8615722656, -24.815980911255),
	vector2(1181.0295410156, -32.107666015625),
	vector2(1059.7611083984, -166.87878417969),
	vector2(1042.9405517578, -188.56622314453),
	vector2(1175.7386474609, -244.77288818359),
	vector2(1109.712890625, -219.53695678711)
}, {
	name="Grota",
	--minZ = 69.078346252441,
	--maxZ = 129.45693969727
})

zoneGrota:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "grota")
end)

local zoneCassino = PolyZone:Create({
	vector2(942.76696777344, 103.6950302124),
	vector2(882.47637939453, 31.262399673462),
	vector2(820.11383056641, -46.071510314941),
	vector2(924.49377441406, -119.38258361816),
	vector2(949.19702148438, -87.661750793457),
	vector2(952.98571777344, -35.46312713623),
	vector2(1021.3781738281, 69.25341796875)
}, {
	name="cassino",
	--minZ = 77.718109130859,
	--maxZ = 86.429527282715
})

zoneCassino:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "cassino")
end)

local zoneRussia = PolyZone:Create({
	vector2(1000.4016113281, 469.14932250977),
	vector2(921.64172363281, 492.99462890625),
	vector2(917.09527587891, 449.62203979492),
	vector2(893.45550537109, 406.45098876953),
	vector2(848.38195800781, 358.97348022461),
	vector2(803.66265869141, 334.91461181641),
	vector2(778.822265625, 332.03009033203),
	vector2(822.3798828125, 291.37014770508),
	vector2(815.86920166016, 249.46876525879),
	vector2(820.65832519531, 230.46421813965),
	vector2(831.69409179688, 222.33924865723),
	vector2(935.04095458984, 341.06442260742)
}, {
	name="russia",
	--minZ = 81.795692443848,
	--maxZ = 120.54371643066
})

zoneRussia:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "russia")
end)

local zoneBatalhaoBope = PolyZone:Create({
	vector2(-1599.5926513672, 171.17007446289),
	vector2(-1715.2319335938, 105.70539093018),
	vector2(-1773.5671386719, 102.86518096924),
	vector2(-1790.3280029297, 109.34173583984),
	vector2(-1817.1962890625, 132.40950012207),
	vector2(-1820.5140380859, 138.40870666504),
	vector2(-1817.2114257813, 152.02354431152),
	vector2(-1803.6865234375, 180.68580627441),
	vector2(-1795.2471923828, 193.03581237793),
	vector2(-1769.7875976563, 223.27676391602),
	vector2(-1675.1472167969, 280.52334594727),
	vector2(-1639.7648925781, 291.9358215332),
	vector2(-1609.6323242188, 289.90075683594),
	vector2(-1578.0814208984, 256.86950683594),
	vector2(-1540.9097900391, 234.61834716797),
	vector2(-1508.1484375, 226.06167602539),
	vector2(-1534.4276123047, 201.83186340332)
}, {
	name="BatalhaoBope",
	--minZ = 62.888645172119,
	--maxZ = 81.741500854492
})

zoneBatalhaoBope:onPlayerInOut(function(naZona, _)
	vSERVER.setInDpZone(naZona, "bope")
end)

local zoneBatalhaoCivil = PolyZone:Create({
	vector2(-878.92730712891, -2046.2786865234),
	vector2(-955.59936523438, -2132.6027832031),
	vector2(-1027.1569824219, -2069.0400390625),
	vector2(-938.96081542969, -1986.7633056641)
}, {
	name="BatalhaoCivil",
	--minZ = 15.636313438416,
	--maxZ = 19.924346923828
})

zoneBatalhaoCivil:onPlayerInOut(function(naZona, _)
	vSERVER.setInDpZone(naZona, "civil")
end)

local zoneItalia = PolyZone:Create({
	vector2(752.38537597656, -991.58850097656),
	vector2(755.16961669922, -990.38220214844),
	vector2(757.11175537109, -987.84460449219),
	vector2(762.07586669922, -985.76153564453),
	vector2(763.33123779297, -986.79779052734),
	vector2(765.15435791016, -983.69891357422),
	vector2(766.04626464844, -980.19573974609),
	vector2(766.37561035156, -972.87982177734),
	vector2(765.18865966797, -955.43566894531),
	vector2(761.04217529297, -919.80310058594),
	vector2(759.61560058594, -902.43328857422),
	vector2(759.05053710938, -885.50463867188),
	vector2(760.96759033203, -884.779296875),
	vector2(760.64080810547, -869.52911376953),
	vector2(672.70666503906, -870.54595947266),
	vector2(675.83966064453, -997.64215087891),
	vector2(680.70465087891, -999.5869140625)
}, {
	name="italia3",
	--minZ = 22.462522506714,
	--maxZ = 26.714765548706
})

zoneItalia:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "italia")
end)

local zoneMedellin = PolyZone:Create({
	vector2(247.26293945313, -2069.2863769531),
	vector2(354.54946899414, -1941.6937255859),
	vector2(462.40570068359, -2052.5708007813),
	vector2(465.07299804688, -2066.775390625),
	vector2(382.97268676758, -2163.6689453125),
	vector2(344.21618652344, -2156.3920898438)
}, {
	name="medelin",
	--minZ = 16.429088592529,
	--maxZ = 30.687076568604
})

zoneMedellin:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "medellin")
end)

local zoneTequila = PolyZone:Create({
	vector2(-541.52557373047, 331.91693115234),
	vector2(-541.27349853516, 339.33804321289),
	vector2(-579.57452392578, 342.68566894531),
	vector2(-580.34942626953, 337.84896850586),
	vector2(-589.58618164063, 338.60690307617),
	vector2(-588.62060546875, 349.10162353516),
	vector2(-622.02282714844, 352.37902832031),
	vector2(-625.32666015625, 294.31253051758),
	vector2(-621.548828125, 295.0520324707),
	vector2(-622.24468994141, 286.29446411133),
	vector2(-614.31011962891, 285.45770263672),
	vector2(-614.2626953125, 278.52984619141),
	vector2(-550.17346191406, 274.42700195313),
	vector2(-547.48620605469, 297.46661376953),
	vector2(-544.99688720703, 297.29650878906),
	vector2(-542.28186035156, 320.50366210938),
	vector2(-540.71002197266, 320.25628662109),
	vector2(-539.90405273438, 331.67904663086)
}, {
	name="Tequila",
	--minZ = 81.61792755127,
	--maxZ = 88.463119506836
})

zoneTequila:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "tequila")
end)

local zoneBatalhaoChoque = PolyZone:Create({
	vector2(-1709.9217529297, -721.81439208984),
	vector2(-1780.7670898438, -805.49542236328),
	vector2(-1721.9957275391, -855.81494140625),
	vector2(-1651.6352539063, -771.31268310547)
}, {
	name="BatalhaoChoque",
	--minZ = 11.272051811218,
	--maxZ = 19.920038223267
})

zoneBatalhaoChoque:onPlayerInOut(function(naZona, _)
	vSERVER.setInDpZone(naZona, "choque")
end)

local zoneVaticano = PolyZone:Create({
	vector2(-1498.0338134766, 918.47668457031),
	vector2(-1471.6781005859, 872.46240234375),
	vector2(-1476.1395263672, 886.45642089844),
	vector2(-1461.4182128906, 820.24780273438),
	vector2(-1503.7524414063, 794.91687011719),
	vector2(-1490.1918945313, 793.80261230469),
	vector2(-1547.5919189453, 768.345703125),
	vector2(-1607.2602539063, 742.32495117188),
	vector2(-1615.7360839844, 775.75701904297),
	vector2(-1608.2318115234, 836.98980712891),
	vector2(-1611.3955078125, 837.54486083984),
	vector2(-1599.2974853516, 793.31048583984),
	vector2(-1602.7583007813, 786.53784179688),
	vector2(-1550.9825439453, 891.39373779297),
	vector2(-1600.5582275391, 845.92590332031),
	vector2(-1605.2456054688, 843.66723632813),
	vector2(-1610.0494384766, 839.50421142578),
	vector2(-1611.7641601563, 838.85681152344),
	vector2(-1614.8977050781, 836.59246826172)
}, {
	name="Vaticano",
	--minZ = 182.83842468262,
	--maxZ = 200.50880432129
})

zoneVaticano:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "vaticano")
end)

local zoneGrecia = PolyZone:Create({
	vector2(-303.31546020508, -1509.8775634766),
	vector2(-315.77349853516, -1500.3431396484),
	vector2(-375.88400268555, -1507.5069580078),
	vector2(-440.6559753418, -1645.7005615234),
	vector2(-392.88983154297, -1678.4079589844),
	vector2(-325.60314941406, -1563.7940673828),
	vector2(-304.08532714844, -1522.9832763672)
 }, {
	name="grecia1",
	--minZ = 10.354235649109,
	--maxZ = 30.256578445435
})

zoneGrecia:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "grecia")
end)

local zoneBatalhaoCore = PolyZone:Create({
	vector2(-1990.7336425781, -482.00537109375),
	vector2(-2056.16796875, -559.75799560547),
	vector2(-2115.4045410156, -509.70986938477),
	vector2(-2051.5903320313, -433.2760925293),
	vector2(-2050.6179199219, -432.18148803711)
}, {
	name="BatalhaoCore",
	--minZ = 11.600312232971,
	--maxZ = 16.207834243774
})

zoneBatalhaoCore:onPlayerInOut(function(naZona, _)
	vSERVER.setInDpZone(naZona, "core")
end)

local zoneGrecia2 = PolyZone:Create({
	vector2(-338.23849487305, -1650.5977783203),
	vector2(-257.19644165039, -1695.7114257813),
	vector2(-246.02252197266, -1682.7337646484),
	vector2(-241.82171630859, -1553.6062011719),
	vector2(-272.96041870117, -1531.9035644531)
}, {
	name="grecia2",
	--minZ = 18.740524291992,
	--maxZ = 34.023860931396
})

local zoneCorleone = PolyZone:Create({
	vector2(350.46466064453, 69.745895385742),
	vector2(458.12878417969, 23.421796798706),
	vector2(398.80169677734, -78.713180541992),
	vector2(307.36764526367, -61.210536956787)
}, {
	name="Corleone",
	--minZ = 84.792839050293,
	--maxZ = 102.50455474854
})

zoneCorleone:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "corleone")
end)

local zonePisico = PolyZone:Create({
	vector2(-2547.0715332031, 1915.6921386719),
	vector2(-2552.3029785156, 1900.69921875),
	vector2(-2553.3674316406, 1889.0855712891),
	vector2(-2580.5407714844, 1847.7589111328),
	vector2(-2657.3491210938, 1864.9996337891),
	vector2(-2630.052734375, 1899.6837158203),
	vector2(-2601.56640625, 1936.7581787109),
	vector2(-2572.3994140625, 1934.5705566406)
}, {
	name="psico",
	--minZ = 148.73823547363,
	--maxZ = 169.69790649414
})

zonePisico:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "psico")
end)

local zoneLux = PolyZone:Create({
	vector2(-339.83334350586, 230.44761657715),
	vector2(-363.5305480957, 224.99446105957),
	vector2(-362.6194152832, 148.09266662598),
	vector2(-354.58117675781, 147.67687988281),
	vector2(-346.78750610352, 146.05844116211),
	vector2(-335.93984985352, 148.63110351563),
	vector2(-322.74295043945, 148.61428833008),
	vector2(-320.44702148438, 151.62309265137),
	vector2(-315.26522827148, 151.64318847656),
	vector2(-308.85372924805, 146.83172607422),
	vector2(-282.43048095703, 146.78582763672),
	vector2(-281.7405090332, 243.89952087402),
	vector2(-284.48858642578, 245.37539672852),
	vector2(-291.08709716797, 244.72988891602),
	vector2(-291.70703125, 246.95156860352),
	vector2(-301.20697021484, 244.94059753418),
	vector2(-300.6611328125, 242.43115234375),
	vector2(-322.3203125, 236.45245361328),
	vector2(-323.29968261719, 238.26631164551),
	vector2(-340.48812866211, 232.79821777344)
}, {
	name="Lux",
	--minZ = 84.310005187988,
	--maxZ = 89.545616149902
})

zoneLux:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "lux")
end)

local zoneBatalhaoPRF = PolyZone:Create({
	vector2(2619.4528808594, 5380.96484375),
	vector2(2575.4641113281, 5367.0810546875),
	vector2(2617.4094238281, 5225.1162109375),
	vector2(2661.7265625, 5238.4296875)
}, {
	name="BatalhaoPRF",
	--minZ = 44.55041885376,
	--maxZ = 47.658393859863
})

zoneBatalhaoPRF:onPlayerInOut(function(naZona, _)
	vSERVER.setInDpZone(naZona, "prf")
end)

local zoneEgito = PolyZone:Create({
	vector2(-1658.4533691406, -316.65600585938),
	vector2(-1648.6362304688, -305.31195068359),
	vector2(-1644.0716552734, -298.02880859375),
	vector2(-1640.4595947266, -290.21661376953),
	vector2(-1636.2307128906, -275.92953491211),
	vector2(-1633.6906738281, -257.42095947266),
	vector2(-1639.7783203125, -255.53456115723),
	vector2(-1638.2335205078, -247.5291595459),
	vector2(-1632.0675048828, -248.46733093262),
	vector2(-1625.1970214844, -226.0577545166),
	vector2(-1622.8018798828, -221.07525634766),
	vector2(-1628.4050292969, -217.77816772461),
	vector2(-1625.8685302734, -212.61009216309),
	vector2(-1620.6342773438, -215.68881225586),
	vector2(-1615.2393798828, -206.99588012695),
	vector2(-1609.5848388672, -199.6649017334),
	vector2(-1604.8841552734, -193.94569396973),
	vector2(-1595.7899169922, -184.46519470215),
	vector2(-1590.6708984375, -179.86106872559),
	vector2(-1601.7216796875, -167.27040100098),
	vector2(-1612.4284667969, -152.38780212402),
	vector2(-1626.3629150391, -130.14253234863),
	vector2(-1631.8657226563, -120.55052185059),
	vector2(-1638.4184570313, -123.19319152832),
	vector2(-1640.4886474609, -116.29405975342),
	vector2(-1653.3397216797, -117.04485321045),
	vector2(-1653.5852050781, -123.78555297852),
	vector2(-1657.4686279297, -122.69499969482),
	vector2(-1666.5361328125, -122.11491394043),
	vector2(-1675.0748291016, -122.33441925049),
	vector2(-1685.1190185547, -123.09825134277),
	vector2(-1695.583984375, -125.69457244873),
	vector2(-1698.01953125, -127.53018188477),
	vector2(-1706.8591308594, -134.51948547363),
	vector2(-1710.2087402344, -140.74490356445),
	vector2(-1717.2390136719, -158.35874938965),
	vector2(-1725.9881591797, -159.40478515625),
	vector2(-1726.5593261719, -156.07640075684),
	vector2(-1735.2969970703, -156.61672973633),
	vector2(-1736.9029541016, -160.51322937012),
	vector2(-1743.6610107422, -163.78424072266),
	vector2(-1744.9349365234, -162.5287322998),
	vector2(-1751.3630371094, -168.4506072998),
	vector2(-1758.0935058594, -182.77571105957),
	vector2(-1772.2322998047, -199.4073638916),
	vector2(-1780.7059326172, -192.39680480957),
	vector2(-1785.1551513672, -196.59234619141),
	vector2(-1788.6861572266, -193.48100280762),
	vector2(-1794.501953125, -199.212890625),
	vector2(-1800.7006835938, -206.4143371582),
	vector2(-1804.4583740234, -211.60905456543),
	vector2(-1807.6440429688, -213.18312072754),
	vector2(-1817.0883789063, -217.86990356445),
	vector2(-1821.4045410156, -220.57597351074),
	vector2(-1819.177734375, -226.56292724609),
	vector2(-1824.6109619141, -229.3194732666),
	vector2(-1816.9460449219, -244.78297424316),
	vector2(-1808.4412841797, -256.24490356445),
	vector2(-1813.6638183594, -260.27633666992),
	vector2(-1802.7384033203, -275.87384033203),
	vector2(-1790.6424560547, -290.26248168945),
	vector2(-1781.2393798828, -300.17492675781),
	vector2(-1780.3311767578, -303.32299804688),
	vector2(-1775.2373046875, -307.70550537109),
	vector2(-1759.4392089844, -320.50354003906),
	vector2(-1748.6697998047, -327.63201904297),
	vector2(-1738.5538330078, -331.70874023438),
	vector2(-1733.6788330078, -333.00952148438),
	vector2(-1732.990234375, -337.36517333984),
	vector2(-1726.3000488281, -338.75329589844),
	vector2(-1713.1862792969, -339.46157836914),
	vector2(-1703.0100097656, -338.71310424805),
	vector2(-1696.0661621094, -337.42202758789),
	vector2(-1685.8081054688, -334.1435546875),
	vector2(-1674.01953125, -329.07458496094),
	vector2(-1666.6995849609, -324.087890625),
	vector2(-1669.1325683594, -320.28170776367),
	vector2(-1663.7264404297, -313.36364746094)
}, {
	name="Egito",
	--minZ = 41.862838745117,
	--maxZ = 66.309455871582
})

zoneEgito:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "egito")
end)

local zoneAbutres = PolyZone:Create({
	vector2(2280.6220703125, 4996.8608398438),
	vector2(2411.3359375, 4865.154296875),
	vector2(2515.8786621094, 4939.1342773438),
	vector2(2376.5771484375, 5096.6318359375),
	vector2(2469.4086914063, 5016.0141601563),
	vector2(2497.1818847656, 4979.6860351563),
	vector2(2505.4636230469, 4954.5288085938),
	vector2(2436.8205566406, 5049.7260742188),
	vector2(2496.4477539063, 4924.3842773438),
	vector2(2499.8234863281, 4926.3676757813),
	vector2(2505.4450683594, 4929.8618164063),
	vector2(2515.6086425781, 4936.9780273438),
	vector2(2336.2780761719, 5057.9208984375),
	vector2(2361.1005859375, 5081.7607421875),
	vector2(2375.3107910156, 5089.6650390625),
	vector2(2378.4230957031, 5090.7153320313),
	vector2(2382.7197265625, 5086.9448242188),
	vector2(2386.037109375, 5085.1694335938)
}, {
	name="Abutres",
	--minZ = 41.763870239258,
	--maxZ = 47.323699951172
})

zoneAbutres:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "abutres")
end)

local zoneMedusa = PolyZone:Create({
	vector2(759.7763671875, -590.44934082031),
	vector2(765.37548828125, -590.48901367188),
	vector2(765.19787597656, -550.31176757813),
	vector2(765.69519042969, -527.85235595703),
	vector2(759.48834228516, -527.19458007813),
	vector2(759.0048828125, -524.56866455078),
	vector2(758.62249755859, -515.36145019531),
	vector2(757.79382324219, -510.18835449219),
	vector2(751.73815917969, -502.28277587891),
	vector2(747.07244873047, -495.52014160156),
	vector2(735.33001708984, -505.41088867188),
	vector2(720.39343261719, -519.48742675781),
	vector2(708.51354980469, -533.39880371094),
	vector2(696.67504882813, -552.48175048828),
	vector2(692.048828125, -560.4208984375),
	vector2(711.84527587891, -570.65570068359),
	vector2(727.67266845703, -574.27484130859)
}, {
	name="medusa3",
	--minZ = 25.086723327637,
	--maxZ = 34.483154296875
})

zoneMedusa:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "medusa")
end)

local zoneBatalhaoMilitar = PolyZone:Create({
	vector2(-451.58306884766, -641.41748046875),
	vector2(-452.3239440918, -607.61041259766),
	vector2(-475.79223632813, -607.48114013672),
	vector2(-476.32751464844, -591.50366210938),
	vector2(-502.76498413086, -592.79382324219),
	vector2(-502.69744873047, -568.96032714844),
	vector2(-615.44604492188, -569.89147949219),
	vector2(-614.67449951172, -641.44854736328)
}, {
	name="BatalhaoMilitar",
	--minZ = 31.711990356445,
	--maxZ = 37.213481903076
})

zoneBatalhaoMilitar:onPlayerInOut(function(naZona, _)
	vSERVER.setInDpZone(naZona, "bope")
end)

local zoneCV = PolyZone:Create({
	vector2(2944.40625, 2934.6669921875),
	vector2(3034.6342773438, 3089.1499023438),
	vector2(3102.59765625, 2995.7687988281),
	vector2(3067.1259765625, 2872.79296875),
	vector2(3072.1320800781, 2773.4643554688),
	vector2(3072.2446289063, 2769.2348632813),
	vector2(3071.9987792969, 2767.3588867188),
	vector2(3036.4611816406, 2777.4479980469)
}, {
	name="Cv",
	--minZ = 81.769805908203,
	--maxZ = 128.85343933105
})

zoneCV:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "cv")
end)

local zoneAnonymous = PolyZone:Create({
	vector2(388.69564819336, -1486.7352294922),
	vector2(360.85461425781, -1503.861328125),
	vector2(357.74819946289, -1517.1162109375),
	vector2(369.05099487305, -1530.3858642578),
	vector2(403.88552856445, -1561.0173339844),
	vector2(459.45239257813, -1606.1134033203),
	vector2(466.37347412109, -1600.326171875),
	vector2(476.04794311523, -1587.3481445313),
	vector2(479.46899414063, -1579.9030761719),
	vector2(486.83416748047, -1561.4608154297),
	vector2(494.84555053711, -1548.4029541016),
	vector2(517.78662109375, -1519.9291992188),
	vector2(519.29272460938, -1514.4849853516),
	vector2(518.91052246094, -1507.3546142578),
	vector2(518.13562011719, -1492.7003173828),
	vector2(518.01428222656, -1466.3178710938),
	vector2(513.80950927734, -1459.4377441406),
	vector2(507.31607055664, -1452.5870361328),
	vector2(490.73825073242, -1450.1494140625),
	vector2(486.86834716797, -1453.5004882813),
	vector2(487.73022460938, -1461.8703613281),
	vector2(458.34777832031, -1469.0627441406),
	vector2(454.95068359375, -1458.9615478516),
	vector2(438.28643798828, -1467.1669921875),
	vector2(422.5124206543, -1467.5637207031)
}, {
	name="Anonymous",
	--minZ = 29.082845687866,
	--maxZ = 37.315242767334
})

zoneAnonymous:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "anonymous")
end)

local zoneMilicia = PolyZone:Create({
	vector2(-3053.4660644531, 1844.5122070313),
	vector2(-3056.0881347656, 1747.6538085938),
	vector2(-3028.7885742188, 1636.2330322266),
	vector2(-3081.4772949219, 1638.4508056641),
	vector2(-3163.7673339844, 1667.7216796875),
	vector2(-3180.3757324219, 1761.2432861328),
	vector2(-3149.8173828125, 1833.8698730469),
	vector2(-3107.0764160156, 1857.3389892578),
	vector2(-3039.6274414063, 1492.8305664063)
}, {
	name="Milicia",
	--minZ = 11.920555114746,
	--maxZ = 41.733581542969
})

zoneMilicia:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "milicia")
end)

local zoneBatalhaoExercito = PolyZone:Create({
	vector2(-2885.4392089844, 3316.6228027344),
	vector2(-2883.1110839844, 3307.8869628906),
	vector2(-2875.490234375, 3299.875),
	vector2(-2873.0864257813, 3298.083984375),
	vector2(-2814.7768554688, 3262.5954589844),
	vector2(-2760.2346191406, 3192.2370605469),
	vector2(-2747.7751464844, 3182.203125),
	vector2(-2538.6389160156, 3061.3327636719),
	vector2(-2505.1279296875, 2925.8510742188),
	vector2(-2511.9401855469, 2948.1372070313),
	vector2(-2540.7653808594, 3062.1232910156),
	vector2(-2451.263671875, 2894.58984375),
	vector2(-2452.7565917969, 2895.0131835938),
	vector2(-2472.03515625, 2906.2412109375),
	vector2(-2500.7170410156, 2922.8806152344),
	vector2(-2504.7517089844, 2925.4284667969),
	vector2(-2447.4375, 2893.4514160156),
	vector2(-2444.5744628906, 2893.5739746094),
	vector2(-2441.48828125, 2894.4692382813),
	vector2(-2432.4704589844, 2901.1018066406),
	vector2(-2405.2834472656, 2924.81640625),
	vector2(-2347.3459472656, 2937.3488769531),
	vector2(-2366.4428710938, 2936.6840820313),
	vector2(-2384.9624023438, 2932.9694824219),
	vector2(-2394.2145996094, 2929.8752441406),
	vector2(-2400.0805664063, 2927.4689941406),
	vector2(-2403.8896484375, 2925.6047363281),
	vector2(-2265.0705566406, 2910.9140625),
	vector2(-2208.8764648438, 2873.9733886719),
	vector2(-2184.8447265625, 2859.8569335938),
	vector2(-2154.6325683594, 2842.3012695313),
	vector2(-2145.5703125, 2825.015625),
	vector2(-2162.7438964844, 2847.2788085938),
	vector2(-1833.3122558594, 2764.9157714844),
	vector2(-1806.8673095703, 2804.4113769531),
	vector2(-1721.1116943359, 2812.7775878906),
	vector2(-1683.2105712891, 2876.6577148438),
	vector2(-1656.087890625, 2912.2661132813),
	vector2(-1701.8264160156, 3099.2006835938),
	vector2(-1669.3220214844, 3233.2834472656),
	vector2(-1966.6597900391, 3395.9858398438),
	vector2(-2045.3325195313, 3338.0024414063),
	vector2(-2171.3969726563, 3380.8659667969),
	vector2(-2266.6838378906, 3381.6938476563),
	vector2(-2346.83984375, 3445.5988769531)
}, {
	name="BatalhaoExercito",
	--minZ = 32.551086425781,
	--maxZ = 42.44246673584
})

zoneBatalhaoExercito:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "exercito")
end)

local zoneMilicia2 = PolyZone:Create({
	vector2(-3030.6142578125, 1468.212890625),
	vector2(-3052.173828125, 1489.0959472656),
	vector2(-3193.5588378906, 1395.1536865234),
	vector2(-3215.9250488281, 1275.6787109375),
	vector2(-3185.7751464844, 1268.7517089844),
	vector2(-3161.0576171875, 1309.0850830078),
	vector2(-3106.9936523438, 1329.5635986328),
	vector2(-3082.2800292969, 1392.0988769531)
}, {
	name="Milicia",
	--minZ = 16.206886291504,
	--maxZ = 38.908874511719
})

zoneMilicia2:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "milicia")
end)

local zoneHospicio = PolyZone:Create({
	vector2(1308.1477050781, 1079.0838623047),
	vector2(1300.0736083984, 1211.5152587891),
	vector2(1305.8452148438, 1211.8854980469),
	vector2(1319.3397216797, 1194.1906738281),
	vector2(1395.49609375, 1194.6130371094),
	vector2(1481.1416015625, 1194.2282714844),
	vector2(1504.2521972656, 1185.8840332031),
	vector2(1509.318359375, 1176.2080078125),
	vector2(1520.6190185547, 1099.0715332031),
	vector2(1518.9759521484, 1042.3572998047),
	vector2(1516.0759277344, 1034.5402832031),
	vector2(1513.3474121094, 1031.0329589844),
	vector2(1504.5128173828, 1025.9927978516),
	vector2(1498.2553710938, 1025.208984375),
	vector2(1461.3660888672, 1025.8306884766),
	vector2(1440.1838378906, 1026.2570800781),
	vector2(1395.0975341797, 1033.0771484375),
	vector2(1389.271484375, 1113.1589355469),
	vector2(1314.3383789063, 1093.0372314453)
}, {
	name="hospicio2",
	--minZ = 105.64600372314,
	--maxZ = 114.76952362061
})

zoneHospicio:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "hospicio")
end)

local zonePCC = PolyZone:Create({
	vector2(-24.785139083862, 946.39849853516),
	vector2(-26.396863937378, 954.93328857422),
	vector2(-46.371250152588, 954.35437011719),
	vector2(-41.789833068848, 983.45104980469),
	vector2(-45.973751068115, 999.6552734375),
	vector2(-72.916931152344, 1032.4516601563),
	vector2(-80.893447875977, 1036.6667480469),
	vector2(-105.71104431152, 1038.8471679688),
	vector2(-139.54238891602, 1035.8638916016),
	vector2(-145.25880432129, 1031.8948974609),
	vector2(-159.43055725098, 1033.4979248047),
	vector2(-161.62976074219, 1027.1704101563),
	vector2(-248.61801147461, 1027.0190429688),
	vector2(-248.61958312988, 1001.1117553711),
	vector2(-242.63592529297, 994.97979736328),
	vector2(-229.77635192871, 972.95159912109),
	vector2(-215.41287231445, 962.69927978516),
	vector2(-202.77352905273, 943.35284423828),
	vector2(-196.890625, 943.96221923828),
	vector2(-190.45104980469, 933.10522460938),
	vector2(-189.80450439453, 912.29089355469),
	vector2(-191.20994567871, 900.44909667969),
	vector2(-189.63252258301, 876.07092285156),
	vector2(-184.70620727539, 869.02239990234),
	vector2(-181.4781036377, 852.71954345703),
	vector2(-165.44342041016, 851.66326904297),
	vector2(-145.31925964355, 856.98803710938),
	vector2(-122.71499633789, 840.93627929688),
	vector2(-117.07350158691, 833.94201660156),
	vector2(-110.74649810791, 817.80853271484),
	vector2(-68.431503295898, 790.74835205078),
	vector2(-51.293182373047, 774.32788085938),
	vector2(-42.684494018555, 771.13604736328),
	vector2(-31.280687332153, 784.97344970703),
	vector2(-39.606967926025, 816.24078369141),
	vector2(-34.200229644775, 821.60101318359),
	vector2(-40.352592468262, 830.6484375),
	vector2(-41.570934295654, 839.89074707031),
	vector2(-42.304492950439, 846.02117919922)
}, {
	name="PCC",
	--minZ = 219.62995910645,
	--maxZ = 234.7975769043
})

zonePCC:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "pcc")
end)

local zoneFranca = PolyZone:Create({
	vector2(1259.6784667969, -756.09790039063),
	vector2(1267.5291748047, -762.21508789063),
	vector2(1274.7659912109, -764.27471923828),
	vector2(1283.7462158203, -765.99163818359),
	vector2(1297.5145263672, -774.30383300781),
	vector2(1315.0184326172, -780.01947021484),
	vector2(1332.4877929688, -786.94207763672),
	vector2(1344.5684814453, -793.41088867188),
	vector2(1358.5288085938, -797.69360351563),
	vector2(1371.5895996094, -798.82684326172),
	vector2(1388.7161865234, -796.82928466797),
	vector2(1408.8243408203, -788.07348632813),
	vector2(1417.2946777344, -781.63110351563),
	vector2(1422.9987792969, -775.34197998047),
	vector2(1425.6805419922, -771.04425048828),
	vector2(1430.7858886719, -755.53491210938),
	vector2(1436.2933349609, -755.57672119141),
	vector2(1435.5233154297, -766.84759521484),
	vector2(1447.3403320313, -767.96459960938),
	vector2(1448.3657226563, -764.74475097656),
	vector2(1453.5393066406, -764.73516845703),
	vector2(1446.8302001953, -770.00134277344),
	vector2(1442.7950439453, -803.73083496094),
	vector2(1443.2176513672, -804.79034423828),
	vector2(1462.2530517578, -806.75769042969),
	vector2(1460.6370849609, -811.10687255859),
	vector2(1465.0784912109, -813.01733398438),
	vector2(1464.5208740234, -816.85229492188),
	vector2(1470.6090087891, -817.97772216797),
	vector2(1478.7276611328, -817.0888671875),
	vector2(1478.7495117188, -821.53503417969),
	vector2(1488.8090820313, -822.16705322266),
	vector2(1489.2177734375, -816.06420898438),
	vector2(1494.9307861328, -816.07873535156),
	vector2(1495.0026855469, -818.13403320313),
	vector2(1500.5710449219, -818.31658935547),
	vector2(1500.6672363281, -821.98468017578),
	vector2(1510.9691162109, -822.17858886719),
	vector2(1511.2176513672, -820.11712646484),
	vector2(1518.7962646484, -819.83740234375),
	vector2(1518.8332519531, -810.52972412109),
	vector2(1523.6468505859, -810.03479003906),
	vector2(1527.5946044922, -808.56018066406),
	vector2(1535.2484130859, -815.95538330078),
	vector2(1542.2601318359, -809.18933105469),
	vector2(1534.5701904297, -801.89312744141),
	vector2(1552.4288330078, -801.83868408203),
	vector2(1552.4038085938, -806.39764404297),
	vector2(1562.5727539063, -807.08215332031),
	vector2(1572.8228759766, -805.29901123047),
	vector2(1570.865234375, -795.11669921875),
	vector2(1576.5032958984, -801.20153808594),
	vector2(1582.5961914063, -795.81304931641),
	vector2(1576.9689941406, -789.08251953125),
	vector2(1591.4786376953, -791.18103027344),
	vector2(1593.3872070313, -779.33782958984),
	vector2(1586.7864990234, -777.43017578125),
	vector2(1586.8363037109, -771.52911376953),
	vector2(1583.3308105469, -771.24395751953),
	vector2(1583.3924560547, -764.89129638672),
	vector2(1578.4658203125, -764.18218994141),
	vector2(1579.3575439453, -751.69378662109),
	vector2(1600.8538818359, -752.42999267578),
	vector2(1601.5454101563, -736.09124755859),
	vector2(1588.6815185547, -735.54736328125),
	vector2(1588.8052978516, -728.67413330078),
	vector2(1587.375, -728.77069091797),
	vector2(1587.3443603516, -718.47833251953),
	vector2(1589.0994873047, -718.654296875),
	vector2(1589.7105712891, -711.37524414063),
	vector2(1598.1185302734, -711.76287841797),
	vector2(1598.625, -706.07281494141),
	vector2(1606.8421630859, -706.45520019531),
	vector2(1607.3934326172, -698.81042480469),
	vector2(1609.6700439453, -698.8974609375),
	vector2(1610.1059570313, -688.40026855469),
	vector2(1606.0145263672, -688.16491699219),
	vector2(1606.3267822266, -682.20672607422),
	vector2(1610.5734863281, -682.42327880859),
	vector2(1611.3135986328, -675.28070068359),
	vector2(1610.2332763672, -674.859375),
	vector2(1610.2664794922, -669.44854736328),
	vector2(1604.4100341797, -669.11688232422),
	vector2(1604.6501464844, -664.62872314453),
	vector2(1606.4699707031, -664.65576171875),
	vector2(1606.7995605469, -656.25872802734),
	vector2(1603.509765625, -655.96136474609),
	vector2(1603.7352294922, -651.63610839844),
	vector2(1606.1263427734, -651.77972412109),
	vector2(1606.5318603516, -646.34558105469),
	vector2(1607.0270996094, -638.81134033203),
	vector2(1597.6765136719, -638.32232666016),
	vector2(1597.9854736328, -630.55316162109),
	vector2(1587.7001953125, -629.40130615234),
	vector2(1587.7487792969, -625.52014160156),
	vector2(1585.8386230469, -625.33575439453),
	vector2(1585.7360839844, -619.5966796875),
	vector2(1577.8669433594, -619.17864990234),
	vector2(1578.3087158203, -611.51776123047),
	vector2(1572.8022460938, -611.06408691406),
	vector2(1572.8675537109, -609.26812744141),
	vector2(1566.142578125, -608.994140625),
	vector2(1563.0228271484, -610.32611083984),
	vector2(1553.1560058594, -609.90954589844),
	vector2(1538.9387207031, -609.33129882813),
	vector2(1538.8298339844, -610.4970703125),
	vector2(1524.4835205078, -609.92059326172),
	vector2(1524.041015625, -615.79406738281),
	vector2(1512.8299560547, -615.21673583984),
	vector2(1512.8928222656, -613.83447265625),
	vector2(1504.9539794922, -613.18328857422),
	vector2(1505.4547119141, -609.18664550781),
	vector2(1494.7396240234, -608.58923339844),
	vector2(1494.0084228516, -620.19256591797),
	vector2(1491.0749511719, -619.98254394531),
	vector2(1490.7371826172, -623.13342285156),
	vector2(1478.0942382813, -622.62347412109),
	vector2(1477.4434814453, -632.60565185547),
	vector2(1482.6806640625, -632.99310302734),
	vector2(1476.4637451172, -637.51007080078),
	vector2(1471.5541992188, -630.68182373047),
	vector2(1462.4376220703, -636.85858154297),
	vector2(1458.9035644531, -633.11724853516),
	vector2(1450.0393066406, -641.13153076172),
	vector2(1446.0223388672, -636.86547851563),
	vector2(1440.580078125, -642.12805175781),
	vector2(1441.8552246094, -643.32153320313),
	vector2(1431.7249755859, -653.59460449219),
	vector2(1434.1812744141, -656.21813964844),
	vector2(1431.46484375, -658.84100341797),
	vector2(1424.5035400391, -652.36077880859),
	vector2(1424.3862304688, -648.45910644531),
	vector2(1418.0946044922, -645.34155273438),
	vector2(1416.9171142578, -646.55548095703),
	vector2(1412.0455322266, -644.6142578125),
	vector2(1408.9689941406, -651.49468994141),
	vector2(1404.2138671875, -649.25537109375),
	vector2(1397.8295898438, -662.46838378906),
	vector2(1394.9389648438, -661.35552978516),
	vector2(1393.37109375, -663.29278564453),
	vector2(1382.2729492188, -660.90502929688),
	vector2(1384.1390380859, -652.16363525391),
	vector2(1373.4443359375, -649.81195068359),
	vector2(1372.1104736328, -657.79699707031),
	vector2(1365.4796142578, -656.50762939453),
	vector2(1365.8029785156, -654.78912353516),
	vector2(1360.9476318359, -653.48358154297),
	vector2(1361.6097412109, -650.50384521484),
	vector2(1351.4329833984, -648.13366699219),
	vector2(1350.8575439453, -650.13342285156),
	vector2(1344.6691894531, -648.49243164063),
	vector2(1346.9976806641, -638.27630615234),
	vector2(1335.1727294922, -635.22131347656),
	vector2(1332.9295654297, -643.60162353516),
	vector2(1322.9495849609, -640.67883300781),
	vector2(1322.2650146484, -643.00439453125),
	vector2(1314.8542480469, -641.05310058594),
	vector2(1313.7409667969, -644.1181640625),
	vector2(1304.8641357422, -642.24365234375),
	vector2(1304.0341796875, -645.3505859375),
	vector2(1298.2526855469, -645.02197265625),
	vector2(1297.7973632813, -648.51245117188),
	vector2(1302.8837890625, -663.31964111328),
	vector2(1305.90234375, -669.01953125),
	vector2(1305.9405517578, -677.20611572266),
	vector2(1304.2924804688, -685.13732910156),
	vector2(1301.8726806641, -693.36773681641),
	vector2(1296.8265380859, -705.66363525391),
	vector2(1288.3588867188, -723.3515625),
	vector2(1283.1468505859, -731.67401123047),
	vector2(1277.5638427734, -739.60668945313),
	vector2(1270.5892333984, -747.40222167969),
	vector2(1265.5638427734, -752.05999755859)
}, {
	name="Franca",
	--minZ = 61.843639373779,
	--maxZ = 151.4278717041
})

zoneFranca:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "franca")
end)

local zoneMafia = PolyZone:Create({
	vector2(-1884.5627441406, 1991.9050292969),
	vector2(-1911.2064208984, 1997.5656738281),
	vector2(-1942.91015625, 2040.1042480469),
	vector2(-1907.6749267578, 2097.2783203125),
	vector2(-1860.0277099609, 2081.978515625),
	vector2(-1852.6993408203, 2052.0654296875),
	vector2(-1876.6331787109, 2022.5391845703),
	vector2(-1853.9583740234, 2066.1254882813),
	vector2(-1852.4453125, 2069.3352050781),
	vector2(-1854.5874023438, 2074.6904296875),
	vector2(-1860.2281494141, 2080.396484375),
	vector2(-1889.0268554688, 2093.6193847656),
	vector2(-1874.4642333984, 2092.4052734375)
}, {
	name="Mafia",
	--minZ = 140.62118530273,
	--maxZ = 153.87869262695
})

zoneMafia:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "mafia")
end)

local zoneBratva = PolyZone:Create({
	vector2(-2652.6232910156, 1348.4221191406),
	vector2(-2652.0869140625, 1328.9809570313),
	vector2(-2651.6818847656, 1323.2897949219),
	vector2(-2651.9924316406, 1299.6551513672),
	vector2(-2651.7475585938, 1273.7081298828),
	vector2(-2651.5485839844, 1238.5933837891),
	vector2(-2672.2338867188, 1238.2686767578),
	vector2(-2684.5466308594, 1238.6164550781),
	vector2(-2685.9411621094, 1348.0361328125)
}, {
	name="Bratva",
	--minZ = 131.18362426758,
	--maxZ = 151.30073547363
})

zoneBratva:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "bratva")
end)

local zoneInglaterra = PolyZone:Create({
	vector2(-1452.5025634766, 64.718894958496),
	vector2(-1454.9974365234, 95.499298095703),
	vector2(-1454.5268554688, 109.48870849609),
	vector2(-1454.8194580078, 121.49855041504),
	vector2(-1454.2890625, 130.36497497559),
	vector2(-1452.8555908203, 143.94873046875),
	vector2(-1447.7091064453, 153.67211914063),
	vector2(-1435.0795898438, 179.96862792969),
	vector2(-1417.3433837891, 201.59938049316),
	vector2(-1418.7697753906, 219.27432250977),
	vector2(-1458.2954101563, 249.07572937012),
	vector2(-1496.5286865234, 202.8289642334),
	vector2(-1560.9567871094, 161.59376525879),
	vector2(-1657.9219970703, 113.06809234619),
	vector2(-1650.9584960938, 99.919090270996),
	vector2(-1614.7045898438, 74.970123291016),
	vector2(-1567.2626953125, 56.553779602051),
	vector2(-1520.5391845703, 55.919063568115)
}, {
	name="inglaterraoficial",
	--minZ = 52.025844573975,
	--maxZ = 66.673408508301
})

zoneInglaterra:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "inglaterra")
end)

local zoneMotoclube = PolyZone:Create({
	vector2(935.91241455078, -117.96033477783),
	vector2(947.85986328125, -133.20964050293),
	vector2(949.6650390625, -140.67633056641),
	vector2(983.22094726563, -161.52105712891),
	vector2(986.35003662109, -157.22700500488),
	vector2(992.06689453125, -151.66729736328),
	vector2(1001.6983032227, -157.68246459961),
	vector2(999.80139160156, -160.67074584961),
	vector2(1006.3753051758, -165.37489318848),
	vector2(1008.1556396484, -162.40835571289),
	vector2(1022.6447753906, -170.52203369141),
	vector2(1060.7509765625, -132.87405395508),
	vector2(1061.1903076172, -132.02558898926),
	vector2(1029.7398681641, -113.04955291748),
	vector2(980.51190185547, -75.372749328613)
}, {
	name="motoclub3",
	--minZ = 71.857963562012,
	--maxZ = 78.06714630127
})

zoneMotoclube:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "motoclube")
end)

local zoneVanilla = PolyZone:Create({
	vector2(73.7431640625, 6471.1171875),
	vector2(81.683448791504, 6477.912109375),
	vector2(123.81085205078, 6519.9331054688),
	vector2(131.71496582031, 6526.9731445313),
	vector2(133.72010803223, 6531.220703125),
	vector2(134.35508728027, 6536.8115234375),
	vector2(131.95498657227, 6542.8637695313),
	vector2(116.52060699463, 6558.6293945313),
	vector2(94.299423217773, 6580.9477539063),
	vector2(88.746475219727, 6585.4321289063),
	vector2(79.03581237793, 6595.0004882813),
	vector2(75.556510925293, 6596.8095703125),
	vector2(69.433891296387, 6594.2006835938),
	vector2(11.714340209961, 6535.9555664063),
	vector2(10.507604598999, 6534.3569335938)
}, {
	name="vanilla3",
	--minZ = 31.317472457886,
	--maxZ = 31.480504989624
})

zoneVanilla:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "vanilla")
end)

local zoneColombia = PolyZone:Create({
	vector2(-847.36010742188, 203.23999023438),
	vector2(-850.08795166016, 200.21987915039),
	vector2(-854.66094970703, 148.1378326416),
	vector2(-854.68371582031, 136.13304138184),
	vector2(-799.73089599609, 138.60060119629),
	vector2(-765.91540527344, 134.19465637207),
	vector2(-758.61206054688, 139.60575866699),
	vector2(-759.90924072266, 155.82234191895),
	vector2(-761.89288330078, 166.34071350098),
	vector2(-764.28356933594, 178.8102722168),
	vector2(-766.01141357422, 189.97396850586),
	vector2(-770.08538818359, 196.66049194336)
}, {
	name="colombia3",
	--minZ = 59.210033416748,
	--maxZ = 75.608528137207
})

zoneColombia:onPlayerInOut(function(naZona, _)
	vSERVER.setInZone(naZona, "colombia")
end)

local block_limbo = false
RegisterCommand("limbo",function(source,args,rawCommand) 
    if block_limbo then
        return TriggerEvent("Notify","negado","Voce ja usou esse comando ou ja passou o tempo para usar, caso queira usar novamente. Relogue!")
    end
    block_limbo = true

    local ped = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    if #(vec3(x,y,z) - vec(-0.01, -0.01, -0.32)) <= 20.0 then
        SetEntityCoordsNoOffset(ped,362.37, 298.25, 103.88,0,0,1)
        return
    end

    local groundCheckHeights = { 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,800.0,850.0,900.0,950.0,1000.0,1050.0,1100.0,1150.0,1200.0,1250.0,1300.0,1350.0,1400.0,1450.0,1500.0,1850.0,1900.0 }
    for i,height in ipairs(groundCheckHeights) do
        SetEntityCoordsNoOffset(ped,x,y,height,0,0,1)
        RequestCollisionAtCoord(x,y,z)
        while not HasCollisionLoadedAroundEntity(ped) do
            RequestCollisionAtCoord(x,y,z)
            Citizen.Wait(1)
        end
        Citizen.Wait(20)
        ground,z = GetGroundZFor_3dCoord(x,y,height)
        if ground then
            z = z + 1.0
            groundFound = true
            break;
        end
    end

    if not groundFound then
        z = 1200
    end
    RequestCollisionAtCoord(x,y,z)
    while not HasCollisionLoadedAroundEntity(ped) do
        RequestCollisionAtCoord(x,y,z)
        Citizen.Wait(1)
    end
    SetEntityCoordsNoOffset(ped,x,y,z,0,0,1)
end)

CreateThread(function()
    Wait(10000)
    TriggerEvent("Notify","importante","Caso esteja no limbo digite o comando /limbo, para sair dele.", 60000)

    SetTimeout(60000, function()
        block_limbo = true
    end)
end)

RegisterNetEvent("Admin:ChoseColor",function(Data)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    if IsEntityAVehicle(vehicle) then  
        SetVehicleModColor_1(vehicle,tonumber(Data[1]),tonumber(Data[2]),tonumber(Data[3]))
        SetVehicleModColor_2(vehicle,tonumber(Data[1]),tonumber(Data[2]),tonumber(Data[3]))
        SetVehicleCustomPrimaryColour(vehicle,tonumber(Data[1]),tonumber(Data[2]),tonumber(Data[3]))
        SetVehicleCustomSecondaryColour(vehicle,tonumber(Data[1]),tonumber(Data[2]),tonumber(Data[3]))
    end
end)

function src.getVehicleName(vehicle)
	local vehicleEntity = NetworkGetEntityFromNetworkId(vehicle)
	local vehicleName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicleEntity))
	return vehicleName
end

function src.inDomination()
	return exports.dominacao:inDomination() or exports.dm_module:inDomination() or exports.nova_dominacao_pistol:inDomination()
end

local hudStatus = true
CreateThread(function()
	while true do
		if IsPauseMenuActive() and hudStatus then
			TriggerEvent('flaviin:toggleHud', false)
			hudStatus = false
		elseif not IsPauseMenuActive() and not hudStatus then
			TriggerEvent('flaviin:toggleHud', true)
			hudStatus = true
		end
		Wait(1000)
	end
end)

RegisterNetEvent('abrircapo', function()
	ExecuteCommand("capo")
end)

RegisterCommand('SDAIASDIJ', function()
	TriggerEvent("CHECK_DBG_STR", 'TriggerServerEvent')
end)

local inZoneDisableCollision = false

local zoneRuaBC = PolyZone:Create({
	vector2(564.57458496094, 258.25140380859),
	vector2(497.45977783203, 67.277191162109),
	vector2(179.71324157715, 180.58432006836),
	vector2(8.6768102645874, 243.06973266602),
	vector2(-102.66213226318, 237.72259521484),
	vector2(-169.20422363281, 238.68383789063),
	vector2(-284.31921386719, 245.04922485352),
	vector2(-362.89935302734, 224.51037597656),
	vector2(-428.63482666016, 224.8994140625),
	vector2(-559.69586181641, 240.73362731934),
	vector2(-547.54467773438, 272.59317016602),
	vector2(-550.89190673828, 451.46319580078),
	vector2(-148.34674072266, 449.80572509766),
	vector2(208.78303527832, 396.91311645508)
}, {
	name="ruabc",
	--minZ = 82.765808105469,
	--maxZ = 114.41422271729
})

zoneRuaBC:onPlayerInOut(function(naZona, _)
    inZoneDisableCollision = naZona
end)

local zoneVermelho = PolyZone:Create({
	vector2(60.500499725342, -1004.2694702148),
	vector2(135.00151062012, -783.62432861328),
	vector2(12.016539573669, -739.15893554688),
	vector2(-236.79264831543, -648.15704345703),
	vector2(-321.68807983398, -640.85168457031),
	vector2(-653.86474609375, -643.04235839844),
	vector2(-654.05932617188, -855.76800537109),
	vector2(-483.07437133789, -848.48480224609),
	vector2(-366.1242980957, -856.03430175781),
	vector2(-282.55139160156, -874.34149169922)
}, {
	name="vermelho",
	--minZ = 24.836532592773,
	--maxZ = 34.606246948242
})
  
zoneVermelho:onPlayerInOut(function(naZona, _)
    inZoneDisableCollision = naZona
end)

CreateThread(function()
    while true do
        local timeDistance = 1000
        if inZoneDisableCollision then
            timeDistance = 0
            local ped = PlayerPedId()
            local vehList = GetGamePool('CVehicle')
            for k,v in pairs(vehList) do
                SetEntityNoCollisionEntity(v, ped, true)
                if IsPedInAnyVehicle(ped) then
                    local veh = GetVehiclePedIsIn(ped)
                    if veh ~= v then
                        SetEntityNoCollisionEntity(v, veh, true)
                    end
                end
            end
        end
        Wait(timeDistance)
    end
end)

local zonesInPerimeter = {}
local perimeterBlips = {}
local centerBlips = {}
local inPerimeter = nil

function src.createPerimeter(userId, coords)
    zonesInPerimeter[tostring(userId)] = { coords = coords }
	
	perimeterBlips[tostring(userId)] = AddBlipForRadius(coords[1], coords[2], coords[3], 250.0)
	SetBlipSprite(perimeterBlips[tostring(userId)], 9)
	SetBlipColour(perimeterBlips[tostring(userId)], 1)
	SetBlipAlpha(perimeterBlips[tostring(userId)], 100)
	
	centerBlips[tostring(userId)] = AddBlipForCoord(coords[1], coords[2], coords[3])
	SetBlipSprite(centerBlips[tostring(userId)], 161)
	SetBlipColour(centerBlips[tostring(userId)], 1)
	SetBlipScale(centerBlips[tostring(userId)], 0.8)
	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Perímetro")
    EndTextCommandSetBlipName(centerBlips[tostring(userId)])
end

function src.removePerimeter(userId)
    zonesInPerimeter[tostring(userId)] = nil
	
	if DoesBlipExist(perimeterBlips[tostring(userId)]) then
		RemoveBlip(perimeterBlips[tostring(userId)])
		perimeterBlips[tostring(userId)] = nil
	end
	
	if DoesBlipExist(centerBlips[tostring(userId)]) then
		RemoveBlip(centerBlips[tostring(userId)])
		centerBlips[tostring(userId)] = nil
	end
end

CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for k,v in pairs(zonesInPerimeter) do
			if #(coords - v.coords) < 250.0 then
				if inPerimeter ~= k then
					TriggerEvent('Notify', 'aviso', 'Você entrou em uma área de código 10, por favor, saia da área para evitar problemas.')
					inPerimeter = k
				end
			else
				if inPerimeter == k then
					inPerimeter = nil
				end
			end
		end
		Wait(1000)
	end
end)

CreateThread(function()
	local _GetEntityModel = GetEntityModel
	while true do
	if _GetEntityModel(PlayerPedId()) == GetHashKey("CS_TaosTranslator") then
	local ped = PlayerPedId()
	ClearPedTasksImmediately(ped)
	RemoveAllPedWeapons(ped)
	SetEntityCoords(ped,0.0,0.0,0.0)
	SetEntityVisible(ped,false, false)
	end
	Wait(0)
	end
	end)

local vtrs = {
    "WRCorolla", "WRl200", "WRpajero", "WRpajero", "WRranger23", "WRstorm", "coach",
    "WRtrailblazer22", "wrr1200pm", "WRas350", "wrcorolla", "WRranger23", "wrl200",
    "wrtrailblazer22", "wrduster22", "wrr1200pm", "WRxt660", "wrjettapm",
    "Wrtrailblazer22", "wrranger23", "wrl200", "wrc7", "WRtrailblazer22",
    "wrpurosanguepm", "WRas350", "WRranger23ebc", "WRranger23eb", "WR5ton",
    "WR5ton", "wrr1200eb", "wrgt3pol", "haitun", "uh1exercito", "WRranger23",
    "WRtrailblazer22", "caveiraopmerj", "wrlc500bope", "WRas350", "wrtiger1200mct",
    "wrlc500mct", "wrm3g80mct", "wrbmwg05mct", "wrtrxmct", "wrbell407mct",
    "WRranger23", "WRl200", "WRtrailblazer22", "wrm3chq", "wrr1200pm", "WRas350",
    "wrer34nfed", "wrblindadoramfed", "wrcorollafed", "wrtrailfed", "wrl200fed",
    "wrcb500fed", "wrpolicebfed", "wrtrail1200fed", "wri8fed", "wrjeep",
    "wrtiger1200fed", "wrpurosanguefed", "wrgt3pol", "wrf850pol", "wrx7pf",
    "wras350fed", "WRtrailblazerprf", "WRL200PRF", "WRcruzeprf", "WRprfcamaro19",
    "WRranger21", "WRgtrprf", "WRr1200prf", "WRas350prf", "WRCorolla", "WRl200",
    "WRpajero", "WRranger23", "WRtrailblazer22", "WRstorm", "wrr1200pm", "WRas350",

    "WRxreparamedico", "WRsw4", "WRsprinter22", "WRas350samu",
    "WRsprinter22cbm", "WR21hiluxcbm", "WRsw4cbm", "bigr1200", "firetruk",
    "wrdinghy", "WRas350cbm", "WRvelar", "r34pw", "wrflatbedpr",
    "wrtrxmecpr", "wrflatbedrace", "speedobg", "wrtrxmecred", "wrflatbedred",
    "wrflatbeddeb", "wrtrxmecdeb", "wrtrxmecrace", "polmavbg"
}

function isVehicleVtr(vehicle)
    if not vehicle or vehicle == 0 then return false end
    
    for _, vtr in ipairs(vtrs) do
        if GetEntityModel(vehicle) == GetHashKey(vtr) then
            return true
        end
    end

    return false
end

CreateThread(function()
    local lastVehicleCheck = nil
    
    while true do
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        
        if vehicle and vehicle > 0 and vehicle ~= lastVehicleCheck and isVehicleVtr(vehicle) and GetPedInVehicleSeat(vehicle, -1) == ped then
            if not vSERVER.checkUserIsCop() then
                TaskLeaveVehicle(ped, vehicle, 4160)
                TriggerEvent('Notify', 'aviso', 'Você precisa ser um policial em serviço para entrar em uma viatura')
			else
				lastVehicleCheck = vehicle
			end
        end
        
        Wait(1000)
    end
end)


RegisterNetEvent('checkIsInDomination', function()
	print('status dominacao', (exports.dm_module:inDomination() or exports.dominacao:inDomination()))
	if exports.dm_module:inDomination() or exports.dominacao:inDomination() then
		SetEntityCoords(PlayerPedId(), 218.87,-808.39,30.7)
	end
end)

local cooldownMecanico = 0

function DrawText3DVeh(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)

    if onScreen then
        local width = 0.12
        local height = 0.03
        local boxX = _x
        local boxY = _y + 0.012

        DrawRect(boxX, boxY, width, height, 0, 0, 0, 150)

        SetTextScale(0.4, 0.4)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextCentre(1)
        SetTextEntry("STRING")
        AddTextComponentString("[~g~E~w~] - CHAMAR MECÂNICO")
        DrawText(_x, _y)
    end
end

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local vehicles = GetGamePool("CVehicle")
        local closestVehicle = nil
        local closestDistance = 10.0
        local sleepTime = 1000

        for _, vehicle in ipairs(vehicles) do
            local vehicleCoords = GetEntityCoords(vehicle)
            local distance = #(playerCoords - vehicleCoords)

            if distance < 10.0 then
                local engineHealth = GetVehicleEngineHealth(vehicle)
                local bodyHealth = GetVehicleBodyHealth(vehicle)

                if engineHealth <= 0 or bodyHealth < 300 or IsEntityOnFire(vehicle) then
                    if distance < closestDistance then
                        closestVehicle = vehicle
                        closestDistance = distance
                    end
                end
            end
        end

        if closestVehicle then
            local vehicleCoords = GetEntityCoords(closestVehicle)
            DrawText3DVeh(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z + 1.2, "[E] - CHAMAR MECÂNICO")
            sleepTime = 0

            if IsControlJustReleased(0, 38) and GetGameTimer() > cooldownMecanico then
                cooldownMecanico = GetGameTimer() + (1000 * 60)
                TriggerServerEvent("hub:sendCallType", nil, "mecanico", "Meu veículo está danificado, preciso de um mecânico.")
            end
        end

        Wait(sleepTime)
    end
end)

local inAutoPilot = false

function startAutoPilot()
    local ped = PlayerPedId()
    if not IsPedInAnyVehicle(ped, false) then
        TriggerEvent('Notify', 'aviso', 'Você não está em um veículo')
        return false
    end

    local blip = GetFirstBlipInfoId(8)
    if not DoesBlipExist(blip) then
        TriggerEvent('Notify', 'aviso', 'Não há um destino definido')
        return false
    end

    local veh = GetVehiclePedIsIn(ped, false)
    if not veh or veh == 0 then
        TriggerEvent('Notify', 'erro', 'Erro ao detectar o veículo')
        return false
    end

    local bCoords = GetBlipCoords(blip)
    ClearPedTasks(ped)

    TaskVehicleDriveToCoord(ped, veh, bCoords.x, bCoords.y, bCoords.z, 500.0, 0, veh, 1074528293, 0, true)
    SetDriveTaskDrivingStyle(ped, 1074528293)
    inAutoPilot = true

    CreateThread(function()
        while inAutoPilot do
            Wait(250)
            
            if not IsPedInAnyVehicle(ped, false) then
                stopAutoPilot()
                return
            end

            local pedCoords = GetEntityCoords(ped)
            if #(pedCoords - bCoords) <= 35.0 then
                TriggerEvent('Notify', 'sucesso', 'Piloto automático chegou ao destino')
                stopAutoPilot()
            end
        end
    end)

    return true
end

function stopAutoPilot()
    if not inAutoPilot then return false end

    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        local veh = GetVehiclePedIsIn(ped, false)
        if veh and veh ~= 0 then
            ClearPedTasks(ped)
            SetVehicleHandbrake(veh, true)
			Wait(1000)
            SetVehicleHandbrake(veh, false)
        end
    end

    inAutoPilot = false
    return true
end

local allowedVehicles = {
	[GetHashKey('xplaid24c')] = true,
	[GetHashKey('cybciv')] = true,
}

RegisterCommand('pilotoautomatico', function()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped, false)
	if not vehicle or vehicle == 0 then
		return
	end

    if not vSERVER.checkAutoPilotPermission() then
        TriggerEvent('Notify', 'aviso', 'Você não tem permissão para usar o piloto automático')
        return
    end

    if inAutoPilot then
        if stopAutoPilot() then
            TriggerEvent('Notify', 'sucesso', 'Piloto automático desativado com sucesso')
        end
    else
        if startAutoPilot() then
            TriggerEvent('Notify', 'sucesso', 'Piloto automático ativado com sucesso')
        end
    end
end)

local rgbAtivo = false

RegisterCommand('rgb', function(source, args, rawCommand)
    local player = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(player, false)

    if vehicle == 0 then
        return
    end

    if not vSERVER.checkRGBPermission() then
        return
    end

    rgbAtivo = not rgbAtivo

    if rgbAtivo then
        TriggerEvent('Notify', 'sucesso', 'RGB ativado!')

        CreateThread(function()
            local hue = 0 

            while rgbAtivo do
                if GetVehiclePedIsIn(player, false) ~= vehicle then
                    rgbAtivo = false
                    break
                end

                local r, g, b = HSVtoRGB(hue, 1, 1)
                
                SetVehicleCustomPrimaryColour(vehicle, r, g, b)
                SetVehicleCustomSecondaryColour(vehicle, r, g, b)

                hue = (hue + 1) % 360 

                Wait(20)
            end
        end)
    else
        TriggerEvent('Notify', 'aviso', 'RGB desativado!')
    end
end)

function HSVtoRGB(h, s, v)
    local c = v * s
    local x = c * (1 - math.abs((h / 60) % 2 - 1))
    local m = v - c
    local r, g, b = 0, 0, 0

    if h < 60 then
        r, g, b = c, x, 0
    elseif h < 120 then
        r, g, b = x, c, 0
    elseif h < 180 then
        r, g, b = 0, c, x
    elseif h < 240 then
        r, g, b = 0, x, c
    elseif h < 300 then
        r, g, b = x, 0, c
    else
        r, g, b = c, 0, x
    end

    return math.floor((r + m) * 255), math.floor((g + m) * 255), math.floor((b + m) * 255)
end