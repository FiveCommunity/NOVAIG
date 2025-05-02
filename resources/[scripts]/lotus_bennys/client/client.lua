local vehicle
local myVeh = {}
local playerSelects = {}
local gameplayCam = nil
local cam = nil
nuiBennys = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    SetNuiFocus(false,false)
    while true do 
        local timeDistance = 400 
        local currentPed = PlayerPedId()
        local coordsPed = GetEntityCoords(currentPed)
        for k,v in pairs(Config.Bennys.locais) do 
            if not nuiBennys then 
                local distance = #(coordsPed - v.coords)
                if distance < 3 then 
                    timeDistance = 5
                    DrawMarker(27, v.coords[1],v.coords[2],v.coords[3]-0.97 ,0,0,0,0,0,0,3.0,3.0,1.0,255, 102, 0,200,0,0,0,1)
                    if distance < 2 then 
                        drawTxt("PRESSIONE  ~r~E~w~  PARA ACESSAR A ~y~MECÂNICA",4,0.5,0.93,0.50,255,255,255,180)
                        if IsControlJustPressed(0,38) and vSERVER.getPermission(v.perm) and (GetEntityHealth(currentPed) > 101) then
                            vehicle = vRP.getNearestVehicle(7)
                            if vehicle and vSERVER.statusVehicle(VehToNet(vehicle)) then
                                SetVehicleModKit(vehicle,0)
                                FreezeEntityPosition(vehicle,true)

                                myVeh = currentVehicleMods(vehicle)
                                gameplaycam = GetRenderingCam()
                                cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true,2)
                                OpenBennysUI()
                                nuiBennys = true
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(timeDistance)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
------------------------------------------------------------------------------------s-----------------------------------------------------
RegisterNUICallback('getConfig', function(data, cb)
   --[[ local stance,stanceB = vSERVER.dataStance(vehicle)
    local dataStance = {
        fronttrack = stance and stance["fronttrack"] or GetVehicleWheelXOffset(vehicle, 0),
        reartrack = stance and stance["reartrack"] or GetVehicleWheelXOffset(vehicle,0),
        frontcamber = stance and stance["frontcamber"] or GetVehicleWheelYRotation(vehicle,0),
        rearcamber = stance and stance["rearcamber"] or GetVehicleWheelYRotation(vehicle,2),
        suspension = stance and stance["suspension"] or GetVehicleSuspensionHeight(vehicle),
        wheelsize = stance and stance["wheelsize"] or GetVehicleWheelSize(vehicle),
        wheelwidth = stance and stance["wheelwidth"] or GetVehicleWheelWidth(vehicle),
        fronttrackb = stanceB and stanceB["fronttrack"] or GetVehicleWheelXOffset(vehicle,0),
        reartrackb = stanceB and stanceB["reartrack"] or GetVehicleWheelXOffset(vehicle,2),
        wheelsizeb = stanceB and stanceB["wheelsize"] or GetVehicleWheelSize(vehicle),
        wheelwidthb = stanceB and stanceB["wheelwidth"] or GetVehicleWheelWidth(vehicle)
    }--]]

    config = {
        categorys = Config.Bennys.categorys,
       
        stance = {
           --[[{ step = 0.001, key = 'fronttrack', name = 'Espaçamento Dianteiro', value = tonumber(dataStance["fronttrack"]), min = tonumber(dataStance["fronttrackb"]) - 0.25, max = tonumber(dataStance["fronttrackb"]) + 0.25 },
            { step = 0.001, key = 'reartrack', name = 'Espaçamento Traseiro', value = tonumber(dataStance["fronttrack"]), min = tonumber(dataStance["reartrackb"]) - 0.25, max = tonumber(dataStance["reartrackb"]) + 0.25 },
            { step = 0.001, key = 'frontcamber', name = 'Cambagem Dianteira', value = tonumber(dataStance["frontcamber"]), min = -0.2, max = 0.2 },
            { step = 0.001, key = 'rearcamber', name = 'Cambagem Traseira', value = tonumber(dataStance["rearcamber"]), min = -0.2, max = 0.2 },
            { step = 0.001, key = 'suspension', name = 'Altura da Suspensão', value = tonumber(dataStance["suspension"]), min = -0.1, max = 0.1 },--]]
        },
        remap = {
           --[[ { step = 20, key = 'rotation', name = 'Rotação do motor', min = 0, max = 100 },
            { step = 20, key = 'rotation', name = 'Aderência em curvas', min = 0, max = 100 },
            { step = 20, key = 'rotation', name = 'Aderência em aceleração', min = 0, max = 100 },]]
        }
    }

    --if GetVehicleMod(vehicle, 23) ~= -1 then
    --    table.insert(config.stance, { step = 20, key = 'wheelsize', name = 'Tamanho da Roda', value = tonumber(dataStance["wheelsize"]), min = tonumber(dataStance["wheelsizeb"]) - 0.2, max = tonumber(dataStance["wheelsizeb"]) + 0.2 })
    --    table.insert(config.stance, { step = 20, key = 'wheelwidth', name = 'Largura da Roda', value = tonumber(dataStance["wheelwidth"]), min = tonumber(dataStance["wheelwidthb"]) - 0.2, max = tonumber(dataStance["wheelwidthb"]) + 0.2 })
    --end
    
    cb(config)
end)


