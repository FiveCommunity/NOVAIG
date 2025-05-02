Config = {}

Config.StaffPermissions = {
    'developer.permissao',
    'admin.permissao',
}

Config.mainCommand = 'mdt'
Config.staffCommand = 'mdtadm'

Config.Webhooks = {
    contract = 'https://discord.com/api/webhooks/1313517683274289183/1uBS4D0xC3lS6nnPqemIWmvb1jtYNHOKbrn8C9UFER4Pq1MDMWGrEVyPJAtxs6Lk_4f3',
    demote = 'https://discord.com/api/webhooks/1313517866431025253/MFff77cO9OPrHCZ9joDbQWOy03FgRFxPNopHb_6P_WHlaV7qmwjD1qLZ4flgVf2Guj5t',
    promote = 'https://discord.com/api/webhooks/1313517754044776558/ngMJWh2UxBcHJ6WmnuDKzrCUA29hd2NgyNQroArslCEFWHz5zEv00ClerD5Cj8a0UNLU',
    dismiss = 'https://discord.com/api/webhooks/1313517935477788745/F_aKKSfpIa6FbiETtACUI0LMiKXAq09ZiNAaP0Ez-He8OpwAOty9Wrp-KyHYMNMnZuIG',
    prison = 'https://discord.com/api/webhooks/1317270783365615676/md20Z6Fbe-il5Fqmg2IqAWzw31K1Zftql2K7mjkKugac0tXf_MXmwNrkUvSFVt-pn86R',
    arrestVehicles = '',
    fine = '',
}

Config.prisonCoord = vec3(1716.85,2525.78,45.54)
Config.releaseCoord = vec3(1848.0,2585.86,45.66)
Config.inviteReward = 50000

Config.prisonClothes = {
    ['mp_m_freemode_01'] = {
        {0,0,0}, {0,209,0}, {0,15,0}, {34,0,706}, {0,0,0}, {0,0,-1}, {-1,-1,-1}, {-1,-1,-1}, {-1,-1,-1}, {-1,-1,-1}
    },
    ['mp_f_freemode_01'] = {
        {0,0,0}, {0,207,0}, {14,0,294}, {35,0,821}, {0,0,0}, {0,0,-1}, {-1,-1,-1}, {-1,-1,-1}, {-1,-1,-1}, {-1,-1,-1}
    },
}

Config.ArrestLocations = {
    { coordinate = vec3(-412.87, 1084.33, 323.85), range = 80.0 },
    { coordinate = vec3(-955.08, -2050.74, 9.4), range = 80.0 },
    { coordinate = vec3(-1091.41, -823.99, 5.48), range = 80.0 },
    { coordinate = vec3(2622.84, 5271.62, 45.48), range = 80.0 },
    { coordinate = vec3(-2049.42, -456.93, 8.58), range = 80.0 },
    { coordinate = vec3(-1665.53, 183.87, 61.77), range = 80.0 },
    { coordinate = vec3(607.34, -7.91, 82.78), range = 80.0 },
    { coordinate = vec3(2507.98, -352.15, 105.68), range = 80.0 },
    { coordinate = vec3(482.13, -1165.64, 30.97), range = 80.0 },
    { coordinate = vec3(487.64, -1166.22, 30.97), range = 80.0 },
    { coordinate = vec3(353.87, -1606.78, 29.28), range = 80.0 },
    { coordinate = vec3(-2020.6, 3209.64, 32.84), range = 80.0 },
    { coordinate = vec3(-2019.32, 3210.26, 32.84), range = 80.0 },
    { coordinate = vec3(-2626.37, 2651.35, 17.3), range = 80.0 },
    { coordinate = vec3(456.57, -986.69, 34.2), range = 80.0 },
    { coordinate = vec3(-785.97, -1212.14, 3.56), range = 80.0 },
    { coordinate = vec3(-2626.02, 2652.1, 17.3), range = 80.0 },
    { coordinate = vec3(-1687.42, -765.41, 7.06), range = 80.0 },
    { coordinate = vec3(-804.06,-1356.58,5.16), range = 80.0 },
    { coordinate = vec3(-702.11,-1288.93,5.39), range = 80.0 },
    { coordinate = vec3(455.27,-986.95,34.2), range = 15.0 },
    { coordinate = vec3(-2062.66,3222.88,32.96), range = 80.0 },
    { coordinate = vec3(-556.0,-596.07,30.43), range = 80.0 },
}

