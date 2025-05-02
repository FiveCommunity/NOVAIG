---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNAGEM
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local colors = {
	["cromado"] = { 120 },
	["metálico"] = { 0, 147, 1, 11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 27, 28, 29, 150, 30, 31, 32, 33, 34, 143, 35, 135, 137, 136, 36, 38, 138, 99, 90, 88, 89, 91, 49, 50, 51, 52, 53, 54, 92, 141, 61, 62, 63, 64, 65, 66, 67, 68, 69, 73, 70, 74, 96, 101, 95, 94, 97, 103, 104, 98, 100, 102, 99, 105, 106, 71, 72, 142, 145, 107, 111, 112 },
	["fosco"] = { 12, 13 ,14 ,131 ,83 ,82 ,84 ,149 ,148 ,39 ,40 ,41 ,42 ,55 ,128 ,151 ,155 ,152 ,153 ,154 },
	["metal"] = { 117 ,118 ,119 ,158 ,159 }
}

local mod = {
	["aerofólio"] = 0,
	["parachoque-dianteiro"] = 1,
	["parachoque-traseiro"] = 2,
	["saias"] = 3,
	["escapamento"] = 4,
	["roll-cage"] = 5,
	["grelha"] = 6,
	["capô"] = 7,
	["para-lama"] = 8,
	["teto"] = 10,
	["motor"] = 11,
	["freios"] = 12,
	["transmissão"] = 13,
	["buzina"] = 14,
	["suspensão"] = 15,
	["blindagem"] = 16,
	["turbo"] = 18,
	["smoke"] = 20,
	["farol"] = 22,
	["dianteira"] = 23,
	["traseira"] = 24,
	["ornaments"] = 28,
	["dashboard"] = 29,
	["dials"] = 30,
	["doors"] = 31,
	["seats"] = 32,
	["plaques"] = 35,
	["arch-cover"] = 42,
	["janela"] = 46,
	["decal"] = 48,
}

local wheeltype = {
	["stock"] = -1,
	["sport"] = 0,
	["muscle"] = 1,
	["lowrider"] = 2,
	["suv"] = 3,
	["offroad"] = 4,
	["tuner"] = 5,
	["highend"] = 7,
}

function SetVehicleMods(veh,myveh) 
	SetVehicleModKit(veh,0)
	if not myveh or not myveh.customPcolor then
		return
	end
	local bug = false
	local primary = myveh.color[1]
	local secondary = myveh.color[2]
	local cprimary = myveh.customPcolor
	if cprimary['1'] then
		bug = true
	end
	local csecondary = myveh.customScolor
	local perolado = myveh.extracolor[1]
	local wheelcolor = myveh.extracolor[2]
	local neoncolor = myveh.neoncolor
	local smokecolor = myveh.smokecolor
	ClearVehicleCustomPrimaryColour(veh)
	ClearVehicleCustomSecondaryColour(veh)
	SetVehicleWheelType(veh,myveh.wheeltype)
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
	SetVehicleXenonLightsColour(veh,myveh.xenoncolor)
	SetVehicleNumberPlateTextIndex(veh,myveh.plateindex)
	SetVehicleWindowTint(veh,myveh.windowtint)
	for i,t in pairs(myveh.mods) do 
		if tonumber(i) == 22 or tonumber(i) == 18 then
			if t.mod > 0 then
				ToggleVehicleMod(veh,tonumber(i),true)
			else
				ToggleVehicleMod(veh,tonumber(i),false)
			end
		elseif tonumber(i) == 20 then
			smokeColor(veh,smokecolor)
		elseif tonumber(i) == 23 or tonumber(i) == 24 then
			SetVehicleMod(veh,tonumber(i),tonumber(t.mod),tonumber(t.variation))
		else
			SetVehicleMod(veh,tonumber(i),tonumber(t.mod))
		end
	end
	SetVehicleTyresCanBurst(veh,myveh.bulletProofTyres)
	if myveh.neon then
		for i = 0, 3 do
			SetVehicleNeonLightEnabled(veh,i,true)
		end
	else
		for i = 0, 3 do
			SetVehicleNeonLightEnabled(veh,i,false)
		end
	end

end

function setNeon(veh,toggle)
	for i = 0, 3 do
		SetVehicleNeonLightEnabled(veh,i,toggle)
	end
end

function setXenon(veh,toggle)
	ToggleVehicleMod(veh,mod["farol"],toggle)
end

function smokeColor(veh,color)
	local r,g,b = parseInt(color[1]),parseInt(color[2]),parseInt(color[3])
	ToggleVehicleMod(veh,mod["smoke"],true)
	SetVehicleTyreSmokeColor(veh,r,g,b)
end