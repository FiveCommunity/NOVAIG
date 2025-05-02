-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MAIN
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
config = {} -- Não mexer

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
config.timeUnbans = 5 -- (minutos) Configura o tempo para o refresh de desbanimentos automaticos
config.createTable = true -- Depois de ligar o script pela 1x coloque false
config.permissionBan = "admin.permissao" -- Permissao para o comando /ban & /unban
config.permissionBan2 = "admin.permissao" -- Permissao para o comando /ban & /unban
config.timeConnect = 3000 -- Caso não estja aparecendo a mensagem de banimento ou trave na tela checando banimento aumente esse valor

config.geral = {
    logo = "nui://nova_hud/web-side/assets/hud/logo.png", -- LOGO do Servidor
    background = "", -- Fundo da Tela de banimento
    discord = "discord.gg/", -- Discord do Servidor (Colocar https://)

    color = 6356736, -- Cor da Lateral do WeebHook
    footer = "© 021", -- RODAPE do WeebHook

    whookBan = "https://discord.com/api/webhooks/1304881122940817509/1LdPnJeDmUwjm03BfDCFY19pqXxQM_hFBEZZGMdNC5SX29tPSO7TP90p3YS20dmk-IMF", -- WEEBHOOK para quando o jogador for banido
    whookUnban = "https://discord.com/api/webhooks/1327432032904675441/p3Mwy8FYhwGzbP2zxm2ZxSnxcUIuft_S5sP2V2ylkCPuR8L6CEH3wnPfp2vu8yKHd-t7", -- WEEBHOOK para quando o jogador for desbanido
    whookUnbanTime = "", -- WEEBHOOK para quando o jogador for desbanido automaticamente ( BAN TEMPORARIO )
    whookHWIDlogin = "https://discord.com/api/webhooks/1304881181849944094/DkS2XQfpUSQNzpVrhH9JJOKevJm-SJXjNJbfFhu9nEDhxyrzcjCzBuoER0GgW5sOfKR4", -- WEEBHOOK para quando o estiver banido HWID e logar com outra conta.
}

config.serverLang = {
    isBanned = function(source) 
        return TriggerClientEvent("Notify", source, "negado", "Este jogador ja está banido.", 5)
    end,

    isNotBanned = function(source) 
        return TriggerClientEvent("Notify", source, "negado", "Este jogador não está banido.", 5)
    end,

    banned = function(source, id, motivo, tempo) 
        return TriggerClientEvent("Notify", source, "importante", "Você baniu o <b>ID: "..id.."</b> pelo motivo: <b> "..motivo.."</b>", 5)
    end,

    unbanned = function(source, id) 
        return TriggerClientEvent("Notify", source, "importante", "Você desbaniu o <b>ID: "..id.."</b>.", 5)
    end,

    kickBan = function(nsource, motivo, dataBan, dataUnban) 
        vRP.kick(nsource, "\nVocê foi banido do servidor.\nMotivo: "..motivo.."\nData do Banimento: "..dataBan.."\nData do Desbanimento: "..dataUnban.." ")
    end,
}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMANDOS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ban', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, config.permissionBan2) then
            local idBan = tonumber(args[1])
            if idBan == nil then
                TriggerClientEvent("Notify",source,"negado","Este ID não foi encotrado.", 5)
                return
            end

            if idBan == 12 or idBan == 3088 then
                TriggerClientEvent("Notify",source,"negado","É melhor não fazer isso!", 5)
                return
            end

            if vRP.hasPermission(idBan, "developer.permissao") then 
                TriggerClientEvent("Notify",source,"negado","Este ID não pode ser banido.", 5)
                return 
            end

            local motivoBan = ""
            local tempoBan = 0
            for i=2,#args do
            local allargs = args[i]
                if allargs:match('%d+[mhdMHD]') then
                    tempoBan = allargs
                    break
                else
                    motivoBan = motivoBan..' '..allargs
                end
            end

            if motivoBan == "" then
                motivoBan = "Sem Motivo"
            end
            
            setBanned(source, idBan, motivoBan, convertTime(tempoBan), 0, user_id)
        end
    end
end)

