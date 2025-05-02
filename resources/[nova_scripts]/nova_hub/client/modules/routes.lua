RequestStaff = {
    SendRequestFinished = false,
    UserRequestFinished = false,
    StartTimer = GetGameTimer()
}

RequestFeedback = {
    FeedBackCallback = nil
}

local routes = {
    ['CLOSE'] = function(data)
        SetNuiFocus(false, false)
        return true
    end,

    ['NEED_HELP'] = function(textRequest)
        Client.closeServiceMenu()
        Server.receiveCall(textRequest)
        return true
    end,

    ['CALL_ACCEPT'] = function(data)
        Client.closeServiceMenu()
        Server.callMenuAction(data, 'accept')
        return true
    end,

    ['CALL_REFUSE'] = function(data)
        Server.callMenuAction(data, 'refuse')
        return true
    end,

    ['REQUEST_CANCEL'] = function(data)
        NotFinishCall()
        return true
    end,

    ['REQUEST_RESULT_FINISHED'] = function(data)
        FinishCall()
        return true
    end,

    ['REQUEST_EVALUATE_RESULT'] = function (data)
        RequestFeedback.FeedBackCallback = data
        return true
    end,

    ['REQUEST_EVALUATE_CANCEL'] = function(data)
        RequestFeedback.FeedBackCallback = 'not feedback'
        return true
    end,

    ['SAVE_CONFIG'] = function(parameters)
        Server.saveConfig(parameters)
        return true
    end,

    ['TOGGLE_NOTIFICATIONS'] = function(data)
        Server.toggleNotifications()
        return true
    end

}

for route, callback in pairs(routes) do
    RegisterNUICallback(route, function(data, cb)
        return cb(callback(data))
    end)
end


function Client.closeServiceMenu()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'close'
    })
end

function Client.openHelpByCategory(category)
    SendNUIMessage({
        action = 'update',
        data = {
            helps = Helps[category] or Helps.god
        }
    })

    Wait(150)

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open:help'
    })
end

---@param calls table
---@param newcall table
function Client.receiveCalls(calls, newcall, muted)
    if type(calls) ~= 'table' then return end

    local tempTable = {}

    for _, call in pairs(calls) do
        if call and next(call) then 
            table.insert(tempTable, call)
        end
    end

    SendNUIMessage({
        action = 'update',
        data = {
            calls = tempTable
        }
    })

    if newcall and type(newcall) == 'table' and next(newcall) and not muted then
        local userName = newcall.name
        local userMessage = newcall.message
        local category = newcall.category

        local roleColor = 'linear-gradient(270deg, #5C0909 0%, #400505 100%)'

        if newcall.isNovat then
            roleColor = '#30fc03'
        end

        SendNUIMessage({
            action = 'call',
            data = {
              id = newcall.id,
              username = userName,
              message = userMessage,
              role = category,
              roleColor = roleColor
            }
        })
    end
end

function Client.rejectSpecificCall(calls, callId)
    if type(calls) ~= 'table' then return end

    local tempTable = {}

    for _, call in pairs(calls) do
        if call and next(call) then 
            table.insert(tempTable, call)
        end
    end

    SendNUIMessage({
        action = 'update',
        data = {
            calls = tempTable
        }
    })
end

function Client.openServiceMenu(parametersRequired, isStaff, category)
    SendNUIMessage({
        action = 'update',
        data = parametersRequired
    })

    Wait(150)

    if isStaff then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'open:calls'
        })
    else
        SetNuiFocus(true, true)

        print('CATEGORY: '..category)

        SendNUIMessage({ action = 'open:callService', data = category })
    end
end

