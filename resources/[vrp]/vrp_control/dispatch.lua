local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","vrp_control")

src = {}
Tunnel.bindInterface("vrp_control",src)
vSERVER = Tunnel.getInterface("vrp_control")


local inIlhaNorte = false

local zoneIlhaNorte = PolyZone:Create({
	vector2(-657.50817871094, 6696.8461914063),
	vector2(-606.20672607422, 6602.009765625),
	vector2(-531.07873535156, 6611.3950195313),
	vector2(-392.91906738281, 6630.7416992188),
	vector2(-402.2961730957, 6825.3115234375),
	vector2(-357.21636962891, 6876.3173828125),
	vector2(-227.62260437012, 6922.2421875),
	vector2(-182.21452331543, 6819.9067382813),
	vector2(-127.14810943604, 6858.240234375),
	vector2(39.782863616943, 7697.3466796875),
	vector2(-250.18586730957, 7922.2055664063),
	vector2(-852.99749755859, 8051.0297851563),
	vector2(-1242.1810302734, 8338.921875),
	vector2(-1855.3376464844, 8495.0703125),
	vector2(-2126.134765625, 8012.6352539063),
	vector2(-2035.8084716797, 7381.8159179688),
	vector2(-1953.0100097656, 7119.794921875),
	vector2(-1992.9443359375, 6853.0341796875),
	vector2(-1954.0766601563, 6684.7509765625),
	vector2(-1783.4738769531, 6690.5556640625),
	vector2(-1581.4493408203, 6648.0737304688),
	vector2(-1439.5051269531, 6778.5419921875),
	vector2(-1085.6469726563, 6600.912109375),
	vector2(-1020.627746582, 6571.9482421875),
	vector2(-857.79595947266, 6576.6279296875)
}, {
	name="ilhanorte",
	--minZ = 5.0706887245178,
	--maxZ = 36.404754638672
})

zoneIlhaNorte:onPlayerInOut(function(naZona, _)
    inIlhaNorte = naZona
	print('status zona', inIlhaNorte)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for i = 1,120 do
		EnableDispatchService(i,false)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- NAO ATIRAR COM RADIO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
		local time = 1000
        local ped = PlayerPedId()

		if GetSelectedPedWeapon(ped) ~= -1569615261 then
			time = 5
			 
			if IsEntityPlayingAnim(ped, "random@arrests","generic_radio_enter", 3) then
				DisablePlayerFiring(PlayerId() , true)
			end
		end 

		Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
    while true do
		local time = 1000
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
			local time = 1
            local vehicle = GetVehiclePedIsIn(PlayerPedId())
            if GetPedInVehicleSeat(vehicle,-1) == ped then
                local speed = GetEntitySpeed(vehicle)*3.6
                if speed >= 130 then
                    SetPlayerCanDoDriveBy(PlayerId(),false)
                else
                    SetPlayerCanDoDriveBy(PlayerId(),true)
                end
            end
        end
		Citizen.Wait(time)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR DIRIGIVEL + NPCS 
-----------------------------------------------------------------------------------------------------------------------------------------

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
	local _NetworkGetEntityIsNetworked = NetworkGetEntityIsNetworked
	function SetTrafficDensity(density)
		SetParkedVehicleDensityMultiplierThisFrame(density)
		SetVehicleDensityMultiplierThisFrame(density)
		SetRandomVehicleDensityMultiplierThisFrame(density)
		SetVehicleModelIsSuppressed(GetHashKey("blimp"), true)
	end

	function GetAllPools()
		local pool = {}
        for k,v in ipairs(_GetGamePool("CObject")) do
			pool[v] = true
		end
		for k,v in ipairs(_GetGamePool("CVehicle")) do
			pool[v] = true
		end
		return pool
	end
    while true do
        local ped = _PlayerPedId()
        for k,v in ipairs(GetAllPools("CObject")) do
            local attachedTo = _GetEntityAttachedTo(v)
            local owner = _NetworkGetEntityOwner(v)
            if attachedTo == ped and owner ~= -1 and owner ~= 128 then
				if not entityValidate[v] then
					TriggerServerEvent("likizao_module:reportAttachViolation", ObjToNet(v))
                    entityValidate[v] = true
					vRP._setCustomization(vRP._getCustomization())
				end
				local model = _GetEntityModel(v)
                DetachEntity(v, true, true)
                DetachEntity(ped, true, true)
				SetEntityCompletelyDisableCollision(v, true, false)
                print('^1[likizao]^7 Reporte para algum staff: ','Model: '..model, 'AttachedTo: '..attachedTo, 'ArcheType', GetEntityArchetypeName(v), 'Source do Cheater:', GetPlayerServerId(NetworkGetEntityOwner(v)), 'Name:', GetPlayerName(NetworkGetEntityOwner(v)))
            -- else
                -- if _NetworkHasControlOfEntity(v) and _NetworkGetEntityIsNetworked(v) and not _IsEntityVisible(v) then
                --     _DeleteEntity(v)
                -- end
            end
        end
        SetTrafficDensity(0.0)
        _Wait(0)
    end
end)


