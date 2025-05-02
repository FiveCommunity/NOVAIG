Config = {}

Config.Roubos = {
    cmdPermission = 'developer.permissao',
    policePermission = 'perm.disparo',
    openScoreboardKey = 'INSERT',
    NeedAdminAuthorization = false,
    disableCooldown = false, -- DESABILITAR O COOLDOWN DE ROUBOS (RECOMENDADO APENAS PARA TESTES)
    blipCooldown = 100 -- TEMPO EM SEGUNDOS QUE APARECERÁ O BLIP COM A ROTA PARA A POLÍCIA
}

Config.Hierarquia = {
    -- Capitães
"CapitaoFederal","CapitaoPM","CapitaoEXERCITO","CapitaoCore","CapitaoTatica","CapitaoCHOQUE","CapitaoRota","CapitaoBAEP",

-- Comandantes
"ComandoCot","ComandanteGeralFederal","ComandoGate","ComandoCivil","ComandoGeralCivil","ComandoNOE","ComandoCore","ComandoTatica","ComandanteGeralCHOQUE","ComandoGeralRota","ComandoGeralBAEP",

-- Subcomandantes
"SubComandanteGeral","SubComandanteCHOQUE","SubComandoGate","SubcomandoCivil","SubComandoGeralRota","SubComandoGeralBAEP","SubComandoGarra","SubComandoInvestigativa","SubTenenteCore","SubTenenteTatica","SubTenenteCHOQUE","SubTenenteRota","SubTenenteBAEP",

-- Coronéis
"CoronelPM","CoronelEXERCITO","CoronelPRF","CoronelCore","CoronelTatica","CoronelCHOQUE","CoronelRota","CoronelBAEP","ComandoCot","ComandoGeralCivil",

-- Tenente-Coronéis
"TenenteCoronelPM","TenenteCoronelEXERCITO","TenenteCoronelPRF","TenenteCoronelCore","TenenteCoronelTatica","TenenteCoronelCHOQUE","TenenteCoronelRota","TenenteCoronelBAEP",

-- Majores
"MajorPM","MajorEXERCITO","MajorCore","MajorTatica","MajorCHOQUE","MajorRota","MajorBAEP",

-- Delegados e Corregedores
"CorregedorFederal","CorregedorPRF","DelegadoAdjuntoFederal","DelegadoFederal","DelegadoGeralFederal","Delegado","DelegadoGeral","DelegadoPRF",

-- Inspetores e Agentes Especiais
"InspetorPRF","AgenteEspecialPRF",

-- Outros cargos de elite
"EliteCot","ComandoGarra","ComandoInvestigativa","SpecPM","APMBB",

}

