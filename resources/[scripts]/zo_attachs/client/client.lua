local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("zo_attachs", src)
vSERVER = Tunnel.getInterface("zo_attachs")

local open = false

local cam = nil
local objs = {}
local myGunsAndAttachs = nil

local beforeGunType = nil

local function f(n)
return (n + 0.00001)
end

local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

local function removeItemArray(tab, val)
    local newTab = {}
    for i, v in ipairs (tab) do 
        if v ~= val then
          table.insert(newTab, v)
        end
    end

    return newTab
end

local function removeAllAttachs()
    local guns = src.getWeapons()
    local ped = PlayerPedId()

    vSERVER.insertOrUpdate({})

    for k, v in pairs(guns) do
        if gunsAndAttachs[v] ~= nil then
            SetCurrentPedWeapon(ped, GetHashKey(v), true)
            SetPedWeaponTintIndex(ped, GetHashKey(v), 0)

            for i, g in pairs(gunsAndAttachs[v]) do
                if i ~= "nome" and i ~= "image" and i ~= "cor" then
                    for x, comp in ipairs(g) do
                        RemoveWeaponComponentFromPed(ped, GetHashKey(v), GetHashKey(comp.component))
                    end
                end
            end
        end
    end

    SetCurrentPedWeapon(ped, GetHashKey("weapon_unarmed"), true)
end

src.openNui = function(pPagarModificacao, pUseItem)
    local ped = PlayerPedId()
    if GetEntityHealth(ped) <= 101 then return end

    local mg, mgh, qtdGuns = src.returnMyGuns()
    local gun = GetSelectedPedWeapon(PlayerPedId())

    if qtdGuns > 0 then
        SetNuiFocus(true, true)
        open = true
        
        SendNUIMessage({ type = 'openAttachs', myGuns = mg, pagar = pPagarModificacao, usarItem = pUseItem , attachsDefault = attachsDefault, pGunsAndAttachs = gunsAndAttachs, gunSelected = mgh[gun] or nil })
    end
end

src.closeNui = function()
    open = false
    beforeGunType = nil
    cam = nil

    SetNuiFocus(false, false)
    RenderScriptCams(0, 0, cam, 0, 0)
    DestroyCam(cam, true)
    SetFocusEntity(PlayerPedId())

    SendNUIMessage({
        type = 'closeNui'
    })
end

src.sendNotify = function(title, msg, time)
    SendNUIMessage({ type = 'sendNotify', title = title, desc = msg, time = time })
end

src.getWeapons = function()
    local ped = PlayerPedId()
    local nWeapons = {}

    for k, v in pairs(gunsAndAttachs) do
        if HasPedGotWeapon(ped, GetHashKey(k)) then
            table.insert(nWeapons, k)
        end
    end

    return nWeapons
end

src.returnMyGuns = function()
    local ped = PlayerPedId()
    local guns = src.getWeapons()
    local myGuns = {}

    local atts = vSERVER.get()
    local myGunsHashFromName = {}
    local qtdGuns = 0

    if atts[1] then
        atts = atts[1]["attachs"]
    end

    for k, v in pairs(guns) do
        local newGun = {}
        qtdGuns = qtdGuns + 1

        local hashString = tostring(GetHashKey(v))

        newGun["nome"] = gunsAndAttachs[v].nome
        newGun["img"] = gunsAndAttachs[v].image
        newGun["gun"] = v

        if gunsAndAttachs[v] ~= nil then
            for i, g in pairs(gunsAndAttachs[v]) do
                if i ~= "nome" then
                    for x, comp in ipairs(g) do
                        if type(comp) == "table" then
                            for z, icomp in pairs(comp) do
                                if has_value(atts[hashString] or {}, icomp) then -- HasPedGotWeaponComponent(ped, GetHashKey(v), GetHashKey(icomp)) or 
                                    newGun[i] = icomp
                                end
                            end
                        else
                            if has_value(atts[hashString] or {}, comp) then -- HasPedGotWeaponComponent(ped, GetHashKey(v), GetHashKey(comp)) or
                                newGun[i] = comp
                            end
                        end
                    end
                end
            end

            myGunsHashFromName[GetHashKey(v)] = v
            myGuns[v] = newGun
        end
    end

    return myGuns, myGunsHashFromName, qtdGuns
end

