local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterTunnel = {}
Tunnel.bindInterface(GetCurrentResourceName(), RegisterTunnel)
vTunnel = Tunnel.getInterface(GetCurrentResourceName())
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Locations = {
    Tables = {},
    Storages = {},
    NearestTable = {},
    NearestStorage = {}
}

local Craft = {
    Open = nil
}

local DelayTimer = GetGameTimer()
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS LOCATIONS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Locations:SearchNextTable()
    CreateThread(function()
        while true do
            local pedCoords = GetEntityCoords(PlayerPedId())

            for i in pairs(self.NearestTable) do
                local Index,Coords = self.NearestTable[i].index,self.NearestTable[i].coords
                if not Index or not Coords then goto next_table end
                SLEEP_TIME = (#(Coords - pedCoords) <= 10.0) and 0 or 1000

                
                DrawText3D(Coords[1],Coords[2],Coords[3], "Pressione ~g~ E ~w~ para abrir a bancada.")
                if (#(Coords - pedCoords) <= 1.5) then
                    if IsControlJustPressed(0, 38) and (DelayTimer - GetGameTimer()) <= 0 then
                        DelayTimer = (GetGameTimer() + 5000)
                        Craft:OpenCraft(Index)
                    end
                end

                :: next_table ::
            end

            Wait( SLEEP_TIME or 1000 )
        end
    end)
end

function Locations:SearchNextStorage()
    CreateThread(function()
        while true do
            local pedCoords = GetEntityCoords(PlayerPedId())

            for i in pairs(self.NearestStorage) do
                local Index,Coords = self.NearestStorage[i].index,self.NearestStorage[i].coords
                if not Index or not Coords then goto next_table end
                SLEEP_TIME = (#(Coords - pedCoords) <= 5.0) and 0 or 1000

                DrawText3D(Coords[1],Coords[2],Coords[3], "[~b~ARMAZEM~w~] ~g~ E ~w~ para ver ~g~ G ~w~ para guardar.")
                if (#(Coords - pedCoords) <= 1.5) then

                    -- VER STORAGE
                    if IsControlJustPressed(0, 38) and (DelayTimer - GetGameTimer()) <= 0 then
                        DelayTimer = (GetGameTimer() + 5000)

                        vTunnel._storageList(Index)
                    end

                    -- STORE ITENS
                    if IsControlJustPressed(0, 47) and (DelayTimer - GetGameTimer()) <= 0 then
                        DelayTimer = (GetGameTimer() + 5000)

                        vTunnel._storageStore(Index)
                    end

                end

                :: next_table ::
            end

            Wait( SLEEP_TIME or 1000 )
        end
    end)
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS CRAFT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Craft:OpenCraft(id)
    local Response = vTunnel.checkOpenCraft(id)
    if not Response then
        return
    end
    
    self.Open = id

    SendNUIMessage({ action = 'opened', data = true })
    SetNuiFocus(true, true)
    TransitionToBlurred(1000)
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.BlockAnims(status, anim)
    ClearPedTasks(PlayerPedId())
    in_status = status

    if in_status then
        anim1 = anim[1]
        anim2 = anim[2]
        getCoords = GetEntityCoords(PlayerPedId())
        getHeading = GetEntityHeading(PlayerPedId())

        CreateThread(function()
            while in_status do
                local time = 1000
                
                if in_status then
                    if not IsEntityPlayingAnim(PlayerPedId(), anim1, anim2,3) then
                        SetEntityHeading(PlayerPedId(), getHeading)
                        SetEntityCoords(PlayerPedId(), getCoords.x, getCoords.y, getCoords.z - 0.7)
                        vRP.playAnim(false,{{anim[1], anim[2]}},true)
                    end
                end

                Citizen.Wait(time)
            end
        end)
    end

end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS CRAFT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local timeToServer = GetGameTimer()
local queueProgress = 1
local queueList = {}

local routeList = { 
    ["GetProductions"] = function(data)
        local Items,Storage,Purchaseds = vTunnel.requestCraft(Craft.Open)
        if not Items or not Storage or not Purchaseds then return end
        
        local DataProductions = {
            queue = vTunnel.extraSlots() or 4, -- quantidade de slots que o cara pode deixar na fila
            items = Items,  
            storage = Storage,
            materials = Purchaseds
          }

        return DataProductions
    end,

    ["GetRanking"] = function(data)
        local Ranking = vTunnel.rankingOrg()
        if type(Ranking) == "table" then 
            return Ranking
        end
    end,

    ["AddToQueue"] = function(data)
        local itemsInQueue = data.items
        local responseQueue = vTunnel.productionList(itemsInQueue)
        if not responseQueue then 
            return false, TriggerEvent("Notify","negado","Itens Insuficientes.",5)
        else
            queueList = itemsInQueue
        end
        
        return queueList 
    end,

    ["ProduceItem"] = function(data)
        if timeToServer > GetGameTimer() then 
            return false
        end

        local itemsInQueue = data.item
        if next(queueList) then 
            timeToServer = GetGameTimer() + 1000
            local res = vTunnel.craftingList(Craft.Open, queueList)
            if type(res) == "boolean" then 
                return res 
            end
        else
            timeToServer = GetGameTimer() + 500
            local response = vTunnel.startProduction(Craft.Open, itemsInQueue, data.amount or itemsInQueue.amount)
            if type(response) == "boolean" then 
                return response 
            end
        end


    end,

    ["BuyMaterial"] = function(data)
        local response = vTunnel.buyMaterial(data.amount)
        if response then 
            TriggerEvent("Crafting:closeInterface")
            TriggerEvent("Notify","sucesso","Compra realizada com sucesso",5)
            return response 
        end

        return false
    end,

    ["hideFrame"] = function(data)
        SendNUIMessage({ action = 'opened', data = false })
        SetNuiFocus(false,false)
        TransitionFromBlurred(1000)
        return true 
    end,
}

local registerRoutes = function()
    for k, v in pairs(routeList) do
        local resolveRoute = function(data, cb)
            local res = v(data)
            if res then
                cb(res)
            end
        end
        RegisterNUICallback(k, resolveRoute)
    end
end

CreateThread(registerRoutes)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE QUEUE
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Crafting:updateQueue",function(Done)
    local refreshList = {}
    if queueList[Done] then
        queueList[Done] = nil 
    end

    for k,v in pairs(queueList) do 
        table.insert(refreshList,v)
    end
    

    SendNUIMessage({ action = 'UpdateQueue', data = refreshList })
end)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE PROGRESS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Crafting:updateProgress",function(Time)
    local timeToInterface = parseInt(Time * 1000)
    SendNUIMessage({ action = "UpdateProgress", data = timeToInterface })
end)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE INTERFACE
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Crafting:closeInterface",function()
    SendNUIMessage({ action = "opened", data = false })
    SetNuiFocus(false,false)
    TransitionFromBlurred(1000)
end)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    -- GERANDO CACHE DAS BANCADAS
    for i in pairs(CraftConfig.Tables) do
        Locations.Tables[i] = CraftConfig.Tables[i].Config.location
    end

    -- GERANDO CACHE DOS ARMAZENS
    for i in pairs(CraftConfig.Storage) do
        Locations.Storages[i] = CraftConfig.Storage[i].Config.location
    end

    Locations:StartNearestTable()
    Locations:StartNearestStorage()
    Locations:SearchNextTable()
    Locations:SearchNextStorage()
end)

