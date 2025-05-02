local fun = function() end -- empty function to initialize properties and avoid type error;

CreateThread(function()
    vRP.execute("bench/items/createTable")
    vRP.execute("bench/log/createTable")
end)

---@param user_id number
---@param itemTbl ItemProps
---@return string
---Format Config.Log with user_id, amount, item and value
local function getLog(user_id, itemTbl)
    local amount, item, value = itemTbl.amount, itemTbl.item, itemTbl.value
    local result = Config.Log:gsub("{user_id}", user_id):gsub("{amount}", amount):gsub("{item}", item):gsub("{value}", value)
    return result
end

---@param item ItemProps
---@return boolean, string?
local function validateItem(item)
    local validTypes = {
        item = 'string',
        value = 'number',
        amount = 'number',
    }
    for key, value in pairs(validTypes) do
        if type(item[key]) ~= value then
            return false, 'Propriedade inválida (' .. key .. ')'
        end
    end
    if item.amount <= 0 then
        return false, 'Quantidade inválida'
    end
    if item.value <= 0 then
        return false, 'Preço inválido'
    end
    return true
end

---@type Bench
local Benchs <const> = {
    infos = {},
    logs = {},
    playersActives = {},
    AddItem = fun,
    RemoveItem = fun,
    GetLogs = fun,
    EditItem = fun,
    GetItems = fun,
    GetItem = fun,
    PayUser = fun,
    SyncBench = fun,
}

