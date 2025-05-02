

Config = {}

Config.initeRobbery = {
	  { coords = vec3(-1052.62,-230.69,44.87), distance = 5 },
}

Config.cooldownIniteRobbery = 86400 -- Tempo em segundos para o player iniciar outro roubo
Config.timeExplosion = 5 -- Tempo em segundos para a explosão da C4
Config.timeLoot = 5 -- Tempo em segundos que o player vai ficar pegando dinheiro
Config.maxDist = 250 -- Distancia maxima que o player pode ficar do veículo após se aproximar (Não coloque mais que 200)
Config.notifyPolice = true -- Deixe em true caso a policia seja notificada ao iniciar o roubo ao carro forte

Config.randomJobs = {
	[1] = {
		initeSpawn = vec4(-135.77,6461.58,31.0,135.48), --Vector 4 [ LOCAL ONDE VEICULO VAI SPAWNAR ]
		vehicle = "stockade4",
		weapon = "WEAPON_ASSAULTRIFLE", --Arma que os seguranças vão levar
		accuracy = 100, -- Nivel de accuracy do NPC

		peds = {
			[1] = { model = "s_m_m_security_01", seat = -1}, --Seat -1 = Piloto, Seat = Passageiro, etc 
			[2] = { model = "s_m_m_security_01", seat = 0}, 
			[3] = { model = "s_m_m_security_01", seat = 1}, 
			[4] = { model = "s_m_m_security_01", seat = 2}, 
		}
	},

	[2] = {
		initeSpawn = vec4(-2333.51,3413.49,29.64,55.56),
		vehicle = "stockade4",
		weapon = "WEAPON_ASSAULTRIFLE", --Arma que os seguranças vão levar
		accuracy = 100, -- Nivel de accuracy do NPC

		peds = {
			[1] = { model = "s_m_m_security_01", seat = -1}, --Seat -1 = Piloto, Seat = Passageiro, etc 
			[2] = { model = "s_m_m_security_01", seat = 0}, 
			[3] = { model = "s_m_m_security_01", seat = 1}, 
			[4] = { model = "s_m_m_security_01", seat = 2}, 
		}
	},

	[3] = {
		initeSpawn = vec4(2914.87,4432.75,47.92,17.57),
		vehicle = "stockade4",
		weapon = "WEAPON_ASSAULTRIFLE", --Arma que os seguranças vão levar
		accuracy = 100, -- Nivel de accuracy do NPC

		peds = {
			[1] = { model = "s_m_m_security_01", seat = -1}, --Seat -1 = Piloto, Seat = Passageiro, etc 
			[2] = { model = "s_m_m_security_01", seat = 0}, 
			[3] = { model = "s_m_m_security_01", seat = 1}, 
			[4] = { model = "s_m_m_security_01", seat = 2}, 
		}
	},

	[4] = {
		initeSpawn = vec4(1021.52,188.14,80.46,52.88),
		vehicle = "stockade4",
		weapon = "WEAPON_ASSAULTRIFLE", --Arma que os seguranças vão levar
		accuracy = 100, -- Nivel de accuracy do NPC

		peds = {
			[1] = { model = "s_m_m_security_01", seat = -1}, --Seat -1 = Piloto, Seat = Passageiro, etc 
			[2] = { model = "s_m_m_security_01", seat = 0}, 
			[3] = { model = "s_m_m_security_01", seat = 1}, 
			[4] = { model = "s_m_m_security_01", seat = 2}, 
		}
	},
}

Config.rewardsItens = {
	{ item = "dirty_money", min = 150000, max = 250000, chance = 100 },
	{ item = "rubi", min = 20, max = 30, chance = 50 },
}