cam = nil
positionCam = nil

function f(n)
	return (n + 0.00000001)
end

function PointCamAtBone(bone, ox, oy, oz)
    if not IsCamActive(cam) then
        SetCamActive(cam, true)
    end

    local veh = currentVehicle

    positionCam = { bone = bone, cds = { ox, oy, oz } }
    
    local b = GetEntityBoneIndexByName(veh, bone)
    local bx, by, bz = table.unpack(GetWorldPositionOfEntityBone(veh, b))
    local ox2, oy2, oz2 = table.unpack(GetOffsetFromEntityGivenWorldCoords(veh, bx, by, bz))
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(veh, ox2 + f(ox), oy2 + f(oy), oz2 + f(oz)))

    SetCamCoord(cam, x, y, z)
    PointCamAtCoord(cam, GetOffsetFromEntityInWorldCoords(veh, 0, oy2, oz2))

    RenderScriptCams(true, true, 1000, false, false)
end

function MoveVehCam(pos, x, y, z)
    if not IsCamActive(cam) then
        SetCamActive(cam, true)
    end

    positionCam = { pos = pos, cds = { x, y, z } }

    local veh = currentVehicle

	local vx, vy, vz = table.unpack(GetEntityCoords(veh))
	local d = GetModelDimensions(GetEntityModel(veh))
	local length, width, height = d.y * -2, d.x * -2, d.z * -2
	local ox, oy, oz

	if pos == 'front' then
		ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), (length / 2) + f(y), f(z)))
	elseif pos == "front-top" then
		ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), (length / 2) + f(y), (height) + f(z)))
	elseif pos == "back" then
		ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), -(length/2) + f(y), f(z)))
	elseif pos == "back-top" then
		ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), -(length/2) + f(y), (height / 2) + f(z)))
	elseif pos == "left" then
		ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(veh, -(width / 2) + f(x), f(y), f(z)))
	elseif pos == "right" then
		ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(veh, (width / 2) + f(x), f(y), f(z)))
	elseif pos == "middle" then
		ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), f(y), (height / 2) + f(z)))
	end

	SetCamCoord(cam, ox, oy, oz)
    PointCamAtCoord(cam, GetOffsetFromEntityInWorldCoords(veh, 0, 0, f(0)))

    RenderScriptCams(true, true, 1000, false, false)
end

function animationInstall(vehicle, part)
    local ped = PlayerPedId()
    instalandoModulo = true

    local instalado = false
    local steps = 0
    local blipsCriados = false

    while not instalado do    
        Citizen.Wait(5)

        if not blipsCriados then
            local stepFinish = {}

            if part.insideCar then
                Citizen.CreateThread(function()
                    local aviso1 = false
                    local aviso2 = false
                    local instalando = false

                    while not instalado do
                        Citizen.Wait(1)

                        local ppos = GetEntityCoords(ped)
                        local posvehicle = GetEntityCoords(vehicle)
                        local len = GetDistanceBetweenCoords(vector3(ppos.x, ppos.y, ppos.z), vector3(posvehicle.x, posvehicle.y, posvehicle.z))

                        local vehicleInside = GetVehiclePedIsUsing(ped)
                        if vehicleInside ~= 0 and ped == GetPedInVehicleSeat(vehicleInside, -1) and vehicle == vehicleInside then
                            DrawText3D(posvehicle.x, posvehicle.y, posvehicle.z + 1.5, "Pressione [~r~E~w~] para instalar")

                            if IsControlJustPressed(0, 38) then
                                instalando = true
                                Citizen.CreateThread(function()
                                    while instalando do
                                        Citizen.Wait(5)
                                        DisableControlAction(0, 167, true)
                                    end
                                end)

                                vSERVER.anim(part.anim)
                                Citizen.Wait(part.anim.time)

                                instalando = false
                                steps = steps + 1
                            end
                        else
                            DrawText3D(posvehicle.x, posvehicle.y, posvehicle.z + 1.5, "Entre no [~r~VEICULO~w~] para instalar")
                        end

                        if len > 20.0 then
                            instalado = true
                            TriggerEvent("Notify", notifysType["erro"], textNotifys[4](), 5000)
                        end
                    end
                end)
                
                blipsCriados = true
            else
                for i, blip in ipairs(part.blips) do
                    Citizen.CreateThread(function()
                        stepFinish[i] = false
                        
                        while not stepFinish[i] and not instalado do
                            Citizen.Wait(1)

                            local instalando = false
                            local ppos = GetEntityCoords(ped)
                            local lenBlip = GetDistanceBetweenCoords(vector3(ppos.x, ppos.y, ppos.z), vector3(blip[1], blip[2], blip[3]))

                            local posvehicle = GetEntityCoords(vehicle)
                            local len = GetDistanceBetweenCoords(vector3(ppos.x, ppos.y, ppos.z), vector3(posvehicle.x, posvehicle.y, posvehicle.z))

                            DrawMarker(1, blip[1], blip[2], blip[3] - 1.5, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.7, 0, 255, 0, 155, 0, 0, 0, 1)
                            if lenBlip < 1.0 then
                                DrawText3D(blip[1], blip[2], blip[3], "Pressione [~r~E~w~] para instalar")

                                if IsControlJustPressed(0, 38) then
                                    instalando = true

                                    Citizen.CreateThread(function()
                                        while instalando do
                                            Citizen.Wait(5)
                                            DisableControlAction(1, 167, true)
                                        end
                                    end)

                                    if blip["prepareInstall"] ~= nil then blip.prepareInstall() end

                                    vSERVER.anim(part.anim)
                                    Citizen.Wait(part.anim.time)

                                    instalando = false
                                    steps = steps + 1
                                    stepFinish[i] = true
                                end
                            end

                            if len > 20.0 and not instalado then
                                instalado = true
                                TriggerEvent("Notify", notifysType["erro"], textNotifys[4](), 5000)

                                return
                            end
                        end
                    end)
                end

                blipsCriados = true
            end
        end

        instalandoModulo = false
        if steps == part.steps then
            instalado = true
            part.installAplly()
        end
    end
end