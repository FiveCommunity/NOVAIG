Config = {}

Config.totalDays = 30
Config.Webhook = 'https://canary.discord.com/api/webhooks/1306642642863657050/ZRlVBSl5TBSxVTBJsHDCZQDhDxTY9ppPwKZ1LeeMD-szmZIOFAH1ffpP4stDq9inhIGE'

Config.websiteURL = 'https://altarjroleplay.shop/'
Config.imagesURL = 'http://177.54.148.31:4020/lotus/lotus_battlepass/'
Config.minTime = 30

Config.startDay = { year = 2025 , month = 2, day = 20 }

Config.items = {
    {
        name = 'GROTTI CALIFORNIA CONVERSÍVEL',
        spawn = 'fc15',
        amount = 1,
        day = 1,
        redeemed = false,
        avaliable = false,
        type = 'premium',
        typeItem = 'item',
        func = function(userId)
            exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos (user_id, veiculo) VALUES (?, ?)', { userId, 'fc15' })
        end,
    },
    {
        name = 'CAIXA DE VERÃO',
        spawn = 'crate_verao',
        amount = 1,
        day = 2,
        redeemed = false,
        avaliable = false,
        type = 'premium',
        typeItem = 'item',
        func = function(userId)
            exports.nova_box:addBox(userId, 'crate_verao')
        end,
    },
    {
        name = 'DINHEIRO 50K',
        spawn = 'dinheiro',
        amount = 50000,
        day = 3,
        redeemed = false,
        avaliable = false,
        type = 'vip',
        typeItem = 'item',
        func = function(userId)
            vRP.giveInventoryItem(userId, 'money', 50000)
        end,
    },
    {
        name = 'CAIXA DE CARROS',
        spawn = 'crate_cars',
        amount = 1,
        day = 4,
        redeemed = false,
        avaliable = false,
        type = 'premium',
        typeItem = 'item',
        func = function(userId)
            exports.nova_box:addBox(userId, 'crate_cars')
        end,
    },
    {
        name = 'MAKAPOINTS 500',
        spawn = 'makapoints',
        amount = 500,
        day = 5,
        redeemed = false,
        avaliable = false,
        type = 'vip',
        typeItem = 'item',
        func = function(userId)
            vRP.giveMakapoints(userId, 500)
        end,
    },
    {
        name = 'RADIO',
        spawn = 'radio',
        amount = 5,
        day = 6,
        redeemed = false,
        avaliable = false,
        type = 'vip',
        typeItem = 'item',
        func = function(userId)
            vRP.giveInventoryItem(userId, 'radio', 5)
        end,
    },
    {
        name = 'BRICKADE',
        spawn = 'wrbrickade',
        amount = 1,
        day = 7,
        redeemed = false,
        avaliable = false,
        type = 'premium',
        typeItem = 'item',
        func = function(userId)
            exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos (user_id, veiculo) VALUES (?, ?)', { userId, 'wrbrickade' })
        end,
    },
    {
        name = 'CAPUZ',
        spawn = 'capuz',
        amount = 5,
        day = 8,
        redeemed = false,
        avaliable = false,
        type = 'vip',
        typeItem = 'item',
        func = function(userId)
            vRP.giveInventoryItem(userId, 'capuz', 5)
        end,
    },
    {
        name = 'CAIXA DE NATAL',
        spawn = 'crate_natal',
        amount = 1,
        day = 9,
        redeemed = false,
        avaliable = false,
        type = 'premium',
        typeItem = 'item',
        func = function(userId)
            exports.nova_box:addBox(userId, 'crate_natal')
        end,
    },
    {
        name = 'CHAVE CAIXA VERAO',
        spawn = 'key_verao',
        amount = 2,
        day = 10,
        redeemed = false,
        avaliable = false,
        type = 'premium',
        typeItem = 'item',
        func = function(userId)
            exports.nova_box:addKey(userId, 'key_verao', 2)
        end,
    },
    {
        name = 'MOCHILAS',
        spawn = 'mochila',
        amount = 3,
        day = 11,
        redeemed = false,
        avaliable = false,
        type = 'vip',
        typeItem = 'item',
        func = function(userId)
            vRP.giveInventoryItem(userId, 'mochila', 3)
        end,
    },
    {
        name = 'DINHEIRO SUJO 150K',
        spawn = 'dirty_money',
        amount = 150000,
        day = 12,
        redeemed = false,
        avaliable = false,
        type = 'premium',
        typeItem = 'item',
        func = function(userId)
            vRP.giveInventoryItem(userId, 'dirty_money', 150000)
        end,
    },
    {
        name = 'ADRENALINA 5X',
        spawn = 'adrenalina',
        amount = 5,
        day = 13,
        redeemed = false,
        avaliable = false,
        type = 'vip',
        typeItem = 'item',
        func = function(userId)
            vRP.giveInventoryItem(userId, 'adrenalina', 5)
        end,
    },
    {
        name = 'SPOTIFY 14 DIAS',
        spawn = 'spotify',
        amount = 1,
        day = 14,
        redeemed = false,
        avaliable = false,
        type = 'premium',
        typeItem = 'grupo',
        func = function(userId)
            vRP.addUserGroup(userId, 'spotify')
            exports.hooka:renew(user_id, 'ungroup', { 'spotify' }, 14)
        end,
    },
    {
        name = 'MACONHA 30X',
        spawn = 'maconha',
        amount = 30,
        day = 15,
        redeemed = false,
        avaliable = false,
        type = 'vip',
        typeItem = 'item',
        func = function(userId)
            vRP.giveInventoryItem(userId, 'maconha', 30)
        end,
    },
    {
        name = 'G3 10X',
        spawn = 'weapon_specialcarbine_mk2',
        amount = 10,
        day = 16,
        redeemed = false,
        avaliable = false,
        type = 'premium',
        typeItem = 'item',
        func = function(userId)
            vRP.giveInventoryItem(userId, 'weapon_specialcarbine_mk2', 10)
        end,
    },
    {
        name = 'BICICLETA',
        spawn = 'tribike',
        amount = 1,
        day = 17,
        redeemed = false,
        avaliable = false,
        type = 'premium',
        typeItem = 'item',
        func = function(userId)
            exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos (user_id, veiculo) VALUES (?, ?)', { userId, 'tribike' })
        end,
    },
    {
        name = 'MAKAPOINTS 500',
        spawn = 'makapoints',
        amount = 500,
        day = 18,
        redeemed = false,
        avaliable = false,
        type = 'vip',
        typeItem = 'item',
        func = function(userId)
            vRP.giveMakapoints(userId, 500)
        end,
    },
    {
        name = 'HELICOPTERO HAVOK',
        spawn = 'havok',
        amount = 1,
        day = 19,
        redeemed = false,
        avaliable = false,
        type = 'premium',
        typeItem = 'item',
        func = function(userId)
            exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos (user_id, veiculo) VALUES (?, ?)', { userId, 'havok' })
        end,
    },
    {
        name = 'CAIXA DE VERÃO 2X',
        spawn = 'crate_verao',
        amount = 2,
        day = 20,
        redeemed = false,
        avaliable = false,
        type = 'premium',
        typeItem = 'item',
        func = function(userId)
            for i = 1, 2 do
                exports.nova_box:addBox(userId, 'crate_verao')
            end
        end,
    },
    {
        name = 'JET SKI',
        spawn = 'seashark',
        amount = 1,
        day = 21,
        redeemed = false,
        avaliable = false,
        type = 'premium',
        typeItem = 'item',
        func = function(userId)
            exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos (user_id, veiculo) VALUES (?, ?)', { userId, 'seashark' })
        end,
    },
    {
        name = 'COCAINA 20X',
        spawn = 'cocaina',
        amount = 20,
        day = 22,
        redeemed = false,
        avaliable = false,
        type = 'vip',
        typeItem = 'item',
        func = function(userId)
            vRP.giveInventoryItem(userId, 'cocaina', 20)
        end,
    },
    {
        name = 'MAKAPOINTS 500',
        spawn = 'makapoints',
        amount = 500,
        day = 23,
        redeemed = false,
        avaliable = false,
        type = 'vip',
        typeItem = 'item',
        func = function(userId)
            vRP.giveMakapoints(userId, 500)
        end,
    },
    {
        name = 'CAIXA LENDÁRIA',
        spawn = 'crate_legendary',
        amount = 1,
        day = 24,
        redeemed = false,
        avaliable = false,
        type = 'premium',
        typeItem = 'item',
        func = function(userId)
            exports.nova_box:addBox(userId, 'crate_legendary')
        end,
    },
    {
        name = 'DINHEIRO SUJO 250K',
        spawn = 'dirty_money',
        amount = 250000,
        day = 25,
        redeemed = false,
        avaliable = false,
        type = 'vip',
        typeItem = 'item',
        func = function(userId)
            vRP.giveInventoryItem(userId, 'dirty_money', 250000)
        end,
    },
    {
        name = 'PAREDAO DE SOM',
        spawn = 'paredao',
        amount = 1,
        day = 26,
        redeemed = false,
        avaliable = false,
        type = 'premium',
        typeItem = 'item',
        func = function(userId)
            exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos (user_id, veiculo) VALUES (?, ?)', { userId, 'paredao' })
        end,
    },
    {
        name = 'DINHEIRO LIMPO 200K',
        spawn = 'dinheiro',
        amount = 200000,
        day = 27,
        redeemed = false,
        avaliable = false,
        type = 'vip',
        typeItem = 'item',
        func = function(userId)
            vRP.giveInventoryItem(userId, 'dirty_money', 200000)
        end,
    },
    {
        name = 'NAGASAKI SAKURA',
        spawn = 'wrr1sakura',
        amount = 1,
        day = 28,
        redeemed = false,
        avaliable = false,
        type = 'premium',
        typeItem = 'item',
        func = function(userId)
            exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos (user_id, veiculo) VALUES (?, ?)', { userId, 'wrr1sakura' })
        end,
    },
    {
        name = 'MAKAPOINTS 500',
        spawn = 'makapoints',
        amount = 500,
        day = 29,
        redeemed = false,
        avaliable = false,
        type = 'vip',
        typeItem = 'item',
        func = function(userId)
            vRP.giveMakapoints(userId, 500)
        end,
    },
    {
        name = 'PFISTER 918S CONVERSÍVEL',
        spawn = '918s',
        amount = 1,
        day = 30,
        redeemed = false,
        avaliable = false,
        type = 'premium',
        typeItem = 'item',
        func = function(userId)
            exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos (user_id, veiculo) VALUES (?, ?)', { userId, '918s' })
        end,
    },
}