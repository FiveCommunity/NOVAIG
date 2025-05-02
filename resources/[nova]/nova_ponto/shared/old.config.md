RANKING_UPDATE_INTERVAL = 300 --[[seconds]]
ADMIN_PERMISSION        = "admin.permissao"

Config                  = {}



-- default
-- this will automatically insert into db
Config.Clothes = {

    ["CoronelPM"] = {
        org = 'Policia',
        male = {
            [1] = { 0, 0, 2 },
            [3] = { 1, 0, 2 },
            [4] = { 59, 9, 2 },
            [6] = { 25, 0, 2 },
            [7] = { 15, 0, 2 },
            [8] = { 15, 0, 2 },
            [9] = { 18, 4, 2 },
            [11] = { 220, 0, 2 },
            ["p0"] = { -1, 0 },
            ["p6"] = { -1, 0 }
        },
        female = {
            [1] = { -1, 0, 2 },
            [3] = { 1, 0, 2 },
            [4] = { 32, 0, 2 },
            [6] = { 25, 0, 2 },
            [7] = { -1, 0, 2 },
            [8] = { -1, 0, 2 },
            [9] = { 36, 0, 2 },
            [11] = { 230, 0, 2 },
            ["p6"] = { -1, 0 },
            ["p0"] = { -1, 0 }
        }
    },
    ["MajorPM"] = {
        org = 'Policia',
        male = {
            [1] = { 0, 0, 2 },
            [3] = { 1, 0, 2 },
            [4] = { 59, 9, 2 },
            [6] = { 25, 0, 2 },
            [7] = { 15, 0, 2 },
            [8] = { 15, 0, 2 },
            [9] = { 18, 0, 2 },
            [11] = { 220, 0, 2 },
            ["p0"] = { -1, 0 },
            ["p6"] = { -1, 0 }
        },
        female = {
            [1] = { -1, 0, 2 },
            [3] = { 1, 0, 2 },
            [4] = { 32, 0, 2 },
            [6] = { 25, 0, 2 },
            [7] = { -1, 0, 2 },
            [8] = { -1, 0, 2 },
            [9] = { 36, 0, 2 },
            [11] = { 230, 0, 2 },
            ["p6"] = { -1, 0 },
            ["p0"] = { -1, 0 }
        }
    },
    ["CapitaoPM"] = {
        org = 'Policia',
        male = {
            [1] = { 0, 0, 2 },
            [3] = { 1, 0, 2 },
            [4] = { 59, 9, 2 },
            [6] = { 25, 0, 2 },
            [7] = { 15, 0, 2 },
            [8] = { 15, 0, 2 },
            [9] = { 18, 0, 2 },
            [11] = { 220, 0, 2 },
            ["p0"] = { -1, 0 },
            ["p6"] = { -1, 0 }
        },
        female = {
            [1] = { -1, 0, 2 },
            [3] = { 1, 0, 2 },
            [4] = { 32, 0, 2 },
            [6] = { 25, 0, 2 },
            [7] = { -1, 0, 2 },
            [8] = { -1, 0, 2 },
            [9] = { 36, 0, 2 },
            [11] = { 230, 0, 2 },
            ["p6"] = { -1, 0 },
            ["p0"] = { -1, 0 }
        }
    },
    ["PrimeiroTenentePM"] = {
        org = 'Policia',
        male = {
            [1] = { 0, 0, 2 },
            [3] = { 1, 0, 2 },
            [4] = { 59, 9, 2 },
            [6] = { 25, 0, 2 },
            [7] = { 15, 0, 2 },
            [8] = { 15, 0, 2 },
            [9] = { 18, 0, 2 },
            [11] = { 220, 0, 2 },
            ["p0"] = { -1, 0 },
            ["p6"] = { -1, 0 }
        },
        female = {
            [1] = { -1, 0, 2 },
            [3] = { 1, 0, 2 },
            [4] = { 32, 0, 2 },
            [6] = { 25, 0, 2 },
            [7] = { -1, 0, 2 },
            [8] = { -1, 0, 2 },
            [9] = { 36, 0, 2 },
            [11] = { 230, 0, 2 },
            ["p6"] = { -1, 0 },
            ["p0"] = { -1, 0 }
        }
    },
    ["PrimeiroSargentoPM"] = {
        org = 'Policia',
        male = {
            [1] = { 0, 0, 2 },
            [3] = { 1, 0, 2 },
            [4] = { 59, 9, 2 },
            [6] = { 25, 0, 2 },
            [7] = { 15, 0, 2 },
            [8] = { 15, 0, 2 },
            [9] = { 18, 0, 2 },
            [11] = { 220, 0, 2 },
            ["p0"] = { -1, 0 },
            ["p6"] = { -1, 0 }
        },
        female = {
            [1] = { -1, 0, 2 },
            [3] = { 1, 0, 2 },
            [4] = { 32, 0, 2 },
            [6] = { 25, 0, 2 },
            [7] = { -1, 0, 2 },
            [8] = { -1, 0, 2 },
            [9] = { 36, 0, 2 },
            [11] = { 230, 0, 2 },
            ["p6"] = { -1, 0 },
            ["p0"] = { -1, 0 }
        }
    },
    ["SoldadoPM"] = {
        org = 'Policia',
        male = {
            [1] = { -1, 0, 2 },
            [3] = { 0, 0, 2 },
            [4] = { 59, 9, 2 },
            [6] = { 25, 0, 2 },
            [7] = { -1, 0, 2 },
            [8] = { 130, 0, 2 },
            [9] = { 18, 0, 2 },
            [11] = { 271, 1, 2 },
            ["p6"] = { 5, 0 },
            ["p0"] = { -1, 0 }
        },
        female = {
            [1] = { -1, 0, 2 },
            [3] = { 1, 0, 2 },
            [4] = { 32, 0, 2 },
            [6] = { 25, 0, 2 },
            [7] = { -1, 0, 2 },
            [8] = { -1, 0, 2 },
            [9] = { 36, 0, 2 },
            [11] = { 230, 0, 2 },
            ["p6"] = { -1, 0 },
            ["p0"] = { -1, 0 }
        }
    },
    ["CaboPM"] = {
        org = 'Policia',
        male = {
            [1] = { -1, 0, 2 },
            [3] = { 0, 0, 2 },
            [4] = { 59, 9, 2 },
            [6] = { 25, 0, 2 },
            [7] = { -1, 0, 2 },
            [8] = { 130, 0, 2 },
            [9] = { 18, 0, 2 },
            [11] = { 271, 1, 2 },
            ["p6"] = { 5, 0 },
            ["p0"] = { -1, 0 }
        },
        female = {
            [1] = { -1, 0, 2 },
            [3] = { 1, 0, 2 },
            [4] = { 32, 0, 2 },
            [6] = { 25, 0, 2 },
            [7] = { -1, 0, 2 },
            [8] = { -1, 0, 2 },
            [9] = { 36, 0, 2 },
            [11] = { 230, 0, 2 },
            ["p6"] = { -1, 0 },
            ["p0"] = { -1, 0 }
        }
    },
    ["AlunoPM"] = {
        org = 'Policia',
        male = {
            [1] = { 59, 2, 2 },
            [3] = { 0, 0, 2 },
            [4] = { 59, 9, 2 },
            [6] = { 25, 0, 2 },
            [7] = { -1, 0, 2 },
            [8] = { -1, 0, 2 },
            [9] = { -1, 0, 2 },
            [11] = { 271, 0, 2 },
            ["p0"] = { -1, 0 },
            ["p6"] = { -1, 0 }
        },
        female = {
            [1] = { -1, 0, 2 },
            [3] = { 1, 0, 2 },
            [4] = { 32, 0, 2 },
            [6] = { 25, 0, 2 },
            [7] = { -1, 0, 2 },
            [8] = { -1, 0, 2 },
            [9] = { 36, 0, 2 },
            [11] = { 230, 0, 2 },
            ["p6"] = { -1, 0 },
            ["p0"] = { -1, 0 }
        }
    },
}

