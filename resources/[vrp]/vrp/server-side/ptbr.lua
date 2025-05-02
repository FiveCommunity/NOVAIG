-- This file was protected using Luraph Obfuscator v14.4.1 [https://lura.ph/]

local patrulhamento = {}

function vRP.setPatrulhamento(user_id)
	patrulhamento[user_id] = true
end

function vRP.removePatrulhamento(user_id)
    patrulhamento[user_id] = nil
end

function vRP.checkPatrulhamento(user_id)
	return patrulhamento[user_id]
end

function alertPolice(data)
    local policia = vRP.getUsersByPermission("perm.countpolicia") 
    if #policia > 0 then
        for k,v in pairs(policia) do
            local nsource = vRP.getUserSource(parseInt(v))
            if nsource then
                if vRP.checkPatrulhamento(parseInt(v)) then
                    TriggerClientEvent("NotifyPush", nsource, { x = data.x, y = data.y, z = data.z, blipID = data.blipID, blipColor = data.blipColor, blipScale = data.blipScale, time = data.time, code = data.code, title = data.title, name = data.name })
                end
            end
        end
    end
end

exports("alertPolice", function(...)
    alertPolice(...)
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CHECAGENS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
    local data = vRP.getUserDataTable(user_id)
    if patrulhamento[user_id] then
        if not vRP.hasPermission(user_id, "perm.tunar") or not vRP.hasPermission(user_id, "perm.unizk") then
            if data then
                data.weapons = {}
            end
        end

        patrulhamento[user_id] = nil
    end
end)