local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local totalBanidos = 0
local autenticado = true


vRP.prepare("mirtin_bans/SetBanIP", "INSERT INTO mirtin_bans_ip (user_id,ip) VALUES(@user_id, @ip)")
vRP.prepare("mirtin_bans/GetBanIp", "SELECT id,ip FROM vrp_users WHERE id = @user_id")
vRP.prepare("mirtin/removeBannedIP", "DELETE FROM mirtin_bans_ip WHERE user_id = @user_id")
vRP.prepare("mirtin/createTable", "CREATE TABLE IF NOT EXISTS `mirtin_bans_ip` ( `user_id` int(11) DEFAULT NULL, `ip` varchar(50) DEFAULT NULL ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;")


setBanned = function(source, target_id, motivo, tempo, hwid, staffBan, verme)
    target_id = parseInt(target_id)
    if autenticado then
        local source = source
        local user_id = vRP.getUserId(source)
        local rows = vRP.query("mirtin/getUserBanned", { user_id = target_id })
        local nsource = vRP.getUserSource(target_id)

        if user_id then
            if #rows > 0 then
                config.serverLang['isBanned'](source)
                return
            end

            local formatHWID
            if hwid == nil or hwid <= 0 then
                formatHWID = "Não"
                hwid = 0
            else
                formatHWID = "Sim"
                hwid = 1
            end
            
            local dataBan = os.date("%d/%m/%Y as %H:%M")
            local dataUnban = os.date("%d/%m/%Y as %H:%M", tempo)
            local timeBan = tempo

            if tempo == 0 then
                dataUnban = "Nunca"
            end

            totalBanidos = totalBanidos + 1
            vRP.setBanned(target_id, true, motivo, tempo, verme,staffBan)

            config.serverLang['banned'](source, target_id, motivo, tempo)

            if nsource then
                config.serverLang['kickBan'](nsource, motivo, dataBan, dataUnban)
            end


            exports["vrp_admin"]:generateLog({
                category = "admin",
                room = "banir",
                user_id = user_id,
                target_id = tonumber(target_id),
                message = ( [[O ADMIN %s BANIU O ID %s PELO MOTIVO %s HWID %s]] ):format(user_id, target_id, motivo, hwid)
            })

            local discord
            local corpoBan
            local ids = GetPlayerIdentifiers(source)

            for k,v in pairs(ids) do
                if string.find(v,"discord:") then
                    discord = string.gsub(v, "discord:","")
                end
            end

            if discord == nil then 
                corpoBan = { 
                    { 
                        ["color"] = config.geral['color'], 
                        ["title"] = "**".. ":no_entry_sign: | Novo Banimento Registrado " .."**\n", 
                        ["thumbnail"] = { ["url"] = config.geral['logo'] },
                        ["description"] = "**Banido:**\n```cs\nID: "..target_id.."```\n**Banido por: **\n```cs\nID: "..user_id.."```\n**MOTIVO:** ```css\n - "..motivo.."```\n**Data do Banimento:**\n ```cs\n "..dataBan.."```\n**Data do Desbanimento:**\n ```cs\n "..dataUnban.."``` **HWID:** ```cs\n "..formatHWID.."``` ", 
                        ["footer"] = { ["text"] = config.geral['footer'], }, } 
                }
                sendToDiscord(config.geral['whookBan'], corpoBan)
                return
            end

            corpoBan = { 
                { 
                    ["color"] = config.geral['color'], 
                    ["title"] = "**".. ":no_entry_sign: | Novo Banimento Registrado " .."**\n", 
                    ["thumbnail"] = { ["url"] = config.geral['logo'] },
                    ["description"] = "**Banido:**\n```cs\nID: "..target_id.."```\n**Banido por: **\n```cs\nID: "..user_id.."``` ``Discord:`` <@"..discord..">\n\n**MOTIVO:** ```css\n - "..motivo.."```\n**Data do Banimento:**\n ```cs\n "..dataBan.."```\n**Data do Desbanimento:**\n ```cs\n "..dataUnban.."``` **HWID:** ```cs\n "..formatHWID.."``` ", 
                    ["footer"] = { ["text"] = config.geral['footer'], }, } 
            }
            sendToDiscord(config.geral['whookBan'], corpoBan)
        end
    end
end

