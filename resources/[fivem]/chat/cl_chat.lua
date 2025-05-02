local chatOpen = false

RegisterNetEvent('__cfx_internal:serverPrint')
AddEventHandler('__cfx_internal:serverPrint', function(msg)
  chatOpen = false
end)

function openChat()
    chatOpen = true
    SendNUIMessage({ action = 'chat:show', data = true })
    SetNuiFocus(true, true)
end

RegisterKeyMapping('open_chat', 'Abrir Chat', 'keyboard', 't')
RegisterCommand('open_chat', function(source,args)
    openChat()
end)

RegisterNUICallback('closeChat', function(data, cb) 
    -- SendNUIMessage({ action = 'chat:hide' })
    SetNuiFocus(false, false)
end)

CreateThread(function()
    SetTextChatEnabled(false)
    SetNuiFocus(false, false)
end)

RegisterNUICallback('new:command', function(data, cb)
  if data.message:sub(1,1) == '/' then
    ExecuteCommand(data.message:sub(2))
  end

  SetNuiFocus(false, false)
  cb('new:command')
end)

RegisterNetEvent('chatMessage')
AddEventHandler('chatMessage', function(data)
  if not data or type(data) ~= 'table' or not next(data) then return end

  local typeMessage = data.type

  if not typeMessage or typeMessage == '' then typeMessage = 'default' end

  if categorysMessage[typeMessage] then
    SendNUIMessage({
      action = 'create:message',
      data = categorysMessage[typeMessage](data)
    })
  end
end) 

RegisterNetEvent('chat:storeMessage', function(data)
  SendNUIMessage({
    action = 'create:message', 
    data = { 
      message = string.format('<b>%s</b> comprou %s', data.args[1], data.args[2]), 
      prefix = 'ANUNCIO', 
      type = 'tip',
      title = '💎 COMPRA NA LOJA 💎'
    }
  })
end)

RegisterNetEvent('chat:addMessage', function(data)
  SendNUIMessage({
    action = 'create:message', 
    data = { 
      message = string.format('<b>%s</b> comprou %s', data.args[1], data.args[2]), 
      type = 'vip',
      title = '💎 COMPRA NA LOJA 💎'
    }
  })
end)