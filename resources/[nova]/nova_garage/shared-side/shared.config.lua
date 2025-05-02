main = {
	dir = "http://177.54.148.31:4020/lotus/carros/",
	spawnClientVehicle = true, -- Spawnar veiculo via client-side

	clearVehicle = { -- LIMPAR VEICULOS QUE NÃO ESTEJAM USADOS
		enable = true,  -- CASO QUEIRA ATIVAR / DESATIVAR
		time = 7, -- TEMPO EM MINUTOS
	},

	ipvaVencimento = 7, -- DIAS PARA O VENCIMENTO DO IPVA
	ipvaValue = 0.05, -- 5% VALOR  DO VEICULO IPVA

	detidoValue = 0.20, -- 5% VALOR DO VEICULO DETIDO
	retidoValue = 0.15, -- 10% VALOR DO VEICULO RETIDO 

	defaultCarPrice = 5000, -- Valor padrão caso o carro não seja encontrado na lista abaixo.
	defaultCarChest = 50, -- Valor padrão caso o carro não seja encontrado na lista abaixo.

	commands = {
		-- prefix = "veh", -- PREFIX
		sellVeh = "vender", -- comando para vender carro /veh vender
		keyAdd = "add", -- comando para  addchave carro /veh add
		keyRem = "rem", -- comando para rem chave carro /veh rem
	}
}

vehicleClasses = {
    [0] = "Compacto",
    [1] = "Sedan",
    [2] = "SUV",
    [3] = "Coupé",
    [4] = "Muscle",
    [5] = "Clássico Esportivo",
    [6] = "Esportivo",
    [7] = "Super",
    [8] = "Motocicleta",
    [9] = "Off-road",
    [10] = "Industrial",
    [11] = "Utilitário",
    [12] = "Van",
    [13] = "Bicicleta",
    [14] = "Barco",
    [15] = "Helicóptero",
    [16] = "Avião",
    [17] = "Serviço",
    [18] = "Emergência",
    [19] = "Militar",
    [20] = "Comercial",
    [21] = "Trem"
}