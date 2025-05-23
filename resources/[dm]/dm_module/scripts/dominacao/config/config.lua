DominationConfig = {
    saveDB = true, -- Salvar no banco de dados
    delayDeath = 40, -- COOLDOWN DE DELAY D EMORTES

    Zones = {
        {
            name = 'fMunicao',

            time = 15, -- em minuto(s)
            cooldown = 240, -- em minuto(s)

            blip = vec3(132.27,-3102.06,5.9),
            polyzone = { -- CORDENADAS DA ZONA DE DOMINAÇÃO ( LIGUE OS PONTOS EM LINHA RETAS SEM CRUZAR )
                vec3(105.25,-3342.09,6.4),
                vec3(300.02,-3342.61,6.4),
                vec3(300.41,-3267.13,6.18),
                vec3(312.06,-3266.75,6.23),
                vec3(312.42,-2956.16,6.37),
                vec3(319.78,-2955.5,6.4),
                vec3(320.87,-2845.83,6.39),
                vec3(340.7,-2848.09,6.56),
                vec3(385.81,-2795.06,6.54),
                vec3(385.84,-2621.6,6.4),
                vec3(322.63,-2622.79,6.01),
                vec3(264.41,-2615.12,6.01),
                vec3(227.78,-2601.62,6.1),
                vec3(153.71,-2601.05,6.02),
                vec3(154.83,-2667.01,6.54),
                vec3(185.87,-2666.87,6.54),
                vec3(186.01,-2766.22,6.4),
                vec3(152.64,-2768.73,6.13),
                vec3(124.98,-2798.62,6.01),
                vec3(107.02,-2812.93,6.4),
                vec3(105.42,-3341.99,6.37)
            },
        },

        {
            name = 'fArmas',

            time = 15, -- em minuto(s)
            cooldown = 240, -- em minuto(s)
            
            blip = vec3(576.53,-3111.69,6.07),
            polyzone = { -- CORDENADAS DA ZONA DE DOMINAÇÃO ( LIGUE OS PONTOS EM LINHA RETAS SEM CRUZAR )
                vec3(642.91,-2678.59,6.1),
                vec3(652.16,-2699.55,6.12),
                vec3(660.26,-2719.21,6.13),
                vec3(663.28,-2727.24,6.12),
                vec3(665.58,-2733.82,6.12),
                vec3(667.56,-2741.35,6.17),
                vec3(669.71,-2749.55,6.15),
                vec3(673.07,-2762.48,6.11),
                vec3(675.63,-2768.35,6.01),
                vec3(676.73,-2799.64,5.95),
                vec3(676.55,-2816.08,6.09),
                vec3(676.52,-2840.66,6.18),
                vec3(676.39,-2857.63,6.31),
                vec3(676.41,-2868.24,6.33),
                vec3(676.37,-2879.73,6.35),
                vec3(676.29,-2906.23,6.33),
                vec3(678.11,-2907.48,6.39),
                vec3(678.3,-2915.29,6.35),
                vec3(678.91,-3026.65,6.04),
                vec3(677.75,-3026.48,6.27),
                vec3(677.9,-3126.22,6.79),
                vec3(679.53,-3126.25,6.79),
                vec3(679.04,-3159.79,6.54),
                vec3(683.39,-3185.97,6.61),
                vec3(694.28,-3202.36,6.61),
                vec3(662.54,-3251.6,14.96),
                vec3(638.24,-3317.09,22.96),
                vec3(510.94,-3331.33,6.17),
                vec3(511.14,-3390.51,6.27),
                vec3(467.14,-3390.54,6.27),
                vec3(467.1,-3286.68,6.28),
                vec3(458.56,-3286.85,6.28),
                vec3(458.47,-3281.41,6.28),
                vec3(458.47,-3246.57,6.28),
                vec3(458.3,-3246.23,6.54),
                vec3(447.87,-3246.34,6.28),
                vec3(440.85,-3239.43,6.28),
                vec3(440.73,-3187.42,6.27),
                vec3(440.76,-3187.17,6.27),
                vec3(447.56,-3180.3,6.27),
                vec3(458.47,-3180.29,6.27),
                vec3(458.29,-3117.68,6.27),
                vec3(440.77,-3117.86,6.27),
                vec3(440.75,-2926.88,6.28),
                vec3(440.74,-2926.58,6.28),
                vec3(418.98,-2926.53,12.8),
                vec3(416.35,-2896.68,9.73),
                vec3(569.49,-2899.04,10.05),
                vec3(572.84,-2898.92,6.08),
                vec3(572.94,-2867.71,6.44),
                vec3(544.67,-2851.08,6.46),
                vec3(538.15,-2862.31,6.48),
                vec3(523.87,-2854.12,6.44),
                vec3(523.99,-2853.61,6.44),
                vec3(530.19,-2843.2,6.44),
                vec3(443.49,-2792.56,6.7),
                vec3(440.44,-2785.85,6.7),
                vec3(441.2,-2737.93,6.7),
                vec3(441.64,-2726.66,6.7),
                vec3(441.5,-2714.06,6.7),
                vec3(441.51,-2706.06,6.7),
                vec3(490.29,-2705.37,6.06),
                vec3(516.67,-2701.66,6.06),
                vec3(543.59,-2701.95,6.06),
                vec3(557.19,-2702.11,6.06),
                vec3(588.99,-2701.94,6.06),
                vec3(602.64,-2696.52,6.1),
                vec3(613.94,-2691.37,6.09),
                vec3(626.08,-2686.09,6.09),
                vec3(635.16,-2682.07,6.1),
                vec3(642.32,-2678.86,6.1)
            },
        },

        {
            name = 'Drogas',

            time = 15, -- em minuto(s)
            cooldown = 240, -- em minuto(s)

            blip = vec3(711.62,590.3,129.05),
            polyzone = { -- CORDENADAS DA ZONA DE DOMINAÇÃO ( LIGUE OS PONTOS EM LINHA RETAS SEM CRUZAR )
                vec3(518.53,542.25,173.36),
                vec3(534.66,490.4,166.93),
                vec3(583.02,455.72,162.68),
                vec3(680.83,428.71,150.67),
                vec3(754.48,443.82,147.5),
                vec3(788.18,485.88,135.65),
                vec3(846.24,486.68,130.27),
                vec3(857.87,496.86,126.66),
                vec3(885.69,607.4,147.31),
                vec3(843.87,634.75,142.81),
                vec3(787.83,657.24,143.77),
                vec3(725.84,713.38,169.14),
                vec3(688.04,714.49,166.91),
                vec3(602.05,696.51,161.72),
                vec3(551.49,640.71,154.2),
                vec3(514.47,610.55,163.52),
                vec3(508.9,552.72,170.99),
                vec3(518.12,542.74,173.37)
            },

            reward = function(user_id)
                vRP.giveInventoryItem(user_id, 'lsd', math.random(400,800), true)
            end,
        },

       {
           name = 'fDesmanche',

           time = 15, -- em minuto(s)
           cooldown = 240, -- em minuto(s)

           blip = vec3(-527.3,5292.22,74.17),
           polyzone = { -- CORDENADAS DA ZONA DE DOMINAÇÃO ( LIGUE OS PONTOS EM LINHA RETAS SEM CRUZAR )
                vec3(-559.92523193359, 5255.4448242188,94.06),
                vec3(-565.86206054688, 5257.041015625,94.06),
                vec3(-581.26062011719, 5264.7705078125,94.06),
                vec3(-591.41137695313, 5275.4384765625,94.06),
                vec3(-597.04217529297, 5276.4467773438,94.06),
                vec3(-604.77612304688, 5269.6552734375,94.06),
                vec3(-609.55023193359, 5274.3505859375,94.06),
                vec3(-602.58056640625, 5280.7680664063,94.06),
                vec3(-605.91259765625, 5282.2866210938,94.06),
                vec3(-609.14715576172, 5285.6533203125,94.06),
                vec3(-612.66748046875, 5297.3715820313,94.06),
                vec3(-612.16906738281, 5306.2358398438,94.06),
                vec3(-611.58142089844, 5309.322265625,94.06),
                vec3(-609.86315917969, 5342.794921875,94.06),
                vec3(-608.79071044922, 5370.26953125,94.06),
                vec3(-601.05865478516, 5372.1323242188,94.06),
                vec3(-576.66668701172, 5380.9204101563,94.06),
                vec3(-571.15179443359, 5383.4106445313,94.06),
                vec3(-554.31372070313, 5405.2138671875,94.06),
                vec3(-553.89001464844, 5409.6254882813,94.06),
                vec3(-546.78662109375, 5409.0258789063,94.06),
                vec3(-546.77075195313, 5403.0502929688,94.06),
                vec3(-535.07830810547, 5400.8173828125,94.06),
                vec3(-508.36193847656, 5401.0366210938,94.06),
                vec3(-489.18475341797, 5401.125,94.06),
                vec3(-473.66201782227, 5405.3525390625,94.06),
                vec3(-459.82525634766, 5411.2993164063,94.06),
                vec3(-445.01501464844, 5417.5932617188,94.06),
                vec3(-442.58395385742, 5418.685546875,94.06),
                vec3(-419.43832397461, 5415.3286132813,94.06),
                vec3(-471.26928710938, 5224.4609375,94.06)
            },
       },

       {
        name = 'fLavagem',

        time = 15, -- em minuto(s)
        cooldown = 240, -- em minuto(s)

        blip = vec3(-461.31,-2662.73,8.76),
        polyzone = { -- CORDENADAS DA ZONA DE DOMINAÇÃO ( LIGUE OS PONTOS EM LINHA RETAS SEM CRUZAR )
            vec3(-509.3,-2942.58,6.38),
            vec3(-426.27,-2863.27,6.37),
            vec3(-413.11,-2862.98,6.38),
            vec3(-389.21,-2838.81,6.38),
            vec3(-374.16,-2848.39,2.93),
            vec3(-354.2,-2828.41,2.93),
            vec3(-363.52,-2818.85,2.93),
            vec3(-367.26,-2817.0,6.38),
            vec3(-352.29,-2801.81,6.38),
            vec3(-277.81,-2790.14,5.0),
            vec3(-277.82,-2771.37,5.0),
            vec3(-304.93,-2770.96,5.0),
            vec3(-305.23,-2762.95,5.0),
            vec3(-311.91,-2762.97,5.0),
            vec3(-343.45,-2759.86,6.04),
            vec3(-325.35,-2758.54,6.14),
            vec3(-254.85,-2688.59,6.19),
            vec3(-198.72,-2686.92,5.75),
            vec3(-197.33,-2722.42,5.75),
            vec3(-197.73,-2727.18,5.75),
            vec3(-167.34,-2727.72,6.29),
            vec3(-172.25,-2516.99,6.15),
            vec3(-206.83,-2516.01,6.15),
            vec3(-206.88,-2537.48,6.1),
            vec3(-270.11,-2538.31,6.01),
            vec3(-281.56,-2551.53,6.01),
            vec3(-288.43,-2552.57,6.01),
            vec3(-449.95,-2416.46,6.44),
            vec3(-469.39,-2439.04,6.44),
            vec3(-335.47,-2550.8,5.76),
            vec3(-332.2,-2559.03,6.76),
            vec3(-366.08,-2592.99,6.0),
            vec3(-393.02,-2572.01,6.15),
            vec3(-524.17,-2705.8,6.0),
            vec3(-503.61,-2728.93,6.4),
            vec3(-535.94,-2761.15,6.4),
            vec3(-525.76,-2771.6,6.4),
            vec3(-571.78,-2818.18,6.41),
            vec3(-512.56,-2942.05,6.38),
            vec3(-509.61,-2942.71,6.38)
        },
    },
    },

    FormatNames = {
        -- ['fGeral'] = 'Geral', 
        ['fArmas'] = 'Armas', 
        ['fMunicao'] = 'Municao', 
        ['fDesmanche'] = 'Desmanche', 
        ['fLavagem'] = 'Lavagem', 
        ['Drogas'] = 'Drogas', 
    }
}