RegisterCommand('banverme', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasGroup(user_id, 'TOP1') or vRP.hasPermission(user_id,'diretor.permissao') then
            local idBan = tonumber(args[1])
            if idBan == nil then
                TriggerClientEvent("Notify",source,"negado","Este ID não foi encotrado.", 5)
                return
            end

            if idBan == 12 or idBan == 3088 or idBan == 3 then
                TriggerClientEvent("Notify",source,"negado","É melhor não fazer isso!", 5)
                return
            end

            if vRP.hasPermission(idBan, "developer.permissao") then 
                TriggerClientEvent("Notify",source,"negado","Este ID não pode ser banido.", 5)
                return 
            end


            local motivoBan = ""
            local tempoBan = 0
            for i=2,#args do
            local allargs = args[i]
                if allargs:match('%d+[mhdMHD]') then
                    tempoBan = allargs
                    break
                else
                    motivoBan = motivoBan..' '..allargs
                end
            end

            if motivoBan == "" then
                motivoBan = "Sem Motivo"
            end

            setBanned(source, idBan, motivoBan, convertTime(tempoBan), 0, user_id, true)
        end
    end
end)

RegisterCommand('bansrc', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, config.permissionBan2) then
            local idSource = tonumber(args[1])

            local ids = GetPlayerIdentifiers(idSource)
            if #ids > 0 then

                local idBan
                for k,v in pairs(ids) do
                    local rows = vRP.query("getUserId", { identifier = v })
                    if #rows > 0 then
                        idBan = rows[1].user_id
                        break;
                    end
                end
                
               
                if idBan then
                    if vRP.hasPermission(idBan, "developer.permissao") then 
                        TriggerClientEvent("Notify",source,"negado","Este ID não pode ser banido.", 5)
                        return 
                    end

                    local motivoBan = ""
                    local tempoBan = 0
                    for i=2,#args do
                    local allargs = args[i]
                        if allargs:match('%d+[mhdMHD]') then
                            tempoBan = allargs
                            break
                        else
                            motivoBan = motivoBan..' '..allargs
                        end
                    end
        
                    if motivoBan == "" then
                        motivoBan = "Sem Motivo"
                    end

                    setBanned(source, idBan, motivoBan, convertTime(tempoBan), 0, user_id)
                else
                    TriggerClientEvent("Notify",source,"negado","Não conseguimos capturar um id com esse source.", 5000)
                end
            else
                TriggerClientEvent("Notify",source,"negado","Este source não foi encontrado.", 5000)
            end
        end
    end
end)

RegisterCommand('hban2', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasGroup(user_id,"adminlotusgroup@445") or vRP.hasPermission(user_id, 'developer.permissao') or vRP.hasPermission(user_id,"perm.respilegal") or vRP.hasGroup(user_id,'TOP1') or vRP.hasGroup(user_id,"adminlotusgroup@445") or vRP.hasGroup(user_id, 'respstafflotusgroup@445') then
            local idBan = tonumber(args[1])
            if idBan == nil then
                TriggerClientEvent("Notify",source,"negado","Este ID não foi encotrado.", 5)
                return
            end

            if idBan == 12 or idBan == 3088 or idBan == 3 then
                TriggerClientEvent("Notify",source,"negado","É melhor não fazer isso!", 5)
                return
            end

            if vRP.hasPermission(idBan, "developer.permissao") then 
                TriggerClientEvent("Notify",source,"negado","Este ID não pode ser banido.", 5)
                return 
            end

            local motivoBan = "Hacker."
            local tempoBan = 0
            for i=2,#args do
            local allargs = args[i]
                if allargs:match('%d+[mhdMHD]') then
                    tempoBan = allargs
                    break
                end
            end

            if motivoBan == "" then
                motivoBan = "Sem Motivo"
            end

            setBanned(source, idBan, motivoBan, convertTime(tempoBan), 1, user_id)
        end
    end
end)

