local rankingIds = {
    mountAt = 0,
    cache = {}
}
local rankingPerOrg = {
mountAt = 0,
    cache = {}
}

vRP._prepare("lotus_apreender/init/create_table",[[
CREATE TABLE IF NOT EXISTS `items_seized` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`user_id` INT NOT NULL,
	`org` TINYTEXT NOT NULL COLLATE 'utf8mb4_general_ci',
    `amount` BIGINT(20) NOT NULL DEFAULT '0',
	`createdAt` DATETIME NOT NULL DEFAULT curDATE(),
	PRIMARY KEY (`id`)
)
COLLATE='utf8mb4_general_ci'
;
]])
vRP._prepare("lotus_apreender/init/insert_item_seized",[[
INSERT INTO items_seized (user_id, org, amount) VALUES (@user_id, @org, @amount)
]])
vRP._prepare("lotus_apreender/init/get_ranking_ids",[[
SELECT user_id, amount FROM items_seized ORDER BY amount DESC LIMIT 10
]])

vRP._prepare("lotus_apreender/init/get_ranking_per_org",[[
SELECT org, SUM(amount) as amount FROM items_seized GROUP BY org
]])

vRP._prepare("lotus_apreender/init/get_ranking_total",[[
SELECT SUM(amount) as total FROM items_seized
]])

function GetRankingIds()
    local now = os.time()
    if now - rankingIds.mountAt > 300 then
        rankingIds.mountAt = now
        rankingIds.cache = {}
        local results = vRP.query("lotus_apreender/init/get_ranking_ids", {})
        rankingIds.cache = results
    end
    return rankingIds
end

function GetRankingPerOrg()
    local now = os.time()
    if now - rankingPerOrg.mountAt > 300 then
        rankingPerOrg.mountAt = now
        rankingPerOrg.cache = {}
        local results = vRP.query("lotus_apreender/init/get_ranking_per_org", {})
        rankingPerOrg.cache = results
        local count = vRP.query("lotus_apreender/init/get_ranking_total", {})
        rankingPerOrg.total = count[1].total
    end
    return rankingPerOrg
end

RegisterCommand('topapreensao', function(source, args, rawCommand)
    local rankingIds = GetRankingIds()
    local message = "Ranking de itens apreendidos\n"
    for i, row in ipairs(rankingIds.cache) do
        message = message .. ""..i.."° - " .. row.user_id .. " - " .. row.amount .. "x\n"
    end
    TriggerClientEvent("Notify", source, "sucesso", message)
end, false)

RegisterCommand('topgapreensao', function(source, args, rawCommand)
    local rankingPerOrg = GetRankingPerOrg()
    local message = "Ranking de itens apreendidos por guarnição\n"
    for i, row in ipairs(rankingPerOrg.cache) do
        message = message .. ""..i.."° - " .. row.org .. " - " .. row.amount .. "x\n"
    end
    message = message .. "Total de itens apreendidos: " .. rankingPerOrg.total .. "\n"
    TriggerClientEvent("Notify", source, "sucesso", message)
end, false)

RegisterCommand('resetartopapreensao', function(source, args)
    local userId = vRP.getUserId(source)
    if not userId then
        return
    end

    if not vRP.hasPermission(userId, 'developer.permissao') and not vRP.hasGroup(userId, 'resppolicialotusgroup@445') then
        return
    end

    rankingIds.cache = {}
    rankingPerOrg.cache = {}

    rankingIds.mountAt = 0
    rankingPerOrg.mountAt = 0

    exports.oxmysql:execute('DELETE FROM items_seized')
end)

local function getItemMultiplier(item)
    local item = string.lower(item)
    if Config.itensTypeMultiplier[item] then
        return Config.itensTypeMultiplier[item]
    end
    local itemType = Items[item] and Items[item].type or nil
    if itemType and Config.itensTypeMultiplier[itemType] then
        return Config.itensTypeMultiplier[itemType] or 1
    end
    return 1
end

function API.exchangeItem(orgName)
    local source = source
    local user_id = vRP.getUserId(source)
    local org = vRP.getUserGroupOrg(user_id)
    if org ~= orgName and ((org == 'Aurora' or org == 'Aurora2') and not vRP.hasPermission(user_id, 'perm.disparo')) then
        return false, 'Você não tem permissão para converter itens nessa guarnição'
    end
    local itemCount = vRP.getInventoryItemAmount(user_id, Config.SeizeItemName)
    if itemCount <= 0 then
        return false, 'Você não possui itens para converter'
    end
    if vRP.tryGetInventoryItem(user_id, Config.SeizeItemName, itemCount) then
        vRP.giveMoney(user_id, itemCount * 50)
        vRP.sendLog('https://discord.com/api/webhooks/1314451274917216296/qlaMUL4fYzY1RNVW1HJKrky3vpZvF5hY3d-rWPkRCLcjVXnzUcOE2WxDrvDFY9euAiiq', 'USUARIO '..user_id..' VENDEU '..itemCount..' ITENS POR R$'..(itemCount * 50)..' NO BLIP '..orgName)
        return true, 'Você recebeu R$' .. itemCount * 50 .. ' por ' .. itemCount .. ' itens apreendidos'
    end
    return false, 'Erro ao converter itens'
end

exports('seizeItem', function(user_id,item, amount)
    local org = vRP.getUserGroupOrg(user_id)
    if Config.blockedItems[item] then return false end
    if not org then
        print('^1[nova_apreender] ^7O usuário ' .. user_id .. ' não está em uma guarnicao')
        return false, 'Você não está em uma guarnição'
    end
    if not item then
        print(user_id, item, amount)
        return false, 'Você não está em uma guarnição'
    end
    local multiplier = getItemMultiplier(item)
    local total = amount * multiplier
    vRP._giveInventoryItem(user_id, Config.SeizeItemName, total, true)
    vRP._execute("lotus_apreender/init/insert_item_seized", {user_id = user_id, org = org, amount = total})
end)

CreateThread(function()
    vRP._execute("lotus_apreender/init/create_table")
end)
