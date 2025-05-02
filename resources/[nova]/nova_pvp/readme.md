Messages:

```lua
SendNUIMessage({ action = 'open', data = true }) -- para dar display geral usar sempre q for mostrar alguma tela.

SendNUIMessage({ action = 'open:lobby' }) -- para abrir a tela de lobby
SendNUIMessage({ action = 'open:register' }) -- para abrir a tela de registro
```

<hr>

Para registrar uma conta:

```lua
RegisterNuiCallback('REGISTER', function(data, cb)
  -- ja verifico no front-end caso ele nao tenha nome ou email nao dispara esse fetch
  local name = data.name
  local email = data.email
  local color = data.color
  cb(true)
end)
```

<hr>

Para abrir o script de skins:

```lua
RegisterNuiCallback('OPEN_SKINS', function(data, cb)
  cb(true)
end)
```

<hr>

Para pegar a lista de players em cada ranking:

```lua
RegisterNuiCallback('GET_LIST', function(data, cb)
  local type = data.type -- o type da lista que voce precisa me retonar se é ranking solo ou o ranking de clans
  cb({
    { name = 'asdsadg', clan = 'asdsad', wins = 12312, kills = 12312, points = 12321, status = true, elo = 'gold' }, -- eu ja to filtrando no front-end, só preciso que voce mande o elo do player/clan
    { name = 'asdsadg', clan = 'asdsad', wins = 12312, kills = 12312, points = 12321, status = true, elo = 'gold' },
    { name = 'asdsadg', clan = 'asdsad', wins = 12312, kills = 12312, points = 12321, status = true, elo = 'gold' },
    { name = 'asdsadg', clan = 'asdsad', wins = 12312, kills = 12312, points = 12321, status = true, elo = 'gold' },
  })
end)
```

Para pegar a informação do perfil da pessoa no ranking: 


```lua
RegisterNuiCallback('GET_PROFILE', function(data, cb)
  cb({ 
    id = 1337 -- identificador dele obrigatorio
    name = 'Pedro Silva' -- nome obrigatorio
    clan? = 'AAA' -- clan opcional, nao precisa enviar caso não tenha
    icon? = '' -- icon opcional
    color = '#BE38F3' -- color obrigatorio é a cor q ele escolhe quando cria
    banner? = '' -- banner opcional, nao precisa enviar caso não tenha
    elos = {
      solo = { elo = 'gold', name = 'Ouro III', points = { current = 250, max = 500 } }
      squad = { elo = 'bronze', name = 'Bronze I', points = { current = 300, max = 600 } }
    },
    matchs: { -- array de objeto contendo as partidas dele precisa enviar o type q pode ser um desses 4, e se ele ganhou ou nao sendo false para derrota e true para vitoria.
      { type = 'ffa', win = false },
      { type = 'teams', win = false },
      { type = 'gungame', win = false },
      { type = 'ctf', win = true },
    }
  })
end)
```

Para atualizar a cor do banner da pessoa.

```lua
RegisterNuiCallback('UPDATE_BANNER', function(data, cb)
  local data = data.banner
  cb(true)
end)
```

Para atualizar o nome da pessoa.

```lua
RegisterNuiCallback('UPDATE_NAME', function(data, cb)
  -- pelo o que eu entendi existe um item entao antes de retornar true é necessario checar se a pessoa realmente tem esse item.
  local data = data.name
  cb(true)
end)
```

# Squad / Clã

Quando ele clicar para acessar a ará de squad eu disparo um fetch:

```lua
RegisterNuiCallback('OPEN_SQUAD', function(data, cb)
  if not squad then
    if item then
      SendNUIMessage({ action = 'open:registerSquad' }) -- caso ele nao tenha time mas tenha o item
    else
      SendNUIMessage({ action = 'open:notSquad' }) -- caso ele naot tenha time e nem o item
    end
  else 
  SendNUIMessage({ action = 'open:squad' }) -- caso ele ja tenha o time criado
  cb(true)
end)
```

Enviar as informações do time:

