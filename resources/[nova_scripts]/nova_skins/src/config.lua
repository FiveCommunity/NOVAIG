---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OBJ
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Shared = {}
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TIPOS DE ARMAS LALALA DEDEDE
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Shared.RealTime = true 
Shared.Categorys = { 
    ["PISTOLAS"] = true, 
    ["SHOTGUNS"] = true, 
    ["RIFLES"] = true, 
    ["SMGS"] = true, 
}
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONTEÚDO DA LOJA 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local storeImages = "nui://nova_skins/ui/background/store/"
local weaponImages = "nui://nova_skins/ui/background/"
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONTEÚDO DA LOJA 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
bannerWeapon = {
    points = 10000,
    data = {
        {
            type = "RIFLE",
            component = "COMPONENT_SIG_HALLOWEEN",
            weapon = "WEAPON_SPECIALCARBINE_MK2",
            name = "G36 Halloween"
        },
        {
            type = "SMGS",
            component = "COMPONENT_SMGMK2_HALLOWEEN",
            weapon = "WEAPON_SMG_MK2",
            name = "SMG MK2 Halloween"
        },

        {
            type = "PISTOLAS",
            component = "COMPONENT_FIVE_HALLOWEEN",
            weapon = "WEAPON_PISTOL_MK2",
            name = "FN Five Seven Halloween"
        },
        {
            type = "BRANCA",
            component = "COMPONENT_HATCHET_HALLOWEEN",
            weapon = "WEAPON_HATCHET",
            name = "Machado de Halloween"
        },
    },    
    
    expires = "06/08/2024",
    name = "PACK HALLOWEEN",
    rarity = "epic",
    banner = storeImages.."banner.png",
}

