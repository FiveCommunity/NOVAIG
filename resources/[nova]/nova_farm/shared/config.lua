Config = {}

Config.coinAmount = 1 -- Quantidade de moedas para boostar
Config.coinMultiplier = 1.0 -- Multiplicador do boost
Config.coinTime = 60 * 60 -- Tempo do boost em segundos
Config.imageURL = 'http://177.54.148.31:4020/lotus/inventario_cda'
Config.routeCooldownTime = 20

Config.Routes = {
	--[ MUNICAO ]--

	{ coords = vec3(-1468.19,-47.93,54.64), routeType = "Municao", rewardType = "Municao", permissions = {"perm.espanha"} },
	{ coords = vec3(-1677.9,-231.19,55.71), routeType = "Municao", rewardType = "Municao", permissions = {"perm.egito"} },
	{ coords = vec3(702.98,-353.18,42.97), routeType = "Municao", rewardType = "Municao", permissions = {"perm.mexico"} },
	{ coords = vec3(-3197.93,837.71,8.93), routeType = "Municao", rewardType = "Municao", permissions = {"perm.okayda"} },
	{ coords = vec3(-1041.69,301.23,66.99), routeType = "Municao", rewardType = "Municao", permissions = {"perm.korea"} },
	{ coords = vec3(-802.6,168.84,72.82), routeType = "Municao", rewardType = "Municao", permissions = {"perm.colombia"} },
	{ coords = vec3(1412.52,-746.03,67.18), routeType = "Municao", rewardType = "Municao", permissions = {"perm.franca"} },
	{ coords = vec3(-93.42,992.04,235.75), routeType = "Municao", rewardType = "Municao", permissions = {"perm.pcc"} },
	{ coords = vec3(333.04,-2012.2,22.39), routeType = "Municao", rewardType = "Municao", permissions = {"perm.medellin"} },
    { coords = vec3(-2672.34,1312.05,147.44), routeType = "Municao", rewardType = "Municao", permissions = {"perm.bratva"} },
    { coords = vec3(-886.32,-1464.58,7.55), routeType = "Municao", rewardType = "Municao", permissions = {"perm.yakuza"} },
    { coords = vec3(-1520.58,857.93,181.78), routeType = "Municao", rewardType = "Municao", permissions = {"perm.vaticano"} },


	--[ DESMANCHE ]--

	{ coords = vec3(-1192.86,-1728.64,11.9), routeType = "ItensIlegal", rewardType = "Desmanche", permissions = {"perm.cdd"} },
	{ coords = vec3(1715.77,-2085.38,113.67), routeType = "ItensIlegal", rewardType = "Desmanche", permissions = {"perm.pedreira"} },
	{ coords = vec3(-198.19,-1341.79,34.91), routeType = "ItensIlegal", rewardType = "Desmanche", permissions = {"perm.bennys"} },
	{ coords = vec3(726.14,-1073.6,28.31), routeType = "ItensIlegal", rewardType = "Desmanche", permissions = {"perm.lacoste"} },
	{ coords = vec3(1035.93,-2534.25,32.27), routeType = "ItensIlegal", rewardType = "Desmanche", permissions = {"perm.hellsangels"} },
	{ coords = vec3(957.86,-111.09,74.34), routeType = "ItensIlegal", rewardType = "Desmanche", permissions = {"perm.motoclube"} },
	{ coords = vec3(119.58,-1968.97,21.33), routeType = "ItensIlegal", rewardType = "Desmanche", permissions = {"perm.roxos"} },
	{ coords = vec3(-1574.22,-412.25,48.26), routeType = "ItensIlegal", rewardType = "Desmanche", permissions = {"perm.cohab"} },
    { coords = vec3(1399.46,-2539.74,55.23), routeType = "ItensIlegal", rewardType = "Desmanche", permissions = {"perm.escocia"} },



	--[ LAVAGEM ]--

	{ coords = vec3(964.41,18.94,75.74), routeType = "Lavagem", rewardType = "Lavagem", permissions = {"perm.cassino"} },
	{ coords = vec3(-319.47,205.93,87.94), routeType = "Lavagem", rewardType = "Lavagem", permissions = {"perm.lux"} },
	
	{ coords = vec3(-568.99,284.18,77.68), routeType = "Lavagem", rewardType = "Lavagem", permissions = {"perm.tequila"} },
	{ coords = vec3(-1146.58,376.26,71.31), routeType = "Lavagem", rewardType = "Lavagem", permissions = {"perm.sete"} },
	{ coords = vec3(417.61,-1496.8,30.14), routeType = "Lavagem", rewardType = "Lavagem", permissions = {"perm.anonymous"} },
	{ coords = vec3(-443.22,-31.47,46.19), routeType = "Lavagem", rewardType = "Lavagem", permissions = {"perm.anubis"} },
	{ coords = vec3(-1392.88,-608.55,30.31), routeType = "Lavagem", rewardType = "Lavagem", permissions = {"perm.bahamas"} },

	--[ ARMAS ]--

	{ coords = vec3(-1539.41,81.49,56.75), routeType = "Armas", rewardType = "Armas", permissions = {"perm.inglaterra"} },
	{ coords = vec3(3044.852, 2975.232, 89.79719), routeType = "Armas", rewardType = "Armas", permissions = {"perm.cv"} },
	{ coords = vec3(-3110.08,1725.08,36.13), routeType = "Armas", rewardType = "Armas", permissions = {"perm.milicia"} },
	{ coords = vec3(1167.749, -162.062027, 74.71558), routeType = "Armas", rewardType = "Armas", permissions = {"perm.grota"} },
	{ coords = vec3(-2948.57,46.9,11.9), routeType = "Armas", rewardType = "Armas", permissions = {"perm.magnatas"} },
	{ coords = vec3(1394.31,1144.54,114.33), routeType = "Armas", rewardType = "Armas", permissions = {"perm.hospicio"} },
	{ coords = vec3(411.45,3.22,84.92), routeType = "Armas", rewardType = "Armas", permissions = {"perm.corleone"} },
	{ coords = vec3(-1868.8,2066.29,140.97), routeType = "Armas", rewardType = "Armas", permissions = {"perm.mafia"} },
	{ coords = vec3(-827.22,-713.12,23.78), routeType = "Armas", rewardType = "Armas", permissions = {"perm.china"} },

	--[ CONTRABANDO ]--
	
	--[ COCAINA E LANÇA ]--

	--[ BALINHA E HAXIXE ]--

	{ coords = vec3(-350.84,-1519.38,33.19), routeType = "Drogas", rewardType = "OpioHeroinaMaconhaMd", permissions = {"perm.grecia"} },
	{ coords = vec3(2093.56,2323.22,101.67), routeType = "Drogas", rewardType = "BalinhaHaxixe", permissions = {"perm.hamas"} },
	{ coords = vec3(1881.82,759.14,228.08), routeType = "Drogas", rewardType = "BalinhaHaxixe", permissions = {"perm.suecia"} },

	-- MACONHA | HEROINA | OPIO | BALINHA

	{ coords = vec3(-2264.75,-261.81,63.51), routeType = "Drogas", rewardType = "DrugsHMOB", permissions = {"perm.irlanda"} },
	{ coords = vec3(-250.25,-2019.83,30.14), routeType = "Drogas", rewardType = "DrugsHMOB", permissions = {"perm.taliba"} },
	{ coords = vec3(-616.14,-1622.82,33.01), routeType = "Drogas", rewardType = "DrugsHMOB", permissions = {"perm.sindicato"} },
    { coords = vec3(-2603.9,1923.01,167.3), routeType = "Drogas", rewardType = "DrugsHMOB", permissions = {"perm.psico"} },
    
	
	--[ META | LANÇA | HAXIXE | COCAINA ]--
	{ coords = vec3(-149.24,-1606.32,35.03), routeType = "Drogas", rewardType = "DrugsMLHC", permissions = {"perm.elements"} },
	{ coords = vec3(706.78,-966.65,30.41), routeType = "Drogas", rewardType = "DrugsMLHC", permissions = {"perm.italia"} },
	{ coords = vec3(750.18,-542.4,33.63), routeType = "Drogas", rewardType = "DrugsMLHC", permissions = {"perm.medusa"} },
    { coords = vec3(2442.95,4971.42,46.81), routeType = "Drogas", rewardType = "DrugsMLHC", permissions = {"perm.abutres"} },
	{ coords = vec3(924.36,354.02,112.3), routeType = "Drogas", rewardType = "DrugsMLHC", permissions = {"perm.russia"} },

    -- Remedio
    { coords = vec3(1139.98,-1568.83,35.38), routeType = "Outros", rewardType = "Remedio", permissions = {"perm.unizk"} },
}