local vehicle_weapons = {
	"VEHICLE_WEAPON_WATER_CANNON",
	"VEHICLE_WEAPON_PLAYER_LAZER",
	"VEHICLE_WEAPON_PLANE_ROCKET",
	"VEHICLE_WEAPON_ENEMY_LASER",
	"VEHICLE_WEAPON_TANK",
	"VEHICLE_WEAPON_SEARCHLIGHT",
	"VEHICLE_WEAPON_RADAR",
	"VEHICLE_WEAPON_PLAYER_BUZZARD",
	"VEHICLE_WEAPON_SPACE_ROCKET",
	"VEHICLE_WEAPON_TURRET_INSURGENT",
	"VEHICLE_WEAPON_PLAYER_SAVAGE",
	"VEHICLE_WEAPON_TURRET_TECHNICAL",
	"VEHICLE_WEAPON_NOSE_TURRET_VALKYRIE",
	"VEHICLE_WEAPON_TURRET_VALKYRIE",
	"VEHICLE_WEAPON_CANNON_BLAZER",
	"VEHICLE_WEAPON_TURRET_BOXVILLE",
	"VEHICLE_WEAPON_RUINER_BULLET",
	"VEHICLE_WEAPON_RUINER_ROCKET",
	"VEHICLE_WEAPON_HUNTER_MG",
	"VEHICLE_WEAPON_HUNTER_MISSILE",
	"VEHICLE_WEAPON_HUNTER_CANNON",
	"VEHICLE_WEAPON_HUNTER_BARRAGE",
	"VEHICLE_WEAPON_TULA_NOSEMG",
	"VEHICLE_WEAPON_TULA_MG",
	"VEHICLE_WEAPON_TULA_DUALMG",
	"VEHICLE_WEAPON_TULA_MINIGUN",
	"VEHICLE_WEAPON_SEABREEZE_MG",
	"VEHICLE_WEAPON_MICROLIGHT_MG",
	"VEHICLE_WEAPON_DOGFIGHTER_MG",
	"VEHICLE_WEAPON_DOGFIGHTER_MISSILE",
	"VEHICLE_WEAPON_MOGUL_NOSE",
	"VEHICLE_WEAPON_MOGUL_DUALNOSE",
	"VEHICLE_WEAPON_MOGUL_TURRET",
	"VEHICLE_WEAPON_MOGUL_DUALTURRET",
	"VEHICLE_WEAPON_ROGUE_MG",
	"VEHICLE_WEAPON_ROGUE_CANNON",
	"VEHICLE_WEAPON_ROGUE_MISSILE",
	"VEHICLE_WEAPON_BOMBUSHKA_DUALMG",
	"VEHICLE_WEAPON_BOMBUSHKA_CANNON",
	"VEHICLE_WEAPON_HAVOK_MINIGUN",
	"VEHICLE_WEAPON_VIGILANTE_MG",
	"VEHICLE_WEAPON_VIGILANTE_MISSILE",
	"VEHICLE_WEAPON_TURRET_LIMO",
	"VEHICLE_WEAPON_DUNE_MG",
	"VEHICLE_WEAPON_DUNE_GRENADELAUNCHER",
	"VEHICLE_WEAPON_DUNE_MINIGUN",
	"VEHICLE_WEAPON_TAMPA_MISSILE",
	"VEHICLE_WEAPON_TAMPA_MORTAR",
	"VEHICLE_WEAPON_TAMPA_FIXEDMINIGUN",
	"VEHICLE_WEAPON_TAMPA_DUALMINIGUN",
	"VEHICLE_WEAPON_HALFTRACK_DUALMG",
	"VEHICLE_WEAPON_HALFTRACK_QUADMG",
	"VEHICLE_WEAPON_APC_CANNON",
	"VEHICLE_WEAPON_APC_MISSILE",
	"VEHICLE_WEAPON_APC_MG",
	"VEHICLE_WEAPON_ARDENT_MG",
	"VEHICLE_WEAPON_TECHNICAL_MINIGUN",
	"VEHICLE_WEAPON_INSURGENT_MINIGUN",
	"VEHICLE_WEAPON_TRAILER_QUADMG",
	"VEHICLE_WEAPON_TRAILER_MISSILE",
	"VEHICLE_WEAPON_TRAILER_DUALAA",
	"VEHICLE_WEAPON_NIGHTSHARK_MG",
	"VEHICLE_WEAPON_OPPRESSOR_MG",
	"VEHICLE_WEAPON_OPPRESSOR_MISSILE",
	"VEHICLE_WEAPON_OPPRESSOR2_MG",
	"VEHICLE_WEAPON_OPPRESSOR2_MISSILE",
	"VEHICLE_WEAPON_MOBILEOPS_CANNON",
	"VEHICLE_WEAPON_AKULA_TURRET_SINGLE",
	"VEHICLE_WEAPON_AKULA_MISSILE",
	"VEHICLE_WEAPON_AKULA_TURRET_DUAL",
	"VEHICLE_WEAPON_AKULA_MINIGUN",
	"VEHICLE_WEAPON_AKULA_BARRAGE",
	"VEHICLE_WEAPON_AVENGER_CANNON",
	"VEHICLE_WEAPON_BARRAGE_TOP_MG",
	"VEHICLE_WEAPON_BARRAGE_TOP_MINIGUN",
	"VEHICLE_WEAPON_BARRAGE_REAR_MG",
	"VEHICLE_WEAPON_BARRAGE_REAR_MINIGUN",
	"VEHICLE_WEAPON_BARRAGE_REAR_GL",
	"VEHICLE_WEAPON_CHERNO_MISSILE",
	"VEHICLE_WEAPON_COMET_MG",
	"VEHICLE_WEAPON_DELUXO_MG",
	"VEHICLE_WEAPON_DELUXO_MISSILE",
	"VEHICLE_WEAPON_KHANJALI_CANNON",
	"VEHICLE_WEAPON_KHANJALI_CANNON_HEAVY",
	"VEHICLE_WEAPON_KHANJALI_MG",
	"VEHICLE_WEAPON_KHANJALI_GL",
	"VEHICLE_WEAPON_REVOLTER_MG",
	"VEHICLE_WEAPON_WATER_CANNON",
	"VEHICLE_WEAPON_SAVESTRA_MG",
	"VEHICLE_WEAPON_SUBCAR_MG",
	"VEHICLE_WEAPON_SUBCAR_MISSILE",
	"VEHICLE_WEAPON_SUBCAR_TORPEDO",
	"VEHICLE_WEAPON_THRUSTER_MG",
	"VEHICLE_WEAPON_THRUSTER_MISSILE",
	"VEHICLE_WEAPON_VISERIS_MG",
	"VEHICLE_WEAPON_VOLATOL_DUALMG"
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOQUEAR DE ATIRAR DE DENTRO DO CARRO
-----------------------------------------------------------------------------------------------------------------------------------------
local passengerDriveBy = false
AddEventHandler("gameEventTriggered",function(eventName,args)
	if eventName == "CEventNetworkPlayerEnteredVehicle" then
		if args[1] == PlayerId() then
			local ped = PlayerPedId()
			SetPedCanBeKnockedOffVehicle(PlayerPedId(), 3)
			local vehicle = args[2]
			if GetVehicleClass(vehicle) == 8 and not LocalPlayer.state.Staff then
				Citizen.CreateThread(function()
					while true do
						if IsPedInAnyVehicle(ped) then
							local vehicle = GetVehiclePedIsIn(ped)
							if (GetPedInVehicleSeat(vehicle, -1) == ped or GetPedInVehicleSeat(vehicle, 0) == ped) then
								DisableControlAction(0, 345, true)
							end
						else
							break
						end
						Citizen.Wait(5)
					end
				end)
			end
			
			Citizen.CreateThread(function()
				while true do
					local ped = PlayerPedId()
					if IsPedInAnyVehicle(ped) and not LocalPlayer.state.inEvent and not inIlhaNorte then
						local vehicle = GetVehiclePedIsIn(ped, false)
						if GetVehicleClass(vehicle) == 15 then
							SetPlayerCanDoDriveBy(PlayerId(), true)
						else
							if GetPedInVehicleSeat(vehicle, -1) == ped then
								SetPlayerCanDoDriveBy(PlayerId(), false)
							elseif passengerDriveBy then
								SetPlayerCanDoDriveBy(PlayerId(), true)
							else
								SetPlayerCanDoDriveBy(PlayerId(), false)
							end
						end
					end
					Citizen.Wait(5)
				end
			end)
			

			Citizen.CreateThread(function()
				while true do
					if IsPedInAnyVehicle(ped) and not LocalPlayer.state.inEvent then
						if DoesVehicleHaveWeapons(vehicle) then
							for _,v in next, vehicle_weapons do
								DisableVehicleWeapon(true,v, vehicle, ped)	
							end
						end
					else
						break
					end
					Citizen.Wait(10)
				end
			end)	

		end
		
	end
end)

DisableBikeWings = true --false para usar asas em bicicletas (como opressor)/true para NÃO usar
DisableVehicleJump = true  ---–-false para ativar saltos de carro/true para NÃO ativar saltos de carro (como K2000)
DisableVehicleTransform = true --false para ativar a “transformação” (deluxo por exemplo)/true para NÃO ativá-la
DisableVehicleWeapons = true --false para ativar armas de carro/true para NÃO ativá-lo

Citizen.CreateThread(function()
    while true do
		local time = 1000
        local playerped = PlayerPedId()
        local vehicle  =   GetVehiclePedIsIn(playerped, true)
        if IsPedInAnyVehicle(playerped, false) then
			time = 0
            if DisableBikeWings then
                DisableControlAction(0, 354, true)
            end

            if DisableVehicleJump then
                DisableControlAction(0, 350, true)
            end

            if DisableVehicleTransform then
                DisableControlAction(0, 357, true)
            end

            local veh = GetVehiclePedIsUsing(playerped)
            if DoesVehicleHaveWeapons(veh) == 1 and DisableVehicleWeapons and vehicleweaponhash ~= 1422046295 and not LocalPlayer.state.inEvent then
                vehicleweapon, vehicleweaponhash = GetCurrentPedVehicleWeapon(playerped)
                if vehicleweapon == 1 then
                    DisableVehicleWeapon(true, vehicleweaponhash, veh, playerped)
                    SetCurrentPedWeapon(playerped, GetHashKey("weapon_unarmed"))
                end
            end
        end
        Citizen.Wait(time)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR A CORONHADA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
		local ped = PlayerPedId()
		local idle = 1000
		if IsPedArmed(ped,6) then
			idle = 5
            DisableControlAction(0,140,true)
            DisableControlAction(0,141,true)
            DisableControlAction(0,142,true)
		end

		Citizen.Wait(idle)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- NAO RECUPERAR VIDA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
		SetPlayerHealthRechargeMultiplier(PlayerId(),0)
		Citizen.Wait(500)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- STAMINA INFINITA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		RestorePlayerStamina(PlayerId(),1.0)
        Citizen.Wait(500)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DESATIVAR WEAPONS NPCS E DROP
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if GetPlayerWantedLevel(PlayerId()) ~= 0 then
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
        end
        Citizen.Wait(3000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FICAR NO BANCO ESCOLHIDO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local total = 0
    while true do
        local time = 100
        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
                if GetIsTaskActive(GetPlayerPed(-1), 165) then
                    SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
                end
            end
        end

        Citizen.Wait(time)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ESTOURAR OS PNEUS QUANDO CAPOTA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local time = 300
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped)
            if GetPedInVehicleSeat(vehicle,-1) == ped then
				time = 100
                local roll = GetEntityRoll(vehicle)
                if (roll > 75.0 or roll < -75.0) and GetEntitySpeed(vehicle) < 2 then
                    if IsVehicleTyreBurst(vehicle, wheel_rm1, 0) == false then
						SetVehicleTyreBurst(vehicle, 0, 1)
						Citizen.Wait(100)
						SetVehicleTyreBurst(vehicle, 1, 1)
						Citizen.Wait(100)
						SetVehicleTyreBurst(vehicle, 2, 1)
						Citizen.Wait(100)
						SetVehicleTyreBurst(vehicle, 3, 1)
						Citizen.Wait(100)
						SetVehicleTyreBurst(vehicle, 4, 1)
						Citizen.Wait(100)
						SetVehicleTyreBurst(vehicle, 5, 1)
						Citizen.Wait(100)
						SetVehicleTyreBurst(vehicle, 45, 1)
						Citizen.Wait(100)
						SetVehicleTyreBurst(vehicle, 47, 1)
                    end
                end
            end
        end

		Citizen.Wait(time)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER HUD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	AddTextEntry("FE_THDR_GTAO","FIVE GROUP")
	AddTextEntry('PM_PANE_LEAVE', 'Sair')
	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE");
	SetAudioFlag("PoliceScannerDisabled",true);

	for i = 1,51 do
		if i ~= 10 and i ~= 14 and i ~= 16 and i ~= 19 then
			SetHudComponentPosition(i,  1000.0001, 1000.0001)
		end
	end
	
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.0) 
	N_0x4757f00bc6323cfe(-1553120962, 0.0) 
	while true do
		DisableControlAction(0,44,true)
		DisableControlAction(0,36,true)
		DisableControlAction(0,157,false)
		
		N_0xf4f2c0d4ee209e20()
		
		DisableVehicleDistantlights(true)
		DisablePlayerVehicleRewards(PlayerId())
		SetPedSuffersCriticalHits(PlayerPedId(), true)
			
		Citizen.Wait(5)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [ AUTO CAPACETE ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread( function()
    while true do
		local time = 1000
        
        local veh = GetVehiclePedIsUsing(PlayerPedId())
        if veh ~= 0 then 
			time = 5
            SetPedConfigFlag(PlayerPedId(),35,false) 
        end

		Citizen.Wait(time)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIFT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local time = 1000
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			time = 5
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			local speed = GetEntitySpeed(vehicle) * 2.236936
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				if speed <= 80.0 then
					if IsControlPressed(1,21) then
						SetVehicleReduceGrip(vehicle,true)
					else
						SetVehicleReduceGrip(vehicle,false)
					end
				end
			end
		end
		Citizen.Wait(time)
	end
end)

local recoil = {
	[453432689] = 0, -- PISTOL
	[3219281620] = 0, -- PISTOL MK2
	[584646201] = 0, -- AP PISTOL
	[2578377531] = 0, -- PISTOL .50
	[324215364] = 0.0, -- MICRO SMG
	[4024951519] = 0.1, -- ASSAULT SMG
	[3220176749] = 0.2, -- ASSAULT RIFLE
	[2937143193] = 0.1, -- ADVANCED RIFLE
	[2634544996] = 0.1, -- MG
	[2144741730] = 0.1, -- COMBAT MG
	[3686625920] = 0.1, -- COMBAT MG MK2
	[487013001] = 0.9, -- PUMP SHOTGUN
	[961495388] = 0.0, -- ASSAULT RIFLE MK2
	[-2084633992] = 0.0, -- CARBINE RIFLE
	[-86904375] = 0.0, -- CARBINE RIFLE MK2
	[-1768145561] = 0.0, -- SPECIAL CARBINE MK2
	[-1075685676] = 0, -- PISTOL MK2
	[1593441988] = 0, -- COMBAT PISTOL
	[-1076751822] = 0, -- SNS PISTOL
	[-771403250] = 0, -- HEAVY PISTOL
	[1432025498] = 0.9, -- PUMP SHOTGUN MK2
	[2017895192] = 0.9, -- SAWNOFF SHOTGUN
	[3800352039] = 0.4, -- ASSAULT SHOTGUN
	[2640438543] = 0.2, -- BULLPUP SHOTGUN
	[911657153] = 0.1, -- STUN GUN
	[100416529] = 0.5, -- SNIPER RIFLE
	[205991906] = 0.7, -- HEAVY SNIPER
	[177293209] = 0.6, -- HEAVY SNIPER MK2
	[856002082] = 1.2, -- REMOTE SNIPER
	[2726580491] = 1.0, -- GRENADE LAUNCHER
	[1305664598] = 1.0, -- GRENADE LAUNCHER SMOKE
	[2982836145] = 0.0, -- RPG
	[1752584910] = 0.0, -- STINGER
	[1119849093] = 0.01, -- MINIGUN
	[3218215474] = 0.2, -- SNS PISTOL
	[1627465347] = 0.1, -- GUSENBERG
	[3523564046] = 0.5, -- HEAVY PISTOL
	[2132975508] = 0.2, -- BULLPUP RIFLE
	[-619010992] = 0.3, -- MACHINE PISTOL
	[736523883] = 0.2, -- SMG
	[2024373456] = 0.2, -- SMG MK2
	[171789620] = 0.3, -- COMBAT PDW
	[-2066285827] = 0.15, -- BULLPUP RIFLE MK2
	[137902532] = 0.4, -- VINTAGE PISTOL
	[2828843422] = 0.7, -- MUSKET
	[984333226] = 0.2, -- HEAVY SHOTGUN
	[3342088282] = 0.3, -- MARKSMAN RIFLE
	[1785463520] = 0.25, -- MARKSMAN RIFLE MK2
	[1672152130] = 0, -- HOMING LAUNCHER
	[1198879012] = 0.9, -- FLARE GUN
	[3696079510] = 0.9, -- MARKSMAN PISTOL
	[1834241177] = 2.4, -- RAILGUN
	[3675956304] = 0.3, -- MACHINE PISTOL
	[3249783761] = 0.6, -- REVOLVER
	[-879347409] = 0.6, -- REVOLVER MK2
	[4019527611] = 0.7, -- DOUBLE BARREL SHOTGUN
	[1649403952] = 0.0, -- COMPACT RIFLE
	[317205821] = 0.2, -- AUTO SHOTGUN
	[125959754] = 0.5, -- COMPACT LAUNCHER
	[3173288789] = 0.1, -- MINI SMG			
	[2725352035] = 0.001, -- SOCO	
}
	------------------------------------------------------------------------------
	-- DANO POR OSSO + RECOIL CONFIG
	------------------------------------------------------------------------------
	Citizen.CreateThread(function()
		while true do
			local idle = 100
			if GetVehiclePedIsIn(PlayerPedId()) then
				if IsPedShooting(PlayerPedId()) then
					idle = 5
					local wep = GetSelectedPedWeapon(PlayerPedId())
					if recoil[wep] and recoil[wep] ~= 0 then
						Wait(0)
						p = GetGameplayCamRelativePitch()
						if not IsPedInAnyHeli(PlayerPedId()) then
							SetGameplayCamRelativePitch(p+recoil[wep], 1.2)
						end
					end
				end
			end
			
			Citizen.Wait(idle)
		end
	end)