Config = {
    route = 'http://177.54.148.231:3000',
    coords = {
         vec3(-1632.11,-1015.16,13.13),
         vec3(187.48,-972.54,29.55),
        -- vec4(798.45,416.59,139.68,55.49),
        -- vec4(391.92,7.01,91.33,60.11),
        -- vec4(-3013.35,82.38,11.68,11.26),
        -- vec4(1409.9,-757.93,67.18,65.5),
        -- vec4(-968.28,351.72,72.15,226.07),
        -- vec4(-1528.33,874.58,181.73,13.59),
        -- vec4(559.94,854.23,219.7,32.81),
        -- vec4(980.08,-108.79,74.22,136.69),
        -- vec4(-210.68,-1309.16,31.29,8.96),
        -- vec4(722.99,-1069.5,23.07,86.71),
        -- vec4(-159.46,-1591.52,34.31,51.59),
        -- vec4(890.33,5.27,78.91,332.05),
        -- vec4(-1373.03,-617.34,30.31,94.1),
        -- vec4(-829.04,-694.27,28.05,91.14),
        -- vec4(-306.97,222.78,87.92,10.53),
        -- vec4(-237.44,-309.27,30.09,94.84),
        -- vec4(110.66,-1313.55,29.2,214.36),
        -- vec4(698.04,-285.69,59.26,247.09),
        -- vec4(1173.26,-183.79,62.39,241.18),
        -- vec4(-977.82,-1492.11,5.58,128.18),
        -- vec4(-1744.49,-80.54,85.61,133.26),
        -- vec4(-810.88,167.75,72.22,107.76),
        -- vec4(-805.49,-1832.99,29.03,322.68),
        -- vec4(1457.69,1087.77,114.33,0.0),
        -- vec4(1409.42,-743.74,69.99, 0.0),
        -- vec4(-2590.57,1926.95,167.49,0.0),
        -- vec4(2457.86,4971.03,46.57,0.0),
        -- vec4(757.02,-575.49,29.37,0.0),
        -- vec4(-580.89,-1589.97,26.74,0.0),
        -- vec4(-2664.15,1327.69,147.37,0.0),
        -- vec4(-116.45,996.2,235.75,0.0),
        -- vec4(-1896.34,2053.46,140.97,0.0),
        -- vec4(1415.71,-2526.29,55.39, 0.0),
        -- vec4(-178.95,314.21,97.93, 0.0),
        -- vec4(1752.41,2505.14,45.54,25.86), -- prisao
        -- vec4(3030.37,3003.31,84.05,0.0), -- cv
        -- vec4(1158.22,-211.31,70.4,0.0), -- grota
        -- vec4(-1145.74,380.02,71.31,0.0), -- sete
        -- vec4(382.65,-1509.21,29.28,0.0), -- anonymous
        -- vec3(-443.76,-27.59,46.19), -- anubis
        -- vec4(-1192.91,-1722.68,4.6,215.6), -- cdd
        -- -- vec4(-2253.61,234.14,174.6,0.0), -- arena
        -- vec4(-1570.76,126.74,58.27,0.0), -- arena
        -- vec4(3030.37,3003.31,84.05,0.0), -- arena
        -- vec4(-3061.0,1687.01,37.69,0.0), -- arena
        -- vec4(-1542.48,-447.09,35.92,0.0), -- arena
        -- vec4(-1199.7,-1728.39,4.6,0.0), -- arena
        -- vec4(1025.1,-2507.18,28.46,0.0), -- arena
        -- vec4(121.06,-1946.34,20.74,0.0), -- arena
        -- vec4(1374.08,-757.16,67.18,0.0), -- franca
        -- vec4(929.08,350.0,112.24,0.0), -- arena
        -- vec4(-321.73,-1545.82,31.02,0.0), -- arena
        -- vec4(-232.78,-1997.16,29.94,0.0), -- arena
        -- vec4(740.14,-970.16,24.45,0.0),
        -- vec4(-2306.03,-254.66,48.14,0.0),
        -- vec3(364.9,-2064.48,21.74),
        -- vec3(364.13,-2065.01,21.74),
        -- vec3(-2045.07,-454.43,12.27),
        -- vec3(-531.92,-591.33,30.43),
        -- vec3(2596.55,5342.75,47.67),
        -- vec3(-742.19,-1256.67,5.7),
        -- vec3(-3185.26,810.78,8.93),
        -- vec3(-742.19,-1256.67,5.7),
        -- vec3(177.68,-983.39,29.52),
        -- vec3(-961.93,-2070.38,9.4),

    },

    points = {
        ['ffa'] = { -- Modo FFA
            ['min_players'] = 3, -- Quantidade minima de players para dar pontos
            ['win'] = 2, -- Quantidade de pontos por vitória
            ['kills'] = {
                ['amount'] = 15, -- Quantidade de kills para dar 1 ponto
                ['points'] = 1, -- Quantidade de kills para dar 1 ponto
            }
        },
        
        ['gungame'] = { -- Modo FFA
            ['min_players'] = 3, -- Quantidade minima de players para dar pontos
            ['win'] = 5, -- Quantidade de pontos por vitória
            ['kills'] = {
                ['amount'] = 60, -- Quantidade de kills para dar 1 ponto
                ['points'] = 1, -- Quantidade de kills para dar 1 ponto
            }
        }
    },

    ranks = {
        -- PONTOS NECESSARIOS / RANKING
        [10] = {
            index = 'bronze1',
            name = 'Bronze 1'
        },
        [20] = {
            index = 'bronze2',
            name = 'Bronze 2'
        },
        [30] = {
            index = 'bronze3',
            name = 'Bronze 3'
        },
        [40] = {
            index = 'bronze4',
            name = 'Bronze 4'
        },
        [50] = {
            index = 'bronze5',
            name = 'Bronze 5'
        },
        [70] = {
            index = 'gold1',
            name = 'Gold 1'
        },
        [80] = {
            index = 'gold2',
            name = 'Gold 2'
        },
        [90] = {
            index = 'gold3',
            name = 'Gold 3'
        },
        [100] = {
            index = 'gold4',
            name = 'Gold 4'
        },
        [125] = {
            index = 'gold5',
            name = 'Gold 5'
        },
        [150] = {
            index = 'diamond1',
            name = 'Diamond 1'
        },
        [170] = {
            index = 'diamond2',
            name = 'Diamond 2'
        },
        [200] = {
            index = 'diamond3',
            name = 'Diamond 3'
        },
        [250] = {
            index = 'diamond4',
            name = 'Diamond 4'
        },
        [300] = {
            index = 'diamond5',
            name = 'Diamond 5'
        }
    },
}