-- easy insert
Config.Clothes["SegundoTenentePM"] = Config.Clothes["PrimeiroTenentePM"]
Config.Clothes["SubTenentePM"] = Config.Clothes["PrimeiroTenentePM"]
Config.Clothes["SegundoSargentoPM"] = Config.Clothes["PrimeiroSargentoPM"]
Config.Clothes["TerceiroSargentoPM"] = Config.Clothes["PrimeiroSargentoPM"]

Config.WeaponsKit = {
    ["Parafal"] = {
        name = "WEAPON_PARAFAL",
        ammo = 250
    },
    ["Glock"] = {
        name = "WEAPON_COMBATPISTOL",
        ammo = 250
    },
    ["SMG"] = {
        name = "WEAPON_SMG",
        ammo = 250
    },
    ["Taser"] = {
        name = "WEAPON_STUNGUN",
        ammo = 250
    }
}

Config.Orgs = {
    ["Policia"] = {
        coords = {
            vec3(-1659.19, 164.54, 61.77),
        },
        radioChannel = 100,
        groups = {
            ["CoronelPM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["TenenteCoronelPM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["MajorPM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["ComandoChoquePM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["ChoquePM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["ComandoGatePM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["GatePM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["ComandoSpeedPM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["SpeedPM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["ComandoRocamPM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["RocamPM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["ComandoGrpaePM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["GrpaePM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["CapitaoPM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["PrimeiroTenentePM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["SegundoTenentePM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["SubTenentePM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["PrimeiroSargentoPM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["SegundoSargentoPM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["TerceiroSargentoPM"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["CaboPM"] = {
                WeaponsKit = {  "Parafal", "Glock", "SMG" }
            },
            ["SoldadoPM"] = {
                WeaponsKit = { "Glock", "SMG" }
            },
            ["AlunoPM"] = {
                WeaponsKit = { "Glock", "SMG" }
            },
        }
    },
    ["Choque"] = {
        coords = {
            vec3(-1696.4, -753.36, 10.75),
        },
        radioChannel = 102,
        groups = {
            ["ComandanteGeralCHOQUE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["SubComandanteCHOQUE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["CoronelCHOQUE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["TenenteCoronelCHOQUE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["MajorCHOQUE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["CapitaoCHOQUE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["PrimeiroTenenteCHOQUE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["SegundoTenenteCHOQUE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["SubTenenteCHOQUE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["PrimeiroSargentoCHOQUE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["SegundoSargentoCHOQUE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["TerceiroSargenteCHOQUE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["CaboCHOQUE"] = {
                WeaponsKit = { "Glock", "SMG" }
            },
            ["SoldadoCHOQUE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["EstagiarioCHOQUE"] = {
                WeaponsKit = { "Glock", "SMG" }
            },
        }
    },
    ["Bope"] = {
        coords = {
            vec3(-1080.1, -823.42, 14.88),
        },
        radioChannel = 101,
        groups = {
            ["ComandanteGeralBOPE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["SubComandanteBOPE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["CoronelBope"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["TenenteCoronelBope"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["MajorBope"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["CapitaoBope"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["PrimeiroTenenteBope"] = {
                WeaponsKit = { "Glock", "SMG", "Parafal", "Taser" }
            },
            ["SegundoTenenteBope"] = {
                WeaponsKit = { "Glock", "SMG", "Parafal", "Taser" }
            },
            ["SubTenenteBope"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["PrimeiroSargentoBope"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["SegundoSargentoBope"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["TerceiroSargentoBope"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["CaboBope"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["SoldadoBope"] = {
                WeaponsKit = { "Glock", "SMG", "Taser" }
            },
            ["EstagiarioBope"] = {
                WeaponsKit = { "Glock", "SMG", "Taser" }
            },
        }
    },
    ["PoliciaCivil"] = {
        coords = {
            vec3(-423.65, 1082.51, 327.68),
        },
        radioChannel = 103,
        groups = {
            ["ComandoGeralCivil"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["DelegadoGeral"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["Delegado"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["Perito"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["RecrutadorCivil"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["ComandoDraco"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["SubComandoDraco"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["ComandoInvestigativa"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["SubComandoInvestigativa"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["Investigador"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["Agente"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["AgenteDraco"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["EstagiarioDraco"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["Recruta"] = {
                WeaponsKit = { "Glock", "SMG" }
            },
        }
    },
    ["PRF"] = {
        coords = {
            vec3(2599.96, 5338.04, 47.65),
        },
        radioChannel = 105,
        groups = {
            ["DiretorGeralPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["DiretorPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["SubDiretorPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["CorregedorGeralPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["SupervisorGeralPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["InspetorGeralPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["DelegadoGeralPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["CorregedorPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["SupervisorPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["DelegadoPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["InspetorPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["CorregedoriaGeral"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["Corregedoria"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["ComandoNoe"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["ComandoDoa"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["ComandoGtmPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["ComandoSpeedPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["ComandoInspetorPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["RecrutadorPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["AgenteOperacionalPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["AgentePrimeiraClassePRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["AgenteSegundaClassePRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["AgenteTerceiraClassePRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["EstagiarioPRF"] = {
                WeaponsKit = { "Glock", "SMG" }
            },
        }
    },
    ["PRF2"] = {
        coords = {
            vec3(-2632.29, 2618.64, 17.3),
        },
        radioChannel = 105,
        groups = {
            ["DiretorGeralPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["DiretorPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["SubDiretorPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["CorregedorGeralPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["SupervisorGeralPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["InspetorGeralPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["DelegadoGeralPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["CorregedorPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["SupervisorPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["DelegadoPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["InspetorPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["CorregedoriaGeral"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["Corregedoria"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["ComandoNoe"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["ComandoDoa"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["ComandoGtmPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["ComandoSpeedPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["ComandoInspetorPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["RecrutadorPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["AgenteOperacionalPRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["AgentePrimeiraClassePRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["AgenteSegundaClassePRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["AgenteTerceiraClassePRF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["EstagiarioPRF"] = {
                WeaponsKit = { "Glock", "SMG" }
            },
        }
    },
    ["PoliciaFederal"] = {
        coords = {
            vec3(-810.36, -1235.14, 6.86),
        },
        radioChannel = 104,
        groups = {
            ["DiretorGeralPF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["DiretorPF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["SubdiretorPF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["CorregedorGeralPF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["SupervisorGeralPF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["InspetorGeralPF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["DelegadoGeralPF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["CorregedorPF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["SupervisorPF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["DelegadoPF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["InspetorPF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["RecrutadorPF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["ComandoDeDivisaoPF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["AgenteOperacionalPF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["Agente1ClassePF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["Agente2ClassePF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["Agente3ClassePF"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["EstagiarioPF"] = {
                WeaponsKit = { "Glock", "SMG" }
            }
        }
    },
    ["Exercito"] = {
        coords = {
            vec3(-2175.61, 3174.89, 32.82),
        },
        radioChannel = 106,
        groups = {
            ["MarechalEXERCITO"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["GeneralEXERCITO"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["CoronelEXERCITO"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["TenenteCoronelEXERCITO"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["MajorEXERCITO"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["CapitaoEXERCITO"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["TenenteEXERCITO"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["SubtenenteEXERCITO"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["SargentoEXERCITO"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["CaboEXERCITO"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["SoldadoEXERCITO"] = {
                WeaponsKit = { "Glock", "SMG" }
            },
            ["RecrutaEXERCITO"] = {
                WeaponsKit = { "Glock", "SMG" }
            },
        }
    },
    ["Core"] = {
        coords = {
            vec3(-2047.63, -447.44, 12.27),
        },
        radioChannel = 111,
        groups = {
            ["ComandoCore"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["SubComandoCore"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["CoronelCORE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["TenenteCoronelCORE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["MajorCORE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["CapitaoCORE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["TenenteCORE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["SegundoTenenteCORE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["OficialCORE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["PrimeiroSargentoCORE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["SegundoSargentoCORE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["TerceiroSargentoCORE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["RecrutadorCORE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["CaboCORE"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["SoldadoCORE"] = {
                WeaponsKit = { "Glock", "SMG" , "Parafal" }
            },
            ["AlunoCORE"] = {
                WeaponsKit = { "Glock", "SMG" }
            },
        }
    },
    ["Race"] = {
        coords = {
            vec3(53.33, -1781.02, 29.28),
        },
        radioChannel = 110,
        groups = {
            ["Lider [Race]"] = {
                WeaponsKit = {} -- Defina as armas corretas aqui
            },
            ["Sub-Lider [Race]"] = {
                WeaponsKit = {}
            },
            ["Gerente [Race]"] = {
                WeaponsKit = {}
            },
            ["Supervisor [Race]"] = {
                WeaponsKit = {}
            },
            ["Recrutador [Race]"] = {
                WeaponsKit = {}
            },
            ["Membro [Race]"] = {
                WeaponsKit = {}
            },
            ["Novato [Race]"] = {
                WeaponsKit = {}
            },
        }
    },

    ["Hospital"] = {
        coords = {
            vec3(-1265.24, 326.92, 65.5),
        },
        radioChannel = 108,
        groups = {
            ["Diretor"] = {
                WeaponsKit = { "Taser" }
            },
            ["ViceDiretor"] = {
                WeaponsKit = { "Taser" }
            },
            ["Gestao"] = {
                WeaponsKit = { "Taser" }
            },
            ["Psiquiatra"] = {
                WeaponsKit = { "Taser" }
            },
            ["Medico"] = {
                WeaponsKit = {}
            },
            ["Enfermeiro"] = {
                WeaponsKit = {}
            },
            ["Socorrista"] = {
                WeaponsKit = {}
            },
        }
    },

    ["Customs"] = {
        coords = {
            vec3(-341.43, -162.01, 44.58),
        },
        radioChannel = 114,
        groups = {
            ["Lider [Customs]"] = {
                WeaponsKit = {}
            },
            ["SubLider [Customs]"] = {
                WeaponsKit = {}
            },
            ["Gerente [Customs]"] = {
                WeaponsKit = {}
            },
            ["Membro [Customs]"] = {
                WeaponsKit = {}
            },
            ["Novato [Customs]"] = {
                WeaponsKit = {}
            },
            ["Recruta [Customs]"] = {
                WeaponsKit = {}
            },
        }
    },
    ["Bombeiro"] = {
        coords = {
            vec3(1173.7, -1473.15, 34.69),
        },
        radioChannel = 193,
        groups = {
            ["CoronelBombeiro"] = {
                WeaponsKit = { "Glock", "Taser" }
            },
            ["TenenteCoronelBombeiro"] = {
                WeaponsKit = { "Glock", "Taser" }
            },
            ["MajorBombeiro"] = {
                WeaponsKit = { "Glock", "Taser" }
            },
            ["CapitaoBombeiro"] = {
                WeaponsKit = { "Glock", "Taser" }
            },
            ["TenenteBombeiro"] = {
                WeaponsKit = { "Taser" }
            },
            ["AspiranteBombeiro"] = {
                WeaponsKit = { "Taser" }
            },
            ["AlunoOficialBombeiro"] = {
                WeaponsKit = { "Taser" }
            },
        }
    },
    ["Judiciario"] = {
        coords = {
            vec3(-552.18, -191.7, 38.22),
        },
        radioChannel = 113,
        groups = {
            ["Desembargador"] = {
                WeaponsKit = {}
            },
            ["Juiz"] = {
                WeaponsKit = {}
            },
            ["Promotor"] = {
                WeaponsKit = {}
            },
            ["Supervisor"] = {
                WeaponsKit = {}
            },
            ["Advogado"] = {
                WeaponsKit = {}
            },
            ["SegurancaChef"] = {
                WeaponsKit = {}
            },
            ["Seguranca"] = {
                WeaponsKit = {}
            },
            ["EstagiarioADV"] = {
                WeaponsKit = {}
            },
        }
    },
    ["Mecanica"] = {
        coords = {
            vec3(97.24, 122.47, 80.53),
        },
        radioChannel = 113,
        groups = {
            ["Lider [Mecanica]"] = {
                WeaponsKit = {}
            },
            ["Sub-Lider [Mecanica]"] = {
                WeaponsKit = {}
            },
            ["Gerente [Mecanica]"] = {
                WeaponsKit = {}
            },
            ["Membro [Mecanica]"] = {
                WeaponsKit = {}
            },
            ["Advogado"] = {
                WeaponsKit = {}
            },
            ["Novato [Mecanica]"] = {
                WeaponsKit = {}
            },
            ["Recrutador [Mecanica]"] = {
                WeaponsKit = {}
            },
        }
    },
    ["Jornal"] = {
        coords = {
            vec3(-582.25, -937.89, 23.86),
        },
        radioChannel = 113,
        groups = {
            ["DiretorJornal"] = {
                WeaponsKit = { "Taser" }
            },
            ["ProdutorJornal"] = {
                WeaponsKit = { "Taser" }
            },
            ["Reporter"] = {
                WeaponsKit = { "Taser" }
            },
            ["EstagiarioJornal"] = {
                WeaponsKit = {}
            },
        }
    },
    ["Cot"] = {
        coords = {
            vec3(365.37, -1608.81, 29.28),
        },
        radioChannel = 123,
        groups = {
            ["ComandoGeralCot"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["ComandoCot"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["SubComandoCot"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["DelegadoGeralCot"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG", "Taser" }
            },
            ["CoronelCot"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["TenenteCoronelCot"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["PrimeiroEscalaoCot"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["CapitaoCot"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["PrimeiroTenenteCot"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["SegundoTenenteCot"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["AspiranteOficialCot"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["CadeteCot"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["RecrutadorCot"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["SargentoCot"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["SegundoSargentoCot"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["TerceiroSargentoCot"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["CaboCot"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["SoldadoCot"] = {
                WeaponsKit = { "Parafal", "Glock", "SMG" }
            },
            ["RecrutaCot"] = {
                WeaponsKit = { "Glock", "SMG" }
            },
        }
    },    
}
