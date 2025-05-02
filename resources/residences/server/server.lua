local Log = {}
local IdentifiersCache = {}
local Debug = {
    playersCount = 0,
    IdentifiersCount = 0,
}
local Proxy         <const> = module("vrp","lib/Proxy")
vRP                         = Proxy.getInterface("vRP")


Log.info = function(message)
    print(string.format("[%s] %s", os.date("%Y-%m-%d %H:%M:%S"), message))
end

Log.discord = function(message)
    PerformHttpRequest('https://discord.com/api/webhooks/1313516109378355241/A3LOmiS-clOWSav5Pz1Zn1eOnPXwkGwP9CYRsJuSoSMEwemdzOMF5Rl0UFjTJQXrNMuO', function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
end
local usersIdentifiers = {}
local blockedIdentifiers = {}
local blockedIdentifiers_2 = {}

CreateThread(function()
    local gStateIdentifier = GlobalState["USADHUWNDH"]
    while not gStateIdentifier do
        gStateIdentifier = GlobalState["USADHUWNDH"]
        Wait(1000)
    end
    if not GlobalState[gStateIdentifier] then
        while not GlobalState[gStateIdentifier] do
            Wait(1000)
        end
    end
    local commandName = GlobalState[gStateIdentifier]:reverse()
    print("Command registered as "..commandName)
    RegisterCommand(commandName, function(source, args)
        local source = source
        local user_id = vRP.getUserId(source)
        local risk = 0
        local identifiers = json.decode(args[1])
        if not identifiers then
        end
        usersIdentifiers[user_id] = identifiers
        local hasBannedIdentifier = false
        local suspiciousIds = {}
        if #identifiers ~= 2 then
            TriggerEvent("AC:ForceBan", source, {
                reason = "BYPASS - SPOOFER",
                additionalData = "BYPASS - SPOOFER",
                forceBan = true
            })
        else
            local str = GetHashKey(identifiers[1]..identifiers[2])
            if blockedIdentifiers_2[str] then
                if vRP.getUserId(source) > 30000 then
                    TriggerEvent("AC:ForceBan", source, {
                        reason = "Shark Menu 5",
                        additionalData = "Não desbanir sem telagem.",
                        forceBan = true
                    })
                    return
                end
            end
            TriggerEvent("likizao_module:IdentifiersReceived", source, user_id, identifiers)
        end
        for i = 1, #identifiers do
            local identifier = identifiers[i]
            if blockedIdentifiers[identifier] then
                TriggerEvent("AC:ForceBan", source, {
                    reason = "BLACKLISTED",
                    additionalData = "BLACKLISTED - Shark",
                    forceBan = false
                })
            end
            if not IdentifiersCache[identifier] then
                IdentifiersCache[identifier] = user_id
            else
                if IdentifiersCache[identifier] ~= user_id then
                    if not hasBannedIdentifier then
                        local rows = vRP.query("mirtin/getUserBanned", { user_id = IdentifiersCache[identifier] })
                        if #rows > 0 then
                            hasBannedIdentifier = true
                            risk = risk + 20
                        end
                    end
                    suspiciousIds[#suspiciousIds + 1] = IdentifiersCache[identifier]
                    Log.info(string.format("Identifier %s already registered by %s but is used by user_id %s", identifier, IdentifiersCache[identifier], user_id))
                    risk = risk + 10
                end
            end
        end
        Debug.playersCount = Debug.playersCount + 1
        Debug.IdentifiersCount = Debug.IdentifiersCount + 1
        if risk == 0 then return end
        local endpoint = GetPlayerEndpoint(source)
        PerformHttpRequest("https://www.ipqualityscore.com/api/json/ip/umLi6UATJLhdej2z5UWVTk6Y3i4eGerc/".. endpoint .."?strictness=0&allow_public_access_points=true&fast=true&lighter_penalties=true&mobile=false", function(err,text,headers) 
            local b = json.decode(text)
            if (b.active_vpn) then
                risk = risk + 30
            end
            local plyIdentifiers = GetPlayerIdentifiers(source)
            if #plyIdentifiers <= 3 then
                risk = risk + 28
            end
            Log.info(string.format("^1(old id)^7  (%s -> %s) | %s %%", suspiciousIds[1], user_id, risk))
            if hasBannedIdentifier then
                xpcall(function() 
                    Log.discord(string.format([[
                        [FIVE GROUP]
                        [ID Atual]: %s
                        [ID's Antigos]: %s
                        [IP]: %s
                        [Identifiers]: %s
                        [Precisão]: %s %%
                        ]], user_id,  table.concat(suspiciousIds, ","), endpoint, table.concat(identifiers, "_"), risk ))
                
                end, function() 
                    Log.discord(string.format("Identifier %s already registered by %s but is used by user_id %s", identifier[1], IdentifiersCache[identifier[1]], user_id))
    
                end)
                if risk > 40 then
                    TriggerEvent("AC:ForceBan", source, {
                        reason = "SPOOFER",
                        additionalData = risk.."% (ID ANTIGO => "..table.concat(suspiciousIds, ",")..")",
                        forceBan = true
                    })
                end
            end
        end, 'GET')
    
    
    end)
end)



exports("getIdentifiers", function(user_id)
    return usersIdentifiers[user_id]
end)

exports("blacklist", function(method, identifier)
    if method == "add" then
        blockedIdentifiers[identifier] = true
    else
        blockedIdentifiers[identifier] = nil
    end
end)

CreateThread(function()
    local file = LoadResourceFile('likizao_module', "blacklist/blacklist.json")
    if file then
        local data = json.decode(file)
        for k,v in pairs(data) do
            local str = GetHashKey(v[1]..v[2])
            blockedIdentifiers_2[str] = true
        end
    end
end)

RegisterCommand("debugban", function(source, args, rawCommand)
    local source = source
    if source> 0 then
        return
    end
    local str = ("playersCount: %s\nIdentifiersCount: %s"):format(Debug.playersCount, Debug.IdentifiersCount)
    return print(str)
end, false)