RegisterNUICallback('Cancel', function(data, cb)
    FreezeEntityPosition(vehicle,false)
    CloseNui()
end)
 
RegisterNUICallback('close', function(data, cb)
    FreezeEntityPosition(vehicle,false)
    CloseNui()
end)

--[[

RegisterNUICallback('cancelStance', function(data, cb)
    print(data,'cancelStance')
end)

RegisterNUICallback('applyStanceCustom', function(data, cb)
    print(json.encode(data),'applyStanceCustom')
    

    if data.key == "fronttrack" then 
        print(tonumber(data.value),tonumber(-data.value))
        SetVehicleWheelXOffset(vehicle,0,tonumber(data.value))
        SetVehicleWheelXOffset(vehicle,1,tonumber(-data.value))
    elseif data.key == "reartrack" then 
        print(tonumber(data.value),tonumber(-data.value))
        SetVehicleWheelXOffset(vehicle,2,tonumber(data.value))
        SetVehicleWheelXOffset(vehicle,3,tonumber(-data.value))
    elseif data.key == "frontcamber" then 
        print(tonumber(data.value),tonumber(-data.value))
        SetVehicleWheelYRotation(vehicle,0,tonumber(data.value))
        SetVehicleWheelYRotation(vehicle,1,tonumber(-data.value))
    elseif data.key == "rearcamber" then 
        SetVehicleWheelYRotation(vehicle,2,tonumber(data.value))
        SetVehicleWheelYRotation(vehicle,3,tonumber(-data.value))
    elseif data.key == "suspension" then 
        SetVehicleSuspensionHeight(vehicle,tonumber(data.value))
    end

    Entity(Vehicle)["state"]:set("PreStance",Data,true)
    cb(true)
end)

RegisterNUICallback('applyRemapCustom', function(data, cb)
    print(json.encode(data),'applyRemapCustom')
    cb(true)
end)

RegisterNUICallback('savePreset', function(data, cb)
    print(data,'savePreset')
end)

RegisterNUICallback('saveStance', function(data, cb)
    print(data,'SAVESTANCE')
    local dataStance = {
        networkVeh = NetworkGetNetworkIdFromEntity(vehicle),
        fronttrack = GetVehicleWheelXOffset(vehicle, 0),
        reartrack = GetVehicleWheelXOffset(vehicle,0),
        frontcamber = GetVehicleWheelYRotation(vehicle,0),
        rearcamber = GetVehicleWheelYRotation(vehicle,2),
        suspension = GetVehicleSuspensionHeight(vehicle),
        wheelsize = GetVehicleWheelSize(vehicle),
        wheelwidth = GetVehicleWheelWidth(vehicle),
        fronttrackb = GetVehicleWheelXOffset(vehicle,0),
        reartrackb = GetVehicleWheelXOffset(vehicle,2),
        wheelsizeb = GetVehicleWheelSize(vehicle),
        wheelwidthb = GetVehicleWheelWidth(vehicle)
    }
    vSERVER.saveCustom("stance",dataStance)
end)

RegisterNUICallback('saveRemap', function(data, cb)
    print(data,'SAVEREMAP')
end)--]]