Config.Gungame = {
    weapons = { -- ORDEM GUN GAME
        [1] = { current_kills = 0, weapon = 'weapon_pistol_mk2' },
        [2] = { current_kills = 6, weapon = 'weapon_snspistol_mk2' },
        [3] = { current_kills = 8, weapon = 'weapon_revolver_mk2' },
        [4] = { current_kills = 13, weapon = 'weapon_microsmg' },
        [5] = { current_kills = 16, weapon = 'weapon_combatpdw' },
        [6] = { current_kills = 18, weapon = 'weapon_pumpshotgun_mk2' },
        [7] = { current_kills = 22, weapon = 'weapon_assaultrifle' },
        [8] = { current_kills = 24, weapon = 'weapon_specialcarbine_mk2' },
        [9] = { current_kills = 29, weapon = 'weapon_compactrifle' },
        [10] = { current_kills = 30, weapon = 'weapon_machete' }
    }
}

Config.X1 = {
    maxTime = 60, -- Tempo maximo do X1
    map = { 
        image = 'http://177.54.148.31:4020/lotus/pvp_mapas/treatro.png', 
        spawns = {
            [1] = vec4(79.55,-863.92,134.76,257.09),
            [2] = vec4(125.19,-879.63,134.76,70.8)
        }
    },
}

Config.Teams = {
    timePerRound = 5, -- Tempo por round

    uniforms = {
        ['ct'] = {
            [`mp_m_freemode_01`] = {
                [1] = { 0,0,0 },
                [3] = { 1,0,2 },
                [4] = { 322,0,2 },
                [6] = { 25,0,2 },
                [7] = { 1,6,2 },
                [8] = { 15,0,2 },
                [9] = { 0,0,0 },
                [11] = { 811,0,2 },
                ["p6"] = { -1,0 },
                ["p0"] = { -1,0 } 
            },

            [`mp_f_freemode_02`] = {
                [1] = { 279,3,2 },
                [3] = { 14,0,2 },
                [4] = { 349,0,2 },
                [6] = { 25,0,2 },
                [7] = { 1,6,2 },
                [8] = { 7,0,2 },
                [9] = { 0,0,2 },
                [11] = { 929,0,2 },
                ["p6"] = { -1,0 },
                ["p0"] = { -1,0 } 
            }
        },

        ['tr'] = {
            [`mp_m_freemode_01`] = {
                [1] = { 0,0,0 },
                [3] = { 11,0,2 },
                [4] = { 321,0,2 },
                [6] = { 25,0,2 },
                [7] = { 1,6,2 },
                [8] = { 15,0,2 },
                [9] = { 0,0,0 },
                [11] = { 810,0,2 },
                ["p6"] = { -1,0 },
                ["p0"] = { -1,0 }, 
            },

            [`mp_f_freemode_02`] = {
                [1] = { 279,3,2 },
                [3] = { 14,0,2 },
                [4] = { 348,0,2 },
                [6] = { 25,0,2 },
                [7] = { 1,6,2 },
                [8] = { 7,0,2 },
                [9] = { 0,0,2 },
                [11] = { 928,0,2 },
                ["p6"] = { -1,0 },
                ["p0"] = { -1,0 }, 
            }
        },
    }
}