```lua
RegisterNuiCallback('GET_SQUAD', function(data, cb)
  cb({
    tag = 'col', -- tag
    elo = 'gold', -- o elo q o player ta
    name = 'COLOCOLO', -- o nome do clã
    color = '#0aff0a', -- cor escolhida
    eloName = 'Ouro III',
    points = { current = 50, max = 200 },
    members = {
      { elo = 'bronze', name = 'Pedro Silva', kills = 20, points = 30 },
      { elo = 'bronze', name = 'Pedro Silva', kills = 20, points = 30 },
      { elo = 'bronze', name = 'Pedro Silva', kills = 20, points = 30 },
      { elo = 'bronze', name = 'Pedro Silva', kills = 20, points = 30 },
      { elo = 'bronze', name = 'Pedro Silva', kills = 20, points = 30 },
      { elo = 'bronze', name = 'Pedro Silva', kills = 20, points = 30 },
      { elo = 'bronze', name = 'Pedro Silva', kills = 20, points = 30 },
      { elo = 'bronze', name = 'Pedro Silva', kills = 20, points = 30 },
      { elo = 'bronze', name = 'Pedro Silva', kills = 20, points = 30 },
      { elo = 'bronze', name = 'Pedro Silva', kills = 20, points = 30 },
    }
  })
end)
```

Quando ele registrar um time:

```lua
RegisterNuiCallback('REGISTER_SQUAD', function(data, cb)
  local tag = data.tag
  local name = data.name
  local color = data.color
  cb(true)
end)
```

Quando ele trocar a cor do banner dele eu disparo esse fetch:

```lua
RegisterNuiCallback('UPDATE_SQUAD_BANNER', function(data, cb)
  local color = data.color
  cb(true)
end)
```

Quando o líder remove um membro da lista:

```lua
RegisterNuiCallback('REMOVE_MEMBER', function(data, cb)
  local member = data.member -- objeto do membro q foi removido.
  cb(true)
end)
```

Quando o líder convidar um player: 

```lua
RegisterNuiCallback('INVITE_MEMBER', function(data, cb)
  local id = data.id
  cb(true)
end)
```

Quando a pessoa quita do time:

```lua
RegisterNuiCallback('QUIT_SQUAD', function(data, cb)
  local id = data.id -- id da pessoa q ta saindo do time.
  cb(true)
end)
```


# Arenas

Sempre que ele escolhe um modo de jogo eu envio uma requisição:

```lua
RegisterNuiCallback('GET_ARENAS'. function(data, cb)
  local mode = data.mode -- ffa | gungame | teams | ctf
  cb({
    highscore = {'pedro', 'mirto', 'han'} -- lista com o top 3, por ordem: 1, 2 e 3
    rooms = { -- lista das salas
      { 
        id = 1, 
        rounds = 10,
        map = 'dust',
        mode = 'ffa', -- ffa | gungame | teams | ctf: retorna esse mode para eu filtrar em alguns momentos.
        weapon = 'five-seven'
        players = { current = 5, max = 10 }
        name = 'sala do joao', 
        private = true, 
        password = 'def', 
        image = 'https://images.panda.org/assets/images/pages/welcome/orangutan_1600x1000_279157.jpg'
      },
      { 
        id = 1, 
        rounds = 10,
        map = 'dust',
        mode = 'ffa', -- ffa | gungame | teams | ctf: retorna esse mode para eu filtrar em alguns momentos.
        weapon = 'five-seven'
        players = { current = 5, max = 10 }
        name = 'sala do joao', 
        image = 'https://images.panda.org/assets/images/pages/welcome/orangutan_1600x1000_279157.jpg'
      },
    }
  })
end)
```

Para criar uma sala é enviada uma requisição para o back-end:

```lua
RegisterNuiCallback('CREATE_ROOM', function(data, cb)
  local map = data.map -- nome do mapa
  local name = data.name -- nome da sala
  local mode = data.mode -- nome do modo
  local kills = data.kills -- quantidade de kills para acabar
  local weapon = data.weapon -- arma que vai ter no modo 
  local players = data.players -- quantidade de players para entrar
  local password = data.password -- caso nao tenha senha vai como string vazia: ""
  cb({ kills = 20, mode = 'ffa', id = 1, private = true, password = 'abc', image = 'https://images.panda.org/assets/images/pages/welcome/orangutan_1600x1000_279157.jpg', name = 'sala do pedro', map = 'test', rounds = 10, weapon = 'FIVE-SEVEN', players = { current = 12, max = 12 } }) -- retornar a nova sala formata do jeito q pede em GET_ARENAS
end)
```

