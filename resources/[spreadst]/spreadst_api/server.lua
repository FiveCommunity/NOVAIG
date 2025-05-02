local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")

RegisterServerEvent("spreadst_api:whitelist", function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end

  local id = payload.id;
  local name = payload.name;
  vRP._setWhitelisted(tonumber(id), true)

  callback({
    error = false,
    message = ''
  })
end)

RegisterServerEvent("spreadst_api:status", function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  local onlinePlayers = GetNumPlayerIndices()
  local onlineFacs = vRP.getUsersByPermission("perm.ilegal")

  callback({
    facs = #onlineFacs,
    online = onlinePlayers
  })
end)

RegisterServerEvent("spreadst_api:checkStaff",function(user_id)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
	local source = vRP.getUserSource(parseInt(user_id))
  local sourceStaff = false
  local sourceInServer = false
  local sourceIp = "0.0.0.0"
	if source then
    sourceInServer = true
    sourceIp = GetPlayerEndpoint(source)
		if vRP.hasPermission(parseInt(user_id),"suporte.permissao") or vRP.hasGroup(user_id, 'ajudantefivegroup@445') then
      sourceStaff = true
		end
	end
  callback({
    inCity = sourceInServer,
    isStaff = sourceStaff,
    ip = sourceIp
  })
end)

RegisterServerEvent('lotus:updateWebhook', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  if not payload.webhook or not payload.name then
    return callback({
      error = true,
      message = 'Precisa ser envida uma webhook para ser alterada'
    })
  end
  
  exports.vrp:updateWebhook(payload.name, payload.webhook)
  callback({
    error = false,
    message = 'Webhook atualizada com sucesso'
  })
end)

RegisterServerEvent('lotus:addcar', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  if not payload.userId or not payload.vehicle then
    return callback({
      error = true,
      message = 'Precisa ser envida um id e um veiculo'
    })
  end
  
  exports.oxmysql:execute('INSERT INTO vrp_user_veiculos(user_id, veiculo) VALUES(?, ?)', { payload.userId, payload.vehicle })
  callback({
    error = false,
    message = 'Veiculo adicionado com sucesso'
  })
end)

RegisterServerEvent('lotus:remcar', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  if not payload.userId or not payload.vehicle then
    return callback({
      error = true,
      message = 'Precisa ser envida um id e um veiculo'
    })
  end
  
  exports.oxmysql:execute('DELETE FROM vrp_user_veiculos WHERE user_id = ? AND veiculo = ?', { payload.userId, payload.vehicle })
  callback({
    error = false,
    message = 'Veiculo removido com sucesso'
  })
end)

local function formatCoords(coords)
  return string.format('%.2f, %.2f, %.2f', coords.x, coords.y, coords.z)
end

RegisterServerEvent('lotus:listChests', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  local chests = exports.inventory:getChests()
  local chestsString = ''
  if chests and #chests > 0 then
    for _, chest in ipairs(chests) do
      chestsString = chestsString .. string.format('Nome: **%s**, peso: **%s**, permissao: **%s**, coordenada: **%s**\n', chest.name, chest.weight, chest.permission, formatCoords(chest.coords))
    end
  end
  callback({
    error = false,
    message = chestsString ~= '' and chestsString or 'Nenhum baú encontrado'
  })
end)

function split(input, delimiter)
  local result = {}
  for match in (input .. delimiter):gmatch("(.-)" .. delimiter) do
      table.insert(result, match)
  end
  return result
end

RegisterServerEvent('lotus:addChest', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  if not payload.chestName or not payload.chestWeight or not payload.chestPermission or not payload.chestCoords then
    return callback({
      error = true,
      message = 'Precisa ser envida um nome, peso, permissao e coordenadas'
    })
  end

  local chestName = payload.chestName
  local chestWeight = tonumber(payload.chestWeight)
  local chestPermission = (payload.chestPermission):lower()
  local coordsArray = split(payload.chestCoords, ',')
  local coordsVector = vector3(tonumber(coordsArray[1]), tonumber(coordsArray[2]), tonumber(coordsArray[3]))

  if not chestName or not chestWeight or not chestPermission or not coordsVector then
    return callback({
      error = true,
      message = 'Precisa ser envida um nome, peso, permissao e coordenadas'
    })
  end

  local chest, message = exports.inventory:addChest(chestName, chestWeight, chestPermission, coordsVector)
  if not chest then
    return callback({
      error = true,
      message = message
    })
  end
  
  callback({
    error = false,
    message = message
  })
end)

