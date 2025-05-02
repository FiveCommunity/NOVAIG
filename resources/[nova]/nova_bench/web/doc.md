```lua
  -- Abrir interface
  SendNUIMessage({ action = 'open', customs = {
    {
      name = 'JAQUETA',
      category = 'Roupas',
      model = {
        value = 0,
        max = 125,
      },
      texture = {
        value = 0,
        max = 125,
      },
    },
    {
      name = 'Chapeu',
      category = 'Acessórios',
      model = {
        value = 0,
        max = 125,
      },
      texture = {
        value = 0,
        max = 125,
      },
    },
    {
      name = 'CALÇA',
      category = 'Roupas',
      model = {
        value = 0,
        max = 125,
      },
      texture = {
        value = 0,
        max = 125,
      },
    },
    {
      name = 'CAMISA',
      category = 'Roupas',
      model = {
        value = 0,
        max = 125,
      },
      texture = {
        value = 0,
        max = 125,
      },
    },
    {
      name = 'SAPATOS',
      category = 'Roupas',
      model = {
        value = 0,
        max = 125,
      },
      texture = {
        value = 0,
        max = 125,
      },
    },
    {
      name = 'ÓCULOS',
      category = 'Acessórios',
      model = {
        value = 0,
        max = 125,
      },
      texture = {
        value = 0,
        max = 125,
      },
    },
    {
      name = 'LUVA',
      category = 'Acessórios',
      model = {
        value = 0,
        max = 125,
      },
      texture = {
        value = 0,
        max = 125,
      },
    },
    {
      name = 'CINTO',
      category = 'Acessórios',
      model = {
        value = 0,
        max = 125,
      },
      texture = {
        value = 0,
        max = 125,
      },
    },
    {
      name = 'MEIAS',
      category = 'Roupas',
      model = {
        value = 0,
        max = 125,
      },
      texture = {
        value = 0,
        max = 125,
      },
    },
    {
      name = 'RELOGIO',
      category = 'Acessórios',
      model = {
        value = 0,
        max = 125,
      },
      texture = {
        value = 0,
        max = 125,
      },
    },
    {
      name = 'ANEL',
      category = 'Acessórios',
      model = {
        value = 0,
        max = 125,
      },
      texture = {
        value = 0,
        max = 125,
      },
    },
    {
      name = 'BOLSA',
      category = 'Acessórios',
      model = {
        value = 0,
        max = 125,
      },
      texture = {
        value = 0,
        max = 125,
      },
    },
  } })

  -- fechar a interface
  SendNUIMessage({ action = 'close' })

  -- Callback quando o esc for apertado
  RegisterNUICallback('CLOSE', function(data, cb)
    SendNUIMessage({ action = 'close' })
    SetNuiFocus(false, false)
  cb(true)
  end)

  -- ROTAÇÃO DO JOGADOR
  RegisterNUICallback('ROTATE', function(data, cb)
    print(json.encode(data))
    cb(true)
  end)

  -- Mudança de camera
  RegisterNUICallback('CAM', function(data, cb)
    print(json.encode(data))
    cb(true)
  end)

  -- SALVAR CUSTOMIZAÇÃO NOVA DO JOGADOR
  RegisterNUICallback('SAVE', function(data, cb)
    print(json.encode(data))
    cb(true)
  end)

  -- RECEBE A NOVA TABELA INTEIRA DE CUSTOM ATUALIZADA A CADA MODIFICAÇÃO
  RegisterNUICallback('UPDATE_CUSTOM', function(data, cb)
    print(json.encode(data))
    cb(true)
  end)
``` 