RegisterNUICallback('BackNavigation', function(data, cb)
    camControl("close")
end)

RegisterNUICallback('Buy', function(data, cb)
    if vehicle then
        myVeh = currentVehicleMods(vehicle)
        buyAttributes(myVeh,vehicle)
    end
end)

RegisterNUICallback('getAttributesCategory', function(data, cb)
    local category = {}
    local dataParts = split(data, ",")
    if dataParts then
        if dataParts[1] == 'pintura' then
            if dataParts[2] == "primaria" or dataParts[2] == 'secundaria' then
                playerSelects['pintura'] = dataParts[2]
                camControl(dataParts[2])
            else
                category = {
                    { name = 'Primaria', image_url = '/icons/'..dataParts[1], key = 'primaria', category = true, type = 'colors' },
                    { name = 'Secundaria', image_url = '/icons/'..dataParts[1], key = 'secundaria', category = true, type = 'colors' },
                }
            end
        elseif dataParts[1] == 'chassi' then
            if dataParts[2] then 
                table.insert(category, {
                    key = -1,
                    name = "Padrão",
                    image_url =  "/icons/"..dataParts[1]
                })
                for i = 0, GetNumVehicleMods(vehicle, Config.Bennys.modsIndex[dataParts[2]]) - 1 do 
                    table.insert(category, {
                        key = i,
                        name = i + 1,
                        image_url =  "/icons/"..dataParts[1]
                    })
                end
                camControl(dataParts[2])
            else
                category = {
                    { name = 'Capa do Farol', image_url = '/icons/'..dataParts[1], key = 'arch-cover', category = true },
                    { name = 'Portas', image_url = '/icons/portas', key = 'doors', category = true },
                    { name = 'Gaiola', image_url = '/icons/'..dataParts[1], key = 'roll-cage', category = true },
                }
                camControl(dataParts[1])
            end
        elseif dataParts[1] == 'farol' then
            if dataParts[2] == "cor" then
                for i = 0, 11 do 
                    table.insert(category, {
                        key = i,
                        name = i,
                        image_url =  "/icons/"..dataParts[1]
                    })
                end
            else
                category = {
                    { name = 'Fábrica', image_url = '/icons/'..dataParts[1], key = 'fabrica' },
                    { name = 'Xenon', image_url = '/icons/'..dataParts[1], key = 'xenon' },
                    { name = 'Cor Xenon', image_url = '/icons/'..dataParts[1], key = 'cor', category = true },
                }
            end
            camControl(dataParts[1])
        elseif dataParts[1] == 'turbo' then
            category = {
                { name = 'Padrão', image_url = '/icons/'..dataParts[1], key = 0 },
                { name = 'Turbo', image_url = '/icons/'..dataParts[1], key = 1 },
            }
            camControl(dataParts[1])
        elseif dataParts[1] == 'blindagem' then
            category = {
                { name = 'Padrão', image_url = '/icons/'..dataParts[1], key = -1 },
                { name = '20%', image_url = '/icons/'..dataParts[1], key = 0 },
                { name = '40%', image_url = '/icons/'..dataParts[1], key = 1 },
                { name = '60%', image_url = '/icons/'..dataParts[1], key = 2 },
                { name = '80%', image_url = '/icons/'..dataParts[1], key = 3 },
                { name = '100%', image_url = '/icons/'..dataParts[1], key = 4 },
            }
            camControl(dataParts[1])
        elseif dataParts[1] == 'placa' then
            for i = 0, 5 do 
                table.insert(category, {
                    key = i,
                    name = i == 0 and "Padrão" or i,
                    image_url =  "/icons/"..dataParts[1]
                })
            end
            camControl(dataParts[1])
        elseif dataParts[1] == 'vidro' then
            for i = 0, 6 do 
                table.insert(category, {
                    key = i,
                    name = i == 0 and "Padrão" or i,
                    image_url =  "/icons/"..dataParts[1]
                })
            end
            camControl(dataParts[1])
        elseif dataParts[1] == 'interior' then
            if dataParts[2] then
                table.insert(category, {
                    key = -1,
                    name = "Padrão",
                    image_url =  "/icons/"..dataParts[1]
                })
                if GetNumVehicleMods(vehicle, Config.Bennys.modsIndex[dataParts[2]]) > 0 then
                    for i = 0, GetNumVehicleMods(vehicle, Config.Bennys.modsIndex[dataParts[2]]) - 1 do 
                        table.insert(category, {
                            key = i,
                            name = i + 1,
                            image_url =  "/icons/"..dataParts[1]
                        })
                    end
                end
                camControl(dataParts[2])
            else
                category = {
                    { name = 'Enfeites', image_url = '/icons/'..dataParts[1], key = 'ornaments', category = true },
                    { name = 'Painel', image_url = '/icons/'..dataParts[1], key = 'dashboard', category = true },
                    { name = 'Ponteiros', image_url = '/icons/ponteiros', key = 'dials', category = true },
                    { name = 'Janela', image_url = '/icons/windows', key = 'janela', category = true },
                    { name = 'Bancos', image_url = '/icons/banco', key = 'seats', category = true },
                }
                camControl(dataParts[1])
            end
        elseif dataParts[1] == 'neon' then
            if dataParts[2] == 'colors' then 
                playerSelects['pintura'] = 'neon'
            end
            category = {
                { name = 'Padrão', image_url = '/icons/'..dataParts[1], key = 'default' },
                { name = 'Kit Neon', image_url = '/icons/'..dataParts[1], key = 'kit' },
                { name = 'Cor do Neon', image_url = '/icons/'..dataParts[1], key = 'colors', category = true, type = 'neoncolor'},
            }
            camControl(dataParts[1])
        elseif dataParts[1] == 'rodas' then
            if dataParts[2] == 'type' then
                if dataParts[3] then 
                    table.insert(category, {
                        key = -1,
                        name = 0,
                        image_url =  "/icons/"..dataParts[1]
                    })
                    print("/icons/"..dataParts[1].."-"..dataParts[3])
                    if dataParts[3] == 'dianteira' or dataParts[3] == 'traseira' then
                        for i = 0, 300 do 
                            table.insert(category, {
                                key = i,
                                name = i + 1,
                                image_url =  "/icons/"..dataParts[1]
                            })
                        end
                    elseif dataParts[3] == 'sport' then
                        for i = 0, 300 do 
                            table.insert(category, {
                                key = i,
                                name = i + 1,
                                image_url =  "../icons/"..dataParts[1].."-"..dataParts[3]
                            })
                        end
                    elseif dataParts[3] == 'muscle' then
                        for i = 0, 300 do 
                            table.insert(category, {
                                key = i,
                                name = i + 1,
                                image_url =  "/icons/"..dataParts[1].."-"..dataParts[3]
                            })
                        end
                    elseif dataParts[3] == 'lowrider' then
                        for i = 0, 300 do 
                            table.insert(category, {
                                key = i,
                                name = i + 1,
                                image_url =  "/icons/"..dataParts[1].."-"..dataParts[3]
                            })
                        end
                    elseif dataParts[3] == 'suv' then
                        for i = 0, 300 do 
                            table.insert(category, {
                                key = i,
                                name = i + 1,
                                image_url =  "/icons/"..dataParts[1].."-"..dataParts[3]
                            })
                        end
                    elseif dataParts[3] == 'offroad' then
                        for i = 0, 300 do 
                            table.insert(category, {
                                key = i,
                                name = i + 1,
                                image_url =  "/icons/"..dataParts[1].."-"..dataParts[3]
                            })
                        end
                    elseif dataParts[3] == 'tuner' then
                        for i = 0, 300 do 
                            table.insert(category, {
                                key = i,
                                name = i + 1,
                                image_url =  "/icons/"..dataParts[1].."-"..dataParts[3]
                            })
                        end
                    elseif dataParts[3] == 'highend' then
                        for i = 0, 300 do 
                            table.insert(category, {
                                key = i,
                                name = i + 1,
                                image_url =  "/icons/"..dataParts[1].."-"..dataParts[3]
                            })
                        end
                    end
                    camControl(dataParts[3])
                else
                    if IsThisModelABike(GetEntityModel(vehicle)) then
                        category = {
                            { name = 'Dianteira', image_url = '/icons/'..dataParts[1], key = 'dianteira', category = true },
                            { name = 'Traseira', image_url = '/icons/'..dataParts[1], key = 'traseira', category = true},                
                        }
                    else
                        category = {
                            { name = 'Padrão', image_url = '/icons/'..dataParts[1], key = 'padrao' },
                            { name = 'Sport', image_url = '/icons/'..dataParts[1]..'-sport', key = 'sport', category = true },
                            { name = 'Muscle', image_url = '/icons/'..dataParts[1]..'-muscle', key = 'muscle', category = true},
                            { name = 'Lowrider', image_url = '/icons/'..dataParts[1]..'-lowrider', key = 'lowrider', category = true},
                            { name = 'Suv', image_url = '/icons/'..dataParts[1]..'-suv', key = 'suv', category = true},
                            { name = 'Offroad', image_url = '/icons/'..dataParts[1]..'-offroad', key = 'offroad', category = true},
                            { name = 'Tuner', image_url = '/icons/'..dataParts[1]..'-tuner', key = 'tuner', category = true},
                            { name = 'Highend', image_url = '/icons/'..dataParts[1]..'-highend', key = 'highend', category = true},
                        }
                    end
                    
                end
            elseif dataParts[2] == 'colors' then
                for i = 0, 75 do 
                    table.insert(category, {
                        key = i,
                        name = i,
                        image_url =  "/icons/"..dataParts[1]
                    })
                end
                camControl("wheel-colors")
            elseif dataParts[2] == 'accessories' then
                if dataParts[3] == 'smoke' then 
                    playerSelects['pintura'] = 'smoke'
                end
                category = {
                    { name = 'Fábrica', image_url = '/icons/'..dataParts[1], key = 'fabrica' },
                    { name = 'Custom', image_url = '/icons/'..dataParts[1], key = 'custom' },
                    { name = 'Blindagem', image_url = '/icons/'..dataParts[1], key = 'bulletproof'},
                    { name = 'Fumaça', image_url = '/icons/smoke', key = 'smoke', category = true, type = 'smokecolor' },
                }
                camControl("wheel-accessories")
            else
                category = {
                    { name = 'Tipo', image_url = '/icons/'..dataParts[1], key = 'type', category = true },
                    { name = 'Cor', image_url = '/icons/'..dataParts[1], key = 'colors', category = true },
                    { name = 'Acessórios', image_url = '/icons/pintura', key = 'accessories', category = true},
                }
                camControl(dataParts[1])
            end
        else
            local modType = Config.Bennys.modsIndex[dataParts[1]]
            if modType then
                table.insert(category, {
                    key = -1,
                    name = "Padrão",
                    image_url =  "/icons/"..dataParts[1]
                })
                for i = 0, GetNumVehicleMods(vehicle, modType) - 1 do 
                    table.insert(category, {
                        key = i,
                        name = i + 1,
                        image_url =  "/icons/"..dataParts[1]
                    })
                end
                camControl(dataParts[1])
            end
        end
    end
    cb(category)
end)

