local cart = {["total"] = 0}

function OpenBennysUI()
	nuiBennys = true
    SetNuiFocus(true,true)
    SendNUIMessage({ action = 'open'})
	SendNUIMessage({ action = 'update', data = { balance = 0 }} )
end

function CloseBennysUI()
	nuiBennys = false
    SetNuiFocus(false,false)
    SendNUIMessage({ action = 'close'})
	cart = {["total"] = 0}
end

function buyAttributes(myVeh,vehicle)
	if cart["total"] then
		local infos = {}
		local mPlaca,mName = vRP.ModelName(5)
		table.insert(infos,{ parseInt(cart["total"]),mName,mPlaca,myVeh })

		if vSERVER.saveAttribute(infos) then
			if not IsPedInAnyVehicle(PlayerPedId()) then
				vRP.playAnim(false,{{"mini@repair","fixing_a_player"}},true)
			end

			SetVehicleFuelLevel(vehicle,100.0)

			CloseNui()
		end
	end
end

function hasNeonKit(veh)
	for i = 0, 3 do 
		if not IsVehicleNeonLightEnabled(veh,i) then 
			return false 
		end 
	end 
	return true
end

function getColorType(color)
	for k, v in pairs(Config.Bennys.modsIndex.colors) do
        for i, j in pairs(v) do
            if j == color then
                return k
            end
        end
    end
    return false
end

function currentVehicleMods(veh)
	local myVeh = {}
	myVeh.vehicle = veh
	myVeh.model = GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower()
	myVeh.color =  table.pack(GetVehicleColours(veh))
	myVeh.customPcolor = table.pack(GetVehicleCustomPrimaryColour(veh))
	myVeh.customScolor = table.pack(GetVehicleCustomSecondaryColour(veh))
	myVeh.extracolor = table.pack(GetVehicleExtraColours(veh))
	myVeh.neon = hasNeonKit(veh)
	myVeh.neoncolor = table.pack(GetVehicleNeonLightsColour(veh))
	myVeh.xenoncolor = GetVehicleHeadlightsColour(veh)
	myVeh.smokecolor = table.pack(GetVehicleTyreSmokeColor(veh))
	myVeh.plateindex = GetVehicleNumberPlateTextIndex(veh)
	myVeh.pcolortype = getColorType(myVeh.color[1])
	myVeh.scolortype = getColorType(myVeh.color[2])
	myVeh.mods = {}
    for i = 0, 48 do
        myVeh.mods[i] = { mod = GetVehicleMod(veh, i) }
        if i == 22 or i == 18 then
            myVeh.mods[i].mod = IsToggleModOn(veh, i) and 1 or 0
        elseif i == 23 or i == 24 then
            myVeh.mods[i].variation = GetVehicleModVariation(veh, i)
        end
    end

    myVeh.windowtint = GetVehicleWindowTint(veh)
    myVeh.xenoncolor = myVeh.xenoncolor > 12 or myVeh.xenoncolor < -1 and -1 or myVeh.xenoncolor
    myVeh.wheeltype = GetVehicleWheelType(veh)
    myVeh.bulletProofTyres = GetVehicleTyresCanBurst(veh)
    myVeh.damage = (1000 - GetVehicleBodyHealth(veh)) / 100

    return myVeh
end

