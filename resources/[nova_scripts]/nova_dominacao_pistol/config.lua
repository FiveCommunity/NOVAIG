Config = {
    pointsPerMinute = 2,
    pointsPerKill = 0,

    pointsPerMarkerNotDominated = 30,
    pointsPerMarkerDominated = 50,
    pointsLostAfterLost = 20,

    -- NÃO COLOCAR ARMAS QUE VÃO VIR DO AIRDROP
    weaponsWhitelistEnterZone = {
        [GetHashKey("WEAPON_PISTOL_MK2")] = true,
        [GetHashKey("WEAPON_SNSPISTOL_MK2")] = true,
        [GetHashKey("WEAPON_PISTOL_MK2")] = true,
    },

    pointsMax = 1000,

    requestInit = {['21'] = 0, },
    time = 120, -- em minuto(s)

    coordsBlip = vec3(-1597.78,6646.18,16.74),
    coordsPolyZone = { -- CORDENADAS DA ZONA DE DOMINAÇÃO ( LIGUE OS PONTOS EM LINHA RETAS SEM CRUZAR )
        vec3(-1632.22,6624.45,16.75),
        vec3(-1627.17,6617.96,16.75),
        vec3(-1623.85,6611.84,16.75),
        vec3(-1621.66,6605.73,16.75),
        vec3(-1619.92,6597.03,16.74),
        vec3(-1618.94,6582.25,16.74),
        vec3(-1618.91,6571.99,16.75),
        vec3(-1618.78,6558.96,16.75),
        vec3(-1618.65,6548.12,16.75),
        vec3(-1618.46,6538.58,16.75),
        vec3(-1617.98,6532.23,16.75),
        vec3(-1617.22,6528.32,16.75),
        vec3(-1615.75,6525.26,16.74),
        vec3(-1612.84,6522.92,16.75),
        vec3(-1608.39,6522.28,16.75),
        vec3(-1604.5,6522.03,16.74),
        vec3(-1601.68,6521.5,16.75),
        vec3(-1601.92,6506.74,16.74),
        vec3(-1601.75,6498.73,16.74),
        vec3(-1601.93,6488.75,16.74),
        vec3(-1602.22,6474.37,16.74),
        vec3(-1602.71,6466.4,16.74),
        vec3(-1604.44,6454.83,16.75),
        vec3(-1606.31,6448.36,16.74),
        vec3(-1611.7,6438.62,16.74),
        vec3(-1615.24,6434.41,16.74),
        vec3(-1616.89,6423.4,16.75),
        vec3(-1616.18,6414.93,16.74),
        vec3(-1615.45,6407.89,16.95),
        vec3(-1615.17,6392.57,30.34),
        vec3(-1653.07,6368.53,21.08),
        vec3(-1701.45,6354.19,14.57),
        vec3(-1775.34,6365.23,12.58),
        vec3(-1839.63,6386.23,17.82),
        vec3(-1867.83,6417.59,16.63),
        vec3(-1903.66,6471.73,14.14),
        vec3(-1921.02,6529.19,11.48),
        vec3(-1870.96,6616.56,12.64),
        vec3(-1829.87,6664.81,20.73),
        vec3(-1806.79,6689.61,18.01),
        vec3(-1753.64,6687.11,20.41),
        vec3(-1713.59,6674.69,18.21),
        vec3(-1669.88,6660.46,19.24),
        vec3(-1651.38,6641.9,18.27),
        vec3(-1646.73,6634.7,16.74),
        vec3(-1644.63,6633.41,16.75),
        vec3(-1642.42,6632.31,16.75),
        vec3(-1639.54,6630.68,16.74),
        vec3(-1636.51,6628.56,16.74),
        vec3(-1635.01,6627.45,16.74),
        vec3(-1632.93,6625.46,16.75),
        vec3(-1632.62,6624.78,16.75)
    },

    -- ZONAS DE DOMINAÇÃO
    coordsDrawmarkers = {
        {
            pos = vec3(-1740.61,6425.69,16.73),
            label = 'A'
        },
        {
            pos = vec3(-1840.77,6571.61,16.75),
            label = 'B'
        },
        {
            pos = vec3(-1711.37,6519.62,16.73),
            label = 'C'
        },
        {
            pos = vec3(-1717.97,6635.74,16.73),
            label = 'D'
        },
    },

    -- TEMPO PARA DOMINAR UMA ZONA -- SEGUNDOS

    timeDominationZone = 10, -- 10 segundos ( para produção )

    -- PONTUAÇÃO POR MINUTO DO TOTAL DE ZONAS DOMINADAS, 1 ZONA, 2 ZONAS E 3 ZONAS

    pointsWinPerZoneDominated = {
        [1] = 2,
        [2] = 5,
        [3] = 10,
        [4] = 14,
    },

    vehicles = {
        blockVehicles = true,

        allowListVehicles = true,
        ListVehicles = {
            [GetHashKey('volatus')] = true,
            [GetHashKey('swift2')] = true,
            [GetHashKey('swift')] = true,
            [GetHashKey('supervolito2')] = true,
            [GetHashKey('supervolito')] = true,
            [GetHashKey('frogger2')] = true,
            [GetHashKey('frogger')] = true,
            [GetHashKey('buzzard2')] = true,
            [GetHashKey('buzzard')] = true,
            [GetHashKey('havok')] = true,
            [GetHashKey('seasparrow')] = true,
            [GetHashKey('seasparrow2')] = true,
            [GetHashKey('seasparrow3')] = true
        }
    },

    winDomination = {
        timeBoostRunning = 24 * 60, -- 24 horas -> em minutos
    },

    airdrop = {
        timePerAirdrop = 20, -- em minutos

        locations = {
            vec3(-1608.71,6490.66,16.73),
            vec3(-1671.23,6412.44,16.73),
            vec3(-1735.42,6452.33,16.5),
            vec3(-1840.82,6470.44,16.93),
            vec3(-1874.9,6527.97,16.5),
            vec3(-1813.43,6584.63,16.51),
            vec3(-1762.57,6661.1,16.48),
            vec3(-1695.34,6644.21,16.48),
            vec3(-1625.38,6607.98,16.48),
            vec3(-1720.72,6524.29,17.1),
        },

        rewards = {
            {
                rewards = {
                    { item = 'weapon_snspistol_mk2', quantity = 1 },
                    { item = 'ammo_snspistol_mk2', quantity = 250 },
                },
                probability = 75,
            },
            {
                rewards = {
                    { item = 'weapon_pistol_mk2', quantity = 1 },
                    { item = 'ammo_pistol_mk2', quantity = 250 },
                },
                probability = 50,
            },
            {
                rewards = {
                    { item = 'weapon_appistol', quantity = 1 },
                    { item = 'ammo_appistol', quantity = 250 },
                },
                probability = 25,
            },
        }
    },
}