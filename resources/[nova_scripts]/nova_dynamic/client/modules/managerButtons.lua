CategorysTemp = {}
NowCategory = {}

local function formatPathImage(image)
    if not image then return nil end
    return "./assets/" .. image .. ".svg"
end

---@param components table Responsável por criar os botões do menu a partir de uma categoria.
exports("createMenu", function(components)

    SendNUIMessage({
        action = "close",
    })

    local sendTable = {}

    for categoryTitle, categoryOptions in pairs(components) do

        local title = type(categoryTitle) ~= "number" and categoryTitle or categoryOptions.name

        if not CategorysTemp[categoryTitle] then
            CategorysTemp[categoryTitle] = categoryOptions
        end

        local nowPos = #sendTable + 1

        sendTable[nowPos] = {
            ["name"] = title,
            ["type"] = categoryOptions.options and "menu" or "button",
            ["image"] = formatPathImage(categoryOptions.image),
            ["delete"] = categoryOptions.delete or false,
            ["modal"] = categoryOptions.modal or false,
            ["description"] = categoryOptions.description,
        }

        if categoryOptions.trigger then
            sendTable[nowPos]["trigger"] = categoryOptions.trigger
        end

        for _, nowcategory in pairs(NowCategory) do
            if nowcategory == categoryTitle then
                goto ignore
            end
        end

        table.insert(NowCategory, categoryTitle)

        ::ignore::
    end

    SendNUIMessage({
       action = 'open',
       targets = sendTable,
       type = 'menu',
       status = 'close',
    })

    SetNuiFocus(true, true)
end)

---@param components table Responsável por criar os botões;
exports("createButton", function (components)
    if type(components) ~= "table" then
        return
    end

    for i, component in pairs(components) do
        components[i]["image"] = formatPathImage(component["image"])
    end

    SendNUIMessage({
        ["action"] = "close"
    })

    SendNUIMessage({
        action = 'open',
        targets = components,
        type = 'button',
        status = 'close',
    })

    SetNuiFocus(true, true)
end)

RegisterNUICallback("target", function (data, cb)
    local typeAction = data["target"]["type"]

    local filterActions = {
        ["menu"] = function()
            local indexCategorysTemp = data["target"]["name"]
            SendNUIMessage({
                ["action"] = "close",
            })

            if CategorysTemp[indexCategorysTemp] then
                local options = CategorysTemp[indexCategorysTemp]["options"]
                local sendTable = {}

                for x, option in pairs(options) do
                    table.insert(sendTable, {
                        ["name"] = option.name or x,
                        ["image"] = formatPathImage(option.image),
                        ["description"] = option.description,
                        ["delete"] = option.delete or false,
                        ["modal"] = option.modal or false,
                        ["trigger"] = option.trigger,
                    })

                    local nowPos = #sendTable

                    if option.options then
                        sendTable[nowPos]["type"] = "submenu"
                        sendTable[nowPos]["options"] = option.options
                    end
                end

                SendNUIMessage({
                    action = 'open',
                    targets = sendTable,
                    type = 'button',
                    status = 'back',
                })
            end
        end,

        ["button"] = function()
            if data["target"]["trigger"] then
                local trigger = data["target"]["trigger"]

                if trigger["type"] and trigger["type"] == "command" then
                    if trigger["args"] and #trigger["args"] > 0 then
                        ExecuteCommand(trigger["name"], table.unpack(trigger["args"]))
                    else
                        ExecuteCommand(trigger["name"])
                    end
                else
                    if trigger["isServer"] then
                        if trigger["args"] and #trigger["args"] > 0 then
                            TriggerServerEvent(trigger["name"], table.unpack(trigger["args"]))
                        else
                            TriggerServerEvent(trigger["name"])
                        end
                    else
                        if trigger["args"] and #trigger["args"] > 0 then
                            TriggerEvent(trigger["name"], table.unpack(trigger["args"]))
                        else
                            TriggerEvent(trigger["name"])
                        end
                    end
                end


            end
        end,

        ["submenu"] = function()
            SendNUIMessage({
                ["action"] = "close",
            })

            local sendTable = {}

            for x, option in pairs(data["target"]["options"]) do
                table.insert(sendTable, {
                    ["name"] = option.name or x,
                    ["image"] = formatPathImage(option.image),
                    ["description"] = option.description,
                    ["delete"] = option.delete or false,
                    ["trigger"] = option.trigger,
                    ["modal"] = option.modal or false,
                })

                local nowPos = #sendTable

                if option.options then
                    sendTable[nowPos]["type"] = "submenu"
                    sendTable[nowPos]["options"] = option.options
                end
            end

            SendNUIMessage({
                action = 'open',
                targets = sendTable,
                type = 'button',
                status = 'back',
            })
        end
    }

    if filterActions[typeAction] then
        filterActions[typeAction]()
    else
        filterActions["button"]()
    end

    cb("ok")
end)

RegisterNUICallback("close", function(data, cb)
    NowCategory = {}
    CategorysTemp = {}
    SetNuiFocus(false, false)
    cb("ok")
end)

RegisterNetEvent("lotus_dynamic:closeMenu")
AddEventHandler("lotus_dynamic:closeMenu", function()
    NowCategory = {}
    CategorysTemp = {}
    SetNuiFocus(false, false)
    SendNUIMessage({
        ["action"] = "close",
    })
end)


RegisterNUICallback("back", function(data, cb)
    if NowCategory and next(NowCategory)  then
        local tableSend = {}
        for _, categoryTitle in pairs(NowCategory) do
            if CategorysTemp[categoryTitle] then

                local CategoryFound = CategorysTemp[categoryTitle]

                tableSend[categoryTitle] = CategoryFound
            end
        end
        exports['nova_dynamic']:createMenu(tableSend)
    else
        SendNUIMessage({
            ["action"] = "close",
        })
        SetNuiFocus(false, false)
    end

    cb("ok")
end)