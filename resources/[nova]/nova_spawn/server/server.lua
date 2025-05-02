function API.GetUserData()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local rows = vRP.getUData(user_id, "vRP:datatable")
        if rows then
            local data = json.decode(rows) or {}
            if data then
                return data
            end
        end
    end
    return false
end

RegisterCommand("bucket", function(source, args, rawCommand)
    local source = source
    TriggerClientEvent("Notify",source,"Você está na bucket "..GetPlayerRoutingBucket(source))
end, false)

function API.setBucket(status)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id  then
        if status then 
            SetPlayerRoutingBucket(source, source)

            -- Aditional Verification
            if GetPlayerRoutingBucket(source) ~= source then
                SetPlayerRoutingBucket(source, source)
            end
        else
            SetPlayerRoutingBucket(source, 0)
        end
    end
end

local function hasOrg(id)
    for index, _ in pairs(Config.Orgs_Spawns) do
        if vRP.hasPermission(tonumber(id),index) then 
            return true, index
        end
    end
    return false
end

function API.GetOrg()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return hasOrg(user_id)
    end
    return false
end