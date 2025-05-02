menuTuning = {
    comando = "zt", 
    permissoesAcessarMenu = { 'perm.tunar' },
    itensObrigatorioAcessar = {  }, -- { "notebook" },

    itensObrigatorioInstalarModulo = {  }, -- { "chavefenda" },
    permissoesInstalarModulo = { 'perm.tunar' }, -- { "mecanico.permissao" },
    
    itensObrigatorioRemoverModulo = {  }, -- { "chavefenda" },
    permissoesRemoverModulo = { 'perm.tunar' }, -- { "mecanico.permissao" },
}

networkPopsAndBangs = {
    som = true,
    particulas = true
}

configuracaoModulos = {
    ["suspensao"] = { 
        nome = "Suspensão a Ar",
        img = "https://i.postimg.cc/G2P1T2D1/61xZT0o.png",
        -- desabilitar = true,
        configItem = {
            obrigatorioItemInstaladoParaAcessar = false,
            nameItem = "suspensaoar",
            tempoAnimacaoInstalacao = 5 -- SEGUNDOS
        },
        permsAcessarMenu = { }
    },
    ["neon"] = { 
        nome = "Neon",
        img = "https://i.postimg.cc/L87SrGSG/UU8pPxM.png",
        configItem = {
            obrigatorioItemInstaladoParaAcessar = false,
            nameItem = "kitneon",
            tempoAnimacaoInstalacao = 5
        },
        permsAcessarMenu = { }
    },
    ["xenon"] = { 
        nome = "Xenon",
        img = "https://i.postimg.cc/N0HtYbfF/XAUopVB.png",
        configItem = {
            obrigatorioItemInstaladoParaAcessar = false,
            nameItem = "kitxenon",
            tempoAnimacaoInstalacao = 5
        },
        permsAcessarMenu = {  }
    },
    ["camber"] = { 
        nome = "Camber",
        img = "https://i.postimg.cc/DZ3Tzs8g/qHamoRI.png",
        configItem = {
            obrigatorioItemInstaladoParaAcessar = false,
            nameItem = "kitcamber",
            tempoAnimacaoInstalacao = 5
        },
        permsAcessarMenu = {  }
    },
    ["offset"] = { 
        nome = "OffSet",
        img = "https://i.postimg.cc/DZ3Tzs8g/qHamoRI.png",
        configItem = {
            obrigatorioItemInstaladoParaAcessar = false,
            nameItem = "kitoffset",
            tempoAnimacaoInstalacao = 5
        },
        permsAcessarMenu = {  }
    },
    ["antiLag"] = { 
        nome = "Pops' Bangs",
        img = "https://i.postimg.cc/QdVsYh2p/NzhQ3t7.png",
        configItem = {
            obrigatorioItemInstaladoParaAcessar = false,
            nameItem = "escapamentoPop",
            tempoAnimacaoInstalacao = 5
        },
        permsAcessarMenu = {  }
    },
    ["remap"] = { 
        nome = "Fueltech",
        img = "https://i.postimg.cc/NfsQT1bC/0rfEpay.png",
        configItem = {
            obrigatorioItemInstaladoParaAcessar = false,
            nameItem = "fueltech",
            tempoAnimacaoInstalacao = 5
        },
        permsAcessarMenu = {  }
    },
    ["westgate"] = { 
        nome = "Westgate",
        img = "https://i.postimg.cc/tJXG3jdn/LTBaZGg.png",
        configItem = {
            obrigatorioItemInstaladoParaAcessar = false,
            nameItem = "westgate",
            tempoAnimacaoInstalacao = 0
        },
        permsAcessarMenu = {  }
    },
    ["purgador"] = { 
        nome = "Purgador",
        img = "https://i.postimg.cc/L6x2Vnb9/yV76b2d.png",
        configItem = {
            obrigatorioItemInstaladoParaAcessar = false,
            nameItem = "purgador",
            tempoAnimacaoInstalacao = 0
        },
        permsAcessarMenu = {  }
    },
}

remapOptions = {
    { field = "fInitialDriveForce", key = "torque", title = "Torque", step = 0.01, var = 0.1 },
    { field = "fDriveInertia", key = "rotation", title = "Aceleração Motor", step = 0.01, var = 0.1 },
    { field = "fSteeringLock", key = "steering", title = "Ângulo", step = 1, var = 35 },
    { field = "fBrakeForce", key = "brakeForce", title = "Força de frenagem", step = 0.01, var = 0.2 },
    { field = "fTractionCurveMax", key = "curvedgrip", title = "Aderência nas curvas", step = 0.01, var = 1.5 },
}

veiculosBlackList = {
    ["kuruma"] = true,
    ["t20"] = true,
}