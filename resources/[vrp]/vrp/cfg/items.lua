local cfg = {}
-- ITEM | NOME | DESC | TYPE | PESO | FOME | SEDE

cfg.items = {
	["none"] = { "none", "none", 0.0, nil, nil},
	["roupas"] = { "Roupas", "none", 0.0, nil, nil},
	["money"] = { "Dinheiro","none", 0.00001, nil, nil},
	
	-- ITENS VIP
	["alterarplaca"] = { "Alterar Placa", "usarVIP", 0.0, nil, nil},
	["alterarrg"] = { "Alterar RG", "usarVIP", 0.0, nil, nil},
	["alterartelefone"] = { "Alterar Telefone", "usarVIP", 0.0, nil, nil},
	["plastica"] = { "Plastica", "usarVIP", 0.0, nil, nil},
	["valemansao500k"] = { "Vale mansao 500k", "usarVIP", 0.0, nil, nil},
	["valemansao1m"] = { "Vale mansao 1m", "usarVIP", 0.0, nil, nil},
	["valemansao8m"] = { "Vale mansao 8m", "usarVIP", 0.0, nil, nil},
	["valemansao10m"] = { "Vale mansao 10m", "usarVIP", 0.0, nil, nil},
	["valemansao100m"] = { "Vale mansao 100m", "usarVIP", 0.0, nil, nil},

	-- Utilitarios
	["mochila"] = { "Mochila", "usar", 2.0, nil, nil},
	["skate"] = { "Skate", "usar", 1.0, nil, nil},
	["algemas"] = { "Algemas", "usar", 2.0, nil, nil},
	["ticket"] = { "Ticket Corrida", "usar", 1.0, nil, nil},
	["plastico"] = { "Plástico", "usar", 1.0, nil, nil},
	["distintivopolicial"] = { "Distintivo Policial", "usar", 0.3, nil, nil},
	["corda"] = { "Corda", "usar", 1.0, nil, nil},
	["chave_algemas"] = { "Chave de algemas", "usar", 0.3, nil, nil},
	["emptybottle"] = { "Garrafa Vazia", "usar", 0.2, nil, nil},
	["attachs"] = { "Attachs", "usar", 0.2, nil, nil},
	["alianca"] = { "Alianca", "usar", 1.0, nil, nil},
	["mamadeira"] = { "Mamadeira", "usar", 0.5, nil, nil},

	-- Mecanica
	["pneus"] = { "Pneus","usar", 10.0, nil, nil},
	["repairkit"] = { "Jogue Fora", "none", 1.0, nil, nil},
	["kitnitro"] = { "Kit de Nitro", "usar", 1.0, nil, nil},
	["fireworks"] = { "Fogos de Artifício", "usar", 0.5, nil, nil},

	["garrafanitro"] = { "Garrafa de Nitro", "usar", 1.0, nil, nil},
	["ferramenta"] = { "Ferramenta", "usar", 1.0, nil, nil},
	["repairkit2"] = { "Jogue Fora", "usar", 1.0, nil, nil},
	["repairkit3"] = { "Kit Reparo", "usar", 1.0, nil, nil},
	["militec"] = { "Militec", "usar", 1.0, nil, nil},
	-- Eletronicos
	["radio"] = { "Radio", "none", 1.0, nil, nil},
    ["celular"] = { "Celular", "none", 1.0, nil, nil},
    ["barricada"] = { "Barricada", "none", 1.0, nil, nil},
    ["apple_watch"] = { "Apple Watch", "none", 0.5, nil, nil},

	-- Itens para Roubar
	["keycard"] = { "Keycard", "none", 1.0, nil, nil},
	["c4"] = { "C4", "none", 5.0, nil, nil},
	--["bolsadinheiro"] = { "Bolsa de Dinheiro", "none", 2.0, nil, nil},
	["masterpick"] = { "MasterPick", "none", 1.0, nil, nil},
	["pendrive"] = { "Pendrive", "none", 1.0, nil, nil},
	["furadeira"] = { "Furadeira", "none", 3.0, nil, nil},
	["lockpick"] = { "Lock Pick", "usar", 1.0, nil, nil},
	--["colete"] = { "Colete", "usar", 1.0, nil, nil},
	["macarico"] = { "Maçarico", "usar", 1.0, nil, nil},

	-- Itens Mafia
    ["m-aco"] = { "Aço", "none", 0.3, nil, nil},
	["metal"] = { "Placa de Metal", "none", 0.15, nil, nil},
	["pecadearma"] = { "Peça de arma", "none", 0.1, nil, nil},
	["molas"] = { "Molas", "none", 0.15, nil, nil},
    ["m-capa_colete"] = { "Capa Colete", "none", 0.50, nil, nil},
    ["m-corpo_ak47_mk2"] = { "Corpo de AK47", "none", 5.0, nil, nil},
    ["m-corpo_g3"] = { "Corpo de G3", "none", 5.0, nil, nil},
    ["m-corpo_machinepistol"] = { "Corpo de TEC-9", "none", 2.0, nil, nil},
    ["m-corpo_pistol_mk2"] = { "Corpo de Pistol", "none", 1.5, nil, nil},
    ["m-corpo_shotgun"] = { "Corpo de Shotgun", "none", 5.0, nil, nil},
    ["m-corpo_smg_mk2"] = { "Corpo de SMG", "none", 2.0, nil, nil},
    ["m-corpo_snspistol_mk2"] = { "Corpo de Fajuta", "none", 1.0, nil, nil},
    ["m-gatilho"] = { "Gatilho", "none", 0.80, nil, nil},
	["gatilho"] = { "Gatilho", "none", 0.20, nil, nil},
    ["m-malha"] = { "Malha", "none", 0.40, nil, nil},
    ["aluminio"] = { "Aluminio", "none", 0.05, nil, nil},
    ["m-tecido"] = { "Tecido", "none", 0.40, nil, nil},
	["notebook"] = { "Notebook", "none", 0.1, nil, nil},
	["c4"] = { "C4", "none", 0.1, nil, nil},
	["suspension"] = { "Item de Tuning", "none", 0.1, nil, nil},
	["fueltech"] = { "FuelTech", "none", 0.1, nil, nil},
	["coin"] = { "Coin", "none", 0.1, nil, nil},
	
	["notafiscalarma"] = { "Nota fiscal de Arma", "none", 0.1, nil, nil},
	["notafiscalmunicao"] = { "Nota fiscal de Municao", "none", 0.1, nil, nil},
	["notafiscallavagem"] = { "Nota fiscal de Lavagem", "none", 0.1, nil, nil},
	["notafiscaldroga"] = { "Nota fiscal de Droga", "none", 0.1, nil, nil},
	["notafiscaldesmanche"] = { "Nota fiscal de Desmanche", "none", 0.1, nil, nil},
	
	


	-- Itens Cartel
	["c-cobre"] = { "Cobre", "none", 0.40, nil, nil},
    ["c-ferro"] = { "Ferro", "none", 0.01, nil, nil},
    ["c-fio"] = { "Fio", "none", 0.40, nil, nil},
	["c-polvora"] = { "Polvora", "none", 0.3, nil, nil},
	["polvora"] = { "Polvora", "none", 0.01, nil, nil},
	["capsulas"] = { "Capsulas", "none", 0.01, nil, nil},
	["zincocobre"] = { "Cápsulas", "none", 0.01, nil, nil},

	["desbloqueadorsinal"] = { "Desbloqueador de Sinal", "none", 0.01, nil, nil },
	["grampoprison"] = { "Grampo", "none", 0.01, nil, nil },
	["moldeprison"] = { "Molde", "none", 0.01, nil, nil },
	["copoprison"] = { "Copo", "none", 0.01, nil, nil },
	["ferroprison"] = { "Ferro", "none", 0.01, nil, nil },
	["cobreprison"] = { "Cobre", "none", 0.01, nil, nil },
	["pedraprison"] = { "Pedra", "none", 0.01, nil, nil },
	["papelprison"] = { "Papel", "none", 0.01, nil, nil },
	["maconhaprison"] = { "Maconha", "none", 0.01, nil, nil },
	["crackprison"] = { "Crack", "none", 0.01, nil, nil },
	["plasticoprison"] = { "Plástico", "none", 0.01, nil, nil },
	["garrafaquebradaprison"] = { "Garrafa Quebrada", "none", 0.01, nil, nil },
	["pedacoarameprison"] = { "Pedaço de Arame", "none", 0.01, nil, nil },
	["tijoloprison"] = { "Tijolo", "none", 0.01, nil, nil },
	["dedodecepadoprison"] = { "Dedo Decepado", "none", 0.01, nil, nil },


	-- Itens Lavagem
	["l-alvejante"] = { "Alvejante", "none", 0.20, nil, nil},

	-- Itens Drogas
	["haxixe"] = { "Haxixe", "usar", 0.5, nil, nil},
	["resinacannabis"] = { "Resina de Cannabis", "none", 0.3, nil, nil},  
	["respingodesolda"] = { "Respingo de Solda", "none", 0.3, nil, nil},  
	["folhamaconha"] = { "Folha de Maconha", "none", 0.3, nil, nil},
    ["maconha"] = { "Maconha", "usar", 0.5, nil, nil},
    ["pastabase"] = { "Pasta Base", "none", 0.3, nil, nil},
    ["cocaina"] = { "Cocaina", "usar", 0.5, nil, nil},
	["acidolsd"] = { "Acido LSD", "none", 0.3, nil, nil},
	["tiner"] = {"Tiner", "none", 0.3, nil, nil},
	["lancaperfume"] = {"Lança Perfume", "none", 0.5, nil, nil},
	["opiopapoula"] = { "Pó de Opio", "none", 0.3, nil, nil},
	

	["carta"] = { "carta", "usar", 0.1, nil, nil}, 

	-- Pacotes de craft
	["pacote_eletrico"] = { "Pacote Eletrico", "none", 3.0, nil, nil},
	["pacote_componentes"] = { "Pacote de Componentes", "none", 5.0, nil, nil},
	["pacote_tecido"] = { "Pacote de Tecido", "none", 3.0, nil, nil},
	["pacote_metalico"] = { "Pacote Metalico", "none", 10.0, nil, nil},
	["pacote_polvora"] = { "Pacote de Polvora", "none", 3.0, nil, nil},

    -- Ilegal
	["body_armor"] = { "Colete", "usar", 1.0, nil, nil},
    ["capuz"] = { "Capuz", "usar", 0.1, nil, nil},
    ["dirty_money"] = { "Dinheiro Sujo", "none", 0.00001, nil, nil},
    ["scubagear"] = { "Kit de Mergulho", "usar", 10.0, nil, nil},

	-- Itens Joalheria
	["relogioroubado"] = { "Relogio", "none", 0.5, nil, nil},
	["colarroubado"] = { "Colar", "none", 0.1, nil, nil},
	["anelroubado"] = { "Anel", "none", 0.1, nil, nil},
	["brincoroubado"] = { "Brinco", "none", 0.1, nil, nil},
	["pulseiraroubada"] = { "Pulseira", "none", 0.1, nil, nil},

	-- Itens Acougue
	["carnedepuma"] = { "Carne de Puma", "none", 3.0, nil, nil},
	["carnedelobo"] = { "Carne de Lobo", "none", 3.0, nil, nil},
	["carnedejavali"] = { "Carne de Javali", "none", 3.0, nil, nil},


	-- Corda e Capuz
	["fibradecarbono"] = { "Fibra de Carbono", "none", 0.05, nil, nil},
	["papel"] = { "Papel", "none", 0.05, nil, nil},
	["poliester"] = { "Poliester", "none", 0.05, nil, nil},


    -- Drogas
	["opio"] = { "Ópio", "usar", 0.5, nil, nil}, 
	["lsd"] = { "LSD", "usar", 0.5, nil, nil}, 
	["morfina"] = { "Morfina", "none", 0.3, nil, nil},
	["heroina"] = { "Heroina", "usar", 0.5, nil, nil},
	["adrenalina"] = { "Adrenalina", "usar", 0.5, nil, nil},
	["anfetamina"] = { "Anfetamina", "none", 0.3, nil, nil},
	["metanfetamina"] = { "Metanfetamina ", "usar", 0.5, nil, nil},
	["balinha"] = { "Balinha", "usar", 0.5, nil, nil},
	["podemd"] = { "Pó de MD", "none", 0.3, nil, nil},
	["cogumelo"] = { "Cogumelo ", "usar", 0.5, nil, nil},

    -- Tartaruga
    ["tartaruga"] = { "Tartaruga", "none", 3.0, nil, nil},

    -- Pescaria
    ["isca"] = { "Isca", "none", 0.25, nil, nil},
    ["pacu"] = { "Pacu", "none", 1.5, nil, nil},
    ["tilapia"] = { "Tilapia", "none", 0.50, nil, nil},
    ["salmao"] = { "Salmao", "none", 1.0, nil, nil},
    ["tucunare"] = { "Tucunare", "none", 2.0, nil, nil},
    ["dourado"] = { "Dourado", "none", 3.0, nil, nil},

    -- Lenhador
    ["madeira"] = { "Madeira", "none", 2.5, nil, nil},

	-- Graos
    ["graosimpuros"] = { "Graos", "none", 1.0, nil, nil},
    ["tomate"] = { "Tomate", "none", 1.0, nil, nil},

    ["goiaba"] = { "Goiaba", "none", 1.0, nil, nil},
    ["maracuja"] = { "Maracujá", "none", 1.0, nil, nil},
    ["laranja"] = { "Laranja", "none", 1.0, nil, nil},
    ["manga"] = { "Manga", "none", 1.0, nil, nil},
    ["maca"] = { "Maça", "none", 1.0, nil, nil},
	
	-- Entregador
	["caixa"] = { "Caixa de entrega", "none", 1.5, nil, nil},

	-- Mineracao
    ["bronze"] = { "Bronze", "none", 1.0, nil, nil},
    ["safira"] = { "Safira", "none", 1.0, nil, nil},
    ["rubi"] = { "Rubi", "none", 1.0, nil, nil},
    ["ouro"] = { "Ouro", "none", 1.0, nil, nil},
    ["ferro"] = { "Ferro", "none", 0.05, nil, nil},

	-- COMIDAS
	["pao"] = { "Pao", "comer", 0.5, -40, nil},
	["sanduiche"] = { "Sanduiche", "comer", 0.5, -40, nil},
	["pizza"] = { "Pizza", "comer", 1.5, -18, nil},
	["barrac"] = { "Barra de chocolate", "comer", 0.5, -40, nil},
	["cachorroq"] = { "Cachorro Quente", "comer", 0.5, -40, nil},
	["pipoca"] = { "Pipoca", "comer", 0.3, -40, nil},
	["donut"] = { "Donut", "comer", 0.2, -40, nil},
	["paoq"] = { "Pao de Queijo", "comer", 0.3, -40, nil},
	["marmita"] = { "Marmitex", "comer", 2.0, -40, nil},
	["coxinha"] = { "Coxinha", "comer", 0.5, -40, nil},
	["panetone"] = { "Panetone", "comer", 0.5, -40, nil},

	-- BEBIDAS
	["cocacola"] = { "Coca Cola", "beber", 0.5, nil, -50},
	["sprunk"] = { "Sprunk", "beber", 0.5, nil, -12},
	["sucol"] = { "Suco de Laranja", "beber", 0.5, nil, -50},
	["sucol2"] = { "Suco de Limao", "beber", 0.5, nil, -50},
	["water"] = { "Agua", "beber", 0.5, nil, -50},
	["cafe"] = { "Cafe", "beber", 0.25, nil, -50},
	["energetico"] = { "Energetico", "beber", 0.25, nil, -50},

	-- ALCOLICAS FOME/SEDE
	["vodka"] = { "Vodka", "bebera", 1.0, 10, -7},
	["cerveja"] = { "Cerveja", "bebera", 0.5, 3, -10},
	["corote"] = { "Corote", "bebera", 0.5, 20, -10},
	["pinga"] = { "Pinga", "bebera", 1.0, 15, -10},
	["whisky"] = { "Whisky", "bebera", 1.0, 10, -8}, 
	["absinto"] = { "Absinto", "bebera", 0.5, 10, -10},
	["skolb"] = { "Skol Beats", "bebera", 0.25, 5, -13},

	-- REMEDIOS
	["amoxilina"] = { "Amoxilina", "remedio", 0.05, 5, nil},
	["cataflan"] = { "Cataflan", "remedio", 0.05, 5, nil},
	["cicatricure"] = { "Cicatricure", "remedio", 0.05, 5, nil},
	["clozapina"] = { "Clozapina", "remedio", 0.05, 5, nil},
	["dipirona"] = { "Dipirona", "remedio", 0.05, 5, nil},
	["paracetamol"] = { "Paracetamol", "remedio", 0.05, 5, nil},
	["rivotril"] = { "Rivotril", "remedio", 0.05, 5, nil},
	["riopan"] = { "Riopan", "remedio", 0.05, 5, nil},
	["luftal"] = { "Luftal", "remedio", 0.05, 5, nil},
	["coumadin"] = { "Coumadin", "remedio", 0.05, 5, nil},
	["dorflex"] = { "Dorflex", "remedio", 0.05, 5, nil},
	["anticoncepcional"] = { "Anticoncepcional", "remedio", 0.05, 5, nil},
	["camisinha"] = { "Camisinha", "remedio", 0.05, 5, nil},
	["fluoxetina"] = { "Fluoxetina", "remedio", 0.05, 5, nil},
	["bandagem"] = { "Bandagem", "remedio", 0.5, 5, nil},
	["barrier"] = { "Tenda", "remedio", 0.5, 5, nil},
	["doritos"] = { "Doritos", "remedio", 0.5, 5, nil},
	["ovodapascoa"] = { "Ovo da Pascoa", "remedio", 0.5, 5, nil},
	["flordelotus"] = { "Flor de Lotus", "remedio", 1.0, 5, nil},
	
	-- PISTOLAS
	["WEAPON_SNSPISTOL_MK2"] = { "Fajuta", "equipar", 3.0, nil, nil},
	["AMMO_SNSPISTOL_MK2"] = { "M-Fajuta", "recarregar", 0.05, nil, nil},

	["WEAPON_HEAVYPISTOL"] = { "HeavyPistol", "equipar", 3.0, nil, nil},
	["AMMO_HEAVYPISTOL"] = { "M-HeavyPistol", "recarregar", 0.05, nil, nil},
	 
	["WEAPON_PISTOL_MK2"] = { "Five-Seven", "equipar", 3.0, nil, nil},
	["AMMO_PISTOL_MK2"] = { "M-Five-Seven", "recarregar", 0.05, nil, nil},
	 
	["WEAPON_PISTOL"] = { "Pistol", "equipar", 3.0, nil, nil},
	["AMMO_PISTOL"] = { "M-Pistol", "recarregar", 0.05, nil, nil},

	["WEAPON_APPISTOL"] = { "Ap Pistol", "equipar", 3.0, nil, nil},
	["AMMO_APPISTOL"] = { "M-Ap Pistol", "recarregar", 0.05, nil, nil},

	["WEAPON_DOUBLEACTION"] = { "Double Action", "equipar", 3.0, nil, nil},
	["AMMO_DOUBLEACTION"] = { "M-Ap Double Action", "recarregar", 0.05, nil, nil},

	["WEAPON_SNOWBALL"] = { "Bola de Neve", "equipar", 3.0, nil, nil},
	["AMMO_SNOWBALL"] = { "M-Bola de Neve", "recarregar", 0.05, nil, nil},

	["WEAPON_FIREWORK"] = { "Fogos", "equipar", 3.0, nil, nil},
	["WEAPON_SNOWBALL"] = { "Bola de Neve", "equipar", 3.0, nil, nil},
	["WEAPON_BZGAS"] = { "Gas", "equipar", 3.0, nil, nil},
	["WEAPON_REVOLVER_MK2"] = { "Revolver", "equipar", 3.0, nil, nil},

	["WEAPON_RAYPISTOL"] = { "RayPistol", "equipar", 3.0, nil, nil},

	["AMMO_FIREWORK"] = { "M-Fogos", "recarregar", 0.05, nil, nil},
	["AMMO_SNOWBALL"] = { "M-Bola", "recarregar", 0.05, nil, nil},
	["AMMO_BZGAS"] = { "M-Gas", "recarregar", 0.05, nil, nil},
	["AMMO_REVOLVER_MK2"] = { "M-Revolver", "recarregar", 0.05, nil, nil},

	["WEAPON_GUSENBERG"] = { "Submetralhadora Thompson", "equipar", 3.0, nil, nil},
	["AMMO_GUSENBERG"] = { "M-Thompson", "recarregar", 0.05, nil, nil},

	["WEAPON_PISTOL50"] = { "Desert Eagle", "equipar", 3.0, nil, nil},
	["AMMO_PISTOL50"] = { "M-Desert", "recarregar", 0.05, nil, nil},

	["WEAPON_COMBATPISTOL"] = { "Glock", "equipar", 3.0, nil, nil},
	["AMMO_COMBATPISTOL"] = { "M-Glock", "recarregar", 0.05, nil, nil},

	["WEAPON_COMBATPDW"] = { "Combat Pdw", "equipar", 3.0, nil, nil},
	["AMMO_COMBATPDW"] = { "M-Pdw", "recarregar", 0.05, nil, nil},

	-- MACHADOS
	["WEAPON_HATCHET"] = { "Machados", "equipar", 3.0, nil, nil},
	["WEAPON_KNIFE"] = { "Faca", "equipar", 3.0, nil, nil},
	["WEAPON_DAGGER"] = { "Dagger", "equipar", 3.0, nil, nil},
	["WEAPON_KNUCKLE"] = { "Knuckle", "equipar", 3.0, nil, nil},
	["WEAPON_MACHETE"] = { "Machete", "equipar", 3.0, nil, nil},
	["WEAPON_SWITCHBLADE"] = { "SwitchBlade", "equipar", 3.0, nil, nil},
	["WEAPON_WRENCH"] = { "Wrench", "equipar", 3.0, nil, nil},
	["WEAPON_HAMMER"] = { "Hammer", "equipar", 3.0, nil, nil},
	["WEAPON_GOLFCLUB"] = { "GolfClub", "equipar", 3.0, nil, nil},
	["WEAPON_CROWBAR"] = { "CrowBar", "equipar", 3.0, nil, nil},
	["WEAPON_FLASHLIGHT"] = { "Lanterna", "equipar", 3.0, nil, nil},
	["WEAPON_BAT"] = { "Bastão de Beisebol", "equipar", 3.0, nil, nil},
	["WEAPON_BOTTLE"] = { "Bottle", "equipar", 3.0, nil, nil},
	["WEAPON_BATTLEAXE"] = { "Battleaxe", "equipar", 3.0, nil, nil},
	["WEAPON_POOLCUE"] = { "Poolcue", "equipar", 3.0, nil, nil},
	["GADGET_PARACHUTE"] = { "Paraquedas", "equipar", 3.0, nil, nil},
	["WEAPON_FLARE"] = { "Sinalizador", "equipar", 3.0, nil, nil},
	
	-- SUBMETRALHADORA
	["WEAPON_MACHINEPISTOL"] = { "Tec-9", "equipar", 6.0, nil, nil},
	["AMMO_MACHINEPISTOL"] = { "M-Tec-9", "recarregar", 0.05, nil, nil},

	["WEAPON_SMG_MK2"] = { "Smg MK2", "equipar", 6.0, nil, nil},
	["AMMO_SMG_MK2"] = { "M-Smg MK2", "recarregar", 0.05, nil, nil},

	["WEAPON_SMG"] = { "SMG", "equipar", 6.0, nil, nil},
	["AMMO_SMG"] = { "M-SMG", "recarregar", 0.05, nil, nil},


	["WEAPON_MICROSMG"] = { "MICROSMG", "equipar", 6.0, nil, nil},
	["AMMO_MICROSMG"] = { "M-MICROSMG", "recarregar", 0.05, nil, nil},

	["WEAPON_ASSAULTSMG"] = { "MTAR", "equipar", 6.0, nil, nil},
	["AMMO_ASSAULTSMG"] = { "M-MTAR", "recarregar", 0.05, nil, nil},

	-- SHOTGUN
	["WEAPON_SAWNOFFSHOTGUN"] = { "Shotgun", "equipar", 8.0, nil, nil},
	["AMMO_SAWNOFFSHOTGUN"] = { "M-Shotgun", "recarregar", 0.05, nil, nil},


	["WEAPON_MILITARYRIFLE"] = { "MilitaryRifle", "equipar", 8.0, nil, nil},
	["AMMO_MILITARYRIFLE"] = { "M-MilitaryRifle", "recarregar", 0.05, nil, nil},


	["WEAPON_PUMPSHOTGUN_MK2"] = { "Pump Shotgun", "equipar", 8.0, nil, nil},
	["AMMO_PUMPSHOTGUN_MK2"] = { "M-Pump Shotgun", "recarregar", 0.05, nil, nil},

	["WEAPON_PUMPSHOTGUN"] = { "Pump Shotgun", "equipar", 8.0, nil, nil},
	["AMMO_PUMPSHOTGUN"] = { "M-Pump Shotgun", "recarregar", 0.05, nil, nil},

	-- FUZIL

	
	["WEAPON_ASSAULTRIFLE"] = { "AK 47", "equipar", 8.0, nil, nil},
	["AMMO_ASSAULTRIFLE"] = { "M-AK-47", "recarregar", 0.05, nil, nil},
	["WEAPON_ASSAULTRIFLE_MK2"] = { "AK MK2", "equipar", 8.0, nil, nil},
	["AMMO_ASSAULTRIFLE_MK2"] = { "M-AK MK2", "recarregar", 0.05, nil, nil},

	["WEAPON_HEAVYSNIPER"] = { "SNIPER", "equipar", 8.0, nil, nil},
	["AMMO_HEAVYSNIPER"] = { "M-SNIPER", "recarregar", 0.05, nil, nil},

	["WEAPON_HEAVYRIFLE"] = { "Heavy Rifle", "equipar", 8.0, nil, nil},
	["AMMO_HEAVYRIFLE"] = { "M-Heavy Rifle", "recarregar", 0.05, nil, nil},
	
	["WEAPON_SPECIALCARBINE_MK2"] = { "G3", "equipar", 8.0, nil, nil},
	["AMMO_SPECIALCARBINE_MK2"] = { "M-G3", "recarregar", 0.05, nil, nil},
	
	["WEAPON_TACTICALRIFLE"] = { "Rifle Tatico", "equipar", 8.0, nil, nil},
	["AMMO_TACTICALRIFLE"] = { "M-Rifle Tatico", "recarregar", 0.05, nil, nil},

	["WEAPON_BULLPUPRIFLE"] = { "Rifle BullUp", "equipar", 8.0, nil, nil},
	["AMMO_BULLPUPRIFLE"] = { "M-Rifle BullUp", "recarregar", 0.05, nil, nil},

	["WEAPON_AKPENTEDE90_RELIKIASHOP"] = { "AK PENTE 90", "equipar", 8.0, nil, nil},
	["AMMO_AKPENTEDE90_RELIKIASHOP"] = { "M-AK PENTE 90", "recarregar", 0.05, nil, nil},

	["WEAPON_AKDEFERRO_RELIKIASHOP"] = { "AK DE FERRO", "equipar", 8.0, nil, nil},
	["AMMO_AKDEFERRO_RELIKIASHOP"] = { "M-AK DE FERRO", "recarregar", 0.05, nil, nil},

	["WEAPON_AK472"] = { "AK 472", "equipar", 8.0, nil, nil},
	["AMMO_AK472"] = { "M-AK 472", "recarregar", 0.05, nil, nil},

	["WEAPON_AR10PRETO_RELIKIASHOP"] = { "AR 10 PRETO", "equipar", 8.0, nil, nil},
	["AMMO_AR10PRETO_RELIKIASHOP"] = { "M-AR 10 PRETO", "recarregar", 0.05, nil, nil},

	["WEAPON_AR15BEGE_RELIKIASHOP"] = { "AR 15 BEGE", "equipar", 8.0, nil, nil},
	["AMMO_AR15BEGE_RELIKIASHOP"] = { "M-AR 15 BEGE", "recarregar", 0.05, nil, nil},

	["WEAPON_ARPENTEACRILICO_RELIKIASHOP"] = { "AR PENTE ACRILICO", "equipar", 8.0, nil, nil},
	["AMMO_ARPENTEACRILICO_RELIKIASHOP"] = { "M-AR PENTE ACRILICO", "recarregar", 0.05, nil, nil},

	["WEAPON_ARDELUNETA_RELIKIASHOP"] = { "AR DE LUNETA", "equipar", 8.0, nil, nil},
	["AMMO_ARDELUNETA_RELIKIASHOP"] = { "M-AR DE LUNETA", "recarregar", 0.05, nil, nil},

	["WEAPON_ARLUNETAPRATA"] = { "AR DE LUNETA PRATA", "equipar", 8.0, nil, nil},
	["AMMO_ARLUNETAPRATA"] = { "M-AR DE LUNETA PRATA", "recarregar", 0.05, nil, nil},

	["WEAPON_ARTAMBOR"] = { "AR DE TAMBOR", "equipar", 8.0, nil, nil},
	["AMMO_ARTAMBOR"] = { "M-AR DE TAMBOR", "recarregar", 0.05, nil, nil},

	["WEAPON_G3LUNETA_RELIKIASHOP"] = { "G3 LUNETA", "equipar", 8.0, nil, nil},
	["AMMO_G3LUNETA_RELIKIASHOP"] = { "M-G3 LUNETA", "recarregar", 0.05, nil, nil},

	["WEAPON_GLOCKDEROUPA_RELIKIASHOP"] = { "GLOCK DE ROUPA", "equipar", 8.0, nil, nil},
	["AMMO_GLOCKDEROUPA_RELIKIASHOP"] = { "M-GLOCK DE ROUPA", "recarregar", 0.05, nil, nil},

	["WEAPON_HKG3A3"] = { "HK G3A3", "equipar", 8.0, nil, nil},
	["AMMO_HKG3A3"] = { "M-HK G3A3", "recarregar", 0.05, nil, nil},

	["WEAPON_HK_RELIKIASHOP"] = { "HK", "equipar", 8.0, nil, nil},
	["AMMO_HK_RELIKIASHOP"] = { "M-HK", "recarregar", 0.05, nil, nil},
	
	["WEAPON_PENTEDUPLO1"] = { "PENTE DUPLO", "equipar", 8.0, nil, nil},
	["AMMO_PENTEDUPLO1"] = { "M-PENTE DUPLO", "recarregar", 0.05, nil, nil},

	["WEAPON_50_RELIKIASHOP"] = { ".50", "equipar", 8.0, nil, nil},
	["AMMO_50_RELIKIASHOP"] = { "M-.50", "recarregar", 0.05, nil, nil},

	["WEAPON_PARAFAL"] = { "PARAFAL", "equipar", 8.0, nil, nil},
	["AMMO_PARAFAL"] = { "M-PARAFAL", "recarregar", 0.05, nil, nil},

	["WEAPON_ADVANCEDRIFLE"] = { "Aug", "equipar", 8.0, nil, nil},
	["AMMO_ADVANCEDRIFLE"] = { "M-Aug", "recarregar", 0.05, nil, nil},

	["WEAPON_DOUBLEACTION"] = { "DOUBLEACTION", "equipar", 8.0, nil, nil},
	["AMMO_DOUBLEACTION"] = { "M-DOUBLEACTION", "recarregar", 0.05, nil, nil},

	["WEAPON_CARBINERIFLE"] = { "M4", "equipar", 8.0, nil, nil},
	["AMMO_CARBINERIFLE"] = { "M-M4", "recarregar", 0.05, nil, nil},
	["WEAPON_CARBINERIFLE_MK2"] = { "M4MK2", "equipar", 8.0, nil, nil},
	["AMMO_CARBINERIFLE_MK2"] = { "M-M4", "recarregar", 0.05, nil, nil},

	["WEAPON_SPECIALCARBINE"] = { "G36", "equipar", 8.0, nil, nil},
	["AMMO_SPECIALCARBINE"] = { "M-G36", "recarregar", 0.05, nil, nil},

	["WEAPON_BARRET"] = { "Barret", "equipar", 8.0, nil, nil},
	["AMMO_BARRET"] = { "M-Barret", "recarregar", 0.05, nil, nil},

	["WEAPON_GRAJADA"] = { "Grajada", "equipar", 8.0, nil, nil},
	["AMMO_GRAJADA"] = { "M-Grajada", "recarregar", 0.05, nil, nil},
	
	
	-- TAZER
	["WEAPON_STUNGUN"] = { "Tazer", "equipar", 1.0, nil, nil},

	-- GALAO DE GASOLINA
	["WEAPON_PETROLCAN"] = { "Galão de gasolina", "equipar", 1.0, nil, nil},
	["AMMO_PETROLCAN"] = { "Gasolina", "equipar", 0.05, nil, nil},


	-- NOVAS

	["WEAPON_AKCROMO"] = { "AK CROMO", "equipar", 8.0, nil, nil },
	["AMMO_AKCROMO"] = { "M-AK CROMO", "recarregar", 0.05, nil, nil },

	["WEAPON_ARRELIKIASHOPFEMININO1"] = { "AR FEMININO 1", "equipar", 8.0, nil, nil },
	["AMMO_ARRELIKIASHOPFEMININO1"] = { "M-AR FEMININO 1", "recarregar", 0.05, nil, nil },

	["WEAPON_ARRELIKIASHOPFEMININO2"] = { "AR FEMININO 2", "equipar", 8.0, nil, nil },
	["AMMO_ARRELIKIASHOPFEMININO2"] = { "M-AR FEMININO 2", "recarregar", 0.05, nil, nil },

	["WEAPON_ARVASCO"] = { "AR VASCO", "equipar", 8.0, nil, nil },
	["AMMO_ARVASCO"] = { "M-AR VASCO", "recarregar", 0.05, nil, nil },

	["WEAPON_CHEYTAC"] = { "CHEYTAC", "equipar", 8.0, nil, nil },
	["AMMO_CHEYTAC"] = { "M-CHEYTAC", "recarregar", 0.05, nil, nil },

	["WEAPON_G3RELIKIASHOPFEMININO"] = { "G3 FEMININO", "equipar", 8.0, nil, nil },
	["AMMO_G3RELIKIASHOPFEMININO"] = { "M-G3 FEMININO", "recarregar", 0.05, nil, nil },

	["WEAPON_GLOCKRAJADA"] = { "GLOCK RAJADA", "equipar", 8.0, nil, nil },
	["AMMO_GLOCKRAJADA"] = { "M-GLOCK RAJADA", "recarregar", 0.05, nil, nil },

	["WEAPON_GLOCKRELIKIASHOPFEMININO0"] = { "GLOCK FEMININO 0", "equipar", 8.0, nil, nil },
	["AMMO_GLOCKRELIKIASHOPFEMININO0"] = { "M-GLOCK FEMININO 0", "recarregar", 0.05, nil, nil },


}

return cfg

