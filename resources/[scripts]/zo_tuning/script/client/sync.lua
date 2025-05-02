vehiclesInfoCache = {}

function loopWhileInVehicle()
    local ped = PlayerPedId()

    local vehicle = GetVehiclePedIsUsing(ped)
    infosVeh = vSERVER.checkVehicleInfos()

    if infosVeh then
        if infosVeh.neon.power then setNeonCarColor(vehicle, infosVeh.neon.color) end
        if infosVeh.xenon.power then setXenonCarColor(vehicle, infosVeh.xenon.color) end

        setRemapVehicle(vehicle, infosVeh.remap)

        if infosVeh.suspensao.value ~= 0 then
            if infosVeh.suspensao.value > infosVeh.suspensao.min then
                infosVeh.suspensao.value = infosVeh.suspensao.min
            end
    
            if infosVeh.suspensao.value < infosVeh.suspensao.max then
                infosVeh.suspensao.value = infosVeh.suspensao.max
            end
    
            if vehicle ~= nil and vehicle ~= 0 then SetVehicleSuspensionHeight(vehicle, f(infosVeh.suspensao.value)) end
        end
    end

    while IsPedInAnyVehicle(ped) do
        if currentVehicle ~= vehicle then
            currentVehicle = vehicle

            infosVeh = vSERVER.checkVehicleInfos()
        end

        if infosVeh then
            if not infosVeh.offset.defaultCar then infosVeh.offset.defaultCar = GetVehicleWheelXOffset(vehicle) end
            if infosVeh.antiLag.active ~= 0 or infosVeh.westgate.active ~= 0 then checkAntiLagAndWestgate() end
            
            if IsControlJustPressed(1, 73) and infosVeh.purgador.active and waitPurge < 1 then
                SetVehicleNitroPurgeEnabled(vehicle, (infosVeh.purgador.value or 1))
            end

            setCamberAndOffSet(vehicle, infosVeh)
        end

        if waitPurge > 0 then
            waitPurge = waitPurge - 5
        end

        Citizen.Wait(5)
    end

    infosVeh = nil
    currentVehicle = nil
end

function applyChangesVehicle(vehicle, infos)
    if currentVehicle then
        if VehToNet(currentVehicle) == VehToNet(vehicle) then return end
    end

    setCamberAndOffSet(vehicle, infos)

    if infos.suspensao.value ~= 0 then
        if infos.suspensao.value > infos.suspensao.min then
            infos.suspensao.value = infos.suspensao.min
        end

        if infos.suspensao.value < infos.suspensao.max then
            infos.suspensao.value = infos.suspensao.max
        end
        
        if vehicle ~= nil and vehicle ~= 0 then SetVehicleSuspensionHeight(vehicle, f(infos.suspensao.value)) end
    end
end

function setCamberAndOffSet(vehicle, infos)
    function checkZeroOrNull(value) return value == 0 or value == nil end

    local setOffSet = true

    if checkZeroOrNull(infos.offset.defaultCar) then infos.offset.defaultCar = GetVehicleWheelXOffset(vehicle) end

    if checkZeroOrNull(infos.camber.frontal) then infos.camber.frontal = infos.camber.ambos end
    if checkZeroOrNull(infos.camber.traseiro) then infos.camber.traseiro = infos.camber.ambos end

    if checkZeroOrNull(infos.offset.frontal) then infos.offset.frontal = infos.offset.ambos end
    if checkZeroOrNull(infos.offset.traseiro) then infos.offset.traseiro = infos.offset.ambos end

    if checkZeroOrNull(infos.offset.ambos) and checkZeroOrNull(infos.offset.frontal) and checkZeroOrNull(infos.offset.traseiro) then setOffSet = false end

    local valCamberFront = (tonumber(infos.camber.frontal / 100))
    local valCamberBack = (tonumber(infos.camber.traseiro / 100))

    local valOffsetFront = (infos.offset.defaultCar - tonumber(infos.offset.frontal / 100))
    local valOffsetBack = (infos.offset.defaultCar - tonumber(infos.offset.traseiro / 100))

    for x = 0, 3, 1 do
        local valCamb = valCamberFront
        local valOff = valOffsetFront

        if x > 1 then
            valCamb = valCamberBack
            valOff = valOffsetBack
        end

        if x % 2 ~= 0 then
            valCamb = valCamb * -1
            valOff = valOff * -1
        end

        if valCamb ~= 0 then
            SetVehicleWheelYRotation(vehicle, x, valCamb)
        end

        if valOffset ~= infos.offset.defaultCar and setOffSet then
            SetVehicleWheelXOffset(vehicle, x, valOff)
        end
    end
end

function checkAntiLagAndWestgate()
    local rpm = GetVehicleCurrentRpm(currentVehicle)

    if math.abs(GetVehicleThrottleOffset(currentVehicle)) < 0.1 and rpm > 0.65 then
        local delayMs = lastEffectTime + math.random() % config.antiLag.randomMs + (config.antiLag.periodMs + 500)
        local gameTime = GetGameTimer()

        if gameTime > delayMs then
            local loud = false
            local loudDelayMs = math.random() % config.antiLag.randomMs + config.antiLag.loudOffThrottleIntervalMs
            
            local currentGear = GetVehicleCurrentGear(currentVehicle)

            if lastCurrentGear ~= currentGear then
                lastCurrentGear = currentGear
                loud = true
            end

            antiLag(loud, rpm)
            lastEffectTime = gameTime
        end
    end
