local inService = false
local systemHacked = false
local Player = {
	npcs = {},
	vehicle = false,
	allPedsDies = false,
	happenExplosion = false,
	indexRobbery = nil,
	approached = false,
    entitysCreated = false
}

CreateThread(function ()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
        for k,v in pairs (Config.initeRobbery) do
            local distance = #(coords - v.coords)
            if not inService and not UsingComputer and not systemHacked then
                if distance <= v.distance then
                    idle = 5
                    DrawMarker(21,v.coords[1],v.coords[2],v.coords[3],0,0,0,0,180.0,130.0,1.0,1.0,0.5, 25,140,255,180 ,1,0,0,1)
                    if distance <= 2 then
                        drawTxt("Pressione ~g~E~w~ para iniciar o assalto.",4,0.5,0.935,0.50,255,255,255,155)
                        if IsControlJustPressed(0, 38) then
                            SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
                            if not IsPedInAnyVehicle(ped) then
                                Brute()
                            end
                        end
                    end
                end
            end
    
            if distance <= v.distance and not inService and systemHacked then
                idle = 5
                DrawMarker(21,v.coords[1],v.coords[2],v.coords[3],0,0,0,0,180.0,130.0,1.0,1.0,0.5, 25,140,255,180 ,1,0,0,1)
                if distance <= 2 then
                    drawTxt("Pressione ~g~E~w~ para localizar o carro forte.",4,0.5,0.935,0.50,255,255,255,155)
                    if IsControlJustPressed(0, 38) then
                        if not IsPedInAnyVehicle(ped) then
                            if systemHacked then
                                local avaliableRobbery,indexRobbery = vSERVER.initeRobbery()
                                if avaliableRobbery then
                                    inService = true
                                    Wait(2000)
                                    Player:startThread(indexRobbery)
                                    TriggerEvent("Notify","sucesso","Você hackeou o sistema do carro forte e conseguiu localizar, marcamos ele em seu GPS!",5)
                                else
                                	TriggerEvent("Notify","negado","Não foi possível encontrar nenhum carro forte disponível no momento, tente novamente mais tarde.")
                                end
                            end
                        end
                    end
                end
            end

        end
		Wait(idle)
	end
end)

local peds = {}
local countKills = 0