RegisterNUICallback('unlockScreen', function(data, cb)
    freeCam()
    cb(true)
end)

RegisterNUICallback('peroladoNext', function(data, cb)
    if playerSelects['perolado'] then 
        if playerSelects['perolado'] == 75 then
            playerSelects['perolado'] = 1
        else 
            playerSelects['perolado'] = playerSelects['perolado'] + 1
        end 
    else 
        playerSelects['perolado'] = 1
    end

    local colorindex = playerSelects['perolado'] or 1
    print(colorindex,'a')
    local perolado,wcolor = GetVehicleExtraColours(vehicle)
    print(perolado,wcolor)
	SetVehicleExtraColours(vehicle,parseInt(colorindex),wcolor)
    updateBalance(myVeh, "perolado", colorindex)
    cb(true)
end)

RegisterNUICallback('peroladoPrevius', function(data, cb)
    if playerSelects['perolado'] then 
        if playerSelects['perolado'] == 1 then
            playerSelects['perolado'] = 75
        else 
            playerSelects['perolado'] = playerSelects['perolado'] - 1
        end 
    else 
        playerSelects['perolado'] = 75
    end

    
    local colorindex = playerSelects['perolado'] or 1
    print(colorindex,'b')

    local perolado,wcolor = GetVehicleExtraColours(vehicle)
	SetVehicleExtraColours(vehicle,parseInt(colorindex),wcolor)
    updateBalance(myVeh, "perolado", colorindex)
    cb(true)
end)