end

-- TriggerEvent("zo_sync_tuning", vehicle)

RegisterNetEvent("zo_sync_tuning")
AddEventHandler("zo_sync_tuning", function(vnet)
    if NetworkDoesEntityExistWithNetworkId(vnet) then
		if DoesEntityExist(veh) then
            local vehicle = NetToVeh(vnet)

            local params = {
                vname = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)):lower(),
                vehicle = vehicle,
                vnet = vnet
            }

			local infosVehSync = vSERVER.checkVehicleInfos(params)

            setRemapVehicle(vehicle, infosVehSync.remap)
            applyChangesVehicle(vehicle, infosVehSync)
		end
	end
end)

RegisterNetEvent('zo_tuning:updateVehicles', function(data)
    vehiclesInfoCache = data
end)

Citizen.CreateThread(function()
    Citizen.Wait(5000)

    while true do
        Citizen.Wait(100)

        local vehicles = vehiclesInfoCache
        if vehicles then
            local vehiclePool = GetGamePool('CVehicle')
            for i = 1, #vehiclePool do
                if NetworkGetEntityIsNetworked(vehiclePool[i]) then
                    local netVeh = tostring(VehToNet(vehiclePool[i])) .. GetVehicleNumberPlateText(vehiclePool[i])

                    if vehicles[netVeh] then
                        applyChangesVehicle(vehiclePool[i], vehicles[netVeh])
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("zo_install_modulo_tuning")
AddEventHandler("zo_install_modulo_tuning", function(modulo)
    if instalandoModulo then TriggerEvent("Notify", notifysType["erro"], "Você já possui uma instalação em andamento", 5000) return end

    if not vSERVER.checkPerms(menuTuning.permissoesInstalarModulo) then TriggerEvent("Notify", notifysType["erro"], textNotifys[2](), 5000) return end

    local possuiItens, itens = vSERVER.checkItens(menuTuning.itensObrigatorioInstalarModulo)
    if not possuiItens then TriggerEvent("Notify", notifysType["erro"], textNotifys[1](itens), 5000) return end

    local vehicleInstall = getNearestVehicle(5)
    if vehicleInstall then
        local infosVehInstall = vSERVER.checkVehicleInfos()
        if not infosVehInstall then return end

        if infosVehInstall[modulo] then
            local infos = vSERVER.getInfos()

            local animWheel = { name = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", extra = "machinic_loop_mechandplayer", time = (configuracaoModulos[modulo].configItem.tempoAnimacaoInstalacao * 1000) }
            local animInsideCar = { name = "mini@repair", extra = "fixing_a_ped", time = 5000 }

            function setChanges()
                if vSERVER.removeItens({ configuracaoModulos[modulo].configItem.nameItem }) then
                    infosVehInstall[modulo].instalado = true
                    vSERVER.setCustom(infosVehInstall, infos, vehicleInstall)

                    TriggerEvent("Notify", notifysType["sucesso"], textNotifys[5](), 5000)
                else
                    TriggerEvent("Notify", notifysType["erro"], textNotifys[7](), 5000)
                end

                instalandoModulo = false
            end

            local cdsRodas = {
                { returnCoordBone(vehicleInstall, "wheel_lf", -0.5, 0, 0) },
                { returnCoordBone(vehicleInstall, "wheel_rf", 0.5, 0, 0) },
                { returnCoordBone(vehicleInstall, "wheel_lr", -0.5, 0, 0) },
                { returnCoordBone(vehicleInstall, "wheel_rr", 0.5, 0, 0) }
            }

            local animationsParts = {
                ["suspensao"] = {
                    insideCar = false,
                    steps = 4,
                    anim = animWheel,
                    blips = cdsRodas,
                    installAplly = setChanges
                },

                ["neon"] = {
                    insideCar = true,
                    steps = 1,
                    anim = animInsideCar,
                    installAplly = setChanges
                },

                ["xenon"] = {
                    insideCar = true,
                    steps = 1,
                    anim = animInsideCar,
                    installAplly = setChanges
                },

                ["offset"] = {
                    insideCar = false,
                    steps = 4,
                    anim = animWheel,
                    blips = cdsRodas,
                    installAplly = setChanges
                },

                ["camber"] = {
                    insideCar = false,
                    steps = 4,
                    anim = animWheel,
                    blips = cdsRodas,
                    installAplly = setChanges
                },

                ["antiLag"] = {
                    insideCar = false,
                    steps = 1,
                    anim = animWheel,
                    blips = { { returnCoordBone(vehicleInstall, "exhaust", -0.5, 0, 0) } },
                    installAplly = setChanges
                },

                ["remap"] = {
                    insideCar = true,
                    steps = 1,
                    anim = animInsideCar,
                    installAplly = setChanges
                },
            }

            if animationsParts[modulo] then
                return animationInstall(vehicleInstall, animationsParts[modulo])
            end

            setChanges()
        end
    end
end)