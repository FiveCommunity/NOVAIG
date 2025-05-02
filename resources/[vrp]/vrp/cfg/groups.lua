local cfg = {}

cfg.groups = {
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- ADMINISTRAÇÃO
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ["SS"] = {
        _config = {
            gtype = "slave",
            salario = 0
        },
        "perm.ss",
    },

    ["paulinho"] = {
        _config = {
            gtype = "staff",
            salario = 0
        },
        "paulinho.permissao",
        "dv.permissao",
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "player.wall",
        "spec.permissao",
        "mqcu.permissao",
        "perm.ptr.staff",
        "player.som",
        "perm.algemar"
    },

    ["cargomakakero"] = {
        _config = {
            gtype = "staff",
            salario = 0
        },
        "perm.top1",
        "perm.mochilastaff",
        "perm.spec",
        "perm.chatstaff",
        "perm.instagrammod",
        "perm.setroupas",
        "perm.abrirmalas",
        "admin.permissao",
        "dv.permissao",
        "ticket.permissao",
        "developer.permissao",
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "spec.permissao",
        "mqcu.permissao",
        "perm.ptr.staff",
        "player.som",
        "perm.algemar"
    },


    ["TOP1"] = {
        _config = {
            gtype = "staff",
            salario = 0
        },
        "perm.top1",
        "perm.mochilastaff",
        "perm.spec",
        "perm.chatstaff",
        "perm.instagrammod",
        "perm.setroupas",
        "perm.abrirmalas",
        "admin.permissao",
        "dv.permissao",
        "ticket.permissao",
        "developer.permissao",
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "player.wall",
        "spec.permissao",
        "mqcu.permissao",
        "perm.ptr.staff",
        "player.som",
        "perm.algemar"
    },

    ["developerlotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 0
        },
        "perm.propmanager",
        "perm.arrastar",
        "perm.mochilastaff",
        "perm.respilegal",
        "diretor.permissao",
        "perm.instagrammod",
        "perm.setroupas",
        "perm.abrirmalas",
        "admin.permissao",
        "dv.permissao",
        "ticket.permissao",
        "developer.permissao",
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "player.wall",
        "spec.permissao",
        "mqcu.permissao",
        "perm.ptr.staff",
        "player.som",
        "perm.algemar"
    },
    ["developerofflotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 0
        },
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "perm.mochilastaff",
        "perm.user",
        "staffoff.permissao",
        "perm.ptr.staff",
        "perm.algemar"
    },
    ["respeventoslotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 0
        },
        "perm.cam",
        "player.som",
        "perm.arrastar",
        "perm.propmanager",
        "admin.permissao",
        "dv.permissao",
        "ticket.permissao",
        "respeventos.permissao",
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "player.wall",
        "spec.permissao",
        "mqcu.permissao",
        "perm.ptr.staff",
        "perm.algemar"
    },
    ["respeventosofflotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 0
        },
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "perm.user",
        "staffoff.permissao",
        "perm.ptr.staff",
        "perm.algemar"
    },
    ["adminlotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 0
        },
        "perm.propmanager",
        "perm.arrastar",
        "admin.permissao",
        "dv.permissao",
        "ticket.permissao",
        "player.blips",
        "player.noclip",
        "perm.mochilastaff",
        "player.teleport",
        "player.secret",
        "player.spec",
        "player.wall",
        "spec.permissao",
        "mqcu.permissao",
        "perm.ptr.staff",
        "perm.algemar"
    },
    ["adminofflotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 0
        },
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "perm.user",
        "staffoff.permissao",
        "perm.ptr.staff",
        "perm.algemar"
    },
    ["resploglotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 0
        },
        "perm.resplog",
        "perm.propmanager",
        "perm.arrastar",
        "admin.permissao",
        "dv.permissao",
        "ticket.permissao",
        "player.blips",
        "player.noclip",
        "perm.mochilastaff",
        "player.teleport",
        "player.secret",
        "player.spec",
        "player.wall",
        "spec.permissao",
        "mqcu.permissao",
        "perm.ptr.staff",
        "perm.algemar"
    },
    ["resplogofflotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 0
        },
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "perm.user",
        "staffoff.permissao",
        "perm.ptr.staff",
        "perm.algemar"
    },
    ["respstreamerlotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 40000
        },
        "perm.propmanager",
        "admin.permissao",
        "respstreamer.permissao",
        "dv.permissao",
        "ticket.permissao",
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "player.wall",
        "spec.permissao",
        "mqcu.permissao",
        "perm.ptr.staff",
        "perm.algemar"
    },
    ["respstreamerofflotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 0
        },
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "perm.user",
        "staffoff.permissao",
        "perm.ptr.staff",
        "perm.algemar"
    },
    ["moderadorlotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 15000
        },
        "perm.arrastar",
        "moderador.permissao",
        "dv.permissao",
        "ticket.permissao",
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "player.wall",
        "spec.permissao",
        "mqcu.permissao",
        "perm.ptr.staff",
        "perm.algemar"
    },
    ["moderadorofflotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 0
        },
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "perm.user",
        "staffoff.permissao",
        "perm.ptr.staff",
        "perm.algemar"
    },
    ["suportelotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 10000
        },
        "suporte.permissao",
        "perm.arrastar",
        "dv.permissao",
        "ticket.permissao",
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "player.wall",
        "spec.permissao",
        "mqcu.permissao",
        "perm.ptr.staff",
        "perm.algemar"
    },
    ["suporteofflotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 0
        },
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "perm.user",
        "staffoff.permissao",
        "perm.ptr.staff",
        "perm.algemar"
    },
    ["ajudantelotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 10000
        },
        "perm.ajudante",
        "dv.permissao",
        "ticket.permissao",
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "player.wall",
        "spec.permissao",
        "mqcu.permissao",
        "perm.ptr.staff",
        "perm.algemar"
    },
    ["ajudanteofflotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 0
        },
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "perm.user",
        "staffoff.permissao",
        "perm.ptr.staff",
        "perm.algemar"
    },
    ["user"] = {"perm.user"},
    ["investidoranjo"] = {
        _config = {
            gtype = "staff"
        },
        "investidoranjo.permissao"
    },
    ["streamer"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "dv.permissao",
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "perm.arrastar",
        "player.spec",
        "player.wall",
        "spec.permissao",
        "dv.permissao",
        "streamer.permissao"
    },

    ["respilegallotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 40000
        },
        "perm.propmanager",
        "perm.arrastar",
        "perm.mochilastaff",
        "perm.instagrammod",
        "perm.setroupas",
        "perm.respilegal",
        "admin.permissao",
        "dv.permissao",
        "ticket.permissao",
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "player.wall",
        "spec.permissao",
        "mqcu.permissao",
        "perm.ptr.staff",
        "perm.algemar"
    },
    ["respilegalofflotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 0
        },
        "perm.mochilastaff",
        "perm.user",
        "staffoff.permissao",
        "perm.ptr.staff",
        "perm.algemar"
    },

    ["resppolicialotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 0
        },
        "perm.propmanager",
        "perm.arrastar",
        "perm.instagrammod",
        "perm.setroupas",
        "perm.resppolicia",
        "perm.mochilastaff",
        "admin.permissao",
        "dv.permissao",
        "ticket.permissao",
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "player.wall",
        "spec.permissao",
        "mqcu.permissao",
        "perm.ptr.staff",
        "perm.algemar"
    },
    ["resppoliciaofflotusgroup@445"] = {
        _config = {
            gtype = "staff",
            salario = 0
        },
        "perm.mochilastaff",
        "perm.user",
        "staffoff.permissao",
        "perm.ptr.staff",
        "perm.algemar"
    },

    ["cc"] = {
        _config = {
            gtype = "cc",
            salario = 30000
        },
        "perm.cc",
        "player.blips",
        "player.noclip",
        "player.teleport",
        "player.secret",
        "player.spec",
        "player.wall",
        "spec.permissao"
    },

    ["cconteudo"] = {
        _config = {
            gtype = "cconteudo",
            salario = 15000
        },
        "perm.cconteudo",
        "dv.permissao",
        "perm.attachs",
        "dv.permissao",
        "perm.mochila",
        "perm.som",
        "perm.verificado",
        "perm.roupas",
        'perm.fixvip'
    },

    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- VIPS
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ["Altarj"] = {
        _config = {
            gtype = "altarj",
            salario = 60000,
            ptr = nil
        },
        "perm.vips",
        "perm.attachs",
        "perm.altarj",
        "perm.booster",
        "perm.roupas",
        "perm.mochila",
        "player.som"
    },

    ["Bronze"] = {
        _config = {
            gtype = "bronze",
            salario = 4000,
            ptr = nil
        },
        "perm.vips",
        "perm.bronze",
        "perm.booster"
    },
    ["Prata"] = {
        _config = {
            gtype = "prata",
            salario = 6000,
            ptr = nil
        },
        "perm.vips",
        "perm.prata",
        "perm.booster"
    },
    ["Ouro"] = {
        _config = {
            gtype = "ouro",
            salario = 8000,
            ptr = nil
        },
        "perm.vips",
        "perm.attachs",
        "perm.ouro",
        "perm.booster",
        "perm.roupas"
    },
    ["Platina"] = {
        _config = {
            gtype = "platina",
            salario = 10000,
            ptr = nil
        },
        "perm.vips",
        "perm.attachs",
        "perm.platina",
        "perm.booster",
        "perm.roupas"
    },
    ["Diamante"] = {
        _config = {
            gtype = "diamante",
            salario = 15000,
            ptr = nil
        },
        "perm.vips",
        "perm.attachs",
        "perm.diamante",
        "perm.booster",
        "perm.roupas",
        "perm.mochila"
    },
    ["Esmeralda"] = {
        _config = {
            gtype = "esmeralda",
            salario = 40000,
            ptr = nil
        },
        "perm.vips",
        "perm.attachs",
        "perm.esmeralda",
        "perm.booster",
        "perm.roupas",
        "perm.mochila",
        "player.som"
    },
    ["Safira"] = {
        _config = {
            gtype = "safira",
            salario = 30000,
            ptr = nil
        },
        "perm.vips",
        "perm.attachs",
        "perm.safira",
        "perm.booster",
        "perm.roupas",
        "perm.mochila",
        "player.som"
    },
    ["Rubi"] = {
        _config = {
            gtype = "rubi",
            salario = 40000,
            ptr = nil
        },
        "perm.vips",
        "perm.attachs",
        "perm.rubi",
        "perm.booster",
        "perm.roupas",
        "perm.mochila",
        "player.som"
    },
    ["Supremorj"] = {
        _config = {
            gtype = "supremorj",
            salario = 80000,
            ptr = nil
        },
        "perm.vips",
        "perm.attachs",
        "perm.supremorj",
        "perm.booster",
        "perm.roupas",
        "perm.mochila",
        "player.som",
        "perm.fixvip"
    },

    ["Pascoa"] = {
        _config = {
            gtype = "Pascoa",
            salario = 25000,
            ptr = nil
        },

        "perm.pascoa",
        "perm.vips",
        "perm.attachs",
        "perm.booster",
        "perm.roupas",
        "perm.verificado",
        "perm.mochila",
        "perm.fixvip",
        "player.som"
    },

    ["VipHalloween"] = {
        _config = {
            gtype = "VipHalloween",
            salario = 25000,
            ptr = nil
        },

        "perm.viphalloween",
        "perm.vips",
        "perm.attachs",
        "perm.booster",
        "perm.roupas",
        "perm.verificado",
        "perm.mochila",
        "perm.fixvip",
        "player.som"
    },

    ["VipDeluxe"] = {
        _config = {
            gtype = "VipDeluxe",
            salario = 25000,
            ptr = nil
        },

        "perm.vipdeluxe",
        "perm.vips",
        "perm.attachs",
        "perm.booster",
        "perm.roupas",
        "perm.verificado",
        "perm.mochila",
        "perm.fixvip",
        "player.som"
    },

    ["VipReal"] = {
        _config = {
            gtype = "Vip Real",
            salario = 30000,
            ptr = nil
        },

        "perm.vipreal",
        "perm.vips",
        "perm.attachs",
        "perm.booster",
        "perm.roupas",
        "perm.verificado",
        "perm.mochila",
        "perm.fixvip",
        "player.som"
    },

    ["Olimpiada"] = {
        _config = {
            gtype = "Olimpiada",
            salario = 30000,
            ptr = nil
        },

        "perm.olimpiada",
        "perm.vips",
        "perm.attachs",
        "perm.booster",
        "perm.roupas",
        "perm.verificado",
        "perm.mochila",
        "perm.fixvip",
        "player.som"
    },

    ["VipIndependencia"] = {
        _config = {
            gtype = "Independencia",
            salario = 25000,
            ptr = nil
        },

        "perm.vipindependencia",
        "perm.vips",
        "perm.attachs",
        "perm.booster",
        "perm.roupas",
        "perm.verificado",
        "perm.mochila",
        "perm.fixvip",
        "player.som"
    },

    ["Ferias"] = {
        _config = {
            gtype = "Ferias",
            salario = 30000,
            ptr = nil
        },

        "perm.ferias",
        "perm.vips",
        "perm.attachs",
        "perm.booster",
        "perm.roupas",
        "perm.verificado",
        "perm.mochila",
        "perm.suspension",
        "perm.fixvip",
        "player.som"
    },

    ["VipPolicia"] = {
        _config = {
            gtype = "VipPolicia",
            salario = 30000,
            ptr = nil
        },
        "perm.vippolicia",
        "perm.attachs",
        "perm.mochila",
        "perm.deathtime",
        "perm.fixvip",
        "player.som",
        "perm.roupas"
    },

    ["VipMedico"] = {
        _config = {
            gtype = "VipMedico",
            salario = 30000,
            ptr = nil
        },
        "perm.vipmedico",
        "perm.attachs",
        "perm.mochila",
        "perm.deathtime",
        "perm.fixvip",
        "player.som",
        "perm.roupas"
    },

    ["VipBombeiro"] = {
        _config = {
            gtype = "VipBombeiro",
            salario = 30000,
            ptr = nil
        },
        "perm.vipbombeiro",
        "perm.attachs",
        "perm.mochila",
        "perm.deathtime",
        "perm.fixvip",
        "player.som",
        "perm.roupas"
    },

    ["VipMecanico"] = {
        _config = {
            gtype = "VipMecanico",
            salario = 30000,
            ptr = nil
        },
        "perm.vipmecanico",
        "perm.attachs",
        "perm.mochila",
        "perm.deathtime",
        "perm.fixvip",
        "player.som",
        "perm.roupas"
    },
    ["VipSaoJoao"] = {
        _config = { 
            gtype = "vipsaojoao", 
            salario = 30000, 
            ptr = nil 
        }, 
        "perm.vips", 
        "perm.attachs", 
        "player.som", 
        "perm.verificado", 
        "perm.vipsaojoao", 
        "perm.booster", 
        "perm.roupas", 
        "perm.mochila", 
        "player.som" 
    },
    ["VipCrianca"] = {
        _config = {
            gtype = "vipcrianca",
            salario = 25000,
            ptr = nil
        },
        "perm.attachs",
        "perm.mochila",
        "perm.som",
        "perm.verificado",
        "perm.roupas",
        'perm.fixvip'
    },
    ["VipSetembro"] = {
        _config = {
            gtype = "vipsetembro",
            salario = 30000,
            ptr = nil
        },
        "perm.vipsetembro",
        "perm.roupas",
        "perm.mochila",
        "perm.attachs",
        "player.som",
        "perm.fixvip",
        "perm.verificado"
    },
    ["VipVerao"] = {
        _config = {
            gtype = "vipverao",
            salario = 25000,
            ptr = nil
        },
        "perm.vipverao",
        "perm.roupas",
        "perm.mochila",
        "perm.attachs",
        "player.som",
        "perm.fixvip",
        "perm.verificado"
    },
    ["VipCarnaval"] = {
        _config = {
            gtype = "vipcarnaval",
            salario = 25000,
            ptr = nil
        },
        "perm.vipcarnaval",
        "perm.roupas",
        "perm.mochila",
        "perm.attachs",
        "perm.suspension",
        "player.som",
        "perm.fixvip",
        "perm.attachs2",
        "perm.verificado"
    },
    ["VipOutono"] = {
        _config = {
            gtype = "vipoutono",
            salario = 25000,
            ptr = nil
        },
        "perm.vipoutono",
        "perm.roupas",
        "perm.mochila",
        "perm.attachs",
        "player.som",
        "perm.fixvip",
        "perm.verificado"
    },
    ["VipMaio"] = {
        _config = {
            gtype = "vipmaio",
            salario = 25000,
            ptr = nil
        },
        "perm.vipmaio",
        "perm.roupas",
        "perm.mochila",
        "perm.attachs",
        "player.som",
        "perm.fixvip",
        "perm.verificado"
    },
    ["VipMakakero"] = {
        _config = {
            gtype = "vipmakakero",
            salario = 30000,
            ptr = nil
        },
        "perm.vipmakakero",
        "perm.roupas",
        "perm.mochila",
        "perm.attachs",
        "player.som",
        "perm.fixvip",
        "perm.verificado"
    },

    ["VipInauguracao"] = {
        _config = {
            gtype = "VipInauguracao",
            salario = 20000,
            ptr = nil
        },
        "perm.vipinauguracao",
        "perm.roupas",
        "perm.mochila",
        "perm.attachs",
        "perm.booster",
        "player.som",
    },

    ["VipAnoNovo"] = {
        _config = {
            gtype = "vipanonovo",
            salario = 25000,
            ptr = nil
        },
        "perm.vipanonovo",
        "perm.roupas",
        "perm.mochila",
        "perm.attachs",
        "player.som",
        "perm.fixvip",
        "perm.verificado"
    },
    ["VipBlackfriday"] = { 
        _config = { 
            gtype = "vipblackfriday", 
            salario = 30000, 
            ptr = nil 
        }, 
        "perm.vipblackfriday", 
        "perm.verificado", 
        "perm.attachs", 
        "perm.mochila", 
        "player.som", 
        "perm.roupas", 
        "perm.suspension",
        "perm.fixvip"
    },
    ["VipInicial"] = { 
        _config = { 
            gtype = "VipInicial", 
            salario = 2000, 
            ptr = nil 
        }, 
        "perm.vipinicial", 
        "perm.attachs", 
        "perm.mochila", 
        "perm.roupas", 
        "perm.fixvip"
    },
    ["VipNatal"] = { 
        _config = { 
            gtype = "VipNatal", 
            salario = 25000, 
            ptr = nil 
        }, 
        "perm.vipnatal", 
        "perm.verificado", 
        "perm.attachs", 
        "perm.mochila", 
        "player.som", 
        "perm.suspension",
        "perm.roupas", 
        "perm.fixvip"
    },
    ["Vip2025"] = { 
        _config = { 
            gtype = "Vip2025", 
            salario = 25000, 
            ptr = nil 
        }, 
        "perm.vip2025", 
        "perm.verificado", 
        "perm.attachs", 
        "perm.mochila", 
        "player.som", 
        "perm.suspension",
        "perm.roupas", 
        "perm.fixvip"
    },
    
    ["Plastica"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.plastica"
    },

    ["SalarioGerente"] = {
        _config = {
            salario = 6000,
            ptr = nil
        },
        "perm.salariogerente"
    },
    ["SalarioPatrao"] = {
        _config = {
            salario = 9000,
            ptr = nil
        },
        "perm.salariopatrao"
    },
    ["SalarioVelhodalancha"] = {
        _config = {
            salario = 12000,
            ptr = nil
        },
        "perm.salariovelhodalancha"
    },
    ["SalarioCelebridade"] = {
        _config = {
            salario = 15000,
            ptr = nil
        },
        "perm.salariocelebridade"
    },
    ["SalarioMilionario"] = {
        _config = {
            salario = 25000,
            ptr = nil
        },
        "perm.salariomilionario"
    },
    ["SalarioDosDeuses"] = {
        _config = {
            salario = 40000,
            ptr = nil
        },
        "perm.salariodosdeuses"
    },
    ["SalarioDoMakakako"] = {
        _config = {
            salario = 100000,
            ptr = nil
        },
        "perm.salariodomakakero"
    },
    ["mochila350"] = {
        _config = {
            salario = 100000,
            ptr = nil
        },
        "perm.mochila350"
    },

    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- BENEFICIOS
    -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ["Estagiario"] = {
        _config = {
            gtype = "jobdois",
            salario = 5000,
            ptr = nil
        },
        "perm.estagiario"
    },
    ["Funcionario"] = {
        _config = {
            gtype = "jobtres",
            salario = 4000,
            ptr = nil
        },
        "perm.funcionario"
    },
    ["Gerente"] = {
        _config = {
            gtype = "jobquatro",
            salario = 6000,
            ptr = nil
        },
        "perm.gerente"
    },
    ["Patrao"] = {
        _config = {
            gtype = "jobcinco",
            salario = 8000,
            ptr = nil
        },
        "perm.patrao"
    },
    ["CasaDoFranklin"] = {
        _config = {
            gtype = "jobseis",
            salario = 0,
            ptr = nil
        },
        "perm.franklin"
    },
    ["spotify"] = {
        _config = {
            gtype = "spotify",
            salario = 0,
            ptr = nil
        },
        "player.som"
    },
    ["Booster"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.booster"
    },
    ["Verificado"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.verificado"
    },

    ["cam"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.cam"
    },
    ["skin"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.skin"
    },
    ["ego"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.ego"
    },
    ["tracker"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.tracker"
    },

    ["valecasa"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "valecasa.permissao"
    },
    ["valegaragem"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "valegaragem.permissao"
    },

    ["zeroum"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.zeroum"
    },
    ["zerodois"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.zerodois"
    },

    ["valeapartamento"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "valeapartamento.permissao"
    },
    ["valecasa5kk"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "valecasa5kk.permissao"
    },
    ["valecasa7kk"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "valecasa7kk.permissao"
    },
    ["valecasa10kk"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "valecasa10kk.permissao"
    },
    ["valecasa100kk"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "valecasa100kk.permissao"
    },

    ["setport"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.setport"
    },



    ["kitbuzeira"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.kitbuzeira"
    },
    ["camisadeforca"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.camisadeforca"
    },

    ["Vagas"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.vagastres"
    },
    ["VagasQuarenta"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.vagasquarenta"
    },
    ["vagas32"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.vagas32"
    },
    ["vagas30"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.vagas30"
    },
    ["vagas10"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.vagas10"
    },
    ["vagas11"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.vagas11"
    },
    ["vagas15"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.vagas15"
    },
    ["vagas19"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.vagas19"
    },
    ["homes4"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.homes4"
    },

    ["CriadorDeConteudo"] = {
        _config = {
            salario = 3000,
            ptr = nil
        },
        "perm.criadordeconteudo",
        "perm.roupas",
        "perm.mochila",
        "player.som"
    },
    ["Influencer"] = {
        _config = {
            salario = 5000,
            ptr = nil
        },
        "perm.influencer",
        "dv.permissao",
        "perm.attachs",
        "perm.fixvip",
        "perm.roupas",
        "perm.mochila",
        "perm.verificado",
        "player.som",
        "perm.cam"
    },

    ["Influencer021"] = {
        _config = {
            salario = 5000,
            ptr = nil
        },
        "perm.influencer021",
        "perm.roupas",
        "perm.mochila",
        "player.som",
        "perm.cam"
    },

    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- OUTROS
    -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ["Porte de Armas"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.portearmas"
    },
    ["Porte de Armas Medio"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.portearmas",
        "perm.portearmasmedio"
    },
    ["Porte de Armas Pesado"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.portearmas",
        "perm.portearmasmedio"
    },
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- POLICIA
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- POLICIA
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ["CoronelPM"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "Policia",
            orgType = 'Policia'
        },
        "dv.permissao",
        "perm.liderpolicia",
        "perm.avisopm",
        "perm.militar",
        "perm.garagemlidermilitar",
        "perm.apreenderveh",
        "perm.garagemmilitar",
        "perm.countpolicia",
        "perm.malas",
        "perm.policia",
        "perm.blitz",
        "perm.policia.padrao",
        "perm.snovato",
        "perm.baupolicialider",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal"
    },
    ["TenenteCoronelPM"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "Policia"
        },
        "dv.permissao",
        "perm.liderpolicia",
        "perm.avisopm",
        "perm.garagemlidermilitar",
        "perm.blitz",
        "perm.apreenderveh",
        "perm.militar",
        "perm.garagemmilitar",
        "perm.countpolicia",
        "perm.malas",
        "perm.policia",
        "perm.policia.padrao",
        "perm.snovato",
        "perm.baupolicialider",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal"
    },
    ["MajorPM"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "Policia"
        },
        "dv.permissao",
        "perm.avisopm",
        "perm.militar",
        "perm.garagemmilitar",
        "perm.garagemlidermilitar",
        "perm.countpolicia",
        "perm.malas",
        "perm.policia",
        "player.blips",
        "perm.apreenderveh",
        "perm.policia.padrao",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal"
    },
    ["CapitaoPM"] = {
        _config = {
            gtype = "org",
            salario = 45000,
            ptr = true,
            orgName = "Policia"
        },
        "perm.militar",
        "perm.garagemmilitar",
        "perm.countpolicia",
        "perm.malas",
        "perm.policia",
        "perm.policia.padrao",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal"
    },
    ["PrimeiroTenentePM"] = {
        _config = {
            gtype = "org",
            salario = 45000,
            ptr = true,
            orgName = "Policia"
        },
        "perm.militar",
        "perm.garagemmilitar",
        "perm.countpolicia",
        "perm.malas",
        "perm.policia",
        "perm.policia.padrao",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal"
    },
    ["SegundoTenentePM"] = {
        _config = {
            gtype = "org",
            salario = 45000,
            ptr = true,
            orgName = "Policia"
        },
        "perm.militar",
        "perm.garagemmilitar",
        "perm.countpolicia",
        "perm.malas",
        "perm.policia",
        "perm.policia.padrao",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal"
    },
    ["SubTenentePM"] = {
        _config = {
            gtype = "org",
            salario = 45000,
            ptr = true,
            orgName = "Policia"
        },
        "perm.militar",
        "perm.garagemmilitar",
        "perm.countpolicia",
        "perm.malas",
        "perm.policia",
        "perm.policia.padrao",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal"
    },
    ["PrimeiroSargentoPM"] = {
        _config = {
            gtype = "org",
            salario = 45000,
            ptr = true,
            orgName = "Policia"
        },
        "perm.militar",
        "perm.garagemmilitar",
        "perm.countpolicia",
        "perm.malas",
        "perm.policia",
        "perm.policia.padrao",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal"
    },
    ["SegundoSargentoPM"] = {
        _config = {
            gtype = "org",
            salario = 45000,
            ptr = true,
            orgName = "Policia"
        },
        "perm.militar",
        "perm.garagemmilitar",
        "perm.countpolicia",
        "perm.malas",
        "perm.policia",
        "perm.policia.padrao",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal"
    },
    ["TerceiroSargentoPM"] = {
        _config = {
            gtype = "org",
            salario = 45000,
            ptr = true,
            orgName = "Policia"
        },
        "perm.militar",
        "perm.garagemmilitar",
        "perm.countpolicia",
        "perm.malas",
        "perm.policia",
        "perm.policia.padrao",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal"
    },
    ["CaboPM"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Policia"
        },
        "perm.militar",
        "perm.garagemmilitar",
        "perm.countpolicia",
        "perm.policia",
        "player.blips",
        "perm.policia.padrao",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal"
    },
    ["SoldadoPM"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Policia"
        },
        "perm.militar",
        "perm.garagemmilitar",
        "perm.countpolicia",
        "perm.policia",
        "player.blips",
        "perm.policia.padrao",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal"
    },
    ["AlunoPM"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Policia"
        },
        "perm.militar",
        "perm.countpolicia",
        "perm.policia",
        "player.blips",
        "perm.policia.padrao",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal"
    },
    ["CadetePM"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Policia"
        },
        "perm.militar",
        "perm.countpolicia",
        "perm.policia",
        "player.blips",
        "perm.policia.padrao",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal"
    },
    ["AspirantePM"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Policia"
        },
        "perm.militar",
        "perm.countpolicia",
        "perm.policia",
        "player.blips",
        "perm.policia.padrao",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal"
    },

    ["ComandanteGeralBOPE"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "Bope"
        },
        "dv.permissao",
        "perm.avisopm",
        "perm.liderbope",
        "perm.baubope",
        "perm.blitz",
        "perm.abrirmalas",
        "perm.countpolicia",
        "perm.garagemliderbope",
        "perm.malas",
        "perm.apreenderveh",
        "perm.bope",
        "perm.policia",
        "perm.garagembope",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["SubComandanteBOPE"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "Bope"
        },
        "dv.permissao",
        "perm.avisopm",
        "perm.liderbope",
        "perm.baubope",
        "perm.abrirmalas",
        "perm.blitz",
        "perm.garagemliderbope",
        "perm.countpolicia",
        "perm.apreenderveh",
        "perm.malas",
        "perm.garagembope",
        "perm.bope",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["CoronelBope"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "Bope"
        },
        "perm.avisopm",
        "perm.baubope",
        "perm.abrirmalas",
        "perm.countpolicia",
        "perm.malas",
        "perm.liderbope",
        "perm.blitz",
        "perm.bope",
        "perm.policia",
        "perm.garagemliderbope",
        "perm.garagembope",
        "player.blips",
        "perm.disparo",
        "perm.apreenderveh",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["TenenteCoronelBope"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "Bope"
        },
        "perm.avisopm",
        "perm.baubope",
        "perm.countpolicia",
        "perm.malas",
        "perm.garagemliderbope",
        "perm.bope",
        "perm.policia",
        "perm.liderbope",
        "perm.blitz",
        "player.blips",
        "perm.garagembope",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["MajorBope"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Bope"
        },
        "perm.avisopm",
        "perm.baubope",
        "perm.liderbope",
        "perm.countpolicia",
        "perm.blitz",
        "perm.malas",
        "perm.garagembope",
        "perm.bope",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["CapitaoBope"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Bope"
        },
        "perm.avisopm",
        "perm.baubope",
        "perm.countpolicia",
        "perm.liderbope",
        "perm.blitz",
        "perm.malas",
        "perm.bope",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.garagembope",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["PrimeiroTenenteBope"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Bope"
        },
        "perm.avisopm",
        "perm.baubope",
        "perm.countpolicia",
        "perm.malas",
        "perm.bope",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.garagembope",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["SegundoTenenteBope"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Bope"
        },
        "perm.avisopm",
        "perm.baubope",
        "perm.countpolicia",
        "perm.malas",
        "perm.bope",
        "perm.policia",
        "perm.garagembope",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["SubTenenteBope"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Bope"
        },
        "perm.avisopm",
        "perm.baubope",
        "perm.countpolicia",
        "perm.malas",
        "perm.bope",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.garagembope",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["PrimeiroSargentoBope"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Bope"
        },
        "perm.baubope",
        "perm.countpolicia",
        "perm.malas",
        "perm.bope",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.garagembope",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["SegundoSargentoBope"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Bope"
        },
        "perm.baubope",
        "perm.countpolicia",
        "perm.malas",
        "perm.bope",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.garagembope",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["TerceiroSargenteBope"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Bope"
        },
        "perm.baubope",
        "perm.countpolicia",
        "perm.malas",
        "perm.bope",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.garagembope",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["CaboBope"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Bope"
        },
        "perm.baubope",
        "perm.countpolicia",
        "perm.malas",
        "perm.bope",
        "perm.policia",
        "player.blips",
        "perm.garagembope",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["SoldadoBope"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Bope"
        },
        "perm.baubope",
        "perm.countpolicia",
        "perm.malas",
        "perm.bope",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.garagembope",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["EstagiarioBope"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Bope"
        },
        "perm.baubope",
        "perm.countpolicia",
        "perm.malas",
        "perm.bope",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },

    ["ComandanteGeralCHOQUE"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "Choque"
        },
        "dv.permissao",
        "perm.avisopm",
        "perm.bauchoque",
        "perm.blitz",
        "perm.liderchoque",
        "perm.apreenderveh",
        "perm.abrirmalas",
        "perm.countpolicia",
        "perm.malas",
        "perm.barreira",
        "perm.choque",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["SubComandanteCHOQUE"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "Choque"
        },
        "dv.permissao",
        "perm.avisopm",
        "perm.bauchoque",
        "perm.liderchoque",
        "perm.barreira",
        "perm.abrirmalas",
        "perm.apreenderveh",
        "perm.blitz",
        "perm.countpolicia",
        "perm.malas",
        "perm.choque",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["CoronelCHOQUE"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "Choque"
        },
        "dv.permissao",
        "perm.avisopm",
        "perm.liderchoque",
        "perm.bauchoque",
        "perm.blitz",
        "perm.abrirmalas",
        "perm.countpolicia",
        "perm.malas",
        "perm.apreenderveh",
        "perm.choque",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["TenenteCoronelCHOQUE"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "Choque"
        },
        "dv.permissao",
        "perm.avisopm",
        "perm.bauchoque",
        "perm.countpolicia",
        "perm.malas",
        "perm.choque",
        "perm.blitz",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["MajorCHOQUE"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Choque"
        },
        "dv.permissao",
        "perm.avisopm",
        "perm.bauchoque",
        "perm.countpolicia",
        "perm.malas",
        "perm.choque",
        "perm.policia",
        "perm.blitz",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["CapitaoCHOQUE"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Choque"
        },
        "dv.permissao",
        "perm.avisopm",
        "perm.countpolicia",
        "perm.malas",
        "perm.choque",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["PrimeiroTenenteCHOQUE"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Choque"
        },
        "perm.avisopm",
        "perm.countpolicia",
        "perm.malas",
        "perm.choque",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["SegundoTenenteCHOQUE"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Choque"
        },
        "perm.avisopm",
        "perm.countpolicia",
        "perm.malas",
        "perm.choque",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["SubTenenteCHOQUE"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Choque"
        },
        "perm.avisopm",
        "perm.countpolicia",
        "perm.malas",
        "perm.choque",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["PrimeiroSargentoCHOQUE"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Choque"
        },
        "perm.countpolicia",
        "perm.malas",
        "perm.choque",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["SegundoSargentoCHOQUE"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Choque"
        },
        "perm.countpolicia",
        "perm.malas",
        "perm.choque",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["TerceiroSargenteCHOQUE"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Choque"
        },
        "perm.countpolicia",
        "perm.malas",
        "perm.choque",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["CaboCHOQUE"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Choque"
        },
        "perm.countpolicia",
        "perm.malas",
        "perm.choque",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["SoldadoCHOQUE"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Choque"
        },
        "perm.countpolicia",
        "perm.malas",
        "perm.choque",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["EstagiarioCHOQUE"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Choque"
        },
        "perm.countpolicia",
        "perm.malas",
        "perm.choque",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },

    ["MarechalEXERCITO"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "Exercito"
        },
        "perm.bauliderexercito",
        "dv.permissao",
        "perm.avisopm",
        "perm.liderexercito",
        "perm.bauexercito",
        "perm.blitz",
        "perm.abrirmalas",
        "perm.countpolicia",
        "perm.apreenderveh",
        "perm.barreira",
        "perm.malas",
        "perm.exercito",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["GeneralEXERCITO"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "Exercito"
        },
        "perm.bauliderexercito",
        "dv.permissao",
        "perm.avisopm",
        "perm.blitz",
        "perm.liderexercito",
        "perm.bauexercito",
        "perm.barreira",
        "perm.abrirmalas",
        "perm.countpolicia",
        "perm.apreenderveh",
        "perm.malas",
        "perm.exercito",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["CoronelEXERCITO"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "Exercito"
        },
        "perm.bauliderexercito",
        "dv.permissao",
        "perm.avisopm",
        "perm.bauexercito",
        "perm.countpolicia",
        "perm.malas",
        "perm.exercito",
        "perm.blitz",
        "perm.barreira",
        "perm.apreenderveh",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["TenenteCoronelEXERCITO"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "Exercito"
        },
        "perm.bauliderexercito",
        "perm.avisopm",
        "perm.barreira",
        "perm.bauexercito",
        "perm.blitz",
        "dv.permissao",
        "perm.countpolicia",
        "perm.malas",
        "perm.exercito",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["MajorEXERCITO"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Exercito"
        },
        "perm.bauexercito",
        "perm.barreira",
        "perm.countpolicia",
        "perm.malas",
        "dv.permissao",
        "perm.exercito",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["CapitaoEXERCITO"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Exercito"
        },
        "perm.bauexercito",
        "perm.countpolicia",
        "perm.malas",
        "perm.exercito",
        "dv.permissao",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["TenenteEXERCITO"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Exercito"
        },
        "perm.bauexercito",
        "perm.countpolicia",
        "perm.malas",
        "perm.exercito",
        "dv.permissao",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["SubtenenteEXERCITO"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Exercito"
        },
        "perm.bauexercito",
        "perm.countpolicia",
        "perm.malas",
        "perm.exercito",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "dv.permissao",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["SargentoEXERCITO"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Exercito"
        },
        "perm.bauexercito",
        "perm.countpolicia",
        "perm.malas",
        "dv.permissao",
        "perm.exercito",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["CaboEXERCITO"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Exercito"
        },
        "perm.bauexercito",
        "perm.countpolicia",
        "perm.malas",
        "perm.exercito",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["SoldadoEXERCITO"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Exercito"
        },
        "perm.bauexercito",
        "perm.countpolicia",
        "perm.malas",
        "perm.exercito",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ["RecrutaEXERCITO"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Exercito"
        },
        "perm.bauexercito",
        "perm.countpolicia",
        "perm.malas",
        "perm.exercito",
        "perm.policia",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.countpoliciaNormal",
        "perm.pftt"
    },
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- POLICIA FEDERAL
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ["ComandanteGeralPF"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PoliciaFederal"
        },
        "perm.garagemdelpf",
        "perm.pf",
        "perm.multar",
        "perm.prisao",
        "dv.permissao",
        "perm.baudelegado",
        "perm.avisopm",
        "perm.blitz",
        "perm.abrirmalas",
        "perm.countfederal",
        "perm.chamadoscivil",
        "perm.baupoliciafederal",
        "perm.geragemliderpf",
        "perm.apreenderveh",
        "perm.malas",
        "perm.barreira",
        "perm.baupf",
        "perm.policiafederal",
        "perm.snovato",
        "perm.baupoliciafederallider",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["DelegadoGeralPF"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PoliciaFederal"
        },
        "perm.garagemdelpf",
        "perm.pf",
        "perm.multar",
        "perm.prisao",
        "dv.permissao",
        "perm.baudelegado",
        "perm.avisopm",
        "perm.barreira",
        "perm.apreenderveh",
        "perm.blitz",
        "perm.abrirmalas",
        "perm.countfederal",
        "perm.chamadoscivil",
        "perm.baupoliciafederal",
        "perm.malas",
        "perm.policiafederal",
        "perm.snovato",
        "perm.baupoliciafederallider",
        "perm.geragemliderpf",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.baupf",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["DelegadoPF"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PoliciaFederal"
        },
        "perm.garagemdelpf",
        "perm.pf",
        "perm.multar",
        "perm.prisao",
        "dv.permissao",
        "perm.baudelegado",
        "perm.geragemliderpf",
        "perm.apreenderveh",
        "perm.avisopm",
        "perm.blitz",
        "perm.baupf",
        "perm.barreira",
        "perm.abrirmalas",
        "perm.countfederal",
        "perm.chamadoscivil",
        "perm.baupoliciafederal",
        "perm.malas",
        "perm.policiafederal",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["DelegadoAdjuntoPF"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PoliciaFederal"
        },
        "perm.garagemdelpf",
        "perm.pf",
        "perm.barreira",
        "perm.multar",
        "perm.prisao",
        "perm.blitz",
        "perm.geragemliderpf",
        "dv.permissao",
        "perm.baudelegado",
        "perm.avisopm",
        "perm.abrirmalas",
        "perm.countfederal",
        "perm.chamadoscivil",
        "perm.baupoliciafederal",
        "perm.baupf",
        "perm.malas",
        "perm.policiafederal",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["ComandoGTF"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PoliciaFederal"
        },
        "perm.pf",
        "perm.multar",
        "perm.prisao",
        "perm.geragemliderpf",
        "dv.permissao",
        "perm.baudelegado",
        "perm.avisopm",
        "perm.blitz",
        "perm.limparficha",
        "perm.abrirmalas",
        "perm.countfederal",
        "perm.chamadoscivil",
        "perm.baupoliciafederal",
        "perm.malas",
        "perm.policiafederal",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["GTF"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PoliciaFederal"
        },
        "perm.pf",
        "perm.multar",
        "perm.prisao",
        "dv.permissao",
        "perm.baudelegado",
        "perm.avisopm",
        "perm.abrirmalas",
        "perm.countfederal",
        "perm.chamadoscivil",
        "perm.baupoliciafederal",
        "perm.malas",
        "perm.policiafederal",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["PeritoPF"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PoliciaFederal"
        },
        "dv.permissao",
        "perm.pf",
        "perm.multar",
        "perm.prisao",
        "perm.avisopm",
        "perm.abrirmalas",
        "perm.countfederal",
        "perm.chamadoscivil",
        "perm.baupoliciafederal",
        "perm.malas",
        "perm.policiafederal",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["EscrivaoPF"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PoliciaFederal"
        },
        "perm.pf",
        "perm.multar",
        "dv.permissao",
        "perm.prisao",
        "perm.avisopm",
        "perm.countfederal",
        "perm.chamadoscivil",
        "perm.baupoliciafederal",
        "perm.malas",
        "perm.policiafederal",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["InstrutorPF"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PoliciaFederal"
        },
        "perm.pf",
        "perm.countfederal",
        "dv.permissao",
        "perm.chamadoscivil",
        "perm.policiafederal",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm",
        "perm.avisopm"
    },
    ["Inspetor"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PoliciaFederal"
        },
        "perm.pf",
        "perm.countfederal",
        "perm.chamadoscivil",
        "perm.policiafederal",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["AgenteEspecial"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PoliciaFederal"
        },
        "perm.pf",
        "dv.permissao",
        "perm.geragemliderpf",
        "perm.countfederal",
        "perm.chamadoscivil",
        "perm.policiafederal",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["AgenteCL3"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "PoliciaFederal"
        },
        "perm.pf",
        "perm.countfederal",
        "perm.chamadoscivil",
        "perm.policiafederal",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["AgenteCL2"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "PoliciaFederal"
        },
        "perm.pf",
        "dv.permissao",
        "perm.countfederal",
        "perm.chamadoscivil",
        "perm.policiafederal",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["AgentePF"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "PoliciaFederal"
        },
        "perm.pf",
        "perm.countfederal",
        "perm.chamadoscivil",
        "perm.policiafederal",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["AgenteCL1"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PoliciaFederal"
        },
        "perm.pf",
        "dv.permissao",
        "perm.countfederal",
        "perm.chamadoscivil",
        "perm.policiafederal",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },

    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- POLICIA CIVIL
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
    ["ComandoGeralCivil"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PoliciaCivil"
        },
        "dv.permissao",
        "perm.baudelegado",
        "perm.avisopm",
        "perm.limparficha",
        "perm.abrirmalas",
        "perm.countcivil",
        "perm.blitz",
        "perm.chamadoscivil",
        "perm.baupoliciacivil",
        "perm.malas",
        "perm.apreenderveh",
        "perm.policiacivil",
        "perm.snovato",
        "perm.baupoliciacivillider",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["DelegadoGeral"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PoliciaCivil"
        },
        "dv.permissao",
        "perm.baudelegado",
        "perm.avisopm",
        "perm.abrirmalas",
        "perm.apreenderveh",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.blitz",
        "perm.baupoliciacivil",
        "perm.malas",
        "perm.policiacivil",
        "perm.snovato",
        "perm.baupoliciacivillider",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["Delegado"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PoliciaCivil"
        },
        "dv.permissao",
        "perm.baudelegado",
        "perm.avisopm",
        "perm.baupoliciacivil",
        "perm.abrirmalas",
        "perm.blitz",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.baupoliciacivil",
        "perm.apreenderveh",
        "perm.baupoliciacivillider",
        "perm.malas",
        "perm.policiacivil",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["Perito"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PoliciaCivil"
        },
        "perm.avisopm",
        "perm.abrirmalas",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.baupoliciacivil",
        "perm.malas",
        "perm.policiacivil",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["RecrutadorCivil"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PoliciaCivil"
        },
        "perm.avisopm",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.baupoliciacivil",
        "perm.malas",
        "perm.policiacivil",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["ComandoInvestigativa"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PoliciaCivil"
        },
        "perm.abrirmalas",
        "perm.limparficha",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.avisopm",
        "perm.baupoliciacivil",
        "perm.malas",
        "perm.policiacivil",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["SubComandoInvestigativa"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PoliciaCivil"
        },
        "perm.abrirmalas",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.baupoliciacivil",
        "perm.malas",
        "perm.policiacivil",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["Investigador"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PoliciaCivil"
        },
        "perm.abrirmalas",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.baupoliciacivil",
        "perm.malas",
        "perm.policiacivil",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["AgenteAdministrativo"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "PoliciaCivil"
        },
        "perm.abrirmalas",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.baupoliciacivil",
        "perm.malas",
        "perm.policiacivil",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["Agente"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "PoliciaCivil"
        },
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.policiacivil",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["Recruta"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "PoliciaCivil"
        },
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.policiacivil",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["EstagiarioDraco"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PoliciaCivil"
        },
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.policiacivil",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["AgenteDraco"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PoliciaCivil"
        },
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.policiacivil",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["SubComandoDraco"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PoliciaCivil"
        },
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.policiacivil",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["ComandoDraco"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PoliciaCivil"
        },
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.policiacivil",
        "perm.avisopm",
        "player.blips",
        "perm.disparo",
        "perm.limparficha",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },

    ["CoronelCORE"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "Core"
        },
        "perm.baucore",
        "perm.avisopm",
        "perm.barreira",
        "perm.core",
        "dv.permissao",
        "perm.abrirmalas",
        "perm.limparficha",
        "perm.apreenderveh",
        "perm.countcivil",
        "perm.blitz",
        "perm.chamadoscivil",
        "perm.malas",
        "perm.baulidercore",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["TenenteCoronelCORE"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "Core"
        },
        "perm.baulidercore",
        "perm.barreira",
        "perm.baucore",
        "perm.apreenderveh",
        "perm.avisopm",
        "perm.core",
        "perm.blitz",
        "perm.abrirmalas",
        "dv.permissao",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["MajorCORE"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "Core"
        },
        "perm.baucore",
        "perm.avisopm",
        "perm.core",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.apreenderveh",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["CapitaoCORE"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "Core"
        },
        "perm.baucore",
        "perm.avisopm",
        "perm.core",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["TenenteCORE"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Core"
        },
        "perm.baucore",
        "perm.avisopm",
        "perm.core",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["SegundoTenenteCORE"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Core"
        },
        "perm.baucore",
        "perm.core",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["OficialCORE"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Core"
        },
        "perm.baucore",
        "perm.core",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["RecrutadorCORE"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Core"
        },
        "perm.baucore",
        "perm.core",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["PrimeiroSargentoCORE"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Core"
        },
        "perm.baucore",
        "perm.core",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["SegundoSargentoCORE"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Core"
        },
        "perm.baucore",
        "perm.core",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["TerceiroSargentoCORE"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Core"
        },
        "perm.baucore",
        "perm.core",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["CaboCORE"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Core"
        },
        "perm.baucore",
        "perm.core",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["SoldadoCORE"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Core"
        },
        "perm.baucore",
        "perm.core",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["AlunoCORE"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Core"
        },
        "perm.core",
        "perm.countcivil",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },

    ["DiretorGeralPRF"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.bauliderprf",
        "perm.barreira",
        "perm.blitz",
        "dv.permissao",
        "perm.garagemliderprf",
        "perm.bauprf",
        "perm.avisopm",
        "perm.prf",
        "perm.abrirmalas",
        "perm.apreenderveh",
        "perm.chamadoscivil",
        "perm.malas",
        "perm.comandoprf",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["DiretorPRF"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.bauliderprf",
        "perm.barreira",
        "perm.blitz",
        "dv.permissao",
        "perm.bauprf",
        "perm.avisopm",
        "perm.garagemliderprf",
        "erm.timerprf",
        "perm.apreenderveh",
        "perm.prf",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.malas",
        "perm.comandoprf",
        "player.blips",
        "perm.disparo",
        "perm.timerprf",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["SubDiretorPRF"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.bauliderprf",
        "perm.barreira",
        "dv.permissao",
        "perm.comandoprf",
        "perm.apreenderveh",
        "perm.bauprf",
        "erm.timerprf",
        "perm.avisopm",
        "perm.garagemliderprf",
        "perm.prf",
        "perm.blitz",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.timerprf",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["CorregedorGeralPRF"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.comandoprf",
        "perm.barreira",
        "dv.permissao",
        "perm.apreenderveh",
        "perm.bauprf",
        "perm.avisopm",
        "perm.prf",
        "perm.abrirmalas",
        "perm.blitz",
        "perm.chamadoscivil",
        "perm.garagemliderprf",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["SupervisorGeralPRF"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.comandoprf",
        "perm.barreira",
        "dv.permissao",
        "perm.bauprf",
        "perm.avisopm",
        "perm.prf",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.garagemliderprf",
        "perm.portasolicia",
        "perm.blitz",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["InspetorGeralPRF"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.comandoprf",
        "perm.barreira",
        "dv.permissao",
        "perm.bauprf",
        "perm.avisopm",
        "perm.prf",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.blitz",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["DelegadoGeralPRF"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.comandoprf",
        "perm.barreira",
        "dv.permissao",
        "perm.bauprf",
        "perm.avisopm",
        "perm.prf",
        "perm.abrirmalas",
        "perm.blitz",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["CorregedorPRF"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.barreira",
        "dv.permissao",
        "perm.bauprf",
        "perm.avisopm",
        "perm.prf",
        "perm.blitz",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["SupervisorPRF"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.barreira",
        "dv.permissao",
        "perm.bauprf",
        "perm.avisopm",
        "perm.prf",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.blitz",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["DelegadoPRF"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.barreira",
        "dv.permissao",
        "perm.bauprf",
        "perm.avisopm",
        "perm.blitz",
        "perm.prf",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["InspetorPRF"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.barreira",
        "dv.permissao",
        "perm.avisopm",
        "perm.prf",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["DelegadoPRF"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.barreira",
        "dv.permissao",
        "perm.avisopm",
        "perm.prf",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["CorregedoriaGeral"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.barreira",
        "dv.permissao",
        "perm.avisopm",
        "perm.prf",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["Corregedoria"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.barreira",
        "dv.permissao",
        "perm.avisopm",
        "perm.prf",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["ComandoNoe"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.comandoprf",
        "perm.barreira",
        "dv.permissao",
        "perm.avisopm",
        "perm.prf",
        "perm.limparficha",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["ComandoDoa"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.limparficha",
        "perm.barreira",
        "dv.permissao",
        "perm.avisopm",
        "perm.prf",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["ComandoGtmPRF"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.barreira",
        "perm.limparficha",
        "dv.permissao",
        "perm.avisopm",
        "perm.prf",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["ComandoSpeedPRF"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.barreira",
        "dv.permissao",
        "perm.avisopm",
        "perm.prf",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.malas",
        "perm.limparficha",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["ComandoInspetorPRF"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.barreira",
        "dv.permissao",
        "perm.avisopm",
        "perm.limparficha",
        "perm.prf",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["ComandoGrrPRF"] = {
        _config = {
            gtype = "org",
            salario = 70000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.barreira",
        "dv.permissao",
        "perm.avisopm",
        "perm.limparficha",
        "perm.prf",
        "erm.timerprf",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["RecrutadorPRF"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.barreira",
        "dv.permissao",
        "perm.avisopm",
        "perm.prf",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["InspetorPRF"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.barreira",
        "dv.permissao",
        "perm.avisopm",
        "perm.prf",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["GrrPRF"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.barreira",
        "dv.permissao",
        "perm.avisopm",
        "perm.prf",
        "perm.timerprf",
        "perm.abrirmalas",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["AgenteOperacionalPRF"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.barreira",
        "dv.permissao",
        "perm.avisopm",
        "perm.prf",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["AgentePrimeiraClassePRF"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.barreira",
        "dv.permissao",
        "perm.prf",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["AgenteSegundaClassePRF"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "PRF"
        },
        "perm.barreira",
        "dv.permissao",
        "perm.prf",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["AgenteTerceiraClassePRF"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "PRF"
        },
        "dv.permissao",
        "perm.prf",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ["EstagiarioPRF"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "PRF"
        },
        "dv.permissao",
        "perm.prf",
        "perm.chamadoscivil",
        "perm.malas",
        "player.blips",
        "perm.disparo",
        "perm.portasolicia",
        "perm.algemar",
        "perm.countpolicia",
        "perm.radiopm"
    },
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Cot
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	["ComandoCot"] = { _config = { gtype = "org", salario = 70000, ptr = true, orgName = "Cot" },  "perm.limparficha","dv.permissao", "perm.openmalas","perm.baulidercot",  "perm.policiatatica", "perm.revivecot", "perm.lidercot", "perm.avisopm", "perm.baucot", "dv.permissao",  "perm.baucot",  "perm.countpolicia", "perm.malas","perm.cot",  "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpoliciaNormal", "perm.pftt", "perm.blitz"  },
	["SubComandoCot"] = { _config = { gtype = "org", salario = 70000, ptr = true, orgName = "Cot" }, "dv.permissao","perm.openmalas","perm.baulidercot",  "perm.policiatatica", "perm.revivecot", "perm.lidercot", "perm.avisopm", "perm.baucot", "dv.permissao",  "perm.baucot",  "perm.countpolicia", "perm.malas","perm.cot",  "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpoliciaNormal", "perm.pftt", "perm.blitz"  },
	["DelegadoGeralCot"] = { _config = { gtype = "org", salario = 70000, ptr = true, orgName = "Cot" }, "dv.permissao","perm.openmalas","perm.baulidercot",  "perm.policiatatica", "perm.revivecot", "perm.lidercot", "perm.avisopm", "perm.baucot", "dv.permissao",  "perm.baucot",  "perm.countpolicia", "perm.malas","perm.cot",  "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpoliciaNormal", "perm.pftt", "perm.blitz"},
	["DelegadoCot"] = { _config = { gtype = "org", salario = 70000, ptr = true, orgName = "Cot" }, "dv.permissao","perm.openmalas","perm.baulidercot",  "perm.policiatatica", "perm.revivecot", "perm.lidercot", "perm.avisopm", "perm.baucot", "dv.permissao",  "perm.baucot",  "perm.countpolicia", "perm.malas","perm.cot",  "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpoliciaNormal", "perm.pftt", "perm.blitz" },
	["CoronelCot"] = { _config = { gtype = "org", salario = 70000, ptr = true, orgName = "Cot" }, "dv.permissao","perm.openmalas","perm.baulidercot",  "perm.policiatatica", "perm.revivecot", "perm.lidercot", "perm.avisopm", "perm.baucot", "dv.permissao",  "perm.baucot",  "perm.countpolicia", "perm.malas","perm.cot",  "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpoliciaNormal", "perm.pftt"  },
	["TenenteCoronelCot"] = { _config = { gtype = "org", salario = 70000, ptr = true, orgName = "Cot" }, "dv.permissao","perm.openmalas","perm.baulidercot",  "perm.policiatatica", "perm.revivecot", "perm.lidercot", "perm.avisopm", "perm.baucot", "dv.permissao",  "perm.baucot",  "perm.countpolicia", "perm.malas","perm.cot",  "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpoliciaNormal", "perm.pftt"  },
	["PrimeiroEscalaoCot"] = { _config = { gtype = "org", salario = 70000, ptr = true, orgName = "Cot" }, "dv.permissao","perm.openmalas","perm.baulidercot",  "perm.policiatatica", "perm.revivecot", "perm.lidercot", "perm.avisopm", "perm.baucot", "dv.permissao",  "perm.baucot",  "perm.countpolicia", "perm.malas","perm.cot",  "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpoliciaNormal", "perm.pftt"  },
	["CapitaoCot"] = { _config = { gtype = "org", salario = 40000, ptr = true, orgName = "Cot" }, "dv.permissao","perm.openmalas","perm.baulidercot",  "perm.policiatatica", "perm.revivecot", "perm.lidercot", "perm.avisopm", "perm.baucot",  "perm.baucot",  "perm.countpolicia", "perm.malas","perm.cot",  "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpoliciaNormal", "perm.pftt"  },
	["PrimeiroTenenteCot"] = { _config = { gtype = "org", salario = 40000, ptr = true, orgName = "Cot" }, "dv.permissao","perm.openmalas",  "perm.policiatatica", "perm.revivecot", "perm.lidercot", "perm.avisopm", "perm.baucot",  "perm.baucot",  "perm.countpolicia", "perm.malas","perm.cot",  "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpoliciaNormal", "perm.pftt"  },
	["SegundoTenenteCot"] = { _config = { gtype = "org", salario = 40000, ptr = true, orgName = "Cot" }, "dv.permissao","perm.openmalas",  "perm.policiatatica", "perm.revivecot", "perm.lidercot", "perm.avisopm", "perm.baucot",  "perm.baucot",  "perm.countpolicia", "perm.malas","perm.cot",  "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpoliciaNormal", "perm.pftt"  },
	["AspiranteOficialCot"] = { _config = { gtype = "org", salario = 40000, ptr = true, orgName = "Cot" }, "perm.policiatatica", "perm.baucot", "perm.countpolicia", "perm.malas", "perm.cot", "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpoliciaNormal", "perm.pftt", "perm.avisopm",  },
	["CadeteCot"] = { _config = { gtype = "org", salario = 40000, ptr = true, orgName = "Cot" }, "perm.policiatatica", "perm.baucot", "perm.countpolicia", "perm.malas", "perm.cot", "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpoliciaNormal", "perm.pftt", "perm.avisopm",  },
	["SubtenenteCot"] = { _config = { gtype = "org", salario = 40000, ptr = true, orgName = "Cot" }, "perm.policiatatica", "perm.baucot", "perm.countpolicia", "perm.malas", "perm.cot", "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpoliciaNormal", "perm.pftt"  },
	["SargentoCot"] = { _config = { gtype = "org", salario = 40000, ptr = true, orgName = "Cot" }, "perm.policiatatica", "perm.baucot", "perm.countpolicia", "perm.malas", "perm.cot", "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpoliciaNormal", "perm.pftt"  },
	["SegundoSargentoCot"] = { _config = { gtype = "org", salario = 40000, ptr = true, orgName = "Cot" }, "perm.policiatatica", "perm.baucot", "perm.countpolicia", "perm.malas", "perm.cot", "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpoliciaNormal", "perm.pftt"  },
	["TerceiroSargentoCot"] = { _config = { gtype = "org", salario = 40000, ptr = true, orgName = "Cot" }, "perm.policiatatica", "perm.baucot", "perm.countpolicia", "perm.malas", "perm.cot", "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpoliciaNormal", "perm.pftt"  },
	["CaboCot"] = { _config = { gtype = "org", salario = 25000, ptr = true, orgName = "Cot" },  "dv.permissao","perm.policiatatica", "perm.baucot", "perm.countpolicia", "perm.malas", "perm.cot", "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpoliciaNormal", "perm.pftt"  },
	["SoldadoCot"] = { _config = { gtype = "org", salario = 25000, ptr = true, orgName = "Cot" }, "perm.policiatatica", "perm.baucot", "perm.countpolicia", "perm.malas", "perm.cot", "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpoliciaNormal", "perm.pftt"  },
	["RecrutaCot"] = { _config = { gtype = "org", salario = 25000, ptr = true, orgName = "Cot" }, "perm.policiatatica", "perm.baucot", "perm.countpolicia", "perm.malas", "perm.cot", "perm.policia", "player.blips", "perm.disparo", "perm.portasolicia", "perm.algemar", "perm.countpoliciaNormal", "perm.pftt"  },
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- HOSPITAL
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ["Diretor"] = {
        _config = {
            gtype = "org",
            salario = 27000,
            ptr = true,
            orgName = "Hospital"
        },
        "perm.chamadoshp",
        "dv.permissao",
        "perm.bauhospital",
        "perm.avisohp",
        "perm.unizk",
        "perm.arrastarunizk",
        "perm.algemar",
        "perm.chamadoshubhospital",
        "perm.liderunizk",
    },
    ["ViceDiretor"] = {
        _config = {
            gtype = "org",
            salario = 22000,
            ptr = true,
            orgName = "Hospital"
        },
        "perm.chamadoshp",
        "dv.permissao",
        "perm.bauhospital",
        "perm.avisohp",
        "perm.unizk",
        "perm.arrastarunizk",
        "perm.algemar",
        "perm.chamadoshubhospital",
        "perm.liderunizk",
    },
    ["Gestao"] = {
        _config = {
            gtype = "org",
            salario = 20000,
            ptr = true,
            orgName = "Hospital"
        },
        "perm.chamadoshp",
        "dv.permissao",
        "perm.avisohp",
        "perm.unizk",
        "perm.arrastarunizk",
        "perm.algemar",
        "perm.chamadoshubhospital",
        "perm.liderunizk",
    },
    ["Psiquiatra"] = {
        _config = {
            gtype = "org",
            salario = 19000,
            ptr = true,
            orgName = "Hospital"
        },
        "perm.chamadoshp",
        "perm.unizk",
        "perm.arrastarunizk",
        "perm.algemar",
        "perm.chamadoshubhospital",
    },
    ["Medico"] = {
        _config = {
            gtype = "org",
            salario = 18000,
            ptr = true,
            orgName = "Hospital"
        },
        "perm.chamadoshp",
        "perm.unizk",
        "perm.arrastarunizk",
        "perm.algemar",
        "perm.chamadoshubhospital",
    },
    ["Enfermeiro"] = {
        _config = {
            gtype = "org",
            salario = 17000,
            ptr = true,
            orgName = "Hospital"
        },
        "perm.chamadoshp",
        "perm.arrastarunizk",
        "perm.unizk",
        "perm.chamadoshubhospital",
    },
    ["Socorrista"] = {
        _config = {
            gtype = "org",
            salario = 16000,
            ptr = true,
            orgName = "Hospital"
        },
        "perm.chamadoshp",
        "perm.unizk"
    },

    ["CoronelBombeiro"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "Bombeiro"
        },
        "perm.baubombeiro",
        "perm.chamadoshp",
        "perm.avisobombeiro",
        "perm.chamadosbombeiro",
        "dv.permissao",
        "dv.permissao",
        "perm.bombeiro",
        "perm.algemar"
    },
    ["TenenteCoronelBombeiro"] = {
        _config = {
            gtype = "org",
            salario = 37000,
            ptr = true,
            orgName = "Bombeiro"
        },
        "perm.baubombeiro",
        "perm.chamadoshp",
        "perm.avisobombeiro",
        "perm.chamadosbombeiro",
        "dv.permissao",
        "perm.bombeiro",
        "perm.algemar"
    },
    ["MajorBombeiro"] = {
        _config = {
            gtype = "org",
            salario = 35000,
            ptr = true,
            orgName = "Bombeiro"
        },
        "perm.chamadoshp",
        "perm.avisobombeiro",
        "perm.chamadosbombeiro",
        "perm.bombeiro",
        "perm.algemar"
    },
    ["CapitaoBombeiro"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = true,
            orgName = "Bombeiro"
        },
        "perm.chamadoshp",
        "perm.bombeiro",
        "perm.chamadosbombeiro",
        "dv.permissao",
        "perm.algemar"
    },
    ["TenenteBombeiro"] = {
        _config = {
            gtype = "org",
            salario = 30000,
            ptr = true,
            orgName = "Bombeiro"
        },
        "perm.chamadoshp",
        "perm.chamadosbombeiro",
        "perm.bombeiro",
        "perm.algemar"
    },
    ["CaboBombeiro"] = {
        _config = {
            gtype = "org",
            salario = 28000,
            ptr = true,
            orgName = "Bombeiro"
        },
        "perm.chamadoshp",
        "perm.chamadosbombeiro",
        "perm.bombeiro"
    },
    ["SoldadoBombeiro"] = {
        _config = {
            gtype = "org",
            salario = 27000,
            ptr = true,
            orgName = "Bombeiro"
        },
        "perm.chamadoshp",
        "perm.chamadosbombeiro",
        "perm.bombeiro"
    },

    ["CoronelBombeiro [CIVIL]"] = {
        _config = {
            gtype = "org",
            salario = 40000,
            ptr = true,
            orgName = "BombeiroCivil"
        },
        "perm.baubombeirocivil",
        "perm.chamadoshp",
        "perm.chamadosbombeiro",
        "perm.avisobombeirocivil",
        "dv.permissao",
        "dv.permissao",
        "perm.bombeirocivil",
        "perm.algemar",
        "perm.barreira",
    },
    ["TenenteCoronelBombeiro [CIVIL]"] = {
        _config = {
            gtype = "org",
            salario = 37000,
            ptr = true,
            orgName = "BombeiroCivil"
        },
        "perm.baubombeirocivil",
        "perm.chamadoshp",
        "perm.avisobombeirocivil",
        "dv.permissao",
        "perm.chamadosbombeiro",
        "perm.bombeirocivil",
        "perm.barreira",
        "perm.algemar"
    },
    ["MajorBombeiro [CIVIL]"] = {
        _config = {
            gtype = "org",
            salario = 35000,
            ptr = true,
            orgName = "BombeiroCivil"
        },
        "perm.chamadoshp",
        "perm.avisobombeirocivil",
        "perm.chamadosbombeiro",
        "perm.bombeirocivil",
        "perm.barreira",
        "perm.dv",
        "perm.algemar"
    },
    ["CapitaoBombeiro [CIVIL]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = true,
            orgName = "BombeiroCivil"
        },
        "perm.chamadoshp",
        "perm.bombeirocivil",
        "perm.chamadosbombeiro",
        "dv.permissao",
        "perm.barreira",
        "perm.algemar"
    },
    ["TenenteBombeiro [CIVIL]"] = {
        _config = {
            gtype = "org",
            salario = 30000,
            ptr = true,
            orgName = "BombeiroCivil"
        },
        "perm.chamadoshp",
        "perm.bombeirocivil",
        "perm.chamadosbombeiro",
        "perm.barreira",
        "perm.algemar"
    },
    ["CaboBombeiro [CIVIL]"] = {
        _config = {
            gtype = "org",
            salario = 28000,
            ptr = true,
            orgName = "BombeiroCivil"
        },
        "perm.chamadoshp",
        "perm.chamadosbombeiro",
        "perm.barreira",
        "perm.bombeirocivil"
    },
    ["SoldadoBombeiro [CIVIL]"] = {
        _config = {
            gtype = "org",
            salario = 27000,
            ptr = true,
            orgName = "BombeiroCivil"
        },
        "perm.chamadoshp",
        "perm.chamadosbombeiro",
        "perm.barreira",
        "perm.bombeirocivil"
    },
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- JUDICIARIO
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ["Desembargador"] = {
        _config = {
            gtype = "org",
            salario = 30000,
            ptr = nil,
            orgName = "Judiciario"
        },
        "dv.permissao",
        "perm.baujudiciario",
        "perm.algemar",
        "perm.trancaliderjudiciario",
        "perm.trancasjudiciario",
        "perm.arrastar",
        "perm.judiciario",
        "perm.liderjudiciario"
    },
    ["Juiz"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = nil,
            orgName = "Judiciario"
        },
        "dv.permissao",
        "perm.algemar",
        "perm.baujudiciario",
        "perm.trancaliderjudiciario",
        "perm.trancasjudiciario",
        "perm.arrastar",
        "perm.judiciario",
        "perm.liderjudiciario"
    },
    ["Promotor"] = {
        _config = {
            gtype = "org",
            salario = 20000,
            ptr = nil,
            orgName = "Judiciario"
        },
        "dv.permissao",
        "perm.baujudiciario",
        "perm.trancaliderjudiciario",
        "perm.trancasjudiciario",
        "perm.judiciario"
    },
    ["Supervisor"] = {
        _config = {
            gtype = "org",
            salario = 17000,
            ptr = nil,
            orgName = "Judiciario"
        },
        "perm.baujudiciario",
        "dv.permissao",
        "perm.trancasjudiciario",
        "perm.judiciario"
    },
    ["Advogado"] = {
        _config = {
            gtype = "org",
            salario = 14000,
            ptr = nil,
            orgName = "Judiciario"
        },
        "perm.baujudiciario",
        "perm.trancasjudiciario",
        "perm.judiciario"
    },
    ["SegurancaChef"] = {
        _config = {
            gtype = "org",
            salario = 18000,
            ptr = nil,
            orgName = "Judiciario"
        },
        "perm.judiciario"
    },
    ["Seguranca"] = {
        _config = {
            gtype = "org",
            salario = 15000,
            ptr = nil,
            orgName = "Judiciario"
        },
        "perm.judiciario"
    },
    ["EstagiarioADV"] = {
        _config = {
            gtype = "org",
            salario = 10000,
            ptr = nil,
            orgName = "Judiciario"
        },
        "perm.judiciario"
    },

    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- JORNAL
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ["DiretorJornal"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = true,
            orgName = "Jornal"
        },
        "perm.newsjornal",
        "perm.baujornal",
        "perm.jornal"
    },
    ["ProdutorJornal"] = {
        _config = {
            gtype = "org",
            salario = 20000,
            ptr = true,
            orgName = "Jornal"
        },
        "perm.newsjornal",
        "perm.baujornal",
        "perm.jornal"
    },
    ["Reporter"] = {
        _config = {
            gtype = "org",
            salario = 15000,
            ptr = true,
            orgName = "Jornal"
        },
        "perm.newsjornal",
        "perm.baujornal",
        "perm.jornal"
    },
    ["EstagiarioJornal"] = {
        _config = {
            gtype = "org",
            salario = 10000,
            ptr = true,
            orgName = "Jornal"
        },
        "perm.jornal"
    },

    ["DiretorRJ"] = {
        _config = {
            gtype = "org",
            salario = 20000,
            ptr = true,
            orgName = "StaffAlta" 
        },
        "perm.ilegal",
        "perm.staffalta"
    },
    ["AdministradorRJ"] = {
        _config = {
            gtype = "org",
            salario = 20000,
            ptr = true,
            orgName = "StaffAlta"
        },
        "perm.ilegal",
        "perm.staffalta"
    },
    ["ModeradorRJ"] = {
        _config = {
            gtype = "org",
            salario = 20000,
            ptr = true,
            orgName = "StaffAlta"
        },
        "perm.ilegal",
        "perm.staffalta"
    },
    ["SuporteRJ"] = {
        _config = {
            gtype = "org",
            salario = 20000,
            ptr = true,
            orgName = "StaffAlta"
        },
        "perm.ilegal",
        "perm.staffalta"
    },

    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
    -- ARMAS
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- MAGNATAS--
    ["Lider [MAGNATAS]"] = {
        _config = {
            gtype = "org",
            salario = 52000,
            ptr = nil,
            orgName = "Magnatas",
            orgType = "fArmas"
        },
        "perm.liderarma",
        "perm.gerentearma",
        "perm.gerentemagnatas",
        "perm.recrutadormagnatas",
        "perm.dashboard",
        "perm.magnatas",
        "perm.lidermagnatas",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baumagnatas"
    },
    ["Sub-Lider [MAGNATAS]"] = {
        _config = {
            gtype = "org",
            salario = 52000,
            ptr = nil,
            orgName = "Magnatas",
            orgType = "fArmas"
        },
        "perm.gerentearma",
        "perm.gerentemagnatas",
        "perm.lidermagnatas",
        "perm.dashboard",
        "perm.magnatas",
        "perm.arma",
        "perm.ilegal",
        "perm.recrutadormagnatas",
        "perm.snovato",
        "perm.gerente",
        "perm.baumagnatas"
    },
    ["Gerente [MAGNATAS]"] = {
        _config = {
            gtype = "org",
            salario = 52000,
            ptr = nil,
            orgName = "Magnatas",
            orgType = "fArmas"
        },
        "perm.gerentearma",
        "perm.gerentemagnatas",
        "perm.magnatas",
        "perm.recrutadormagnatas",
        "perm.dashboard",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baumagnatas"
    },
    ["Membro [MAGNATAS]"] = {
        _config = {
            gtype = "org",
            salario = 52000,
            ptr = nil,
            orgName = "Magnatas",
            orgType = "fArmas"
        },
        "perm.magnatas",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.baumagnatas"
    },
    ["Novato [MAGNATAS]"] = {
        _config = {
            gtype = "org",
            salario = 52000,
            ptr = nil,
            orgName = "Magnatas",
            orgType = "fArmas"
        },
        "perm.magnatas",
        "perm.arma",
        "perm.ilegal"
    },
    ["Recrutador [MAGNATAS]"] = {
        _config = {
            gtype = "org",
            salario = 52000,
            ptr = nil,
            orgName = "Magnatas",
            orgType = "fArmas"
        },
        "perm.recrutador",
        "perm.baumagnatas",
        "perm.recrutadormagnatas",
        "perm.dashboard",
        "perm.magnatas",
        "perm.arma",
        "perm.ilegal"
    },

    -- MAFIA--
    ["Lider [MAFIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Mafia",
            orgType = "fArmas"
        },
        "perm.liderarma",
        "perm.gerentearma",
        "perm.gerentemafia",
        "perm.dashboard",
        "perm.mafia",
        "perm.lidermafia",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baumafia"
    },
    ["Sub-Lider [MAFIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Mafia",
            orgType = "fArmas"
        },
        "perm.gerentearma",
        "perm.gerentemafia",
        "perm.lidermafia",
        "perm.dashboard",
        "perm.mafia",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baumafia"
    },
    ["Gerente [MAFIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Mafia",
            orgType = "fArmas"
        },
        "perm.gerentearma",
        "perm.gerentemafia",
        "perm.mafia",
        "perm.dashboard",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baumafia"
    },
    ["Membro [MAFIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Mafia",
            orgType = "fArmas"
        },
        "perm.mafia",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.baumafia"
    },
    ["Novato [MAFIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Mafia",
            orgType = "fArmas"
        },
        "perm.mafia",
        "perm.arma",
        "perm.ilegal"
    },
    ["Recrutador [MAFIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Mafia",
            orgType = "fArmas"
        },
        "perm.recrutador",
        "perm.baumafia",
        "perm.dashboard",
        "perm.mafia",
        "perm.arma",
        "perm.ilegal"
    },

    -- GROTA--
    ["Lider [GROTA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Grota",
            orgType = "fArmas"
        },
        "perm.liderarma",
        "perm.gerentearma",
        "perm.gerentegrota",
        "perm.grota",
        "perm.recrutadorgrota",
        "perm.dashboard",
        "perm.lidergrota",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baugrota"
    },
    ["Sub-Lider [GROTA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Grota",
            orgType = "fArmas"
        },
        "perm.gerentearma",
        "perm.gerentegrota",
        "perm.recrutadorgrota",
        "perm.dashboard",
        "perm.lidergrota",
        "perm.grota",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baugrota"
    },
    ["Gerente [GROTA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Grota",
            orgType = "fArmas"
        },
        "perm.gerentearma",
        "perm.gerentegrota",
        "perm.recrutadorgrota",
        "perm.dashboard",
        "perm.grota",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baugrota"
    },
    ["Membro [GROTA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Grota",
            orgType = "fArmas"
        },
        "perm.grota",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.baugrota"
    },
    ["Novato [GROTA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Grota",
            orgType = "fArmas"
        },
        "perm.grota",
        "perm.arma",
        "perm.ilegal"
    },
    ["Recrutador [GROTA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Grota",
            orgType = "fArmas"
        },
        "perm.recrutador",
        "perm.recrutadorgrota",
        "perm.dashboard",
        "perm.grota",
        "perm.arma",
        "perm.ilegal"
    },


    ["Lider [HOSPICIO]"] = {
        _config = {
            gtype = "org",
            salario = 17000,
            ptr = nil,
            orgName = "Hospicio",
            orgType = "fArmas"
        },
        "perm.liderarma",
        "perm.gerentearma",
        "perm.gerentehospicio",
        "perm.hospicio",
        "perm.dashboard",
        "perm.liderhospicio",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauhospicio"
    },
    ["Sub-Lider [HOSPICIO]"] = {
        _config = {
            gtype = "org",
            salario = 17000,
            ptr = nil,
            orgName = "Hospicio",
            orgType = "fArmas"
        },
        "perm.gerentearma",
        "perm.gerentehospicio",
        "perm.liderhospicio",
        "perm.hospicio",
        "perm.arma",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauhospicio"
    },
    ["Gerente [HOSPICIO]"] = {
        _config = {
            gtype = "org",
            salario = 17000,
            ptr = nil,
            orgName = "Hospicio",
            orgType = "fArmas"
        },
        "perm.gerentearma",
        "perm.gerentehospicio",
        "perm.hospicio",
        "perm.arma",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauhospicio"
    },
    ["Membro [HOSPICIO]"] = {
        _config = {
            gtype = "org",
            salario = 17000,
            ptr = nil,
            orgName = "Hospicio",
            orgType = "fArmas"
        },
        "perm.hospicio",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.bauhospicio"
    },
    ["Novato [HOSPICIO]"] = {
        _config = {
            gtype = "org",
            salario = 17000,
            ptr = nil,
            orgName = "Hospicio",
            orgType = "fArmas"
        },
        "perm.hospicio",
        "perm.arma",
        "perm.ilegal"
    },
    ["Recrutador [HOSPICIO]"] = {
        _config = {
            gtype = "org",
            salario = 17000,
            ptr = nil,
            orgName = "Hospicio",
            orgType = "fArmas"
        },
        "perm.recrutador",
        "perm.bauhospicio",
        "perm.hospicio",
        "perm.dashboard",
        "perm.arma",
        "perm.ilegal"
    },

    ["Lider [INGLATERRA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Inglaterra",
            orgType = "fArmas"
        },
        "perm.liderarma",
        "perm.gerentearma",
        "perm.dashboard",
        "perm.gerenteinglaterra",
        "perm.inglaterra",
        "perm.lideringlaterra",
        "perm.recrutadoringlaterra",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauinglaterra"
    },
    ["Sub-Lider [INGLATERRA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Inglaterra",
            orgType = "fArmas"
        },
        "perm.gerentearma",
        "perm.gerenteinglaterra",
        "perm.recrutadoringlaterra",
        "perm.lideringlaterra",
        "perm.dashboard",
        "perm.inglaterra",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauinglaterra"
    },
    ["Gerente [INGLATERRA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Inglaterra",
            orgType = "fArmas"
        },
        "perm.gerentearma",
        "perm.recrutadoringlaterra",
        "perm.gerenteinglaterra",
        "perm.inglaterra",
        "perm.arma",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauinglaterra"
    },
    ["Membro [INGLATERRA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Inglaterra",
            orgType = "fArmas"
        },
        "perm.inglaterra",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.bauinglaterra"
    },
    ["Novato [INGLATERRA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Inglaterra",
            orgType = "fArmas"
        },
        "perm.inglaterra",
        "perm.arma",
        "perm.ilegal"
    },
    ["Recrutador [INGLATERRA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Inglaterra",
            orgType = "fArmas"
        },
        "perm.recrutador",
        "perm.recrutadoringlaterra",
        "perm.bauinglaterra",
        "perm.dashboard",
        "perm.inglaterra",
        "perm.arma",
        "perm.ilegal"
    },

    -- tcp--
    ["Lider [CV]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "CV",
            orgType = "fArmas"
        },
        "perm.liderarma",
        "perm.gerentearma",
        "perm.dashboard",
        "perm.gerentecv",
        "perm.cv",
        "perm.lidercv",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baucv"
    },
    ["Sub-Lider [CV]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "CV",
            orgType = "fArmas"
        },
        "perm.gerentearma",
        "perm.gerentecv",
        "perm.lidercv",
        "perm.cv",
        "perm.dashboard",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baucv"
    },
    ["Gerente [CV]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "CV",
            orgType = "fArmas"
        },
        "perm.gerentearma",
        "perm.gerentecv",
        "perm.cv",
        "perm.dashboard",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baucv"
    },
    ["Membro [CV]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "CV",
            orgType = "fArmas"
        },
        "perm.cv",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.baucv"
    },
    ["Novato [CV]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "CV",
            orgType = "fArmas"
        },
        "perm.cv",
        "perm.arma",
        "perm.ilegal"
    },
    ["Recrutador [CV]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "CV",
            orgType = "fArmas"
        },
        "perm.cv",
        "perm.recrutador",
        "perm.baucv",
        "perm.dashboard",
        "perm.arma",
        "perm.ilegal"
    },

    -- milicia--
    ["Lider [MILICIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Milicia",
            orgType = "fArmas"
        },
        "perm.liderarma",
        "perm.gerentearma",
        "perm.dashboard",
        "perm.gerentemilicia",
        "perm.dashboard",
        "perm.milicia",
        "perm.lidermilicia",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baumilicia"
    },
    ["Sub-Lider [MILICIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Milicia",
            orgType = "fArmas"
        },
        "perm.gerentearma",
        "perm.gerentemilicia",
        "perm.lidermilicia",
        "perm.milicia",
        "perm.arma",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baumilicia"
    },
    ["Gerente [MILICIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Milicia",
            orgType = "fArmas"
        },
        "perm.gerentearma",
        "perm.gerentemilicia",
        "perm.milicia",
        "perm.arma",
        "perm.ilegal",
        "perm.dashboard",
        "perm.snovato",
        "perm.gerente",
        "perm.baumilicia"
    },
    ["Membro [MILICIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Milicia",
            orgType = "fArmas"
        },
        "perm.milicia",
        "perm.arma",
        "perm.ilegal",
        "perm.snovato",
        "perm.baumilicia"
    },
    ["Novato [MILICIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Milicia",
            orgType = "fArmas"
        },
        "perm.milicia",
        "perm.arma",
        "perm.ilegal"
    },
    ["Recrutador [MILICIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Milicia",
            orgType = "fArmas"
        },
        "perm.recrutador",
        "perm.baumilicia",
        "perm.dashboard",
        "perm.milicia",
        "perm.arma",
        "perm.ilegal"
    },
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- MUNIÇÃO
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   --[[-- CARTEL
    ["Lider [CARTEL]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Cartel",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentecartel",
        "perm.lidercartel",
        "perm.cartel",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baucartel"
    },
    ["Sub-Lider [CARTEL]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Cartel",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentecartel",
        "perm.lidercartel",
        "perm.cartel",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baucartel"
    },
    ["Gerente [CARTEL]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Cartel",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentecartel",
        "perm.cartel",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baucartel"
    },
    ["Membro [CARTEL]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Cartel",
            orgType = "fMunicao"
        },
        "perm.cartel",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.baucartel"
    },
    ["Novato [CARTEL]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Cartel",
            orgType = "fMunicao"
        },
        "perm.cartel",
        "perm.muni",
        "perm.ilegal"
    },
    ["Recrutador [CARTEL]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Cartel",
            orgType = "fMunicao"
        },
        "perm.recrutador",
        "perm.baucartel",
        "perm.dashboard",
        "perm.cartel",
        "perm.muni",
        "perm.ilegal"
    },--]]
    -- FRANCA--
    ["Lider [FRANCA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Franca",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentefranca",
        "perm.franca",
        "perm.liderfranca",
        "perm.muni",
        "perm.ilegal",
        "perm.dashboard",
        "perm.snovato",
        "perm.gerente",
        "perm.baufranca"
    },
    ["Sub-Lider [FRANCA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Franca",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentefranca",
        "perm.liderfranca",
        "perm.franca",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baufranca"
    },
    ["Gerente [FRANCA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Franca",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentefranca",
        "perm.franca",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baufranca"
    },
    ["Membro [FRANCA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Franca",
            orgType = "fMunicao"
        },
        "perm.franca",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.baufranca"
    },
    ["Novato [FRANCA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Franca",
            orgType = "fMunicao"
        },
        "perm.franca",
        "perm.muni",
        "perm.ilegal"
    },
    ["Recrutador [FRANCA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Franca",
            orgType = "fMunicao"
        },
        "perm.recrutador",
        "perm.baufranca",
        "perm.franca",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal"
    },

    -- PCC--
    ["Lider [PCC]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Pcc",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentepcc",
        "perm.pcc",
        "perm.liderpcc",
        "perm.muni",
        "perm.ilegal",
        "perm.dashboard",
        "perm.snovato",
        "perm.gerente",
        "perm.baupcc"
    },
    ["Sub-Lider [PCC]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Pcc",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentepcc",
        "perm.liderpcc",
        "perm.pcc",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baupcc"
    },
    ["Gerente [PCC]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Pcc",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentepcc",
        "perm.pcc",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baupcc"
    },
    ["Membro [PCC]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Pcc",
            orgType = "fMunicao"
        },
        "perm.pcc",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.baupcc"
    },
    ["Novato [PCC]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Pcc",
            orgType = "fMunicao"
        },
        "perm.pcc",
        "perm.muni",
        "perm.ilegal"
    },
    ["Recrutador [PCC]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Pcc",
            orgType = "fMunicao"
        },
        "perm.recrutador",
        "perm.baupcc",
        "perm.pcc",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal"
    },

    -- EGITO--
    ["Lider [EGITO]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Egito",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerenteegito",
        "perm.egito",
        "perm.lideregito",
        "perm.muni",
        "perm.ilegal",
        "perm.dashboard",
        "perm.snovato",
        "perm.gerente",
        "perm.bauegito"
    },
    ["Sub-Lider [EGITO]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Egito",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerenteegito",
        "perm.lideregito",
        "perm.egito",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauegito"
    },
    ["Gerente [EGITO]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Egito",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerenteegito",
        "perm.egito",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauegito"
    },
    ["Membro [EGITO]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Egito",
            orgType = "fMunicao"
        },
        "perm.egito",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.bauegito"
    },
    ["Novato [EGITO]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Egito",
            orgType = "fMunicao"
        },
        "perm.egito",
        "perm.muni",
        "perm.ilegal"
    },
    ["Recrutador [EGITO]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Egito",
            orgType = "fMunicao"
        },
        "perm.recrutador",
        "perm.bauegito",
        "perm.egito",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal"
    },

    -- COLOMBIA--
    ["Lider [COLOMBIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Colombia",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentecolombia",
        "perm.colombia",
        "perm.lidercolombia",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baucolombia"
    },
    ["Sub-Lider [COLOMBIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Colombia",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentecolombia",
        "perm.lidercolombia",
        "perm.colombia",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baucolombia"
    },
    ["Gerente [COLOMBIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Colombia",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentecolombia",
        "perm.colombia",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baucolombia"
    },
    ["Membro [COLOMBIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Colombia",
            orgType = "fMunicao"
        },
        "perm.colombia",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.baucolombia"
    },
    ["Novato [COLOMBIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Colombia",
            orgType = "fMunicao"
        },
        "perm.colombia",
        "perm.muni",
        "perm.ilegal"
    },
    ["Recrutador [COLOMBIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Colombia",
            orgType = "fMunicao"
        },
        "perm.recrutador",
        "perm.baucolombia",
        "perm.dashboard",
        "perm.colombia",
        "perm.muni",
        "perm.ilegal"
    },

    -- KOREA--
    ["Lider [KOREA]"] = {
        _config = {
            gtype = "org",
            salario = 18000,
            ptr = nil,
            orgName = "Korea",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentekorea",
        "perm.korea",
        "perm.liderkorea",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baukorea"
    },
    ["Sub-Lider [KOREA]"] = {
        _config = {
            gtype = "org",
            salario = 18000,
            ptr = nil,
            orgName = "Korea",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentekorea",
        "perm.liderkorea",
        "perm.korea",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baukorea"
    },
    ["Gerente [KOREA]"] = {
        _config = {
            gtype = "org",
            salario = 18000,
            ptr = nil,
            orgName = "Korea",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentekorea",
        "perm.korea",
        "perm.muni",
        "perm.ilegal",
        "perm.dashboard",
        "perm.snovato",
        "perm.gerente",
        "perm.baukorea"
    },
    ["Membro [KOREA]"] = {
        _config = {
            gtype = "org",
            salario = 18000,
            ptr = nil,
            orgName = "Korea",
            orgType = "fMunicao"
        },
        "perm.korea",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.baukorea"
    },
    ["Novato [KOREA]"] = {
        _config = {
            gtype = "org",
            salario = 18000,
            ptr = nil,
            orgName = "Korea",
            orgType = "fMunicao"
        },
        "perm.korea",
        "perm.muni",
        "perm.ilegal"
    },
    ["Recrutador [KOREA]"] = {
        _config = {
            gtype = "org",
            salario = 18000,
            ptr = nil,
            orgName = "Korea",
            orgType = "fMunicao"
        },
        "perm.recrutador",
        "perm.baukorea",
        "perm.dashboard",
        "perm.korea",
        "perm.muni",
        "perm.ilegal"
    },

    -- OKAYDA--
    ["Lider [OKAYDA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Okayda",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerenteokayda",
        "perm.okayda",
        "perm.liderokayda",
        "perm.recrutadorokayda",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauokayda"
    },
    ["Sub-Lider [OKAYDA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Okayda",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerenteokayda",
        "perm.liderokayda",
        "perm.okayda",
        "perm.muni",
        "perm.ilegal",
        "perm.dashboard",
        "perm.snovato",
        "perm.gerente",
        "perm.bauokayda"
    },
    ["Gerente [OKAYDA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Okayda",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerenteokayda",
        "perm.okayda",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauokayda"
    },
    ["Membro [OKAYDA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Okayda",
            orgType = "fMunicao"
        },
        "perm.okayda",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.bauokayda"
    },
    ["Novato [OKAYDA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Okayda",
            orgType = "fMunicao"
        },
        "perm.okayda",
        "perm.muni",
        "perm.ilegal"
    },
    ["Recrutador [OKAYDA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Okayda",
            orgType = "fMunicao"
        },
        "perm.recrutador",
        "perm.bauokayda",
        "perm.okayda",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal"
    },

    -- MEDELLIN--
    ["Lider [MEDELLIN]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Medellin",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentemedellin",
        "perm.medellin",
        "perm.lidermedellin",
        "perm.recrutadormedellin",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baumedellin"
    },
    ["Sub-Lider [MEDELLIN]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Medellin",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentemedellin",
        "perm.lidermedellin",
        "perm.medellin",
        "perm.muni",
        "perm.ilegal",
        "perm.dashboard",
        "perm.snovato",
        "perm.gerente",
        "perm.baumedellin"
    },
    ["Gerente [MEDELLIN]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Medellin",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentemedellin",
        "perm.medellin",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baumedellin"
    },
    ["Membro [MEDELLIN]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Medellin",
            orgType = "fMunicao"
        },
        "perm.medellin",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.baumedellin"
    },
    ["Novato [MEDELLIN]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Medellin",
            orgType = "fMunicao"
        },
        "perm.medellin",
        "perm.muni",
        "perm.ilegal"
    },
    ["Recrutador [MEDELLIN]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Medellin",
            orgType = "fMunicao"
        },
        "perm.recrutador",
        "perm.baumedellin",
        "perm.medellin",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal"
    },

    -- YAKUZA--
    ["Lider [YAKUZA]"] = {
        _config = {
            gtype = "org",
            salario = 52000,
            ptr = nil,
            orgName = "Yakuza",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerenteyakuza",
        "perm.yakuza",
        "perm.lideryakuza",
        "perm.recrutadoryakuza",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauyakuza"
    },
    ["Sub-Lider [YAKUZA]"] = {
        _config = {
            gtype = "org",
            salario = 52000,
            ptr = nil,
            orgName = "Yakuza",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerenteyakuza",
        "perm.lideryakuza",
        "perm.yakuza",
        "perm.muni",
        "perm.ilegal",
        "perm.dashboard",
        "perm.snovato",
        "perm.gerente",
        "perm.bauyakuza"
    },
    ["Gerente [YAKUZA]"] = {
        _config = {
            gtype = "org",
            salario = 52000,
            ptr = nil,
            orgName = "Yakuza",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerenteyakuza",
        "perm.yakuza",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauyakuza"
    },
    ["Membro [YAKUZA]"] = {
        _config = {
            gtype = "org",
            salario = 52000,
            ptr = nil,
            orgName = "Yakuza",
            orgType = "fMunicao"
        },
        "perm.yakuza",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.bauyakuza"
    },
    ["Novato [YAKUZA]"] = {
        _config = {
            gtype = "org",
            salario = 52000,
            ptr = nil,
            orgName = "Yakuza",
            orgType = "fMunicao"
        },
        "perm.yakuza",
        "perm.muni",
        "perm.ilegal"
    },
    ["Recrutador [YAKUZA]"] = {
        _config = {
            gtype = "org",
            salario = 52000,
            ptr = nil,
            orgName = "Yakuza",
            orgType = "fMunicao"
        },
        "perm.recrutador",
        "perm.bauyakuza",
        "perm.yakuza",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal"
    },
     -- CORLEONE--
    ["Lider [CORLEONE]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Corleone",
            orgType = "fArmas"
        },
        "perm.craftmuni",
        "perm.liderarma",
        "perm.gerentecorleone",
        "perm.corleone",
        "perm.lidercorleone",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baucorleone"
    },
    ["Sub-Lider [CORLEONE]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Corleone",
            orgType = "fArmas"
        },
        "perm.craftmuni",
        "perm.gerentecorleone",
        "perm.lidercorleone",
        "perm.corleone",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baucorleone"
    },
    ["Gerente [CORLEONE]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Corleone",
            orgType = "fArmas"
        },
        "perm.craftmuni",
        "perm.gerentecorleone",
        "perm.corleone",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baucorleone"
    },
    ["Membro [CORLEONE]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Corleone",
            orgType = "fArmas"
        },
        "perm.corleone",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.baucorleone"
    },
    ["Novato [CORLEONE]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Corleone",
            orgType = "fArmas"
        },
        "perm.corleone",
        "perm.muni",
        "perm.ilegal"
    },
    ["Recrutador [CORLEONE]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Corleone",
            orgType = "fArmas"
        },
        "perm.recrutador",
        "perm.baucorleone",
        "perm.dashboard",
        "perm.corleone",
        "perm.muni",
        "perm.ilegal"
    },
    -- China--
    ["Lider [CHINA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "China",
            orgType = "fArmas"
        },
        "perm.craftmuni",
        "perm.liderarma",
        "perm.gerentechina",
        "perm.china",
        "perm.liderchina",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauchina"
    },
    ["Sub-Lider [CHINA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "China",
            orgType = "fArmas"
        },
        "perm.craftmuni",
        "perm.gerentechina",
        "perm.liderchina",
        "perm.china",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauchina"
    },
    ["Gerente [CHINA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "China",
            orgType = "fArmas"
        },
        "perm.craftmuni",
        "perm.gerentechina",
        "perm.china",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauchina"
    },
    ["Membro [CHINA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "China",
            orgType = "fArmas"
        },
        "perm.china",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.bauchina"
    },
    ["Novato [CHINA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "China",
            orgType = "fArmas"
        },
        "perm.china",
        "perm.muni",
        "perm.ilegal"
    },
    ["Recrutador [CHINA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "China",
            orgType = "fArmas"
        },
        "perm.recrutador",
        "perm.bauchina",
        "perm.dashboard",
        "perm.china",
        "perm.muni",
        "perm.ilegal"
    },

    -- Tequila--
    ["Lider [TEQUILA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Tequila",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerentetequila",
        "perm.tequila",
        "perm.lidertequila",
        "perm.lavagem",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bautequila"
    },
    ["Sub-Lider [TEQUILA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Tequila",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerentetequila",
        "perm.lidertequila",
        "perm.dashboard",
        "perm.tequila",
        "perm.lavagem",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bautequila"
    },
    ["Gerente [TEQUILA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Tequila",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerentetequila",
        "perm.tequila",
        "perm.muni",
        "perm.ilegal",
        "perm.dashboard",
        "perm.snovato",
        "perm.gerente",
        "perm.bautequila"
    },
    ["Membro [TEQUILA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Tequila",
            orgType = "fLavagem"
        },
        "perm.tequila",
        "perm.lavagem",
        "perm.ilegal",
        "perm.snovato",
        "perm.bautequila"
    },
    ["Novato [TEQUILA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Tequila",
            orgType = "fLavagem"
        },
        "perm.tequila",
        "perm.lavagem",
        "perm.ilegal"
    },
    ["Recrutador [TEQUILA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Tequila",
            orgType = "fLavagem"
        },
        "perm.recrutador",
        "perm.bautequila",
        "perm.tequila",
        "perm.dashboard",
        "perm.lavagem",
        "perm.ilegal"
    },

    -- BAHAMAS--
    ["Lider [BAHAMAS]"] = {
        _config = {
            gtype = "org",
            salario = 52000,
            ptr = nil,
            orgName = "Bahamas",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerentebahamas",
        "perm.bahamas",
        "perm.liderbahamas",
        "perm.lavagem",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baubahamas"
    },
    ["Sub-Lider [BAHAMAS]"] = {
        _config = {
            gtype = "org",
            salario = 52000,
            ptr = nil,
            orgName = "Bahamas",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerentebahamas",
        "perm.liderbahamas",
        "perm.dashboard",
        "perm.bahamas",
        "perm.lavagem",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baubahamas"
    },
    ["Gerente [BAHAMAS]"] = {
        _config = {
            gtype = "org",
            salario = 52000,
            ptr = nil,
            orgName = "Bahamas",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerentebahamas",
        "perm.bahamas",
        "perm.muni",
        "perm.ilegal",
        "perm.dashboard",
        "perm.snovato",
        "perm.gerente",
        "perm.baubahamas"
    },
    ["Recrutador [BAHAMAS]"] = {
        _config = {
            gtype = "org",
            salario = 52000,
            ptr = nil,
            orgName = "Bahamas",
            orgType = "fLavagem"
        },
        "perm.recrutador",
        "perm.baubahamas",
        "perm.bahamas",
        "perm.dashboard",
        "perm.lavagem",
        "perm.ilegal"
    },
    ["Membro [BAHAMAS]"] = {
        _config = {
            gtype = "org",
            salario = 52000,
            ptr = nil,
            orgName = "Bahamas",
            orgType = "fLavagem"
        },
        "perm.bahamas",
        "perm.lavagem",
        "perm.ilegal",
        "perm.snovato",
        "perm.baubahamas"
    },
    ["Novato [BAHAMAS]"] = {
        _config = {
            gtype = "org",
            salario = 52000,
            ptr = nil,
            orgName = "Bahamas",
            orgType = "fLavagem"
        },
        "perm.bahamas",
        "perm.lavagem",
        "perm.ilegal"
    },

    -- Anonymous--
    ["Lider [ANONYMOUS]"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = nil,
            orgName = "Anonymous",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerenteanonymous",
        "perm.anonymous",
        "perm.lideranonymous",
        "perm.dashboard",
        "perm.lavagem",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauanonymous"
    },
    ["Sub-Lider [ANONYMOUS]"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = nil,
            orgName = "Anonymous",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerenteanonymous",
        "perm.lideranonymous",
        "perm.anonymous",
        "perm.dashboard",
        "perm.lavagem",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauanonymous"
    },
    ["Gerente [ANONYMOUS]"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = nil,
            orgName = "Anonymous",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerenteanonymous",
        "perm.anonymous",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauanonymous"
    },
    ["Membro [ANONYMOUS]"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = nil,
            orgName = "Anonymous",
            orgType = "fLavagem"
        },
        "perm.anonymous",
        "perm.lavagem",
        "perm.ilegal",
        "perm.snovato",
        "perm.bauanonymous"
    },
    ["Novato [ANONYMOUS]"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = nil,
            orgName = "Anonymous",
            orgType = "fLavagem"
        },
        "perm.anonymous",
        "perm.lavagem",
        "perm.ilegal"
    },
    ["Recrutador [ANONYMOUS]"] = {
        _config = {
            gtype = "org",
            salario = 25000,
            ptr = nil,
            orgName = "Anonymous",
            orgType = "fLavagem"
        },
        "perm.recrutador",
        "perm.bauanonymous",
        "perm.anonymous",
        "perm.dashboard",
        "perm.lavagem",
        "perm.ilegal"
    },

        -- Sete--
    ["Lider [SETE]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Sete",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerentesete",
        "perm.sete",
        "perm.dashboard",
        "perm.lidersete",
        "perm.lavagem",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bausete"
    },
    ["Sub-Lider [SETE]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Sete",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerentesete",
        "perm.lidersete",
        "perm.sete",
        "perm.lavagem",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bausete"
    },
    ["Gerente [SETE]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Sete",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerentesete",
        "perm.sete",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bausete"
    },
    ["Membro [SETE]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Sete",
            orgType = "fLavagem"
        },
        "perm.sete",
        "perm.lavagem",
        "perm.ilegal",
        "perm.snovato",
        "perm.bausete"
    },
    ["Novato [SETE]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Sete",
            orgType = "fLavagem"
        },
        "perm.sete",
        "perm.lavagem",
        "perm.ilegal"
    },
    ["Recrutador [SETE]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Sete",
            orgType = "fLavagem"
        },
        "perm.recrutador",
        "perm.bausete",
        "perm.sete",
        "perm.dashboard",
        "perm.lavagem",
        "perm.ilegal"
    },
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- DESMANCHE
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
     -- ESCOCIA--
     ["Lider [ESCOCIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Escocia",
            orgType = "fDesmanche"
        },
        "perm.craftdesmanche",
        "perm.gerenteescocia",
        "perm.escocia",
        "perm.liderescocia",
        "perm.desmanche",
        "perm.ilegal",
        "perm.dashboard",
        "perm.snovato",
        "perm.gerente",
        "perm.bauescocia"
    },
    ["Sub-Lider [ESCOCIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Escocia",
            orgType = "fDesmanche"
        },
        "perm.craftdesmanche",
        "perm.gerenteescocia",
        "perm.liderescocia",
        "perm.escocia",
        "perm.dashboard",
        "perm.desmanche",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauescocia"
    },
    ["Gerente [ESCOCIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Escocia",
            orgType = "fDesmanche"
        },
        "perm.craftdesmanche",
        "perm.gerenteescocia",
        "perm.escocia",
        "perm.desmanche",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauescocia"
    },
    ["Membro [ESCOCIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Escocia",
            orgType = "fDesmanche"
        },
        "perm.escocia",
        "perm.desmanche",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.bauescocia"
    },
    ["Novato [ESCOCIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Escocia",
            orgType = "fDesmanche"
        },
        "perm.escocia",
        "perm.desmanche",
        "perm.ilegal"
    },
    ["Recrutador [ESCOCIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Escocia",
            orgType = "fDesmanche"
        },
        "perm.recrutador",
        "perm.bauescocia",
        "perm.escocia",
        "perm.dashboard",
        "perm.desmanche",
        "perm.ilegal"
    },

    -- cdd--
    ["Lider [CDD]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "CDD",
            orgType = "fDesmanche"
        },
        "perm.craftdesmanche",
        "perm.gerentecdd",
        "perm.cdd",
        "perm.lidercdd",
        "perm.dashboard",
        "perm.gerentecdd",
        "perm.desmanche",
        "perm.recrutadorcdd",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baucdd"
    },
    ["Sub-Lider [CDD]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "CDD",
            orgType = "fDesmanche"
        },
        "perm.craftdesmanche",
        "perm.gerentecdd",
        "perm.lidercdd",
        "perm.gerentecdd",
        "perm.cdd",
        "perm.desmanche",
        "perm.ilegal",
        "perm.dashboard",
        "perm.snovato",
        "perm.recrutadorcdd",
        "perm.gerente",
        "perm.baucdd"
    },
    ["Gerente [CDD]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "CDD",
            orgType = "fDesmanche"
        },
        "perm.craftdesmanche",
        "perm.gerentecdd",
        "perm.gerentecdd",
        "perm.recrutadorcdd",
        "perm.dashboard",
        "perm.cdd",
        "perm.desmanche",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baucdd"
    },
    ["Membro [CDD]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "CDD",
            orgType = "fDesmanche"
        },
        "perm.cdd",
        "perm.ilegal",
        "perm.snovato",
        "perm.baucdd"
    },
    ["Novato [CDD]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "CDD",
            orgType = "fDesmanche"
        },
        "perm.cdd",
        "perm.ilegal"
    },
    ["Recrutador [CDD]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "CDD",
            orgType = "fDesmanche"
        },
        "perm.recrutador",
        "perm.recrutadorcdd",
        "perm.dashboard",
        "perm.baucdd",
        "perm.cdd",
        "perm.desmanche",
        "perm.ilegal"
    },

    -- hellsangels--
    ["Lider [HELLSANGELS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "HellsAngels",
            orgType = "fDesmanche"
        },
        "perm.craftdesmanche",
        "perm.gerentehells",
        "perm.liderhellsangels",
        "perm.dashboard",
        "perm.hellsangels",
        "perm.desmanche",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauhellsangels",
        "perm.bauliderhellsangels"
    },
    ["Sub-Lider [HELLSANGELS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "HellsAngels",
            orgType = "fDesmanche"
        },
        "perm.craftdesmanche",
        "perm.gerentehells",
        "perm.liderhellsangels",
        "perm.hellsangels",
        "perm.desmanche",
        "perm.ilegal",
        "perm.dashboard",
        "perm.snovato",
        "perm.gerente",
        "perm.bauhellsangels",
        "perm.bauliderhellsangels"
    },
    ["Gerente [HELLSANGELS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "HellsAngels",
            orgType = "fDesmanche"
        },
        "perm.craftdesmanche",
        "perm.gerentehells",
        "perm.hellsangels",
        "perm.desmanche",
        "perm.dashboard",
        "perm.ilegal",
        "perm.bauhellsangels",
        "perm.snovato",
        "perm.gerente",
        "perm.bauliderhellsangels"
    },
    ["Membro [HELLSANGELS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "HellsAngels",
            orgType = "fDesmanche"
        },
        "perm.hellsangels",
        "perm.desmanche",
        "perm.ilegal",
        "perm.snovato",
        "perm.bauhellsangels"
    },
    ["Novato [HELLSANGELS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "HellsAngels",
            orgType = "fDesmanche"
        },
        "perm.hellsangels",
        "perm.ilegal"
    },
    ["Recrutador [HELLSANGELS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "HellsAngels",
            orgType = "fDesmanche"
        },
        "perm.recrutador",
        "perm.bauhellsangels",
        "perm.hellsangels",
        "perm.dashboard",
        "perm.desmanche",
        "perm.ilegal"
    },

    -- motoclub--
    ["Lider [MOTOCLUBE]"] = {
        _config = {
            gtype = "org",
            salario = 17000,
            ptr = nil,
            orgName = "Motoclube",
            orgType = "fDesmanche"
        },
        "perm.craftdesmanche",
        "perm.gerentemotoclube",
        "perm.dashboard",
        "perm.lidermotoclube",
        "perm.motoclube",
        "perm.desmanche",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baumotoclube",
        "perm.recrutadormotoclube",
        "perm.baulidermotoclube"
    },
    ["Sub-Lider [MOTOCLUBE]"] = {
        _config = {
            gtype = "org",
            salario = 17000,
            ptr = nil,
            orgName = "Motoclube",
            orgType = "fDesmanche"
        },
        "perm.craftdesmanche",
        "perm.gerentemotoclube",
        "perm.lidermotoclube",
        "perm.motoclube",
        "perm.dashboard",
        "perm.desmanche",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.recrutadormotoclube",
        "perm.baumotoclube",
        "perm.baulidermotoclube"
        
    },
    ["Gerente [MOTOCLUBE]"] = {
        _config = {
            gtype = "org",
            salario = 17000,
            ptr = nil,
            orgName = "Motoclube",
            orgType = "fDesmanche"
        },
        "perm.gerentemotoclube",
        "perm.motoclube",
        "perm.desmanche",
        "perm.dashboard",
        "perm.ilegal",
        "perm.baumotoclube",
        "perm.snovato",
        "perm.recrutadormotoclube",
        "perm.gerente",
        "perm.baulidermotoclube"
    },
    ["Membro [MOTOCLUBE]"] = {
        _config = {
            gtype = "org",
            salario = 17000,
            ptr = nil,
            orgName = "Motoclube",
            orgType = "fDesmanche"
        },
        "perm.motoclube",
        "perm.desmanche",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.baumotoclube"
    },
    ["Novato [MOTOCLUBE]"] = {
        _config = {
            gtype = "org",
            salario = 17000,
            ptr = nil,
            orgName = "Motoclube",
            orgType = "fDesmanche"
        },
        "perm.motoclube",
        "perm.ilegal"
    },
    ["Recrutador [MOTOCLUBE]"] = {
        _config = {
            gtype = "org",
            salario = 17000,
            ptr = nil,
            orgName = "Motoclube",
            orgType = "fDesmanche"
        },
        "perm.recrutador",
        "perm.baumotoclube",
        "perm.motoclube",
        "perm.dashboard",
        "perm.recrutadormotoclube",
        "perm.desmanche",
        "perm.ilegal"
    },

    -- lacoste--
    ["Lider [LACOSTE]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Lacoste",
            orgType = "fDesmanche"
        },
        "perm.craftdesmanche",
        "perm.gerentelacoste",
        "perm.liderlacoste",
        "perm.lacoste",
        "perm.dashboard",
        "perm.liderbaulacoste",
        "perm.desmanche",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baulacoste"
    },
    ["Sub-Lider [LACOSTE]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Lacoste",
            orgType = "fDesmanche"
        },
        "perm.craftdesmanche",
        "perm.gerentelacoste",
        "perm.liderlacoste",
        "perm.lacoste",
        "perm.liderbaulacoste",
        "perm.desmanche",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baulacoste"
    },
    ["Gerente [LACOSTE]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Lacoste",
            orgType = "fDesmanche"
        },
        "perm.craftdesmanche",
        "perm.gerentelacoste",
        "perm.lacoste",
        "perm.desmanche",
        "perm.liderbaulacoste",
        "perm.ilegal",
        "perm.dashboard",
        "perm.snovato",
        "perm.gerente",
        "perm.baulacoste"
    },
    ["Membro [LACOSTE]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Lacoste",
            orgType = "fDesmanche"
        },
        "perm.lacoste",
        "perm.desmanche",
        "perm.ilegal",
        "perm.snovato",
        "perm.baulacoste"
    },
    ["Novato [LACOSTE]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Lacoste",
            orgType = "fDesmanche"
        },
        "perm.lacoste",
        "perm.ilegal"
    },
    ["Recrutador [LACOSTE]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Lacoste",
            orgType = "fDesmanche"
        },
        "perm.recrutador",
        "perm.baulacoste",
        "perm.dashboard",
        "perm.lacoste",
        "perm.desmanche",
        "perm.ilegal"
    },

    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- LAVAGEM 
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    -- LUX--
    ["Lider [LUX]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Lux",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerentelux",
        "perm.gerentelux",
        "perm.dashboard",
        "perm.liderlux",
        "perm.lux",
        "perm.lavagem",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baulux"
    },
    ["Sub-Lider [LUX]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Lux",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerentelux",
        "perm.gerentelux",
        "perm.liderlux",
        "perm.dashboard",
        "perm.lux",
        "perm.lavagem",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baulux"
    },
    ["Gerente [LUX]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Lux",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerentelux",
        "perm.gerentelux",
        "perm.lux",
        "perm.lavagem",
        "perm.ilegal",
        "perm.snovato",
        "perm.dashboard",
        "perm.gerente",
        "perm.baulux"
    },
    ["Membro [LUX]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Lux",
            orgType = "fLavagem"
        },
        "perm.lux",
        "perm.lavagem",
        "perm.ilegal",
        "perm.snovato",
        "perm.baulux"
    },
    ["Novato [LUX]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Lux",
            orgType = "fLavagem"
        },
        "perm.lux",
        "perm.lavagem",
        "perm.ilegal"
    },
    ["Recrutador [LUX]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Lux",
            orgType = "fLavagem"
        },
        "perm.recrutador",
        "perm.baulux",
        "perm.dashboard",
        "perm.lux",
        "perm.lavagem",
        "perm.ilegal"
    },

    -- anubis--
    ["Lider [ANUBIS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Anubis",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerenteanubis",
        "perm.lideranubis",
        "perm.anubis",
        "perm.dashboard",
        "perm.lavagem",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauanubis"
    },
    ["Sub-Lider [ANUBIS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Anubis",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerenteanubis",
        "perm.lideranubis",
        "perm.anubis",
        "perm.dashboard",
        "perm.lavagem",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauanubis"
    },
    ["Gerente [ANUBIS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Anubis",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerenteanubis",
        "perm.anubis",
        "perm.lavagem",
        "perm.ilegal",
        "perm.dashboard",
        "perm.snovato",
        "perm.gerente",
        "perm.bauanubis"
    },
    ["Membro [ANUBIS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Anubis",
            orgType = "fLavagem"
        },
        "perm.anubis",
        "perm.lavagem",
        "perm.ilegal",
        "perm.snovato",
        "perm.bauanubis"
    },
    ["Novato [ANUBIS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Anubis",
            orgType = "fLavagem"
        },
        "perm.anubis",
        "perm.lavagem",
        "perm.ilegal"
    },
    ["Recrutador [ANUBIS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Anubis",
            orgType = "fLavagem"
        },
        "perm.recrutador",
        "perm.bauanubis",
        "perm.anubis",
        "perm.dashboard",
        "perm.lavagem",
        "perm.ilegal"
    },

    -- CASSINO--
    ["Lider [CASSINO]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Cassino",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerentecassino",
        "perm.cassino",
        "perm.lidercassino",
        "perm.lavagem",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.gerente",
        "perm.baucassino",
        "perm.baulidercassino"
    },
    ["Sub-Lider [CASSINO]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Cassino",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerentecassino",
        "perm.lidercassino",
        "perm.dashboard",
        "perm.cassino",
        "perm.lavagem",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baucassino",
        "perm.baulidercassino"
    },
    ["Gerente [CASSINO]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Cassino",
            orgType = "fLavagem"
        },
        "perm.craftlavagem",
        "perm.gerentecassino",
        "perm.dashboard",
        "perm.cassino",
        "perm.lavagem",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baucassino",
        "perm.baulidercassino"
    },
    ["Membro [CASSINO]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Cassino",
            orgType = "fLavagem"
        },
        "perm.cassino",
        "perm.lavagem",
        "perm.ilegal",
        "perm.snovato",
        "perm.baucassino"
    },
    ["Novato [CASSINO]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Cassino",
            orgType = "fLavagem"
        },
        "perm.cassino",
        "perm.lavagem",
        "perm.ilegal"
    },
    ["Recrutador [CASSINO]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Cassino",
            orgType = "fLavagem"
        },
        "perm.recrutador",
        "perm.baucassino",
        "perm.dashboard",
        "perm.cassino",
        "perm.lavagem",
        "perm.ilegal"
    },
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- DROGAS
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        -- BRATVA
    ["Lider [BRATVA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Bratva",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentebratva",
        "perm.liderbratva",
        "perm.bratva",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baubratva"
    },
    ["Sub-Lider [BRATVA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Bratva",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentebratva",
        "perm.liderbratva",
        "perm.bratva",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baubratva"
    },
    ["Gerente [BRATVA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Bratva",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentebratva",
        "perm.bratva",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baubratva"
    },
    ["Membro [BRATVA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Bratva",
            orgType = "fMunicao"
        },
        "perm.bratva",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.baubratva"
    },
    ["Novato [BRATVA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Bratva",
            orgType = "fMunicao"
        },
        "perm.bratva",
        "perm.muni",
        "perm.ilegal"
    },
    ["Recrutador [BRATVA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Bratva",
            orgType = "fMunicao"
        },
        "perm.recrutador",
        "perm.baubratva",
        "perm.dashboard",
        "perm.bratva",
        "perm.muni",
        "perm.ilegal"
    },
    
    -- MEXICO
    ["Lider [MEXICO]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Mexico",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentemexico",
        "perm.lidermexico",
        "perm.mexico",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baumexico"
    },
    ["Sub-Lider [MEXICO]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Mexico",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentemexico",
        "perm.lidermexico",
        "perm.mexico",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baumexico"
    },
    ["Gerente [MEXICO]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Mexico",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentemexico",
        "perm.mexico",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baumexico"
    },
    ["Membro [MEXICO]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Mexico",
            orgType = "fMunicao"
        },
        "perm.mexico",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.baumexico"
    },
    ["Novato [MEXICO]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Mexico",
            orgType = "fMunicao"
        },
        "perm.mexico",
        "perm.muni",
        "perm.ilegal"
    },
    ["Recrutador [MEXICO]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Mexico",
            orgType = "fMunicao"
        },
        "perm.recrutador",
        "perm.baumexico",
        "perm.dashboard",
        "perm.mexico",
        "perm.muni",
        "perm.ilegal"
    },
    
    -- Vatincao
    ["Lider [VATICANO]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Vaticano",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentevaticano",
        "perm.lidervaticano",
        "perm.vaticano",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauvaticano"
    },
    ["Sub-Lider [VATICANO]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Vaticano",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentevaticano",
        "perm.lidervaticano",
        "perm.vaticano",
        "perm.dashboard",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauvaticano"
    },
    ["Gerente [VATICANO]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Vaticano",
            orgType = "fMunicao"
        },
        "perm.craftmuni",
        "perm.gerentevaticano",
        "perm.vaticano",
        "perm.muni",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauvaticano"
    },
    ["Membro [VATICANO]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Vaticano",
            orgType = "fMunicao"
        },
        "perm.vaticano",
        "perm.muni",
        "perm.ilegal",
        "perm.snovato",
        "perm.bauvaticano"
    },
    ["Novato [VATICANO]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Vaticano",
            orgType = "fMunicao"
        },
        "perm.vaticano",
        "perm.muni",
        "perm.ilegal"
    },
    ["Recrutador [VATICANO]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Vaticano",
            orgType = "fMunicao"
        },
        "perm.recrutador",
        "perm.bauvaticano",
        "perm.dashboard",
        "perm.vaticano",
        "perm.muni",
        "perm.ilegal"
    },

  
    -- ABUTRES--
    ["Lider [ABUTRES]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Abutres",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.membrosabutres",
        "perm.gerenteabutres",
        "perm.abutres",
        "perm.liderabutres",
        "perm.dashboard",
        "perm.drogas",
        "perm.lancaperfume",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauabutres"
    },
    ["Sub-Lider [ABUTRES]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Abutres",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.membrosabutres",
        "perm.gerenteabutres",
        "perm.liderabutres",
        "perm.abutres",
        "perm.dashboard",
        "perm.drogas",
        "perm.ilegal",
        "perm.lancaperfume",
        "perm.snovato",
        "perm.gerente",
        "perm.bauabutres"
    },
    ["Gerente [ABUTRES]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Abutres",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.membrosabutres",
        "perm.gerenteabutres",
        "perm.abutres",
        "perm.drogas",
        "perm.dashboard",
        "perm.ilegal",
        "perm.lancaperfume",
        "perm.snovato",
        "perm.gerente",
        "perm.bauabutres"
    },
    ["Membro [ABUTRES]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Abutres",
            orgType = "Drogas"
        },
        "perm.membrosabutres",
        "perm.abutres",
        "perm.drogas",
        "perm.ilegal",
        "perm.lancaperfume",
        "perm.snovato",
        "perm.bauabutres"
    },
    ["Novato [ABUTRES]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Abutres",
            orgType = "Drogas"
        },
        "perm.abutres",
        "perm.drogas",
        "perm.lancaperfume",
        "perm.ilegal"
    },
    ["Recrutador [ABUTRES]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Abutres",
            orgType = "Drogas"
        },
        "perm.recrutador",
        "perm.bauabutres",
        "perm.abutres",
        "perm.dashboard",
        "perm.drogas",
        "perm.lancaperfume",
        "perm.ilegal"
    },
    -- ELEMENTS--
    ["Lider [ELEMENTS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Elements",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.membroselements",
        "perm.gerenteelements",
        "perm.elements",
        "perm.liderelements",
        "perm.dashboard",
        "perm.drogas",
        "perm.lancaperfume",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauelements"
    },
    ["Sub-Lider [ELEMENTS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Elements",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.membroselements",
        "perm.gerenteelements",
        "perm.liderelements",
        "perm.elements",
        "perm.dashboard",
        "perm.drogas",
        "perm.ilegal",
        "perm.lancaperfume",
        "perm.snovato",
        "perm.gerente",
        "perm.bauelements"
    },
    ["Gerente [ELEMENTS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Elements",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.membroselements",
        "perm.gerenteelements",
        "perm.elements",
        "perm.drogas",
        "perm.dashboard",
        "perm.ilegal",
        "perm.lancaperfume",
        "perm.snovato",
        "perm.gerente",
        "perm.bauelements"
    },
    ["Membro [ELEMENTS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Elements",
            orgType = "Drogas"
        },
        "perm.membroselements",
        "perm.elements",
        "perm.drogas",
        "perm.ilegal",
        "perm.lancaperfume",
        "perm.snovato",
        "perm.bauelements"
    },
    ["Novato [ELEMENTS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Elements",
            orgType = "Drogas"
        },
        "perm.elements",
        "perm.drogas",
        "perm.lancaperfume",
        "perm.ilegal"
    },
    ["Recrutador [ELEMENTS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Elements",
            orgType = "Drogas"
        },
        "perm.recrutador",
        "perm.bauelements",
        "perm.elements",
        "perm.dashboard",
        "perm.drogas",
        "perm.lancaperfume",
        "perm.ilegal"
    },

    -- ITALIA--
    ["Lider [ITALIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Italia",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.membrositalia",
        "perm.gerenteitalia",
        "perm.italia",
        "perm.lideritalia",
        "perm.dashboard",
        "perm.drogas",
        "perm.lancaperfume",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauitalia"
    },
    ["Sub-Lider [ITALIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Italia",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.membrositalia",
        "perm.gerenteitalia",
        "perm.lideritalia",
        "perm.italia",
        "perm.dashboard",
        "perm.drogas",
        "perm.ilegal",
        "perm.lancaperfume",
        "perm.snovato",
        "perm.gerente",
        "perm.bauitalia"
    },
    ["Gerente [ITALIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Italia",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.membrositalia",
        "perm.gerenteitalia",
        "perm.italia",
        "perm.drogas",
        "perm.dashboard",
        "perm.ilegal",
        "perm.lancaperfume",
        "perm.snovato",
        "perm.gerente",
        "perm.bauitalia"
    },
    ["Membro [ITALIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Italia",
            orgType = "Drogas"
        },
        "perm.membrositalia",
        "perm.italia",
        "perm.drogas",
        "perm.ilegal",
        "perm.lancaperfume",
        "perm.snovato",
        "perm.bauitalia"
    },
    ["Novato [ITALIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Italia",
            orgType = "Drogas"
        },
        "perm.italia",
        "perm.drogas",
        "perm.lancaperfume",
        "perm.ilegal"
    },
    ["Recrutador [ITALIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Italia",
            orgType = "Drogas"
        },
        "perm.recrutador",
        "perm.bauitalia",
        "perm.italia",
        "perm.dashboard",
        "perm.drogas",
        "perm.lancaperfume",
        "perm.ilegal"
    },

    -- MEDUSA--
    ["Lider [MEDUSA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Medusa",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.membrosmedusa",
        "perm.gerentemedusa",
        "perm.medusa",
        "perm.lidermedusa",
        "perm.dashboard",
        "perm.drogas",
        "perm.lancaperfume",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baumedusa"
    },
    ["Sub-Lider [MEDUSA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Medusa",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.membrosmedusa",
        "perm.gerentemedusa",
        "perm.lidermedusa",
        "perm.medusa",
        "perm.dashboard",
        "perm.drogas",
        "perm.ilegal",
        "perm.lancaperfume",
        "perm.snovato",
        "perm.gerente",
        "perm.baumedusa"
    },
    ["Gerente [MEDUSA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Medusa",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.membrosmedusa",
        "perm.gerentemedusa",
        "perm.medusa",
        "perm.drogas",
        "perm.dashboard",
        "perm.ilegal",
        "perm.lancaperfume",
        "perm.snovato",
        "perm.gerente",
        "perm.baumedusa"
    },
    ["Membro [MEDUSA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Medusa",
            orgType = "Drogas"
        },
        "perm.membrosmedusa",
        "perm.medusa",
        "perm.drogas",
        "perm.ilegal",
        "perm.lancaperfume",
        "perm.snovato",
        "perm.baumedusa"
    },
    ["Novato [MEDUSA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Medusa",
            orgType = "Drogas"
        },
        "perm.medusa",
        "perm.drogas",
        "perm.lancaperfume",
        "perm.ilegal"
    },
    ["Recrutador [MEDUSA]"] = {
        _config = {
            gtype = "org",
            salario = 32000,
            ptr = nil,
            orgName = "Medusa",
            orgType = "Drogas"
        },
        "perm.recrutador",
        "perm.baumedusa",
        "perm.medusa",
        "perm.dashboard",
        "perm.drogas",
        "perm.lancaperfume",
        "perm.ilegal"
    },

   -- -- GRECIA--
   ["Lider [GRECIA]"] = {
       _config = {
           gtype = "org",
           salario = 30000,
           ptr = nil,
           orgName = "Grecia",
           orgType = "Drogas"
       },
       "perm.craftdrogas",
       "perm.gerentegrecia",
       "perm.grecia",
       "perm.lidergrecia",
       "perm.drogas",
       "perm.dashboard",
       "perm.lancaperfume",
       "perm.ilegal",
       "perm.snovato",
       "perm.gerente",
       "perm.baugrecia"
   },
   ["Sub-Lider [GRECIA]"] = {
       _config = {
           gtype = "org",
           salario = 30000,
           ptr = nil,
           orgName = "Grecia",
           orgType = "Drogas"
       },
       "perm.craftdrogas",
       "perm.gerentegrecia",
       "perm.lidergrecia",
       "perm.grecia",
       "perm.dashboard",
       "perm.drogas",
       "perm.ilegal",
       "perm.snovato",
       "perm.gerente",
       "perm.baugrecia"
   },
   ["Gerente [GRECIA]"] = {
       _config = {
           gtype = "org",
           salario = 30000,
           ptr = nil,
           orgName = "Grecia",
           orgType = "Drogas"
       },
       "perm.craftdrogas",
       "perm.gerentegrecia",
       "perm.grecia",
       "perm.drogas",
       "perm.dashboard",
       "perm.ilegal",
       "perm.lancaperfume",
       "perm.snovato",
       "perm.gerente",
       "perm.baugrecia"
   },
   ["Membro [GRECIA]"] = {
       _config = {
           gtype = "org",
           salario = 30000,
           ptr = nil,
           orgName = "Grecia",
           orgType = "Drogas"
       },
       "perm.grecia",
       "perm.drogas",
       "perm.dashboard",
       "perm.ilegal",
       "perm.lancaperfume",
       "perm.snovato",
       "perm.baugrecia"
   },
   ["Novato [GRECIA]"] = {
       _config = {
           gtype = "org",
           salario = 30000,
           ptr = nil,
           orgName = "Grecia",
           orgType = "Drogas"
       },
       "perm.grecia",
       "perm.drogas",
       "perm.lancaperfume",
       "perm.ilegal"
   },
   ["Recrutador [GRECIA]"] = {
       _config = {
           gtype = "org",
           salario = 30000,
           ptr = nil,
           orgName = "Grecia",
           orgType = "Drogas"
       },
       "perm.recrutador",
       "perm.baugrecia",
       "perm.grecia",
       "perm.dashboard",
       "perm.drogas",
       "perm.lancaperfume",
       "perm.ilegal"
   },
    -- RUSSIA--
    ["Lider [RUSSIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Russia",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.gerenterussia",
        "perm.russia",
        "perm.liderrussia",
        "perm.dashboard",
        "perm.lancaperfume",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baurussia",
        "perm.liderbaurussia",
        "perm.liderdoliderbaurussia"
    },
    ["Sub-Lider [RUSSIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Russia",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.gerenterussia",
        "perm.liderrussia",
        "perm.russia",
        "perm.dashboard",
        "perm.lancaperfume",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baurussia",
        "perm.liderbaurussia"
    },
    ["Gerente [RUSSIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Russia",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.gerenterussia",
        "perm.russia",
        "perm.lancaperfume",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.baurussia",
    },
    ["Membro [RUSSIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Russia",
            orgType = "Drogas"
        },
        "perm.russia",
        "perm.lancaperfume",
        "perm.ilegal",
        "perm.snovato",
        "perm.baurussia"
    },
    ["Novato [RUSSIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Russia",
            orgType = "Drogas"
        },
        "perm.russia",
        "perm.lancaperfume",
        "perm.ilegal"
    },
    ["Recrutador [RUSSIA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Russia",
            orgType = "Drogas"
        },
        "perm.recrutador",
        "perm.baurussia",
        "perm.russia",
        "perm.dashboard",
        "perm.lancaperfume",
        "perm.ilegal"
    },


    -- IRLANDA-- 
    ["Lider [IRLANDA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Irlanda",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.gerenteirlanda",
        "perm.irlanda",
        "perm.liderirlanda",
        "perm.dashboard",
        "perm.drogas",
        "perm.balinha",
        "perm.ilegal",
        "perm.bauirlanda",
        "perm.snovato",
        "perm.gerente",
        "perm.bauliderirlanda"
    },
    ["Sub-Lider [IRLANDA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Irlanda",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.gerenteirlanda",
        "perm.liderirlanda",
        "perm.irlanda",
        "perm.dashboard",
        "perm.drogas",
        "perm.ilegal",
        "perm.balinha",
        "perm.bauirlanda",
        "perm.snovato",
        "perm.gerente",
        "perm.bauliderirlanda"
    },
    ["Gerente [IRLANDA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Irlanda",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.gerenteirlanda",
        "perm.irlanda",
        "perm.drogas",
        "perm.dashboard",
        "perm.ilegal",
        "perm.balinha",
        "perm.snovato",
        "perm.gerente",
        "perm.bauirlanda"
    },
    ["Membro [IRLANDA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Irlanda",
            orgType = "Drogas"
        },
        "perm.irlanda",
        "perm.drogas",
        "perm.ilegal",
        "perm.balinha",
        "perm.snovato",
        "perm.bauirlanda"
    },
    ["Novato [IRLANDA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Irlanda",
            orgType = "Drogas"
        },
        "perm.irlanda",
        "perm.drogas",
        "perm.balinha",
        "perm.ilegal"
    },
    ["Recrutador [IRLANDA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Irlanda",
            orgType = "Drogas"
        },
        "perm.recrutador",
        "perm.bauirlanda",
        "perm.irlanda",
        "perm.dashboard",
        "perm.drogas",
        "perm.cocaina",
        "perm.ilegal"
    },

    -- PSICO-- 
    ["Lider [PSICO]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Psico",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.gerentepsico",
        "perm.psico",
        "perm.liderpsico",
        "perm.dashboard",
        "perm.drogas",
        "perm.balinha",
        "perm.ilegal",
        "perm.baupsico",
        "perm.snovato",
        "perm.gerente",
        "perm.bauliderpsico"
    },
    ["Sub-Lider [PSICO]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Psico",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.gerentepsico",
        "perm.liderpsico",
        "perm.psico",
        "perm.dashboard",
        "perm.drogas",
        "perm.ilegal",
        "perm.balinha",
        "perm.baupsico",
        "perm.snovato",
        "perm.gerente",
        "perm.bauliderpsico"
    },
    ["Gerente [PSICO]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Psico",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.gerentepsico",
        "perm.psico",
        "perm.drogas",
        "perm.dashboard",
        "perm.ilegal",
        "perm.balinha",
        "perm.snovato",
        "perm.gerente",
        "perm.baupsico"
    },
    ["Membro [PSICO]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Psico",
            orgType = "Drogas"
        },
        "perm.psico",
        "perm.drogas",
        "perm.ilegal",
        "perm.balinha",
        "perm.snovato",
        "perm.baupsico"
    },
    ["Novato [PSICO]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Psico",
            orgType = "Drogas"
        },
        "perm.psico",
        "perm.drogas",
        "perm.balinha",
        "perm.ilegal"
    },
    ["Recrutador [PSICO]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Psico",
            orgType = "Drogas"
        },
        "perm.recrutador",
        "perm.baupsico",
        "perm.psico",
        "perm.dashboard",
        "perm.drogas",
        "perm.cocaina",
        "perm.ilegal"
    },

    -- SINDICATO-- 
    ["Lider [SINDICATO]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Sindicato",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.gerentesindicato",
        "perm.sindicato",
        "perm.lidersindicato",
        "perm.dashboard",
        "perm.drogas",
        "perm.balinha",
        "perm.ilegal",
        "perm.bausindicato",
        "perm.snovato",
        "perm.gerente",
        "perm.baulidersindicato"
    },
    ["Sub-Lider [SINDICATO]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Sindicato",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.gerentesindicato",
        "perm.lidersindicato",
        "perm.sindicato",
        "perm.dashboard",
        "perm.drogas",
        "perm.ilegal",
        "perm.balinha",
        "perm.bausindicato",
        "perm.snovato",
        "perm.gerente",
        "perm.baulidersindicato"
    },
    ["Gerente [SINDICATO]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Sindicato",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.gerentesindicato",
        "perm.sindicato",
        "perm.drogas",
        "perm.dashboard",
        "perm.ilegal",
        "perm.balinha",
        "perm.snovato",
        "perm.gerente",
        "perm.bausindicato"
    },
    ["Membro [SINDICATO]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Sindicato",
            orgType = "Drogas"
        },
        "perm.sindicato",
        "perm.drogas",
        "perm.ilegal",
        "perm.balinha",
        "perm.snovato",
        "perm.bausindicato"
    },
    ["Novato [SINDICATO]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Sindicato",
            orgType = "Drogas"
        },
        "perm.sindicato",
        "perm.drogas",
        "perm.balinha",
        "perm.ilegal"
    },
    ["Recrutador [SINDICATO]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Sindicato",
            orgType = "Drogas"
        },
        "perm.recrutador",
        "perm.bausindicato",
        "perm.sindicato",
        "perm.dashboard",
        "perm.drogas",
        "perm.cocaina",
        "perm.ilegal"
    },

    -- taliba-- 
    ["Lider [TALIBA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Taliba",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.gerentetaliba",
        "perm.taliba",
        "perm.lidertaliba",
        "perm.dashboard",
        "perm.drogas",
        "perm.balinha",
        "perm.ilegal",
        "perm.bautaliba",
        "perm.snovato",
        "perm.gerente",
        "perm.baulidertaliba"
    },
    ["Sub-Lider [TALIBA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Taliba",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.gerentetaliba",
        "perm.lidertaliba",
        "perm.taliba",
        "perm.dashboard",
        "perm.drogas",
        "perm.ilegal",
        "perm.balinha",
        "perm.bautaliba",
        "perm.snovato",
        "perm.gerente",
        "perm.baulidertaliba"
    },
    ["Gerente [TALIBA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Taliba",
            orgType = "Drogas"
        },
        "perm.craftdrogas",
        "perm.gerentetaliba",
        "perm.taliba",
        "perm.drogas",
        "perm.dashboard",
        "perm.ilegal",
        "perm.balinha",
        "perm.snovato",
        "perm.gerente",
        "perm.bautaliba"
    },
    ["Membro [TALIBA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Taliba",
            orgType = "Drogas"
        },
        "perm.taliba",
        "perm.drogas",
        "perm.ilegal",
        "perm.balinha",
        "perm.snovato",
        "perm.bautaliba"
    },
    ["Novato [TALIBA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Taliba",
            orgType = "Drogas"
        },
        "perm.taliba",
        "perm.drogas",
        "perm.balinha",
        "perm.ilegal"
    },
    ["Recrutador [TALIBA]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Taliba",
            orgType = "Drogas"
        },
        "perm.recrutador",
        "perm.bautaliba",
        "perm.taliba",
        "perm.dashboard",
        "perm.drogas",
        "perm.cocaina",
        "perm.ilegal"
    },

    -- ROXOS-- 
    ["Lider [ROXOS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Roxos",
            orgType = "fDesmanche"
        },
        "perm.craftdrogas",
        "perm.gerenteroxos",
        "perm.roxos",
        "perm.liderroxos",
        "perm.desmanche",
        "perm.dashboard",
        "perm.ilegal",
        "perm.craftdesmanche",
        "perm.bauroxos",
        "perm.snovato",
        "perm.gerente",
        "perm.bauliderroxos"
    },
    ["Sub-Lider [ROXOS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Roxos",
            orgType = "fDesmanche"
        },
        "perm.craftdrogas",
        "perm.gerenteroxos",
        "perm.liderroxos",
        "perm.craftdesmanche",
        "perm.roxos",
        "perm.desmanche",
        "perm.dashboard",
        "perm.ilegal",
        "perm.bauroxos",
        "perm.snovato",
        "perm.gerente",
        "perm.bauliderroxos"
    },
    ["Gerente [ROXOS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Roxos",
            orgType = "fDesmanche"
        },
        "perm.craftdrogas",
        "perm.gerenteroxos",
        "perm.roxos",
        "perm.craftdesmanche",
        "perm.desmanche",
        "perm.dashboard",
        "perm.ilegal",
        "perm.snovato",
        "perm.gerente",
        "perm.bauroxos"
    },
    ["Membro [ROXOS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Roxos",
            orgType = "fDesmanche"
        },
        "perm.roxos",
        "perm.desmanche",
        "perm.ilegal",
        "perm.heroina",
        "perm.bauroxos"
    },
    ["Novato [ROXOS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Roxos",
            orgType = "fDesmanche"
        },
        "perm.roxos",
        "perm.ilegal"
    },
    ["Recrutador [ROXOS]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Roxos",
            orgType = "fDesmanche"
        },
        "perm.recrutador",
        "perm.bauroxos",
        "perm.dashboard",
        "perm.roxos",
        "perm.desmanche",
        "perm.ilegal"
    },

    ["Lider [COHAB]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Cohab",
            orgType = "fDesmanche"
        },
        "perm.gerentecohab",
        "perm.cohab",
        "perm.craftdesmanche",
        "perm.dashboard",
        "perm.snovato",
        "perm.gerente",
        "perm.lidercohab",
        "perm.baucohab",
        "perm.desmanche",
        "perm.ilegal"
    },
    ["Sub-Lider [COHAB]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Cohab",
            orgType = "fDesmanche"
        },
        "perm.gerentecohab",
        "perm.cohab",
        "perm.snovato",
        "perm.gerente",
        "perm.craftdesmanche",
        "perm.dashboard",
        "perm.baucohab",
        "perm.lidercohab",
        "perm.desmanche",
        "perm.ilegal"
    },
    ["Gerente [COHAB]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Cohab",
            orgType = "fDesmanche"
        },
        "perm.gerentecohab",
        "perm.cohab",
        "perm.snovato",
        "perm.gerente",
        "perm.dashboard",
        "perm.craftdesmanche",
        "perm.baucohab",
        "perm.desmanche",
        "perm.ilegal"
    },
    ["Membro [COHAB]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Cohab",
            orgType = "fDesmanche"
        },
        "perm.cohab",
        "perm.snovato",
        "perm.baucohab",
        "perm.ilegal"
    },
    ["Novato [COHAB]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Cohab",
            orgType = "fDesmanche"
        },
        "perm.cohab",
        "perm.ilegal"
    },
    ["Recrutador [COHAB]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Cohab",
            orgType = "fDesmanche"
        },
        "perm.recrutador",
        "perm.baucohab",
        "perm.dashboard",
        "perm.cohab",
        "perm.ilegal"
    },

    ["Lider [BENNYS]"] = {
        _config = {
            gtype = "org",
            salario = 15000,
            ptr = nil,
            orgName = "Bennys",
            orgType = "fDesmanche"
        },
        "perm.gerentebennys",
        "perm.bennys",
        "perm.craftdesmanche",
        "perm.snovato",
        "perm.gerente",
        "perm.liderbennys",
        "perm.baubennys",
        "perm.desmanche",
        "perm.ilegal",
        "perm.recrutadorbennys",
    },
    ["Sub-Lider [BENNYS]"] = {
        _config = {
            gtype = "org",
            salario = 15000,
            ptr = nil,
            orgName = "Bennys",
            orgType = "fDesmanche"
        },
        "perm.gerentebennys",
        "perm.bennys",
        "perm.snovato",
        "perm.craftdesmanche",
        "perm.gerente",
        "perm.baubennys",
        "perm.dashboard",
        "perm.liderbennys",
        "perm.desmanche",
        "perm.ilegal",
        "perm.recrutadorbennys",

    },
    ["Gerente [BENNYS]"] = {
        _config = {
            gtype = "org",
            salario = 15000,
            ptr = nil,
            orgName = "Bennys",
            orgType = "fDesmanche"
        },
        "perm.gerentebennys",
        "perm.bennys",
        "perm.dashboard",
        "perm.craftdesmanche",
        "perm.snovato",
        "perm.gerente",
        "perm.baubennys",
        "perm.desmanche",
        "perm.ilegal",
        "perm.recrutadorbennys",
    },
    ["Membro [BENNYS]"] = {
        _config = {
            gtype = "org",
            salario = 15000,
            ptr = nil,
            orgName = "Bennys",
            orgType = "fDesmanche"
        },
        "perm.bennys",
        "perm.snovato",
        "perm.baubennys",
        "perm.desmanche",
        "perm.dashboard",
        "perm.ilegal"
    },
    ["Novato [BENNYS]"] = {
        _config = {
            gtype = "org",
            salario = 15000,
            ptr = nil,
            orgName = "Bennys",
            orgType = "fDesmanche"
        },
        "perm.bennys",
        "perm.desmanche",
        "perm.ilegal"
    },
    ["Recrutador [BENNYS]"] = {
        _config = {
            gtype = "org",
            salario = 15000,
            ptr = nil,
            orgName = "Bennys",
            orgType = "fDesmanche"
        },
        "perm.recrutador",
        "perm.baubennys",
        "perm.bennys",
        "perm.dashboard",
        "perm.desmanche",
        "perm.ilegal",
        "perm.recrutadorbennys",
    },
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Bennys
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ["Lider [Mecanica]"] = {
        _config = {
            gtype = "org",
            salario = 5000,
            ptr = nil,
            orgName = "Mecanica"
        },
        "perm.chamadomec",
        "dv.permissao",
        "perm.arrastarmecanica",
        "perm.avisomc",
        "perm.dashboard",
        "perm.gerentemecanica",
        "dv.permissao",
        "perm.mecanica",
        "perm.lidermecanica",
        "perm.tunar",
        "perm.arrastar",
        "perm.snovato",
        "perm.gerente",
        "perm.baumecanica"
    },
    ["Sub-Lider [Mecanica]"] = {
        _config = {
            gtype = "org",
            salario = 4000,
            ptr = nil,
            orgName = "Mecanica"
        },
        "perm.chamadomec",
        "dv.permissao",
        "perm.arrastarmecanica",
        "perm.avisomc",
        "perm.gerentemecanica",
        "perm.dashboard",
        "perm.mecanica",
        "perm.tunar",
        "perm.arrastar",
        "perm.lidermecanica",
        "perm.snovato",
        "perm.gerente",
        "perm.baumecanica"
    },
    ["Gerente [Mecanica]"] = {
        _config = {
            gtype = "org",
            salario = 3500,
            ptr = nil,
            orgName = "Mecanica"
        },
        "perm.chamadomec",
        "dv.permissao",
        "perm.arrastarmecanica",
        "perm.avisomc",
        "perm.dashboard",
        "perm.gerentemecanica",
        "perm.mecanica",
        "perm.tunar",
        "perm.arrastar",
        "perm.snovato",
        "perm.gerente",
        "perm.baumecanica"
    },
    ["Membro [Mecanica]"] = {
        _config = {
            gtype = "org",
            salario = 3000,
            ptr = nil,
            orgName = "Mecanica"
        },
        "perm.chamadomec",
        "perm.mecanica",
        "perm.tunar",
        "perm.snovato",
        "perm.baumecanica"
    },
    ["Novato [Mecanica]"] = {
        _config = {
            gtype = "org",
            salario = 2500,
            ptr = nil,
            orgName = "Mecanica"
        },
        "perm.chamadomec",
        "perm.mecanica",
        "perm.tunar"
    },
    ["Recrutador [Mecanica]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Mecanica"
        },
        "perm.chamadomec",
        "perm.recrutador",
        "perm.dashboard",
        "perm.mecanica",
        "perm.tunar"
    },

    ["Lider [Deboxe]"] = {
        _config = {
            gtype = "org",
            salario = 5000,
            ptr = nil,
            orgName = "Deboxe"
        },
        "perm.chamadomec",
        "perm.gerentedeboxe",
        "perm.arrastarmecanica",
        "dv.permissao",
        "perm.arrastardeboxe",
        "perm.avisomc",
        "perm.gerentedeboxe",
        "dv.permissao",
        "perm.deboxe",
        "perm.liderdeboxe",
        "perm.tunar",
        "perm.arrastar",
        "perm.snovato",
        "perm.gerente",
        "perm.baudeboxe"
    },
    ["Sub-Lider [Deboxe]"] = {
        _config = {
            gtype = "org",
            salario = 4000,
            ptr = nil,
            orgName = "Deboxe"
        },
        "perm.chamadomec",
        "perm.gerentedeboxe",
        "perm.arrastarmecanica",
        "dv.permissao",
        "perm.arrastardeboxe",
        "perm.avisomc",
        "perm.dashboard",
        "perm.gerentedeboxe",
        "perm.deboxe",
        "perm.tunar",
        "perm.arrastar",
        "perm.liderdeboxe",
        "perm.snovato",
        "perm.gerente",
        "perm.baudeboxe"
    },
    ["Gerente [Deboxe]"] = {
        _config = {
            gtype = "org",
            salario = 3500,
            ptr = nil,
            orgName = "Deboxe"
        },
        "perm.chamadomec",
        "perm.gerentedeboxe",
        "dv.permissao",
        "perm.arrastarmecanica",
        "perm.dashboard",
        "perm.arrastardeboxe",
        "perm.avisomc",
        "perm.gerentedeboxe",
        "perm.deboxe",
        "perm.tunar",
        "perm.arrastar",
        "perm.snovato",
        "perm.gerente",
        "perm.baudeboxe"
    },
    ["Supervisor [Deboxe]"] = {
        _config = {
            gtype = "org",
            salario = 3500,
            ptr = nil,
            orgName = "Deboxe"
        },
        "perm.chamadomec",
        "dv.permissao",
        "perm.arrastarmecanica",
        "perm.dashboard",
        "perm.arrastardeboxe",
        "perm.avisomc",
        "perm.deboxe",
        "perm.tunar",
        "perm.snovato",
        "perm.baudeboxe"
    },
    ["Recrutador [Deboxe]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Deboxe"
        },
        "perm.chamadomec",
        "perm.recrutador",
        "perm.dashboard",
        "perm.deboxe",
        "perm.tunar"
    },
    ["Membro [Deboxe]"] = {
        _config = {
            gtype = "org",
            salario = 3000,
            ptr = nil,
            orgName = "Deboxe"
        },
        "perm.chamadomec",
        "perm.deboxe",
        "perm.tunar",
        "perm.snovato",
        "perm.baudeboxe"
    },
    ["Novato [Deboxe]"] = {
        _config = {
            gtype = "org",
            salario = 2500,
            ptr = nil,
            orgName = "Deboxe"
        },
        "perm.chamadomec",
        "perm.deboxe",
    },

    ["Lider [StoMotors]"] = {
        _config = {
            gtype = "org",
            salario = 5000,
            ptr = nil,
            orgName = "Stomotors"
        },
        "perm.chamadomec",
        "perm.gerentestomotors",
        "perm.arrastarmecanica",
        "dv.permissao",
        "perm.arrastarstomotors",
        "perm.avisomc",
        "perm.gerentestomotors",
        "dv.permissao",
        "perm.stomotors",
        "perm.liderstomotors",
        "perm.tunar",
        "perm.arrastar",
        "perm.snovato",
        "perm.gerente",
        "perm.baustomotors"
    },
    ["Sub-Lider [StoMotors]"] = {
        _config = {
            gtype = "org",
            salario = 4000,
            ptr = nil,
            orgName = "Stomotors"
        },
        "perm.chamadomec",
        "perm.gerentestomotors",
        "perm.arrastarmecanica",
        "dv.permissao",
        "perm.arrastarstomotors",
        "perm.avisomc",
        "perm.dashboard",
        "perm.gerentestomotors",
        "perm.stomotors",
        "perm.tunar",
        "perm.arrastar",
        "perm.liderstomotors",
        "perm.snovato",
        "perm.gerente",
        "perm.baustomotors"
    },
    ["Gerente [StoMotors]"] = {
        _config = {
            gtype = "org",
            salario = 3500,
            ptr = nil,
            orgName = "Stomotors"
        },
        "perm.chamadomec",
        "perm.gerentestomotors",
        "dv.permissao",
        "perm.arrastarmecanica",
        "perm.dashboard",
        "perm.arrastarstomotors",
        "perm.avisomc",
        "perm.gerentestomotors",
        "perm.stomotors",
        "perm.tunar",
        "perm.arrastar",
        "perm.snovato",
        "perm.gerente",
        "perm.baustomotors"
    },
    ["Supervisor [StoMotors]"] = {
        _config = {
            gtype = "org",
            salario = 3500,
            ptr = nil,
            orgName = "Stomotors"
        },
        "perm.chamadomec",
        "dv.permissao",
        "perm.arrastarmecanica",
        "perm.dashboard",
        "perm.arrastarstomotors",
        "perm.avisomc",
        "perm.stomotors",
        "perm.tunar",
        "perm.arrastar",
        "perm.snovato",
        "perm.baustomotors"
    },
    ["Recrutador [StoMotors]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Stomotors"
        },
        "perm.chamadomec",
        "perm.recrutador",
        "perm.dashboard",
        "perm.stomotors",
        "perm.tunar"
    },
    ["Membro [StoMotors]"] = {
        _config = {
            gtype = "org",
            salario = 3000,
            ptr = nil,
            orgName = "Stomotors"
        },
        "perm.chamadomec",
        "perm.stomotors",
        "perm.tunar",
        "perm.snovato",
        "perm.baustomotors"
    },
    ["Novato [StoMotors]"] = {
        _config = {
            gtype = "org",
            salario = 2500,
            ptr = nil,
            orgName = "Stomotors"
        },
        "perm.chamadomec",
        "perm.stomotors",
    },

    ["Lider [Sickomotors]"] = {
        _config = {
            gtype = "org",
            salario = 5000,
            ptr = nil,
            orgName = "Sickomotors"
        },
        "perm.chamadomec",
        "perm.gerentesickomotors",
        "perm.arrastarmecanica",
        "dv.permissao",
        "perm.arrastarsickomotors",
        "perm.avisomc",
        "perm.gerentesickomotors",
        "dv.permissao",
        "perm.sickomotors",
        "perm.lidersickomotors",
        "perm.tunar",
        "perm.arrastar",
        "perm.snovato",
        "perm.gerente",
        "perm.bausickomotors"
    },
    ["Sub-Lider [Sickomotors]"] = {
        _config = {
            gtype = "org",
            salario = 4000,
            ptr = nil,
            orgName = "Sickomotors"
        },
        "perm.chamadomec",
        "perm.gerentesickomotors",
        "perm.arrastarmecanica",
        "dv.permissao",
        "perm.arrastarsickomotors",
        "perm.avisomc",
        "perm.dashboard",
        "perm.gerentesickomotors",
        "perm.sickomotors",
        "perm.tunar",
        "perm.arrastar",
        "perm.lidersickomotors",
        "perm.snovato",
        "perm.gerente",
        "perm.bausickomotors"
    },
    ["Gerente [Sickomotors]"] = {
        _config = {
            gtype = "org",
            salario = 3500,
            ptr = nil,
            orgName = "Sickomotors"
        },
        "perm.chamadomec",
        "perm.gerentesickomotors",
        "dv.permissao",
        "perm.arrastarmecanica",
        "perm.dashboard",
        "perm.arrastarsickomotors",
        "perm.avisomc",
        "perm.gerentesickomotors",
        "perm.sickomotors",
        "perm.tunar",
        "perm.arrastar",
        "perm.snovato",
        "perm.gerente",
        "perm.bausickomotors"
    },
    ["Supervisor [Sickomotors]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Sickomotors"
        },
        "perm.chamadomec",
        "perm.recrutador",
        "dv.permissao",
        "perm.arrastarmecanica",
        "perm.dashboard",
        "perm.arrastarsickomotors",
        "perm.sickomotors",
        "perm.bausickomotors",
        "perm.tunar"
    },
    ["Recrutador [Sickomotors]"] = {
        _config = {
            gtype = "org",
            salario = 3000,
            ptr = nil,
            orgName = "Sickomotors"
        },
        "perm.chamadomec",
        "perm.sickomotors",
        "perm.tunar",
        "perm.snovato",
    },
    ["Mecanico [Sickomotors]"] = {
        _config = {
            gtype = "org",
            salario = 2500,
            ptr = nil,
            orgName = "Sickomotors"
        },
        "perm.chamadomec",
        "perm.sickomotors",
        "perm.tunar"
    },

    ["Lider [Race]"] = {
        _config = {
            gtype = "org",
            salario = 5000,
            ptr = nil,
            orgName = "Race"
        },
        "perm.chamadomec",
        "perm.gerenterace",
        "perm.dashboard",
        "dv.permissao",
        "perm.arrastarmecanica",
        "perm.arrastarrace",
        "perm.avisomc",
        "perm.gerenterace",
        "dv.permissao",
        "perm.race",
        "perm.liderrace",
        "perm.tunar",
        "perm.arrastar",
        "perm.snovato",
        "perm.gerente",
        "perm.baurace"
    },
    ["Sub-Lider [Race]"] = {
        _config = {
            gtype = "org",
            salario = 4000,
            ptr = nil,
            orgName = "Race"
        },
        "perm.chamadomec",
        "perm.gerenterace",
        "dv.permissao",
        "perm.dashboard",
        "perm.arrastarrace",
        "perm.avisomc",
        "perm.gerenterace",
        "perm.race",
        "perm.arrastarmecanica",
        "perm.tunar",
        "perm.arrastar",
        "perm.liderrace",
        "perm.snovato",
        "perm.gerente",
        "perm.baurace"
    },
    ["Gerente [Race]"] = {
        _config = {
            gtype = "org",
            salario = 3500,
            ptr = nil,
            orgName = "Race"
        },
        "perm.chamadomec",
        "perm.gerenterace",
        "dv.permissao",
        "perm.arrastarrace",
        "perm.dashboard",
        "perm.avisomc",
        "perm.arrastarmecanica",
        "perm.gerenterace",
        "perm.race",
        "perm.tunar",
        "perm.arrastar",
        "perm.snovato",
        "perm.gerente",
        "perm.baurace"
    },
    ["Supervisor [Race]"] = {
        _config = {
            gtype = "org",
            salario = 3500,
            ptr = nil,
            orgName = "Race"
        },
        "perm.chamadomec",
        "dv.permissao",
        "perm.arrastarrace",
        "perm.avisomc",
        "perm.race",
        "perm.tunar",
        "perm.arrastar",
        "perm.snovato",
        "perm.baurace"
    },
    ["Recrutador [Race]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Race"
        },
        "perm.chamadomec",
        "dv.permissao",
        "perm.recrutador",
        "perm.baurace",
        "perm.race",
        "perm.dashboard",
        "perm.tunar"
    },
    ["Membro [Race]"] = {
        _config = {
            gtype = "org",
            salario = 3000,
            ptr = nil,
            orgName = "Race"
        },
        "perm.chamadomec",
        "perm.race",
        "perm.tunar",
        "perm.snovato",
        "perm.baurace"
    },
    ["Novato [Race]"] = {
        _config = {
            gtype = "org",
            salario = 2500,
            ptr = nil,
            orgName = "Race"
        },
        "perm.chamadomec",
        "perm.race",
    },

    ["Lider [Redline]"] = {
        _config = {
            gtype = "org",
            salario = 5000,
            ptr = nil,
            orgName = "Redline"
        },
        "perm.chamadomec",
        "perm.gerenteredline",
        "perm.dashboard",
        "dv.permissao",
        "perm.arrastarmecanica",
        "perm.arrastarredline",
        "perm.avisomc",
        "perm.gerenteredline",
        "perm.redline",
        "perm.liderredline",
        "perm.tunar",
        "perm.arrastar",
        "perm.snovato",
        "perm.gerente",
        "perm.bauredline"
    },
    ["Sub-Lider [Redline]"] = {
        _config = {
            gtype = "org",
            salario = 4000,
            ptr = nil,
            orgName = "Redline"
        },
        "perm.chamadomec",
        "perm.gerenteredline",
        "dv.permissao",
        "perm.dashboard",
        "perm.arrastarredline",
        "perm.avisomc",
        "perm.gerenteredline",
        "perm.redline",
        "perm.arrastarmecanica",
        "perm.tunar",
        "perm.arrastar",
        "perm.liderredline",
        "perm.snovato",
        "perm.gerente",
        "perm.bauredline"
    },
    ["Gerente [Redline]"] = {
        _config = {
            gtype = "org",
            salario = 3500,
            ptr = nil,
            orgName = "Redline"
        },
        "perm.chamadomec",
        "perm.gerenteredline",
        "dv.permissao",
        "perm.arrastarredline",
        "perm.dashboard",
        "perm.avisomc",
        "perm.arrastarmecanica",
        "perm.gerenteredline",
        "perm.redline",
        "perm.tunar",
        "perm.arrastar",
        "perm.snovato",
        "perm.gerente",
        "perm.bauredline"
    },
    ["Supervisor [Redline]"] = {
        _config = {
            gtype = "org",
            salario = 3500,
            ptr = nil,
            orgName = "Redline"
        },
        "perm.chamadomec",
        "dv.permissao",
        "perm.arrastarredline",
        "perm.avisomc",
        "perm.redline",
        "perm.tunar",
        "perm.snovato",
        "perm.bauredline"
    },
    ["Recrutador [Redline]"] = {
        _config = {
            gtype = "org",
            salario = 2000,
            ptr = nil,
            orgName = "Redline"
        },
        "perm.chamadomec",
        "dv.permissao",
        "perm.recrutador",
        "perm.bauredline",
        "perm.redline",
        "perm.dashboard",
        "perm.tunar"
    },
    ["Membro [Redline]"] = {
        _config = {
            gtype = "org",
            salario = 3000,
            ptr = nil,
            orgName = "Redline"
        },
        "perm.chamadomec",
        "perm.redline",
        "perm.tunar",
        "perm.snovato",
        "perm.bauredline"
    },
    ["Novato [Redline]"] = {
        _config = {
            gtype = "org",
            salario = 2500,
            ptr = nil,
            orgName = "Redline"
        },
        "perm.chamadomec",
        "perm.redline",
    },

    ["Lider [MAISONETTE]"] = {
        _config = {
            gtype = "org",
            salario = 5000,
            ptr = nil,
            orgName = "Maisonette"
        },
        "perm.gerentemaisonette",
        "perm.dashboard",
        "dv.permissao",
        "perm.maisonette",
        "perm.snovato",
        "perm.gerente",
        "perm.lidermaisonette",
        "perm.baumaisonette"
    },
    ["Sub-Lider [MAISONETTE]"] = {
        _config = {
            gtype = "org",
            salario = 5000,
            ptr = nil,
            orgName = "Maisonette"
        },
        "perm.gerentemaisonette",
        "perm.maisonette",
        "perm.snovato",
        "perm.dashboard",
        "perm.gerente",
        "perm.baumaisonette",
        "perm.lidermaisonette"
    },
    ["Gerente [MAISONETTE]"] = {
        _config = {
            gtype = "org",
            salario = 5000,
            ptr = nil,
            orgName = "Maisonette"
        },
        "perm.gerentemaisonette",
        "perm.maisonette",
        "perm.dashboard",
        "perm.snovato",
        "perm.gerente",
        "perm.baumaisonette"
    },
    ["Membro [MAISONETTE]"] = {
        _config = {
            gtype = "org",
            salario = 5000,
            ptr = nil,
            orgName = "Maisonette"
        },
        "perm.maisonette",
        "perm.snovato",
        "perm.baumaisonette"
    },
    ["Novato [MAISONETTE]"] = {
        _config = {
            gtype = "org",
            salario = 5000,
            ptr = nil,
            orgName = "Maisonette"
        },
        "perm.maisonette"
    },
    ["Recrutador [MAISONETTE]"] = {
        _config = {
            gtype = "org",
            salario = 5000,
            ptr = nil,
            orgName = "Maisonette"
        },
        "perm.recrutador",
        "perm.baumaisonette",
        "perm.dashboard",
        "perm.maisonette"
    },

    ["Lider [VANILLA]"] = {
        _config = {
            gtype = "org",
            salario = 5000,
            ptr = nil,
            orgName = "Vanilla"
        },
        "perm.ilegal",
        "perm.gerentevanilla",
        "perm.dashboard",
        "dv.permissao",
        "perm.vanilla",
        "perm.snovato",
        "perm.gerente",
        "perm.lidervanilla",
        "perm.bauvanilla"
    },
    ["Sub-Lider [VANILLA]"] = {
        _config = {
            gtype = "org",
            salario = 5000,
            ptr = nil,
            orgName = "Vanilla"
        },
        "perm.ilegal",
        "perm.gerentevanilla",
        "perm.vanilla",
        "perm.snovato",
        "perm.dashboard",
        "perm.gerente",
        "perm.bauvanilla",
        "perm.lidervanilla"
    },
    ["Gerente [VANILLA]"] = {
        _config = {
            gtype = "org",
            salario = 5000,
            ptr = nil,
            orgName = "Vanilla"
        },
        "perm.ilegal",
        "perm.gerentevanilla",
        "perm.vanilla",
        "perm.dashboard",
        "perm.snovato",
        "perm.gerente",
        "perm.bauvanilla"
    },
    ["Dancarina [VANILLA]"] = {
        _config = {
            gtype = "org",
            salario = 5000,
            ptr = nil,
            orgName = "Vanilla"
        },
        "perm.ilegal",
        "perm.vanilla",
        "perm.snovato",
        "perm.bauvanilla"
    },
    ["Seguranca [VANILLA]"] = {
        _config = {
            gtype = "org",
            salario = 5000,
            ptr = nil,
            orgName = "Vanilla"
        },
        "perm.ilegal",
        "perm.vanilla"
    },

    ["Professora [ALTAKIDS]"] = {
        _config = {
            gtype = "org",
            salario = 20000,
            ptr = nil,
            orgName = "AltaKids"
        },
        "perm.kids",
        "perm.liderkids",
        "perm.mochila"
    },
    ["Ajudante [ALTAKIDS]"] = {
        _config = {
            gtype = "org",
            salario = 5000,
            ptr = nil,
            orgName = "AltaKids"
        },
        "perm.kids",
        "perm.mochila"
    },
    ["Crianca [ALTAKIDS]"] = {
        _config = {
            gtype = "org",
            salario = 5000,
            ptr = nil,
            orgName = "AltaKids"
        },
        "perm.kids",
        "perm.mochila"
    },

    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
    -- MANSAO
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ["dandara"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.dandara"
    },
    ["mansaoarrancadiu"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.mansaoarrancadiu"
    },
    ["mansaodavinci"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.mansaodavinci"
    },
    ["mansaowolf"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.mansaowolf"
    },
    ["mansaolobo"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.mansaolobo"
    },
    ["mansaobillions"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.mansaobillions"
    },
    ["mansaoserena"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.mansaoserena"
    },
    ["m400"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.m400"
    },
    ["block"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.block"
    },
    ["ilhadodavinci"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.ilhadodavinci"
    },
    ["ilhashodai"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.ilhashodai"
    },
    ["ally"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.ally"
    },
    ["respjuridico"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.respjuridico"
    },
    ["BlacklistPolicia"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.blacklistpolicia"
    },
    ["auxiliareventos"] = {
        _config = {
            salario = nil,
            ptr = nil
        },
        "perm.auxiliareventos",
        "player.som",
    },
}

cfg.users = {}

cfg.selectors = {}

return cfg