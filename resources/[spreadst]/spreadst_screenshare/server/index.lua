local usersJailed = {}

function RequestUserScreenShare(requestedBy, userId, url, requestedSource)
  local requestedBy = requestedBy  
  local url = url

  local source = vRP.getUserSource(userId)

  if usersJailed[source] then
    if source then 
      exports.vrp_misc:unBanned(requestedSource, usersJailed[source].id, 'JAIL LIBERADO')

      vCLIENT._toggleScreen(source, false)
      FreezeEntityPosition(GetPlayerPed(source), false)
    end

    usersJailed[source] = nil
    return 'O usuário que está em telagem foi liberado.'
  else
    if not source then
      return 'Usuário está offline', 'negado'
    end

    usersJailed[source] = {
      id = userId,
      calledBy = requestedBy,
      startTime = os.time()
    }

    local identity = vRP.getUserIdentity(userId)
    vCLIENT._toggleScreen(source, true, { url = url, name = ('%s %s'):format(identity.nome, identity.sobrenome), id = userId })
    FreezeEntityPosition(GetPlayerPed(source), true)
    vRP.setBanned(usersJailed[source].id, true, config.defaultReason)
    vRP.sendLog('https://discord.com/api/webhooks/1344619600871948288/7X9YyVgeratVhNOSFDPlxxD9JDuf96qNhnGiLOwkmXPyyn6cQhzD4epxNMVIVHRkXjk7','ID '..requestedBy..' utilizou /jail no '..userId..' O usuário foi preso no sistema de telagem, espere ele entrar em algum canal para testar')

    return 'O usuário foi preso no sistema de telagem, espere ele entrar em algum canal para testar'
  end
end

RegisterCommand('jail', function(source, args, rawCommand)
  local source = source
  local id = vRP.getUserId(source) 

  local perms = {
    { permType = 'perm', perm = 'developer.permissao' }, 

    { permType = 'group', perm = 'developerfivegroup@445' },
    { permType = 'group', perm = 'respstafffivegroup@445' },
    { permType = 'group', perm = 'resppoliciafivegroup@445' },
    { permType = 'group', perm = 'resplogfivegroup@445' },
    { permType = 'group', perm = 'respilegalfivegroup@445' },
    { permType = 'group', perm = 'respstreamerfivegroup@445' },
    { permType = 'group', perm = 'respeventosfivegroup@445' },
    { permType = 'group', perm = 'respkidsfivegroup@445' },
    { permType = 'group', perm = 'top1' },
    { permType = 'group', perm = 'SS' }, 
    { permType = 'group', perm = 'adminfivegroup@445' }, 
  }

  local hasPermission = false
  for _, perm in ipairs(perms) do
      if perm.permType == 'perm' then
          if vRP.hasPermission(id, perm.perm) then
              hasPermission = true
              break
          end
      elseif perm.permType == 'group' then
          if vRP.hasGroup(id, perm.perm) then
              hasPermission = true
              break
          end
      end
  end

  if not hasPermission then
      return TriggerClientEvent('Notify', source, 'negado', 'Você não possui permissão para utilizar esse comando.')
  end

  local user_id = vRP.prompt(source, 'Insira o ID do usuário', '')
  if not user_id then return end
    
  local response, typing = RequestUserScreenShare(id, tonumber(user_id), config.defaultURL, source)
  if response and type(response) == 'string' then

    vRP.sendLog('https://discord.com/api/webhooks/1344619600871948288/7X9YyVgeratVhNOSFDPlxxD9JDuf96qNhnGiLOwkmXPyyn6cQhzD4epxNMVIVHRkXjk7', 'STAFF: '..id .. ' USOU O COMANDO /JAIL NO ID: '..user_id)

    return TriggerClientEvent('Notify', source, typing or 'sucesso', response)
  end
end)

AddEventHandler('playerDropped', function(reason)
  local source = source
  if usersJailed[source] then
    local jailTime = os.time() - usersJailed[source].startTime
    local userId = usersJailed[source].id
    local reasonMessage = ('O usuário %s (%d) desconectou %d segundos após a solicitação de telagem pelo motivo %s'):format(vRP.getUserIdentity(userId).nome, userId, jailTime, reason)

    vRP.sendLog('https://discord.com/api/webhooks/1344619600871948288/7X9YyVgeratVhNOSFDPlxxD9JDuf96qNhnGiLOwkmXPyyn6cQhzD4epxNMVIVHRkXjk7', reasonMessage)

    usersJailed[source] = nil
  end
end)