--- Config Variables

local ADMIN_PERMISSION <const> = "admin.permissao"
local ADMIN_COMMAND <const> = "liberardc"


vRP._prepare("lotus_access/getAllowed", 'SELECT discord FROM lotus_access WHERE discord = @discord')
vRP._prepare("lotus_access/insert", 'INSERT INTO lotus_access (discord, admin) VALUES (@discord, @admin)')

vRP._prepare("lotus_access/createTable", 'CREATE TABLE IF NOT EXISTS lotus_access (discord VARCHAR(255) PRIMARY KEY, admin INT)')
CreateThread(function()
    vRP._execute("lotus_access/createTable")
end)

---@type table<string, boolean>
local DiscordCache <const> = {}

---@type table<number, string>
local UsersInNui <const> = {}

---@param source number
---@return string|false
local function getDiscord(source)
    local identifier = GetPlayerIdentifierByType(source, "discord")
    if identifier then
        return identifier:gsub("discord:", "")
    end
    return false
end

---@param discord string
---@return boolean
local function isDiscordValid(discord)
    if type(discord) ~= "string" then return false end
 --   if string.len(discord) ~= 18 then return false end
    return true
end

---@param discord string
---@return boolean, string
local function isDiscordAuthorized(discord)
    if not isDiscordValid(discord) then return false, "Discord não vinculado" end
    -- prevent spamming query
    if DiscordCache[discord] then
        return DiscordCache[discord], (not DiscordCache[discord]) and "Discord não autorizado" or "Discord autorizado"
    end

    local authorized = vRP.query("lotus_access/getAllowed", {discord = discord})
    DiscordCache[discord] = #authorized > 0
    if #authorized == 0 then return false, "Discord não autorizado" end
    return true
end

---@param discord string
---@param staffId number
---@return boolean, string
local function authorizeDiscord(discord, staffId)
    if not isDiscordValid(discord) then return false, "Discord inválido (" .. discord .. ")" end
    local authorized = vRP.query("lotus_access/getAllowed", {discord = discord})
    if #authorized == 0 then
        vRP._execute("lotus_access/insert", {discord = discord, admin = staffId})
    end
    DiscordCache[discord] = true
    return true
end

RegisterCommand(ADMIN_COMMAND, function(source, args, raw)
    local source = source
    local hasPermission = false
    local user_id = 0
    if source == 0 then
        hasPermission = true
    else
        user_id = vRP.getUserId(source)
        hasPermission = vRP.hasPermission(user_id, ADMIN_PERMISSION)
    end
    if #args < 1 then
        if source == 0 then
            print("Uso: /" .. ADMIN_COMMAND .. " <discord>")
        else
            TriggerClientEvent("Notify", source, "negado", "Uso: /" .. ADMIN_COMMAND .. " <discord>")
        end
        return
    end
    if hasPermission then
        local discord = args[1]
        local res, msg = authorizeDiscord(discord, user_id)
        if res then
            if source == 0 then
                print("Discord autorizado com sucesso: " .. discord)
            else
                TriggerClientEvent("Notify", source, "sucesso", "Discord autorizado com sucesso: " .. discord)
            end
        else
            if source == 0 then
                print("Erro ao autorizar o discord: " .. msg)
            else
                TriggerClientEvent("Notify", source, "negado", "Erro ao autorizar o discord: " .. msg)
            end
        end
    end
end)

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
        -- local discord = getDiscord(source)
        -- local res, msg = isDiscordAuthorized(discord)
        -- if res then
        --     TriggerEvent("lotus_access:authorized", user_id, source,first_spawn)
        -- else
        --     Player(source).state:set("waitDiscordAuth", true, false)
        --     UsersInNui[source] = discord
        --     SetPlayerRoutingBucket(source, source)
        --     TriggerClientEvent("lotus_access:open", source, msg)
        -- end
        TriggerEvent("lotus_access:authorized", user_id, source,first_spawn)
    end
end)

local bucketWarnings = {}
AddEventHandler("playerDropped", function()
    UsersInNui[source] = nil
end)


--- kick player if they are in the wrong bucket & force vec3(0.0, 0.0, 0.0)
CreateThread(function()
    while true do
        Wait(2000)
        for source, discord in pairs(UsersInNui) do
            if DiscordCache[discord] then
                print("Usuário liberado para entrar na cidade (Discord autorizado: " .. discord .. ")")
                SetPlayerRoutingBucket(source, source)
                TriggerClientEvent("lotus_access:close", source)
                TriggerEvent("lotus_access:authorized", vRP.getUserId(source), source, true)
                UsersInNui[source] = nil
            else
                local ped = GetPlayerPed(source)
                SetEntityCoords(ped, 0, 0, 0)
                local bucket = GetPlayerRoutingBucket(source)
                if bucket ~= source then
                    bucketWarnings[source] = (bucketWarnings[source] or 0) + 1
                    SetPlayerRoutingBucket(source, source)
                    if bucketWarnings[source] > 3 then
                        DropPlayer(source, "Você foi desconectado por estar em um bucket inválido.")
                    end
                    TriggerClientEvent("lotus_access:open", source)
                end
            end
        end
    end
end)