Config.crimes = {
    {
        name = "Abuso de Autoridade",
        fine = 300000,
        bail = 0,
        mounths = 50,
    },
    {
        name = "Corrupção Passiva e/ou Ativa",
        fine = 300000,
        bail = 0,
        mounths = 50,
    },
    {
        name = "Desacato",
        fine = 300000,
        bail = 0,
        mounths = 30,
    },
    {
        name = "Impedir Exercício Profissional",
        fine = 150000,
        bail = 300000,
        mounths = 20,
    },
    {
        name = "Prevaricação",
        fine = 300000,
        bail = 0,
        mounths = 50,
    },
    {
        name = "Prisão Disciplinar",
        fine = 100000,
        bail = 0,
        mounths = 30,
    },
    {
        name = "Tráfico de Influência",
        fine = 150000,
        bail = 300000,
        mounths = 30,
    },
    {
        name = "Uso irregular de Função Pública",
        fine = 300000,
        bail = 0,
        mounths = 30,
    },
    {
        name = "Tentativa de Homicídio",
        fine = 200000,
        bail = 0,
        mounths = 30,
    },
    {
        name = "Homicídio Culposo",
        fine = 300000,
        bail = 0,
        mounths = 30,
    },
    {
        name = "Homicídio Doloso",
        fine = 300000,
        bail = 0,
        mounths = 40,
    },
    {
        name = "Homicídio Qualificado",
        fine = 400000,
        bail = 0,
        mounths = 50,
    },
    {
        name = "Latrocínio",
        fine = 400000,
        bail = 0,
        mounths = 60,
    },
    {
        name = "Assédio Moral",
        fine = 100000,
        bail = 200000,
        mounths = 10,
    },
    {
        name = "Calúnia",
        fine = 100000,
        bail = 200000,
        mounths = 10,
    },
    {
        name = "Difamação",
        fine = 100000,
        bail = 200000,
        mounths = 10,
    },
    {
        name = "Injúria",
        fine = 100000,
        bail = 200000,
        mounths = 10,
    },
    {
        name = "Importunação Sexual",
        fine = 100000,
        bail = 200000,
        mounths = 10,
    },
    {
        name = "Perjúrio",
        fine = 100000,
        bail = 200000,
        mounths = 10,
    },
    {
        name = "Abandono de Incapaz",
        fine = 200000,
        bail = 0,
        mounths = 100,
    },
    {
        name = "Adultério",
        fine = 200000,
        bail = 2000000,
        mounths = 50,
    },
    {
        name = "Bigamia",
        fine = 200000,
        bail = 2000000,
        mounths = 50,
    },
    {
        name = "Crime Sexual Intrafamiliar",
        fine = 200000,
        bail = 2000000,
        mounths = 50,
    },
    {
        name = "Ameaça",
        fine = 100000,
        bail = 200000,
        mounths = 20,
    },
    {
        name = "Extorsão",
        fine = 50000,
        bail = 100000,
        mounths = 10,
    },
    {
        name = "Lesão Corporal",
        fine = 100000,
        bail = 200000,
        mounths = 20,
    },
    {
        name = "Sequestro",
        fine = 200000,
        bail = 0,
        mounths = 30,
    },
    {
        name = "Tortura",
        fine = 400000,
        bail = 0,
        mounths = 50,
    },
    {
        name = "Vandalismo",
        fine = 50000,
        bail = 100000,
        mounths = 10,
    },
    {
        name = "Dano de Propriedade do Governo",
        fine = 100000,
        bail = 200000,
        mounths = 10,
    },
    {
        name = "Estelionato",
        fine = 100000,
        bail = 200000,
        mounths = 10,
    },
    {
        name = "Invasão de Propriedade",
        fine = 100000,
        bail = 200000,
        mounths = 10,
    },
    {
        name = "Furto",
        fine = 100000,
        bail = 200000,
        mounths = 10,
    },
    {
        name = "Roubo",
        fine = 150000,
        bail = 300000,
        mounths = 20,
    },
    {
        name = "Posse de Produtos Ilegais",
        fine = 50000,
        bail = 100000,
        mounths = 10,
    },
    {
        name = "Tráfico de Produtos Ilegais",
        fine = 100000,
        bail = 200000,
        mounths = 30,
    },
    {
        name = "Posse de Peças de Armas",
        fine = 0,
        bail = 0,
        mounths = 0,
    },
    {
        name = "Posse de Cápsula",
        fine = 0,
        bail = 0,
        mounths = 0,
    },
    {
        name = "Porte de Arma Leve",
        fine = 100000,
        bail = 200000,
        mounths = 20,
    },
    {
        name = "Tráfico de Armas Leve",
        fine = 300000,
        bail = 0,
        mounths = 40,
    },
    {
        name = "Porte de Arma Pesada",
        fine = 200000,
        bail = 400000,
        mounths = 30,
    },
    {
        name = "Tráfico de Armas Pesada",
        fine = 400000,
        bail = 0,
        mounths = 50,
    },
    {
        name = "Porte de Arma Branca",
        fine = 100000,
        bail = 0,
        mounths = 0,
    },
    {
        name = "Porte de Munição (-100)",
        fine = 100000,
        bail = 200000,
        mounths = 20,
    },
    {
        name = "Tráfico de Munição (+100)",
        fine = 200000,
        bail = 400000,
        mounths = 30,
    },
    {
        name = "Posse de Componentes Narcóticos",
        fine = 0,
        bail = 0,
        mounths = 0,
    },
    {
        name = "Posse de Drogas (-100)",
        fine = 100000,
        bail = 200000,
        mounths = 20,
    },
    {
        name = "Tráfico de Drogas (+100)",
        fine = 150000,
        bail = 300000,
        mounths = 30,
    },
    {
        name = "Dinheiro Sujo Leve",
        fine = 50000,
        bail = 100000,
        mounths = 10,
    },
    {
        name = "Dinheiro Sujo Médio",
        fine = 150000,
        bail = 300000,
        mounths = 20,
    },
    {
        name = "Dinheiro Sujo Grave",
        fine = 300000,
        bail = 600000,
        mounths = 30,
    },
    {
        name = "Apologia ao Crime",
        fine = 100000,
        bail = 200000,
        mounths = 10,
    },
    {
        name = "Falsidade Ideológica",
        fine = 200000,
        bail = 400000,
        mounths = 30,
    },
    {
        name = "Formação de Quadrilha",
        fine = 200000,
        bail = 400000,
        mounths = 30,
    },
    {
        name = "Desobediência",
        fine = 100000,
        bail = 200000,
        mounths = 10,
    },
    {
        name = "Exercício Ilegal de Profissão",
        fine = 200000,
        bail = 400000,
        mounths = 10,
    },
    {
        name = "Falsa Comunicação de Crime",
        fine = 50000,
        bail = 100000,
        mounths = 10,
    },
    {
        name = "Obstrução de Justiça",
        fine = 50000,
        bail = 100000,
        mounths = 20,
    },
    {
        name = "Ocultação de Provas",
        fine = 100000,
        bail = 200000,
        mounths = 10,
    },
    {
        name = "Omissão de Socorro",
        fine = 50000,
        bail = 100000,
        mounths = 10,
    },
    {
        name = "Perturbação da Ordem",
        fine = 100000,
        bail = 200000,
        mounths = 10,
    },
    {
        name = "QRR Ilegal",
        fine = 50000,
        bail = 100000,
        mounths = 10,
    },
    {
        name = "Tentativa de Fuga",
        fine = 100000,
        bail = 200000,
        mounths = 20,
    },
    {
        name = "Tentativa de Suborno",
        fine = 200000,
        bail = 400000,
        mounths = 30,
    },
    {
        name = "Alta Velocidade",
        fine = 20000,
        bail = 0,
        mounths = 0,
    },
    {
        name = "Condução Imprudente",
        fine = 20000,
        bail = 0,
        mounths = 0,
    },
    {
        name = "Corridas Ilegais",
        fine = 100000,
        bail = 200000,
        mounths = 20,
    },
    {
        name = "Dirigir na Contramão",
        fine = 20000,
        bail = 0,
        mounths = 0,
    },
    {
        name = "Poluição Sonora",
        fine = 20000,
        bail = 0,
        mounths = 0,
    },
    {
        name = "Veículo Muito Danificado",
        fine = 20000,
        bail = 0,
        mounths = 0,
    },
    {
        name = "Veículo Ilegalmente Estacionado",
        fine = 20000,
        bail = 0,
        mounths = 0,
    },
    {
        name = "Uso Excessivo de Insulfilm",
        fine = 20000,
        bail = 0,
        mounths = 0,
    },
    {
        name = "Ocultação Facial",
        fine = 50000,
        bail = 100000,
        mounths = 10,
    },
    {
        name = "Uso de Coldre",
        fine = 50000,
        bail = 0,
        mounths = 0,
    },
    {
        name = "Uso de Colete (Roupa)",
        fine = 50000,
        bail = 0,
        mounths = 0,
    },
    {
        name = "Porte de Colete Balístico (equipamento)",
        fine = 100000,
        bail = 200000,
        mounths = 10,
    },
    {
        name = "Tráfico de Colete Balístico (equipamento)",
        fine = 200000,
        bail = 400000,
        mounths = 20,
    },
}

