registrationConfig = {}

registrationConfig.main = {
    weebhookSocial = "", -- WEEBHOOK quando usar o comando /social enviar no discord

    rewards = {
        ['Facebook'] = function(user_id, source)
        end,

        ['Instagram'] = function(user_id, source)
        end,

        ['TikTok'] = function(user_id, source)
            SetTimeout(5000,function() 
                vRP.execute("vRP/inserir_veh",{ veiculo = "nissanskyliner34", user_id = user_id, placa = vRP.gerarPlaca(user_id), ipva = os.time(), expired = "{}" })
                TriggerClientEvent('__title', source, 'PARABÉNS, VOCÊ VEIO PELO TIKTOK E FOI PREMIADO!', 'VOCÊ ACABA DE GANHAR UM SKYLINE.')
            end)
        end,

        ['WhatsApp'] = function(user_id, source)
        end,

        ['Youtube'] = function(user_id, source)
        end,

        ['Amigo(a)'] = function(user_id, source)
        end,
    }
}