Config.Maps = {
    ['clock_tower'] = { 
        image = 'http://177.54.148.31:4020/lotus/pvp_mapas/clock.png', 
        spawns = {
            ['ffa'] = {
                [1] = vec3(-3277.78,-2526.52,18.33),
                [2] = vec3(-3282.29,-2535.5,18.33),
                [3] = vec3(-3272.94,-2518.18,18.33),
                [4] = vec3(-3275.59,-2533.04,22.06),
                [5] = vec3(-3276.25,-2519.01,22.06),
                [6] = vec3(-3275.55,-2533.19,25.78),
                [7] = vec3(-3254.14,-2511.16,12.52),
                [8] = vec3(-3240.17,-2507.26,12.27),
                [9] = vec3(-3223.43,-2450.34,6.4),
                [10] = vec3(-3237.81,-2444.92,6.44),
                [11] = vec3(-3273.32,-2448.44,6.39),
                [12] = vec3(-3301.59,-2477.88,6.35),
                [13] = vec3(-3215.11,-2540.63,16.06),
                [14] = vec3(-3210.34,-2552.83,12.33),
                [15] = vec3(-3213.3,-2529.79,12.33),
                [16] = vec3(-3207.08,-2552.51,16.06),
                [17] = vec3(-3268.14,-2622.83,14.9),
                [18] = vec3(-3286.11,-2569.39,12.23),
                [19] = vec3(-3309.75,-2552.63,18.21),
                [20] = vec3(-3209.26,-2570.67,12.22),
                [21] = vec3(-3217.41,-2570.69,12.25),
                [22] = vec3(-3270.83,-2448.0,6.39),
                [23] = vec3(-3387.3,-2511.23,6.35),
            },

            ['gungame'] = {
                [1] = vec3(-3277.78,-2526.52,18.33),
                [2] = vec3(-3282.29,-2535.5,18.33),
                [3] = vec3(-3272.94,-2518.18,18.33),
                [4] = vec3(-3275.59,-2533.04,22.06),
                [5] = vec3(-3276.25,-2519.01,22.06),
                [6] = vec3(-3275.55,-2533.19,25.78),
                [7] = vec3(-3254.14,-2511.16,12.52),
                [8] = vec3(-3240.17,-2507.26,12.27),
                [9] = vec3(-3223.43,-2450.34,6.4),
                [10] = vec3(-3237.81,-2444.92,6.44),
                [11] = vec3(-3273.32,-2448.44,6.39),
                [12] = vec3(-3301.59,-2477.88,6.35),
                [13] = vec3(-3215.11,-2540.63,16.06),
                [14] = vec3(-3210.34,-2552.83,12.33),
                [15] = vec3(-3213.3,-2529.79,12.33),
                [16] = vec3(-3207.08,-2552.51,16.06),
                [17] = vec3(-3268.14,-2622.83,14.9),
                [18] = vec3(-3286.11,-2569.39,12.23),
                [19] = vec3(-3309.75,-2552.63,18.21),
                [20] = vec3(-3209.26,-2570.67,12.22),
                [21] = vec3(-3217.41,-2570.69,12.25),
                [22] = vec3(-3270.83,-2448.0,6.39),
                [23] = vec3(-3387.3,-2511.23,6.35),
            },

            ['teams'] = {
                ['ct'] = {
                    [1] = vec3(-3159.83,-2541.36,6.71),
                    [2] = vec3(-3160.36,-2540.09,6.62),
                    [3] = vec3(-3160.69,-2538.21,6.54),
                    [4] = vec3(-3160.87,-2535.89,6.44),
                    [5] = vec3(-3159.61,-2543.72,6.79),
                    [6] = vec3(-3159.57,-2545.37,6.86),
                },

                ['tr'] = {
                    [1] = vec3(-3395.38,-2522.69,6.25),
                    [2] = vec3(-3395.6,-2521.34,6.25),
                    [3] = vec3(-3395.36,-2519.56,6.27),
                    [4] = vec3(-3395.14,-2517.63,6.27),
                    [5] = vec3(-3394.97,-2515.93,6.35),
                    [6] = vec3(-3394.83,-2514.14,6.35),
                }
            }
        }
    },

    ['mirage'] = { 
        image = 'http://177.54.148.31:4020/lotus/pvp_mapas/mirage.png', 
        spawns = {
            ['ffa'] = {
                [1] = vec3(-2683.76,-2653.21,458.11),
                [2] = vec3(-2670.51,-2658.3,457.88),
                [3] = vec3(-2665.59,-2670.31,457.88),
                [4] = vec3(-2654.8,-2675.53,457.88),
                [5] = vec3(-2662.99,-2692.85,457.88),
                [6] = vec3(-2638.35,-2711.7,457.88),
                [7] = vec3(-2647.19,-2719.59,457.88),
                [8] = vec3(-2622.9,-2687.35,455.01),
                [9] = vec3(-2607.04,-2716.32,457.89),
                [10] = vec3(-2619.61,-2736.89,457.88),
                [11] = vec3(-2664.26,-2760.25,461.7),
                [12] = vec3(-2672.72,-2744.3,461.7),
                [13] = vec3(-2697.45,-2738.58,457.52),
                [14] = vec3(-2713.96,-2720.1,455.35),
                [15] = vec3(-2689.54,-2695.29,457.88),
                [16] = vec3(-2679.89,-2693.4,457.88),
                [17] = vec3(-2664.35,-2679.49,451.91),
            },

            ['gungame'] = {
                [1] = vec3(-2683.76,-2653.21,458.11),
                [2] = vec3(-2670.51,-2658.3,457.88),
                [3] = vec3(-2665.59,-2670.31,457.88),
                [4] = vec3(-2654.8,-2675.53,457.88),
                [5] = vec3(-2662.99,-2692.85,457.88),
                [6] = vec3(-2638.35,-2711.7,457.88),
                [7] = vec3(-2647.19,-2719.59,457.88),
                [8] = vec3(-2622.9,-2687.35,455.01),
                [9] = vec3(-2607.04,-2716.32,457.89),
                [10] = vec3(-2619.61,-2736.89,457.88),
                [11] = vec3(-2664.26,-2760.25,461.7),
                [12] = vec3(-2672.72,-2744.3,461.7),
                [13] = vec3(-2697.45,-2738.58,457.52),
                [14] = vec3(-2713.96,-2720.1,455.35),
                [15] = vec3(-2689.54,-2695.29,457.88),
                [16] = vec3(-2679.89,-2693.4,457.88),
                [17] = vec3(-2664.35,-2679.49,451.91),
            },

            ['teams'] = {
                ['ct'] = {
                    [1] = vec3(-2714.43,-2710.16,455.01),
                    [2] = vec3(-2713.96,-2709.75,455.01),
                    [3] = vec3(-2713.01,-2708.63,455.01),
                    [4] = vec3(-2711.24,-2708.14,455.01),
                    [5] = vec3(-2714.96,-2711.49,455.01),
                    [6] = vec3(-2715.54,-2712.83,455.01),
                },

                ['tr'] = {
                    [1] = vec3(-2609.19,-2722.5,457.88),
                    [2] = vec3(-2611.12,-2724.8,457.88),
                    [3] = vec3(-2612.12,-2726.22,457.88),
                    [4] = vec3(-2608.68,-2721.46,457.88),
                    [5] = vec3(-2607.79,-2720.12,457.88),
                    [6] = vec3(-2606.69,-2718.42,457.88),
                }
            }
        }
    },

    ['de_dust2'] = { 
        image = 'http://177.54.148.31:4020/lotus/pvp_mapas/dust2.png', 
        spawns = {
            ['ffa'] = {
                [1] = vec3(-5864.82,1819.53,670.93),
                [2] = vec3(-5888.39,1839.76,667.72),
                [3] = vec3(-5883.24,1857.17,667.72),
                [4] = vec3(-5876.54,1887.79,674.14),
                [5] = vec3(-5879.72,1870.13,673.32),
                [6] = vec3(-5884.78,1846.99,673.22),
                [7] = vec3(-5867.68,1845.04,670.93),
                [8] = vec3(-5860.65,1814.64,670.93),
                [9] = vec3(-5871.57,1795.89,670.93),
                [10] =  vec3(-5878.47,1785.87,670.93),
                [11] =  vec3(-5848.29,1781.2,674.13),
                [12] =  vec3(-5834.14,1818.81,670.93),
                [13] =  vec3(-5926.02,1821.05,671.75),
                [14] =  vec3(-5910.88,1823.91,670.93),
                [15] =  vec3(-5900.24,1795.97,671.72),
                [16] =  vec3(-5882.07,1783.2,670.91),
            },

            ['gungame'] = {
                [1] = vec3(-5864.82,1819.53,670.93),
                [2] = vec3(-5888.39,1839.76,667.72),
                [3] = vec3(-5883.24,1857.17,667.72),
                [4] = vec3(-5876.54,1887.79,674.14),
                [5] = vec3(-5879.72,1870.13,673.32),
                [6] = vec3(-5884.78,1846.99,673.22),
                [7] = vec3(-5867.68,1845.04,670.93),
                [8] = vec3(-5860.65,1814.64,670.93),
                [9] = vec3(-5871.57,1795.89,670.93),
                [10] =  vec3(-5878.47,1785.87,670.93),
                [11] =  vec3(-5848.29,1781.2,674.13),
                [12] =  vec3(-5834.14,1818.81,670.93),
                [13] =  vec3(-5926.02,1821.05,671.75),
                [14] =  vec3(-5910.88,1823.91,670.93),
                [15] =  vec3(-5900.24,1795.97,671.72),
                [16] =  vec3(-5882.07,1783.2,670.91),
            },

            ['teams'] = {
                ['ct'] = {
                    [1] = vec3(-5884.62,1858.29,667.72),
                    [2] = vec3(-5884.25,1858.57,667.72),
                    [3] = vec3(-5883.24,1859.53,667.72),
                    [4] = vec3(-5881.51,1860.31,667.72),
                    [5] = vec3(-5885.52,1856.97,667.72),
                    [6] = vec3(-5886.46,1855.57,667.72),
                },

                ['tr'] = {
                    [1] = vec3(-5838.54,1787.9,674.13),
                    [2] = vec3(-5837.73,1788.47,674.13),
                    [3] = vec3(-5836.82,1789.88,674.13),
                    [4] = vec3(-5840.34,1786.92,674.13),
                    [5] = vec3(-5841.32,1785.55,674.13),
                    [6] = vec3(-5839.13,1785.45,674.16),
                }
            }
        }
    },

    ['haven'] = { 
        image = 'http://177.54.148.31:4020/lotus/pvp_mapas/haven.png', 
        spawns = {
            ['ffa'] = {
                [1] = vec3(4474.32,7592.51,711.89),
                [2] = vec3(4462.61,7589.94,711.9),
                [3] = vec3(4465.56,7597.77,711.89),
                [4] = vec3(4470.2,7607.36,711.89),
                [5] = vec3(4481.45,7590.72,711.89),
                [6] = vec3(4485.16,7583.19,710.29),
                [7] = vec3(4473.91,7574.52,710.29),
                [8] = vec3(4471.11,7564.88,711.9),
                [9] = vec3(4458.08,7571.85,710.91),
                [10] =  vec3(4459.22,7582.91,709.55),
                [11] =  vec3(4475.78,7582.04,711.9),
                [12] =  vec3(4474.9,7604.95,716.61),
                [13] =  vec3(4463.78,7609.07,715.78),
                [14] =  vec3(4447.14,7610.87,711.89),
                [15] =  vec3(4435.64,7601.07,711.89),
                [16] =  vec3(4422.77,7594.49,711.89),
                [17] =  vec3(4428.95,7584.36,711.89),
                [18] =  vec3(4436.44,7592.91,711.9),
                [19] =  vec3(4440.82,7581.88,715.04),
                [20] =  vec3(4438.65,7568.3,711.9),
                [21] =  vec3(4455.34,7560.39,710.34),
                [22] =  vec3(4445.35,7554.33,711.9),
                [23] =  vec3(4461.12,7546.73,711.9),
                [24] =  vec3(4463.32,7534.49,711.9),
                [25] =  vec3(4431.39,7534.99,710.35),
                [26] =  vec3(4425.1,7538.55,710.35),
                [27] =  vec3(4419.8,7550.19,711.15),
                [28] =  vec3(4406.39,7558.17,711.15),
                [29] =  vec3(4417.76,7562.92,711.15),
                [30] =  vec3(4411.84,7576.04,711.15),
                [31] =  vec3(4399.55,7570.84,711.15),
                [32] =  vec3(4426.58,7572.39,710.34),
                [33] =  vec3(4423.82,7573.19,711.89),
            },

            ['gungame'] = {
                [1] = vec3(4474.32,7592.51,711.89),
                [2] = vec3(4462.61,7589.94,711.9),
                [3] = vec3(4465.56,7597.77,711.89),
                [4] = vec3(4470.2,7607.36,711.89),
                [5] = vec3(4481.45,7590.72,711.89),
                [6] = vec3(4485.16,7583.19,710.29),
                [7] = vec3(4473.91,7574.52,710.29),
                [8] = vec3(4471.11,7564.88,711.9),
                [9] = vec3(4458.08,7571.85,710.91),
                [10] =  vec3(4459.22,7582.91,709.55),
                [11] =  vec3(4475.78,7582.04,711.9),
                [12] =  vec3(4474.9,7604.95,716.61),
                [13] =  vec3(4463.78,7609.07,715.78),
                [14] =  vec3(4447.14,7610.87,711.89),
                [15] =  vec3(4435.64,7601.07,711.89),
                [16] =  vec3(4422.77,7594.49,711.89),
                [17] =  vec3(4428.95,7584.36,711.89),
                [18] =  vec3(4436.44,7592.91,711.9),
                [19] =  vec3(4440.82,7581.88,715.04),
                [20] =  vec3(4438.65,7568.3,711.9),
                [21] =  vec3(4455.34,7560.39,710.34),
                [22] =  vec3(4445.35,7554.33,711.9),
                [23] =  vec3(4461.12,7546.73,711.9),
                [24] =  vec3(4463.32,7534.49,711.9),
                [25] =  vec3(4431.39,7534.99,710.35),
                [26] =  vec3(4425.1,7538.55,710.35),
                [27] =  vec3(4419.8,7550.19,711.15),
                [28] =  vec3(4406.39,7558.17,711.15),
                [29] =  vec3(4417.76,7562.92,711.15),
                [30] =  vec3(4411.84,7576.04,711.15),
                [31] =  vec3(4399.55,7570.84,711.15),
                [32] =  vec3(4426.58,7572.39,710.34),
                [33] =  vec3(4423.82,7573.19,711.89),
            },

            ['teams'] = {
                ['ct'] = {
                    [1] = vec3(4439.11,7614.57,711.89),
                    [2] = vec3(4437.26,7613.2,711.89),
                    [3] = vec3(4435.67,7612.45,711.89),
                    [4] = vec3(4436.15,7614.27,711.89),
                    [5] = vec3(4438.48,7614.8,711.89),
                    [6] = vec3(4441.5,7614.0,711.89),
                },

                ['tr'] = {
                    [1] = vec3(4454.18,7529.66,711.9),
                    [2] = vec3(4456.46,7529.69,711.9),
                    [3] = vec3(4458.22,7530.61,711.9),
                    [4] = vec3(4458.23,7528.91,711.9),
                    [5] = vec3(4456.08,7528.12,711.9),
                    [6] = vec3(4453.86,7527.54,711.9),
                }
            }
        }
    },

    ['treatro'] = { 
        image = 'http://177.54.148.31:4020/lotus/pvp_mapas/treatro.png', 
        spawns = {
            ['ffa'] = {
                [1] = vec3(-1043.98,-522.54,36.04),
                [2] = vec3(-1181.6,-495.16,35.57),
                [3] = vec3(-1186.43,-460.36,33.87),
                [4] = vec3(-1219.56,-499.68,31.19),
                [5] = vec3(-1122.51,-553.8,32.37),
                [6] = vec3(-1132.7,-431.3,36.16),
                [7] = vec3(-1150.29,-572.05,30.13),
            },

            ['gungame'] = {
                [1] = vec3(-1043.98,-522.54,36.04),
                [2] = vec3(-1181.6,-495.16,35.57),
                [3] = vec3(-1186.43,-460.36,33.87),
                [4] = vec3(-1219.56,-499.68,31.19),
                [5] = vec3(-1122.51,-553.8,32.37),
                [6] = vec3(-1132.7,-431.3,36.16),
                [7] = vec3(-1150.29,-572.05,30.13),
            },

            ['teams'] = {
                ['ct'] = {
                    [1] = vec3(-1188.63,-542.03,28.75),
                    [2] = vec3(-1187.92,-544.37,28.64),
                    [3] = vec3(-1186.28,-543.57,28.73),
                    [4] = vec3(-1186.74,-541.31,28.86),
                    [5] = vec3(-1188.47,-540.01,28.78),
                    [6] = vec3(-1190.65,-539.9,28.68),
                },

                ['tr'] = {
                    [1] = vec3(-1081.59,-476.74,36.65),
                    [2] = vec3(-1081.85,-474.34,36.63),
                    [3] = vec3(-1084.1,-474.38,36.6),
                    [4] = vec3(-1086.38,-476.69,36.6),
                    [5] = vec3(-1084.7,-479.28,36.67),
                    [6] = vec3(-1081.7,-478.5,36.67),
                }
            }
        }
    }
}

