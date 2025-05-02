local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

Client = {}
Tunnel.bindInterface(GetCurrentResourceName(), Client)
Server = Tunnel.getInterface(GetCurrentResourceName())


RegisterCommand('nova_hub:open', function()
    Server.openServiceMenu()
end)

RegisterKeyMapping('nova_hub:open',"Abrir Menu de Call","keyboard","f5")

local callRunning = false
local callParamsCommand = nil

function NotFinishCall()
    SetNuiFocus(false, false)
    RequestStaff.SendRequestFinished = false
end

function FinishCall()
    SetNuiFocus(false, false)
    RequestStaff.UserRequestFinished = true
end

RegisterCommand('fchamado', function()
    if not callRunning and not callParamsCommand then return end
    RequestStaff.UserRequestFinished = true
end)

function Client.setAcceptedCall(callParams)
    callRunning = true
    callParamsCommand = callParams
    local status = 'cancel'

    if not callParams or not callParams.location then return 'not params' end

    CreateThread(function()
        while callRunning and not RequestStaff.UserRequestFinished do
            local THREAD_OPTIMIZER = 500

            local playerCoords = GetEntityCoords(PlayerPedId())
            local targetCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(callParams.target_source)))

            if #(playerCoords - targetCoords) > 50.0 then
                SetEntityCoords(PlayerPedId(), targetCoords)
                TriggerEvent('Notify', 'importante', 'Use /fchamado para finalizar o chamado')
            end

            Wait(THREAD_OPTIMIZER)
        end

        if RequestStaff.UserRequestFinished then
            callRunning = false
            status = 'accepted'
            callParamsCommand = nil
            RequestStaff.UserRequestFinished = false
            RequestStaff.SendRequestFinished = false
        end
    end)

    CreateThread(function()
        while callRunning do
            local myPed = PlayerPedId()
            local pedSource = GetPlayerFromServerId(callParams.target_source)
            local ped = GetPlayerPed(pedSource)
            local pedCoords = GetEntityCoords(ped)

            if (myPed ~= ped) and pedCoords then
                DrawMarker(42,pedCoords.x, pedCoords.y, pedCoords.z+0.9 ,0,0,0, 90.0, 0,0, 0.2,1.0,0.2, 255,222,0,180 ,0,0,0,1)
            end

            Wait(0)
        end
    end)


    while callRunning do
        Wait(1000)
    end
   
    return status
end

function Client.feedbackCall(callParams)
    if not callParams then return 'not params' end

    local id = callParams.id

    SetNuiFocus(true, true)

    SendNUIMessage({
        action = 'request',
        data = { id = id, type = 'EVALUATE' }
    })

    while RequestFeedback.FeedBackCallback == nil do
        Wait(1000)
    end

    SetNuiFocus(false, false)

    local temp = RequestFeedback.FeedBackCallback

    RequestFeedback.FeedBackCallback = nil

    return temp
end

function Client.inDomination()
    return exports.dm_module:inDomination() or exports.dominacao:inDomination() or exports.nova_dominacao_pistol:inDomination()
end