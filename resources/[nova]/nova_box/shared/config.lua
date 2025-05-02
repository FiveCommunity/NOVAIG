Config = {
    dir = 'http://177.54.148.31:4020/lotus/inventario_021/',
    dirCars = 'http://177.54.148.31:4020/lotus/carros/',
    dirOthers = 'http://177.54.148.31:4020/lotus/lotus_box/',

    urlStore = 'https://altarjroleplay.shop/',

    raritys = {
        ['commom'] = 92,
        ['epic'] = 5,
        ['legendary'] = 3,
    },

    Crates = {
        ['crate_normal'] = {
            name = 'Caixa Normal',
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/crate_normal.png',
            price = 100,

            key = 'key_normal',
            rarity = 'commom',

            items = {
                {
                    item = 'COMPONENT_FIVESEVEN_NAMIFADE',
                    name = 'Five Seven Namifade',
                    type = 'others',

                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        exports["nova_skins"]:createSkin(user_id,"PISTOLAS","WEAPON_PISTOL_MK2","COMPONENT_FIVESEVEN_NAMIFADE")
                    end
                },

                {
                    item = 'radio',
                    name = 'Radio',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'radio', 1, true)
                    end
                },

                {

                    item = 'cocaina',
                    name = 'Cocaina',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'cocaina', 100, true)
                    end
                },

                {

                    item = 'WEAPON_PISTOL_MK2',
                    name = 'Five Seven',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'weapon_pistol_mk2', 2, true)
                    end
                },

                {

                    item = 'AMMO_PISTOL_MK2',
                    name = 'Munição de Five Seven',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'ammo_pistol_mk2', 200, true)
                    end
                },

                {

                    item = 'WEAPON_SPECIALCARBINE_MK2',
                    name = 'G3',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'weapon_specialcarbine_mk2', 2, true)
                    end
                },

                {

                    item = 'AMMO_SPECIALCARBINE_MK2',
                    name = 'Munição de G3',
                    type = 'item',

                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'ammo_specialcarbine_mk2', 200, true)
                    end
                },

                {

                    item = 'bandagem',
                    name = 'Bandagem',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'bandagem', 10, true)
                    end
                },

                {

                    item = 'energetico',
                    name = 'Energético',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'energetico', 10, true)
                    end
                },

                {

                    item = 'money',
                    name = 'Dinheiro',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'money', 100000, true)
                    end
                },

                {

                    item = 'balinha',
                    name = 'Balinha',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'balinha', 100, true)
                    end
                },

                {

                    item = 'lockpick',
                    name = 'Lock Pick',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'lockpick', 5, true)
                    end
                },

                {
                    item = 'pcx',
                    name = 'Moto Pcx',
                    type = 'car',

                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'pcx', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {
                    item = 't20',
                    name = 'Carro T20',
                    type = 'car',

                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 't20', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {
                    item = 'makapoints',
                    name = 'Makapoints',
                    type = 'others',

                    rarity = 'epic',
                    amount = 100,
                    func = function(source,user_id)
                        vRP.giveMakapoints(user_id, 100)
                    end
                },
            }
        },

        ['crate_epic'] = {
            name = 'Caixa Epica',
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/crate_epic.png',
            price = 150,

            key = 'key_epic',
            rarity = 'epic',

            items = {
                {
                    item = 'COMPONENT_AK103_DRAGON',
                    name = 'Skin AK47 Dragon',
                    type = 'others',


                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        exports["nova_skins"]:createSkin(user_id,"RIFLES","WEAPON_ASSAULTRIFLE_MK2","COMPONENT_AK103_DRAGON")
                    end
                },

                {
                    item = 'attachs',
                    name = 'Item Attachs',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'attachs', 30, true)
                    end
                },

                {

                    item = 'cocaina',
                    name = 'Cocaina',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'cocaina', 100, true)
                    end
                },

                {

                    item = 'WEAPON_PISTOL_MK2',
                    name = 'Five Seven',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'weapon_pistol_mk2', 5, true)
                    end
                },

                {

                    item = 'AMMO_PISTOL_MK2',
                    name = 'Munição de Five Seven',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'ammo_pistol_mk2', 250, true)
                    end
                },

                {

                    item = 'WEAPON_SPECIALCARBINE_MK2',
                    name = 'G3',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'weapon_specialcarbine_mk2', 3, true)
                    end
                },

                {

                    item = 'AMMO_SPECIALCARBINE_MK2',
                    name = 'Munição de G3',
                    type = 'item',

                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'ammo_specialcarbine_mk2', 250, true)
                    end
                },

                {

                    item = 'money',
                    name = 'Dinheiro',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'money', 250000	, true)
                    end
                },

                {

                    item = 'heroina',
                    name = 'Heroina',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'heroina', 100, true)
                    end
                },

                {

                    item = 'WEAPON_ASSAULTRIFLE',
                    name = 'AK47',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'weapon_assaultrifle', 5, true)
                    end
                },

                {

                    item = 'r8spyder20',
                    name = 'OBEY R8 Spyder',
                    type = 'car',

                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'r8spyder20', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {

                    item = 's1000rr',
                    name = 'S1000rr',
                    type = 'car',

                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 's1000rr', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {
                    item = 'zentorno',
                    name = 'Zentorno',
                    type = 'car',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'zentorno', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {
                    item = 'burrito',
                    name = 'Burrito',
                    type = 'car',

                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'burrito', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {
                    item = 'makapoints',
                    name = 'Makapoints',
                    type = 'others',

                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveMakapoints(user_id, 500)
                    end
                },
            },
            
        },

        ['crate_legendary'] = {
            name = 'Caixa Lendaria',
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/crate_legendary.png',
            price = 250,

            key = 'key_legendary',
            rarity = 'legendary',

            items = {
                {
                    item = 'COMPONENT_SMGMK2_SAKURA',
                    name = 'Skin SMG MK2 Sakura',
                    type = 'others',

                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        exports["nova_skins"]:createSkin(user_id,"SMGS","WEAPON_SMG_MK2","COMPONENT_SMGMK2_SAKURA")
                    end
                },

                {
                    item = 'bikelete',
                    name = 'Bikelete',
                    type = 'car',

                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'bikelete', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {

                    item = 'cocaina',
                    name = 'Cocaina',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'cocaina', 100, true)
                    end
                },

                {

                    item = 'WEAPON_PISTOL_MK2',
                    name = 'Five Seven',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'weapon_pistol_mk2', 10, true)
                    end
                },

                {

                    item = 'AMMO_PISTOL_MK2',
                    name = 'Munição de Five Seven',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'ammo_pistol_mk2', 500, true)
                    end
                },

                {

                    item = 'WEAPON_SPECIALCARBINE_MK2',
                    name = 'G3',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'weapon_specialcarbine_mk2', 5, true)
                    end
                },

                {

                    item = 'AMMO_SPECIALCARBINE_MK2',
                    name = 'Munição de G3',
                    type = 'item',

                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'ammo_specialcarbine_mk2', 500, true)
                    end
                },

                {

                    item = 'money',
                    name = 'Dinheiro',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'money', 500000, true)
                    end
                },

                {

                    item = '2f2fgtr34',
                    name = 'GT-R 34',
                    type = 'car',

                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = '2f2fgtr34', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {

                    item = 'makapoints',
                    name = 'Makapoints',
                    type = 'others',

                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveMakapoints(user_id, 500)
                    end
                },

                {
                    item = 'COMPONENT_FIVESEVEN_SHIPPUDEN',
                    name = 'Skin Five Seven Shippuden',
                    type = 'others',

                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        exports["nova_skins"]:createSkin(user_id,"PISTOL","WEAPON_PISTOL_MK2","COMPONENT_FIVESEVEN_SHIPPUDEN")
                    end
                },

                {

                    item = 'fnfmk4',
                    name = 'Supra MK4',
                    type = 'car',

                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'fnfmk4', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {
                    item = 'bmws',
                    name = 'Moto BMWS',
                    type = 'car',

                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'bmws', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {
                    item = 'burrito',
                    name = 'Burrito',
                    type = 'car',

                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'burrito', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {
                    item = 'COMPONENT_SIG_FLOWER',
                    name = 'Skin G3 Flower',
                    type = 'others',

                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        exports["nova_skins"]:createSkin(user_id,"RIFLE","WEAPON_SPECIALCARBINE_MK2","COMPONENT_SIG_FLOWER")
                    end
                },
            }
        },
        ['crate_hero'] = {
            name = 'Caixa Hero',
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/crate_hero.png',
            price = 350,
        
            key = 'key_hero',
            rarity = 'legendary',
        
            items = {
                {
                    item = 'COMPONENT_AK74_HERO',
                    name = 'SKIN AK MK2  HERO',
                    type = 'others',
        
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        exports["nova_skins"]:createSkin(user_id,"RIFLE","WEAPON_ASSAULTRIFLE_MK2","COMPONENT_AK74_HERO")
                    end
                },
        
                {
                    item = 'm3e46',
                    name = 'UBERMACHT M3 E36',
                    type = 'car',
        
                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'm3e46', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },
        
                {
        
                    item = 'cocaina',
                    name = 'Cocaina',
                    type = 'item',
        
                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'cocaina', 100, true)
                    end
                },
        
                {
        
                    item = 'WEAPON_PISTOL_MK2',
                    name = 'Five Seven',
                    type = 'item',
        
                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'weapon_pistol_mk2', 5, true)
                    end
                },
        
                {
        
                    item = 'AMMO_PISTOL_MK2',
                    name = 'Munição de Five Seven',
                    type = 'item',
        
                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'ammo_pistol_mk2', 500, true)
                    end
                },
        
                {
        
                    item = 'WEAPON_SPECIALCARBINE_MK2',
                    name = 'G3',
                    type = 'item',
        
                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'weapon_specialcarbine_mk2', 5, true)
                    end
                },
        
                {
        
                    item = 'makapoints',
                    name = 'Makapoints',
                    type = 'others',
        
                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveMakapoints(user_id, 150)
                    end
                },
        
                {
        
                    item = 'money',
                    name = 'Dinheiro',
                    type = 'item',
        
                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'money', 500000, true)
                    end
                },
        
                {
        
                    item = 'rs520',
                    name = 'OBEY RS5',
                    type = 'car',
        
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'rs520', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },
        
                {
        
                    item = 'makapoints',
                    name = 'Makapoints',
                    type = 'others',
        
                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveMakapoints(user_id, 500)
                    end
                },
        
                {
                    item = 'COMPONENT_DAGGER_HERO',
                    name = 'ADAGA HERO',
                    type = 'others',
        
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        exports["nova_skins"]:createSkin(user_id,"PISTOL","WEAPON_DAGGER","COMPONENT_DAGGER_HERO")
                    end
                },
        
                {
        
                    item = 'fnflan',
                    name = 'Lancer Evo VIII',
                    type = 'car',
        
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'fnflan', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },
        
                {
                    item = 'tiger',
                    name = 'Moto TIGER',
                    type = 'car',
        
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'tiger', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },
        
                {
                    item = 'benson',
                    name = 'Benson',
                    type = 'car',
        
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'benson', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },
        
                {
                    item = 'crate_legendary',
                    name = 'CAIXA LEGENDARIA',
                    type = 'others',
        
                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        exports.nova_box:addBox(user_id, 'crate_legendary')
                    end
                },
            }
        },

        ['crate_cars'] = {
            name = 'Caixa Carros',
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/crate_cars.png',
            price = 500,
        
            key = 'key_cars',
            rarity = 'legendary',
        
            items = {
                {
                    item = 'FOXEVO',
                    name = 'Huracan Evo',
                    type = 'car',
                    rarity = 'commom',
                    amount = 1,
                    func = function(source, user_id)
                        exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos(user_id, veiculo, ipva) VALUES(?, ?, ?)', { user_id, 'FOXEVO', os.time() })
                    end
                },
                {
                    item = 'macanturbo',
                    name = 'PFISTER Macan',
                    type = 'car',
                    rarity = 'commom',
                    amount = 1,
                    func = function(source, user_id)
                        exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos(user_id, veiculo, ipva) VALUES(?, ?, ?)', { user_id, 'macanturbo', os.time() })
                    end
                },
                {
                    item = '23S63L',
                    name = 'S63 Luxury',
                    type = 'car',
                    rarity = 'commom',
                    amount = 1,
                    func = function(source, user_id)
                        exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos(user_id, veiculo, ipva) VALUES(?, ?, ?)', { user_id, '23S63L', os.time() })
                    end
                },
                {
                    item = 'wri8e',
                    name = 'UBERMACHT i8',
                    type = 'car',
                    rarity = 'commom',
                    amount = 1,
                    func = function(source, user_id)
                        exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos(user_id, veiculo, ipva) VALUES(?, ?, ?)', { user_id, 'wri8e', os.time() })
                    end
                },
                {
                    item = 's15lbwk',
                    name = 'Silvia s15 Liberty Walk',
                    type = 'car',
                    rarity = 'epic',
                    amount = 1,
                    func = function(source, user_id)
                        exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos(user_id, veiculo, ipva) VALUES(?, ?, ?)', { user_id, 's15lbwk', os.time() })
                    end
                },
                {
                    item = '918S',
                    name = 'PFISTER 918 Spyder',
                    type = 'car',
                    rarity = 'epic',
                    amount = 1,
                    func = function(source, user_id)
                        exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos(user_id, veiculo, ipva) VALUES(?, ?, ?)', { user_id, '918S', os.time() })
                    end
                },
                {
                    item = 'er34n',
                    name = 'ANNIS Skyline R34 ‘GT-R’ Sedan',
                    type = 'car',
                    rarity = 'epic',
                    amount = 1,
                    func = function(source, user_id)
                        exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos(user_id, veiculo, ipva) VALUES(?, ?, ?)', { user_id, 'er34n', os.time() })
                    end
                },
                {
                    item = 'gtb22',
                    name = 'GROTTI GTB 22',
                    type = 'car',
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source, user_id)
                        exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos(user_id, veiculo, ipva) VALUES(?, ?, ?)', { user_id, 'gtb22', os.time() })
                    end
                },
                {
                    item = 'fxxkevo',
                    name = 'GROTTI FXX-K',
                    type = 'car',
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source, user_id)
                        exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos(user_id, veiculo, ipva) VALUES(?, ?, ?)', { user_id, 'fxxkevo', os.time() })
                    end
                },
                {
                    item = 'amrevu23mg',
                    name = 'PEGASSI Revuelto',
                    type = 'car',
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source, user_id)
                        exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos(user_id, veiculo, ipva) VALUES(?, ?, ?)', { user_id, 'amrevu23mg', os.time() })
                    end
                },
                {
                    item = 'aventsvjr',
                    name = 'PEGASSI Aventador SVJ',
                    type = 'car',
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source, user_id)
                        exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos(user_id, veiculo, ipva) VALUES(?, ?, ?)', { user_id, 'aventsvjr', os.time() })
                    end
                },
                {
                    item = 'HURACANGT3EVO',
                    name = 'PEGASSI Huracán GT3 EVO',
                    type = 'car',
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source, user_id)
                        exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos(user_id, veiculo, ipva) VALUES(?, ?, ?)', { user_id, 'HURACANGT3EVO', os.time() })
                    end
                },
                {
                    item = 'silvia',
                    name = 'Silvia',
                    type = 'car',
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source, user_id)
                        exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos(user_id, veiculo, ipva) VALUES(?, ?, ?)', { user_id, 'silvia', os.time() })
                    end
                },
                {
                    item = 'm8gte',
                    name = 'UBERMACHT M8 GTE',
                    type = 'car',
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source, user_id)
                        exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos(user_id, veiculo, ipva) VALUES(?, ?, ?)', { user_id, 'm8gte', os.time() })
                    end
                },
                {
                    item = 'polestar1',
                    name = 'Polestar',
                    type = 'car',
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source, user_id)
                        exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos(user_id, veiculo, ipva) VALUES(?, ?, ?)', { user_id, 'polestar1', os.time() })
                    end
                }
            },
        },        
        
        ['crate_olimpica'] = {
            name = 'CAIXA OLIMPICA',
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/crate_olimpica.png',
            price = 250,

            key = 'key_olimpica',
            rarity = 'epic',

            items = {
                {
                    item = 'COMPONENT_SIG_PUNK',
                    name = 'G36 Punk',
                    type = 'others',


                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        exports["nova_skins"]:createSkin(user_id,"RIFLES","WEAPON_SPECIALCARBINE_MK2","COMPONENT_SIG_PUNK")
                    end
                },

                {
                    item = 'corda',
                    name = 'Item Corda',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'corda', 10, true)
                    end
                },

                {

                    item = 'metanfetamina',
                    name = 'Metanfetamina',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'metanfetamina', 50, true)
                    end
                },

                {

                    item = 'WEAPON_PISTOL_MK2',
                    name = 'Five Seven',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'weapon_pistol_mk2', 5, true)
                    end
                },

                {

                    item = 'AMMO_PISTOL_MK2',
                    name = 'Munição de Five Seven',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'ammo_pistol_mk2', 250, true)
                    end
                },

                {

                    item = 'WEAPON_SPECIALCARBINE_MK2',
                    name = 'G3',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'weapon_specialcarbine_mk2', 3, true)
                    end
                },

                {

                    item = 'AMMO_SPECIALCARBINE_MK2',
                    name = 'Munição de G3',
                    type = 'item',

                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'ammo_specialcarbine_mk2', 250, true)
                    end
                },

                {

                    item = 'money',
                    name = 'Dinheiro',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'money', 250000	, true)
                    end
                },

                {

                    item = 'cocaina',
                    name = 'Cocaina',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'cocaina', 100, true)
                    end
                },

                {

                    item = 'WEAPON_ASSAULTRIFLE',
                    name = 'AK47',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'weapon_assaultrifle', 5, true)
                    end
                },

                {

                    item = '2xlr35sakura',
                    name = 'GTR-35 Hello Kity',
                    type = 'car',

                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = '2xlr35sakura', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {

                    item = 'nh2r',
                    name = 'NAGASAKI Ninja H2/H2R',
                    type = 'car',

                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'nh2r', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {
                    item = 'mule',
                    name = 'Caminhao Mule',
                    type = 'car',

                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'mule', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {
                    item = 'burrito2',
                    name = 'Burrito 2',
                    type = 'car',

                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'burrito2', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {
                    item = 'makapoints',
                    name = 'Makapoints',
                    type = 'others',

                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveMakapoints(user_id, 500)
                    end
                },
            },
            
        },

        ['crate_halo'] = {
            name = 'Caixa Halloween',
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/crate_halo.png',
            price = 350,
        
            key = 'key_halo',
            rarity = 'legendary',
        
            items = {
                {
                    item = 'COMPONENT_AK74_HERO',
                    name = 'SKIN AK MK2 HERO',
                    type = 'others',
        
                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        exports["nova_skins"]:createSkin(user_id,"RIFLE","WEAPON_ASSAULTRIFLE_MK2","COMPONENT_AK74_HERO")
                    end
                },
        
                {
                    item = 'wrthundersasuke',
                    name = 'R35 SASUKE BLINDADO',
                    type = 'car',
        
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'wrthundersasuke', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },
        
                {
        
                    item = 'cocaina',
                    name = 'Cocaina',
                    type = 'item',
        
                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'cocaina', 100, true)
                    end
                },
        
                {
        
                    item = 'WEAPON_PISTOL_MK2',
                    name = 'Five Seven',
                    type = 'item',
        
                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'weapon_pistol_mk2', 1, true)
                    end
                },
        
                {
        
                    item = 'AMMO_PISTOL_MK2',
                    name = 'Munição de Five Seven',
                    type = 'item',
        
                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'ammo_pistol_mk2', 500, true)
                    end
                },
        
                {
        
                    item = 'WEAPON_SPECIALCARBINE_MK2',
                    name = 'G3',
                    type = 'item',
        
                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'weapon_specialcarbine_mk2', 1, true)
                    end
                },
        
                {
        
                    item = 'makapoints',
                    name = 'Makapoints',
                    type = 'others',
        
                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveMakapoints(user_id, 350)
                    end
                },
        
                {
        
                    item = 'money',
                    name = 'Dinheiro',
                    type = 'item',
        
                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'money', 500000, true)
                    end
                },
        
                {
        
                    item = '350zdk',
                    name = '350Z DK',
                    type = 'car',
        
                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = '350zdk', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },
        
                {
        
                    item = 'makapoints',
                    name = 'Makapoints',
                    type = 'others',
        
                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveMakapoints(user_id, 500)
                    end
                },
        
                {
                    item = 'COMPONENT_DAGGER_HERO',
                    name = 'ADAGA HERO',
                    type = 'others',
        
                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        exports["nova_skins"]:createSkin(user_id,"PISTOL","WEAPON_DAGGER","COMPONENT_DAGGER_HERO")
                    end
                },
        
                {
        
                    item = 'pistaspider19',
                    name = 'PISTA SPIDER',
                    type = 'car',
        
                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'pistaspider19', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },
        
                {
                    item = 'tiger',
                    name = 'Moto TIGER',
                    type = 'car',
        
                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'tiger', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },
        
                {
                    item = 'benson',
                    name = 'Benson',
                    type = 'car',
        
                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'benson', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },
        
                {
                    item = 'crate_hero',
                    name = 'CAIXA HERO',
                    type = 'others',
        
                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        exports.nova_box:addBox(user_id, 'crate_hero')
                    end
                },
            }
        },

        ['crate_blindada'] = {
            name = 'CAIXA BLINDADA',
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/crate_blindada.png',
            price = 500,

            key = 'key_blindada',
            rarity = 'legendary',

            items = {
                {
                    item = 'COMPONENT_AK103_DRAGON',
                    name = 'Skin AK47 Dragon',
                    type = 'others',


                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        exports["nova_skins"]:createSkin(user_id,"RIFLES","WEAPON_ASSAULTRIFLE_MK2","COMPONENT_AK103_DRAGON")
                    end
                },

                {
                    item = 'algemas',
                    name = 'Algema',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'algemas', 5, true)
                    end
                },

                {

                    item = 'cocaina',
                    name = 'Cocaina',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'cocaina', 50, true)
                    end
                },

                {

                    item = 'weapon_snspistol_mk2',
                    name = 'Fajuta',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'weapon_snspistol_mk2', 2, true)
                    end
                },

                {

                    item = 'ammo_snspistol_mk2',
                    name = 'Munição de Fajuta',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'ammo_snspistol_mk2', 150, true)
                    end
                },

                {

                    item = 'WEAPON_SPECIALCARBINE_MK2',
                    name = 'G3',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'weapon_specialcarbine_mk2', 3, true)
                    end
                },

                {

                    item = 'AMMO_SPECIALCARBINE_MK2',
                    name = 'Munição de G3',
                    type = 'item',

                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'ammo_specialcarbine_mk2', 250, true)
                    end
                },

                {

                    item = 'dirty_money',
                    name = 'Dinheiro Sujo',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'dirty_money', 250000	, true)
                    end
                },

                {

                    item = 'metanfetamina',
                    name = 'Metanfetamina',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'metanfetamina', 100, true)
                    end
                },

                {

                    item = 'WEAPON_PISTOL_MK2',
                    name = 'Pistola Five seven',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'WEAPON_PISTOL_MK2', 5, true)
                    end
                },

                {

                    item = 'AMMO_PISTOL_MK2',
                    name = 'Muniçao Five Seven',
                    type = 'item',

                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'AMMO_PISTOL_MK2', 250, true)
                    end
                },

                {

                    item = 'wrarmoredconada',
                    name = 'Helicóptero Conada',
                    type = 'car',

                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'wrarmoredconada', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {
                    item = 'wrarmoredx6',
                    name = 'X6 Blindado',
                    type = 'car',

                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'wrarmoredx6', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {
                    item = 'WEAPON_ASSAULTRIFLE_MK2',
                    name = 'AK47 MK2',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'WEAPON_ASSAULTRIFLE_MK2', 2, true)
                    end
                },

                {
                    item = 'makapoints',
                    name = 'Makapoints',
                    type = 'others',

                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveMakapoints(user_id, 500)
                    end
                },
            },
            
        },

        ['crate_natal'] = {
            name = 'CAIXA NATAL',
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/crate_natal.png',
            price = 300,

            key = 'key_natal',
            rarity = 'legendary',

            items = {
                {
                    item = 'pistaspider19',
                    name = 'PISTA SPIDER',
                    type = 'car',
        
                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'pistaspider19', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {
                    item = 'algemas',
                    name = 'Algema',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'algemas', 5, true)
                    end
                },

                {

                    item = 'cocaina',
                    name = 'Cocaina',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'cocaina', 50, true)
                    end
                },

                {

                    item = 'weapon_snspistol_mk2',
                    name = 'Fajuta',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'weapon_snspistol_mk2', 2, true)
                    end
                },

                {

                    item = 'ammo_snspistol_mk2',
                    name = 'Munição de Fajuta',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'ammo_snspistol_mk2', 150, true)
                    end
                },

                {

                    item = 'WEAPON_SPECIALCARBINE_MK2',
                    name = 'G3',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'weapon_specialcarbine_mk2', 3, true)
                    end
                },

                {

                    item = 'burritonatal',
                    name = 'Burrito Natal',
                    type = 'car',

                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'burritonatal', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {

                    item = 'dirty_money',
                    name = 'Dinheiro Sujo',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'dirty_money', 250000	, true)
                    end
                },

                {

                    item = 'metanfetamina',
                    name = 'Metanfetamina',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'metanfetamina', 100, true)
                    end
                },

                {

                    item = 'WEAPON_PISTOL_MK2',
                    name = 'Pistola Five seven',
                    type = 'item',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'WEAPON_PISTOL_MK2', 5, true)
                    end
                },

                {

                    item = 'AMMO_PISTOL_MK2',
                    name = 'Muniçao Five Seven',
                    type = 'item',

                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'AMMO_PISTOL_MK2', 250, true)
                    end
                },

                {

                    item = 'wrr1natal',
                    name = 'R1 Natalina',
                    type = 'car',

                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'wrr1natal', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {
                    item = 'wrgtrnatal',
                    name = 'GTR Natalino',
                    type = 'car',

                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'wrgtrnatal', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },

                {
                    item = 'makapoints',
                    name = 'Makapoints',
                    type = 'others',

                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveMakapoints(user_id, 200)
                    end
                },

                {
                    item = 'makapoints',
                    name = 'Makapoints',
                    type = 'others',

                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveMakapoints(user_id, 500)
                    end
                },
            },
            
        },

        ['crate_verao'] = {
            name = 'Caixa Verão',
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/crate_verao.png',
            price = 350,
        
            key = 'key_verao',
            rarity = 'legendary',
        
            items = {
                {
                    item = 'COMPONENT_FIVE_HALLOWEEN',
                    name = 'SKIN FIVE HALLOWEEN',
                    type = 'others',
        
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        exports["nova_skins"]:createSkin(user_id,"PISTOLAS","WEAPON_PISTOL_MK2","COMPONENT_FIVE_HALLOWEEN")
                    end
                },
        
                {
                    item = 'evoquecabrio',
                    name = 'CARRO MC KEVIN',
                    type = 'car',
        
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'evoquecabrio', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },
        
                {
        
                    item = 'cocaina',
                    name = 'Cocaina',
                    type = 'item',
        
                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'cocaina', 100, true)
                    end
                },
        
                {
        
                    item = 'masterpick',
                    name = 'Masterpick',
                    type = 'item',
        
                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'masterpick', 1, true)
                    end
                },
        
                {
        
                    item = 'makapoints',
                    name = 'Makapoints',
                    type = 'others',
        
                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveMakapoints(user_id, 150)
                    end
                },
        
                {
        
                    item = 'WEAPON_SPECIALCARBINE_MK2',
                    name = 'G3',
                    type = 'item',
        
                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'weapon_specialcarbine_mk2', 5, true)
                    end
                },
        
                {
        
                    item = 'makapoints',
                    name = 'Makapoints',
                    type = 'others',
        
                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveMakapoints(user_id, 150)
                    end
                },
        
                {
        
                    item = 'money',
                    name = 'Dinheiro',
                    type = 'item',
        
                    rarity = 'commom',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveInventoryItem(user_id, 'money', 500000, true)
                    end
                },
        
                {
        
                    item = 'wrcorollaciv',
                    name = 'Corolla',
                    type = 'car',
        
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'wrcorollaciv', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },
        
                {
        
                    item = 'makapoints',
                    name = 'Makapoints',
                    type = 'others',
        
                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.giveMakapoints(user_id, 500)
                    end
                },
        
                {
                    item = 'COMPONENT_DAGGER_HERO',
                    name = 'ADAGA HERO',
                    type = 'others',
        
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        exports["nova_skins"]:createSkin(user_id,"PISTOL","WEAPON_DAGGER","COMPONENT_DAGGER_HERO")
                    end
                },
        
                {
        
                    item = 'nivou',
                    name = 'Nivus',
                    type = 'car',
        
                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'nivou', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },
        
                {
                    item = 'impala67',
                    name = 'Impala supernatural',
                    type = 'car',
        
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'impala67', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },
        
                {
                    item = 'benson',
                    name = 'Benson',
                    type = 'car',
        
                    rarity = 'legendary',
                    amount = 1,
                    func = function(source,user_id)
                        vRP.execute("vRP/inserir_veh",{ veiculo = 'benson', user_id = user_id, ipva = os.time(), expired = "{}" })
                    end
                },
        
                {
                    item = 'crate_legendary',
                    name = 'CAIXA LEGENDARIA',
                    type = 'others',
        
                    rarity = 'epic',
                    amount = 1,
                    func = function(source,user_id)
                        exports.nova_box:addBox(user_id, 'crate_legendary')
                    end
                },
            }
        },
    },

    Keys = {
        ['key_normal'] = {
            name = 'Chave Caixa Normal', 
            price = 100, 
            category = 'comum', 
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/key_normal.png',
            type = 'key', 

            open_crates = { 
                'crate_normal'
            },
        },

        ['key_epic'] = { 
            name = 'Chave Caixa Epica', 
            price = 150, 
            category = 'comum', 
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/key_epic.png',
            type = 'key', 
            
            open_crates = {
                'crate_epic' 
            },
        },

        ['key_legendary'] = { 
            name = 'Chave Caixa Lendaria', 
            price = 250, 
            category = 'comum', 
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/key_legendary.png',
            type = 'key', 
            
            open_crates = { 
                'crate_legendary',
            },
        },

        ['key_hero'] = { 
            name = 'Chave Caixa Hero', 
            price = 300, 
            category = 'comum', 
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/key_hero.png',
            type = 'key', 
         
            open_crates = { 
                'crate_hero',
            },
        },

        ['key_cars'] = { 
            name = 'Chave Caixa Carros', 
            price = 300, 
            category = 'comum', 
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/key_cars.png',
            type = 'key', 
         
            open_crates = { 
                'crate_cars',
            },
        },

        ['key_olimpica'] = { 
            name = 'Chave Caixa Olimpica', 
            price = 150, 
            category = 'comum', 
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/key_olimpica.png',
            type = 'key', 
            
            open_crates = {
                'crate_olimpica' 
            },
        },

        ['key_halo'] = { 
            name = 'Chave Caixa Halloween', 
            price = 200, 
            category = 'comum', 
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/key_halo.png',
            type = 'key', 
            
            open_crates = {
                'crate_halo' 
            },
        },

        ['key_blindada'] = { 
            name = 'Chave Caixa Blindada', 
            price = 300, 
            category = 'comum', 
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/key_blindada.png',
            type = 'key',
            open_crates = {
                'crate_blindada' 
            },
        },

        ['key_natal'] = { 
            name = 'Chave Caixa Natal', 
            price = 200, 
            category = 'legendary', 
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/key_natal.png',
            type = 'key', 
            
            open_crates = {
                'crate_natal' 
            },
        },

        ['key_verao'] = { 
            name = 'Chave Caixa Verão', 
            price = 200, 
            category = 'legendary', 
            image_url = 'http://177.54.148.31:4020/lotus/lotus_box/key_verao.png',
            type = 'key', 
            
            open_crates = {
                'crate_verao' 
            },
        },
    },

    AutoRandomizeRewards = {
        { -- 30min
            time = 30,
            items = {
                { type = 'item', spawn = 'maconha', amount = 34 }, -- types = item,car,makapoints
                { type = 'car', spawn = 'brioso', amount = 1 }, -- types = item,car,makapoints
                { type = 'makapoints', spawn = 'makapoints', amount = 5 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'money', amount = 18756 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'balinha', amount = 16 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'corda', amount = 2 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'radio', amount = 4 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'bandagem', amount = 3 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'energetico', amount = 3 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'lsd', amount = 12 }, -- types = item,car,makapoints
            }
        },

        { -- 1h
            time = 60,
            items =  {
                { type = 'item', spawn = 'cocaina', amount = 52 }, -- types = item,car,makapoints
                { type = 'car', spawn = 'sanchez', amount = 1 }, -- types = item,car,makapoints
                { type = 'makapoints', spawn = 'makapoints', amount = 25 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'dirty_money', amount = 23546 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'heroina', amount = 38 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'algemas', amount = 3 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'bandagem', amount = 4 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'energetico', amount = 5 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'attachs', amount = 2 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'corda', amount = 1 }, -- types = item,car,makapoints
            }
        },

        { -- 2h
            time = 120,
            items =  {
                { type = 'item', spawn = 'metanfetamina', amount = 105 }, -- types = item,car,makapoints
                { type = 'car', spawn = 'sandking', amount = 1 }, -- types = item,car,makapoints
                { type = 'makapoints', spawn = 'makapoints', amount = 50 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'money', amount = 52548 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'balinha', amount = 59 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'corda', amount = 5 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'celular', amount = 3 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'bandagem', amount = 9 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'energetico', amount = 10 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'attachs', amount = 5 }, -- types = item,car,makapoints
            }
        },

        { -- 3h
            time = 180,
            items =  {
                { type = 'item', spawn = 'balinha', amount = 126 }, -- types = item,car,makapoints
                { type = 'car', spawn = 'vacca', amount = 1 }, -- types = item,car,makapoints
                { type = 'makapoints', spawn = 'makapoints', amount = 96 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'money', amount = 86548 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'celular', amount = 2 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'algemas', amount = 5 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'AMMO_PISTOL_MK2', amount = 35 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'bandagem', amount = 5 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'weapon_pistol_mk2', amount = 2 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'cogumelo', amount = 10 }, -- types = item,car,makapoints
            }
        },

        { -- 4h
            time = 240,
            items =  {
                { type = 'item', spawn = 'cocaina', amount = 134 }, -- types = item,car,makapoints
                { type = 'car', spawn = 'blazer4', amount = 1 }, -- types = item,car,makapoints
                { type = 'makapoints', spawn = 'makapoints', amount = 102 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'dirty_money', amount = 928393 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'corda', amount = 4 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'algemas', amount = 5 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'AMMO_PISTOL_MK2', amount = 24 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'bandagem', amount = 3 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'weapon_assaultrifle', amount = 1 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'lsd', amount = 3 }, -- types = item,car,makapoints
            }
        },

        { -- 5h
            time = 300,
            items =  {
                { type = 'item', spawn = 'haxixe', amount = 102 }, -- types = item,car,makapoints
                { type = 'car', spawn = 'sultan', amount = 1 }, -- types = item,car,makapoints
                { type = 'makapoints', spawn = 'makapoints', amount = 135 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'money', amount = 100890 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'corda', amount = 1 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'algemas', amount = 5 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'ammo_specialcarbine_mk2', amount = 150 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'bandagem', amount = 2 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'weapon_specialcarbine_mk2', amount = 2 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'cogumelo', amount = 5 }, -- types = item,car,makapoints
            }
        },

        { -- 6h
            time = 360,
            items =  {
                { type = 'item', spawn = 'lsd', amount = 82 }, -- types = item,car,makapoints
                { type = 'car', spawn = 'bati2', amount = 1 }, -- types = item,car,makapoints
                { type = 'makapoints', spawn = 'makapoints', amount = 126 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'dirty_money', amount = 928928 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'corda', amount = 1 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'weapon_pistol_mk2', amount = 3 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'AMMO_PISTOL_MK2', amount = 76 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'energetico', amount = 4 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'cogumelo', amount = 1 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'AMMO_ASSAULTRIFLE', amount = 15 }, -- types = item,car,makapoints
            }
        },

        { -- 7h
            time = 420,
            items =  {
                { type = 'item', spawn = 'lancaperfume', amount = 150 }, -- types = item,car,makapoints
                { type = 'car', spawn = 'bodhi2', amount = 1 }, -- types = item,car,makapoints
                { type = 'makapoints', spawn = 'makapoints', amount = 48 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'money', amount = 125687 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'corda', amount = 3 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'weapon_snspistol_mk2', amount = 5 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'AMMO_SNSPISTOL_MK2', amount = 105 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'algemas', amount = 4 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'cocaina', amount = 108 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'AMMO_SPECIALCARBINE_MK2', amount = 53 }, -- types = item,car,makapoints
            }
        },

        { -- 8h
            time = 480,
            items =  {
                { type = 'item', spawn = 'lsd', amount = 120 }, -- types = item,car,makapoints
                { type = 'car', spawn = 'shotaro', amount = 1 }, -- types = item,car,makapoints
                { type = 'makapoints', spawn = 'makapoints', amount = 210 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'money', amount = 1826381 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'weapon_specialcarbine_mk2', amount = 2 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'weapon_assaultrifle_mk2', amount = 4 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'ammo_assaultrifle_mk2', amount = 172 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'algemas', amount = 2 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'cocaina', amount = 72 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'ammo_specialcarbine_mk2', amount = 100 }, -- types = item,car,makapoints
            }
        },

        { -- 12h
            time = 720,
            items =  {
                { type = 'item', spawn = 'lsd', amount = 205 }, -- types = item,car,makapoints
                { type = 'car', spawn = 'burrito', amount = 1 }, -- types = item,car,makapoints
                { type = 'makapoints', spawn = 'makapoints', amount = 280 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'dirty_money', amount = 324869 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'weapon_specialcarbine_mk2', amount = 5 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'weapon_assaultrifle_mk2', amount = 6 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'ammo_specialcarbine_mk2', amount = 250 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'cordas', amount = 5 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'cocaina', amount = 50 }, -- types = item,car,makapoints
                { type = 'item', spawn = 'ammo_assaultrifle_mk2', amount = 100 }, -- types = item,car,makapoints
            }
        },
    }
}