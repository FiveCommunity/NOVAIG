---@param inputstr string
---@param sep string
---@return table<string>
string.split = function(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

-- CreateThread(function() 
--     local user_id = 67528

--     print(json.encode(vRP.getWeapons(user_id)))
-- end)




-- AddEventHandler("weaponDamageEvent", function(sender,ev)
--     xpcall(function()
--         print("run")
--         local network_id = assert(ev.hitGlobalId,"network_id is nil")
--         local entity = NetworkGetEntityFromNetworkId(network_id)
--         if entity --[[and IsPedAPlayer(entity)]] then 
--         print("a")
--             --[[
--                 local target_src = NetworkGetFirstEntityOwner(entity)
--                 if not target_src then
--                     return
--                 end
--             ]]
--             local weaponHash = ev.weaponType
--             print(json.encode(ev))
--             local weapon = weapons_list[weaponHash]
--             print(weaponHash)
--             if not weapon then
--                 print("not weapon")
--                 return
--             end
--         end
--     end, function() end)
-- end)