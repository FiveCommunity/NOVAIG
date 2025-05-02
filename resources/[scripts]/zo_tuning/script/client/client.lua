Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
Tools = module("vrp", "lib/Tools")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface(GetCurrentResourceName(), src)

vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local math = math

infosVeh = nil

inMoveCam = false

function src.close()
    RenderScriptCams(0, 0, cam, 0, 0)
    DestroyCam(cam, true)
    SetFocusEntity(PlayerPedId())

    cam = nil

    SetNuiFocus(false, false)
    
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)

    if vehicle then
        SetVehicleLights(vehicle, 0)
    end

    SendNUIMessage({
        type = 'closeNui'
    })
end

function table.empty(self)
    for _, _ in pairs(self) do return false end
    return true
end

function hexToRGB(hex)
    if type(hex) == "string" then
        hex = hex:gsub("#","")

        local r = tonumber(hex:sub(1,2), 16)
        local g = tonumber(hex:sub(3,4), 16)
        local b = tonumber(hex:sub(5,6), 16)
        
        return r, g, b
    end

    return 255, 255, 255
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local registerNUICallbacks = {
    ["closeNui"] = function(data, cb)
        src.close()

        local infos = vSERVER.getInfos()

        if infos then
            vSERVER.setCustom(infosVeh, infos, VehToNet(currentVehicle))
        end
    end,

    ["removeModulo"] = function(data, cb)
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsUsing(ped)

        if not vSERVER.checkPerms(menuTuning.permissoesRemoverModulo) then TriggerEvent("Notify", notifysType["erro"], textNotifys[2](), 5000) return end

        local possuiItens, itens = vSERVER.checkItens(menuTuning.itensObrigatorioRemoverModulo)
        if not possuiItens then TriggerEvent("Notify", notifysType["erro"], textNotifys[1](itens), 5000) return end

        local infosVehRemove = vSERVER.checkVehicleInfos()
        local modulo = data.item

        if not infosVehRemove then return end
        if infosVehRemove[modulo] then
            infosVehRemove[modulo].instalado = nil

            local infos = vSERVER.getInfos()
            vSERVER.setCustom(infosVehRemove, infos, vehicleInstall)
            src.close()
            
            vSERVER.giveItens({{ item = configuracaoModulos[modulo].configItem.nameItem, qtd = 1 }})
            TriggerEvent("Notify", notifysType["sucesso"], textNotifys[8](), 5000)
        end
    end,

    ["setValueCamber"] = function(data, cb)
        infosVeh.camber = data.camber
    end,

    ["setValueOffset"] = function(data, cb)
        infosVeh.offset = data.offset
    end,

    ["setValueSuspensao"] = function(data, cb)
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsUsing(ped)

        infosVeh.suspensao.value = data.suspensao

        local suspensao = round(GetVehicleSuspensionHeight(vehicle), 2)
        TriggerServerEvent("zo_tuning_suspe", VehToNet(vehicle), infosVeh.suspensao.value, suspensao)
    end,

    ["setValueAntiLag"] = function(data, cb)
        infosVeh.antiLag = data.antiLag

        if infosVeh.antiLag.effect then
            antiLag(true)
        end
    end,

    ["setValueWestgate"] = function(data, cb)
        infosVeh.westgate = data.westgate

        if infosVeh.westgate.sound and infosVeh.westgate.active then
            local sound = westGateSounds[infosVeh.westgate.sound]
            local val = math.random(sound.min, sound.max)

            PlaySoundFromEntity(-1, "WEST_GATE_" .. val, currentVehicle, sound.dlc, true, 0)
        end
    end,

    ["setPurgadorValue"] = function(data, cb)
        infosVeh.purgador.value = data.purgador
        infosVeh.purgador.active = true

        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsUsing(ped)
        SetVehicleNitroPurgeEnabled(vehicle, data.purgador)
    end,

    ["disablePurgador"] = function(data, cb)
        infosVeh.purgador.active = data.active

        if data.active then
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsUsing(ped)
            SetVehicleNitroPurgeEnabled(vehicle, infosVeh.purgador.value)
        end
    end,

    ["disableNeon"] = function(data, cb)
        if not data.active then
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsUsing(ped)

            setNeonCarOnOff(vehicle, false)
        end

        infosVeh.neon.power = data.active
    end,

    ["setValueNeon"] = function(data, cb)
        local color = data.color

        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsUsing(ped)

        infosVeh.neon.power = true
        infosVeh.neon.color = data.color

        setNeonCarColor(vehicle, data.color)
    end,

    ["disableXenon"] = function(data, cb)
        if not data.active then
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsUsing(ped)

            ToggleVehicleMod(vehicle, 22, false)
        end

        infosVeh.xenon.power = data.active
    end,

    ["setValueXenon"] = function(data, cb)
        local color = data.color

        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsUsing(ped)

        infosVeh.xenon.power = true
        infosVeh.xenon.color = data.color

        setXenonCarColor(vehicle, data.color)
    end,

    ["setRemapValue"] = function(data, cb)
        data = data.item

        infosVeh.remap[data.key] = { 
            value = data.value,
            max = data.max,
            min = data.min
        }

        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsUsing(ped)

        if vehicle then
            setRemapVehicle(vehicle, infosVeh.remap)
        end
    end,

    ["destroyCam"] = function(data, cb)
        RenderScriptCams(0, 0, cam, 0, 0)
        DestroyCam(cam, true)

        cam = nil
        SetFocusEntity(PlayerPedId())
    end,

    ["moveCam"] = function(data, cb)
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsUsing(ped)

        inMoveCam = data.move

        if inMoveCam then
            Citizen.CreateThread(function()
                SetNuiFocus(false, true)

                while inMoveCam do
                    Citizen.Wait(0)

                    BlockWeaponWheelThisFrame()
                    DisableControlAction(0, 261, true)
                    DisableControlAction(0, 262, true)
                    DisableInputGroup(24)

                    local alterPosition = false

                    if IsControlPressed(1, 172) then positionCam.cds[1] = (positionCam.cds[1] or 0) + 0.01; alterPosition = true end -- ARROW UP
                    if IsControlPressed(1, 173) then positionCam.cds[1] = (positionCam.cds[1] or 0) - 0.01; alterPosition = true end -- ARROW DOWN

                    if IsControlPressed(1, 308) then positionCam.cds[2] = (positionCam.cds[2] or 0) + 0.01; alterPosition = true end -- ARROW LEFT
                    if IsControlPressed(1, 307) then positionCam.cds[2] = (positionCam.cds[2] or 0) - 0.01; alterPosition = true end -- ARROW RIGHT

                    if IsControlPressed(1, 172) and IsControlPressed(1, 21) then positionCam.cds[3] = (positionCam.cds[3] or 0) + 0.01; alterPosition = true end -- SCROL UP
                    if IsControlPressed(1, 173) and IsControlPressed(1, 21) then positionCam.cds[3] = (positionCam.cds[3] or 0) - 0.01; alterPosition = true end -- SCROL DOWN

                    if IsControlPressed(1, 38) or IsControlPressed(1, 200) then
                        inMoveCam = false
                        
                        SetNuiFocus(true, true)
                        cb(true)
                    end
                    
                    if alterPosition then
                        if positionCam.pos then
                            MoveVehCam(positionCam.pos, positionCam.cds[1], positionCam.cds[2], positionCam.cds[3])
                        end

                        if positionCam.bone then
                            PointCamAtBone(positionCam.bone, positionCam.cds[1], positionCam.cds[2], positionCam.cds[3])
                        end

                        alterPosition = false 
                    end
                end
            end)
        end
    end,

    ["setCam"] = function(data, cb)
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsUsing(ped)

        if cam == nil then
            cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        end

        if data.tipo == "home" then
            MoveVehCam("front-top", 0, 2.0, 0.5)
        end

        if data.tipo == "wheel" then
            if data.eixo == "frontal" then
                PointCamAtBone("wheel_lf", -1.4, 0.0, 0.3)
            elseif data.eixo == "traseiro" then
                PointCamAtBone("wheel_lr", -1.4, -1.0, 0.3)
            else
                MoveVehCam("left", -5, 0.0, 0.5)
            end
        end

        if data.tipo == "suspe" then
            MoveVehCam("left", -5, 0.0, 0.5)
        end

        if data.tipo == "xenon" then
            MoveVehCam("front", 0, 2.0, 0.5)
            SetVehicleLights(vehicle, 2)
        end

        if data.tipo == "purgador" then
            MoveVehCam("front", 0, 2.0, 1.0)
        end

        if data.tipo == "exahust" then
            MoveVehCam("back", 1.5, -3.0, 1.0)
        end

        if data.tipo == "neon" then
            MoveVehCam("left", -1.5, 3.5, 1.0)
        end
    end,
}