RegisterServerEvent('lotus:remChest', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  if not payload.chestName then
    return callback({
      error = true,
      message = 'Precisa ser envida um nome'
    })
  end

  local chestName = payload.chestName

  local chest, message = exports.inventory:removeChest(chestName)
  if not chest then
    return callback({
      error = true,
      message = message
    })
  end
  
  callback({
    error = false,
    message = message
  })
end)

RegisterServerEvent('lotus:updateChest', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  if not payload.chestName or not payload.chestWeight or not payload.chestCoords then
    return callback({
      error = true,
      message = 'Precisa ser envida um nome, peso e coordenadas'
    })
  end

  local chestName = payload.chestName
  local chestWeight = tonumber(payload.chestWeight)
  local chestCoords = payload.chestCoords
  local chestCoordsArray = split(chestCoords, ',')
  local chestCoordsVector = vector3(tonumber(chestCoordsArray[1]), tonumber(chestCoordsArray[2]), tonumber(chestCoordsArray[3]))

  local chest, message = exports.inventory:updateChest(chestName, chestWeight, chestCoordsVector)
  if not chest then
    return callback({
      error = true,
      message = message
    })
  end
  
  callback({
    error = false,
    message = message
  })
end)

RegisterServerEvent('lotus:updateChestCoords', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  if not payload.chestName or not payload.chestCoords then
    return callback({
      error = true,
      message = 'Precisa ser envida um nome e coordenadas'
    })
  end

  local chestName = payload.chestName
  local chestCoords = payload.chestCoords
  local chestCoordsArray = split(chestCoords, ',')
  local chestCoordsVector = vector3(tonumber(chestCoordsArray[1]), tonumber(chestCoordsArray[2]), tonumber(chestCoordsArray[3]))

  local chest, message = exports.inventory:updateChestCoords(chestName, chestCoordsVector)
  if not chest then
    return callback({
      error = true,
      message = message
    })
  end
  
  callback({
    error = false,
    message = message
  })
end)

RegisterServerEvent('lotus:updateChestWeight', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  if not payload.chestName or not payload.chestWeight then
    return callback({
      error = true,
      message = 'Precisa ser envida um nome e peso'
    })
  end

  local chestName = payload.chestName
  local chestWeight = tonumber(payload.chestWeight)

  local chest, message = exports.inventory:updateChestWeight(chestName, chestWeight)
  if not chest then
    return callback({
      error = true,
      message = message
    })
  end
  
  callback({
    error = false,
    message = message
  })
end)

RegisterServerEvent('lotus:listSkinShops', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  local skinShops = exports.nova_skinshop:getSkinShops()
  local skinShopsString = ''
  if skinShops and #skinShops > 0 then
    for _, skinShop in ipairs(skinShops) do
      skinShopsString = skinShopsString .. string.format('ID: **%s**, Tem blip: **%s**, coordenada: **%s**\n', skinShop.id, (skinShop.blip and 'Sim' or 'Não'), formatCoords(skinShop.coords))
    end
  end
  callback({
    error = false,
    message = skinShopsString ~= '' and skinShopsString or 'Nenhuma loja de skins encontrada'
  })
end)

RegisterServerEvent('lotus:addSkinsShop', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  if not payload.coords or not payload.blip then
    return callback({
      error = true,
      message = 'Precisa ser envida coordenadas e se tem blip'
    })
  end

  local coords = payload.coords
  local blip = payload.blip
  local coordsArray = split(coords, ',')
  local coordsArr = { tonumber(coordsArray[1]), tonumber(coordsArray[2]), tonumber(coordsArray[3]) }
  if blip ~= 'sim' and blip ~= 'nao' then
    return callback({
      error = true,
      message = 'Precisa ser envida se tem blip'
    })
  end

  blip = blip == 'sim'

  if not coordsArr then
    return callback({
      error = true,
      message = 'Precisa ser envida coordenadas'
    })
  end

  local skinShop, message = exports.nova_skinshop:addSkinshop(coordsArr, blip)
  if not skinShop then
    return callback({
      error = true,
      message = message
    })
  end
  
  callback({
    error = false,
    message = message
  })
end)