Citizen.CreateThread(function()
    src.closeNui()
    
    for i, v in pairs(comandos) do
        RegisterCommand(v.comando, function(source, args, rawCommand)
            if vSERVER.checkPerms(v.perms) and not exports['vrp_policia']:getinSafe() then
                src.openNui(v.pagarPelaModificacao, v.usarItens)
            end
        end)
    end

    while true do
        local wait = 1000
        
        local px, py, pz = table.unpack(GetEntityCoords(PlayerPedId(), true))
        for _, data in pairs(blips) do
            if GetDistanceBetweenCoords(data.x, data.y, data.z, px, py, pz, true) <= 5 then
                wait = 5

                DrawMarker(21, data.x, data.y, data.z - 0.6 , 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 0, 300, 255, 0, 300, 0, 1)
                if IsControlJustPressed(1, 38) and GetDistanceBetweenCoords(data.x, data.y, data.z, px, py, pz, true) <= 2 and vSERVER.checkPerms(data.perms) then
                   src.openNui(data.pagarPelaModificacao, data.usarItens)
                end
            end
        end

        Citizen.Wait(wait)
    end
end)

function toggleAttachWeapon(weapon, attach)
    local ped = PlayerPedId()

    if type(attach) == "number" then
        SetPedWeaponTintIndex(ped, GetHashKey(weapon), attach)

        return true
    end
    
    if HasPedGotWeaponComponent(ped, GetHashKey(weapon), GetHashKey(attach)) then
        RemoveWeaponComponentFromPed(ped, GetHashKey(weapon), GetHashKey(attach))
        return false
    end

    GiveWeaponComponentToPed(ped, GetHashKey(weapon), GetHashKey(attach))
    return true
end

local registerNUICallbacks = {
    ["closeNui"] = function(data, cb)
src.closeNui() 
    end,

    ["setSelectedWeapon"] = function(data, cb)
local ped = PlayerPedId()
        local gun = GetHashKey(data.gun)
        local inVehicle = GetVehiclePedIsIn(ped, false)

        SetCurrentPedWeapon(ped, gun, true)

        myGunsAndAttachs = vSERVER.get()
        if myGunsAndAttachs[tostring(gun)] then
            for i, v in ipairs(myGunsAndAttachs[tostring(gun)]) do
                if type(v) == "number" then
                    SetPedWeaponTintIndex(PlayerPedId(), gun, v)
                else
                    GiveWeaponComponentToPed(PlayerPedId(), gun, GetHashKey(v))
                end
            end
        end

        if inVehicle == nil or inVehicle == 0 then
            local typeGun = (GetWeapontypeGroup(gun) == 416676503 or GetWeapontypeGroup(gun) == -728555052 or data.gun == "WEAPON_MICROSMG" or data.gun == "WEAPON_MACHINEPISTOL")
            
            if typeGun ~= beforeGunType then
                if typeGun then
                    MoveCam(ped, "gun", 1.5, 0.65, 0.25)
                else
                    MoveCam(ped, "gun", -0.5, 1.0, 0.5)
                end
            end
        end

        beforeGunType = typeGun
        cb({ inVehicle = (inVehicle == nil or inVehicle == 0) })
    end,

    ["toggleAttach"] = function(data, cb)
        local attach = toggleAttachWeapon(data.weapon, data.comp)
        
if not data.save or not attach then
            local tGuns = vSERVER.get()

            local hash = tostring(GetHashKey(data.weapon))

            if tGuns[hash] == nil then
                tGuns[hash] = {}
            end

            if attach then
                if type(data.comp) == "number" then
                    for i, k in pairs(tGuns[hash]) do
                        if type(k) == "number" then
                            removeItemArray(tGuns[hash], k)
                        end
                    end
                end

                table.insert(tGuns[hash], data.comp)
            else
                tGuns[hash] = removeItemArray(tGuns[hash], data.comp)
            end

            vSERVER.insertOrUpdate(tGuns)
        end
    end,

    ["removeAttachs"] = function(data, cb)
        local ped = PlayerPedId()
        local weapon = GetHashKey(data.weapon)

        for i, v in pairs(data.componentsRemove) do
            RemoveWeaponComponentFromPed(ped, weapon, GetHashKey(v))
        end
    end,

    ["aplicarAttachs"] = function(data, cb)
        local tGuns = vSERVER.get()

        local checkAttachs = function()
            local hash = tostring(GetHashKey(data.weapon))

            if tGuns[hash] == nil then
                tGuns[hash] = {}
            end

            for i, v in ipairs(data.comps) do
                if not toggleAttachWeapon(data.weapon, v.component) then
                    tGuns[hash] = removeItemArray(tGuns[hash], v.component)
                else
                    if type(v.component) == "number" then
                        for i, k in pairs(tGuns[hash]) do
                            if type(k) == "number" then
                                removeItemArray(tGuns[hash], k)
                            end
                        end
                    end

                    table.insert(tGuns[hash], v.component)
                end
            end
            
            vSERVER.insertOrUpdate(tGuns)

            local mg, mgh = returnMyGuns()
            SendNUIMessage({ type = 'resetAlters', myGuns = mg })
        end

        local aplicarAttachs = true
        local attachsAplicados = data.attachsOwned

        if data.totalPrice > 0 then
            aplicarAttachs = vSERVER.checkPayment(data.totalPrice, data.weapon)

            if not aplicarAttachs then
                src.sendNotify("Ops", "Dinheiro insuficiente para realizar todas as alterações", 5000)
            end
        end

        if data.useItens then
            aplicarAttachs = vSERVER.checkContainsAttachs(data.attachsCheckedAndType, data.weapon)

            if not aplicarAttachs then
                src.sendNotify("Ops", "Componentes insuficientes para realizar todas as alterações", 5000)
            end
        end

        if aplicarAttachs then
            local hash = tostring(GetHashKey(data.weapon))
            if tGuns[hash] == nil then
                tGuns[hash] = {}
            end

            for i, c in pairs(attachsAplicados) do
                table.insert(tGuns[hash], c)
            end
            
            vSERVER.insertOrUpdate(tGuns)
            src.sendNotify("Sucesso", "Todas as alterações foram registradas", 5000)
        else
            for i, v in pairs(attachsAplicados) do
                local ped = PlayerPedId()
                RemoveWeaponComponentFromPed(ped, data.weapon, GetHashKey(v))
            end
        end

        local mg, mgh = src.returnMyGuns()
        local gun = GetSelectedPedWeapon(PlayerPedId())

        cb(mg[mgh[gun]])
    end
}