function setVehicleMods(veh,myVeh,tunnerChip) 
	SetVehicleModKit(veh,0)
	if not myVeh or not myVeh.customPcolor then
		return
	end
	local bug = false
	local primary = myVeh.color[1]
	local secondary = myVeh.color[2]
	local cprimary = myVeh.customPcolor
	if cprimary['1'] then
		bug = true
	end
	local csecondary = myVeh.customScolor
	local perolado = myVeh.extracolor[1]
	local wheelcolor = myVeh.extracolor[2]
	local neoncolor = myVeh.neoncolor
	local smokecolor = myVeh.smokecolor
	ClearVehicleCustomPrimaryColour(veh)
	ClearVehicleCustomSecondaryColour(veh)
	SetVehicleWheelType(veh,myVeh.wheeltype)
	SetVehicleColours(veh,primary,secondary)
	if bug then
		SetVehicleCustomPrimaryColour(veh,cprimary['1'],cprimary['2'],cprimary['3'])
		SetVehicleCustomSecondaryColour(veh,csecondary['1'],csecondary['2'],csecondary['3'])
	else
		SetVehicleCustomPrimaryColour(veh,cprimary[1],cprimary[2],cprimary[3])
		SetVehicleCustomSecondaryColour(veh,csecondary[1],csecondary[2],csecondary[3])
	end
	SetVehicleExtraColours(veh,perolado,wheelcolor)
	SetVehicleNeonLightsColour(veh,neoncolor[1],neoncolor[2],neoncolor[3])
	SetVehicleXenonLightsColour(veh,myVeh.xenoncolor)
	SetVehicleNumberPlateTextIndex(veh,myVeh.plateindex)
	SetVehicleWindowTint(veh,myVeh.windowtint)
	for i,t in pairs(myVeh.mods) do 
		if tonumber(i) == 22 or tonumber(i) == 18 then
			if t.mod > 0 then
				ToggleVehicleMod(veh,tonumber(i),true)
			else
				ToggleVehicleMod(veh,tonumber(i),false)
			end
		elseif tonumber(i) == 20 then
			local r,g,b = parseInt(smokecolor[1]),parseInt(smokecolor[2]),parseInt(smokecolor[3])
			ToggleVehicleMod(veh,Config.Bennys.modsIndex["smoke"],true)
			SetVehicleTyreSmokeColor(veh,r,g,b)
		elseif tonumber(i) == 23 or tonumber(i) == 24 then
			SetVehicleMod(veh,tonumber(i),tonumber(t.mod),tonumber(t.variation))
		else
			SetVehicleMod(veh,tonumber(i),tonumber(t.mod))
		end
	end
	SetVehicleTyresCanBurst(veh,myVeh.bulletProofTyres)

	for i = 0, 3 do
		SetVehicleNeonLightEnabled(veh,i,myVeh.neon and true or false)
	end

	-- if myVeh.damage > 0 then
	-- 	SetVehicleBodyHealth(veh,myVeh.damage)
	-- end
end

function RGBToHex(rgb)
	local hexadecimal = '#'
    for _, value in ipairs(rgb) do
        local hex = string.format('%02X', math.min(math.max(value, 0), 255))
        hexadecimal = hexadecimal .. hex
    end
    return hexadecimal
end

function isWheelType(type)
    local wtype = Config.Bennys.modsIndex.wheelTypes[type]
    local currentWheel = GetVehicleMod(vehicle, Config.Bennys.modsIndex.dianteira)
    local bool = false
    if GetVehicleWheelType(vehicle) == wtype then
        bool = true
    end
    SetVehicleWheelType(vehicle, wtype)
    local num = GetNumVehicleMods(vehicle, Config.Bennys.modsIndex.dianteira)
    SetVehicleWheelType(vehicle, currentWheel)
    return bool, currentWheel, num
end

