----- Lojas de Departamento -----
Shops = {
    ['Loja de Bebidas'] = {
        mode = 'buy',
        items = {
            ['cerveja'] = 5000,
            ['absinto'] = 5000,
            ['whisky'] = 5000,
            ['conhaque'] = 5000,
            ['vodka'] = 5000,
            ['tequila'] = 5000
        },
        coords = {
              { coords = vec3(1184.08, -197.7, 62.41), blip = true },
              { coords = vec3(1003.72, -2550.38, 28.29), blip = true },
              { coords = vec3(128.33, -1285.3, 29.28), blip = true },
              { coords = vec3(4902.39, -4941.16, 3.35), blip = true },
              { coords = vec3(-465.41, 4392.95, 31.96), blip = true },
              { coords = vec3(-86.28, 826.61, 227.78), blip = true },
              { coords = vec3(-161.27, 905.99, 235.64), blip = true },
              { coords = vec3(-521.26, 510.16, 108.07), blip = true },
              { coords = vec3(-823.54, 265.5, 86.19), blip = true },
              { coords = vec3(-1990.9, -513.27, 25.9), blip = true },
              { coords = vec3(-2580.77, 1868.22, 163.8), blip = true },
              { coords = vec3(-11.88, 516.56, 174.63), blip = true },
              { coords = vec3(-2800.82, -18.22, 15.92), blip = true },
              { coords = vec3(1385.37, 4700.72, 134.83), blip = true },
              { coords = vec3(-3025.8, 60.8, 11.61), blip = true },
              { coords = vec3(-2977.45, 11.0, 6.76), blip = true },
              { coords = vec3(-2963.98, -52.6, 1.75), blip = true },
              { coords = vec3(-3020.2, 37.92, 10.11), blip = true },
              { coords = vec3(-1430.65, -1261.89, 3.49), blip = true },
              { coords = vec3(204.55, -1638.46, 33.38), blip = true },
              { coords = vec3(129.43,-1281.05,29.27), blip = true },

              { coords = vec3(700.69,-273.74,59.53), blip = false }, -- Mexico
              { coords = vec3(-1510.0,847.44,181.59), blip = false }, -- Vaticano
              { coords = vec3(735.21,3426.08,57.88), blip = false },
              { coords = vec3(1633.23,-2635.31,49.98), blip = false },
              { coords = vec3(39.53,6566.51,23.08), blip = false },
        }
    },

    ['Ammunation'] = {
        mode = 'buy',
        items = {
            ["scubagear"] = 500,
            ["weapon_knife"] = 1000000,
            ["weapon_dagger"] = 1000000,
            ["weapon_knuckle"] = 1000000,
            ["weapon_machete"] = 1000000,
            ["weapon_switchblade"] = 1000000,
            ["weapon_wrench"] = 1000000,
            ["weapon_hammer"] = 1000000,
            ["weapon_golfclub"] = 1000000,
            ["weapon_hatchet"] = 1000000,
            ["weapon_flashlight"] = 1000000,
            ["weapon_bat"] = 1000000,
            ["weapon_bottle"] = 1000000,
            ["weapon_battleaxe"] = 1000000,
            ["weapon_poolcue"] = 1000000,
            ["gadget_parachute"] = 100000,
        },
        coords = {
            { coords = vec3(1692.62,3759.50,34.70) },
            { coords = vec3(252.89,-49.25,69.94)   },
            { coords = vec3(843.28,-1034.02,28.19) },
            { coords = vec3(-331.35,6083.45,31.45) },
            { coords = vec3(-663.15,-934.92,21.82) },
            { coords = vec3(-1305.18,-393.48,36.69)},
            { coords = vec3(-1118.80,2698.22,18.55)},
            { coords = vec3(2568.83,293.89,108.73) },
            { coords = vec3(-3172.68,1087.10,20.83)},
            { coords = vec3(21.32,-1106.44,29.79)  },
            { coords = vec3(811.19,-2157.67,29.61) },
        }
    },

    ['Peixes'] = {
        mode = 'sell',
        blip = { index = 277, color = 0,  text = "Venda de Peixes" },
        items = {
            ["tilapia"] = 750,
            ["pacu"] = 750,
            ["tucunare"] = 750,
            ["salmao"] = 750,
            ["dourado"] = 750,
        },
        coords = {
            { coords = vec3(-1817.08,-1193.61,14.31), blip = true },
        }
    },

    ['Peixes AFK'] = {
        mode = 'sell',
        blip = { index = 277, color = 0,  text = "Venda de Peixes" },
        items = {
            ["pirarucu"] = 50000,
            ["piranha"] = 25000,
        },
        coords = {
            { coords = vec3(1300.49,4319.5,38.18), blip = true },
        }
    },
    ['Itens Peixe'] = {
        mode = 'buy',
        items = {
            ["vara"] = 50000,
            ["isca"] = 1000,
        },
        coords = {
            { coords = vec3(1332.68,4325.29,38.08) },
        }
    },

    ['Joalheria'] = {
        mode = 'sell',
        items = {
            ["bronze"] = 550,
            ["safira"] = 650,
            ["rubi"] = 600,
            ["ouro"] = 500,
        },
        coords = {
            {coords = vec3(2954.18,2743.36,43.61)}, 
        }
    },

    ['Graos'] = {
        mode = 'sell',
        items = {
            ["graosimpuros"] = 200,
        },
        coords = {
            { coords = vec3(-112.49,2818.82,53.16) }, 
        }
    },

    ['Tartarugas'] = {
        mode = 'sell',
        items = {
            ["tomate"] = 3000,
        },
        coords = {
              {coords = vec3(3725.21,4525.16,22.48)}, 
        }
    },

    ['Quitanda'] = {
        mode = 'sell',
        items = {
            ["tomate"] = 350,
            ["laranja"] = 500,
        },
        coords = {
            {coords = vec3(1785.64,4591.1,37.68)}, 
        }
    },

    ['Farmacia'] = {
        mode = 'buy',
        perm = 'perm.chamadoshp',
        items = {
            ['bandagem'] = 10000,

        },
        coords = {
            { coords = vec3(-1278.63,321.5,69.51) },
        }
    },

    ['Farmacia3'] = {
        mode = 'buy',
        perm = 'perm.chamadoshp',
        items = {
            ['bandagem'] = 5000,
            ['celular'] = 3000,
            ['radio'] = 2000,
            ['roupas'] = 10000,

        },
        coords = {
            { coords = vec3(-358.29,6114.22,31.44) },
            { coords = vec3(-1614.4,-826.9,10.18) },
        }
    },

    ['FarmaciaFree'] = {
        mode = 'buy',
        items = {
            ['bandagem'] = 20000,

        },
        coords = {
            { coords = vec3(-1275.12,325.05,65.5) },
            { coords = vec3(-530.95,-595.04,30.43) },
        }
    },

    ['Farmacia2'] = {
        mode = 'buy',
        items = {
            ['anticoncepcional'] = 1000,
            ['camisinha'] = 1000,
            ['dorflex'] = 1000,
            ['paracetamol'] = 1000,
            ['cataflan'] = 1000,
            ['riopan'] = 1000,
            ['luftal'] = 1000,
            ['amoxilina'] = 1000,
            ['clozapina'] = 1000,
            ['fluoxetina'] = 1000,
            ['rivotril'] = 1000,
            ['cicatricure'] = 1000,

        },
        coords = {
            { coords = vec3(92.33,-229.58,54.66) },
            { coords = vec3(-176.42,6383.61,31.49) },
            { coords = vec3(-508.39,290.46,83.39) },
            { coords = vec3(318.49,-1076.99,29.47) },
        }
    },

    ['Mercado'] = {
        mode = 'buy',
        items = {
            ['repairkit3'] = 25000,
            ['pneus'] = 5000,
            ['mochila'] = 6000,
            ['radio'] = 2000,
            ['celular'] = 3000,
            ['roupas'] = 10000,
            ['energetico'] = 15000,
            ['fireworks'] = 5000,
            ['alianca'] = 50000,
            ['isca'] = 200,
        },
        blip = { index = 52, color = 0,  text = "Mercado" }, 
        coords = {
            { coords = vec3(-47.52,-1756.85,29.42), blip = true },
            { coords = vec3(-1223.38,-907.15,12.32), blip = true },
            { coords = vec3(25.74,-1345.26,29.49), blip = true },
            { coords = vec3(1135.7,-981.79,46.41), blip = true },
            { coords = vec3(1163.53,-323.54,69.2), blip = true },
            { coords = vec3(374.19,327.5,103.56), blip = true },
            { coords = vec3(2555.35,382.16,108.62), blip = true },
            { coords = vec3(2676.76,3281.57,55.24), blip = true },
            { coords = vec3(1960.5,3741.84,32.34), blip = true },
            { coords = vec3(1393.23,3605.17,34.98), blip = true },
            { coords = vec3(1166.08,2709.24,38.15), blip = true },
            { coords = vec3(547.98,2669.75,42.15), blip = true },
            { coords = vec3(1698.3,4924.37,42.06), blip = true },
            { coords = vec3(1729.54,6415.76,35.03), blip = true },
            { coords = vec3(-3243.9,1001.4,12.83), blip = true },
            { coords = vec3(-2968.0,390.8,15.04), blip = true },
            { coords = vec3(-3041.17,585.16,7.9), blip = true },
            { coords = vec3(-1820.55,792.77,138.11), blip = true },
            { coords = vec3(-1486.87,-379.77,40.16), blip = true },
            { coords = vec3(-707.4,-913.68,19.21), blip = true },

            { coords = vec3(-1518.76,111.53,55.64), blip = false },
            { coords = vec3(-1658.84,-260.65,55.13), blip = false },
            { coords = vec3(782.18,-252.72,73.57), blip = false },
            { coords = vec3(1217.6,-220.86,70.67), blip = false },
            { coords = vec3(1345.71,-680.14,84.69), blip = false },
            { coords = vec3(-1670.29,593.1,156.64), blip = false },
            { coords = vec3(997.84,-108.25,73.97), blip = false },
            { coords = vec3(962.62,50.18,74.98), blip = false },
            { coords = vec3(-3046.06,104.62,12.35), blip = false },
            { coords = vec3(399.55,-18.51,91.93), blip = false },
            { coords = vec3(700.46,-303.5,59.24), blip = false }, -- Mexico
            { coords = vec3(-1382.96,-586.5,30.31), blip = false }, -- Bahamas
            { coords = vec3(-103.47,992.09,235.75), blip = false }, -- Pcc
            { coords = vec3(-1526.92,837.21,181.59), blip = false }, -- Vaticano
            { coords = vec3(953.5,26.27,76.99), blip = false }, -- Cassino
            { coords = vec3(735.99,-1081.16,22.16), blip = false }, -- Lacoste
            { coords = vec3(1415.64,1161.51,114.68), blip = false },
            { coords = vec3(2731.14,3478.57,55.25), blip = false },
            { coords = vec3(753.72,-566.28,33.63), blip = false },
            { coords = vec3(1410.77,-769.72,67.23), blip = false },
            { coords = vec3(-2206.82,-416.7,13.82), blip = false },
            { coords = vec3(-570.18,-208.53,38.22), blip = false },
            { coords = vec3(-1039.7,302.3,66.99), blip = false },
            { coords = vec3(-1602.36,-843.79,10.18), blip = false },
            { coords = vec3(906.36,344.79,112.37), blip = false },
            { coords = vec3(787.51,3422.6,57.88), blip = false },
            { coords = vec3(-351.29,-172.39,39.01), blip = false },
            { coords = vec3(941.42,-933.98,42.95), blip = false },
            { coords = vec3(-1889.09,2063.44,145.57), blip = false },
            { coords = vec3(-176.66,-1285.12,31.29), blip = false },
            { coords = vec3(36.22,6563.17,23.08), blip = false },
            { coords = vec3(-1231.75,6929.56,20.47), blip = false },
            { coords = vec3(1606.04,-2624.1,53.28), blip = false },
            { coords = vec3(-992.01,-1467.57,5.04), blip = false },
            { coords = vec3(-629.32,-1634.69,26.03), blip = false },
            { coords = vec3(-1382.96,-586.5,30.31), blip = false },
            { coords = vec3(-2679.89,1313.23,147.44), blip = false },
            { coords = vec3(-807.69,181.09,72.15), blip = false },
            { coords = vec3(-2189.8,-267.28,36.13), blip = false },
            { coords = vec3(755.95,-551.6,33.63), blip = false },
            { coords = vec3(74.85,-1727.19,29.6), blip = false },
            { coords = vec3(-339.23,-1539.46,27.72), blip = false },
            { coords = vec3(-923.44,-2036.18,9.4), blip = false },
            { coords = vec3(359.13,-1589.85,29.28), blip = false },
            { coords = vec3(-2031.61,-450.14,12.27), blip = false },
            { coords = vec3(-534.48,-601.38,30.43), blip = false },
            { coords = vec3(2628.19,5299.94,47.52), blip = false },
            { coords = vec3(-1392.76,-602.16,36.51), blip = false },
            { coords = vec3(-314.22,-1637.64,32.3), blip = false },
            { coords = vec3(2628.19,5299.94,47.52), blip = false },
            { coords = vec3(-810.56,-1228.08,6.86), blip = false },
            { coords = vec3(-828.92,-727.0,28.05), blip = false },
        }
    },

    ['Mecanica'] = {
        mode = 'buy',
        perm = 'perm.arrastarmecanica',
        items = {
            ['repairkit3'] = 15000,
            ['kitnitro'] = 250000,
        },
        blip = { index = 52, color = 0,  text = "Loja Mecânica" }, 
        coords = {
            { coords = vec3(451.69,-1286.22,29.34), blip = false },
            { coords = vec3(842.83,-981.5,26.49), blip = false },
            { coords = vec3(-344.69,-155.89,44.58), blip = false },
        }
    },

    ['Bombeiro'] = {
        mode = 'buy',
        perm = 'perm.bombeiro',
        items = {
            ['scubagear'] = 50,
            ['GADGET_PARACHUTE'] = 1000,
            ['bandagem'] = 10000,
        },
        coords = {
              { coords = vec3(1193.99,-1487.94,34.85), blip = false },
        }
    },

    ['Judiciario'] = {
        mode = 'buy',
        perm = 'perm.judiciario',
        items = {
            ['notafiscalarma'] = 10000,
            ['notafiscalmunicao'] = 10000,
            ['notafiscallavagem'] = 10000,
            ['notafiscaldroga'] = 10000,
            ['notafiscaldesmanche'] = 10000,
        },
        coords = {
            { coords = vec3(-556.08,-185.1,39.02), blip = false },
        }
    },
}
