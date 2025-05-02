local tableSelected = nil ---@type number | nil Table Index (Config.Tables)
Items = Items ---@type table<string, table<string, any>>

---@param item string
---@return number
local function GetItemPrice(item)
    local price = Config.Prices[item] or Config.Prices["default"]
    return price
end

---@param item string
---@return number
local function GetItemWeight(item)
    if not Items[item] then
        print(('[^1ERROR^7] Item %s não encontrado'):format(item))
        return 0
    end
    local weight = Items[item].weight
    return weight
end

---@param items ItemProps[]
---@return table<number, table<string, any>>
local function formatItems(items)
    local formattedItems = {}
    for k, v in pairs(items) do
        formattedItems[#formattedItems + 1] = v
        local item = formattedItems[#formattedItems]
        item.idx = item.idx or k
        item.name = Items[item.item].name
        item.weight = GetItemWeight(item.item)
        item.image = Config.ImageCdn:format(item.item)
        -- item.value = GetItemPrice(item.item)
    end
    return formattedItems
end

---@param inventory table<number, table<string, any>>
---@return table<number, table<string, any>>
local function formatInventory(inventory)
    local formattedInventory = {}
    if not inventory then return {} end
    for k, v in pairs(inventory) do
        formattedInventory[#formattedInventory + 1] = v
        local item = formattedInventory[#formattedInventory]
        item.weight = GetItemWeight(item.item)
        item.slot = k
        item.name = Items[item.item].name
        item.image = Config.ImageCdn:format(item.item)
        item.value = GetItemPrice(item.item)
    end
    return formattedInventory
end

---@param items table<number, table<string, any>>
---@return number
local function calcWeight(items)
    local weight = 0
    for _, v in pairs(items) do weight = weight + (v.weight * v.amount) end
    return weight
end

local BenchData = {}
local Peds = {}
local function doPed(hash, tableConfig)
    local ped = CreatePed(4, hash, tableConfig.coords.x, tableConfig.coords.y, tableConfig.coords.z - 1.0, tableConfig.heading or 100.0, false, false)
    SetEntityAsMissionEntity(ped, true, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    PlaceObjectOnGroundProperly(ped, true)
    SetTimeout(3000, function() 
        FreezeEntityPosition(ped, true)
    end)
    return ped
end
CreateThread(function()
    local hash = GetHashKey("g_m_y_salvaboss_01")
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(0) end
    for i = 1, #Config.Tables do
        local tableConfig = Config.Tables[i]
        Peds[i] = doPed(hash, tableConfig)
    end
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for i = 1, #Config.Tables do
            local tableConfig = Config.Tables[i]
            local tableCoords = tableConfig.coords
            local distance = #(coords - tableCoords)
            if distance < 30.0 then
                if not DoesEntityExist(Peds[i]) then
                    Peds[i] = doPed(hash, tableConfig)
                end
            end
            if distance < 6 then
                sleep = 3
                DrawText3D(tableCoords.x, tableCoords.y, tableCoords.z + 0.2, '~r~[E]~w~ Bancada')
                -- DrawMarker(29, tableCoords.x, tableCoords.y, tableCoords.z - 0.46, 0.0,
                --            0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0,
                --            0, 60, true, true, 2, false, false, false, false)
                if distance <= 2 and IsControlJustPressed(0, 38) then
                    sleep = 0
                    ---@type BenchResponse
                    local response = Remote.GetTableResponse(i)
                    if response then
                        BenchData = response
                        BenchData.bench = formatItems(BenchData.bench)
                        BenchData.inventory = formatInventory(BenchData.inventory)
                        BenchData.weight = math.floor(calcWeight(BenchData.inventory))
                        BenchData.maxWeight = math.floor(BenchData.maxWeight)
                        SendNUIMessage({action = 'open', data = response.method})
                        SetNuiFocus(true, true)
                        tableSelected = i
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('bench:sync', function(itemsStore, itemsUser)
    if BenchData.method == 'STORE' then
        BenchData.bench = formatItems(itemsStore)
        print(json.encode(BenchData.bench))
        SendNUIMessage({action = 'UPDATE_STORE', data = BenchData.bench})
    else
        BenchData.bench = formatItems(itemsUser)
        print(json.encode(BenchData.bench))
        SendNUIMessage({action = 'UPDATE_BENCH', data = BenchData.bench})
    end
end)

RegisterNetEvent("bench:syncInventory", function(inventory)
    BenchData.inventory = formatInventory(inventory)
    BenchData.weight = calcWeight(BenchData.inventory)
    SendNUIMessage({action = 'UPDATE_ITEMS', data = BenchData.inventory})
end)

RegisterNUICallback('PICK_UP_SALES_COUNTER', function(data, cb)
    local data = {
        inventory = BenchData.inventory,
        bench = BenchData.bench,
        logs = BenchData.logs,
        weight = BenchData.weight,
        maxWeight = BenchData.maxWeight
    }
    cb(data)
end)

RegisterNUICallback('GET_PRODUCTS', function(data, cb) cb(BenchData.bench) end)

RegisterNUICallback('CLOSE', function(data, cb)
    SendNUIMessage({action = 'close'})
    Remote.CloseBench(tableSelected)
    tableSelected = nil
    SetNuiFocus(false, false)
    BenchData = {}
    cb(true)
end)

RegisterNUICallback('BUY_ITEM', function(data, cb)
    local item = data.item
    local success, err = Remote.BuyItem(tableSelected, item.idx, item.amount)
    if not success then
        print(('[^1ERROR^7] %s'):format(err))
        return cb(false)
    end
    cb(true)
end)

RegisterNUICallback('PUT_ON_BENCH', function(data, cb)
    local item = data.item
    if Config.BlockedItems[item.item] then
        return cb(false)
    end
    local success, err = Remote.PutOnBench(tableSelected, item.slot, item.item, item.amount, item.value)
    if not success then
        print(('[^1ERROR^7] %s'):format(err))
        return cb(false)
    end
    return cb(true)
end)

RegisterNUICallback('EDIT_AMOUNT', function(data, cb)
    if data.amount - data.new_amount <= 0 then
        return cb(false)
    end
    local success, err = Remote.RemoveItem(tableSelected, data.idx, data.amount - data.new_amount)
    if not success then
        print(('[^1ERROR^7] %s'):format(err))
        return cb(false)
    end
    cb(true)
end)

RegisterNUICallback('REMOVE_ITEM', function(data, cb)
    local success, err = Remote.RemoveItem(tableSelected, data.idx, data.amount)
    if not success then
        print(('[^1ERROR^7] %s'):format(err))
        return cb(false)
    end
    cb(true)
end)

RegisterNUICallback('SELL_ITEM', function(data, cb)
    print('deprecated: SELL_ITEM is not used anymore;') 
    cb(true)
end)

RegisterNUICallback('EDIT_VALUE', function(data, cb)
    local item = data.item
    if item.value <= 0 then
        return cb(false)
    end
    local res, err = Remote.EditPrice(tableSelected, item.idx, item.value)
    if not res then
        print(('[^1ERROR^7] %s'):format(err))
        return cb(false)
    end
    cb(true)
end)



---@param x number
---@param y number
---@param z number
---@param text string
---@void
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 400
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,140)
end