function setXenonCarColor(vehicle, color)
    if color then
        local r, g, b = hexToRGB(color)

        ToggleVehicleMod(vehicle, 22, true)
        SetVehicleXenonLightsCustomColor(vehicle, r, g, b)
    end
end

function setNeonCarOnOff(vehicle, toggle)
    local lados = { 0, 1, 2, 3 }

    for i, l in pairs(lados) do
        SetVehicleNeonLightEnabled(vehicle, l, toggle)
    end
end

function setNeonCarColor(vehicle, color)
    local r, g, b = hexToRGB(color)
    setNeonCarOnOff(vehicle, true)

    SetVehicleNeonLightsColour(vehicle, r, g, b)
end

Citizen.CreateThread(function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)

    src.close()

    for i, f in pairs(registerNUICallbacks) do
        RegisterNUICallback(i, function(data, cb)
            f(data, cb)
        end)
    end

    if vehicle then
        Citizen.Wait(1000)
        loopWhileInVehicle()
    end


    local tunning_coords = {
        vec3(38.46,-1768.64,29.3),
        -- vec3(98.39,-1773.17,29.71),
        -- vec3(2731.32,3470.11,55.25),
        -- vec3(-2232.71,-386.37,13.67),
        -- vec3(923.83,-926.99,43.42),
        -- vec3(928.44,-927.0,43.42),
        -- vec3(937.5,-972.02,59.11),
        -- vec3(-329.05,-134.51,60.47),
    }
    while true do
        local SLEEP_TIME = 1000

        local playercoords = GetEntityCoords(PlayerPedId())
        for _, v in pairs(tunning_coords) do 
            local distance = #(playercoords - v)
            if distance < 10 then
                SLEEP_TIME = 0
                DrawMarker(27, v.x,v.y,v.z-0.97 ,0,0,0,0,0,0,3.0,3.0,1.0,255, 102, 0,200,0,0,0,1)

                if IsControlJustPressed(0,38) then

                    if not vSERVER.checkPerms(menuTuning.permissoesAcessarMenu) then
                        TriggerEvent("Notify", notifysType["erro"], textNotifys[2](), 5000)
                        return
                    end
            
                    local possuiItens, itens = vSERVER.checkItens(menuTuning.itensObrigatorioAcessar)
                    if not possuiItens then
                        TriggerEvent("Notify", notifysType["erro"], textNotifys[1](itens), 5000)
                        return
                    end
            
                    local ped = PlayerPedId()
                    vehicle = GetVehiclePedIsUsing(ped)
            
                    if vehicle ~= 0 then
                        infosVeh = vSERVER.checkVehicleInfos()
                        if not infosVeh then TriggerEvent("Notify", notifysType["erro"], textNotifys[3](), 5000) return end
            
                        if not infosVeh.suspensao.value then
                            infosVeh.suspensao.value = round(GetVehicleSuspensionHeight(vehicle), 2)
                        end
            
                        if not infosVeh.offset.defaultCar then
                            infosVeh.offset.defaultCar = GetVehicleWheelXOffset(vehicle)
                        end
            
                        for i, v in pairs(remapOptions) do
                            if infosVeh.remap then
                                if infosVeh.remap[v.key] then
                                    remapOptions[i].value = infosVeh.remap[v.key].value
                                    remapOptions[i].max = infosVeh.remap[v.key].max
                                    remapOptions[i].min = infosVeh.remap[v.key].min
                                end
                            end
            
                            if not remapOptions[i].max or not remapOptions[i].min then
                                if vehicle then
                                    local valueVehicle = GetVehicleHandlingFloat(vehicle, "CHandlingData", v.field)
            
                                    remapOptions[i].value = round(valueVehicle, 2)
                                    remapOptions[i].max = round(valueVehicle + remapOptions[i].var, 2)
                                    remapOptions[i].min = round(valueVehicle - remapOptions[i].var, 2)
                                end
                            end
                        end
            
                        local permsMenu = {}
                        local exibirInstalados = false
                        local itensInstalados = {}
            
                        for i, v in pairs(configuracaoModulos) do
                            local itemInstalado = true
            
                            if v.configItem.obrigatorioItemInstaladoParaAcessar then
                                exibirInstalados = true
            
                                if infosVeh[i] then
                                    itemInstalado = infosVeh[i].instalado ~= nil
                                end
            
                                if itemInstalado then
                                    table.insert(itensInstalados, { key = i, nome = v.nome, img = v.img })
                                else
                                    permsMenu[i] = { key = i, block = true }
                                end
                            end
            
                            if table.empty(v.permsAcessarMenu) and not permsMenu[i] then
                                permsMenu[i] = { key = i, block = false }
                            else
                                if permsMenu[i] then
                                    if permsMenu[i].block then goto continue end
                                end
            
                                permsMenu[i] = { key = i, block = not vSERVER.checkPerms(v.permsAcessarMenu) }
                            end
            
                            permsMenu[i].img = v.img
                            permsMenu[i].desabilitar = v.desabilitar
            
                            ::continue::
                        end
            
                        SetNuiFocus(true, true)
                        SendNUIMessage({
                            type = 'openNuiCars',
                            data = {
                                infosVeh = infosVeh,
                                remapConfig = remapOptions,
                                permsMenu = permsMenu,
                                exibirInstalados = exibirInstalados,
                                modulosInstalados = itensInstalados,
                                configValues = {
                                    antiLagEffects = antiLagEffectsDict,
                                    antiLagSounds = antiLagSounds,
                                    westgateSounds = westGateSounds
                                }
                            }
                        })
                    else
                        TriggerEvent("Notify", notifysType["erro"], textNotifys[6](), 5000)
                    end

                end
            end
        end


        Wait(SLEEP_TIME)
    end
