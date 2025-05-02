vRP._prepare("lotus_ponto/saveTime", 'INSERT INTO lotus_ponto (user_id, identity, service_time) VALUES (@user_id, @identity, @service_time) ON DUPLICATE KEY UPDATE service_time = service_time + @service_time')
vRP._prepare("lotus_ponto/getRanking", 'SELECT user_id, identity as `name` FROM lotus_ponto ORDER BY service_time DESC LIMIT 10')
vRP._prepare("ponto_presets/insert", 'INSERT INTO ponto_presets(`org`, `group`, preset) VALUES (@org, @group, @preset) ON DUPLICATE KEY preset = @preset')
vRP._prepare("ponto_presets/get", 'SELECT `group`, `preset` FROM ponto_presets')

--#region Clothes
local Clothes <const> = {
    cache = {}
}

CreateThread(function() 
    exports.oxmysql:execute([[
        CREATE TABLE IF NOT EXISTS lotus_ponto (
            user_id INT NOT NULL,
            identity VARCHAR(100) NOT NULL,
            service_time INT NOT NULL,
            PRIMARY KEY (user_id)
        );
    ]])

    -- Verificar e criar a tabela ponto_presets
    exports.oxmysql:execute([[
        CREATE TABLE IF NOT EXISTS ponto_presets (
            org VARCHAR(100) NOT NULL,
            `group` VARCHAR(100) NOT NULL,
            preset TEXT NOT NULL,
            PRIMARY KEY (org, `group`)
        );
    ]])

    Clothes:Mount()
    for k,v in pairs(Config.Clothes) do
        if not Clothes:Get(k) then
            Clothes:Update(v.org, k, json.encode({
                male = v.male,
                female = v.female or {},
            }))
        end
    end
end)

function Clothes:Mount()
    local rows = exports["oxmysql"]:query_async('SELECT `group`, `preset` FROM ponto_presets', {})
    self.cache = {}
    for i = 1, #rows do
        local row = rows[i]
        self.cache[row.group] = (row.preset)
    end
    return self.cache
end

function Clothes:Get(group)
    return self.cache[group]
end

function Clothes:Update(org, group, preset)
    self.cache[group] = json.decode(preset)
    exports["oxmysql"]:executeSync("INSERT IGNORE INTO ponto_presets(`org`, `group`, preset) VALUES (@org, @group, @preset) ON DUPLICATE KEY UPDATE preset = @preset", {
        org = org,
        group = group,
        preset = (preset)
    })
end
--#endregion

--#region Ranking
local Ranking <const> = {
    cache = {},
    generated_at = 0
}
function Ranking:Mount()
    self.cache = exports["oxmysql"]:query_async("SELECT user_id, identity as `name` FROM lotus_ponto ORDER BY service_time DESC LIMIT 10")
    self.generated_at = os.time()
    return self.cache
end
function Ranking:Get()
    if os.time() - self.generated_at > RANKING_UPDATE_INTERVAL then
        self:Mount()
    end
    return self.cache
end

CreateThread(function()
    Ranking:Mount()
end)

function API.getRanking()
    return Ranking:Get()
end
--#endregion

local StartTime = {}
local function getTime(user_id)
    return StartTime[user_id]
end

local function setTime(user_id, on_service)
    if not on_service then
        StartTime[user_id] = nil
        return false
    end
    local started_at = os.time()
    StartTime[user_id] = started_at
    return true
end

local function saveTime(user_id)
    local started_at = StartTime[user_id]
    if not started_at then
        return false
    end
    local now = os.time()
    local identity = vRP.getUserIdentity(user_id)
    if not identity then
        return error("Identity not found")
    end
    identity = identity.nome.." "..identity.sobrenome
    local service_time = now - started_at
    vRP._execute("lotus_ponto/saveTime", {user_id = user_id, identity = identity, service_time = service_time})
    setTime(user_id, false)
    return true
end

function API.getClothes(org)
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id, ADMIN_PERMISSION) then return end
    local response = {}
    for k,v in pairs(Config.Orgs[org].groups) do
        response[#response+1] = {
            name = "Uniforme - "..k,
            group = k,
            preset = Clothes:Get(k)
        }
    end
    return {
        radio = Config.Orgs[org].radioChannel,
        uniforms = response
    }
end