function Benchs:GetLogs(MachineName)
    if not self.logs[MachineName] then
        self.logs[MachineName] = {}
        local rows = vRP.query("bench/logs/getMachineLogs", {machine = MachineName})
        for i = 1, #rows do
            local row = rows[i]
            self.logs[MachineName][#self.logs[MachineName]+1] = row.log
        end
    end
    return self.logs[MachineName]
end

function Benchs:AddItem(MachineName, item, user_id)
    local items = self.infos[MachineName]
    if not items then
        items = {}
    end
    local isValid, err = validateItem(item)
    if not isValid then
        return false, err
    end
    local row = exports["oxmysql"]:executeSync("INSERT INTO bench_items(item, user_id, machine, amount, value) VALUES(?, ?, ?, ?, ?)", {item.item, user_id, MachineName, item.amount, item.value})
    if not row then
        return false, 'Erro ao adicionar item'
    end
    vRP._execute("bench/logs/add", {
        machine = MachineName,
        user_id = user_id,
        log = getLog(user_id, item)
    })
    self.logs[MachineName][#self.logs[MachineName]+1] = getLog(user_id, item)
    item.id = row.insertId
    items[#items+1] = item
    self.infos[MachineName] = items
    self:SyncBench(MachineName)
    return true
end

---@param MachineName string
---@param idx number
---@param new_price number
---@return boolean, string?
function Benchs:EditItem(MachineName, idx, new_price)
    local items = self.infos[MachineName]
    if not items then
        return false, 'Não há itens nesta máquina'
    end
    local item = items[idx]
    if not item then
        return false, 'Item não encontrado'
    end
    if new_price <= 0 then
        return false, 'Preço inválido'
    end
    local row = exports["oxmysql"]:executeSync("UPDATE bench_items SET value = ? WHERE id = ?", {new_price, item.id})
    item.value = new_price
    self.infos[MachineName][idx] = item
    self:SyncBench(MachineName)
    return true
end

function Benchs:PayUser(user_id, price)
    local src = vRP.getUserSource(user_id)
    local price = tonumber(price) * 0.65
    if not src then
        exports.oxmysql:executeSync("UPDATE vrp_user_identities SET banco = banco + ? WHERE user_id = ?", {price, user_id})
    else
        vRP.giveMoney(src, price)
        TriggerClientEvent("Notify", src, "sucesso", "Você recebeu R$"..price.." por vender itens na bancada")
    end
    return true
end

function Benchs:RemoveItem(MachineName, idx, amount)
    local items = self.infos[MachineName]
    if not items then
        return false, 'Não há itens nesta máquina'
    end
    local item = items[idx]
    if not item then
        return false, 'Item não encontrado'
    end
    if item.amount < amount then
        return false, 'Quantidade insuficiente'
    end
    item.amount = item.amount - amount
    local user_id = item.owner
    local log = "O usuário "..user_id.." retirou "..item.item.."x"..amount.." da bancada"
    if item.amount <= 0 then
        exports["oxmysql"]:executeSync("DELETE FROM bench_items WHERE id = ?", {item.id})
        table.remove(items, idx)
    else
        exports["oxmysql"]:executeSync("UPDATE bench_items SET amount = ? WHERE id = ?", {item.amount, item.id})
    end
    vRP._execute("bench/logs/add", {
        machine = MachineName,
        user_id = user_id,
        log = log
    })
    Benchs.logs[MachineName][#Benchs.logs[MachineName]+1] = log
    self.infos[MachineName] = items
    self:SyncBench(MachineName)
    return true
end

function Benchs:SyncBench(MachineName)
    local players = self.playersActives
    for src, machine in pairs(players) do
        if machine == MachineName then
            local user_id = vRP.getUserId(src)
            TriggerClientEvent('bench:sync', src, self:GetItems(MachineName), self:GetItemsByUserId(MachineName, user_id))
        end
    end
end

function Benchs:GetItems(MachineName)
    if not self.infos[MachineName] then
        local row = vRP.query("bench/items/getMachineItems", {machine = MachineName})
        self.infos[MachineName] = {}
        for i = 1, #row do
            local item = row[i]
            item.id = tonumber(item.id)
            item.owner = item.user_id
            item.amount = tonumber(item.amount)
            item.value = tonumber(item.value)
            self.infos[MachineName][i] = item
        end
    end
    return self.infos[MachineName]
end

function Benchs:GetItemsByUserId(MachineName, user_id)
    local items = self:GetItems(MachineName)
    local itemsByUserId = {}
    for i = 1, #items do
        local item = items[i]
        if item.owner == user_id then
            itemsByUserId[#itemsByUserId+1] = item
            itemsByUserId[#itemsByUserId].idx = i
        end
    end
    return itemsByUserId
end

function Benchs:GetItem(MachineName, idx)
    local items = self:GetItems(MachineName)
    if not items then
        return false, 'Não há itens nesta máquina'
    end
    local item = items[idx]
    if not item then
        return false, 'Item não encontrado'
    end
    return item
end

---@param machineIdx number Table Index
---@param itemIdx number Item Index
---@param amount number Amount
---@return boolean, string?
function API.RemoveItem(machineIdx, itemIdx, amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local tableConfig = Config.Tables[machineIdx]
    local hasPermission = vRP.hasPermission(user_id, tableConfig.permission)
    if not hasPermission then
        return false, 'Você não tem permissão para remover itens desta máquina'
    end
    local item = Benchs:GetItem(tableConfig.name, itemIdx)
    if not item then
        return false, 'Item não encontrado'
    end
    if item.owner ~= user_id then
        return false, 'Este item não é seu'
    end
    local success, err = Benchs:RemoveItem(tableConfig.name, itemIdx, amount)
    if not success then
        return false, err
    end
    if item and item.amount >= 0 then
        vRP.giveInventoryItem(user_id, item.item, amount, true)
        CreateThread(function()
            Wait(500)
            TriggerClientEvent("bench:syncInventory", source, vRP.getInventory(user_id))
        end)
        return true
    end
    return true
end

---@param idx number Table Index
---@param item_slot number Item Slot
---@param item_name string Item Name
---@param item_amount number Item Amount
---@param item_value number Item Value
---@return boolean, string?
function API.PutOnBench(idx, item_slot, item_name, item_amount, item_value)
    local source = source
    local user_id = vRP.getUserId(source)
    local tableConfig = Config.Tables[idx]
    if not tableConfig then
        return false, 'Máquina não encontrada'
    end
    local hasPermission = vRP.hasPermission(user_id, tableConfig.permission)
    if not hasPermission then
        return false, 'Você não tem permissão para adicionar itens a esta máquina'
    end
    local item = vRP.getSlotItem(user_id, item_slot)
    if not item then
        return false, 'Item não encontrado'
    end
    if item.item ~= item_name then
        return false, 'Item não encontrado'
    end
    if item.amount < item_amount then
        return false, 'Quantidade insuficiente'
    end
    if item_value <= 0 then
        return false, 'Preço inválido'
    end
    if not vRP.tryGetInventoryItem(user_id, item_name, item_amount, false, item_slot) then
        return false, 'Erro ao pegar item do inventário'
    end
    local success, err = Benchs:AddItem(tableConfig.name, {
        item = item_name,
        amount = item_amount,
        value = item_value,
        owner = user_id
    }, user_id)
    if not success then
        return false, err
    end
    CreateThread(function()
        Wait(500)
        TriggerClientEvent("bench:syncInventory", source, vRP.getInventory(user_id))
    end)
    return true
end

---@param machineIdx number Table Index
---@param itemIdx number Item Index
---@param amount number Amount
---@return boolean, string?
function API.BuyItem(machineIdx, itemIdx, amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local tableConfig = Config.Tables[machineIdx]
    if not tableConfig then
        return false, 'Máquina não encontrada'
    end
    local item = Benchs:GetItem(tableConfig.name, itemIdx)
    if not item then
        return false, 'Item não encontrado'
    end
    if vRP.computeInvWeight(user_id) + vRP.getItemWeight(item.item) * amount > vRP.getInventoryMaxWeight(user_id) then
        return false, 'Inventário cheio'
    end
    if item.amount < amount then
        return false, 'Quantidade insuficiente'
    end
    local price = item.value * amount
    if not vRP.tryPayment(user_id, price) then
        return false, 'Dinheiro insuficiente'
    end
    local itemName = rawget(item, 'item')
    local owner = rawget(item, 'owner')
    local success, err = Benchs:RemoveItem(tableConfig.name, itemIdx, amount)
    if not success then
        return false, err
    end
    local log = "O usuário "..user_id.." comprou "..itemName.."x"..amount.." do ID "..owner
    vRP._execute("bench/logs/add", {
        machine = tableConfig.name,
        user_id = user_id,
        log = log
    })
    Benchs.logs[tableConfig.name][#Benchs.logs[tableConfig.name]+1] = log
    Benchs:PayUser(owner, price)
    vRP.giveInventoryItem(user_id, itemName, amount, true)
    return true
end

---@param machineIdx number Table Index
---@param itemIdx number Item Index
---@param price number? new price
---@return boolean, string?
function API.EditPrice(machineIdx, itemIdx, price)
    local source = source
    local user_id = vRP.getUserId(source)
    local tableConfig = Config.Tables[machineIdx]
    local hasPermission = vRP.hasPermission(user_id, tableConfig.permission)
    if not hasPermission then
        return false, 'Você não tem permissão para editar este item'
    end
    local item = Benchs:GetItem(tableConfig.name, itemIdx)
    if not item then
        return false, 'Item não encontrado'
    end
    if item.owner ~= user_id then
        return false, 'Este item não é seu'
    end
    price = tonumber(price)
    if not price or price <= 0 then
        return false, 'Preço inválido'
    end
    local success, err = Benchs:EditItem(tableConfig.name, itemIdx, price)
    if not success then
        return false, err
    end
    return true
end

---@param idx number Table Index
---@return table<BenchResponse>
function API.GetTableResponse(idx)
    local source = source
    local user_id = vRP.getUserId(source)
    local tableConfig = Config.Tables[idx]
    local hasPermission = vRP.hasPermission(user_id, tableConfig.permission)
    local response = {
        method = (hasPermission and 'EDIT_BENCH' or 'STORE'),
    }
    if(response.method == 'EDIT_BENCH') then
        response.bench = Benchs:GetItemsByUserId(tableConfig.name, user_id)
        response.inventory = vRP.getInventory(user_id)
        response.logs = Benchs:GetLogs(tableConfig.name)
    else
        response.bench = Benchs:GetItems(tableConfig.name)
    end
    
    response.maxWeight = vRP.computeInvWeight(user_id)
    Benchs.playersActives[source] = tableConfig.name
    return response
end

---@param idx number Table Index
---@void
function API.CloseBench(idx)
    local source = source
    Benchs.playersActives[source] = nil
end

AddEventHandler('playerDropped', function()
    if not Benchs.playersActives[source] then return end
    Benchs.playersActives[source] = nil
end)


CreateThread(function()
    if Config.LogExpireDays and Config.LogExpireDays > 0 then
        exports["oxmysql"]:executeSync("DELETE FROM bench_logs WHERE createdAt < NOW() - INTERVAL "..Config.LogExpireDays.." DAY")
    end
end)
