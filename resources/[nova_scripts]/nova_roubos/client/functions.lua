function OpenNUI(table,focus)
        if type(table) ~= 'table' then return end
    SendNUIMessage(table)
    if focus then
        inPainel = true
        SetNuiFocus(focus, focus)
        TriggerScreenblurFadeIn(2000)
    end
end

function CloseNUI()
    inPainel = false
    SetNuiFocus(false, false)
    TriggerScreenblurFadeOut(500)
end

function showKeyForScoreboard()
    local showWarn = true
   -- AddTextEntry('warning_line_1', 'Pressione INSERT para abrir o menu do roubo.')
    CreateThread(function()
        SetTimeout(8000, function()
            showWarn = false
        end)
        while showWarn do
            Wait(0)
          --  SetWarningMessage("warning_line_1", 2, false, false, -1, false, false, false, 0)
            if IsDisabledControlJustPressed(2,201) or IsDisabledControlJustPressed(2,215) then 
                showWarn = false
            end
        end
    end)
end

function lRoubos.updateRobberyPoints(obj)
    RobberyPoints = obj
end

function lRoubos.getNearestPlayers(radius)
    local r          = {}
	local pid        = PlayerId()
	local plyCoords  = GetEntityCoords(PlayerPedId())

	for _,player in ipairs(GetActivePlayers()) do 
		if player ~= pid then 
			local distance = #(plyCoords - GetEntityCoords(GetPlayerPed(player)))
			if distance <= radius then 
				r[GetPlayerServerId(player)] = distance
			end
		end
	end

	return r
end

function lRoubos.removeDrawmarker(key)
    RemoveBlip(robberyBlips[key])
    robberyHappen[key] = false
end

function lRoubos.createDrawmarker(vec,key)
    robberyHappen[key] = true
    AreaBlip(vec.x,vec.y,vec.z, key)
    Citizen.CreateThread(function()
        while robberyHappen[key] do 
            Citizen.Wait(4)
            DrawMarker(1,vec.x,vec.y,vec.z-2,0,0,0,0, 0,0,135.5,135.5,20.5, 255,0,0, 40,0,0,0,1)
        end
    end)
end