setUnBanned = function(source, target_id, motivo)
    if autenticado then
       local source = source
       local user_id = vRP.getUserId(source)
       local rows = vRP.query("mirtin/getUserBanned", { user_id = target_id })
       if user_id then
           if #rows == 0 then
               config.serverLang['isNotBanned'](source)
               return
           end

           if rows[1].owner and (rows[1].owner == 1) and user_id ~= 2 then
                if not vRP.hasGroup(user_id, 'TOP1') then
                    TriggerClientEvent("Notify",source,"negado","Você não possui permissao para desbanir esse ID.", 5)
                    return
                end
            end

           totalBanidos = totalBanidos - 1

           local discord
           local corpoBan
           local ids = GetPlayerIdentifiers(source)

           for k,v in pairs(ids) do
               if string.find(v,"discord:") then
                   discord = string.gsub(v, "discord:","")
               end
           end

           exports["vrp_admin"]:generateLog({
                category = "admin",
               room = "desbanir",
               user_id = user_id,
               target_id = tonumber(target_id),
               message = ( [[O ADMIN %s DESBANIU O ID %s PELO MOTIVO %s]] ):format(user_id, target_id, motivo)
           })

           if discord == nil then
               corpoBan = { 
                   { 
                       ["color"] = config.geral['color'], 
                       ["title"] = "**".. ":no_entry:  | Novo Desbanimento Registrado " .."**\n", 
                       ["thumbnail"] = { ["url"] = config.geral['logo'] },
                       ["description"] = "**Desbanido:**\n```cs\nID: "..target_id.."```\n**Desbanido por: **\n```cs\nID: "..user_id.."```\n**Data do Desbanimento:** ```cs\n "..os.date("%d/%m/%Y as %H:%M").."```\n**Motivo do Desbanimento:** ```cs\n "..motivo.."``` ", 
                       ["footer"] = { ["text"] = config.geral['footer'], }, } 
               }
               vRP.execute("mirtin/removeBanned", { user_id = target_id })
               vRP.execute("mirtin/removeBannedIP", { user_id = target_id })
               vRP.removeBanIp(target_id)

               config.serverLang['unbanned'](source, target_id)

               sendToDiscord(config.geral['whookUnban'], corpoBan)
               return
           end

           corpoBan = { 
               { 
                   ["color"] = config.geral['color'], 
                   ["title"] = "**".. ":no_entry:  | Novo Desbanimento Registrado " .."**\n", 
                   ["thumbnail"] = { ["url"] = config.geral['logo'] },
                   ["description"] = "**Desbanido:**\n```cs\nID: "..target_id.."```\n**Desbanido por: **\n```cs\nID: "..user_id.."``` ``Discord:`` <@"..discord..">\n\n**Data do Desbanimento:** ```cs\n "..os.date("%d/%m/%Y as %H:%M").."```\n**Motivo do Desbanimento:** ```cs\n "..motivo.."``` ", 
                   ["footer"] = { ["text"] = config.geral['footer'], }, } 
           }
           sendToDiscord(config.geral['whookUnban'], corpoBan)

           vRP.execute("mirtin/removeBanned", { user_id = target_id })
           vRP.execute("mirtin/removeBannedIP", { user_id = target_id })
           vRP.removeBanIp(target_id)

           config.serverLang['unbanned'](source, target_id)
       end
   end 
end

getHcheck = function(source, target_id)
    local source = source
    local user_id = vRP.getUserId(source)
    local rows = vRP.query("mirtin/getUserBanned", { user_id = target_id })
    if user_id then
        if #rows == 0 then
            config.serverLang['isNotBanned'](source)
            return
        end

        TriggerClientEvent('chatMessage', source, {
            type = 'staff',
            title = 'SYSTEM',
            message = "ID: "..target_id.."\nBanido por ID: "..rows[1].staff.."\nData do Banimento: "..rows[1].banimento.."\nData do Desbanimento: "..rows[1].desbanimento.."\nMotivo do Banimento: "..rows[1].motivo.."  . "
        })
    end
end

exports('unBanned', function(source, idBan, motivoUnBan)
    setUnBanned(source, idBan, motivoUnBan)
end)

Citizen.CreateThread(function()
    vRP.prepare('mirtin_bans/getBans', 'SELECT * FROM mirtin_bans WHERE TIME > 0 and TIME < UNIX_TIMESTAMP();')
    while true do
        for k, v in pairs(vRP.query('mirtin_bans/getBans')) do
            vRP.execute("mirtin/removeBanned", { user_id = v.user_id })
            vRP.execute("mirtin/removeBannedIP", { user_id = v.user_id })
            vRP.removeBanIp(v.user_id)
        end
        Citizen.Wait(300 * 1000)
    end
end)


function sendToDiscord(weebhook, message)
    PerformHttpRequest(weebhook, function(err, text, headers) end, 'POST', json.encode({embeds = message}), { ['Content-Type'] = 'application/json' })
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CHECAGEM DO JOGADOR BANIDO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local TimeUnit = {
    ['m'] = 60, -- 1 minuto tem 60 segundos
    ['h'] = 3600, -- 1 hora tem 3600 segundos
    ['d'] = 86400 -- 1 dia tem 86400 segundos
}
  
convertTime = function (value)
    if value ~= 0 then
        local unit = value:match('[mhdMHD]'):lower()
        local time = tonumber(value:match('%d+'))
        return (os.time() + (TimeUnit[unit] * time)), os.time() + (TimeUnit[unit] * time)
    end
    return 0
end


-- local defaultMessage = '^6CIDADE ALTA #WIPOU HOJE'
-- CreateThread(function()
--     while true do
--         local dateSuffix = (" %02d-%02d🌈"):format(os.date('%d'), os.date('%m'))
--         local updatedMessage = defaultMessage .. dateSuffix
--         ExecuteCommand("set sv_projectName \"" .. updatedMessage .. "\"")
--         ExecuteCommand("heartbeat")

--         Wait(60 * 1000)
--     end
-- end)