RegisterNUICallback('applyAttribute', function(data, cb)
    if data and vehicle then
        applyAttribute(data, vehicle,myVeh)
    end
end)

RegisterNUICallback('SelectTypeColor', function(data, cb)
    if data and playerSelects then
        if playerSelects['pintura'] == 'primaria' or playerSelects['pintura'] == 'secundaria' then

            local colorindex = 1
            local primaryColor, secondaryColor = GetVehicleColours(vehicle)
            if #Config.Bennys.colorsIndex[data] > 1 and colorindex then
                SetVehicleModKit(vehicle, 0)
                if playerSelects['pintura'] == 'primaria' then 
                    ClearVehicleCustomPrimaryColour(vehicle)
                    SetVehicleColours(vehicle, Config.Bennys.colorsIndex[data][colorindex], secondaryColor)
                elseif playerSelects['pintura'] == 'secundaria' then 
                    ClearVehicleCustomSecondaryColour(vehicle)
                    SetVehicleColours(vehicle, primaryColor, Config.Bennys.colorsIndex[data][colorindex])
                end
            else
                SetVehicleModKit(vehicle, 0)
                if playerSelects['pintura'] == 'primaria' then 
                    ClearVehicleCustomPrimaryColour(vehicle)
                    SetVehicleColours(vehicle, Config.Bennys.colorsIndex[data][1], secondaryColor)
                elseif playerSelects['pintura'] == 'secundaria' then 
                    ClearVehicleCustomSecondaryColour(vehicle)
                    SetVehicleColours(vehicle, primaryColor, Config.Bennys.colorsIndex[data][1])
                end
            end

            updateBalance(myVeh, playerSelects['pintura'], Config.Bennys.colorsIndex[data][colorindex],colorindex)
        end
    end
end)