Config.mitigatingFactors = {
    {
        name = "Jurídico Constituído",
        fine = 0,
        mounths = 15,
    },
    {
        name = "Réu Primário",
        fine = 0,
        mounths = 10,
    },
    {
        name = "Réu Confesso",
        fine = 0,
        mounths = 10,
    },
    {
        name = "Colaboração",
        fine = 0,
        mounths = 10,
    },
    {
        name = "Porte de Arma Legal",
        fine = 0,
        mounths = 10,
    },
    {
        name = "Delação Premiada",
        fine = 0,
        mounths = 50,
    },
}

Config.Roles = {
    ['Policia'] = {
        {
            roleName = 'CoronelPM',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'TenenteCoronelPM',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'MajorPM',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'CapitaoPM',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'PrimeiroTenentePM',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'SegundoTenentePM',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'SubTenentePM',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'PrimeiroSargentoPM',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'SegundoSargentoPM',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'TerceiroSargentoPM',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'CaboPM',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'SoldadoPM',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'AlunoPM',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'CadetePM',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'AspirantePM',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
    },    
    ['PoliciaCivil'] = {
        {
            roleName = 'ComandoGeralCivil',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'DelegadoGeral',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'Delegado',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'ComandoInvestigativa',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'SubComandoInvestigativa',
            permissions = {
                canHire = true,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'ComandoDraco',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'SubComandoDraco',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'AgenteDraco',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'EstagiarioDraco',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'Perito',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'Investigador',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'RecrutadorCivil',
            permissions = {
                canHire = true,
                canPromote = false,
                canDemote = false,
                canDismiss = true,
            },
        },
        {
            roleName = 'AgenteAdministrativo',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'Agente',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'Recruta',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
    },
    ['PoliciaFederal'] = {
        {
            roleName = 'ComandanteGeralPF',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'DelegadoGeralPF',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'DelegadoPF',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'DelegadoAdjuntoPF',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'ComandoGTF',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'GTF',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'PeritoPF',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'EscrivaoPF',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'InstrutorPF',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = false,
                canDismiss = true,
            },
        },
        {
            roleName = 'Inspetor',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'AgenteEspecial',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'AgenteCL1',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'AgenteCL2',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'AgenteCL3',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'AgentePF',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
    },    
    ['Choque'] = {
        {
            roleName = 'ComandanteGeralCHOQUE',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'SubComandanteCHOQUE',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'CoronelCHOQUE',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'TenenteCoronelCHOQUE',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = false,
                canDismiss = true,
            },
        },
        {
            roleName = 'MajorCHOQUE',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = false,
                canDismiss = true,
            },
        },
        {
            roleName = 'PrimeiroTenenteCHOQUE',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = false,
                canDismiss = true,
            },
        },
        {
            roleName = 'SegundoTenenteCHOQUE',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = false,
                canDismiss = true,
            },
        },
        {
            roleName = 'SubTenenteCHOQUE',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = false,
                canDismiss = true,
            },
        },
        {
            roleName = 'PrimeiroSargentoCHOQUE',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'SegundoSargentoCHOQUE',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'TerceiroSargenteCHOQUE',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'CaboCHOQUE',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'SoldadoCHOQUE',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'EstagiarioCHOQUE',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
    },
    ['Core'] = {
        {
            roleName = 'CoronelCORE',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'TenenteCoronelCORE',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'MajorCORE',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = false,
                canDismiss = true,
            },
        },
        {
            roleName = 'CapitaoCORE',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = false,
                canDismiss = true,
            },
        },
        {
            roleName = 'TenenteCORE',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'SegundoTenenteCORE',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'OficialCORE',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'RecrutadorCORE',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = false,
                canDismiss = true,
            },
        },
        {
            roleName = 'SegundoSargentoCORE',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'PrimeiroSargentoCORE',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'CaboCORE',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'SoldadoCORE',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'AlunoCORE',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
    },    
    ['PRF'] = {
        {
            roleName = 'DiretorGeralPRF',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'DiretorPRF',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'SubDiretorPRF',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'CorregedorGeralPRF',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'SupervisorGeralPRF',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'InspetorGeralPRF',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'DelegadoGeralPRF',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'ComandoGrrPRF',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'CorregedorPRF',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'SupervisorPRF',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'DelegadoPRF',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'RecrutadorPRF',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'InspetorPRF',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'GrrPRF',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'AgenteOperacionalPRF',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'AgentePrimeiraClassePRF',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'AgenteSegundaClassePRF',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'AgenteTerceiraClassePRF',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'EstagiarioPRF',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
    },    
    ['Exercito'] = {
        {
            roleName = 'MarechalEXERCITO',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'GeneralEXERCITO',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'CoronelEXERCITO',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'TenenteCoronelEXERCITO',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'MajorEXERCITO',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'CapitaoEXERCITO',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'TenenteEXERCITO',
            permissions = {
                canHire = false,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'SubtenenteEXERCITO',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = false,
                canDismiss = true,
            },
        },
        {
            roleName = 'SargentoEXERCITO',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'CaboEXERCITO',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'SoldadoEXERCITO',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'RecrutaEXERCITO',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
    },    
    ['Cot'] = {
        {
            roleName = 'ComandoCot',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'SubComandoCot',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'DelegadoGeralCot',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'DelegadoCot',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'CoronelCot',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'TenenteCoronelCot',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'PrimeiroEscalaoCot',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'CapitaoCot',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'PrimeiroTenenteCot',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'SegundoTenenteCot',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'AspiranteOficialCot',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'CadeteCot',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'SubtenenteCot',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'SargentoCot',
            permissions = {
                canHire = false,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'SegundoSargentoCot',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'TerceiroSargentoCot',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'CaboCot',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'SoldadoCot',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'RecrutaCot',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
    },
    ['Bope'] = {
        {
            roleName = 'ComandanteGeralBOPE',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'SubComandanteBOPE',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'CoronelBope',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'TenenteCoronelBope',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'MajorBope',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = true,
                canDismiss = true,
            },
        },
        {
            roleName = 'CapitaoBope',
            permissions = {
                canHire = true,
                canPromote = true,
                canDemote = false,
                canDismiss = true,
            },
        },
        {
            roleName = 'PrimeiroTenenteBope',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'SegundoTenenteBope',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'SubTenenteBope',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'PrimeiroSargentoBope',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'SegundoSargentoBope',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'TerceiroSargenteBope',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'CaboBope',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'SoldadoBope',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
        {
            roleName = 'EstagiarioBope',
            permissions = {
                canHire = false,
                canPromote = false,
                canDemote = false,
                canDismiss = false,
            },
        },
    },    
}