function applyAttribute(data, vehicle, myVeh)
    print(json.encode(data))
    if data then
        if string.find(data.category, "vidro") then
            local tint = tonumber(data.key)
            SetVehicleWindowTint(vehicle, tint)
            updateBalance(myVeh, "vidro", tint)
		elseif string.find(data.category, "farol") then
			if data.category == "farol,cor" then
				local colorindex = parseInt(data.key)
				SetVehicleXenonLightsColour(vehicle,colorindex)
			else 
				SetVehicleLights(vehicle,2)
				if data.key == "xenon" then
					ToggleVehicleMod(vehicle,Config.Bennys.modsIndex["farol"],1)
					updateBalance(myVeh, Config.Bennys.modsIndex["farol"], 1)
				else
					ToggleVehicleMod(vehicle,Config.Bennys.modsIndex["farol"],0)
					updateBalance(myVeh, Config.Bennys.modsIndex["farol"], 0)
				end
			end
		elseif string.find(data.category, "turbo") then
			local turbo = parseInt(data.key)
			if turbo > 0 then
				ToggleVehicleMod(vehicle,Config.Bennys.modsIndex["turbo"],true)
			else
				ToggleVehicleMod(vehicle,Config.Bennys.modsIndex["turbo"],false)
			end
			updateBalance(myVeh, Config.Bennys.modsIndex["turbo"], turbo)
		elseif string.find(data.category, "blindagem") then
			local blindagem = parseInt(data.key)
			if blindagem then
				SetVehicleMod(vehicle,Config.Bennys.modsIndex["blindagem"],blindagem)
			end
			updateBalance(myVeh, Config.Bennys.modsIndex["blindagem"], blindagem)
		elseif string.find(data.category, "placa") then
			local type = parseInt(data.key)
			SetVehicleNumberPlateTextIndex(vehicle,type)
			updateBalance(myVeh, "placa", type)
		elseif string.find(data.category,"motor") or string.find(data.category,"freios") or string.find(data.category,"transmissão") or string.find(data.category,"suspensão") then
			local level = tonumber(data.key)
				
			SetVehicleMod(vehicle,Config.Bennys.modsIndex[data.category], level)
			updateBalance(myVeh, Config.Bennys.modsIndex[data.category], level)
		elseif string.find(data.category,"neon") then
			local type = data.key
			if type == "kit" then
				for i = 0, 3 do
					SetVehicleNeonLightEnabled(vehicle,i,true)
				end
				updateBalance(myVeh, "neon", 1)

			elseif type == "default" then
				for i = 0, 3 do
					SetVehicleNeonLightEnabled(vehicle,i,false)
				end
				updateBalance(myVeh, "neon", 0)
			end
			SetVehicleLights(vehicle,2)
		elseif string.find(data.category,"rodas") then
			if data.category == "rodas,colors" then 
				local perolado,wcolor = GetVehicleExtraColours(vehicle)
				SetVehicleExtraColours(vehicle,perolado,parseInt(data.key))
				updateBalance(myVeh, "wheelcolor", parseInt(data.key))
			elseif data.category == "rodas,accessories" then 
				local modindex = GetVehicleMod(vehicle,Config.Bennys.modsIndex["dianteira"])
				if data.key == "fabrica" then
					SetVehicleMod(vehicle,Config.Bennys.modsIndex["dianteira"],modindex,false)
					SetVehicleTyresCanBurst(vehicle,true)
					updateBalance(myVeh, data.key, 0)
				elseif data.key == "custom" then
					SetVehicleMod(vehicle,Config.Bennys.modsIndex["dianteira"],modindex,true)
					updateBalance(myVeh, data.key, 1)
				elseif data.key == "bulletproof" then
					SetVehicleTyresCanBurst(vehicle,false)
					updateBalance(myVeh, data.key, 1)
				end
			elseif string.find(data.category,"rodas,type") then 
				local typeWheel = split(data.category,",")
				print(json.encode(typeWheel))
				if (data.key == "padrao") then 
					print(Config.Bennys.modsIndex["dianteira"])
					SetVehicleMod(vehicle, Config.Bennys.modsIndex["dianteira"], -1, false)
					updateBalance(myVeh, Config.Bennys.modsIndex["dianteira"], -1)
					return 
				end
				local cfgWheel = Config.Bennys.modsIndex['wheelTypes']
				if (typeWheel[3] == "dianteira" or typeWheel[3] == "traseira") then 
					SetVehicleMod(vehicle, Config.Bennys.modsIndex[typeWheel[3]], data.key, false)
					updateBalance(myVeh, Config.Bennys.modsIndex[typeWheel[3]], data.key)
				elseif cfgWheel[typeWheel[3]] or cfgWheel[split(typeWheel[3],"-")[1]] then
					local type = cfgWheel[typeWheel[3]]
					SetVehicleWheelType(vehicle,type)
					SetVehicleMod(vehicle, Config.Bennys.modsIndex["dianteira"],data.key,false)
					updateBalance(myVeh, Config.Bennys.modsIndex["dianteira"], data.key)
				end
			end
        else
			local categoryParts = {}
            for part in data.category:gmatch("[^%-]+") do
                table.insert(categoryParts, part)
            end
            local modType = nil
			local firstPart = categoryParts[1]:gsub(",.*", "")
            if firstPart == "chassi" then
				if categoryParts[1] == "chassi,arch" then
                	modType = Config.Bennys.modsIndex["arch-cover"]
            	elseif categoryParts[1] == "chassi,doors" then
                	modType = Config.Bennys.modsIndex["doors"]
				elseif categoryParts[1] == "chassi,roll" then
                	modType = Config.Bennys.modsIndex["roll-cage"]
				end
			elseif firstPart == "interior" then
				if categoryParts[1] == "interior,ornaments" then
                	modType = Config.Bennys.modsIndex["ornaments"]
				elseif categoryParts[1] == "interior,dashboard" then
                	modType = Config.Bennys.modsIndex["dashboard"]
				elseif categoryParts[1] == "interior,dials" then
                	modType = Config.Bennys.modsIndex["dials"]
				elseif categoryParts[1] == "interior,janela" then
                	modType = Config.Bennys.modsIndex["janela"]
            	elseif categoryParts[1] == "interior,seats" then
                	modType = Config.Bennys.modsIndex["seats"]
				end
            elseif categoryParts[2] then
                modType = Config.Bennys.modsIndex[categoryParts[1].."-"..categoryParts[2]]
            else
                modType = Config.Bennys.modsIndex[categoryParts[1]]
            end
            if modType then
                SetVehicleMod(vehicle, modType, tonumber(data.key), false)
				if modType == Config.Bennys.modsIndex["buzina"] then
					StartVehicleHorn(vehicle, 5000, "HELDDOWN", true)
				end
                updateBalance(myVeh, modType, tonumber(data.key))
            end
        end
    end