Config.Weapons = {
    ['rifle'] = {
        ['WEAPON_SPECIALCARBINE'] = 'Carabina Especial',
        ['WEAPON_SPECIALCARBINE_MK2'] = 'Carabina Especial MK2',
    },
    ['pistol'] = {
        ['WEAPON_PISTOL_MK2'] = 'Pistola MK2',
        ['WEAPON_COMBATPISTOL'] = 'Pistola de Combate'
    },
    ['sub'] = {
        ['WEAPON_COMBATPDW'] = 'PDW de Combate',
        ['WEAPON_MACHINEPISTOL'] = 'Pistola Automática'
    },
    ['shotgun'] = {
        ['WEAPON_PUMPSHOTGUN'] = 'Shotgun de Bomba',
        ['WEAPON_ASSAULTSHOTGUN'] = 'Shotgun de Assalto'
    },
    ['sniper'] = {
        ['WEAPON_SNIPERRIFLE'] = 'Rifle de Sniper',
        ['WEAPON_HEAVYSNIPER'] = 'Sniper Pesado',
        ['WEAPON_MARKSMANRIFLE'] = 'Rifle Marksman'
    },
    ['heavy'] = {
        ['WEAPON_GRENADELAUNCHER'] = 'Lançador de Granadas',
        ['WEAPON_RPG'] = 'RPG',
        ['WEAPON_MINIGUN'] = 'Minigun',
        ['WEAPON_FIREWORK'] = 'Lançador de Fogos de Artifício',
        ['WEAPON_RAILGUN'] = 'Railgun',
        ['WEAPON_HOMINGLAUNCHER'] = 'Lançador de Mísseis Teleguiados',
        ['WEAPON_GRENADE'] = 'Granada',
        ['WEAPON_STICKYBOMB'] = 'Bomba Adesiva',
        ['WEAPON_PROXMINE'] = 'Mina de Proximidade',
        ['WEAPON_PIPEBOMB'] = 'Bomba de Tubo',
        ['WEAPON_BZGAS'] = 'Gás BZ'
    },
    ['melee'] = {
        ['WEAPON_UNARMED'] = 'Desarmado',
        ['WEAPON_KNIFE'] = 'Faca',
        ['WEAPON_NIGHTSTICK'] = 'Cassetete',
        ['WEAPON_HAMMER'] = 'Martelo',
        ['WEAPON_BAT'] = 'Taco de Baseball',
        ['WEAPON_GOLFCLUB'] = 'Taco de Golfe',
        ['WEAPON_CROWBAR'] = 'Pé-de-Cabra',
        ['WEAPON_BOTTLE'] = 'Garrafa',
        ['WEAPON_DAGGER'] = 'Adaga',
        ['WEAPON_HATCHET'] = 'Machado',
        ['WEAPON_KNUCKLE'] = 'Dedo-de-Moça',
        ['WEAPON_MACHETE'] = 'Machete',
        ['WEAPON_SWITCHBLADE'] = 'Canivete',
        ['WEAPON_FLASHLIGHT'] = 'Lanterna'
    },
    ['throwable'] = {
        ['WEAPON_SMOKEGRENADE'] = 'Granada de Fumaça',
        ['WEAPON_FLARE'] = 'Sinalizador',
        ['WEAPON_MOLOTOV'] = 'Coquetel Molotov',
        ['WEAPON_STICKYBOMB'] = 'Bomba Adesiva'
    }
}

