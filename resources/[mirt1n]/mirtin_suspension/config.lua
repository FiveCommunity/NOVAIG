-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Config = {
     SuspensionConfig = { -- Configuração dos leveis da suspensão a AR
         command = 'ar', -- Para abrir controle da suspensao a AR
         install_command = 'instalar_suspensao', -- Para instalar a suspensao a AR ( Uso para mecanicos )
 
         permissions = {
             vip_permission = 'perm.suspension', -- Permissao para abrir a suspensao a AR sem precisar ser instalada ( Uso para beneficios VIP )
             install_permission = 'mirtin_suspension.install', -- Permissao para instalar a suspensao a AR ( Uso para mecanicos )
         },
 
         requireItem = { -- Precisa de item para abrir a suspensao a AR
             active = false, -- true se precisa false se não precisa ( Caso tenha permissão de Beneficio não precisa do item )
             item = 'controle_ar', -- spawn do item
         },
 
         itens = {
             ['cylinder'] = { -- Configuração do cilindro
                 value = 150, -- Quantidade maxima de ar no cilindro
             },
 
             ['compressor'] = { -- Configuração do compressor
                 secondsToAir = 2, -- Delay em segundos para carregar o compressor
                 value = 2 -- Quantidade de ar que vai ser carregado por secondsToAir
             },
 
             ['block'] = { -- Configuração do bloco para suspensão subir mais rápido
                 wait = 80, -- Delay em ms que vai subir ou descer a suspensao
                 pressure = 0.0010 -- Quantidade de ar vai injetar por wait
             },
         },
 
         vehicles = { -- Caso queira definir tamanhos padroes por veiculos adicionar aqui.
             default = { -- Padrao Pre definido para todos os veiculos que não tiver configurado na lista abaixo
                 default = 15, -- Valor padrao ja da altura do carro
                 min = 0, -- Minimo de 0 PSI Por Bolsa de Ar
                 max = 17, -- Maximo de 10 PSI Por Bolsa de Ar
             },
 
             list = {	
                -- [`t20`] = {
                --     default = 5, -- Valor padrao ja da altura do carro
                --     min = -5, -- Minimo de 0 PSI Por Bolsa de Ar
                --     max = 15, -- Maximo de 10 PSI Por Bolsa de Ar
                -- },
                --  [`adder`] = {
                --      default = 5, -- Valor padrao ja da altura do carro
                --      min = 0, -- Minimo de 0 PSI Por Bolsa de Ar
                --      max = 15, -- Maximo de 10 PSI Por Bolsa de Ar
                --  },
             }
         }
     }
 }
 
 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 -- LANGS
 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Config.Langs = {
     ['noProximityVehicle'] = function() 
         TriggerEvent('Notify', 'negado', 'Nenhum veículo próximo.') 
     end,
     ['notVehicleOwner'] = function(source) 
         TriggerClientEvent('Notify', source, 'negado', 'Você não é o proprietário desse veículo.') 
     end,
     ['suspensionNotConfigured'] = function(source) 
         TriggerEvent('Notify', 'negado', 'Suspensão a Ar não configurada para esse veículo.') 
     end,
     ['vehicleAlreadyInstalled'] = function(source) 
         TriggerClientEvent('Notify', source, 'negado', 'Veículo já possui a suspensão a AR instalada.') 
     end,
     ['vehicleNotFound'] = function(source) 
         TriggerClientEvent('Notify', source, 'negado', 'Veículo não encontrado.') 
     end,
     ['vehicleNotFoundPlayer'] = function(source) 
         TriggerClientEvent('Notify', source, 'negado', 'Veículo não encontrado na garagem do jogador.') 
     end,
     ['noAirInCylinder'] = function() 
         TriggerEvent('Notify', 'negado', 'Sem ar no cilindro para encher.') 
     end,
     ['maxLimitReached'] = function() 
         TriggerEvent('Notify', 'negado', 'Limite máximo atingido.') 
     end,
     ['minLimitReached'] = function() 
         TriggerEvent('Notify', 'negado', 'Limite mínimo atingido.') 
     end,
     ['notAirInBag'] = function() 
         TriggerEvent('Notify', 'negado', 'Você precisa no minimo de 50 de AR em seu cilindro você fazer isso.') 
     end,
     ['waitThis'] = function() 
         TriggerEvent('Notify', 'negado', 'Aguarde para fazer isso.') 
     end,
     ['exitVehicleToInstall'] = function()
         TriggerEvent('Notify', 'negado', 'Você está em um veiculo, saia dele para instalar a suspensão a AR')
     end,
     ['nearHoodToInstall'] = function()
         TriggerEvent('Notify', 'negado', 'Você precisa estar próximo ao capô do veículo para instalar a suspensão a AR')
     end,
     ['installingSuspension'] = function()
         TriggerEvent('Notify', 'sucesso', 'Instalando Suspension a AR...')
     end,
     ['waitToExecute'] = function()
         TriggerEvent('Notify', 'negado', 'Aguarde para executar')
     end,
     ['notOwnerOrNotInstalled'] = function()
         TriggerEvent('Notify', 'negado', 'Você não é o proprietário desse veículo ou não possui a suspensão a AR instalada.')
     end
 }
 
 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 -- FUNCTIONS
 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 if SERVER then
     function getUserId(source)
         return vRP.getUserId(source)
     end
 
     function getUserByRegistration(plate) 
         return vRP.getUserByRegistration(plate) or false
     end
 
     function hasPermission(user_id, permission)
         return vRP.hasPermission(user_id, permission)
     end
 
     function getUData(user_id, key)
         return json.decode(vRP.getUData(user_id, key)) or {}
     end
 
     function setUData(user_id, key, value)
         vRP.setUData(user_id, key, json.encode(value))
     end
 
     function getSData(key)
         return json.decode(vRP.getSData(key)) or {}
     end
 
     function setSData(key, value)
         vRP.setSData(key, json.encode(value))
     end
 
     function getInventoryItemAmount(user_id, item)
         return vRP.getInventoryItemAmount(user_id, item)
     end
 
     function getVehicleName(model, modelName)
         -- model = hash 
         -- modelname = vehName ( adder, t20 e etc ) alguns veiculos addons não funciona
         -- caso queira usar o nome do veiculo, fazer o filtro utilizando model na sua lista de veiculo
 
         return tostring(model)
     end
 else
     function playAnim(dict, anim)
         local anim = { dict, anim }
         vRP.playAnim(false, { anim }, true)
     end
 end