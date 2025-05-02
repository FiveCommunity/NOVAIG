Para melhor visualização clique com o botão direito > Abrir Preview

## NUI Messages

### Abrir Tablet
  ```lua
  SendNUIMessage({
    action = "openTablet",
    data = {
      name = string, --Nome do policial
      image = string --Imagem do policial
      id = number --Id do policial
      permissions = {'CAN_CREATE_WARN', 'CAN_DELETE_WARN', 'CAN_CREATE_BULLETIN', 'CAN_DELETE_BULLETIN'} --Array de permissões do policial
    }
  })
  ```

### Visualizar especificações do veículo pela placa
  ```lua
  SendNUIMessage({
    action = "viewVehicleByPlate",
    data = string -- Placa do veículo
  })
  ```

## Requisições

### [Home] Buscar status dos registros semanais (Gráfico)
<span style="color: lightgreen; font-size: 1rem;margin-left: 1.4rem">src: [Linha da requisição](nui/src/page/home/index.tsx#L29)</span><br>
<span style="color: lightyellow; font-size: 1rem;margin-left: 1.4rem">endpoint: <strong>getWeeklyRecordStatus</strong></span>
- **Método**: GET
- **Parâmetros**: Nenhum
- **Retorno**: 
  ```ts
  [
    {
      data: string; //Data em string "10/05"
      amount: number; //Quantia máxima de registros do gráfico
      prisions: number; //Quantia de prisões
      fines: number; //Quantia de multas
    }
  ]
  ```

### [Home] Buscar mural de avisos
<span style="color: lightgreen; font-size: 1rem;margin-left: 1.4rem">src: [Linha da requisição](nui/src/page/home/index.tsx#L33)</span><br>
<span style="color: lightyellow; font-size: 1rem;margin-left: 1.4rem">endpoint: <strong>getBulletins</strong></span>
- **Método**: GET
- **Parâmetros**: Nenhum
- **Retorno**: 
  ```ts
  [
    {
      id: number //Id do aviso
      officerImage: string //Imagem do policial
      officerName: string //Nome do policial
      createdAt: number //Timestamp da criação do aviso
      message: string //Mensagem do aviso
    }
  ]
  ```

### [Home] Criar aviso
<span style="color: lightgreen; font-size: 1rem;margin-left: 1.4rem">src: [Linha da requisição](nui/src/page/home/index.tsx#L43)</span><br>
<span style="color: lightyellow; font-size: 1rem;margin-left: 1.4rem">endpoint: <strong>createBulletin</strong></span>
- **Método**: POST
- **Parâmetros**:
  ```ts
  { 
    message: string //Texto do aviso
  }
  ```
- **Retorno:** 
  ```ts 
    cb(boolean) //True se deu certo false se não
  ```

### [Home] Deletar aviso
<span style="color: lightgreen; font-size: 1rem;margin-left: 1.4rem">src: [Linha da requisição](nui/src/page/home/components/Bulletin/index.tsx#L19)</span><br>
<span style="color: lightyellow; font-size: 1rem;margin-left: 1.4rem">endpoint: <strong>deleteBulletin</strong></span>
- **Método**: POST
- **Parâmetros**:
  ```ts
  { 
    id: number //Id do aviso que será deletado
  }
  ```
- **Retorno:** 
  ```ts 
  boolean //Se for true irá remover o aviso da lista no front-end, se for falso não acontecerá nada
  ```

### [Pesquisar pessoas] Pesquisar Cidadão 
<span style="color: lightgreen; font-size: 1rem;margin-left: 1.4rem">src: [Linha da requisição](nui/src/page/user/index.tsx#L45)</span><br>
<span style="color: lightyellow; font-size: 1rem;margin-left: 1.4rem">endpoint: <strong>searchUser</strong></span>
- **Método**: GET
- **Parâmetros**: Nenhum
- **Retorno:** 
  ```ts
  { 
    name: string, //Nome do cidadão
    id: number, //Id do cidadão
    rg: string, //Registro do cidadão
    age: number, //Idade do cidadão
    image: string, //Imagem do cidadão
    isWanted: boolean, // Procurado / Não Procurado
    hasGunLicense: boolean, // Com porte / Sem porte
    historic: [
      {
          type: string, // Tipo do histórico (Prisão, Multa, etc...)
          date: number, // Timestamp do ocorrido
          officer: string, // Nome do oficial que aplicou
          value: string // Valor / Quantia
      }
    ]
  }
  ```

### [Prender/Multar] Buscar lista de artigos (Só é requisitado 1 vez, mantido em cache)
<span style="color: lightyellow; font-size: 1rem;margin-left: 1.4rem">endpoint: <strong>getArticles</strong></span>
- **Método**: GET
- **Parâmetros**: Nenhum
- **Retorno:** 
  ```ts
  [
    {
      id: number, //Id do artigo
      name: string, //Nome do artigo
      time: number, //Tempo de prisão do artigo
      fine: number //Valor em multa do artigo
    }
  ]
  ```

### [Prender/Multar] Buscar players próximos ao policial
<span style="color: lightyellow; font-size: 1rem;margin-left: 1.4rem">endpoint: <strong>getNearestPlayers</strong></span>
- **Método**: GET
- **Parâmetros**: Nenhum
- **Retorno:** 
  ```ts
  [
    {
      id: number, //Id do jogador
      name: string, //Nome do jogador
    }
  ]
  ```

### [Prender] Aplicar prisão
<span style="color: lightgreen; font-size: 1rem;margin-left: 1.4rem">src: [Linha da requisição](nui/src/page/arrest/index.tsx#L76)</span><br>
<span style="color: lightyellow; font-size: 1rem;margin-left: 1.4rem">endpoint: <strong>getNearestPlayers</strong></span>
- **Método**: POST
- **Parâmetros**:
  ```ts
  {
    infractor: {
      id: number, //Id do infrator
      name: string //Nome do infrator
    },
    articles: [
      {
        id: number, //Id do artigo
        name: string, //Nome do artigo
        time: number, //Tempo de prisão do artigo
        fine: number //Valor em multa do artigo
      }
    ],
    time: number, //Tempo de prisão
    fine: number, //Valor em multa
  }
  ```
- **Retorno:** Nenhum

### [Multar] Aplicar multa
<span style="color: lightgreen; font-size: 1rem;margin-left: 1.4rem">src: [Linha da requisição](nui/src/page/fine/index.tsx#L58)</span><br>
<span style="color: lightyellow; font-size: 1rem;margin-left: 1.4rem">endpoint: <strong>applyFine</strong></span>
- **Método**: POST
- **Parâmetros**: 
  ```ts
  {
    infractor: {
      id: number, //Id do infrator
      name: string //Nome do infrator
    },
    articles: [
      {
        id: number, //Id do artigo
        name: string, //Nome do artigo
        time: number, //Tempo de prisão do artigo
        fine: number //Valor em multa do artigo
      }
    ],
    description: string, //Descrição da multa
  }
  ```
- **Retorno:** Nenhum

### [Procurados] Buscar Cidadãos Procurados 
<span style="color: lightgreen; font-size: 1rem;margin-left: 1.4rem">src: [Linha da requisição](nui/src/page/wanted/index.tsx#L29)</span><br>
<span style="color: lightyellow; font-size: 1rem;margin-left: 1.4rem">endpoint: <strong>getWantedPlayers</strong></span>
- **Método**: GET
- **Parâmetros**: Nenhum
- **Retorno:** 
  ```ts
  [
    {
      id: number //Id do procurado
      name: string //Nome do procurado
      reason: string //Motivo
      officerName: string //Nome do policial que definiu como procurado
      wantedTime: number //Numero em dias que está procurado
    }
  ]
  ```

### [Boletins de Ocorrência] Buscar Boletins de ocorrência
<span style="color: lightgreen; font-size: 1rem;margin-left: 1.4rem">src: [Linha da requisição](nui/src/page/reports/index.tsx#L14)</span><br>
<span style="color: lightyellow; font-size: 1rem;margin-left: 1.4rem">endpoint: <strong>getReports</strong></span>
- **Método**: GET
- **Parâmetros**: Nenhum
- **Retorno:** 
  ```ts
  [
    {
      officerName: string //Nome do policial
      targetId: number //Id do cidadão que foi denunciado
      createdAt: number //Timestamp da criação do boletim
      description: string // Descrição do boletim
    }
  ]
  ```

### [Boletins de Ocorrência] Criar boletim de ocorrência
<span style="color: lightgreen; font-size: 1rem;margin-left: 1.4rem">src: [Linha da requisição](nui/src/page/reports/index.tsx#L14)</span><br>
<span style="color: lightyellow; font-size: 1rem;margin-left: 1.4rem">endpoint: <strong>createReport</strong></span>
- **Método**: POST
- **Parâmetros**: 
  ```ts
    {
      claimant: {
        id: number, //Id do requerente
        name: string //Nome do requerente
      },
      description: string, //Descrição do boletim
      target: number, //Id do cidadão que está recebendo denúncia
    }
  ```
- **Retorno:** Nenhum

### [Boletins de Ocorrência] Deletar boletim de ocorrência
<span style="color: lightgreen; font-size: 1rem;margin-left: 1.4rem">src: [Linha da requisição](nui/src/page/reports/index.tsx#L14)</span><br>
<span style="color: lightyellow; font-size: 1rem;margin-left: 1.4rem">endpoint: <strong>deleteReport</strong></span>
- **Método**: POST
- **Parâmetros**: 
  ```ts
    {
      targetId: number, //Id do cidadão que foi denunciado nesse boletim 
    }
  ```
- **Retorno:** 
  ```
    cb(boolean) Se for true irá remover o boletim da lista no front-end, se for falso não acontecerá nada
  ```

### [Veículo] Buscar veículo pela placa
<span style="color: lightgreen; font-size: 1rem;margin-left: 1.4rem">src: [Linha da requisição](nui/src/page/vehicle/index.tsx#L41)</span><br>
<span style="color: lightyellow; font-size: 1rem;margin-left: 1.4rem">endpoint: <strong>searchVehicleByPlate</strong></span>
- **Método**: GET
- **Parâmetros**: 
  ```ts
    {
      plate: string //Placa do veículo
    }
  ```
- **Retorno**: 
  ```ts
  {
    name: string //Nome do dono
    id: number //Id do dono
    phone: string //Numero de telefone do dono
    plate: string //Placa do veículo
    image: string //Imagem do veículo ou do dono
    vehicleModel: string //Modelo do veículo
    isWanted: boolean // Procurado ou não
    historic: [
      {
        type: string, //Tipo do registro (Detido, etc...)
        date: number, //timestamp de quando foi registrado
        officer: string, //Nome do oficial
        reason: string, //Motivo da detenção
        value: number // Valor em dinheiro
      }
    ]
  }
  ```