end)

AddEventHandler("gameEventTriggered", function(event, args)
    local actionFromEvent = {
        ["CEventNetworkPlayerEnteredVehicle"] = function(event, args)
            loopWhileInVehicle()
        end,
    }

    if actionFromEvent[event] then
        actionFromEvent[event](event, args)
    end
end)

RegisterNetEvent("synczosuspe_tuning")
AddEventHandler('synczosuspe_tuning', function(vehicle, altura)
    if NetworkDoesNetworkIdExist(vehicle) then
        local v = NetToVeh(vehicle)
        SetVehicleSuspensionHeight(v, f(altura))
    end
end)

function src.soundSuspensao(subir)
    local sound = "SUSPENSION_UP"
    if subir then sound = "SUSPENSION_DOWN" end

    if currentVehicle then
        PlaySoundFromEntity(-1, sound, currentVehicle, "ZO_PACK_SOUNDS_CAR", true, 0)
    end
end

function setRemapVehicle(vehicle, remapInfos)
    for i, remap in pairs(remapOptions) do
        if remapInfos[remap.key] then
            SetVehicleHandlingFloat(vehicle, "CHandlingData", remap.field, remapInfos[remap.key].value * 1.0)
        end
    end
end

instalandoModulo = false

function returnCoordBone(veh, bone, px, py, pz)
    local b = GetEntityBoneIndexByName(veh, bone)
    local bx,by,bz = table.unpack(GetWorldPositionOfEntityBone(veh, b))
    local ox2,oy2,oz2 = table.unpack(GetOffsetFromEntityGivenWorldCoords(veh,bx,by,bz))
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(veh,ox2+f(px),oy2+f(py),oz2+f(pz)))

    return x, y, z
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x,y,z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)

    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.005 + factor, 0.03, 41, 11, 41, 68)
