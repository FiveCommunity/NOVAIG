local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")

RegisterServerEvent('smartphone:LuaIsTheBest')
AddEventHandler('smartphone:LuaIsTheBest', function(users, id, infos,name, loc, motivo)
  local aceito = false
  for k,v in pairs(users) do
    async(function()
      local source =  vRP.Source(parseInt(k))
      if source then
        TriggerClientEvent('chatMessage', source, 'CHAMADO', {19, 197, 43}, '('..infos.name..')  Enviado por ^1'..name..'^0 ['..id..'], '..motivo);
        local request =  vRP.Request(source,'Atender o chamado de '..name..'?', motivo)
        if request then
          if aceito then
              TriggerClientEvent('Notify', source, 'vermelho', 'Esse chamado já foi atendido', 5000);
            return
          end
          aceito = true
          TriggerClientEvent('smartphone:setLoc', source, loc)
          TriggerClientEvent('Notify', vRP.Source(parseInt(id)), 'verde', "Seu chamado foi atendido, aguarde no local.", 10000)
        end
      end
    end)
  end
  Wait(31000)
  if not aceito then
    TriggerClientEvent('Notify', vRP.Source(parseInt(id)), 'vermelho', "Seu chamado não foi atendido por ninguem.", 10000)
  end
end)
