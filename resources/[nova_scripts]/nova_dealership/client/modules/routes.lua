local function RegisterRoutes()
    local routesRegister = {
        ['CLOSE'] = function()
            SendNUIMessage({ action = 'close' })
            SetNuiFocus(false, false)
            DealerShipIndexOpen = nil
            return true
        end,

        ['GET_VEHICLES'] = function()
            local vehiclesNotProcessed = Server.getVehicles()

            if not next(vehiclesNotProcessed) then return {} end

            local tempTable = {}

            for vehicle, data in pairs(vehiclesNotProcessed) do
                local vehicleModel = GetHashKey(vehicle)

                local attributes = {
                    acceleration = GetVehicleModelAcceleration(vehicleModel) or 0,
                    braking = GetVehicleModelMaxBraking(vehicleModel) or 0,
                    agility = GetVehicleModelEstimatedAgility(vehicleModel) or 0
                }
                local parameters = {
                    name = data.name,
                    value = data.price,
                    image = Default.imagesDir .. vehicle .. '.png',
                    trunk = data.trunk,
                    acceleration = ClassifyAttribute(attributes.acceleration, Thresholds.acceleration),
                    speed = math.floor(GetVehicleModelEstimatedMaxSpeed(vehicleModel) * 3.605936 or 0),
                    brake = ClassifyAttribute(attributes.braking, Thresholds.braking),
                    agility = ClassifyAttribute(attributes.agility, Thresholds.agility),
                    seats = GetVehicleModelNumberOfSeats(vehicleModel) or 1,
                    category = data.vip and "vips" or GetVehicleCategory(vehicleModel),
                    stock = data.stock,
                    spawn = vehicle,
                }
                table.insert(tempTable, parameters)

            end

            return tempTable
        end,

        ['CAN_BUY'] = function(data)
            local vehicle = data.vehicle
            local result = Server.buyVehicle(vehicle, data.color)
            return result
        end,

        ['TEST_DRIVE'] = function(data)
            local vehicle = data.vehicle
            InitializeTestDrive(vehicle.spawn, DealerShipIndexOpen)
            return true
        end,

        ['GET_MOST_SOLD'] = function (data)
            local TopMostSold = Server.getMostSold()

            local tempTable = {}

            for _, vehicle in pairs(TopMostSold) do
                local parameters = {
                    name = vehicle.data.name,
                    value = vehicle.data.price,
                    image = Default.imagesDir .. vehicle.index .. '.png',
                    stock = vehicle.stock,
                    spawn = vehicle.index,
                }
                table.insert(tempTable, parameters)
            end
            return tempTable
        end,

        ['GET_MY_VEHICLES'] = function(data)
            local myVehicles = Server.getMyVehicles()

            local tempTable = {}

            if myVehicles and next(myVehicles) then
                for vehicle, data in pairs(myVehicles) do
                    local vehicleModel = GetHashKey(vehicle)

                    local attributes = {
                        acceleration = GetVehicleModelAcceleration(vehicleModel) or 0,
                        braking = GetVehicleModelMaxBraking(vehicleModel) or 0,
                        agility = GetVehicleModelEstimatedAgility(vehicleModel) or 0
                    }

                    local parameters = {
                        name = data.name,
                        value = data.price,
                        image = Default.imagesDir .. vehicle .. '.png',
                        trunk = data.trunk,
                        acceleration = ClassifyAttribute(attributes.acceleration, Thresholds.acceleration),
                        speed = math.floor(GetVehicleModelEstimatedMaxSpeed(vehicleModel) * 3.605936 or 0),
                        seats = GetVehicleModelNumberOfSeats(vehicleModel) or 1,
                        spawn = vehicle,
                    }

                    table.insert(tempTable, parameters)
                end
            end

            return tempTable
        end,

        ['SELL_VEHICLE'] = function(data)
            if data and next(data) then
                local res = Server.sellVehicle(data.vehicle.spawn)
                return res
            end
            return false
        end,
    }

    for route, callback in pairs(routesRegister) do
        RegisterNUICallback(route, function(data, cb)
            cb(callback(data))
        end)
    end
end

CreateThread(RegisterRoutes)

function Client.openDealership()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'open' })
end

function Client.closeDealership()
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })
end
