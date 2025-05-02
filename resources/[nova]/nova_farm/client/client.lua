local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')

ClientAPI = {}
Tunnel.bindInterface(GetCurrentResourceName(), ClientAPI)
ServerAPI = Tunnel.getInterface(GetCurrentResourceName())

local actualRoute = nil
local actualRegion = nil
local actualBlip = nil
local routeBlip = nil

--- @param x number
--- @param y number
--- @param z number
--- @param text string
--- @return void
local function DrawText3D(x, y, z, text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 400
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,140)
end

--- @return void
local function removeBlip()
    if routeBlip and DoesBlipExist(routeBlip) then
        RemoveBlip(routeBlip)
        routeBlip = nil
    end
end

--- @param coords vector3
--- @return void
local function createBlip(coords)
    removeBlip()
    routeBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
	SetBlipSprite(routeBlip,433)
	SetBlipColour(routeBlip,5)
	SetBlipScale(routeBlip,0.4)
	SetBlipAsShortRange(routeBlip,false)
	SetBlipRoute(routeBlip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Destino")
	EndTextCommandSetBlipName(routeBlip)
end

--- @return void
local function endRoute()
    actualRoute = nil
    actualRegion = nil
    actualBlip = nil
    removeBlip()
    ServerAPI.finishRoute()
end

--- @param routes table
--- @return void
function ClientAPI.openRoutes(routes)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
        routes = routes
    })
end

--- @param route number
--- @param region string
--- @return void
function ClientAPI.startRoute(route, region)
    actualRoute = route
    actualRegion = region
    actualBlip = 1
    local firstBlipCoords = Config.RouteBlips[actualRoute][actualRegion][actualBlip].coords
    createBlip(firstBlipCoords)
end

--- @param text string
--- @param x number
--- @param y number
--- @return void
function drawTxt(text, x, y)
    local res_x, res_y = GetActiveScreenResolution()

    SetTextFont(4)
    SetTextScale(0.3,0.3)
    SetTextColour(255,255,255,255)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)

    if res_x >= 2000 then
        DrawText(x+0.076,y)
    else
        DrawText(x,y)
    end
end

RegisterNUICallback('boost', function(data, cb)
    ServerAPI.boostRoute()
    SendNUIMessage({ action = 'close' })
    SetNuiFocus(false, false)
    cb(true)
end)

RegisterNUICallback('start', function(data, cb)
    local route = data.route.name
    local region = data.region
    if not route or not region then
        return
    end
    ServerAPI.startRoute(route, region)
    cb(true)
    SendNUIMessage({ action = 'close' })
    SetNuiFocus(false, false)
end)

RegisterNUICallback('close', function(data, cb)
    SendNUIMessage({ action = 'close' })
    SetNuiFocus(false, false)
    cb(true)
end)

RegisterCommand('+cancelroute', function(source, args)
    if actualRoute then
        endRoute()
    end
end)

CreateThread(function()
    while true do 
        local timeDistance = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for k, v in ipairs(Config.Routes) do
            local distance = #(coords - v.coords)
            if distance <= 2.0 then
                timeDistance = 0
                DrawText3D(v.coords.x, v.coords.y, v.coords.z, 'Pressione ~g~E~w~ para acessar as rotas.')
                DrawMarker(27, v.coords.x, v.coords.y, v.coords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 0)
                if IsControlJustPressed(0, 38) then
                    ServerAPI.openRoutes(k)
                end
            end
        end
        Wait(timeDistance)
    end
end)

CreateThread(function()
    while true do
        local timeDistance = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        if actualRoute and actualBlip then
            local actualBlipCoords = Config.RouteBlips[actualRoute][actualRegion][actualBlip].coords
            local distance = #(actualBlipCoords - coords)
            if distance <= 2.0 then
                timeDistance = 0
                DrawText3D(actualBlipCoords.x, actualBlipCoords.y, actualBlipCoords.z, 'Pressione ~g~E~w~ para coletar.')
                DrawMarker(27, actualBlipCoords.x, actualBlipCoords.y, actualBlipCoords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 0)
                if IsControlJustPressed(0, 38) then
                    if ServerAPI.collectRoute(actualRoute, actualRegion, actualBlip) then
                        actualBlip = actualBlip + 1
                        if actualBlip > #Config.RouteBlips[actualRoute][actualRegion] then
                            actualBlip = 1
                        end
                        if actualBlip > 0 then
                            local nextBlipCoords = Config.RouteBlips[actualRoute][actualRegion][actualBlip].coords
                            createBlip(nextBlipCoords)
                        else
                            endRoute()
                        end
                    end
                end
            end
        end
        Wait(timeDistance)
    end
end)

CreateThread(function()
    while true do
        local timeDistance = 1000
        if actualRoute and actualBlip then
            timeDistance = 0
            drawTxt("~w~Aperte ~r~F7~w~ se deseja finalizar o expediente.", 0.215,0.94)
        end
        Wait(timeDistance)
    end
end)

RegisterKeyMapping('+cancelroute', 'Cancelar rota', 'keyboard', 'F7')

function DrawText3DAlways(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if not onScreen then
        return
    end

    local playerCoords = GetEntityCoords(PlayerPedId())
    local distance = #(playerCoords - vector3(x, y, z))
    local scale = 1.0 / math.max(distance, 1.0) * 2.0
    scale = math.min(scale, 0.35)
    scale = math.max(scale, 0.2)

    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(_x, _y)
end

local function getCoordsByPermission(org)
    for _, data in ipairs(Config.Routes) do
        if data.permissions[1] == 'perm.'..(org):lower() then
            return data.coords
        end
    end

    return nil
end

RegisterNetEvent('routes:showBlips', function(org)
    CreateThread(function()
        local coords = getCoordsByPermission(org)
        if not coords then return end

        local endTime = GetGameTimer() + (1000 * 60 * 2)
        while GetGameTimer() < endTime do
            Wait(0)
            DrawText3DAlways(coords.x, coords.y, coords.z + 1.0, "Rota")
        end
    end)
end)