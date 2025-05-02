-- Citizen.CreateThread(function()
--     Citizen.Wait(5000)

--     while true do
--         local vehiclesInfoCache = GlobalState.vehiclesInfoCache
--         local vehiclesExists = {}

--         for i, v in pairs(vehiclesInfoCache) do
--             if v.vnetid then
--                 if NetworkGetEntityFromNetworkId(parseInt(v.vnetid)) ~= 0 then
--                     vehiclesExists[i] = v
--                 end
--             end
--         end

--         GlobalState.vehiclesInfoCache = vehiclesExists

--         Citizen.Wait(3 * (1000 * 60))
--     end
-- end)