function Player:startThread(indexRobbery)
	self.indexRobbery = indexRobbery
    local notified = false
	CreateThread(function ()
		while inService do
			local idle = 1000
			local ped = PlayerPedId()
			local plyCoords = GetEntityCoords(ped)
			local vehCoords = GetEntityCoords(Player.vehicle)
            local coordsIndexed = Config.randomJobs[indexRobbery].initeSpawn
			local distVehMain = #(plyCoords - vec3(coordsIndexed[1],coordsIndexed[2],coordsIndexed[3]))
			local distVehReal = #(plyCoords - vehCoords)
            local distAlternate = GetDistanceBetweenCoords(vehCoords[1], vehCoords[2], vehCoords[3], 0, 0, 0, false)

            if not notified then
                if DoesBlipExist(blips) then 
                    RemoveBlip(blips) 
                end
            end

            if self.approached then
                createBlip(vehCoords)
            elseif not notified and not self.approached then
                createBlip(coordsIndexed)
                vSERVER._alertPolices(coordsIndexed)
                notified = true
                print("Loading entitys...")
            end

            if not self.entitysCreated then
				if distVehMain <= 200 then
                    self:createVehicleSync(indexRobbery)
					self.entitysCreated = true
                    print("Entidades criadas")
				end
			end

			if not self.approached then
				if distVehMain <= 250 then
					self.approached = true
					TriggerEvent("Notify","sucesso","Você se aproximou do carro forte, aborde os seguranças!",5)
                    --FreezeEntityPosition(self.vehicle,false)
                    notified = false
				end
			end

			if GetEntityHealth(ped) <= 101 then
				self:finishRobbery(false)
				TriggerEvent("Notify","importante","Você entrou em coma e não pode finalizar o roubo.",5)
			end

			if self.approached then
                if distAlternate > 5 then
                    if distVehReal >= Config.maxDist then
                        self:finishRobbery(false)
                        TriggerEvent("Notify","importante","Você se distanciou de mais do carro forte e o perdeu de vista!",5)
                    end
                end
			end

			if not self.allPedsDies then
				for k,v in pairs(self.npcs) do
					if not peds[v] then
						if GetEntityHealth(v) <= 0 then
							peds[v] = true
							countKills = countKills + 1
                            print("ped setado como morto")
						end
					end
				end
				if countKills >= #Config.randomJobs[indexRobbery].peds then
					self.allPedsDies = true
					TriggerEvent("Notify","sucesso","Você finalizou todos os seguranças, agora exploda o cofre do veículo!",5)
				end
			end

			if self.allPedsDies then
				local d1 = GetModelDimensions(GetEntityModel(self.vehicle))
				local veh_pos = GetOffsetFromEntityInWorldCoords(self.vehicle, 0.0,d1["y"]+0.60,0.0)
				local distVeh = #(vec3(veh_pos.x, veh_pos.y, veh_pos.z) - plyCoords)
				if distVeh < 5.0 and not self.happenExplosion then
					idle = 1
					DrawText3Ds(veh_pos.x, veh_pos.y, veh_pos.z,"Pressione ~b~G~w~ para posicionar o explosivo.")
					if IsControlJustPressed(1, 47) then 
						self:openBackDoorsVehicle()
					end
				end

			end

			if self.happenExplosion then
				local d1 = GetModelDimensions(GetEntityModel(self.vehicle))
				local veh_pos = GetOffsetFromEntityInWorldCoords(self.vehicle, 0.0,d1["y"]+0.60,0.0)
				local distVeh = #(vec3(veh_pos.x, veh_pos.y, veh_pos.z) - plyCoords)
				if distVeh < 5.0 then
					idle = 1
					DrawText3Ds(veh_pos.x, veh_pos.y, veh_pos.z,"Pressione ~b~G~w~ para pegar o dinheiro.")
					if IsControlJustPressed(1, 47) then
						self:getMoneyOffVehicle()
					end
				end
			end

			Wait(idle)
		end

	end)
end

RegisterKeyMapping('CancelRobberyCar', 'Cancelar o roubo ao carro forte', 'keyboard', 'F7')
RegisterCommand('CancelRobberyCar', function()
	if inService then
		Player:finishRobbery(false)
        TriggerEvent("Notify","importante","Você finalizou o serviço!",5)
	end
end)

function Player:finishRobbery(payment)

    local tableReturnPeds = {}
    for k,v in pairs (self.npcs) do
        table.insert(tableReturnPeds,PedToNet(v))
    end

	vSERVER._deleteEntitys(VehToNet(self.vehicle),tableReturnPeds,self.indexRobbery)

	inService = false

	Player.npcs = {}
	Player.vehicle = false
	Player.allPedsDies = false
	Player.happenExplosion = false
	Player.indexRobbery = nil
	Player.approached = false

	peds = {}
	countKills = 0
    systemHacked = false

	RemoveBlip(blips)

	if payment then
		vSERVER._finishRobberyPayment()
	end

end

function Player:getMoneyOffVehicle()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local moneyBag = CreateObject(GetHashKey('prop_cs_heist_bag_02'), coords[1], coords[2],coords[3], true, true, true)

	AttachEntityToEntity(moneyBag, ped, GetPedBoneIndex(ped, 57005), 0.0, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)

	vRP.playAnim(true,{{"anim@heists@ornate_bank@grab_cash_heels", "grab"}},true)

	FreezeEntityPosition(ped, true)

	TriggerEvent("progress",Config.timeExplosion,"Roubando")
	Citizen.Wait((Config.timeLoot * 1000))
	
	vRP.stopAnim(false)

	DeleteEntity(moneyBag)
	ClearPedTasks(ped)
	FreezeEntityPosition(ped, false)
	SetPedComponentVariation(ped, 5, 45, 0, 2)

	self:finishRobbery(true)
end