Para pegar as informações dos mapas: 

```lua
RegisterNuiCallback('GET_MAPS', function(data, cb)
  cb({
    { image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsIosuXcz2ZRfiVPuTWFiXm1vP7itNAy4Atg&s', name: 'dust' }, { image: 'https://media.assettype.com/afkgaming%2F2022-08%2F1288abab-b398-4c85-a093-5e20865e1142%2FCover_Image___S1mple_And_B1t_Defend_CSGO_Map_Mirage_After_HObbit_Calls_It_Boring.jpg?auto=format%2Ccompress&dpr=1.0&w=1200', name: 'mirage' },
    { image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsIosuXcz2ZRfiVPuTWFiXm1vP7itNAy4Atg&s', name: 'dust' }, { image: 'https://media.assettype.com/afkgaming%2F2022-08%2F1288abab-b398-4c85-a093-5e20865e1142%2FCover_Image___S1mple_And_B1t_Defend_CSGO_Map_Mirage_After_HObbit_Calls_It_Boring.jpg?auto=format%2Ccompress&dpr=1.0&w=1200', name: 'dust' },
  }) -- lista com todos os mapas
end)
```

Para pegar as opções de armas de acordo com a categoria:

```lua
RegisterNuiCallback('GET_OPTIONS', function(data, cb)
  local category = data.category -- rifle | pistol | sub | shotgun de acordo com a categoria retornar a lista de armas
  cb({'five', 'glock', 'magnum'})
end)
```

Para entrar em alguma sala: 

```lua
RegisterNuiCallback('JOIN_ROOM', function(data, cb)
  local room = data.room -- dependendo do modo voce vai redirecionar direto para a partida. No caso do ffa, voce ja redireciona direto para a partida:
  cb(true)
end)
```

Para spectar uma sala:

```lua
RegisterNuiCallback('SPECTATE', function(data, cb)
  local room = data.room
  cb(true)
end)
```

## Hud

Para navegar para a hud:

```lua
SendNUIMessage({
  action = 'open:hud',
  data = 'ffa' -- tipo da hud é necessario me mandar isso pra eu customizar da maneira certa.
})
```

Para criar uma notificação de kill:

```lua
SendNUIMessage({
  action = 'NEW_KILL',
  data = {
    killer = 'Pedro',
    victim = 'Mirto',
    image = '' -- link da imagem
  }
})
```

Para atualizar a lista que mostra os players: 

```lua
SendNUIMessage({
  action = 'UPDATE_PLAYERS',
  data = {
    { icon = "", alive = false }, -- icone e se está vivo/morto
    { icon = "", alive = true },
    { icon = "", alive = true },
    { icon = "", alive = true },
  }
})
```

Para atualizar a vida do player: 

```lua
SendNUIMessage({
  action = 'UPDATE_STATS',
  data = {
    health = 20, -- vida
    armour = 20, -- colete
  }
})
```

Para atualizar as kills do player:

```lua
SendNUIMessage({
  action = 'UPDATE_KILLS',
  data = 2 -- quantidade de kill
})
```

Para atualizar o tempo da partida:

```lua
SendNUIMessage({
  action = 'UPDATE_TIME',
  data = 2 -- tempo em segundos ja formato no front-end
})
```

Para atualizar o TAB:

```lua
SendNUIMessage({
  action = 'UPDATE_SCOREBOARD',
  data = {
    visibled = true,
    players = {
      { 
        elo: 'bronze', 
        name = 'Pedro Silva', 
        ping = 20, 
        kills = 20, 
        deaths = 20, -- opcional, exemplo no modo gungame nao precisa enviar.
        weapon = ''  -- opcional voce só envia quando for do tipo gungame, é o link da imagem
      },
    }
  }
})
```

