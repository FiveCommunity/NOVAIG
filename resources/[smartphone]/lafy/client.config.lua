Config = {
  -- Quantas vezes por segundo a localização do jogador será atualizada em relação a música
  -- Não há motivo para esse número ser maior que 10
  refreshRate = 4,
  realism = true,
  realismIgnore = {
    [`pbus2`] = true,
  },
  
  -- Volume máximo, é bom aumentar este valor quando muitos jogadores reclamarem de som baixo
  -- Valor mínimo 0, Valor máximo 1
  baseVolume = 0.5,

  -- Tecla utilizada para deixar a caixa de som no chão, ou pegar do chão
  dropRadioKey = 'g',

  -- Valor mínimo de vida que o jogador precisa ter para abrir a NUI
  minimumHealth = 101,
  
  -- A música vai parar de tocar se o jogador morrer?
  stopOnDeath = true,

  -- Lista de coordenadas de interiores onde o som será desabilitado (precisa ser dentro do interior)
  blockedInteriors = {
    --vector3(148.95, -1039.27, 29.37), -- Banco da praça
  },

  isWindowsOpen = function(vehicle)
    -- Exemplo da base creative network
    -- return Entity(vehicle).state.Windows
  end,

  -- Esta notify acontece quando o jogador não tem permissão
  -- bool == nil   (Jogador sem permissão)
  -- bool == true  (O jogador digitou /som on)
  -- bool == false (O jogador digitou /som off)
  notify = function(bool)
    if type(bool) == 'number' then
      TriggerEvent('Notify', 'sucesso', 'Volume atual: '..bool..'%',5000)
    elseif bool == nil then
      TriggerEvent('Notify', 'importante', 'Você não tem permissão',5000)
    elseif bool then
      TriggerEvent('Notify', 'sucesso', 'Status do som: Ligado',5000)
    else
      TriggerEvent('Notify', 'importante', 'Status do som: Desligado',5000)
    end
  end
}