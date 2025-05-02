local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

AddEventHandler('hydrus:system-notify', function(player_id, order)
    -- na vRP, player_id é o mesmo que user_id
    -- order é um objeto com muitas propriedades, veja o exemplo em JSON  
    
    local identity = vRP.getUserIdentity(player_id)
    
    local products = {}
    
    -- Salvando o nome de todos os produtos em uma lista
    for _, product in pairs(order.packages) do
        table.insert(products, product.name)
    end
    
    -- Juntando a lista para transformar em uma string
    products = table.concat(products, ' & ')
    

    TriggerClientEvent('chatMessage', -1, {
        type = 'vip',
        title = '💎 COMPRA NA LOJA 💎',
        message = string.format('<b>%s</b> comprou %s', identity.nome.. " "..identity.sobrenome, products)
    })
end)