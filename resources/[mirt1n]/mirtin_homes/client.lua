--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
in_interior = false

infoInterior = {}
vehicles = {}
segundos = 3

propriedades = {}
proprietarios = {}
houseOwner = {}

nearestHouse = {}
nearestGaragem = {}

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src.enterCLhouse = function(interior)
    infoInterior = interior
    if infoInterior then
        DoScreenFadeOut(1000)

        Citizen.Wait(1000)
        SetEntityCoords(PlayerPedId(), infoInterior.coords[1],infoInterior.coords[2],infoInterior.coords[3])
        
        Citizen.Wait(500)
        in_interior = true

        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
    end
end

src.exitCLhouse = function(houseID)
    if houseID then
        DoScreenFadeOut(1000)

        Citizen.Wait(2000)
        SetEntityCoords(PlayerPedId(), propriedades[infoInterior.houseID].coords['x'],propriedades[infoInterior.houseID].coords['y'], propriedades[infoInterior.houseID].coords['z'])
        in_interior = false
        infoInterior = {}

        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
    end
end

src.enterAP = function(id, interfone)
    vSERVER.entrarPropriedade(id, "apartamento", interfone)
end

src.updatePropriedadesLock = function(id, status)
    if propriedades[id] then
        propriedades[id].porta = status
    end
end

src.updatePropriedadeID = function(id, status)
    propriedades[id] = status
end

src.updatePropriedades = function(props, id)
    if id ~= nil then
        if propriedades[parseInt(id)] ~= nil then
            propriedades[parseInt(id)] = nil
        end

        if nearestHouse[parseInt(id)] ~= nil then
            nearestHouse[parseInt(id)] = nil
        end
    end

    propriedades = props
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE GARAGEM
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src.openNUIGaragem = function(id, dados)
    SetNuiFocus(true, true)
    TransitionToBlurred(1000)
    SendNUIMessage({ show = true, tipo = "garagem", idGaragem = id, js = dados, imagens = config.imagemDir })
end

src.getSpawnVehicle = function()
    local heading = GetEntityHeading(PlayerPedId())
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    if IsPedInAnyVehicle(PlayerPedId()) then
        return {tD(x),tD(y),tD(z),tD(heading)}
    else
        return false
    end
end

src.spawnarVeiculo = function(id, veiculo, placa, motor, lataria, gasolina, custom)
    if vehicles[string.lower(veiculo)] then
        config.lang['veiculoSpawnado']()
        return
    end

    local mhash = GetHashKey(veiculo)
        while not HasModelLoaded(mhash) do
            RequestModel(mhash)
            Citizen.Wait(10)
        end
    if HasModelLoaded(mhash) then
        rand = 1
        while true do
            checkPos = GetClosestVehicle(propriedades[parseInt(id)].garagem['spawn'].x,propriedades[parseInt(id)].garagem['spawn'].y,propriedades[parseInt(id)].garagem['spawn'].z,3.001,0,71)
            if DoesEntityExist(checkPos) and checkPos ~= nil then
                rand = rand + 1
                if rand > #propriedades[parseInt(id)].garagem['spawn'] then
                    rand = -1
                    break
                end
            else
                break
            end
            Citizen.Wait(1)
        end

        if rand ~= -1 then
            nveh = CreateVehicle(mhash,propriedades[parseInt(id)].garagem['spawn'].x,propriedades[parseInt(id)].garagem['spawn'].y,propriedades[parseInt(id)].garagem['spawn'].z,propriedades[parseInt(id)].garagem['spawn'].h,true,false)
            netveh = VehToNet(nveh)

            NetworkRegisterEntityAsNetworked(nveh)
            while not NetworkGetEntityIsNetworked(nveh) do
                NetworkRegisterEntityAsNetworked(nveh)
                Citizen.Wait(1)
            end

            if NetworkDoesNetworkIdExist(netveh) then
                SetEntitySomething(nveh,true)
                if NetworkGetEntityIsNetworked(nveh) then
                    SetNetworkIdExistsOnAllMachines(netveh,true)
                end
            end

            NetworkFadeInEntity(NetToEnt(netveh),true)
            SetVehicleIsStolen(NetToVeh(netveh),false)
            SetVehicleNeedsToBeHotwired(NetToVeh(netveh),false)
            SetEntityInvincible(NetToVeh(netveh),false)
            SetVehicleNumberPlateText(NetToVeh(netveh), placa)
            SetEntityAsMissionEntity(NetToVeh(netveh),true,true)
            SetVehicleHasBeenOwnedByPlayer(NetToVeh(netveh),true)
            SetVehicleDoorsLocked(NetToVeh(netveh),2)

            SetVehicleEngineHealth(NetToVeh(netveh),motor+0.0)
            SetVehicleBodyHealth(NetToVeh(netveh),lataria+0.0)
            SetVehicleFuelLevel(NetToVeh(netveh),gasolina+0.0)

            src.tuningVehicle(custom,VehToNet(nveh))
            vehicles[string.lower(veiculo)] = true
        end

        return true
    end

    SetTimeout(240*1000, function() vehicles = {} end)