RegisterServerEvent('lotus:removeSkinsShop', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end

  if not payload.id then
    return callback({
      error = true,
      message = 'Precisa ser envida um id'
    })
  end

  local id = payload.id
  local skinShop, message = exports.nova_skinshop:removeSkinshop(id)
  if not skinShop then
    return callback({
      error = true,
      message = message
    })
  end
  
  callback({
    error = false,
    message = message
  })
end)

RegisterServerEvent('lotus:listBarberShops', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  local barberShops = exports.nova_barbershop:getBarberShops()
  local barberShopsString = ''
  if barberShops and #barberShops > 0 then
    for _, barberShop in ipairs(barberShops) do
      barberShopsString = barberShopsString .. string.format('ID: **%s**, Tem blip: **%s**, coordenada: **%s**\n', barberShop.id, (barberShop.blip and 'Sim' or 'Não'), formatCoords(barberShop.coords))
    end
  end
  callback({
    error = false,
    message = barberShopsString ~= '' and barberShopsString or 'Nenhuma barbearia encontrada'
  })
end)

RegisterServerEvent('lotus:addBarberShop', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  if not payload.coords or not payload.blip then
    return callback({
      error = true,
      message = 'Precisa ser enviada coordenadas e se tem blip'
    })
  end

  local coords = payload.coords
  local blip = payload.blip
  local coordsArray = split(coords, ',')
  local coordsArr = { tonumber(coordsArray[1]), tonumber(coordsArray[2]), tonumber(coordsArray[3]) }
  if blip ~= 'sim' and blip ~= 'nao' then
    return callback({
      error = true,
      message = 'Precisa ser enviada se tem blip'
    })
  end

  blip = blip == 'sim'

  if not coordsArr then
    return callback({
      error = true,
      message = 'Precisa ser enviada coordenadas'
    })
  end

  local barberShop, message = exports.nova_barbershop:addBarberShop(coordsArr, blip)
  if not barberShop then
    return callback({
      error = true,
      message = message
    })
  end
  
  callback({
    error = false,
    message = message
  })
end)

RegisterServerEvent('lotus:removeBarberShop', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end

  if not payload.id then
    return callback({
      error = true,
      message = 'Precisa ser enviado um id'
    })
  end

  local id = payload.id
  local barberShop, message = exports.nova_barbershop:removeBarberShop(id)
  if not barberShop then
    return callback({
      error = true,
      message = message
    })
  end
  
  callback({
    error = false,
    message = message
  })
end)

RegisterServerEvent('lotus:getTattooShops', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  local tattooShops = exports.nova_tattoos:getTattooShops()
  local tattooShopsString = ''
  if tattooShops and #tattooShops > 0 then
    for _, tattooShop in ipairs(tattooShops) do
      tattooShopsString = tattooShopsString .. string.format('ID: **%s**, Tem blip: **%s**, coordenada: **%s**\n', tattooShop.id, (tattooShop.blip and 'Sim' or 'Não'), formatCoords(tattooShop.coords))
    end
  end
  callback({
    error = false,
    message = tattooShopsString ~= '' and tattooShopsString or 'Nenhuma loja de tatuagem encontrada'
  })
end)

RegisterServerEvent('lotus:addTattooShop', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  if not payload.coords or not payload.blip then
    return callback({
      error = true,
      message = 'Precisa ser enviada coordenadas e se tem blip'
    })
  end

  local coords = payload.coords
  local blip = payload.blip
  local coordsArray = split(coords, ',')
  local coordsArr = { tonumber(coordsArray[1]), tonumber(coordsArray[2]), tonumber(coordsArray[3]) }
  if blip ~= 'sim' and blip ~= 'nao' then
    return callback({
      error = true,
      message = 'Precisa ser enviada se tem blip'
    })
  end

  blip = blip == 'sim'

  if not coordsArr then
    return callback({
      error = true,
      message = 'Precisa ser enviada coordenadas'
    })
  end

  local tattooShop, message = exports.nova_tattoos:addTattooShop(coordsArr, blip)
  if not tattooShop then
    return callback({
      error = true,
      message = message
    })
  end
  
  callback({
    error = false,
    message = message
  })
end)

