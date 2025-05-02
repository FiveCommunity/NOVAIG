SendNUIMessage({
    action = 'open',
    data = 'EDIT_BENCH'
})

SendNUIMessage({
    action = 'UPDATE_WEIGHT',
    data = {
        weight = 10,
        maxWeight = 100,
    }
})

SendNUIMessage({
    action = 'UPDATE_LOGS',
    data = {
        'Coca-Cola foi adicionado ao banco de dados'
    }
})


RegisterNUICallback('PICK_UP_SALES_COUNTER', function(data, cb)
    local data = {
        inventory = {
            {
                name = 'Coca-Cola',
                image = 'https://i.imgur.com/6Z7R2VQ.png',
                amount = 10,
                weight = 1.5,
                value = 10,
                selected = true -- opcional
            },
            {
                name = 'Pepsi',
                image = 'https://i.imgur.com/6Z7R2VQ.png',
                amount = 10,
                weight = 1.5,
                value = 10,
                selected = true -- opcional
            },
        },
        bench = {
            {
                name = 'Coca-Cola',
                image = 'https://i.imgur.com/6Z7R2VQ.png',
                amount = 10,
                weight = 1.5,
                value = 10,
                selected = false -- opcional
            },
        },
        logs = { 'Coca-Cola foi adicionado ao banco de dados' },
        weight = 11.32,
        maxWeight = 40,
    }
    cb(data)
end)

-- Atualizar itens na bancada (apenas com a tela de gerenciamento de bancada aberta)
SendNUIMessage({
    action = 'UPDATE_BENCH',
    data = {
        {
            name = 'Coca-Cola',
            image = 'https://i.imgur.com/6Z7R2VQ.png',
            amount = 10,
            weight = 1.5,
            value = 10,
        },
    },
})

-- Atualizar inventário (apenas com a tela de gerenciamento de bancada aberta)
SendNUIMessage({
    action = 'UPDATE_ITEMS',
    data = {
        {
            name = 'Coca-Cola',
            image = 'https://i.imgur.com/6Z7R2VQ.png',
            amount = 10,
            weight = 1.5,
            value = 10,
        },
    },
})

-- Atualizar as logs (apenas com a tela de gerenciamento de bancada aberta)
SendNUIMessage({
    action = 'UPDATE_LOGS',
    data = { 'Coca-Cola foi adicionado ao banco de dados' }
})

RegisterNUICallback('PUT_ON_BENCH', function(data, cb)
    print(json.encode(data)) -- devolvo a tabela do item que foi adicionado a bancada
    cb(true)
end)


RegisterNUICallback('REMOVE_ITEM', function(data, cb)
    print(json.encode(data)) -- devolvo a tabela do item que foi removido
    cb(true)
end)

RegisterNUICallback('SELL_ITEM', function(data, cb)
    print(json.encode(data)) -- devolvo a tabela do item que foi vendido
    cb(true)
end)

RegisterNUICallback('EDIT_VALUE', function(data, cb)
    print(json.encode(data)) -- devolvo a tabela do item que foi editado
    cb(true)
end)

-- Abrir a tela de venda de itens
SendNUIMessage({
    action = 'open',
    data = 'STORE'
})

RegisterNUICallback('GET_PRODUCTS', function(data, cb)
    local products = {
        amount = 1,
        image = 'https://cdn.shopify.com/s/files/1/0533/2089/5885/products/product-image-1175360001_360x.jpg?v=1623860000',
        name = 'Coca-Cola',
        value = 5.0,
        weight = 0.5,
    }
    cb(products)
end)

RegisterNUICallback('BUY_ITEM', function(data, cb)
    print(json.encode(data)) -- devolvo a tabela do item que foi comprado
    cb(true)
end)


-- FECHAR INTERFACE
SendNUIMessage({
    action = 'close',
})

-- CALLBACK QUANDO APERTAR ESC
RegisterNUICallback('CLOSE', function(data, cb)
    SendNUIMessage({
        action = 'close',
    })    
    cb(true)
end)