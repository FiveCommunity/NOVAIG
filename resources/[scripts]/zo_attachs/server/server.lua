local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vCLIENT = Tunnel.getInterface("zo_attachs")
src = {}
Tunnel.bindInterface("zo_attachs", src)
Proxy.addInterface("zo_attachs", src)
local cacheAttachsPlayers = {}
local cacheAttachsPlayersInWaitSave = {}
Citizen.CreateThread(
    function()
        zof.prepare(
            "zo/attachs_createtable",
            [[            CREATE TABLE IF NOT EXISTS zo_attachs(                user_id INTEGER,                attachs text,                PRIMARY KEY (`user_id`) USING BTREE            )        ]]
        )
        zof.prepare("zo/check_exists_table_attachs", "SHOW TABLES LIKE 'zo_attachs'")
        zof.prepare("zo/insert_attachs", "INSERT INTO zo_attachs(user_id, attachs) VALUES(@user_id, @attachs)")
        zof.prepare("zo/update_attachs", "UPDATE zo_attachs SET attachs = @attachs WHERE user_id = @user_id")
        zof.prepare("zo/get_attachs", "SELECT * FROM zo_attachs WHERE user_id = @user_id")
        async(
            function()
                if config.salvarAttachsDb then
                    zof.execute("zo/attachs_createtable")
                end
            end
        )
    end
)
src.getAllGunsList = function(guns)
    local source = source
    local weapons = {}
    for i, v in pairs(guns) do
        weapons[string.gsub(i, "wbody|", "")] = {ammo = 250}
    end
    zof.giveWeapons(source, weapons)
end
src.checkPerms = function(perms)
    local user_id = zof.getUserId(source)
    local next = next
    if next(perms) == nil then
        return true
    end
    for i, v in ipairs(perms) do
        if zof.hasPermission(user_id, v) then
            return true
        end
    end
    return false
end
src.checkPayment = function(price, gun)
    local user_id = zof.getUserId(source)
    price = tonumber(price)
    if price then
        return zof.tryFullPayment(user_id, price)
    end
    return true
end
src.checkContainsAttachs = function(attachs, gun)
    local user_id = zof.getUserId(source)
    local itensAplicados = {}
    local todosAttachs = true
    for i, component in pairs(attachs) do
        table.insert(itensAplicados, component.attach)
        if zof.getInventoryItemAmount(user_id, attachsItens[component.type]) <= 0 then
            todosAttachs = false
        end
    end
    if todosAttachs then
        for i, component in pairs(attachs) do
            zof.tryGetInventoryItem(user_id, attachsItens[component.type], 1)
        end
    end
    return todosAttachs
end
src.saveCacheWait = function()
    if not config.salvarAttachsDb then
        return
    end
    if cacheAttachsPlayersInWaitSave == nil then
        return
    end
    if next(cacheAttachsPlayersInWaitSave) then
        for user_id, atts in pairs(cacheAttachsPlayersInWaitSave) do
            if user_id then
                local attsUser = zof.query("zo/get_attachs", {user_id = parseInt(user_id)})
                if attsUser[1] ~= nil then
                    zof.query("zo/update_attachs", {user_id = parseInt(user_id), attachs = json.encode(atts)})
                else
                    zof.query("zo/insert_attachs", {user_id = parseInt(user_id), attachs = json.encode(atts)})
                end
                cacheAttachsPlayersInWaitSave[user_id] = nil
                Citizen.Wait(1000)
            end
        end
    end
end
src.insertOrUpdate = function(atts)
    if not config.salvarAttachsDb then
        return
    end
    local source = source
    local user_id = zof.getUserId(source)
    if user_id then
        cacheAttachsPlayersInWaitSave[user_id] = atts
        cacheAttachsPlayers[user_id] = atts
    end
end
src.get = function(puser_id)
    if not config.salvarAttachsDb then
        return {}
    end
    local source = source
    local user_id = zof.getUserId(source)
    if puser_id then
        user_id = puser_id
    end
    if cacheAttachsPlayers[user_id] ~= nil then
        return cacheAttachsPlayers[user_id]
    end
    local atts = zof.query("zo/get_attachs", {user_id = parseInt(user_id)})
    if atts[1] ~= nil then
        atts = json.decode(atts[1]["attachs"])
    else
        atts = {}
    end
    cacheAttachsPlayers[user_id] = atts
    return atts
end
Citizen.CreateThread(
    function()
        while config.salvarAttachsDb do
            src.saveCacheWait()
            Citizen.Wait((1000 * 60))
        end
    end
)
AddEventHandler(
    "vRP:playerSpawn",
    function(user_id, source, first_spawn)
        local infosAttachs = src.get(user_id)
        cacheAttachsPlayers[user_id] = infosAttachs
    end
)
AddEventHandler(
    "playerDropped",
    function(reason)
        local source = source
        local user_id = zof.getUserId(source)
        if user_id then 
            cacheAttachsPlayers[user_id] = nil
        end
    end
)