RegisterNUICallback('SelectColor', function(data, cb)
    if data and playerSelects then 
        local r, g, b = data:match("rgb%((%d+), (%d+), (%d+)%)")
        if playerSelects['pintura'] == 'smoke' then 
            ToggleVehicleMod(vehicle,Config.Bennys.modsIndex["smoke"],true)
			SetVehicleTyreSmokeColor(vehicle,tonumber(r),tonumber(g),tonumber(b))
        elseif playerSelects['pintura'] == 'neon' then
            SetVehicleNeonLightsColour(vehicle,tonumber(r),tonumber(g),tonumber(b))
        elseif playerSelects['pintura'] == 'primaria' then 
            updateBalance(myVeh, "cor-primaria", {r,g,b})
            SetVehicleCustomPrimaryColour(vehicle,tonumber(r),tonumber(g),tonumber(b))
        elseif playerSelects['pintura'] == 'secundaria' then 
            updateBalance(myVeh, "cor-secundaria", {r,g,b})
            SetVehicleCustomSecondaryColour(vehicle,tonumber(r),tonumber(g),tonumber(b))
        end 
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function CloseNui()
    if IsCamActive(cam) then
		SetCamActive(cam, false)
	end
    SetVehicleLights(vehicle,0)
	ResetCam()
    CloseBennysUI()
    camControl("close")
    setVehicleMods(vehicle,myVeh)
    FreezeEntityPosition(vehicle,false)
    vSERVER.removeVehicle(VehToNet(vehicle))
    vehicle = nil
	cam = nil
	myVeh = {}
end

local function f(n)
	return (n + 0.00001)
end

local function PointCamAtBone(bone,ox,oy,oz)
	SetCamActive(cam, true)
	local veh = vehicle
	local b = GetEntityBoneIndexByName(veh, bone)
	if b and b > -1 then
		local bx,by,bz = table.unpack(GetWorldPositionOfEntityBone(veh, b))
		local ox2,oy2,oz2 = table.unpack(GetOffsetFromEntityGivenWorldCoords(veh, bx, by, bz))
		local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(veh, ox2 + f(ox), oy2 + f(oy), oz2 +f(oz)))
		SetCamCoord(cam, x, y, z)
		PointCamAtCoord(cam,GetOffsetFromEntityInWorldCoords(veh, 0, oy2, oz2))
		RenderScriptCams( 1, 1, 1000, 0, 0)
	end
end