end

function updateBalance(myVeh, modType, index, colorType)
	if not myVeh or not modType or not index then
        return
    end

	print(modType)
	local currentMod = (myVeh.mods[modType] and myVeh.mods[modType].mod) or modType
    local startPrice = (Config.BennysPrices[modType] and Config.BennysPrices[modType].startprice) or 0
	local increaseBy = (Config.BennysPrices[modType] and Config.BennysPrices[modType].increaseby) or 0
	
	if modType == "vidro" then 
		if cart[tostring(modType)] == nil and myVeh.windowtint ~= index and index > 0 then
			cart[tostring(modType)] = index
			cart["total"] = cart["total"] + (startPrice + increaseBy * p(index-1))
		elseif myVeh.windowtint ~= index and index > 0 then
			cart["total"] = cart["total"] - (startPrice + increaseBy * p(cart[tostring(modType)]-1))
			cart[tostring(modType)] = index
			cart["total"] = cart["total"] + (startPrice + increaseBy * p(index-1))
		elseif (index < 1 or myVeh.windowtint == index) and cart[tostring(modType)] ~= nil then
			cart["total"] = cart["total"] - (startPrice + increaseBy * p(cart[tostring(modType)]-1))
			cart[tostring(modType)] = nil
		end
	elseif modType == "cor-primaria" or modType == "cor-secundaria" then
		local type = myVeh.customPcolor
		if modType == "cor-secundaria" then
			type = myVeh.customScolor
		end

		local priceChange = 0
		if cart[tostring(modType)] == nil and index[1] ~= type[1] or index[2] ~= type[2] or index[3] ~= type[3] then
			cart[tostring(modType)] = index
        	priceChange = startPrice
		else
			priceChange = -startPrice
			cart["total"] = cart["total"] - startPrice
			cart[tostring(modType)] = nil
		end
		cart["total"] = cart["total"] + priceChange
	elseif modType == "wheelcolor" or modType == "perolado" then
		index = parseInt(index)
		local type = myVeh.extracolor[1]
		if modType == "wheelcolor" then
			type = myVeh.extracolor[2]
		end
		if cart[tostring(modType)] == nil and type ~= index and index > 0 then
			cart[tostring(modType)] = index
			cart["total"] = cart["total"] + startPrice
		elseif type ~= index and index > 0 then
			cart[tostring(modType)] = index
		elseif (index < 1 or type == index) and cart[tostring(modType)] ~= nil then
			cart["total"] = cart["total"] - startPrice
			cart[tostring(modType)] = nil
		end
	elseif modType == "primaria" or modType == "secundaria" then
		local type = myVeh.color[1]
		local vehColorType = myVeh.pcolortype
		local cartColorType = cart["pcolortype"]
		if modType == "secundaria" then
			type = myVeh.color[2]
			vehColorType = myVeh.scolortype
			cartColorType = cart["scolortype"]
		end
		if colorType and Config.BennysPrices["colortypes"][colorType] then
			local price = Config.BennysPrices["colortypes"][colorType]

			if cartColorType == nil then
				cartColorType = colorType
				cart["total"] = cart["total"] + price
			elseif colorType == vehColorType then
				local oldPrice = Config.BennysPrices["colortypes"][cartColorType]
				cart["total"] = cart["total"] - oldPrice
				cartColorType = nil
			else
				local oldPrice = Config.BennysPrices["colortypes"][cartColorType]
				cart["total"] = cart["total"] - oldPrice
				cartColorType = colorType
				cart["total"] = cart["total"] + price
			end
	
			if modType == "primaria" then
				cart["pcolortype"] = cartColorType
			else
				cart["scolortype"] = cartColorType
			end
		end
		if cart[tostring(modType)] == nil and type and index and type ~= index and index > 0 then
			cart[tostring(modType)] = index
			cart["total"] = cart["total"] + startPrice
		elseif type and index and type ~= index and index > 0 then
			cart[tostring(modType)] = index
		elseif (index < 1 or type == index) and cart[tostring(modType)] ~= nil then
			cart["total"] = cart["total"] - startPrice
			cart[tostring(modType)] = nil
		end
	elseif modType == Config.Bennys.modsIndex["turbo"] or modType == Config.Bennys.modsIndex["farol"] then
		if cart[tostring(modType)] == nil then
			if currentMod < 1 and index > 0 then
				cart[tostring(modType)] = 1
				cart["total"] = cart["total"] + startPrice
			end
		elseif cart[tostring(modType)] > 0 and index < 1 then
			cart["total"] = cart["total"] - startPrice
			cart[tostring(modType)] = nil
		end
	elseif modType == "neon" then
		if cart[tostring(modType)] == nil then
			if not myVeh.neon and index > 0 then
				cart[tostring(modType)] = 1
				cart["total"] = cart["total"] + startPrice
			end
		elseif cart[tostring(modType)] > 0 and index < 1 then
			cart["total"] = cart["total"] - startPrice
			cart[tostring(modType)] = nil
		end	
	elseif modType == "bulletproof" or modType == "custom" or modType == "fabrica" then
		if modType == "fabrica" then
			if cart["bulletproof"] ~= nil then
				cart["total"] = cart["total"] - Config.BennysPrices["bulletproof"].startprice
				cart["bulletproof"] = nil
			end
			if cart["custom"] ~= nil then
				cart["total"] = cart["total"] - Config.BennysPrices["custom"].startprice
				cart["custom"] = nil
			end
		else
			local type = not myVeh.bulletProofTyres
			if modType == "custom" then
				type = myVeh.mods[Config.Bennys.modsIndex["dianteira"]].variation
			end
			if cart[tostring(modType)] == nil then
				if not type and index > 0 then
					cart[tostring(modType)] = 1
					cart["total"] = cart["total"] + startPrice
				end
			elseif cart[tostring(modType)] > 0 and index < 1 then
				cart["total"] = cart["total"] - startPrice
				cart[tostring(modType)] = nil
			end
		end
	elseif modType == "placa" then
		if cart[tostring(modType)] == nil and myVeh.plateindex ~= index and index > 0 then
			cart[tostring(modType)] = index
			cart["total"] = cart["total"] + (startPrice + increaseBy * p(index-1))
		elseif myVeh.plateindex ~= index and index > 0 then
			cart["total"] = cart["total"] - (startPrice + increaseBy * p(cart[tostring(modType)]-1))
			cart[tostring(modType)] = index
			cart["total"] = cart["total"] + (startPrice + increaseBy * p(index-1))
		elseif (index < 1 or myVeh.plateindex == index) and cart[tostring(modType)] ~= nil then
			cart["total"] = cart["total"] - (startPrice + increaseBy * p(cart[tostring(modType)]-1))
			cart[tostring(modType)] = nil
		end
    elseif index >= 0 and currentMod ~= index then
        if cart[tostring(modType)] then
            cart["total"] = cart["total"] - (startPrice + increaseBy * cart[tostring(modType)])
        end
        cart[tostring(modType)] = index
        cart["total"] = cart["total"] + (startPrice + increaseBy * index)
    elseif index < 0 or currentMod == index then
        if cart[tostring(modType)] then
            cart["total"] = cart["total"] - (startPrice + increaseBy * cart[tostring(modType)])
            cart[tostring(modType)] = nil
        end
    end

    SendNUIMessage({ action = 'update', data = { balance = tonumber(cart["total"])}})
end

function freeCam()
	Citizen.CreateThread(function()
		SetNuiFocus(false,false)
		ResetCam()
		local freecam = true
		while freecam and nuiBennys do
			Citizen.Wait(1)
			if IsControlJustPressed(0,38) then
				freecam = false
				SetNuiFocus(true,true)
			end
		end
	end)
end