RegisterServerEvent('lotus:removeTattooShop', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end

  if not payload.id then
    return callback({
      error = true,
      message = 'Precisa ser enviado um id'
    })
  end

  local id = payload.id
  local tattooShop, message = exports.nova_tattoos:removeTattooShop(id)
  if not tattooShop then
    return callback({
      error = true,
      message = message
    })
  end
  
  callback({
    error = false,
    message = message
  })
end)

RegisterServerEvent('lotus:getBanks', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  local banks = exports.nova_bank:getBanks()
  local banksString = ''
  if banks and #banks > 0 then
    for _, bank in ipairs(banks) do
      banksString = banksString .. string.format('ID: **%s**, Tipo: **%s**, coordenada: **%s**\n', bank.id, (bank.isBank and 'Banco' or 'Caixa'), formatCoords(bank.coords))
    end
  end
  callback({
    error = false,
    message = banksString ~= '' and banksString or 'Nenhum banco encontrado'
  })
end)

RegisterServerEvent('lotus:addBank', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  if not payload.coords or not payload.isBank then
    return callback({
      error = true,
      message = 'Precisa ser enviada coordenadas e se é banco'
    })
  end

  local coords = payload.coords
  local isBank = payload.isBank
  local coordsArray = split(coords, ',')
  local coordsArr = { tonumber(coordsArray[1]), tonumber(coordsArray[2]), tonumber(coordsArray[3]) }
  if isBank ~= 'sim' and isBank ~= 'nao' then
    return callback({
      error = true,
      message = 'Precisa ser enviado se é banco'
    })
  end

  isBank = isBank == 'sim'

  if not coordsArr then
    return callback({
      error = true,
      message = 'Precisa ser enviada coordenadas'
    })
  end

  local bank, message = exports.nova_bank:addBank(coordsArr, isBank)
  if not bank then
    return callback({
      error = true,
      message = message
    })
  end
  
  callback({
    error = false,
    message = message
  })
end)

RegisterServerEvent('lotus:removeBank', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end

  if not payload.id then
    return callback({
      error = true,
      message = 'Precisa ser enviado um id'
    })
  end

  local id = payload.id
  local bank, message = exports.nova_bank:removeBank(id)
  if not bank then
    return callback({
      error = true,
      message = message
    })
  end
  
  callback({
    error = false,
    message = message
  })
end)

RegisterServerEvent('lotus:getShops', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  local shops = exports.inventory:getShops()
  local shopsString = ''
  if shops and #shops > 0 then
    for _, shop in ipairs(shops) do
      shopsString = shopsString .. string.format('ID: **%s**, Tipo: **%s**, coordenada: **%s**\n', shop.id, (shop.blip and 'Com Blip' or 'Sem Blip'), formatCoords(shop.coords))
    end
  end
  callback({
    error = false,
    message = shopsString ~= '' and shopsString or 'Nenhuma loja encontrada'
  })
end)

RegisterServerEvent('lotus:addShop', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end
  
  if not payload.coords or not payload.blip then
    return callback({
      error = true,
      message = 'Precisa ser enviada coordenadas e se tem blip'
    })
  end

  local coords = payload.coords
  local blip = payload.blip
  local coordsArray = split(coords, ',')
  local coordsArr = { tonumber(coordsArray[1]), tonumber(coordsArray[2]), tonumber(coordsArray[3]) }
  if blip ~= 'sim' and blip ~= 'nao' then
    return callback({
      error = true,
      message = 'Precisa ser enviado se tem blip'
    })
  end

  blip = blip == 'sim'

  if not coordsArr then
    return callback({
      error = true,
      message = 'Precisa ser enviada coordenadas'
    })
  end

  local shop, message = exports.inventory:addShop(coordsArr, blip)
  if not shop then
    return callback({
      error = true,
      message = message
    })
  end
  
  callback({
    error = false,
    message = message
  })
end)

RegisterServerEvent('lotus:removeShop', function(payload, callback)
  local source = source
  if source and source ~= 0 and source ~= '' then
    print('Suspeito tentando derrubar o servidor: '..vRP.getUserId(source))
    return
  end

  if not payload.id then
    return callback({
      error = true,
      message = 'Precisa ser enviado um id'
    })
  end

  local id = payload.id
  local shop, message = exports.inventory:removeShop(id)
  if not shop then
    return callback({
      error = true,
      message = message
    })
  end
  
  callback({
    error = false,
    message = message
  })
end)