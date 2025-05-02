local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')

Client = {}
Tunnel.bindInterface(GetCurrentResourceName(), Client)
Server = Tunnel.getInterface(GetCurrentResourceName())

DealerShipIndexOpen = nil


CreateThread(function()
    while true do
        local THREAD_TIMER = 1000
        local playerCoords = GetEntityCoords(PlayerPedId())

        for locationIndex, location in pairs(TestDrive.Locations) do
            local distance = #(playerCoords - location.coords)
            if distance <= 15.0 then
                THREAD_TIMER = 5
                DrawMarker(36, location.coords.x, location.coords.y, location.coords.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 131, 133, 132, 155, 1, 1, 1, 1)
                DrawMarker(27, location.coords.x, location.coords.y, location.coords.z - 0.97, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 131, 133, 132, 155, 0, 0, 0, 1)

                if IsControlJustPressed(0, 38) and distance < 2 then
                    Client.openDealership()
                    DealerShipIndexOpen = locationIndex
                end
            end
        end
        Wait(THREAD_TIMER)
    end
end)

-- RESOURCE FUNCTIONS
function DrawTXT(text,font,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end


Thresholds = {
    acceleration = { good = 1.5, medium = 0.7 },
    maxspeed = { good = 200, medium = 90 },
    braking = { good = 1.0, medium = 0.5 },
    agility = { good = 0.8, medium = 0.4 }
}

function ClassifyAttribute(value, thresholds)
    if value >= thresholds.good then
        return "bom"
    elseif value >= thresholds.medium then
        return "médio"
    else
        return "ruim"
    end
end

function GetVehicleCategory(vehicleModel)
    local category = GetVehicleClassFromName(vehicleModel)

    local categories = {
        [0] = "outros",        -- Compact
        [1] = "sedan",         -- Sedan
        [2] = "esportivos",    -- SUVs
        [3] = "esportivos",    -- Coupes
        [4] = "esportivos",    -- Muscle
        [5] = "esportivos",    -- Sports Classics
        [6] = "esportivos",    -- Sports
        [7] = "esportivos",    -- Super
        [8] = "motos",         -- Motorcycles
        [9] = "off-roads",     -- Off-road
        [10] = "outros",       -- Industrial
        [11] = "outros",       -- Utility
        [12] = "vans",         -- Vans
        [13] = "caminhoes",    -- Cycles
        [14] = "outros",    -- Boats
        [15] = "aeronaves",    -- Helicopters
        [16] = "aeronaves",    -- Planes
        [17] = "off-roads",    -- Service
        [18] = "outros",       -- Emergency
        [19] = "outros",       -- Military
        [20] = "caminhoes",    -- Commercial
        [21] = "outros"        -- Trains
    }

    return categories[category] or "outros"
end