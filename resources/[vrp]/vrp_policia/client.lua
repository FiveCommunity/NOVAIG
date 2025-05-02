local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","vrp_policia")

src = {}
Tunnel.bindInterface("vrp_policia",src)
vSERVER = Tunnel.getInterface("vrp_policia")


local segundos = 0

----------------------------------------------------------------------------------------------------------------------------------------
-- PEDIR RG
----------------------------------------------------------------------------------------------------------------------------------------
local css = [[ #simplehud { bottom: 13%; right: 0%; background: rgba(0, 0, 0, 0.4); -webkit-box-shadow: 0 6px 15px 0 rgba(0,0,0,.6); box-shadow: 10px rgba(0,0,0,.4); -webkit-box-sizing: border-box; width: 15%; padding: 0 15px 12px 15px; border-radius: 15px 0 0 15px; position: fixed; } @keyframes animateright { from { right: -300px; opacity: 0 } to { right: 3%; opacity: 1 } } .label_carteira { font-family: 'Lobster', cursive; font-size: 25px; font-weight: bold; letter-spacing: 1px; color: #fff; letter-spacing: 0.25rem; text-align: center; } .label_carteira p { background: linear-gradient(270deg, rgba(74, 255, 213,1), rgba(74, 255, 213,0.3)); background-size: 400% 400%; margin: 10px; padding: 0; -webkit-background-clip: text; -webkit-text-fill-color: transparent; animation: changebackground 5s ease infinite; } @keyframes changebackground { 0%{background-position:0% 50%} 50%{background-position:100% 50%} 100%{background-position:0% 50%} } .info_carteira { font-family: 'Blinker', sans-serif; font-size: 15px; color: #333; } .info_carteira .info_section{ background: transparent; padding: 8px; /*border-radius: 8px; margin: 10px 0;*/ text-align: left; letter-spacing: 1px; border-bottom:1px solid transparent; color: white; } .info_carteira .info_section:first-child{ border-top-left-radius: 8px; border-top-right-radius: 8px; } .info_carteira .info_section:last-child{ border-bottom-left-radius: 8px; border-bottom-right-radius: 8px; box-shadow: 0 2px 1px transparent; border: 0; } .info_carteira .info_section .icon { width: 30px; height: 30px; background-repeat: no-repeat; background-size: 20px; background-position: center; float: left; position: relative; top: -5px; left: -2px; } .info_carteira .info_section .info { float: right; color: rgb(255, 255, 255); padding-right: 5px; } @keyframes animateright { from { right: -300px; opacity: 0 } to { right: 2.2%; opacity: 1 } } ]]

---@param status boolean
---@param id string
---@param nome string
---@param sobrenome string
---@param idade string
---@param registro string
---@param telefone string
---@param carteira string
---@param trabalho string
---@param porte string
---@param procurado string
function src.enviarIdentidade(status, id, nome, sobrenome, idade, registro, telefone, carteira, trabalho, porte, procurado)
    if status then
        local html = string.format(
            "<div id='simplehud'> " ..
            "<div class='label_carteira'>" ..
            "<img src='https://i.imgur.com/9W1byNe.png' style='width: 120px;'>" ..
            "</div> " ..
            "<div class='info_carteira'> " ..
            "<div class='info_section'> PASSAPORTE: <span class='info'>" .. id .. "</span> </div> " ..
            "</div> " ..
            "<div class='info_carteira'> " ..
            "<div class='info_section'> NOME: <span class='info'> " .. nome .. " " .. sobrenome .. " (" .. idade .. ")</span> </div> " ..
            "</div> " ..
            "<div class='info_carteira'> " ..
            "<div class='info_section'> RG: <span class='info'> " .. registro .. "</span> </div> " ..
            "</div> " ..
            "<div class='info_carteira'> " ..
            "<div class='info_section'> Telefone: <span class='info'> " .. telefone .. "</span> </div> " ..
            "</div> " ..
            "<div class='info_carteira'> " ..
            "<div class='info_section'> Trabalho: <span class='info'> " .. trabalho .. "</span> </div> " ..
            "</div> " ..
            "<div class='info_carteira'> " ..
            "<div class='info_section'> Carteira: <span class='info'> " .. carteira .. "</span> </div> " ..
            "</div> " ..
            "<div class='info_carteira'> " ..
            "<div class='info_section'> Procurado: <span class='info'> " .. (procurado or "Falha ao consultar") .. "</span> </div> " ..
            "</div> " ..
            "</div>"
        )
        vRP._setDiv("registro", css, html)
    else
        vRP._removeDiv("registro")
    end
    return true
end  

----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE ALGEMAR
----------------------------------------------------------------------------------------------------------------------------------------
local other = nil
local drag = false
local carregado = false

function src.arrastar(p1)
    other = p1
    drag = not drag
    if OnesyncEnableRemoteAttachmentSanitization then
		OnesyncEnableRemoteAttachmentSanitization(false)
	end
end

Citizen.CreateThread(function()
    while true do
        local time = 1000
		if drag and other then
            time = 5
			local ped = GetPlayerPed(GetPlayerFromServerId(other))
			-- Citizen.InvokeNative(0x6B9BBD38AB0796DF,PlayerPedId(),ped,4103,11816,0.48,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
            AttachEntityToEntity(PlayerPedId(),ped,11816,0.6,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
			carregado = true
        else
        	if carregado then
				DetachEntity(PlayerPedId(),true,false)
                
				carregado = false
			end
        end

        Citizen.Wait(time)
	end
end)

local other2 = nil
local drag2 = false
local carregado2 = false

function src.arrastar2(p12)
    other2 = p12
    drag2 = not drag2
    if OnesyncEnableRemoteAttachmentSanitization then
		OnesyncEnableRemoteAttachmentSanitization(false)
	end
end

Citizen.CreateThread(function()
    while true do
        local time = 1000
		if drag2 and other2 then
            time = 5
			local ped = GetPlayerPed(GetPlayerFromServerId(other2))
            -- AttachEntityToEntity(PlayerPedId(),ped,11816,0.6,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
            Citizen.InvokeNative(0x6B9BBD38AB0796DF,PlayerPedId(),ped,4103,11816,0.48,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
			carregado2 = true
        else
        	if carregado2 then
				DetachEntity(PlayerPedId(),true,false)
				carregado2 = false
			end
        end

        Citizen.Wait(time)
	end
end)


local ped = PlayerPedId()
local vida = GetEntityHealth(ped)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALGEMAR / DESALGEMAR 
-----------------------------------------------------------------------------------------------------------------------------------------
local playerInSafezone = false
RegisterCommand("keybindcuff",function(source,args)
    if not IsPedInAnyVehicle(PlayerPedId()) then
	    vSERVER._algemar(playerInSafezone)
    end
end)
RegisterKeyMapping("keybindcuff","Algemar o Cidadao","keyboard","g")

RegisterCommand("keybindcarry",function(source,args)
    if not IsPedInAnyVehicle(PlayerPedId())  then
	    vSERVER._arrastar(playerInSafezone) 
    end
end)
RegisterKeyMapping("keybindcarry","Carregar o Cidadao","keyboard","h")

RegisterCommand("arrastarf",function(source,args)
    if not IsPedInAnyVehicle(PlayerPedId())  then
	    vSERVER._arrastar2() 
    end
end)

function src.checkAnim()
    if IsEntityPlayingAnim(GetPlayerPed(-1),"random@arrests@busted","idle_a",3) then
        return true
    end
end

-- RegisterNetEvent('cuffEvent', function()
--     if not IsPedInAnyVehicle(PlayerPedId()) then
-- 	    vSERVER._algemar()
--     end
-- end)
--COMENTEI LINHA DE ARRASTAR NO H--

----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------------------------------------
function src.checkSexo()
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
        return "H" 
    elseif GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        return "M"
    end
end

function src.retirarMascara()
    SetPedComponentVariation(PlayerPedId(), 1, 0,0,2)
end


local in_arena = false

function src.updateWeapons()
	if not in_arena then
        exports.vrp:forceUpdateWeapons()
	end
end

RegisterNetEvent("mirtin_survival:updateArena")
AddEventHandler("mirtin_survival:updateArena", function(boolean)
    in_arena = boolean
end)

function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end

--------------------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFICAO DE DISPARO
--------------------------------------------------------------------------------------------------------------------------------------------------
local in_arena = false

local blacklistedWeapons = {
	"WEAPON_DAGGER",
	"WEAPON_BAT",
	"WEAPON_BALL",
	"WEAPON_SNOWBALL",
	"WEAPON_BOTTLE",
	"WEAPON_CROWBAR",
	"WEAPON_FLASHLIGHT",
	"WEAPON_GOLFCLUB",
	"WEAPON_HAMMER",
	"WEAPON_HATCHET",
	"WEAPON_KNUCKLE",
	"WEAPON_KNIFE",
    "WEAPON_FLARE",
    "WEAPON_BATTLEAXE",
    "WEAPON_DAGGER",
	"WEAPON_MACHETE",
	"WEAPON_SWITCHBLADE",
	"WEAPON_NIGHTSTICK",
	"WEAPON_WRENCH",
	"WEAPON_POOLCUE",
	"WEAPON_STUNGUN",
	"WEAPON_STONE_HATCHET"
}

local blacklistedLocations = {
    [1] = { coords = vec3(1571.94,-1685.43,88.22), dist = 100.0 },
    [2] = { coords = vec3(-91.33,-2642.74,6.04), dist = 100.0 },
}

Citizen.CreateThread(function()
	while true do
		local time = 100
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsUsing(ped)
		local blacklistweapon = false
		local x,y,z = table.unpack(GetEntityCoords(ped))
      
		for k,v in ipairs(blacklistedWeapons) do
			if GetSelectedPedWeapon(ped) == GetHashKey(v) or not vehicle then
				blacklistweapon = true
			end
		end

        for k,v in pairs(blacklistedLocations) do
            local distance = #(GetEntityCoords(ped) - v.coords)
			if distance <= v.dist then
                blacklistweapon = true
            end
        end

		if IsPedShooting(ped) and not blacklistweapon and not IsPedCurrentWeaponSilenced(PlayerPedId())
        and not exports.dm_module:inDomination() and not exports.dominacao:inDomination() and not LocalPlayer.state.inPvP then
            vSERVER._sendLocationFire(x,y,z)
            Wait(60000)
		end


		blacklistweapon = false

        Citizen.Wait(time)
	end
end)

RegisterNetEvent("mirtin_survival:updateArena")
AddEventHandler("mirtin_survival:updateArena", function(boolean)
    in_arena = boolean
end)


--------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE RADAR
--------------------------------------------------------------------------------------------------------------------------------------------------
local radar = {
	shown = false,
	freeze = false,
	info = "INICIANDO O SISTEMA DO RADAR",
	info2 = "INICIANDO O SISTEMA DO RADAR"
}

Citizen.CreateThread(function()
	while true do
		local time = 1000
        if IsPedInAnyVehicle(PlayerPedId()) then
            time = 5
            if IsControlJustPressed(1,306) and IsPedInAnyPoliceVehicle(PlayerPedId()) then
                if radar.shown then
                    radar.shown = false
                else
                    radar.shown = true
                end
            end

            if IsControlJustPressed(1,301) and IsPedInAnyPoliceVehicle(PlayerPedId()) then
                if radar.freeze then
                    radar.freeze = false
                else
                    radar.freeze = true
                end
            end

            if radar.shown then
                if radar.freeze == false then
                    local veh = GetVehiclePedIsIn(PlayerPedId(),false)
                    local coordA = GetOffsetFromEntityInWorldCoords(veh,0.0,1.0,1.0)
                    local coordB = GetOffsetFromEntityInWorldCoords(veh,0.0,105.0,0.0)
                    local frontcar = StartShapeTestCapsule(coordA,coordB,3.0,10,veh,7)
                    local a,b,c,d,e = GetShapeTestResult(frontcar)

                    if IsEntityAVehicle(e) then
                        local fmodel = GetDisplayNameFromVehicleModel(GetEntityModel(e))
                        local fvspeed = GetEntitySpeed(e)*2.236936
                        local fplate = GetVehicleNumberPlateText(e)
                        radar.info = string.format("~y~PLACA: ~w~%s   ~y~MODELO: ~w~%s   ~y~VELOCIDADE: ~w~%s MPH",fplate,fmodel,math.ceil(fvspeed))
                    end

                    local bcoordB = GetOffsetFromEntityInWorldCoords(veh,0.0,-105.0,0.0)
                    local rearcar = StartShapeTestCapsule(coordA,bcoordB,3.0,10,veh,7)
                    local f,g,h,i,j = GetShapeTestResult(rearcar)

                    if IsEntityAVehicle(j) then
                        local bmodel = GetDisplayNameFromVehicleModel(GetEntityModel(j))
                        local bvspeed = GetEntitySpeed(j)*2.236936
                        local bplate = GetVehicleNumberPlateText(j)
                        radar.info2 = string.format("~y~PLACA: ~w~%s   ~y~MODELO: ~w~%s   ~y~VELOCIDADE: ~w~%s MPH",bplate,bmodel,math.ceil(bvspeed))
                    end
                end
                drawTxt(radar.info,4,0.5,0.905,0.50,255,255,255,180)
                drawTxt(radar.info2,4,0.5,0.93,0.50,255,255,255,180)
            end

            if not IsPedInAnyVehicle(PlayerPedId()) and radar.shown then
                radar.shown = false
            end
        end
        Citizen.Wait(time)
	end
end)




----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OUTROS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)

Citizen.CreateThread(function()
    while true do
        local time = 1000

        if segundos > 0 then
            segundos = segundos - 1
        end

        Citizen.Wait(time)
    end
end)

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

local inSafeZone = false

Citizen.CreateThread(function()
    while true do 
        local ms = 400
        if inSafeZone then 
            ms = 0 
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped) then
             --   SetNetworkVehicleAsGhost(GetVehiclePedIsUsing(player),true)
                if not IsEntityGhostedToLocalPlayer(ped) then
                    SetLocalPlayerAsGhost(true)
                    SetGhostedEntityAlpha(254)
                end
            else
				SetGhostedEntityAlpha(254)
                if IsEntityGhostedToLocalPlayer(ped) then
                    SetLocalPlayerAsGhost(false)
					ResetGhostedEntityAlpha()
                end
            end
        else 
			SetGhostedEntityAlpha(254)
            if IsEntityGhostedToLocalPlayer(ped) then
                SetLocalPlayerAsGhost(false)
				ResetGhostedEntityAlpha()
            end
        end
        Citizen.Wait(ms)
    end
end)

exports("setinsafe", function(status)
	inSafeZone = status
    if not status then 
        local ped = PlayerPedId()
        if IsEntityGhostedToLocalPlayer(ped) then
            SetLocalPlayerAsGhost(false)
        end
    end
end)

function src.inSafe()
    return inSafeZone
end

exports('getinSafe', function()
    return inSafeZone
end)

exports("getArrest", function(status)
	return carregado
end)