function lRoubos.createCopsBlip(vec,name,cooldown)
    if not vec then return end
    if not name then name = '' end
    blips:insert(AddBlipForCoord(vec))
    local blip = blips[#blips]

    if DoesBlipExist(blip) then
        SetBlipScale(blip,0.5)
        SetBlipSprite(blip,1)
        SetBlipColour(blip,27)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Roubo: ~r~"..tostring(name))
        EndTextCommandSetBlipName(blip)
        SetBlipAsShortRange(blip,false)
        SetBlipRoute(blip,true)
    end

    SetTimeout(tonumber(cooldown) * 1000, function()
        RemoveBlip(blip)
    end)
end

function lRoubos.cancelRobbery()
   -- config:blockControls(false)
   -- config.stopAnim()
    inPainel = false
    isInRobbery = false
    inSelectTeam = false
    ActualRobbery,Team = nil
    OpenNUI({ action = 'CloseLoadscreen' }, false)
    CloseNUI()
end


local function counterChoose(key)
    Citizen.CreateThread(function()
        while inSelectTeam do
            Wait(4)
            if IsControlJustPressed(0, 177) then
                CloseNUI()
                inSelectTeam = false
                print('Roubo cancelado linha 108')
                TriggerServerEvent('nova_roubos:tryrobnotify', tonumber(key), 'negado', 'A seleção de time foi cancelada!', 8000)
                vSERVER.cancelRobbery(key)
            end
        end
    end)
   
end

function lRoubos.SelectCops(key,cops,needcops,bandits,hostages,name) -- FUNÇÃO CLIENT, QUE SELECIONA OS COPS
    OpenNUI({ action = 'CloseLoadscreen' }, false)
    CloseNUI()
    Wait(5000)
    if not tonumber(key) then return end if type(cops) ~= 'table' or not needcops or not bandits or not hostages then return end
    inSelectTeam = true
    playTabletAnimation()
    OpenNUI({ action = 'CopsTeam', key = tonumber(key), nusers = cops, needcops = parseInt(tonumber(needcops)), bandits = parseInt(tonumber(bandits)), hostages = parseInt(tonumber(hostages)), name = tostring(name), cops = {} },true)
    
    counterChoose(tonumber(key))
    
    Wait(60000 * 5)
    stopTabletAnimation()
    if inSelectTeam and key then 
        CloseNUI()
        inSelectTeam = false
        TriggerServerEvent('nova_roubos:tryrobnotify', tonumber(data.key), 'negado', 'A seleção de time foi cancelada!', 8000)
        print('Roubo cancelado linha 132')
        vSERVER.cancelRobbery(data.key)
    end
end

local important_warns = {
    ['bandits'] = 'Os policiais estão a caminho, aguarde.',
    ['cops'] = 'O roubo iniciou, a localização já está marcada!',
    ['hostages'] = 'Os policiais foram alertados do roubo, coopere para sobreviver!',
    Warn = function(self,team)
        TriggerEvent('nova_roubos:robnotify', 'importante', tostring(self[team]), 8000)
    end
}

local start_warns = {
    ['bandits'] = 'Roubo iniciado, policiais chegaram no perímetro.',
    ['cops'] = 'Roubo iniciado, policiais chegaram no perímetro.',
    ['hostages'] = 'O roubo iniciou, coopere para sobreviver!',
    Warn = function(self,team)
        TriggerEvent('nova_roubos:robnotify', 'importante', tostring(self[team]), 8000)
    end
}

function lRoubos.hudRobbery(robbery,team)
    if not isInRobbery then 
        OpenNUI({ action = 'CloseLoadscreen' }, false)
        CloseNUI()
    end
    if not robbery or type(robbery) ~= 'table' or type(team) ~= 'string' then return end
    ActualRobbery = robbery

    isInRobbery,Team,isAlive = true,team,GetEntityHealth(PlayerPedId()) > 101

    print('HUD ROUBO',json.encode(ActualRobbery),team)

    OpenNUI({action = 'UpdatingHud', robbery = ActualRobbery, team = Team, initialUpdate = true},false)
    showKeyForScoreboard()

    SetTimeout(1000, function()
        start_warns:Warn(Team)
    end)
end

function lRoubos.initRobbery(robbery,team)
    if not robbery or type(robbery) ~= 'table' or type(team) ~= 'string' then return end
    if not isInRobbery then 
        OpenNUI({ action = 'CloseLoadscreen' }, false)
        CloseNUI()
        return 
    end
    ActualRobbery = robbery
    
    CreateThread(function()
        if ActualRobbery.pusher == GetPlayerServerId(PlayerId()) and GetPlayerServerId(PlayerId()) ~= 0 then 
            OpenNUI({ action = 'CloseLoadscreen' }, false)
            CloseNUI()
        end
    end)
     
    SetTimeout(1000, function()
        if isInRobbery then
            important_warns:Warn(team)
        end
    end)
end


function lRoubos.updateActualRobbery(obj)
    if obj and type(obj) == 'table' then
        ActualRobbery = obj
        local Team = vSERVER.GetMyTeam(ActualRobbery)
        print('updateActualRobbery',json.encode(ActualRobbery),Team)
        OpenNUI({action = 'UpdatingHud', robbery = ActualRobbery, team = Team}, false)
    else
        inPainel = false
        isInRobbery = false
        inSelectTeam = false
        ActualRobbery,Team = nil
        print('Cancelando updateActualRobbery')
        OpenNUI({action = 'UpdatingHud', robbery = false},false)
        CloseNUI()
    end
end
 ----==={ FUNÇÕES EXTRAS }===----
        
 function DrawText3D(x, y, z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)    
    SetTextScale(0.39, 0.39)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 235)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 270
    
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.04, 0, 0, 0, 145)
end

function DrawTxt(text,font,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end

format = function(n)
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

AreaBlip = function(x, y, z,key)
    robberyBlips[key] = AddBlipForRadius(x, y, z, 50.0)
    print(robberyBlips[key],key)
    print(x,y,z,'> areablip')
    SetBlipColour(robberyBlips[key], 1)
    SetBlipAlpha(robberyBlips[key], 80)
end

local tabletProp = nil
local animPlaying = false

function playTabletAnimation()
    if not animPlaying then
        RequestAnimDict('amb@code_human_in_bus_passenger_idles@female@tablet@idle_a')
        while not HasAnimDictLoaded('amb@code_human_in_bus_passenger_idles@female@tablet@idle_a') do
            Wait(10)
        end

        local playerPed = PlayerPedId()
        local propName = 'prop_cs_tablet'
        local boneIndex = GetPedBoneIndex(playerPed, 60309)

        tabletProp = CreateObject(GetHashKey(propName), 0, 0, 0, true, true, false)
        AttachEntityToEntity(tabletProp, playerPed, boneIndex, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)

        TaskPlayAnim(playerPed, 'amb@code_human_in_bus_passenger_idles@female@tablet@idle_a', 'idle_b', 8.0, -8.0, -1, 49, 0, false, false, false)
        animPlaying = true
    end
end

function stopTabletAnimation()
    if animPlaying then
        ClearPedTasks(PlayerPedId())
        DeleteObject(tabletProp)
        tabletProp = nil
        animPlaying = false
    end
end