function Player:openBackDoorsVehicle()
	if IsVehicleStopped(self.vehicle) then
		local ped = PlayerPedId()

		local x,y,z = table.unpack(GetEntityCoords(ped))
		local itemC4prop = CreateObject(GetHashKey('prop_c4_final_green'), x, y, z+0.2,  true,  true, true)
		AttachEntityToEntity(itemC4prop, ped, GetPedBoneIndex(ped, 60309), 0.06, 0.0, 0.06, 90.0, 0.0, 0.0, true, true, false, true, 1, true)
		SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"),true)
		
		Wait(500)

		FreezeEntityPosition(ped, true)

		vRP.playAnim(false,{{'anim@heists@ornate_bank@thermal_charge_heels', "thermal_charge"}},true)

		Wait(5500)
		
		local doorPside = GetEntityBoneIndexByName(self.vehicle, 'door_pside_r')

		ClearPedTasks(ped)
		DetachEntity(itemC4prop)
		AttachEntityToEntity(itemC4prop, self.vehicle, doorPside, -0.7, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
		FreezeEntityPosition(ped, false)
		vRP.stopAnim(false)

		TriggerEvent("progress",Config.timeExplosion,"Explosão")
		Wait(Config.timeExplosion*1000)

		local coordsC4 = GetWorldPositionOfEntityBone(self.vehicle, doorPside)
		SetVehicleDoorBroken(self.vehicle, 2, false)
		SetVehicleDoorBroken(self.vehicle, 3, false)

		AddExplosion(coordsC4[1], coordsC4[2], coordsC4[3], 'EXPLOSION_TANKER', 2.0, true, false, 2.0)

		ApplyForceToEntity(self.vehicle, 0, coordsC4[1], coordsC4[2], coordsC4[3], 0.0, 0.1, 0.0, doorPside, false, true, false, false, true)
		DeleteEntity(itemC4prop)


		self.happenExplosion = true
	end
end

function Player:createVehicleSync(indexRobbery)
    local coords = Config.randomJobs[indexRobbery].initeSpawn
    local tableNpcs = {}

    RequestModel(Config.randomJobs[indexRobbery].vehicle)

    while not HasModelLoaded(Config.randomJobs[indexRobbery].vehicle) do
        RequestModel(Config.randomJobs[indexRobbery].vehicle)
        Wait(0)
    end

    local veh = CreateVehicle(GetHashKey(Config.randomJobs[indexRobbery].vehicle),coords[1],coords[2],coords[3],coords[4], true, true, true)

    self.vehicle = veh

	Wait(1000)

    CreateThread(function()
		
		while not DoesEntityExist(veh) do
            print("Buscando VEH")
			Wait(100)
		end

	end)

    print("VEH encontrado")

	NetworkRegisterEntityAsNetworked(self.vehicle)
	SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(self.vehicle), true)
	SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(self.vehicle), true)
	SetVehicleHasBeenOwnedByPlayer(self.vehicle, true)
	SetEntityAsMissionEntity(self.vehicle, true, true)
	SetVehicleDoorsLockedForAllPlayers(self.vehicle, true)
	SetVehicleIsStolen(self.vehicle, false)
	SetVehicleIsWanted(self.vehicle, false)
	SetVehicleFuelLevel(self.vehicle, 80.0)
	SetVehRadioStation(self.vehicle, 'OFF')
	DecorSetFloat(self.vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(self.vehicle))
	SetVehicleOnGroundProperly(self.vehicle)
	SetVehicleNumberPlateText(self.vehicle, "CLIENT")
    
    --FreezeEntityPosition(self.vehicle,true)
    Wait(1000)

    --[ CREATION PEDS ]--

    for k,v in pairs (Config.randomJobs[indexRobbery].peds) do

        RequestModel(v.model)

        while not HasModelLoaded(v.model) do
            RequestModel(v.model)
            Wait(0)
        end

        local NPC = CreatePedInsideVehicle(veh, 1,GetHashKey(v.model), v.seat, true, true)
        CreateThread(function()
    --	
            while not DoesEntityExist(NPC) do
                print("Buscando ped")
                Wait(1)
            end
        
            print(NPC,"PED ENCONTRADO")

            --[ SETS ITENS SERVER ON PED ]--
            GiveWeaponToPed(NPC,GetHashKey(Config.randomJobs[indexRobbery].weapon), 250, false, true)


            NetworkRegisterEntityAsNetworked(NPC)
            SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(NPC), true)
            SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(NPC), true)
            SetPedFleeAttributes(NPC, 0, false)
            SetPedCombatAttributes(NPC, 46, 1)
            SetPedCombatAbility(NPC, 100)
            SetPedCombatMovement(NPC, 2)
            SetPedCombatRange(NPC, 2)
            SetPedKeepTask(NPC, true) 
            SetPedAsCop(NPC, true)
            SetPedDropsWeaponsWhenDead(NPC, false)
            SetPedArmour(NPC, 100)
            SetPedAccuracy(NPC, Config.randomJobs[indexRobbery].accuracy)
            SetEntityInvincible(NPC, false)
            SetEntityVisible(NPC, true)
            SetEntityAsMissionEntity(NPC)

            table.insert(tableNpcs,NPC)

            --[ TASK DRIVE VEHICLES ]--
            
            if v.seat == -1 then
                if self.vehicle > 0 then
                    local ped = GetPedInVehicleSeat(veh,-1)
                    if ped > 0 then
                        TaskVehicleDriveWander(ped, veh, 50.0, 443)
                        print(ped,self.vehicle,"Set Driving")
                    end
                end
            end

        end)
    end

    --[ TABLE MANAGEMENT NPCS ]--

    self.npcs = tableNpcs
    print("Orientação de NPCS Criada")

    --[ REGISTER ENTITYS ON SERVER ]--

    local tableReturnPeds = {}
    for k,v in pairs (self.npcs) do
        table.insert(tableReturnPeds,PedToNet(v))
    end
 
    vSERVER._registerEntitys(VehToNet(self.vehicle),tableReturnPeds,self.indexRobbery)
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

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function createBlip(coords)
	blips = AddBlipForCoord(coords[1],coords[2],coords[3])
	SetBlipSprite(blips,1)
	SetBlipColour(blips,1)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Carro forte")
	EndTextCommandSetBlipName(blips)