Shared.Store = {
	{
		points = 800,
		data = {
			type = "PISTOLAS",
			component = "COMPONENT_GLOCK_HERO",
			weapon = "WEAPON_COMBATPISTOL"
		},
		name = "Glock Hero",
		rarity = "epic",
        image = storeImages.."glockero.png",
	},
    {
		points = 1000,
		data = {
			type = "RIFLE",
			component = "COMPONENT_SIG_SAKURA",
			weapon = "WEAPON_CARBINERIFLE_MK2"
		},
		name = "G36 Sakura",
		rarity = "epic",
        image = storeImages.."G36 SAKURA.png",
	},
    {
		points = 500,
		data = {
			type = "BRANCAS",
			component = "COMPONENT_DAGGER_HERO",
			weapon = "WEAPON_DAGGER"
		},
		name = "Adaga Hero",
		rarity = "common",
        image = storeImages.."adagahero.png",
	},
}
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Shared.Weapons = { 
    ["RIFLE"] = { 
        ["WEAPON_ASSAULTRIFLE_MK2"] = { 
            Name = "AK MK2",
            Image = weaponImages.."assault-rifle-mk2.png",
            Weapon = "WEAPON_ASSAULTRIFLE_MK2",
            Components = {
                { component = "COMPONENT_AK74_GOLDEN", rarity = "legendary", name = "AK-74 Golden", image = weaponImages.."ak74gold.png", textureImage = weaponImages.."golden.png",  },
                { component = "COMPONENT_AK74_HERO", rarity = "legendary", name = "AK-74 Hero", image = weaponImages.."akhero.png", textureImage = weaponImages.."hero_texture.png",  },
            }
        },
                
        ["WEAPON_SPECIALCARBINE_MK2"] = { 
            Name = "G36 MK2",
            Image = weaponImages.."special-carbine-mk2.png",
            Weapon = "WEAPON_SPECIALCARBINE_MK2",
            Components = {
                { component = "COMPONENT_SIG_SAKURA", rarity = "legendary", name = "G36 Sakura", image = weaponImages.."g36sakura.png", textureImage = weaponImages.."texturasakura.png" },
                { component = "COMPONENT_SIG_HALLOWEEN", rarity = "legendary", name = "G36 Halloween", image = weaponImages.."g36halloween.png", textureImage = weaponImages.."texturahalloween.png" },
                { component = "COMPONENT_SIG_ICE", rarity = "legendary", name = "G36C Mecha Samurai", image = weaponImages.."mechaw.png", textureImage = weaponImages.."mecha.png" },
            }
        },
    },

    ["SMGS"] = {
        ["WEAPON_SMG_MK2"] = { 
            Name = "SMG MK2",
            Image = weaponImages.."smg-mk2.png",
            Weapon = "WEAPON_SMG_MK2",
            Components = {
                { component = "COMPONENT_SMGMK2_SAKURA", rarity = "epic", name = "SMG MK2 Sakura", image = weaponImages.."sakura-smg_mk2.png",textureImage = weaponImages.."texturasakura.png" },            
                { component = "COMPONENT_SMGMK2_HALLOWEEN", rarity = "epic", name = "SMG MK2 Halloween", image = weaponImages.."halloween-smg_mk2.png",textureImage = weaponImages.."texturahalloween.png" },   
            }
        },
        ["WEAPON_COMBATPDW"] = { 
            Name = "Combat PDW",
            Image = weaponImages.."combat-pdw.png",
            Weapon = "WEAPON_COMBATPDW",
            Components = {
                { component = "COMPONENT_COMBATPDW_HERO", rarity = "epic", name = "PDW Hero", textureImage = weaponImages.."hero_texture.png", image=weaponImages.."pdw_hero.png" },            
            }  
        },
    },

    ["BRANCAS"] = {
        ["WEAPON_KNIFE"] = { 
            Name = "Faca",
            Image = weaponImages.."knife.png",
            Weapon = "WEAPON_KNIFE",
            Components = {
                { component = "COMPONENT_KNIFE_SAKURA", rarity = "epic", name = "Knife Sakura", image = weaponImages.."sakuraknife.png", textureImage = weaponImages.."texturasakura.png" },
            }  
        },
        ["WEAPON_HATCHET"] = { 
            Name = "Machado",
            Image = weaponImages.."hatchet.png",
            Weapon = "WEAPON_HATCHET",
            Components = {
                { component = "COMPONENT_HATCHET_ASSIS", rarity = "epic", name = "Machado de Assis", image = weaponImages.."machadodeassisw.png", textureImage = weaponImages.."machadodeassis.png" },            
                { component = "COMPONENT_HATCHET_HALLOWEEN", rarity = "epic", name = "Machado de Halloween", image = weaponImages.."machadohalloween.png", textureImage = weaponImages.."machadohalloween.png" },            
            }  
        },
        ["WEAPON_DAGGER"] = { 
            Name = "Dagger",
            Image = weaponImages.."antique-cavalry-dagger.png",
            Weapon = "WEAPON_DAGGER",
            Components = {
                { component = "COMPONENT_DAGGER_HERO", rarity = "epic", name = "Adaga Hero", textureImage = weaponImages.."hero_texture.png", image = weaponImages.."adagahero.png"},            
            }  
        },
    },
    
    ["PISTOLAS"] = { 
        ["WEAPON_COMBATPISTOL"] = { 
            Name = "Glock",
            Image = weaponImages.."combat-pistol.png",
            Weapon = "WEAPON_COMBATPISTOL",
            Components = {
                { component = "COMPONENT_GLOCK_SAKURA", rarity = "epic", name = "Glock Sakura", image = weaponImages.."/glock/glocksakura.png", textureImage = weaponImages.."texturasakura.png" },
                { component = "COMPONENT_GLOCK_HERO", rarity = "epic", name = "Glock Hero", image = weaponImages.."/glockero.png", textureImage = weaponImages.."hero_texture.png" },
            }  
        },
        
        ["WEAPON_PISTOL_MK2"] = { 
            Name = "FN Five Seven",
            Image = weaponImages.."pistol-mk2.png",
            Weapon = "WEAPON_PISTOL_MK2",
            Components = {
                { component = "COMPONENT_FIVE_SAKURA", rarity = "epic", name = "FN Five Seven Sakura", image = weaponImages.."fivesakura.png", textureImage = weaponImages.."texturasakura.png" },
                { component = "COMPONENT_FIVE_HALLOWEEN", rarity = "epic", name = "FN Five Seven Halloween", image = weaponImages.."fivesevenhalloween.png", textureImage = weaponImages.."texturahalloween.png" },
                { component = "COMPONENT_FIVESEVEN_NARUTO", rarity = "epic", name = "FN Five Seven Shippuden", image = weaponImages.."fiveshippuden.png", textureImage = weaponImages.."shippuden.png" },
            }  
        },
    }
}
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VRP
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SERVER = IsDuplicityVersion()
CLIENT = not SERVER
Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
if SERVER then 
    cO = {}
    Tunnel.bindInterface(GetCurrentResourceName(),cO)
    clientAPI = Tunnel.getInterface(GetCurrentResourceName())
    oxmysql = exports.oxmysql
else
    cO = {}
    Tunnel.bindInterface(GetCurrentResourceName(),cO)
    serverAPI = Tunnel.getInterface(GetCurrentResourceName())


    function getWeaponFOV(hash)
        if GetWeapontypeGroup(hash) == -957766203 then
            return 30.0
        end

        if GetWeapontypeGroup(hash) == 416676503 then
            return 20.0
        end

        if GetWeapontypeGroup(hash) == 970310034 then
            return 27.0
        end

        if GetWeapontypeGroup(hash) == 1159398588 then
            return 30.0
        end

        if GetWeapontypeGroup(hash) == -1212426201 then
            return 40.0
        end
        
        if GetWeapontypeGroup(hash) == -1569042529 then
            return 40.0
        end

        return 35.0
    end
end