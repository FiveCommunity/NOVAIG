# Docs - Lotus Group Concessionária

## 1. Visibilidade

```lua
SendNUIMessage({ action = 'open' })
SendNUIMessage({ action = 'close' })

RegisterNUICallback('CLOSE_NUI', function(cb, data)
  SetNuiFocus(false, false)
  SendNUIMessage({ action = 'close' })
  cb('ok')
end)
```

## 2. Requisição dos veículos

```lua
RegisterNUICallback('GET_VEHICLES', function(cb, data)
  -- TIPOS DE CATEGORIA: esportivos, vips, motos, sedan, outros, off-roads, caminhoes, aeronaves
  local vehicles = {
      {
          name = "Kawasaki Ninja H2R",
          value = 150000,
          image = "/vehicle.png",
          brake = "Bom",
          acceleration = "Boa",
          speed = 400,
          seats = 1,
          stock = 5,
          category = "esportivos"
      },
      {
          name = "Ducati Panigale V4",
          value = 120000,
          image = "/vehicle.png",
          brake = "Bom",
          acceleration = "Boa",
          speed = 350,
          seats = 1,
          stock = 3,
          category = "vips"
      },
      {
          name = "BMW S1000RR",
          value = 110000,
          image = "/vehicle.png",
          brake = "Bom",
          acceleration = "Boa",
          speed = 330,
          seats = 1,
          stock = 4,
          category = "motos"
      },
      {
          name = "Ferrari F8 Tributo",
          value = 3500000,
          image = "/vehicle.png",
          brake = "Excelente",
          acceleration = "Excelente",
          speed = 340,
          seats = 2,
          stock = 2,
          category = "esportivos"
      },
      {
          name = "Porsche 911 GT3 RS",
          value = 2800000,
          image = "/vehicle.png",
          brake = "Excelente",
          acceleration = "Excelente",
          speed = 320,
          seats = 2,
          stock = 3,
          category = "esportivos"
      },
      {
          name = "Mercedes-Benz S-Class",
          value = 950000,
          image = "/vehicle.png",
          brake = "Muito Bom",
          acceleration = "Muito Boa",
          speed = 250,
          seats = 5,
          stock = 4,
          category = "sedan"
      },
      {
          name = "BMW X7",
          value = 1200000,
          image = "/vehicle.png",
          brake = "Muito Bom",
          acceleration = "Muito Boa",
          speed = 230,
          seats = 7,
          stock = 3,
          category = "outros"
      },
      {
          name = "Land Rover Defender",
          value = 850000,
          image = "/vehicle.png",
          brake = "Bom",
          acceleration = "Boa",
          speed = 190,
          seats = 5,
          stock = 5,
          category = "off-roads"
      },
      {
          name = "Volvo FH16",
          value = 980000,
          image = "/vehicle.png",
          brake = "Muito Bom",
          acceleration = "Moderada",
          speed = 160,
          seats = 2,
          stock = 8,
          category = "caminhoes"
      },
      {
          name = "Cessna Citation X",
          value = 15000000,
          image = "/vehicle.png",
          brake = "Excelente",
          acceleration = "Excelente",
          speed = 980,
          seats = 12,
          stock = 1,
          category = "aeronaves"
      }
  }
  cb(vehicles)
end)
```
## 3. Verificação de compra

```lua
RegisterNUICallback('CAN_BUY', function(cb, data)
  local vehicle = data.vehicle
  local CAN_BUY = false -- true ou false (se retornar true, irá abrir o modal de compra com sucesso)
  cb(CAN_BUY)
end)
``` 

## 4. Test drive

```lua
RegisterNUICallback('TEST_DRIVE', function(cb, data)
  local vehicle = data.vehicle
  SetNuiFocus(false, false)
  cb('ok')
end)
```


## 5. Veículos mais vendidos

```lua
RegisterNUICallback('GET_MOST_SOLD', function(data, cb)
  local vehicles = {
    {
      name = "Kawasaki Ninja H2R",
      value = 150000,
      image = "/vehicle.png", 
      stock = 5,
    },
    {
      name = "Ferrari 488 GTB",
      value = 1200000,
      image = "/vehicle.png",
      stock = 2,
    },
    {
      name = "Mercedes-Benz C63 AMG",
      value = 450000,
      image = "/vehicle.png",
      stock = 3,
    },
    {
      name = "Porsche 911 GT3 RS",
      value = 980000,
      image = "/vehicle.png",
      stock = 1,
    }
  }
  cb(vehicles)
end)
```
