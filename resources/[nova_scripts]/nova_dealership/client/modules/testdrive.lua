VehicleEntityCode = 0
InTestDrive = false
CountTestDrive = 0

function InitializeTestDrive(vehicle, indexLocation)
    if type(vehicle) ~= 'string' or type(indexLocation) ~= 'number' then return end

    local location = TestDrive.Locations[indexLocation]

    if not location then return end

    local vehicleHash = GetHashKey(vehicle)

    while not HasModelLoaded(vehicleHash) do
        RequestModel(vehicleHash)
        Wait(200)
    end

    DoScreenFadeOut(500)

    Server.setDimension(true, indexLocation)

    Wait(1000)

    SetEntityCoords(PlayerPedId(), location.test_drive.x, location.test_drive.y, location.test_drive.z)
    Wait(500)

    local vehicleEntity = CreateVehicle(vehicleHash, location.test_drive.x, location.test_drive.y, location.test_drive.z, location.test_drive.w, false)

    if vehicleEntity then

        Client.closeDealership()

        while not DoesEntityExist(vehicleEntity) do
            Wait(200)
        end

        if not IsEntityAVehicle(vehicleEntity) then
            return
        end

        SetVehicleNumberPlateText(vehicleEntity, "TEST-DRIVE")
        SetEntityAsMissionEntity(vehicleEntity, true, true)
        SetVehicleOnGroundProperly(vehicleEntity)
        SetVehRadioStation(vehicleEntity, "OFF")
        SetVehicleDirtLevel(vehicleEntity, 0.0)
        SetVehicleDoorsLocked(vehicleEntity, 2)
        SetPedIntoVehicle(PlayerPedId(), vehicleEntity, -1)
        SetVehicleEngineHealth(vehicleEntity, 1000.0)
        SetVehicleBodyHealth(vehicleEntity, 1000.0)
        SetVehicleFuelLevel(vehicleEntity, 100.0)
        SetModelAsNoLongerNeeded(vehicleHash)
        DoScreenFadeIn(300)


        VehicleEntityCode = vehicleEntity

        InTestDrive = true
        CountTestDrive = TestDrive.cooldownTestDriver

        local function returnToLocation()
            InTestDrive = false

            Server.setDimension(false, indexLocation)

            if VehicleEntityCode > 0 then
                DeleteEntity(VehicleEntityCode)
                VehicleEntityCode = 0
            end
            DoScreenFadeOut(500)
            Wait(1000)

            SetEntityCoords(PlayerPedId(), location.coords.x, location.coords.y, location.coords.z)
            
            Wait(1000)
            Client.openDealership()
            DoScreenFadeIn(300)
        end

        CreateThread(function()
            if not IsPedInAnyVehicle(PlayerPedId(), false) then
                TaskWarpPedIntoVehicle(PlayerPedId(),vehicleEntity,-1)
            end
            local gameTimer = GetGameTimer()
            while InTestDrive do
                DrawTXT("Para cancelar o test-driver pressione ~r~F6",4,0.5,0.93,0.50,255,255,255,120)
                DrawTXT("Tempo restante: ~b~"..CountTestDrive.."~w~ segundo(s)",4,0.5,0.96,0.50,255,255,255,120)

                if IsControlJustPressed(0, 167) then
                    returnToLocation()
                end

                if not IsPedInAnyVehicle(PlayerPedId(), false) then
                    returnToLocation()
                end

                if CountTestDrive <= 0 then
                    returnToLocation()
                end

                if GetGameTimer() - gameTimer >= 1000 then
                    gameTimer = GetGameTimer()
                    if CountTestDrive > 0 then
                        CountTestDrive = CountTestDrive - 1
                    end
                end

                Wait(0)
            end
        end)
    end
end