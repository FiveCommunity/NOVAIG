local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("mirtin_survival",src)
Proxy.addInterface("mirtin_survival",src)

vCLIENT = Tunnel.getInterface("mirtin_survival")
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
cfg = {}
config = {}

config.token = "7cf5aced163d824e8e74aa51f596910d" -- configure aqui seu token [ DEFINA-SEU-TOKEN-AQUI ]
cfg.weebhook = "https://ptb.discord.com/api/webhooks/1313514268263579730/5m0hE4ZsEkY98t_2ewyQmSPX8iqI6A8h_ddIB9OsixBgjoJnTDTgM4IAsM3H-BBWnv_k" -- WEEBHOOK
cfg.logo = "https://media.discordapp.net/attachments/999123993330200656/1111409407218171934/logo.png?width=575&height=670" -- IMAGEM DO WEEBHOOK
cfg.color = 6356736 -- COR DO WEEBHOOK

src.limparConta = function() -- FUNÇÃO QUE VEM DO CONFIG.CLIENT PARA EXECUTAR FUNÇÕES DIRETAS
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if not Player(source).state.NovatMode then
            vRP.clearAccount(user_id)
        end
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE DISCONNECT
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDropped", function(reason)
    local source = source
    local coords = GetEntityCoords(GetPlayerPed(source))
    local user_id = vRP.getUserId(source)
    if user_id then
        TriggerClientEvent("anticl", -1, user_id, coords, reason )
        vRP.sendLog('https://discord.com/api/webhooks/1238198698106814586/51-8BBnmLATnY-RSLgV9yj2fOz9uGKQc1TTHjdaJb61SHoUynjDft9FQwv5iSZS31Bfx', 'ID '..user_id..' deslogou em '..json.encode(coords))
    end
end)