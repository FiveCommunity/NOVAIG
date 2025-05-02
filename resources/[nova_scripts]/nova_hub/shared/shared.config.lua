ServicesList = {
    ["god"] = { perm = "ticket.permissao", category = "god", label = "Staff", isStaff = true },
    ["bombeiro"] = { perm = "perm.chamadosbombeiro", category = "bombeiro", label = "Bombeiro", checkPatrol = true, price = 5000 },
    ["hospital"] = { perm = "perm.chamadoshubhospital", category = "hospital", label = "Hospital", checkPatrol = true, price = 5000 },
    ["policia"] = { perm = "perm.disparo", category = "policia", label = "Policia", checkPatrol = true, price = 0 },
    ["mecanico"] = { perm = "perm.chamadomec", category = "mecanico", label = "Mecanico", checkPatrol = true , price = 5000},
    ["advocacia"] = { perm = "perm.judiciario", category = "advocacia", label = "Advocacia", checkPatrol = true, price = 0 },
}

StaffRoles = {
    ['TOP1'] = { label = 'TOP1', value = 'TOP1', selected = false, hasPermission = true },
    ['developerlotusgroup@445'] = { label = 'Desenvolvedor', value = 'developerlotusgroup@445', selected = false, hasPermission = true },
    ['adminlotusgroup@445'] = { label = 'Admin', value = 'adminlotusgroup@445', selected = false, hasPermission = false },
    ['respeventoslotusgroup@445'] = { label = 'Respeventos', value = 'respeventoslotusgroup@445', selected = false, hasPermission = false },
    ['moderadorlotusgroup@445'] = { label = 'Moderador', value = 'moderadorlotusgroup@445', selected = false, hasPermission = false },
    ['suportelotusgroup@445'] = { label = 'Suporte', value = 'suportelotusgroup@445', selected = false, hasPermission = false },
    ['resploglotusgroup@445'] = { label = 'Resplog', value = 'resploglotusgroup@445', selected = false, hasPermission = false },
}

HubCalls = {

    HighUserId = {
        counterBeforeLastId = 5000,
    },

    timerShowFinishCall =  {
        ['god'] = (1 * 60 * 1000) + (30 * 1000),
        ['bombeiro'] = (3 * 60 * 1000),
        ['hospital'] = (3 * 60 * 1000),
        ['policia'] = (3 * 60 * 1000),
        ['mecanico'] = (3 * 60 * 1000),
        ['advocacia'] = (3 * 60 * 1000),
    },
}

Helps = {
    god = {
        { 
            title = "Não consigo ouvir nem falar com jogadores", 
            description = "Certifique-se de que seu microfone está configurado corretamente no menu de configurações do FiveM. Verifique também se o dispositivo padrão do Windows está correto."
        },
        { 
            title = "Meu personagem está preso", 
            description = "Você pode tentar usar o comando /respawn para reiniciar o seu personagem. Caso não funcione, peça ajuda a um administrador."
        },
        { 
            title = "Itens sumiram do meu inventário", 
            description = "Tente relogar no servidor. Se o problema persistir, entre em contato com o suporte ou admin do servidor fornecendo detalhes."
        },
        { 
            title = "Meu veículo desapareceu", 
            description = "Isso pode acontecer se você sair do jogo sem guardar o veículo em uma garagem. Verifique se ele foi recuperado pela polícia ou está em um depósito."
        },
        { 
            title = "Não consigo equipar armas", 
            description = "Certifique-se de que você tem slots disponíveis no inventário. Algumas armas podem precisar de um espaço maior."
        },
        { 
            title = "Minha tela está travada ou bugada", 
            description = "Pressione ALT+TAB para alternar entre janelas e retorne ao jogo. Caso o problema persista, reinicie o FiveM."
        },
        { 
            title = "Como faço para comprar propriedades?", 
            description = "Procure um corretor no servidor ou visite os locais marcados no mapa para adquirir propriedades disponíveis."
        },
        { 
            title = "Os comandos não estão funcionando", 
            description = "Certifique-se de estar digitando o comando corretamente, incluindo a barra (/). Confira também se o servidor está ativo e sem problemas."
        },
    },
    bombeiro = {
        { 
            title = "Meu veículo está em chamas", 
            description = "Faça um chamado para o bombeiro."
        },
        {
            title = "Fui atingido por chamas e estou em chamas",
            description = "Role no chão para tentar apagar o fogo e chame imediatamente o bombeiro para receber atendimento."
        },
        {
            title = "Incêndio em um prédio",
            description = "Mantenha distância, avise outros jogadores na área e faça um chamado urgente para o bombeiro. Não tente apagar sozinho se não tiver o equipamento adequado."
        },
        {
            title = "Como utilizar um extintor de incêndio",
            description = "Aproxime-se da fonte do fogo, equipe o extintor, aponte para a base das chamas e acione o extintor até que o fogo seja controlado."
        },
        {
            title = "Existe vazamento de gás",
            description = "Afaste-se imediatamente da área, não acenda chamas ou cigarro e informe aos bombeiros, que possuem equipamentos específicos para lidar com vazamentos."
        }
    },
    hospital = {
        { 
            title = "Como solicitar atendimento médico",
            description = "Use o comando /call hospital para solicitar a presença de um médico. Forneça o máximo de detalhes sobre sua condição."
        },
        {
            title = "Estou desmaiado",
            description = "Aguarde a chegada de um médico. Não se mova para evitar agravar ferimentos."
        },
        {
            title = "Fui atropelado por um veículo",
            description = "Procure um médico imediatamente. Caso não consiga se locomover, use /call hospital para receber ajuda no local."
        },
        {
            title = "Quero curar ferimentos leves",
            description = "Visite o hospital mais próximo, procure um médico ou um enfermeiro e solicite curativos ou bandagens para tratar cortes superficiais."
        },
        {
            title = "Preciso de medicamentos",
            description = "Consulte um médico no hospital para obter prescrições e medicamentos adequados à sua condição. Não se automedique."
        }
    },    
}