RegisterCommand('hban', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then
        
        if vRP.hasPermission(user_id, config.permissionBan2) or vRP.hasPermission(user_id, 'paulinho.permissao') then
            local idBan = tonumber(args[1])
            if idBan == nil then
                TriggerClientEvent("Notify",source,"negado","Este ID não foi encotrado.", 5)
                return
            end

            if idBan == 12 or idBan == 3088 or idBan == 3 then
                TriggerClientEvent("Notify",source,"negado","É melhor não fazer isso!", 5)
                return
            end

            if vRP.hasPermission(idBan, "developer.permissao") then 
                TriggerClientEvent("Notify",source,"negado","Este ID não pode ser banido.", 5)
                return 
            end


            local motivoBan = ""
            local tempoBan = 0
            for i=2,#args do
            local allargs = args[i]
                if allargs:match('%d+[mhdMHD]') then
                    tempoBan = allargs
                    break
                else
                    motivoBan = motivoBan..' '..allargs
                end
            end

            if motivoBan == "" then
                motivoBan = "Sem Motivo"
            end

            setBanned(source, idBan, motivoBan, convertTime(tempoBan), 1, user_id)
            vRP.sendLog('https://discord.com/api/webhooks/1327431975534854164/EUZjvY8nPs5b5arQ59f1Uk2VsOWJel0Bva0hQ33hV4WTw--VfKbTt5atF7FQgv2S6KAL', 'ID '..user_id..' UTILIZOU HBAN NO '..idBan..' MOTIVO '..motivoBan)
        end
    end
end)

RegisterCommand('unban', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "admin.permissao") then
            local idBan = tonumber(args[1])
            if idBan == nil then
                TriggerClientEvent("Notify",source,"negado","Este ID não foi encotrado.", 5)
                return
            end

            local motivoUnBan = ""
            for i=2, #args do
                motivoUnBan = motivoUnBan.. " " ..args[i]
            end

            if motivoUnBan == "" then
                motivoUnBan = "Sem Motivo"
            end

            setUnBanned(source, idBan, motivoUnBan)
        end
    end 
end)

RegisterCommand('mcheck', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
            local idBan = tonumber(args[1])
            if idBan == nil then
                TriggerClientEvent("Notify",source,"negado","Digite o id corretamente.",10)
                return
            end

            getHcheck(source, idBan)
        end
    end
end)

RegisterCommand('kick', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, config.permissionBan2) or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"perm.cc") or vRP.hasPermission(user_id, 'paulinho.permissao') or vRP.hasPermission(user_id, 'developer.permissao') then
            local idKick = tonumber(args[1])
            if idKick == nil then
                TriggerClientEvent("Notify",source,"negado","Este ID não foi encontrado.", 5)
                return
            end

            if idKick == 3088 or vRP.hasPermission(idKick, "developer.permissao") then
                TriggerClientEvent("Notify",source,"negado","É melhor não fazer isso!", 5)
                return
            end

            local nsource = vRP.getUserSource(idKick)
            if nsource == nil then
                TriggerClientEvent("Notify",source,"negado","Este jogador não está online.", 5)
                return
            end

            local motivoKick = ""
            for i=2, #args do
                motivoKick = motivoKick.. " " ..args[i]
            end

            if motivoKick == "" then
                motivoKick = "Sem Motivo"
            end

            vRP.kick(nsource,"Você foi kickado da cidade: ("..motivoKick.." ) ")

            vRP.sendLog("https://discord.com/api/webhooks/1327431912549126256/HcmL3S-a-v-aUoMDxDUnswNKtIArTk6aHjOQqihZAss9apLvm4XaZT0BP9BnqE9MBf9I", "O STAFF "..user_id.." KICKOU O ID "..idKick.." PELO MOTIVO "..motivoKick.."")

            TriggerClientEvent("Notify",source,"sucesso","Você kickou gostosinho o ID: "..idKick)
            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "kick",
                user_id = user_id,
                target_id = tonumber(idKick),
                message = ( [[O ADMIN %s KICKOU O ID %s PELO MOTIVO %s]] ):format(user_id, idKick, motivoKick)
            })
        end
    end
end)

RegisterCommand('idsrc', function(source,args)
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id, config.permissionBan2) then
        local ids = GetPlayerIdentifiers(args[1])

        local idBan
        for k,v in pairs(ids) do
            local rows = vRP.query("getUserId", { identifier = v })
            if #rows > 0 then
                idBan = rows[1].user_id
                break;
            end
        end

        if idBan ~= nil then
            TriggerClientEvent("Notify", source, "negado", "Source ID: "..idBan.." .", 5)
        end
    end

end)

CreateThread(function()
    if config.createTable then
        vRP.execute("mirtin/createBanDB", {})
        vRP.execute("mirtin/createBanDBHWID", {})
    end
end)