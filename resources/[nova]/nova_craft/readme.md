## Pagina de produção:

Fetch disparado para pegar todas as informações da pagina de produção:

```lua
RegisterNuiCallback('GetProductions', function(data, cb)
  cb({
    queue = 4, -- quantidade de slots que o cara pode deixar na fila
    items = {
      { 
        name = 'Aluminio', 
        image = 'aluminio', 
        spawn = 'aluminio', 
        production: { time: 1000 }, -- tempo q está.
        time = 20, 
        requires = [ 
          { spawn = 'aluminio', amount = 2, name = 'asdas', image = 'aluminio' }, 
          { spawn = 'aluminio', amount = 2, name = 'asdas', image = 'aluminio' }, 
          { spawn = 'aluminio', amount = 2, name = 'asdas', image = 'aluminio' } 
        ] 
      },
            { 
        name = 'Aluminio', 
        image = 'aluminio', 
        spawn = 'aluminio', 
        production: { time: 1000 }, -- tempo q está
        time = 20, 
        requires = [ 
          { spawn = 'aluminio', amount = 2, name = 'asdas', image = 'aluminio' }, 
          { spawn = 'aluminio', amount = 2, name = 'asdas', image = 'aluminio' }, 
          { spawn = 'aluminio', amount = 2, name = 'asdas', image = 'aluminio' } 
        ] 
      },
    }, -- lista de items
    storage = {
      { item = 'Ferro', amount = 1 },
      { item = 'Ferro', amount = 232 },
      { item = 'Ferro', amount = 232 },
      { item = 'Ferro', amount = 232 },
      { item = 'Ferro', amount = 232 },
      { item = 'Ferro', amount = 232 },
      { item = 'Ferro', amount = 232 },
    }, -- lista de itens que tem no armazém
    materials = {
      { amount = 1000, buyed = true, price = 1000 },
      { amount = 1000, buyed = false, price = 1000 },
      { amount = 1000, buyed = false, price = 1000 },
      { amount = 1000, buyed = false, price = 1000 },
      { amount = 1000, buyed = false, price = 1000 },
      { amount = 1000, buyed = false, price = 1000 },
      { amount = 1000, buyed = true, price = 1000 },
      { amount = 1000, buyed = true, price = 1000 },
      { amount = 1000, buyed = true, price = 1000 },
      { amount = 1000, buyed = true, price = 1000 },
      { amount = 1000, buyed = true, price = 1000 },
      { amount = 1000, buyed = true, price = 1000 },
      { amount = 1000, buyed = true, price = 1000 },
      { amount = 1000, buyed = true, price = 1000 },
      { amount = 1000, buyed = true, price = 1000 },
      { amount = 1000, buyed = true, price = 1000 },
      { amount = 1000, buyed = true, price = 1000 },
      { amount = 1000, buyed = true, price = 1000 },
      { amount = 1000, buyed = true, price = 1000 },
      { amount = 1000, buyed = true, price = 1000 },
      { amount = 1000, buyed = true, price = 1000 },
      { amount = 1000, buyed = true, price = 1000 },
    } -- lista de matérias
  })
end)
```

Fetch disparado para sempre que é adicionado um item na fila para ser craftado:

```lua
RegisterNuiCallback('AddToQueue', function(data, cb)
  local itemsInQueue = data.items
  cb({
    {
      time = 2,
      name = 'Aluminio',
      image = 'aluminio',
      spawn = 'aluminio',
      requires = {
        {
          name = 'aluminio',
          spawn = 'aluminio',
          image = 'aluminio',
          amount = 2,
        }
      }
    },
    {
      time = 2,
      name = 'Aluminio',
      image = 'aluminio',
      spawn = 'aluminio',
      requires = {
        {
          name = 'aluminio',
          spawn = 'aluminio',
          image = 'aluminio',
          amount = 2,
        }
      }
    }
  })
end)
```

Fetch disparado para quando a pessoa escolhe produzir agora:

```lua
RegisterNuiCallback('ProduceItem', function(data, cb)
  local item = data.item -- item que vai ser produzido.
  cb(4000) -- tempo q vai demorar pro item ser produzido.
end)
```

## Pagina de ranking:

Fetch disparado para pegar o ranking a propriedade isMy é para verificar se é o player

```lua
RegisterNuiCallback('GetRanking', function(data, cb)
  cb({
    { position = 1, id = 1, name = 'test', daily = 222, weekly = 222, monthly = 333 },
    { position = 1, id = 1, name = 'test', daily = 222, weekly = 222, monthly = 333 },
    { position = 1, id = 1, name = 'test', daily = 222, weekly = 222, monthly = 333, isMy = true },
    { position = 1, id = 1, name = 'test', daily = 222, weekly = 222, monthly = 333 },
    { position = 1, id = 1, name = 'test', daily = 222, weekly = 222, monthly = 333 },
    { position = 1, id = 1, name = 'test', daily = 222, weekly = 222, monthly = 333 },
  })
end)
```

## Matérias

Fetch disparada sempre que a pessoa compra uma quantidade de espaço de matérias

```lua
RegisterNuiCallback('BuyMaterial', function(data,cb)
  local material = data.material
  cb({
    { price = 1000, buyed = true, amount = 200 },
    { price = 1000, buyed = true, amount = 200 },
    { price = 1000, buyed = true, amount = 200 },
    { price = 1000, buyed = true, amount = 200 },
  }) -- lista atualizada de matérias
end)
``` 

## Fechar

Fetch para quando fechar:

```lua
RegisterNuiCallback('Close', function(data,cb)
  SendNUIMessage({ action = 'opened', data = false })
  cb(true)
end)
```