local function MoveVehCam(pos,x,y,z)
	SetCamActive(cam, true)
	local veh = vehicle
	local vx,vy,vz = table.unpack(GetEntityCoords(veh))
	local d = GetModelDimensions(GetEntityModel(veh))
	local length,width,height = d.y*-2, d.x*-2, d.z*-2
	local ox,oy,oz
	if pos == 'front' then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), (length/2)+ f(y), f(z)))
	elseif pos == "front-top" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), (length/2) + f(y),(height) + f(z)))
	elseif pos == "back" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), -(length/2) + f(y),f(z)))
	elseif pos == "back-top" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), -(length/2) + f(y),(height/2) + f(z)))
	elseif pos == "left" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, -(width/2) + f(x), f(y), f(z)))
	elseif pos == "right" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, (width/2) + f(x), f(y), f(z)))
	elseif pos == "middle" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), f(y), (height/2) + f(z)))
	end
	SetCamCoord(cam, ox, oy, oz)
	PointCamAtCoord(cam,GetOffsetFromEntityInWorldCoords(veh, 0, 0, f(0)))
	RenderScriptCams( 1, 1, 1000, 0, 0)
end

function camControl(c)
	if c == "parachoque-dianteiro" or c == "grelha" or c == "arch-cover" then
		MoveVehCam('front',-0.6,1.5,0.4)
	elseif c == "primaria" or c == "secundaria" or c == "decal" then
		MoveVehCam('middle',-2.6,2.5,1.4)
	elseif  c == "parachoque-traseiro"  or c == "escapamento" then
		MoveVehCam('back',-0.5,-1.5,0.2)
	elseif c == "capô" then
		MoveVehCam('front-top',-0.5,1.3,1.0)
	elseif c == "teto" then
		MoveVehCam('middle',-2.2,2,1.5)
	elseif c == "vidro" then
		MoveVehCam('middle',-2.0,2,0.5)
	elseif c == "farol" or c == "xenon-colors" then
		MoveVehCam('front',-0.6,1.3,0.6)
	elseif c == "placa" then
		MoveVehCam('back',0,-1,0.2)
	elseif c == "para-lama" then
		MoveVehCam('left',-1.8,-1.3,0.7)
	elseif c == "saias" then
		MoveVehCam('left',-1.8,-1.3,0.7)
	elseif c == "aerofolio" then
		MoveVehCam('back',0.5,-1.6,1.3)
	elseif c == "traseira" then
		PointCamAtBone("wheel_lr",-1.4,0,0.3)
	elseif c == "dianteira" or c == "wheel-accessories" or  c == "wheel-colors" or c == "sport" or c == "muscle" or c == "lowrider"  or c == "highend" or c == "suv" or c == "offroad" or c == "tuner" then
        PointCamAtBone("wheel_lf",-1.4,0,0.3)
	elseif c == "neon" or c == "neon-colors" or c == "suspensão" then
		if not IsThisModelABike(GetEntityModel(vehicle)) then
			PointCamAtBone("neon_l",-2.0,2.0,0.4)
		end
	elseif c == "janela" or c == "interior" or c == "ornaments" or c == "dashboard" or c == "dials" or c == "seats" or c =="roll-cage" then
		MoveVehCam('back-top',0.0,4.0,0.7)
	elseif c == "doors" then
		SetVehicleDoorOpen(vehicle, 0, 0, 0)
		SetVehicleDoorOpen(vehicle, 1, 0, 0)
		doorsopen = true
	elseif IsCamActive(cam) then
		ResetCam()
	else
		if doorsopen then
			SetVehicleDoorShut(vehicle, 0, 0)
			SetVehicleDoorShut(vehicle, 1, 0)
			SetVehicleDoorShut(vehicle, 4, 0)
			SetVehicleDoorShut(vehicle, 5, 0)
			doorsopen = false
		end
	end
end

function ResetCam()
	SetCamCoord(cam,GetGameplayCamCoords())
	SetCamRot(cam, GetGameplayCamRot(2), 2)
	RenderScriptCams( 0, 1, 1000, 0, 0)
	SetCamActive(gameplaycam, true)
	EnableGameplayCam(true)
	SetCamActive(cam, false)
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


function p(nro)
	if nro < 0 then
		return 0
	end
	return nro
end

function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end