Config.Rewards = {
    Armas = {
        {
            name = 'ROTA DE ARMAS',
            image = 'WEAPON_PISTOL_MK2',
            items = {
                { item = 'pecadearma', min = 5, max = 9 },
            }
        },
    },

    Municao = {
        {
            name = 'ROTA DE MUNIÇÃO',
            image = 'AMMO_PISTOL_MK2',
            items = {
                { item = 'polvora', min = 35, max = 35 },
                { item = 'capsulas', min = 25, max = 25 },
            }
        }
    },

    Lavagem = {
        {
            name = 'ROTA DE LAVAGEM',
            image = 'l-alvejante',
            items = {
                { item = 'l-alvejante', min = 8, max = 9 },
            }
        },
        {
            name = 'ROTA DE FERRO E ALUMINIO',
            image = 'ferro',
            items = {
                { item = 'ferro', min = 5, max = 10 },
                { item = 'aluminio', min = 5, max = 10 },
            }
        },
        {
            name = 'ROTA DE FIBRA DE CARBONO E POLIESTER',
            image = 'fibradecarbono',
            items = {
                { item = 'fibradecarbono', min = 5, max = 5 },
                { item = 'poliester', min = 5, max = 5 },
            }
        },
    },

    Desmanche = {
        {
            name = 'ROTA DE DESMANCHE',
            image = 'aluminio',
            items = {
                { item = 'ferro', min = 5, max = 10 },
                { item = 'aluminio', min = 5, max = 10 },
                { item = 'fibradecarbono', min = 5, max = 5 },
                { item = 'poliester', min = 5, max = 5 },
            }
        },
        {
            name = 'ROTA DE PAPEL',
            image = 'papel',
            items = {
                { item = 'papel', min = 5, max = 5 },
            }
        },
    },

    Contrabando = {
        {
            name = 'ROTA DE PAPEL',
            image = 'papel',
            items = {
                { item = 'papel', min = 12, max = 15 },
            }
        },
        {
            name = 'ROTA DE FERRO E ALUMINIO',
            image = 'ferro',
            items = {
                { item = 'ferro', min = 5, max = 10 },
                { item = 'aluminio', min = 5, max = 10 },
            }
        },
        {
            name = 'ROTA DE FIBRA DE CARBONO E POLIESTER',
            image = 'fibradecarbono',
            items = {
                { item = 'fibradecarbono', min = 5, max = 5 },
                { item = 'poliester', min = 5, max = 5 },
            }
        },
    },

    DrugsHMOB = {
        {
            name = 'ROTA DE DROGAS - HMOB',
            image = 'hmob',
            items = {
                { item = 'folhamaconha', min = 4, max = 6 },
                { item = 'morfina', min = 4, max = 6 },
                { item = 'opiopapoula', min = 4, max = 6 },
                { item = 'podemd', min = 4, max = 6 },
            }
        },
    },

    DrugsMLHC = {
        {
            name = 'ROTA DE DROGAS - MLHC',
            image = 'mlhc',
            items = {
                { item = 'respingodesolda', min = 4, max = 6 },
                { item = 'anfetamina', min = 4, max = 6 },
                { item = 'resinacannabis', min = 4, max = 6 },
                { item = 'pastabase', min = 4, max = 6 },
            }
        },
    },

    MaconhaCoca = {
        {
            name = 'ROTA DE MACONHA E COCAINA',
            image = 'maconhacoca',
            items = {
                { item = 'folhamaconha', min = 4, max = 6 },
                { item = 'pastabase', min = 4, max = 6 },
            }
        },
    },

    BalinhaHaxixe = {
        {
            name = 'ROTA DE BALINHA E HAXIXE',
            image = 'balinhahaxixe',
            items = {
                { item = 'podemd', min = 4, max = 6 },
                { item = 'resinacannabis', min = 4, max = 6 },
                { item = 'folhamaconha', min = 4, max = 6 },
                { item = 'anfetamina', min = 4, max = 6 },
            }
        },
    },

    MetanfetaminaLanca = {
        {
            name = 'ROTA DE METANFETAMINA E LANÇA',
            image = 'metanfetaminalanca',
            items = {
                { item = 'respingodesolda', min = 4, max = 6 },
                { item = 'anfetamina', min = 4, max = 6 },
            }
        },
    },

    OpioHeroina = {
        {
            name = 'ROTA DE ÓPIO E HEROÍNA',
            image = 'opioheroina',
            items = {
                { item = 'opiopapoula', min = 4, max = 6 },
                { item = 'morfina', min = 4, max = 6 },
            }
        },
    },

    OpioHeroinaMaconhaMd = {
        {
            name = 'ROTA DE ÓPIO, HEROÍNA, MACONHA E MD',
            image = 'opioheroina',
            items = {
                { item = 'opiopapoula', min = 4, max = 6 },
                { item = 'morfina', min = 4, max = 6 },
                { item = 'folhamaconha', min = 4, max = 6 },
                { item = 'podemd', min = 4, max = 6 },
            }
        },
    },

    Cocaina = {
        {
            name = 'ROTA DE COCAÍNA',
            image = 'cocaina',
            items = {
                { item = 'pastabase', min = 4, max = 6 },
            }
        },
    },

    Maconha = {
        {
            name = 'ROTA DE MACONHA',
            image = 'maconha',
            items = {
                { item = 'folhamaconha', min = 4, max = 6 },
            }
        },
    },

    Metanfetamina = {
        {
            name = 'ROTA DE METANFETAMINA',
            image = 'metanfetamina',
            items = {
                { item = 'anfetamina', min = 4, max = 6 },
            }
        },
    },

    Haxixe = {
        {
            name = 'ROTA DE HAXIXE',
            image = 'haxixe',
            items = {
                { item = 'resinacannabis', min = 4, max = 6 },
            }
        },
    },

    Opio = {
        {
            name = 'ROTA DE ÓPIO',
            image = 'opio',
            items = {
                { item = 'opiopapoula', min = 4, max = 6 },
            }
        },
    },

    Heroina = {
        {
            name = 'ROTA DE HEROÍNA',
            image = 'heroina',
            items = {
                { item = 'morfina', min = 4, max = 6 },
            }
        },
    },

    Lancaperfume = {
        {
            name = 'ROTA DE LANÇA',
            image = 'lancaperfume',
            items = {
                { item = 'respingodesolda', min = 4, max = 6 },
            }
        },
    },

    Balinha = {
        {
            name = 'ROTA DE BALINHA',
            image = 'balinha',
            items = {
                { item = 'podemd', min = 4, max = 6 },
            }
        },
    },

    Remedio = {
        {
            name = 'ROTA DE REMEDIO',
            image = 'flordelotus',
            items = {
                { item = 'riopan', min = 5, max = 10 },
                { item = 'coumadin', min = 5, max = 10 },
            }
        },
    },
}