Para ocultar o TAB: 

```lua
SendNUIMessage({
  action = 'UPDATE_SCOREBOARD',
  data = { visibled = false }
})
```

Para habilitar a arma:

```lua
SendNUIMessage({
  action = 'UPDATE_WEAPON',
  data = {
    visibled = true -- true/false
    munition = { current = 20, clip = 10 },
    image = '' -- link da imagem
  }
})
```

Para atualizar a lista de armas do gungame:

```lua
SendNUIMessage({
  action = 'UPDATE_WEAPONS',
  data = { -- lista por ordem crescente, exemplo a primeira q é q vai aparecer no topo, e a ultima é a arma atual dele, serão sempre 5
    '', 
    '',
    '',
    '',
    '',
  }
})
```

## X1

Quando ele convida para um x1 é enviado uma requisição:

```lua
RegisterNuiCallback('X1_INVITE', function(data, cb)
  local bet = data.bet -- valor da aposta
  local user = data.user -- usuario que vai ser convidado
  local rounds = data.rounds -- quantidade de rounds
  local makapoints = data.makapoints -- se o valor da aposta vai ser em makapoints ou não
  local weapon = data.weapon -- arma do x1
end)
```

Para disparar a requisição na tela do outro player:

```lua
SendNUIMessage({ 
  action = 'request',
  data = {
    name = 'Pedro Silva', -- nome de quem convidou
    weapon = 'Five-Seven', -- nome da arma do x1
    rounds = 20, -- quantidade de rounds
    visibled = true -- se a request vai ser visivel ou não
    bet = {
      makapoints = true, -- se o valor da aposta é em makapoints ou não
      value = 20 -- valor da aposta
    }
  }
})
```

Como vai ser por keymapping fiz dois listeners para aceitar/recusar que disparam um callback:

```lua
SendNUIMessage({ action = 'requestAccept' })
```

Que dispara o callback:

```lua
RegisterNuiCallback('REQUEST_ACCEPT', function(data, cb)
  -- function
  cb(true)
end)
```

```lua
SendNUIMessage({ action = 'requestRefused' })
```

Que dispara o callback:

```lua
RegisterNuiCallback('REQUEST_REFUSED', function(data, cb)
  -- function
  cb(true)
end)
```

Para habilitar navegar para a hud do X1:

```lua
SendNUIMessage({
  action = 'open:hud',
  data = 'x1'
})
```

Para atualizar os valores do score:

```lua
SendNUIMessage({
  action = 'updateScore',
  data = {
    timer = 20, -- em segundos para eu decrementar no front
    player1 = { icon = '', points 10 } -- informacoes do player1
    player2 = { icon = '', points 10 } -- informacoes do player2
  }
})
```

Para atualizar os pontos do player1:

```lua
SendNUIMessage({
  action = 'updatePlayer1',
  data = 2 -- quantidade de pontos
})
```

Para atualizar os pontos do player2:

```lua
SendNUIMessage({
  action = 'updatePlayer2',
  data = 5 -- quantidade de pontos
})
```

## Hoverfy 

Hoverfy que aparece apenas na area do PVP:

```lua
SendNUIMessage({
  action = 'hoverfy',
  data = {
    visibled = true -- true/false
  }
})
```

## Teams

Quando for acessar a sala:

```lua
RegisterNuiCallback('JOIN_ROOM', function(data, cb)
  local mode = data.mode 

  if mode == 'teams' then -- quando voce for abrir a tela de entrar/alterar time
    SendNUIMessage({ action = 'open:room', type= 'teams' })
  end

  cb(true)
end)
```

Quando renderiza o saguão da sala, executa um fetch:

```lua
RegisterNuiCallback('GET_ROOM', function(data, cb)
  cb({
    id = 1123213,
    name = 'Nome da sala',
    image = '/images/rooms/room1.png',
    players = {
      current = 1,
      max = 3
    },
    weapon = 'AK-47',
    rounds = 10,
    mode = 'TIMES',
    minutes = 10,
    teams = {
      ct = { -- clan é opcional caso o player não tenha não precisa enviar, my é pra eu saber quem alterar o time, envia true para aquele que for o cara q abriu a interface e leader pro criador/lider da sala
        { my = true, name = 'Ruan Pablo', elo = 'Bronze',  clan = 'BIBA', banner = '/images/ranking/bronze.png' },
        { leader = true, name = 'Flavio Jeremias', elo = 'Ouro',  clan = 'BIBA', banner = '/images/ranking/bronze.png' },
        { name = 'Flavio Jeremias', elo = 'Ouro',  clan = 'BIBA', banner = '/images/ranking/bronze.png' },
      },
      tr = {
        { name = 'Ruan Pablo', elo = 'Bronze',  clan = 'BIBA', banner = '/images/ranking/bronze.png' },
        { name = 'Flavio Jeremias', elo = 'Ouro',  clan = 'BIBA', banner = '/images/ranking/bronze.png' },
        { name = 'Flavio Jeremias', elo = 'Ouro',  clan = 'BIBA', banner = '/images/ranking/bronze.png' },
      }
    }
  })
end)
```

Sempre que o player troca de time eu envio um fetch com os valor da sala inteira atualizado:

```lua
RegisterNuiCallback('ROOM_UPDATED', function(data, cb)
  local room = data.room
  cb(true)
end)
```

E também criei um listener pra quando voce quiser adicionar ou altera alguma informação da sala:

```lua
SendNUIMessage({
  action = 'ROOM_UPDATED'
  data = {
    id = 1123213,
    name = 'Nome da sala',
    image = '/images/rooms/room1.png',
    players = { current = 1, max = 3 },
    weapon = 'AK-47',
    rounds = 10,
    mode = 'TIMES',
    minutes = 10,
    teams = {
      ct = {
        { my = true, name = 'Ruan Pablo', elo = 'Bronze',  clan = 'BIBA', banner = '/images/ranking/bronze.png' },
        { leader = true, name = 'Flavio Jeremias', elo = 'Ouro',  clan = 'BIBA', banner = '/images/ranking/bronze.png' },
        { name = 'Flavio Jeremias', elo = 'Ouro',  clan = 'BIBA', banner = '/images/ranking/bronze.png' },
      },
      tr = {
        { name = 'Ruan Pablo', elo = 'Bronze',  clan = 'BIBA', banner = '/images/ranking/bronze.png' },
        { name = 'Flavio Jeremias', elo = 'Ouro',  clan = 'BIBA', banner = '/images/ranking/bronze.png' },
        { name = 'Flavio Jeremias', elo = 'Ouro',  clan = 'BIBA', banner = '/images/ranking/bronze.png' },
      }
    }
  }
})
```

Quando o dono clicar em start game, te envio um callback:

```lua
RegisterNuiCallback('START_GAME', function(data, cb)
  local room = data.room
  -- logica para enviar para a hud lembrar de passar o type = 'teams' na hora de abrir a hud
  cb(true)
end)
```

## Teams HUD

Na hora de atualizar o scoreboard:

```lua
SendNUIMessage({ 
  action = 'UPDATE_SCOREBOARD',
  data = {
    visibled = true,
    players = { -- tem a propriedade que voce vai precisar enviar q é team = ct ou tr 
      { elo = 'Bronze', name = 'Ruan Pablo', ping = 20, kills = 20, deaths = 20, team = 'ct' },
      { elo = 'Bronze', name = 'Ruan Pablo', ping = 20, kills = 20, deaths = 20, team = 'tr' },
    }
  }
})
```

Para atualizar os pontos de cada time: 

```lua
SendNUIMessage({
  action = 'UPDATE_SCOREBOARD',
  data = { 
    ct = 10, 
    tr = 20 
  } -- quantidade de pontos
})
```

Para atualizar os times:

```lua
SendNUIMessage({
  action = 'UPDATE_PLAYERS',
  data = { -- enviando o team para eu separador no front qual lado ele vai ficar
    { icon = '', alive = true, team = 'ct' },
    { icon = '', alive = true, team = 'ct' },
    { icon = '', alive = false, team = 'tr' },
    { icon = '', alive = true, team = 'tr' },
  }
})
```