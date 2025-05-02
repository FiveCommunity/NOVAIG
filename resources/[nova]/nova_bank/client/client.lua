tn = tonumber

local ROUTES = {
    ['close'] = function()
        SendNUIMessage({ action = 'close' })
        SetNuiFocus(false, false)
      end,
      ['GetExtract'] = function(data)
        print('Extract '..json.encode(vTunnel.getExtract()))
        return vTunnel.getExtract()
      end,
      ['deposit'] = function(data)
        return vTunnel.tryDeposit(tn(data.value))
      end,
      ['transfer'] = function(data)
        return vTunnel.tryTransfer(tn(data.to), tn(data.value))
      end,
      ['witdraw'] = function(data)
        return vTunnel.tryWithdraw(tn(data.value))
      end,
      ['GetUser'] = function(data)
        print('GetUser '..json.encode(vTunnel.requestBankInfo()))
        return vTunnel.requestBankInfo()
      end,
      ['payfines'] = function(data)
        return vTunnel.payFines(tn(data.value))
      end,
      ['buycrypto'] = function(data)
        local amount = tonumber(data.amount)
        return vTunnel.buyCryptos(data.name, amount)
      end,

      ['sellcrypto'] = function(data)
        local amount = tonumber(data.amount)
        return vTunnel.sellCryptos(data.name, amount)
      end,

      ['requireCryptos'] = function(data)
          print('requisitando informacoes')
          local cryptos = vTunnel.requestCryptos() or {}
          print('informacoes requisitadas', json.encode(cryptos))
          return cryptos
      end,
}


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
      local ms = 1000
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)

        for _,loc in pairs(Config.locations) do
            local dist = #(pedCoords - loc.coords)
            isNear = (dist <= 10)
            if dist <= 5.0 then
                ms = 0
                DrawMarker(29,loc.coords.x,loc.coords.y,loc.coords.z,0,0,0,0,0,0, (loc.isBank and 1.0 or 0.5),(loc.isBank and 1.0 or 0.5), (loc.isBank and 1.0 or 0.5), 0, 255, 0, 80, 1,1,1,1)

                if IsControlJustPressed(0,38) and dist < 2 then
                    SetNuiFocus(true, true)
                    SendNUIMessage({ action = 'open' })
                end
            end
        end


        Wait( ms )
    end
end)

CreateThread(function()
    for k, v in pairs(ROUTES) do
        RegisterNUICallback(tostring(k), function(data, cb)
            local response = v(data)
            cb(response or {})
        end)
    end
end)

function RegisterTunnel.addBank(id, coords, isBank)
    Config.locations[tostring(id)] = { coords = vec3(tonumber(coords.x), tonumber(coords.y), tonumber(coords.z)), isBank = isBank }
end

function RegisterTunnel.removeBank(id)
    Config.locations[tostring(id)] = nil
end