function API.checkOrgData(org)
    if not Config.Orgs[org] then
        return false
    end
    local source = source
    local user_id = vRP.getUserId(source)
    local orgType, orgName = exports['dm_module']:GetGroupType(user_id)
    if orgName ~= org then
        return false
    end
    local group = vRP.getUserGroupByType(user_id, "org")
    if not group then
        return false
    end
    if not Config.Orgs[org].groups[group] then
        error("Group not found ("..group..") in org ("..org..")")
    end
    local identity = vRP.getUserIdentity(user_id)
    return true, group, getTime(user_id), {
        isDeveloper = vRP.hasPermission(user_id, ADMIN_PERMISSION),
        name = identity.nome.. " " ..identity.sobrenome,
        group = group,
        org = org,
    }
end

function API.updateUniform(org, group, new_preset)
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id, ADMIN_PERMISSION) then return end
    if not json.encode(new_preset) then return false end
    Clothes:Update(org, group, json.encode(new_preset))
    return true
end

function API.startService(org)
    local source = source
    local user_id = vRP.getUserId(source)
    local orgType, orgName = exports['dm_module']:GetGroupType(user_id)
    if orgName ~= org then
        return false
    end

    if exports.vrp_admin:isOrganizationBlacklisted(org) then
        TriggerClientEvent("Notify", source, "negado", "Você não pode entrar em serviço nesta organização.")
        return false
    end

    local group = vRP.getUserGroupByType(user_id, "org")
    if not group then
        return false
    end
    if not Config.Orgs[org].groups[group] then
        error("Group not found ("..group..") in org ("..org..")")
    end
    if getTime(user_id) then
        TriggerClientEvent("Notify", source, "negado", "Você já está em serviço.")
        return false
    end
    setTime(user_id, true)
    vRP.setPatrulhamento(user_id, true)
    return true
end

local function removeUserWeapons(userId)
    local source = vRP.getUserSource(userId)
    if source then
        local weapons = vRP.clearWeapons(userId)
        vRPC._replaceWeapons(source, {})
    end
end

function API.stopService(org)
    local source = source
    local user_id = vRP.getUserId(source)
    local orgType, orgName = exports['dm_module']:GetGroupType(user_id)
    if orgName ~= org then
        return false
    end
    local group = vRP.getUserGroupByType(user_id, "org")
    if not group then
        return false
    end
    if not Config.Orgs[org].groups[group] then
        error("Group not found ("..group..") in org ("..org..")")
    end
    if not getTime(user_id) then
        TriggerClientEvent("Notify", source, "negado", "Você não está em serviço.")
        return false
    end
    saveTime(user_id)
    setTime(user_id, false)
    vRP.removePatrulhamento(user_id)
    removeUserWeapons(user_id)
    return true
end

local function parseTables(target, keys)
    local result = {}
    for i = 1, #keys do
        result[keys[i]] = target[keys[i]]
    end
    return result
end

function API.equip(org)

    local source = source
    local user_id = vRP.getUserId(source)
    local orgType, orgName = exports['dm_module']:GetGroupType(user_id)
    if orgName ~= org then
        return false
    end
    local group = vRP.getUserGroupByType(user_id, "org")
    if not group then
        return false
    end
    if not Config.Orgs[org].groups[group] then
        error("Group not found ("..group..") in org ("..org..")")
    end
    if not getTime(user_id) then
        TriggerClientEvent("Notify", source, "negado", "Você não está em serviço.")
        return false
    end
    local weapons = Config.Orgs[org].groups[group].WeaponsKit
    local weaponsResult = parseTables(Config.WeaponsKit, weapons)
    local clothes = Clothes:Get(group)
    if not clothes then
        clothes = {
            male = {},
            female = {}
        }
    end
    local ped_model = GetEntityModel(GetPlayerPed(source))
    local is_male = (ped_model == GetHashKey("mp_m_freemode_01"))
    if is_male then
        clothes = clothes.male
    else
        clothes = clothes.female
    end
    vRPC._setCustomization(source, clothes)
    local weaponsClient = {}
    for k,v in pairs(weaponsResult) do
        weaponsClient[v.name] = {
            ammo = v.ammo
        }
    end
    vRPC._replaceWeapons(source, weaponsClient, true)
    if vRP.getInventoryItemAmount(user_id, 'radio') <= 0 then
        vRP.giveInventoryItem(user_id, 'radio', 1)
    end
    vRPC._setArmour(source, 100)
    TriggerClientEvent("vrp_sound:source",source,'ziper',0.5)
    return true
end


AddEventHandler("vRP:playerLeave", function(user_id)
    if getTime(user_id) then
        saveTime(user_id)
    end
end)
