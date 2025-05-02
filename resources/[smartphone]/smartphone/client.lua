IsNuiOpen = false
Summerz = false
src = {
  close = function()
    IsNuiOpen = false
    SetNuiFocus(false)
  end,
  open = function()
    IsNuiOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({event='open',args={}})
  end,
  eval = function(code)
    return load(code)()
  end,
  __clear = function()
    return true
  end
}

RegisterNUICallback('client', function(data, cb)
  if table.unpack(data.args) then
    res =src[data.member](table.unpack(data.args))
    if res == nil then
      res = true
    end
  else
    print(table.unpack(data.args))
    res =src[data.member](table.unpack(data.args))
    if res == nil then
      res = true
    end
  end
  cb(res)
end)

RegisterNUICallback('backend', function(data, cb)
  requestToBackend(data.member, data.args, cb)
end)

local backend_promises = { id=1 }
RegisterNetEvent('backend:res')
AddEventHandler('backend:res', function(rid, res)
  if backend_promises[rid] then
    backend_promises[rid](res)
    backend_promises[rid] = nil
  end
end)

RegisterNetEvent('smartphone:setLoc')
AddEventHandler('smartphone:setLoc', function(loc)
  SetNewWaypoint(loc[1], loc[2])
end)

function requestToBackend(member, args, cb)
  local id = backend_promises.id
  backend_promises.id=id+1

  backend_promises[id] = cb
  TriggerServerEvent('backend:req', id, member, args or {})
end

Citizen.CreateThread(function()
  Wait(5000)

  requestToBackend('download', {}, function(script)
    SendNUIMessage(script)
  end)
end)

local delaynotify = false
function NoPhoneCallback()
  if not delaynotify then
    delaynotify = true
    TriggerEvent("Notify","Negado","Você não tem um <b>celular</b> em sua mochila!",5000)
    TriggerEvent("itensNotify",{ "NÃO POSSUI","celular",1,"CELULAR" })
    Wait(3000)
    delaynotify = false
  end
end