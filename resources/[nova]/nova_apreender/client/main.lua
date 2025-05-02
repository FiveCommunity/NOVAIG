local function doPed(hash, coords)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(10)
    end
    local ped = CreatePed(4, hash, coords.x, coords.y, coords.z - 1.0, coords.w or 100.0, false, false)
    SetEntityAsMissionEntity(ped, true, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    PlaceObjectOnGroundProperly(ped, true)
    SetTimeout(3000, function()
        FreezeEntityPosition(ped, true)
    end)
    return ped
end


function Draw2DText(x, y, width, height, scale, text, r, g, b, a)
    SetTextFont(6)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 200)
    SetTextDropShadow()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

CreateThread(function()
    for org, tbl in pairs(Config.Coords) do
        local formatedVector = vec4(tbl[1].x, tbl[1].y, tbl[1].z, tbl[2])
        Config.Coords[org][3] = doPed(Config.pedModel, formatedVector)
    end
    while true do
        local sleep = 1e3
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for org, tbl in pairs(Config.Coords) do
            local distance = #(coords - tbl[1])
            if distance < 100 then
                if not DoesEntityExist(tbl[3]) then
                    tbl[3] = doPed(Config.pedModel, tbl[1])
                end
            end
            if distance < 6 then
                sleep = 0
                DrawText3D(tbl[1].x, tbl[1].y, tbl[1].z + 0.2, '~r~[E]~w~ Apreensao')
                if distance <= 2 and IsControlJustReleased(0, 38) then
                    local res, err = Remote.exchangeItem(org)
                    TriggerEvent("Notify", res and "sucesso" or "negado", err)
                    Wait(2e3)
                end
            end
        end
        Wait(sleep)
    end
end)


function DrawText3D(x, y, z, text)
    SetTextFont(4)
    SetTextCentre(1)
    SetTextEntry("STRING")
    SetTextScale(0.35, 0.35)
    SetTextColour(255, 255, 255, 150)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text) / 450) + 0.01
    DrawRect(0.0, 0.0125, factor, 0.03, 10, 10, 10, 120)
    ClearDrawOrigin()
end

function GetMinimapAnchor()
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.left_x + Minimap.width
    Minimap.top_y = Minimap.bottom_y - Minimap.height
    Minimap.x = Minimap.left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end