function Locations:StartNearestTable()
    CreateThread(function()
        while true do
            local SLEEP_TIME = 1000
            local pedCoords = GetEntityCoords(PlayerPedId())
    
            for i in pairs(Locations.Tables) do
                if #(Locations.Tables[i] - pedCoords) <= 10.0 then
                    self.NearestTable[i] = { index = i, coords = Locations.Tables[i] }
                elseif self.NearestTable[i] then
                    self.NearestTable[i] = nil
                end
            end
    
            Wait( SLEEP_TIME )
        end
    end)
end

function Locations:StartNearestStorage()
    CreateThread(function()
        while true do
            local SLEEP_TIME = 1000
            local pedCoords = GetEntityCoords(PlayerPedId())
    
            for i in pairs(Locations.Storages) do
                if #(Locations.Storages[i] - pedCoords) <= 10.0 then
                    self.NearestStorage[i] = { index = i, coords = Locations.Storages[i] }
                elseif self.NearestStorage[i] then
                    self.NearestStorage[i] = nil
                end
            end
            
            Wait( SLEEP_TIME )
        end
    end)
end

exports('GetSelectStorage', function(org)
    return vTunnel.storageItens(org)
end)


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

function DrawText3DAlways(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if not onScreen then
        return
    end

    local playerCoords = GetEntityCoords(PlayerPedId())
    local distance = #(playerCoords - vector3(x, y, z))
    local scale = 1.0 / math.max(distance, 1.0) * 2.0
    scale = math.min(scale, 0.35)
    scale = math.max(scale, 0.2)

    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(_x, _y)
end

RegisterNetEvent('craft:showBlips', function(org)
    CreateThread(function()
        if not CraftConfig.Tables[org] then return end

        local coords = CraftConfig.Tables[org].Config.location
        local coords2 = CraftConfig.Storage[org].Config.location
        if not coords then return end

        local endTime = GetGameTimer() + (1000 * 60 * 2)
        while GetGameTimer() < endTime do
            Wait(0)
            DrawText3DAlways(coords.x, coords.y, coords.z + 1.0, "Craft")
            DrawText3DAlways(coords2.x, coords2.y, coords2.z + 1.0, "Armazem")
        end
    end)
end)