Config.RouteBlips = {
    Armas = {
        South = {
            { coords = vec3(244.81,-41.27,69.89) },
            { coords = vec3(772.34,-152.28,74.43) },
            { coords = vec3(1217.81,-416.55,67.77) },
            { coords = vec3(1200.48,-1276.62,35.22) },
            { coords = vec3(787.46,-1770.31,29.28) },
            { coords = vec3(1432.66,-1682.29,64.79) },
            { coords = vec3(1021.11,-2434.61,29.66) },
            { coords = vec3(433.39,-1979.14,23.13) },
            { coords = vec3(-142.56,-1994.05,22.83) },
            { coords = vec3(-81.08,-1832.61,27.09) },
            { coords = vec3(-324.87,-1356.42,31.29) },
            { coords = vec3(-680.45,-945.73,20.93) },
            { coords = vec3(-1064.25,-1159.3,2.16) },
            { coords = vec3(-1305.28,-1363.85,4.52) },
            { coords = vec3(-1806.59,-402.98,44.64) },
            { coords = vec3(-715.76,303.7,85.31) },
            { coords = vec3(-766.82,-23.7,41.08) },
            { coords = vec3(-72.1,65.17,71.83) },
            { coords = vec3(736.91,132.28,80.71) },
        },
        North = {
            { coords = vec3(1561.67,867.3,77.46) },
            { coords = vec3(2559.5,373.69,108.61) },
            { coords = vec3(2521.59,2629.88,37.95) },
            { coords = vec3(1224.73,2728.37,38.0) },
            { coords = vec3(379.43,2629.81,44.67) },
            { coords = vec3(-1123.02,2682.0,18.7) },
            { coords = vec3(241.28,3107.68,42.48) },
            { coords = vec3(915.66,3565.17,33.8) },
            { coords = vec3(2039.86,3183.75,45.24) },
            { coords = vec3(2931.96,4624.54,48.71) },
            { coords = vec3(2252.08,5154.94,57.68) },
            { coords = vec3(1662.94,4776.44,42.01) },
            { coords = vec3(2467.39,4101.01,38.06) },
            { coords = vec3(1705.86,6425.2,32.76) },
            { coords = vec3(-151.35,6322.55,31.56) },
            { coords = vec3(-841.52,5401.3,34.61) },
            { coords = vec3(-3155.98,1125.54,20.86) },
            { coords = vec3(-2205.45,-373.39,13.31) },
        },
    },

    Municao = {
        South = {
            { coords = vec3(-1778.09,-427.29,41.45) },
            { coords = vec3(-1304.36,-1318.32,4.87) },
            { coords = vec3(-1215.05,-1505.03,4.33) },
            { coords = vec3(-495.21,-975.74,23.54) },
            { coords = vec3(-631.81,-1779.59,23.98) },
            { coords = vec3(1448.73,-1934.3,70.99) },
            { coords = vec3(869.78,-2327.76,30.6) },
            { coords = vec3(919.4,-1269.29,25.54) },
            { coords = vec3(497.5,-100.33,61.38) },
            { coords = vec3(1211.56,-445.21,66.94) },
            { coords = vec3(368.0,-775.29,29.27) },
            { coords = vec3(445.96,-1242.79,30.28) },
            { coords = vec3(283.28,-1814.99,27.06) },
            { coords = vec3(-769.72,-223.38,37.41) },
            { coords = vec3(-511.8,-40.83,44.52) },
            { coords = vec3(227.37,-284.04,49.72) },
            { coords = vec3(1057.09,217.22,80.98) },
        },
        North = {
            { coords = vec3(-2187.49,-409.0,13.13) },
            { coords = vec3(-3147.49,1121.32,20.86) },
            { coords = vec3(-2544.11,2316.06,33.21) },
            { coords = vec3(-1123.3,2682.08,18.72) },
            { coords = vec3(241.44,3107.75,42.48) },
            { coords = vec3(915.5,3564.98,33.8) },
            { coords = vec3(1705.71,3779.48,34.76) },
            { coords = vec3(2389.35,3310.29,47.63) },
            { coords = vec3(2054.92,3196.38,45.19) },
            { coords = vec3(1224.9,2728.05,38.0) },
            { coords = vec3(2521.42,2630.0,37.95) },
            { coords = vec3(2847.92,4450.0,48.51) },
            { coords = vec3(2456.39,4058.06,38.06) },
            { coords = vec3(1804.05,4596.33,37.61) },
            { coords = vec3(1702.29,4916.54,42.07) },
            { coords = vec3(2242.86,5154.18,57.88) },
            { coords = vec3(770.92,226.81,86.04) },
            { coords = vec3(1561.51,867.22,77.46) },
        },
    },

    Drogas = {
        South = {
            { coords = vec3(-1178.79,-365.97,36.65) },
            { coords = vec3(-1318.1,-832.23,16.97) },
            { coords = vec3(-1482.73,-1029.85,6.13) },
            { coords = vec3(-1312.07,-1336.56,4.63) },
            { coords = vec3(-494.72,-976.53,23.54) },
            { coords = vec3(-753.38,-2499.7,13.93) },
            { coords = vec3(217.97,-2012.82,18.89) },
            { coords = vec3(393.08,-1814.24,28.98) },
            { coords = vec3(105.02,-1569.25,29.72) },
            { coords = vec3(519.25,-1734.01,30.68) },
            { coords = vec3(1193.06,-1656.47,43.02) },
            { coords = vec3(1200.52,-1276.72,35.22) },
            { coords = vec3(847.22,-1315.05,26.45) },
            { coords = vec3(292.41,-223.3,53.97) },
            { coords = vec3(222.43,-595.88,43.88) },
            { coords = vec3(-516.18,-679.79,33.67) },
            { coords = vec3(-929.18,-390.98,38.96) },
            { coords = vec3(-763.62,-34.32,37.83) },
            { coords = vec3(-654.64,313.53,83.09) },
        },
        North = {
            { coords = vec3(2527.79,2617.42,37.95) },
            { coords = vec3(1194.12,2722.04,38.62) },
            { coords = vec3(719.57,2312.06,50.33) },
            { coords = vec3(1195.76,1819.46,78.92) },
            { coords = vec3(218.13,2602.17,45.78) },
            { coords = vec3(-1122.76,2682.2,18.7) },
            { coords = vec3(-2198.2,4272.57,48.53) },
            { coords = vec3(-841.16,5401.46,34.61) },
            { coords = vec3(-319.88,6085.84,31.46) },
            { coords = vec3(-36.13,6639.88,30.46) },
            { coords = vec3(-128.5,6341.23,31.49) },
            { coords = vec3(1743.06,6409.65,35.1) },
            { coords = vec3(2241.04,5163.42,58.44) },
            { coords = vec3(1726.63,4682.85,43.66) },
            { coords = vec3(2471.33,4110.86,38.06) },
            { coords = vec3(1846.28,3914.6,33.46) },
            { coords = vec3(1296.0,3629.93,33.03) },
            { coords = vec3(191.21,3082.03,43.47) },
        },
    },

    ItensIlegal = {
        South = {
            { coords = vec3(-985.42,-1198.58,5.49) },
            { coords = vec3(-619.04,-1211.36,14.05) },
            { coords = vec3(-528.81,-1784.55,21.58) },
            { coords = vec3(-41.4,-1747.78,29.4) },
            { coords = vec3(445.89,-1241.65,30.28) },
            { coords = vec3(449.93,-650.84,28.48) },
            { coords = vec3(972.33,125.61,80.98) },
            { coords = vec3(642.36,260.47,103.29) },
            { coords = vec3(15.31,378.07,112.37) },
            { coords = vec3(-515.88,413.54,97.51) },
            { coords = vec3(-1460.8,-154.97,48.83) },
            { coords = vec3(-1607.4,-431.72,40.42) },
            { coords = vec3(-1789.26,-660.39,10.46) },
            { coords = vec3(-1320.77,-1044.84,7.46) },
            { coords = vec3(-1120.56,-1508.88,4.4) },
            { coords = vec3(-1039.25,-1397.05,5.9) },
            { coords = vec3(-1153.68,-1249.6,7.19) },
            { coords = vec3(-1188.3,-1575.69,4.36) },
            { coords = vec3(-1125.71,-1061.34,2.14) },
        },
        North = {
            { coords = vec3(862.03,2173.79,52.28) },
            { coords = vec3(265.8,2598.45,44.82) },
            { coords = vec3(1141.86,2650.99,38.13) },
            { coords = vec3(1776.72,3327.66,41.43) },
            { coords = vec3(2389.35,3310.29,47.63) },
            { coords = vec3(2539.31,2603.45,37.95) },
            { coords = vec3(2897.69,4481.86,48.21) },
            { coords = vec3(2872.49,4721.33,48.8) },
            { coords = vec3(2251.79,5155.28,57.88) },
            { coords = vec3(1726.66,4765.75,41.91) },
            { coords = vec3(2467.48,4100.8,38.06) },
            { coords = vec3(1543.88,3715.59,34.81) },
            { coords = vec3(915.42,3564.94,33.8) },
            { coords = vec3(15.8,3687.68,39.56) },
            { coords = vec3(-2203.48,4276.28,48.46) },
            { coords = vec3(-840.97,5401.4,34.61) },
            { coords = vec3(1705.94,6425.11,32.76) },
            { coords = vec3(2677.93,3467.56,55.55) },
        },
    },

    Lavagem = {
        South = {
            { coords = vec3(-985.42,-1198.58,5.49) },
            { coords = vec3(-528.81,-1784.55,21.58) },
            { coords = vec3(-41.4,-1747.78,29.4) },
            { coords = vec3(445.89,-1241.65,30.28) },
            { coords = vec3(449.93,-650.84,28.48) },
            { coords = vec3(972.33,125.61,80.98) },
            { coords = vec3(642.36,260.47,103.29) },
            { coords = vec3(15.31,378.07,112.37) },
            { coords = vec3(-515.88,413.54,97.51) },
            { coords = vec3(-1460.8,-154.97,48.83) },
            { coords = vec3(-1607.4,-431.72,40.42) },
            { coords = vec3(-1789.26,-660.39,10.46) },
            { coords = vec3(-1320.77,-1044.84,7.46) },
            { coords = vec3(-1120.56,-1508.88,4.4) },
            { coords = vec3(-1153.68,-1249.6,7.19) },
            { coords = vec3(-1188.3,-1575.69,4.36) },
            { coords = vec3(-1125.71,-1061.34,2.14) },
        },
        North = {
            { coords = vec3(-2187.49,-409.0,13.13) },
            { coords = vec3(-3147.49,1121.32,20.86) },
            { coords = vec3(-2544.11,2316.06,33.21) },
            { coords = vec3(-1123.3,2682.08,18.72) },
            { coords = vec3(241.44,3107.75,42.48) },
            { coords = vec3(915.5,3564.98,33.8) },
            { coords = vec3(1705.71,3779.48,34.76) },
            { coords = vec3(2389.35,3310.29,47.63) },
            { coords = vec3(2054.92,3196.38,45.19) },
            { coords = vec3(1224.9,2728.05,38.0) },
            { coords = vec3(2521.42,2630.0,37.95) },
            { coords = vec3(2847.92,4450.0,48.51) },
            { coords = vec3(2456.39,4058.06,38.06) },
            { coords = vec3(1804.05,4596.33,37.61) },
            { coords = vec3(1702.29,4916.54,42.07) },
            { coords = vec3(2242.86,5154.18,57.88) },
            { coords = vec3(770.92,226.81,86.04) },
            { coords = vec3(1561.51,867.22,77.46) },
        },
    },

    Outros = {
        South = {
            { coords = vec3(-801.9,-922.02,18.77) },
            { coords = vec3(-978.39,-1108.45,2.14) },
            { coords = vec3(-801.99,-921.37,18.8) },
            { coords = vec3(-1277.45,-1336.2,4.25) },
            { coords = vec3(-1753.49,-694.36,10.14) },
            { coords = vec3(-1965.0,-297.0,41.1) },
            { coords = vec3(-1245.66,376.54,75.34) },
            { coords = vec3(-355.85,469.81,112.64) },
            { coords = vec3(412.67,151.02,103.2) },
            { coords = vec3(888.61,-141.81,78.33) },
            { coords = vec3(378.24,-371.92,46.89) },
            { coords = vec3(255.78,-665.48,38.18) },
            { coords = vec3(-229.0,-1118.0,23.02) },
            { coords = vec3(-545.01,-1228.0,18.45) },
            { coords = vec3(-786.0,-1045.0,12.97) },
            { coords = vec3(-1053.86,-1144.02,2.16) },
            { coords = vec3(-1090.52,-954.19,2.43) },
            { coords = vec3(-1053.13,-908.42,4.3) },
            { coords = vec3(-812.91,-980.45,14.17) },
        },
        North = {
            { coords = vec3(2527.79,2617.42,37.95) },
            { coords = vec3(1194.12,2722.04,38.62) },
            { coords = vec3(719.57,2312.06,50.33) },
            { coords = vec3(1195.76,1819.46,78.92) },
            { coords = vec3(218.13,2602.17,45.78) },
            { coords = vec3(-1122.76,2682.2,18.7) },
            { coords = vec3(-2544.01,2316.69,33.21) },
            { coords = vec3(-2198.2,4272.57,48.53) },
            { coords = vec3(-841.16,5401.46,34.61) },
            { coords = vec3(-319.88,6085.84,31.46) },
            { coords = vec3(-36.13,6639.88,30.46) },
            { coords = vec3(-128.5,6341.23,31.49) },
            { coords = vec3(1743.06,6409.65,35.1) },
            { coords = vec3(2241.04,5163.42,58.44) },
            { coords = vec3(1726.63,4682.85,43.66) },
            { coords = vec3(2471.33,4110.86,38.06) },
            { coords = vec3(1846.28,3914.6,33.46) },
            { coords = vec3(1296.0,3629.93,33.03) },
            { coords = vec3(191.21,3082.03,43.47) },
        },
    },
}