Citizen.CreateThread(function()
    for i, f in pairs(registerNUICallbacks) do
        RegisterNUICallback(i, function(data, cb)
            f(data, cb)
        end)
    end
end)

AddEventHandler('gameEventTriggered', function(event, args)
    local actionFromEvent = {
        ["CEventNetworkEntityDamage"] = function(event, args)
            local ped = args[1]

            if not IsEntityAPed(ped) or not config.perderAttachsAoMorrer then return end

            if GetEntityHealth(ped) <= 101 then
                removeAllAttachs()
            end
        end,
    }

    if actionFromEvent[event] then
        actionFromEvent[event](event, args)
    end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 100
        
        if IsPedSwappingWeapon(PlayerPedId()) and not open then
            local weaponSelecting = GetSelectedPedWeapon(PlayerPedId())
            myGunsAndAttachs = vSERVER.get()

            if myGunsAndAttachs[tostring(weaponSelecting)] then
                for i, v in ipairs(myGunsAndAttachs[tostring(weaponSelecting)]) do
                    if type(v) == "number" then
                        SetPedWeaponTintIndex(PlayerPedId(), weaponSelecting, v)
                    else
                        GiveWeaponComponentToPed(PlayerPedId(), weaponSelecting, GetHashKey(v))
                    end
                end
            end
        end

        Citizen.Wait(wait)
    end
end)

function MoveCam(ent, pos, x, y, z)
    if cam == nil then 
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true, 2)
        SetCamActive(cam, true)
    end

local vx, vy, vz = table.unpack(GetEntityCoords(ent))
local d = GetModelDimensions(GetEntityModel(ent))

local length, width, height = d.y * -2, d.x * -2, d.z * -2
local ox, oy, oz

if pos == "gun" then
ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(ent, f(x), (length/2) + f(y), f(z)))
    elseif pos == "guna" then
ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(ent, f(x), (length / 2) + f(y) + 1.0, f(z)))
end
    
SetCamCoord(cam, ox, oy, oz)
    PointCamAtCoord(cam, GetOffsetFromEntityInWorldCoords(ent, 0, 0, f(0)))
    
    RenderScriptCams(0, 1, 1000, 0, 0)
RenderScriptCams(1, 1, 1000, 0, 0)
end