end

RegisterNUICallback('spawnCar', function(data)
    vSERVER.checkOwnerVehicle(data.id, data.vehicle, data.plate, data.motor, data.lataria, data.gasolina)
end)

RegisterNUICallback('storeCar', function()
    local veh = vRP.getNearestVehicle(10)
    if veh then
        vehicles[(GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower())] = false
        src.deleteVehicle(veh)
    end
end)

RegisterNUICallback('fechar', function()
    segundos = 3
    
    SetNuiFocus(false, false)
    TransitionFromBlurred(1000)
    SendNUIMessage({ show = false, js = "t20" })
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE BAU
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local time = 1000
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        if in_interior then
            if infoInterior.coordsBau ~= nil then
                local distance = #(pedCoords - infoInterior.coordsBau)
                if distance <= 5.0 then
                    time = 1
                    config.drawlable(infoInterior.houseID, infoInterior.coordsBau, "bau", propriedades[infoInterior.houseID].porta)

                    if IsControlJustReleased(1, 51) and segundos <= 0 and distance <= 1.5  then
                        if vSERVER.checkOpenPermission(infoInterior.houseID, infoInterior.proprietario) then
                            vSERVER._getBau(infoInterior.id, infoInterior.houseID, infoInterior.proprietario, infoInterior.tipo)
                        else
                            config.lang['notAccess']()
                        end
                    end
                end
            end
        end

        Citizen.Wait(time)
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE ARMARIO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local time = 1000
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        if in_interior then
            if infoInterior.coordsArmario ~= nil then
                local distance = #(pedCoords - infoInterior.coordsArmario)
                if distance <= 5.0 then
                    time = 1
                    config.drawlable(infoInterior.houseID, infoInterior.coordsArmario, "armario", propriedades[infoInterior.houseID].porta)

                    if IsControlJustReleased(1, 51) and segundos <= 0 and distance <= 1.5  then
                        segundos = 5
                        if vSERVER.checkOpenPermission(infoInterior.houseID, infoInterior.proprietario) then
                            local roupas = vSERVER.getArmario(infoInterior.id, infoInterior.houseID)

                            SetNuiFocus(true, true)
                            TransitionToBlurred(1000)
                            SendNUIMessage({ show = true, tipo = "armario", js = roupas, id = infoInterior.id, houseID = infoInterior.houseID })
                        else
                            config.lang['notAccess']()
                        end
                    end
                end
            end
        end

        Citizen.Wait(time)
    end
end)

RegisterNUICallback('salvarRoupa', function(data)
    segundos = 3
    vSERVER.CsalvarRoupa(data.id) 
end)

RegisterNUICallback('usarRoupa', function(data)
    segundos = 3
    vSERVER.usarRoupas(data.id, data.idRoupa) 
end)

RegisterNUICallback('deletarRoupa', function(data)
    segundos = 3
    vSERVER.deletarRoupa(data.id, data.idRoupa) 
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE MORADORES
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src.openNuiMoradores = function(houseID, id, moradores)
    SetNuiFocus(true, true)
    TransitionToBlurred(1000)
    SendNUIMessage({ show = true, tipo = "moradores", js = moradores, id = id, houseID = houseID })
end

RegisterNUICallback('addMorador', function(data)
    segundos = 3
    vSERVER.checkAddMorador(data.id, data.houseID) 
end)

RegisterNUICallback('remMorador', function(data)
    segundos = 3
    vSERVER.checkRemMorador(data.id, data.houseID, data.morador) 
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE CASAS/APARTAMENTOS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src.getStreetName = function (x,y,z)
    return GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))
end
    
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OTHERS FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x,y,z,text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    SetTextFont(4)
    SetTextScale(0.35,0.35)
    SetTextColour(255,255,255,150)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

Citizen.CreateThread(function()
    while true do

        if segundos <= 0 then
            segundos = 0
        else
            segundos = segundos - 1
        end

        Citizen.Wait(1000)
    end
end)

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end

function length(array)
    local len = 0
    for i in pairs(array) do 
        if array[i] then
            len = len+1
        end
    end
    return len
end    