Config.DeathEvent = {
    WeaponClassIcons = { -- ICONES DAS CLASSES DE ARMA
        suicide = 'https://cdn.discordapp.com/attachments/546438668831817769/913973356037038120/SUICIDE.png',
        pistol = 'https://cdn.discordapp.com/attachments/864220360416952341/911036858849435719/WEAPON_PISTOL_MK2.png',
        rifle = 'https://cdn.discordapp.com/attachments/864220360416952341/911036754134441984/WEAPON_ASSAULTRIFLE.png',
        smg = 'https://cdn.discordapp.com/attachments/864220360416952341/911037099275329576/WEAPON_MICROSMG.png',
        unarmed = 'https://cdn.discordapp.com/attachments/864220360416952341/911036987430015046/WEAPON_UNARMED.png',
        sniper = 'https://cdn.discordapp.com/attachments/864220360416952341/911036931649970196/WEAPON_HEAVYSNIPER.png',
        melee = 'https://cdn.discordapp.com/attachments/864220360416952341/911036959957352469/WEAPON_KNUCKLE.png',
        shotgun = 'https://cdn.discordapp.com/attachments/864220360416952341/911037866048626738/WEAPON_PUMPSHOTGUN.png',
        rpg = 'https://cdn.discordapp.com/attachments/864220360416952341/911038263303745586/WEAPON_RPG.png',
        grenade = 'https://cdn.discordapp.com/attachments/864220360416952341/911038505197637663/WEAPON_GRENADE.png',
        snowball = 'https://cdn.discordapp.com/attachments/864220360416952341/911038726036140073/WEAPON_SNOWBALL.png',
    },

    reasonsKill = { -- SERÁ A MENSAGEM ENVIADA NA LOG O VALOR1, E A ARMA UTILIZADA PARA MATAR NOTIFICADO NO KILLFEED O VALOR2 
    -- NÃO MEXER NAS KEYS, PODE MEXER APENAS NOS VALOR1 DE CADA LINHA: ([KEY] = {VALOR1,VALOR2}), 
    ["0"] = {reason = 'Suicídio',weapon = 'SUICIDE', class = 'suicide'},
    [`WEAPON_UNARMED`] = {reason = 'Espancado',weapon = 'WEAPON_UNARMED', class = 'unarmed'},
    [`WEAPON_RUN_OVER_BY_CAR`] = {reason = 'Atropelado',weapon = 'WEAPON_RUN_OVER_BY_CAR', class = 'pistol'},
    [`WEAPON_RAMMED_BY_CAR`] = {reason = 'Atropelado',weapon = 'WEAPON_RAMMED_BY_CAR', class = 'pistol'},
    [`VEHICLE_WEAPON_ROTORS`] = {reason = 'Atropelado',weapon = 'VEHICLE_WEAPON_ROTORS', class = 'pistol'},
    [`WEAPON_DAGGER`] = {reason = 'Punhal',weapon = 'WEAPON_DAGGER', class = 'melee'},
    [`WEAPON_BAT`] = {reason = 'Bastão',weapon = 'WEAPON_BAT', class = 'melee'},
    [`WEAPON_BOTTLE`] = {reason = 'Garrafa de Vidro',weapon = 'WEAPON_BOTTLE', class = 'melee'},
    [`WEAPON_CROWBAR`] = {reason = 'Pé de Cabra',weapon = 'WEAPON_CROWBAR', class = 'melee'},
    [`WEAPON_FLASHLIGHT`] = {reason = 'Lanterna',weapon = 'WEAPON_FLASHLIGHT', class = 'melee'},
    [`WEAPON_GOLFCLUB`] = {reason = 'Taco de Golf',weapon = 'WEAPON_GOLFCLUB', class = 'melee'},
    [`WEAPON_HAMMER`] = {reason = 'Martelo',weapon = 'WEAPON_HAMMER', class = 'melee'},
    [`WEAPON_HATCHET`] = {reason = 'Machadinho',weapon = 'WEAPON_HATCHET', class = 'melee'},
    [`WEAPON_KNUCKLE`] = {reason = 'Soco Inglês',weapon = 'WEAPON_KNUCKLE', class = 'melee'},
    [`WEAPON_KNIFE`] = {reason = 'Faca',weapon = 'WEAPON_KNIFE', class = 'melee'},
    [`WEAPON_MACHETE`] = {reason = 'Facão',weapon = 'WEAPON_MACHETE', class = 'melee'},
    [`WEAPON_SWITCHBLADE`] = {reason = 'Canivete',weapon = 'WEAPON_SWITCHBLADE', class = 'melee'},
    [`WEAPON_NIGHTSTICK`] = {reason = 'Cassetete',weapon = 'WEAPON_NIGHTSTICK', class = 'melee'},
    [`WEAPON_WRENCH`] = {reason = 'Chave Inglesa',weapon = 'WEAPON_WRENCH', class = 'melee'},
    [`WEAPON_BATTLEAXE`] = {reason = 'Machado de Batalha',weapon = 'WEAPON_BATTLEAXE', class = 'melee'},
    [`WEAPON_POOLCUE`] = {reason = 'Taco de Sinuca',weapon = 'WEAPON_POOLCUE', class = 'melee'},
    [`WEAPON_STONE_HATCHET`] = {reason = 'Machado de Pedra',weapon = 'WEAPON_STONE_HATCHET', class = 'melee'},
    [`WEAPON_PISTOL`] = {reason = 'Pistola',weapon = 'WEAPON_PISTOL', class = 'pistol'},
    [`WEAPON_PISTOL_MK2`] = {reason = 'Pistola MK2',weapon = 'WEAPON_PISTOL_MK2', class = 'pistol'},
    [`WEAPON_COMBATPISTOL`] = {reason = 'Pistola de Combate',weapon = 'WEAPON_COMBATPISTOL', class = 'pistol'},
    [`WEAPON_APPISTOL`] = {reason = 'Pistola AP',weapon = 'WEAPON_APPISTOL', class = 'pistol'},
    [`WEAPON_STUNGUN`] = {reason = 'Pistola de Choque',weapon = 'WEAPON_STUNGUN', class = 'pistol'},
    [`WEAPON_PISTOL50`] = {reason = 'Pistola .50',weapon = 'WEAPON_PISTOL50', class = 'pistol'},
    [`WEAPON_SNSPISTOL`] = {reason = 'Pistola Fajuta',weapon = 'WEAPON_SNSPISTOL', class = 'pistol'},
    [`WEAPON_SNSPISTOL_MK2`] = {reason = 'Pistola Fajuta MK2',weapon = 'WEAPON_SNSPISTOL_MK2', class = 'pistol'},
    [`WEAPON_HEAVYPISTOL`] = {reason = 'Pistola Pesada',weapon = 'WEAPON_HEAVYPISTOL', class = 'pistol'},
    [`WEAPON_VINTAGEPISTOL`] = {reason = 'Pistola Vintage',weapon = 'WEAPON_VINTAGEPISTOL', class = 'pistol'},
    [`WEAPON_FLAREGUN`] = {reason = 'Pistola Sinalizadora',weapon = 'WEAPON_FLAREGUN', class = 'pistol'},
    [`WEAPON_MARKSMANPISTOL`] = {reason = 'Pistola Atiradora',weapon = 'WEAPON_MARKSMANPISTOL', class = 'pistol'},
    [`WEAPON_REVOLVER`] = {reason = 'Pistola Revólver',weapon = 'WEAPON_REVOLVER', class = 'pistol'},
    [`WEAPON_REVOLVER_MK2`] = {reason =  'Pistola Revólver MK2',weapon = 'WEAPON_REVOLVER_MK2', class = 'pistol'},
    [`WEAPON_DOUBLEACTION`] = {reason = 'Pistola de Dupla Ação',weapon = 'WEAPON_DOUBLEACTION', class = 'pistol'},
    [`WEAPON_RAYPISTOL`] = {reason = 'Pistola de Raio',weapon = 'WEAPON_RAYPISTOL', class = 'pistol'},
    [`WEAPON_CERAMICPISTOL`] = {reason = 'Pistola de Cerâmica',weapon = 'WEAPON_CERAMICPISTOL', class = 'pistol'},
    [`WEAPON_NAVYREVOLVER`] = {reason = 'Pistola Revólver da Marinha',weapon = 'WEAPON_NAVYREVOLVER', class = 'pistol'},
    [`WEAPON_GADGETPISTOL`] = {reason = 'Pistola de Gadget',weapon = 'WEAPON_GADGETPISTOL', class = 'pistol'},
    [`WEAPON_MICROSMG`] = {reason = 'Micro SMG',weapon = 'WEAPON_MICROSMG', class = 'smg'},
    [`WEAPON_SMG`] = {reason = 'SMG',weapon = 'WEAPON_SMG', class = 'smg'},
    [`WEAPON_SMG_MK2`] = {reason = 'SMG MK2',weapon = 'WEAPON_SMG_MK2', class = 'smg'},
    [`WEAPON_ASSAULTSMG`] = {reason = 'SMG de Assalto',weapon = 'WEAPON_ASSAULTSMG', class = 'smg'},
    [`WEAPON_COMBATPDW`] = {reason = 'PDW de Combate',weapon = 'WEAPON_COMBATPDW', class = 'smg'},
    [`WEAPON_MACHINEPISTOL`] = {reason = 'Pistola Metralhadora',weapon = 'WEAPON_MACHINEPISTOL', class = 'smg'},
    [`WEAPON_MINISMG`] = {reason = 'Mini SMG',weapon = 'WEAPON_MINISMG', class = 'smg'},
    [`WEAPON_RAYCARBINE`] = {reason = 'Carabina de Raios',weapon = 'WEAPON_RAYCARBINE', class = 'smg'},
    [`WEAPON_PUMPSHOTGUN`] = {reason = 'Espingarda Pump',weapon = 'WEAPON_PUMPSHOTGUN', class = 'shotgun'},
    [`WEAPON_PUMPSHOTGUN_MK2`] = {reason = 'Espingarda Pump MK2',weapon = 'WEAPON_PUMPSHOTGUN_MK2', class = 'shotgun'},
    [`WEAPON_SAWNOFFSHOTGUN`] = {reason = 'Espingarda Cerrada',weapon = 'WEAPON_SAWNOFFSHOTGUN', class = 'shotgun'},
    [`WEAPON_ASSAULTSHOTGUN`] = {reason = 'Espingarda de Assalto',weapon = 'WEAPON_ASSAULTSHOTGUN', class = 'shotgun'},
    [`WEAPON_BULLPUPSHOTGUN`] = {reason = 'Espingarda Bullpup',weapon = 'WEAPON_BULLPUPSHOTGUN', class = 'shotgun'},
    [`WEAPON_MUSKET`] = {reason = 'Espingarda de Mosquete',weapon = 'WEAPON_MUSKET', class = 'shotgun'},
    [`WEAPON_HEAVYSHOTGUN`] = {reason = 'Espingarda Pesada',weapon = 'WEAPON_HEAVYSHOTGUN', class = 'shotgun'},
    [`WEAPON_DBSHOTGUN`] = {reason = 'Espingarda de Cano Duplo',weapon = 'WEAPON_DBSHOTGUN', class = 'shotgun'},
    [`WEAPON_AUTOSHOTGUN`] = {reason = 'Espingarda Automática',weapon = 'WEAPON_AUTOSHOTGUN', class = 'shotgun'},
    [`WEAPON_COMBATSHOTGUN`] = {reason = 'Espingarda de Combate',weapon = 'WEAPON_COMBATSHOTGUN', class = 'shotgun'},
    [`WEAPON_ASSAULTRIFLE`] = {reason = 'Rifle de Assalto',weapon = 'WEAPON_ASSAULTRIFLE', class = 'rifle'},
    [`WEAPON_ASSAULTRIFLE_MK2`] = {reason = 'Rifle de Assalto MK2',weapon = 'WEAPON_ASSAULTRIFLE_MK2', class = 'rifle'},
    [`WEAPON_CARBINERIFLE`] = {reason = 'Carabina',weapon = 'WEAPON_CARBINERIFLE', class = 'rifle'},
    [`WEAPON_CARBINERIFLE_MK2`] = {reason = 'Carabina MK2',weapon = 'WEAPON_CARBINERIFLE_MK2', class = 'rifle'},
    [`WEAPON_ADVANCEDRIFLE`] = {reason = 'Rifle Avançado',weapon = 'WEAPON_ADVANCEDRIFLE', class = 'rifle'},
    [`WEAPON_SPECIALCARBINE`] = {reason = 'Carabina Especial',weapon = 'WEAPON_SPECIALCARBINE', class = 'rifle'},
    [`WEAPON_SPECIALCARBINE_MK2`] = {reason = 'Carabina Especial MK2',weapon = 'WEAPON_SPECIALCARBINE_MK2', class = 'rifle'},
    [`WEAPON_BULLPUPRIFLE`] = {reason = 'Rifle Bullpup',weapon = 'WEAPON_BULLPUPRIFLE', class = 'rifle'},
    [`WEAPON_BULLPUPRIFLE_MK2`] = {reason = 'Rifle Bullpup MK2',weapon = 'WEAPON_BULLPUPRIFLE_MK2', class = 'rifle'},
    [`WEAPON_COMPACTRIFLE`] = {reason = 'Rifle Compacto',weapon = 'WEAPON_COMPACTRIFLE', class = 'rifle'},
    [`WEAPON_MILITARYRIFLE`] = {reason = 'Rifle Militar',weapon = 'WEAPON_MILITARYRIFLE', class = 'rifle'},
    [`WEAPON_MG`] = {reason = 'Metralhadora',weapon = 'WEAPON_MG', class = 'rifle'},
    [`WEAPON_COMBATMG`] = {reason = 'Metralhadora de Combate',weapon = 'WEAPON_COMBATMG', class = 'rifle'},
    [`WEAPON_COMBATMG_MK2`] = {reason = 'Metralhadora de Combate MK2',weapon = 'WEAPON_COMBATMG_MK2', class = 'rifle'},
    [`WEAPON_GUSENBERG`] = {reason = 'Metralhadora de Tambor',weapon = 'WEAPON_GUSENBERG', class = 'rifle'},
    [`WEAPON_SNIPERRIFLE`] = {reason = 'Rifle Sniper',weapon = 'WEAPON_SNIPERRIFLE', class = 'sniper'},
    [`WEAPON_HEAVYSNIPER`] = {reason = 'Rifle Sniper Pesado',weapon = 'WEAPON_HEAVYSNIPER', class = 'sniper'},
    [`WEAPON_HEAVYSNIPER_MK2`] = {reason = 'Rifle Sniper Pesado MK2',weapon = 'WEAPON_HEAVYSNIPER_MK2', class = 'sniper'},
    [`WEAPON_MARKSMANRIFLE`] = {reason = 'Rifle de Atirador',weapon = 'WEAPON_MARKSMANRIFLE', class = 'sniper'},
    [`WEAPON_MARKSMANRIFLE_MK2`] = {reason = 'Rifle de Atirador MK2',weapon = 'WEAPON_MARKSMANRIFLE_MK2', class = 'sniper'},
    [`WEAPON_RPG`] = {reason = 'Lança Míssel (RPG)',weapon = 'WEAPON_RPG', class = 'rpg'},
    [`WEAPON_GRENADELAUNCHER`] = {reason = 'Lançador de Granadas',weapon = 'WEAPON_GRENADELAUNCHER', class = 'rpg'},
    [`WEAPON_MINIGUN`] = {reason = 'Metralhadora Giratória',weapon = 'WEAPON_MINIGUN', class = 'rpg'},
    [`WEAPON_FIREWORK`] = {reason = 'Lança Fogos',weapon = 'WEAPON_FIREWORK', class = 'rpg'},
    [`WEAPON_RAILGUN`] = {reason = 'Arma de Raios',weapon = 'WEAPON_RAILGUN', class = 'rpg'},
    [`WEAPON_HOMINGLAUNCHER`] = {reason = 'Lança Míssel Teleguiado',weapon = 'WEAPON_HOMINGLAUNCHER', class = 'rpg'},
    [`WEAPON_COMPACTLAUNCHER`] = {reason = 'Lançador Compacto',weapon = 'WEAPON_COMPACTLAUNCHER', class = 'rpg'},
    [`WEAPON_RAYMINIGUN`] = {reason = 'Metralhadora Giratória de Raios',weapon = 'WEAPON_RAYMINIGUN', class = 'rpg'},
    [`WEAPON_GRENADE`] = {reason = 'Granada',weapon = 'WEAPON_GRENADE', class = 'grenade'},
    [`WEAPON_BZGAS`] = {reason = 'Granada Gás',weapon = 'WEAPON_BZGAS', class = 'grenade'},
    [`WEAPON_MOLOTOV`] = {reason = 'Molotov',weapon = 'WEAPON_MOLOTOV', class = 'grenade'},
    [`WEAPON_STICKYBOMB`] = {reason = 'Bomba Adesivo (C4)',weapon = 'WEAPON_STICKYBOMB', class = 'grenade'},
    [`WEAPON_PROXMINE`] = {reason = 'Mina de Proximidade',weapon = 'WEAPON_PROXMINE', class = 'grenade'},
    [`WEAPON_SNOWBALL`] = {reason = 'Bola de Neve',weapon = 'WEAPON_SNOWBALL', class = 'snowball'},
    [`WEAPON_PIPEBOMB`] = {reason = 'Bomba Caseira',weapon = 'WEAPON_PIPEBOMB', class = 'grenade'},
    [`WEAPON_BALL`] = {reason = 'Bola de Tênis',weapon = 'WEAPON_BALL', class = 'grenade'},
    [`WEAPON_SMOKEGRENADE`] = {reason = 'Granada de Fumaça',weapon = 'WEAPON_SMOKEGRENADE', class = 'grenade'},
    [`WEAPON_FLARE`] = {reason = 'Granda de Clarão',weapon = 'WEAPON_FLARE', class = 'grenade'},
    [`WEAPON_PETROLCAN`] = {reason = 'Galão de Gasolina',weapon = 'WEAPON_PETROLCAN', class = 'grenade'},
    [`WEAPON_PARACHUTE`] = {reason = 'Paraquedas',weapon = 'WEAPON_PARACHUTE', class = 'grenade'},
    [`WEAPON_FIREEXTINGUISHER`] = {reason = 'Extintor de Incêndio',weapon = 'WEAPON_FIREEXTINGUISHER', class = 'grenade'},
    [`WEAPON_HAZARDCAN`] = {reason = 'Rezidos Inflamáveis',weapon = 'WEAPON_HAZARDCAN', class = 'grenade'},
    }
}