Config.Images = {
    [GetHashKey('WEAPON_SNSPISTOL_MK2')] = "WEAPON_SNSPISTOL_MK2",
    [GetHashKey('WEAPON_PISTOL_MK2')] = "WEAPON_PISTOL_MK2",
    [GetHashKey('WEAPON_GUSENBERG')] = "WEAPON_GUSENBERG",
    [GetHashKey('WEAPON_PISTOL50')] = "WEAPON_PISTOL50",
    [GetHashKey('WEAPON_PISTOL')] = "WEAPON_PISTOL",
    [GetHashKey('WEAPON_HEAVYPISTOL')] = "WEAPON_HEAVYPISTOL",
    [GetHashKey('WEAPON_REVOLVER')] = "WEAPON_REVOLVER",
    [GetHashKey('WEAPON_GADGETPISTOL')] = "WEAPON_GADGETPISTOL",
    [GetHashKey('WEAPON_HATCHET')] = "WEAPON_HATCHET",
    [GetHashKey('WEAPON_KNIFE')] = "WEAPON_KNIFE",
    [GetHashKey('WEAPON_DAGGER')] = "WEAPON_DAGGER",
    [GetHashKey('WEAPON_KNUCKLE')] = "WEAPON_KNUCKLE",
    [GetHashKey('WEAPON_MACHETE')] = "WEAPON_MACHETE",
    [GetHashKey('WEAPON_SWITCHBLADE')] = "WEAPON_SWITCHBLADE",
    [GetHashKey('WEAPON_WRENCH')] = "WEAPON_WRENCH",
    [GetHashKey('WEAPON_HAMMER')] = "WEAPON_HAMMER",
    [GetHashKey('WEAPON_GOLFCLUB')] = "WEAPON_GOLFCLUB",
    [GetHashKey('WEAPON_CROWBAR')] = "WEAPON_CROWBAR",
    [GetHashKey('WEAPON_FLASHLIGHT')] = "WEAPON_FLASHLIGHT",
    [GetHashKey('WEAPON_BAT')] = "WEAPON_BAT",
    [GetHashKey('WEAPON_BOTTLE')] = "WEAPON_BOTTLE",
    [GetHashKey('WEAPON_BATTLEAXE')] = "WEAPON_BATTLEAXE",
    [GetHashKey('WEAPON_POOLCUE')] = "WEAPON_POOLCUE",
    [GetHashKey('WEAPON_FLARE')] = "WEAPON_FLARE",
    [GetHashKey('WEAPON_MACHINEPISTOL')] = "WEAPON_MACHINEPISTOL",
    [GetHashKey('WEAPON_SMG_MK2')] = "WEAPON_SMG_MK2",
    [GetHashKey('WEAPON_SMG')] = "WEAPON_SMG",
    [GetHashKey('WEAPON_ASSAULTSMG')] = "WEAPON_ASSAULTSMG",
    [GetHashKey('WEAPON_MICROSMG')] = "WEAPON_MICROSMG",
    [GetHashKey('WEAPON_COMBATPDW')] = "WEAPON_COMBATPDW",
    [GetHashKey('WEAPON_MINISMG')] = "WEAPON_MINISMG",
    [GetHashKey('WEAPON_SAWNOFFSHOTGUN')] = "WEAPON_SAWNOFFSHOTGUN",
    [GetHashKey('WEAPON_PUMPSHOTGUN_MK2')] = "WEAPON_PUMPSHOTGUN_MK2",
    [GetHashKey('WEAPON_ASSAULTSHOTGUN')] = "WEAPON_ASSAULTSHOTGUN",
    [GetHashKey('WEAPON_BULLPUPSHOTGUN')] = "WEAPON_BULLPUPSHOTGUN",
    [GetHashKey('WEAPON_HEAVYSHOTGUN')] = "WEAPON_HEAVYSHOTGUN",
    [GetHashKey('WEAPON_DBSHOTGUN')] = "WEAPON_DBSHOTGUN",
    [GetHashKey('WEAPON_COMBATSHOTGUN')] = "WEAPON_COMBATSHOTGUN",
    [GetHashKey('WEAPON_ASSAULTRIFLE')] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey('WEAPON_ASSAULTRIFLE_MK2')] = "WEAPON_ASSAULTRIFLE_MK2",
    [GetHashKey('WEAPON_SPECIALCARBINE_MK2')] = "WEAPON_SPECIALCARBINE_MK2",
    [GetHashKey('WEAPON_DOUBLEACTION')] = "WEAPON_DOUBLEACTION",
    [GetHashKey('WEAPON_CARBINERIFLE')] = "WEAPON_CARBINERIFLE",
    [GetHashKey('WEAPON_CARBINERIFLE_MK2')] = "WEAPON_CARBINERIFLE_MK2",
    [GetHashKey('WEAPON_SPECIALCARBINE')] = "WEAPON_SPECIALCARBINE",
    [GetHashKey('WEAPON_ADVANCEDRIFLE')] = "WEAPON_ADVANCEDRIFLE",
    [GetHashKey('WEAPON_BULLPUPRIFLE')] = "WEAPON_BULLPUPRIFLE",
    [GetHashKey('WEAPON_BULLPUPRIFLE_MK2')] = "WEAPON_BULLPUPRIFLE_MK2",
    [GetHashKey('WEAPON_COMPACTRIFLE')] = "WEAPON_COMPACTRIFLE",
    [GetHashKey('WEAPON_HEAVYRIFLE')] = "WEAPON_HEAVYRIFLE",
    [GetHashKey('WEAPON_TACTICALRIFLE')] = "WEAPON_TACTICALRIFLE",
    [GetHashKey('WEAPON_MG')] = "WEAPON_MG",
    [GetHashKey('WEAPON_COMBATMG')] = "WEAPON_COMBATMG",
    [GetHashKey('WEAPON_COMBATMG_MK2')] = "WEAPON_COMBATMG_MK2",
    [GetHashKey('WEAPON_GUSENBERG')] = "WEAPON_GUSENBERG",
    [GetHashKey('WEAPON_SNIPERRIFLE')] = "WEAPON_SNIPERRIFLE",
    [GetHashKey('WEAPON_HEAVYSNIPER')] = "WEAPON_HEAVYSNIPER",
    [GetHashKey('WEAPON_HEAVYSNIPER_MK2')] = "WEAPON_HEAVYSNIPER_MK2",
    [GetHashKey('WEAPON_MARKSMANRIFLE')] = "WEAPON_MARKSMANRIFLE",
    [GetHashKey('WEAPON_MARKSMANRIFLE_MK2')] = "WEAPON_MARKSMANRIFLE_MK2",
    [GetHashKey('WEAPON_PRECISIONRIFLE')] = "WEAPON_PRECISIONRIFLE",
    [GetHashKey('WEAPON_STUNGUN')] = "WEAPON_STUNGUN",
}