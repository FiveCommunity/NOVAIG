permissaoParaInstalarNitro = { "developer.permissao", "perm.tunar", "perm.race", "perm.Customs" }

comandoAbrirHud = "hudnitro"

tempoDuracaoTotalNitro = 30 -- Tempo total que vai ser a utilização do nitro (100 a 0)
animacaoLanternaVeiculoAoUsarNitro = true -- Rastro do farol ao andar com o veiculo
TamanhoDoFogoNoEscape = 5.0 -- Tamanho do fogo que sai do escape do veículo
tempoInstalacaoKitNitro = 30 -- Tempo de instalação do nitro
tempoParaTrocarGarrafaNitro = 30 -- Tempo para trocar o tanque de nitro
AumentoDeVelocidadeFinalAoUsarNitro = 50 -- Aumento de velocidade final
AumentoDeTorqueAoUsarNitro = 5 -- Torque do motor do veículo

itemKitNitro = "kitnitro" 
itemGarrafaNitro = "garrafanitro"
teclaParaUsarNitro = 244 -- M SITE: https://docs.fivem.net/docs/game-references/controls/


-- Configuração de posição do blip ao instalar o nitro OBS: para carros com posição do motor bugada
veiculosPositionEngine = {
    ["t20"] = -1.7,
    ["ferrariitalia"] = 1.7
}

veiculosBlackList = {
    "kuruma"
}

dict = {
    [0] = "O veículo já possui nitro!",
    [1] = "Você não possui permissão para instalar o nitro!",
    [2] = "Instalação cancelada, você não está mais próximo do veículo!",
    [3] = "Instalação concluida com sucesso!",
    [4] = "O veículo não possui kit nitro!",
    [5] = "Você precisa estar sentado como piloto ou copiloto para trocar a garrafa de nitro!",
    [6] = "O veículo deve estar parado para realizar a troca da garrafa!",
    [7] = "Trocando garrafa de nitro",
    [8] = "Instalando Kit nitro",
    [9] = "Garrafa trocada com sucesso!",
    [10] = "Veiculo bloqueado de instalar nitro!",
    [11] = "Você não possui 1x kit nitro!",
}