end

--[ SISTEMA HACKING ]--

local RouletteWords = {
    "ABSOLUTE",
    "ISTANBUL",
    "SUPERHOT",
    "DOCTRINE",
    "IMPERIUS",
    "DELIRIUM",
    "MAETHRIL"
}

Citizen.CreateThread(function()
    function Initialize(scaleform)
        startScaleForm()
        local scaleform = RequestScaleformMovieInteractive(scaleform)
        while not HasScaleformMovieLoaded(scaleform) do
            Citizen.Wait(0)
        end

        local CAT = 'hack'
        local CurrentSlot = 0
        while HasAdditionalTextLoaded(CurrentSlot) and not HasThisAdditionalTextLoaded(CAT, CurrentSlot) do
            Citizen.Wait(0)
            CurrentSlot = CurrentSlot + 1
        end

        if not HasThisAdditionalTextLoaded(CAT, CurrentSlot) then
            ClearAdditionalText(CurrentSlot, true)
            RequestAdditionalText(CAT, CurrentSlot)
            while not HasThisAdditionalTextLoaded(CAT, CurrentSlot) do
                Citizen.Wait(0)
            end
        end
        PushScaleformMovieFunction(scaleform, "SET_LABELS")
        ScaleformLabel("H_ICON_1")
        ScaleformLabel("H_ICON_2")
        ScaleformLabel("H_ICON_3")
        ScaleformLabel("H_ICON_4")
        ScaleformLabel("H_ICON_5")
        ScaleformLabel("H_ICON_6")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_BACKGROUND")
        PushScaleformMovieFunctionParameterInt(1)
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
        PushScaleformMovieFunctionParameterFloat(1.0)
        PushScaleformMovieFunctionParameterFloat(4.0)
        PushScaleformMovieFunctionParameterString("My Computer")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
        PushScaleformMovieFunctionParameterFloat(6.0)
        PushScaleformMovieFunctionParameterFloat(6.0)
        PushScaleformMovieFunctionParameterString("Power Off")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_LIVES")
        PushScaleformMovieFunctionParameterInt(lives)
        PushScaleformMovieFunctionParameterInt(5)
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(1)
        PushScaleformMovieFunctionParameterInt(math.random(160,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(2)
        PushScaleformMovieFunctionParameterInt(math.random(170,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(3)
        PushScaleformMovieFunctionParameterInt(math.random(190,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(4)
        PushScaleformMovieFunctionParameterInt(math.random(200,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(5)
        PushScaleformMovieFunctionParameterInt(math.random(210,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(6)
        PushScaleformMovieFunctionParameterInt(math.random(220,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(7)
        PushScaleformMovieFunctionParameterInt(255)
        PopScaleformMovieFunctionVoid()
        return scaleform
    end
    scaleform = Initialize("HACKING_PC")
    while true do
        local idle = 1000
        if UsingComputer then
            idle = 1
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            PushScaleformMovieFunction(scaleform, "SET_CURSOR")
            PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 239))
            PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 240))
            PopScaleformMovieFunctionVoid()

            if IsDisabledControlJustPressed(0,24) and not SorF then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT_SELECT")
                ClickReturn = PopScaleformMovieFunction()
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            elseif IsDisabledControlJustPressed(0, 176) and Hacking then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT_SELECT")
                ClickReturn = PopScaleformMovieFunction()
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            elseif IsDisabledControlJustPressed(0, 25) and not Hacking and not SorF then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT_BACK")
                PopScaleformMovieFunctionVoid()
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            elseif IsDisabledControlJustPressed(0, 172) and Hacking then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT")
                PushScaleformMovieFunctionParameterInt(8)
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            elseif IsDisabledControlJustPressed(0, 173) and Hacking then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT")
                PushScaleformMovieFunctionParameterInt(9)
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            elseif IsDisabledControlJustPressed(0, 174) and Hacking then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT")
                PushScaleformMovieFunctionParameterInt(10)
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            elseif IsDisabledControlJustPressed(0, 175) and Hacking then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT")
                PushScaleformMovieFunctionParameterInt(11)
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            end
        end
        Citizen.Wait(idle)
    end
end)

function Brute()
    scaleform = Initialize("HACKING_PC")
    UsingComputer = true
end
function ScaleformLabel(label)
    BeginTextCommandScaleformString(label)
    EndTextCommandScaleformString()
end

function startScaleForm()
    Ipfinished = false
    Hacking = false
    hackfinish = false
    systemHacked = false
    SorF = false
    lives = 5
    Citizen.CreateThread(function()
        while UsingComputer do
            if HasScaleformMovieLoaded(scaleform) and UsingComputer then
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 25, true)
    
                if GetScaleformMovieFunctionReturnBool(ClickReturn) then
                    program = GetScaleformMovieFunctionReturnInt(ClickReturn)
                    if program == 82 and not Hacking and not Ipfinished then
                        lives = 5
                        PushScaleformMovieFunction(scaleform, "SET_LIVES")
                        PushScaleformMovieFunctionParameterInt(lives)
                        PushScaleformMovieFunctionParameterInt(5)
                        PopScaleformMovieFunctionVoid()
    
                        PushScaleformMovieFunction(scaleform, "OPEN_APP")
                        PushScaleformMovieFunctionParameterFloat(0.0)
                        PopScaleformMovieFunctionVoid()
                        Hacking = true
                        TriggerEvent("Notify","importante","Encontre o endereço de IP...")
    
                    elseif program == 83 and not Hacking and Ipfinished then
                        PushScaleformMovieFunction(scaleform, "SET_LIVES")
                        PushScaleformMovieFunctionParameterInt(lives)
                        PushScaleformMovieFunctionParameterInt(5)
                        PopScaleformMovieFunctionVoid()
    
                        PushScaleformMovieFunction(scaleform, "OPEN_APP")
                        PushScaleformMovieFunctionParameterFloat(1.0)
                        PopScaleformMovieFunctionVoid()
    
                        PushScaleformMovieFunction(scaleform, "SET_ROULETTE_WORD")
                        PushScaleformMovieFunctionParameterString(RouletteWords[math.random(#RouletteWords)])
                        PopScaleformMovieFunctionVoid()
    
                        Hacking = true
                        TriggerEvent("Notify","importante","Encontre a senha...")
                    elseif Hacking and program == 87 then
                        lives = lives - 1
                        PushScaleformMovieFunction(scaleform, "SET_LIVES")
                        PushScaleformMovieFunctionParameterInt(lives)
                        PushScaleformMovieFunctionParameterInt(5)
                        PopScaleformMovieFunctionVoid()
                        PlaySoundFrontend(-1, "HACKING_CLICK_BAD", "", false)
                    elseif Hacking and program == 84 then
                        PlaySoundFrontend(-1, "HACKING_SUCCESS", "", true)
                        PushScaleformMovieFunction(scaleform, "SET_IP_OUTCOME")
                        PushScaleformMovieFunctionParameterBool(true)
                        ScaleformLabel(0x18EBB648)
                        PopScaleformMovieFunctionVoid()
                        PushScaleformMovieFunction(scaleform, "CLOSE_APP")
                        PopScaleformMovieFunctionVoid()
                        Hacking = false
                        Ipfinished = true
    					hackmethod = 2
                    elseif Hacking and program == 85 then
                        PlaySoundFrontend(-1, "HACKING_FAILURE", "", false)
                        PushScaleformMovieFunction(scaleform, "CLOSE_APP")
                        PopScaleformMovieFunctionVoid()
                        Hacking = false
                        SorF = false
                    elseif Hacking and program == 86 then
                        SorF = true
                        PlaySoundFrontend(-1, "HACKING_SUCCESS", "", true)
                        PushScaleformMovieFunction(scaleform, "SET_ROULETTE_OUTCOME")
                        PushScaleformMovieFunctionParameterBool(true)
                        ScaleformLabel("WINBRUTE")
                        PopScaleformMovieFunctionVoid()
                        Wait(0)
                        PushScaleformMovieFunction(scaleform, "CLOSE_APP")
                        PopScaleformMovieFunctionVoid()
                        Hacking = false
                        SorF = false
                        SetScaleformMovieAsNoLongerNeeded(scaleform)
                        DisableControlAction(0, 24, false)
                        DisableControlAction(0, 25, false)
                        FreezeEntityPosition(PlayerPedId(), false)
    					hackfinish = true
                        systemHacked = true
                        if hackmethod == 1 then
                            UsingComputer = false
                            hackfinish = true
                            Ipfinished = false
                        elseif hackmethod == 2 then
                            UsingComputer = false
                            Ipfinished = false
                            hackfinish = true
                        end
                    elseif program == 6 then
                        UsingComputer = false
                        hackfinish = true
                        SetScaleformMovieAsNoLongerNeeded(scaleform)
                        DisableControlAction(0, 24, false)
                        DisableControlAction(0, 25, false)
                        FreezeEntityPosition(PlayerPedId(), false)
                    end
    
                    if Hacking then
                        PushScaleformMovieFunction(scaleform, "SHOW_LIVES")
                        PushScaleformMovieFunctionParameterBool(true)
                        PopScaleformMovieFunctionVoid()
                        if lives <= 0 then
                            SorF = true
                            PlaySoundFrontend(-1, "HACKING_FAILURE", "", true)
                            PushScaleformMovieFunction(scaleform, "SET_ROULETTE_OUTCOME")
                            PushScaleformMovieFunctionParameterBool(false)
                            ScaleformLabel("LOSEBRUTE")
                            PopScaleformMovieFunctionVoid()
                            Wait(1000)
                            PushScaleformMovieFunction(scaleform, "CLOSE_APP")
                            PopScaleformMovieFunctionVoid()
                            Hacking = false
                            SorF = false
                        end
                    end
                end
            end
            Wait(0)
        end
    end)
end