end

function getNearestVehicles(radius)
	local r = {}
	local px,py,pz = table.unpack(GetEntityCoords(PlayerPedId()))

	local vehs = {}
	local it,veh = FindFirstVehicle()
	if veh then
		table.insert(vehs,veh)
	end
	local ok
	repeat
		ok,veh = FindNextVehicle(it)
		if ok and veh then
			table.insert(vehs,veh)
		end
	until not ok
	EndFindVehicle(it)

	for _,veh in pairs(vehs) do
		local x,y,z = table.unpack(GetEntityCoords(veh,true))
		local distance = GetDistanceBetweenCoords(x,y,z,px,py,pz,true)
		if distance <= radius then
			r[veh] = distance
		end
	end
	return r
end

function getNearestVehicle(radius)
	local veh
	local vehs = getNearestVehicles(radius)
	local min = radius+0.0001
	for _veh,dist in pairs(vehs) do
		if dist < min then
			min = dist
			veh = _veh
		end
	end
	return veh 
end

function src.vehList(radius)
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)

	if not IsPedInAnyVehicle(ped) then veh = getNearestVehicle(radius) end

	if IsEntityAVehicle(veh) then
		local x, y, z = table.unpack(GetEntityCoords(ped))
		return veh, VehToNet(veh), GetVehicleNumberPlateText(veh), GetDisplayNameFromVehicleModel(GetEntityModel(veh))
	end
end