local blips = {}
local func = exports["vrp"]

local OthersDrugs = function(user_id, source, item, slot, cb)
    if vRP.hasPermission(user_id, 'perm.kids') then
        TriggerClientEvent("Notify", source, "negado", "Você não pode usar droga..", 5)
        return cb(false)
    end
    if not Remote.isInDrug(source) then
        if GetEntityHealth(GetPlayerPed(source)) > 101 then
            if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                vRPc._playAnim(source, true, { { "mp_player_int_uppersmoke", "mp_player_int_smoke" } }, true)

                if item == "balinha" then
                    Remote._useBandagem(source, true, 'Balinha')
                end

                SetTimeout(2000,
                    function()
                        vRPc._stopAnim(source, false)
                        TriggerClientEvent("inventory:useDrugs", source, item)
                    end)
                return cb(true)
            end
        end
    end
    return cb(false)
end

local Beber = function(user_id, source, item, slot, cb)
    TriggerClientEvent("progress", source, 5)
    play_drink(source, item, 5)
    SetTimeout(5000, function()
        if item == "water" then
            vRP.giveInventoryItem(user_id, "emptybottle", amount, true)
        end
    end)
    return cb(true)
end
local Remedio = function(user_id, source, item, slot, cb)
end

local Beber_Alcoolico = function(user_id, source, item, slot, cb)
    func:setCooldown(user_id, "inventario", 10)

    TriggerClientEvent("progress", source, 10, "Bebendo")
    play_drink(source, item, 10)

    SetTimeout(15 * 1000, function()
        vRPc._playScreenEffect(source, "RaceTurbo", 60)
        vRPc._playScreenEffect(source, "DrugsTrevorClownsFight", 60)
        Remote._SetAnim(source, amount)
    end)
end
function play_drink(source, tipo, segundos)
    local prop = ""
    -- BEBIDAS
    if tipo == "energetico" then
        prop = "prop_energy_drink"
    elseif tipo == "water" then
        prop = "prop_ld_flow_bottle"
    elseif tipo == "cafe" then
        prop = "prop_fib_coffee"
    elseif tipo == "cocacola" then
        prop = "ng_proc_sodacan_01a"
    elseif tipo == "sucol" then
        prop = "ng_proc_sodacan_01b"
    elseif tipo == "sucol2" then
        prop = "ng_proc_sodacan_01b"
    elseif tipo == "sprunk" then
        prop = "ng_proc_sodacan_01b"

        -- BEBIDAS ALCOLICAS
    elseif tipo == "cerveja" then
        prop = "prop_amb_beer_bottle"
    elseif tipo == "whisky" then
        prop = "prop_drink_whisky"
    elseif tipo == "vodka" then
        prop = "p_whiskey_notop"
    elseif tipo == "pinga" then
        prop = "p_whiskey_notop"
    elseif tipo == "corote" then
        prop = "ng_proc_sodacan_01b"
    elseif tipo == "absinto" then
        prop = "prop_drink_whisky"
    elseif tipo == "skolb" then
        prop = "ng_proc_sodacan_01b"
    else
        prop = "prop_ld_flow_bottle"
    end

    vRPc._CarregarObjeto(source, "amb@world_human_drinking@beer@male@idle_a", "idle_a", prop, 49, 28422)
    SetTimeout(segundos * 1000, function() vRPc._DeletarObjeto(source) end)
end

function play_eat(source, tipo, segundos)
    local prop = ""
    -- COMIDAS
    if tipo == "pao" then
        prop = "prop_food_burg2"
    elseif tipo == "sanduiche" then
        prop = "prop_cs_burger_01"
    elseif tipo == "pizza" then
        prop = "prop_taco_01"
    elseif tipo == "barrac" then
        prop = "prop_choc_meto"
    elseif tipo == "cachorroq" then
        prop = "prop_cs_hotdog_01"
    elseif tipo == "pipoca" then
        prop = "ng_proc_food_chips01b"
    elseif tipo == "donut" then
        prop = "prop_amb_donut"
    elseif tipo == "paoq" then
        prop = "prop_food_cb_nugets"
    elseif tipo == "marmita" then
        prop = "prop_taco_01"
    elseif tipo == "coxinha" then
        prop = "prop_food_cb_nugets"
    else
        prop = "prop_cs_burger_01"
    end

    vRPc._CarregarObjeto(source, "amb@code_human_wander_eating_donut@male@idle_a", "idle_c", prop, 49, 28422)
    SetTimeout(segundos * 1000, function() vRPc._DeletarObjeto(source) end)
end

Items = {
    ["weapon_hammer"] = {
        index = "weapon_hammer",
        name = "Hammer",
        png = "weapon_hammer",
        weight = 3.0,
        type = "equip"
    },
    ["fueltech"] = {
        index = "fueltech",
        name = "FuelTech",
        png = "fueltech",
        weight = 0.1,
        type = "use"
    },

    ["pacote_componentes"] = {
        index = "pacote_componentes",
        name = "Pacote de Componentes",
        png = "pacote_componentes",
        weight = 5.0,
        type = "use"
    },

    ["plastico"] = {
        index = "plastico",
        name = "Plástico",
        png = "plastico",
        weight = 1.0,
        type = "use"
    },

    ["weapon_pistol_mk2"] = {
        index = "weapon_pistol_mk2",
        name = "Five-Seven",
        png = "weapon_pistol_mk2",
        weight = 3.0,
        type = "equip"
    },

    ["weapon_stungun"] = {
        index = "weapon_stungun",
        name = "Tazer",
        png = "weapon_stungun",
        weight = 1.0,
        type = "equip"
    },

    ["pacu"] = {
        index = "pacu",
        name = "Pacu",
        png = "pacu",
        weight = 1.5,
        type = "use"
    },

    ["ammo_revolver_mk2"] = {
        index = "ammo_revolver_mk2",
        name = "M-Revolver",
        png = "ammo_revolver_mk2",
        weight = 0.05,
        type = "recharge"
    },

    ["apreensao"] = {
        index = "apreensao",
        name = "Apreensao",
        png = "apreensao",
        weight = 0.2,
        type = "use"
    },
    ["ammo_microsmg"] = {
        index = "ammo_microsmg",
        name = "M-MICROSMG",
        png = "ammo_microsmg",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_flashlight"] = {
        index = "weapon_flashlight",
        name = "Lanterna",
        png = "weapon_flashlight",
        weight = 3.0,
        type = "equip"
    },

    ["m-aco"] = {
        index = "m-aco",
        name = "Aço",
        png = "m-aco",
        weight = 0.3,
        type = "use"
    },

    ["dipirona"] = {
        index = "dipirona",
        name = "Dipirona",
        png = "dipirona",
        weight = 0.05,
        type = "use"
    },

    ["opiopapoula"] = {
        index = "opiopapoula",
        name = "Pó de Opio",
        png = "opiopapoula",
        weight = 0.3,
        type = "use"
    },

    ["weapon_machinepistol"] = {
        index = "weapon_machinepistol",
        name = "Tec-9",
        png = "weapon_machinepistol",
        weight = 6.0,
        type = "equip"
    },

    ["ticket"] = {
        index = "ticket",
        name = "Ticket Corrida",
        png = "ticket",
        weight = 1.0,
        type = "use"
    },

    ["weapon_hatchet"] = {
        index = "weapon_hatchet",
        name = "Machados",
        png = "weapon_hatchet",
        weight = 3.0,
        type = "equip"
    },
    ["ammo_petrolcan"] = {
        index = "ammo_petrolcan",
        name = "Gasolina",
        png = "ammo_petrolcan",
        weight = 0.05,
        type = "recharge"
    },

    ["m-corpo_shotgun"] = {
        index = "m-corpo_shotgun",
        name = "Corpo de Shotgun",
        png = "m-corpo_shotgun",
        weight = 5.0,
        type = "use"
    },

    ["masterpick"] = {
        index = "masterpick",
        name = "MasterPick",
        png = "masterpick",
        weight = 1.0,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            local hasPermission = false
            for group in pairs(vRP.getUserGroups(user_id)) do
                if group:find('Gerente') or group:find('Lider') or group:find('Sub-Lider') then
                    hasPermission = true
                    break
                end
            end

            if vRP.hasPermission(user_id, 'admin.permissao') then
                hasPermission = true
            end

            if not hasPermission then
                TriggerClientEvent("Notify", source, "negado", "Você não tem permissão para usar este item.", 5)
                return cb(false)
            end

            local plate, mName, mNet, mPortaMalas, mPrice, mLock, mModel = vRPc.ModelName(source, 7)
            local plateUser = vRP.getUserByRegistration(plate)
            if not plate then
                TriggerClientEvent("Notify", source, "negado", "Você não perto de um veículo.", 5)
                return cb(false)
            end
            
            if vRP.tryGetInventoryItem(user_id, "masterpick", 1, true, slot) then
                Remote._closeInventory(source)
                Wait(1000)
                Remote._startAnimHotwired(source)
                local finished = vRPc.taskBar(source)
                if finished then
                    local entity = NetworkGetEntityFromNetworkId(mNet)
                    if entity then
                        SetVehicleDoorsLocked(entity, 1)
                        setBypassVehicle(user_id, mNet)
                        TriggerClientEvent('Notify', source, 'sucesso', 'Veiculo <b>destrancado</b> com sucesso.')
                        TriggerClientEvent("vrp_sound:source", source, "lock", 0.1)
                        local plyCoords = GetEntityCoords(GetPlayerPed(source))
                        exports["vrp_admin"]:generateLog({
                            category = "inventario",
                            room = "lockpick",
                            user_id = user_id,
                            message = ([[O USER_ID %s UTILIZOU MASTERPICK NO VEICULO %s NAS COORDENAS %s]]):format(user_id, (mName or 'Desconhecido'), vec3(plyCoords.x, plyCoords.y, plyCoords.z))
                        })
                    end

                end
                vRPc._stopAnim(source, false)
            end
        end,
    },

    ["valemansao1m"] = {
        index = "valemansao1m",
        name = "Vale mansao 1m",
        png = "valemansao1m",
        weight = 0.0,
        type = "use"
    },

    ["ammo_combatpdw"] = {
        index = "ammo_combatpdw",
        name = "M-Pdw",
        png = "ammo_combatpdw",
        weight = 0.05,
        type = "recharge"
    },

    ["ammo_sawnoffshotgun"] = {
        index = "ammo_sawnoffshotgun",
        name = "M-Shotgun",
        png = "ammo_sawnoffshotgun",
        weight = 0.05,
        type = "recharge"
    },

    ["safira"] = {
        index = "safira",
        name = "Safira",
        png = "safira",
        weight = 1.0,
        type = "use"
    },

    ["ammo_snowball"] = {
        index = "ammo_snowball",
        name = "M-Bola",
        png = "ammo_snowball",
        weight = 0.05,
        type = "recharge"
    },

    ["molas"] = {
        index = "molas",
        name = "Molas",
        png = "molas",
        weight = 0.15,
        type = "use"
    },

    ["weapon_carbinerifle"] = {
        index = "weapon_carbinerifle",
        name = "M4",
        png = "weapon_carbinerifle",
        weight = 8.0,
        type = "equip"
    },

    ["weapon_assaultsmg"] = {
        index = "weapon_assaultsmg",
        name = "MTAR",
        png = "weapon_assaultsmg",
        weight = 6.0,
        type = "equip"
    },

    ["zincocobre"] = {
        index = "zincocobre",
        name = "Zinco e Cobre",
        png = "zincocobre",
        weight = 0.01,
        type = "use"
    },

    ["l-alvejante"] = {
        index = "l-alvejante",
        name = "Alvejante",
        png = "l-alvejante",
        weight = 0.2,
        type = "use"
    },

    ["body_armor"] = {
        index = "body_armor",
        name = "Colete",
        png = "body_armor",
        weight = 1.0,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            local status, time = func:getCooldown(user_id, "usecolete")
            if status then
                if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                    func:setCooldown(user_id, "usecolete", 30)
                    TriggerClientEvent("progress", source, 10)
                    exports["vrp"]:setBlockCommand(user_id, 15)
                    vRPc.playAnim(source, true, { { "clothingtie", "try_tie_negative_a" } }, true)
                    SetTimeout(15000, function()
                        Remote._closeInventory(source)
                        vRPc._stopAnim(source, false)
                        vRPc.setArmour(source, 100)
                        vRPc._DeletarObjeto(source)
                        TriggerClientEvent("Notify", source, "sucesso", "Colete utilizado com sucesso!")
                    end)
                    return cb(true)
                end
            else
                TriggerClientEvent("Notify", source, "negado", "Aguarde " .. time .. " segundos para usar outro colete.",
                    8000)
                return cb(false)
            end
        end
    },

    ["ammo_heavysniper"] = {
        index = "ammo_heavysniper",
        name = "M-SNIPER",
        png = "ammo_heavysniper",
        weight = 0.05,
        type = "recharge"
    },

    ["algemas"] = {
        index = "algemas",
        name = "Algemas",
        png = "algemas",
        weight = 2.0,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            local nplayer = vRPc.getNearestPlayer(source, 3)
            if nplayer then
                if not Remote.checkAnim(nplayer) then
                    TriggerClientEvent("Notify", source, "importante", "O jogador não está rendido.", 5)
                    return
                end

                if not vRPc.isHandcuffed(nplayer) then
                    if vRP.tryGetInventoryItem(user_id, "algemas", 1, true, slot) then
                        vRP.giveInventoryItem(user_id, "chave_algemas", 1, true)
                        vRPc._playAnim(source, false, { { "mp_arrest_paired", "cop_p2_back_left" } }, false)
                        vRPc._playAnim(nplayer, false, { { "mp_arrest_paired", "crook_p2_back_left" } }, false)
                        SetTimeout(3500, function()
                            vRPc._stopAnim(source, false)
                            vRPc._toggleHandcuff(nplayer)
                            TriggerClientEvent("vrp_sound:source", source, "cuff", 0.1)
                            TriggerClientEvent("vrp_sound:source", nplayer, "cuff", 0.1)
                            vRPc._setHandcuffed(nplayer, true)
                        end)
                        return cb(true)
                    else
                        TriggerClientEvent("Notify", source, "negado", "Você não possui algemas.", 5)
                    end
                end
            else
                TriggerClientEvent("Notify", source, "negado", "Nenhum jogador proximo.", 5)
            end
            return cb(false)
        end
    },

    ["notebook"] = {
        index = "notebook",
        name = "Notebook",
        png = "notebook",
        weight = 0.1,
        type = "use"
    },

    ["garrafanitro"] = {
        index = "garrafanitro",
        name = "Garrafa de Nitro",
        png = "garrafanitro",
        weight = 1.0,
        type = "use",
        func = function(user_id, source, item, slot, cb)
            TriggerClientEvent("recharge_nitro", source)
        end
    },

    ["carnedepuma"] = {
        index = "carnedepuma",
        name = "Carne de Puma",
        png = "carnedepuma",
        weight = 3.0,
        type = "use"
    },

    ["furadeira"] = {
        index = "furadeira",
        name = "Furadeira",
        png = "furadeira",
        weight = 3.0,
        type = "use"
    },

    ["heroina"] = {
        index = "heroina",
        name = "Heroina",
        png = "heroina",
        weight = 0.5,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            if vRP.hasPermission(user_id, 'perm.kids') then
                TriggerClientEvent("Notify", source, "negado", "Você não pode usar droga..", 5)
                return cb(false)
            end
            if not Remote.isInDrug(source) then
                local plyCoords = GetEntityCoords(GetPlayerPed(source))
                local distance = #(plyCoords - vec3(1298.92, 4370.97, 42.48))
                local distance2 = #(plyCoords - vec3(-69.3, 365.49, 112.42))
                if (distance < 4 or distance2 < 4) then
                    local nplayer = vRPc.getNearestPlayer(source, 5)
                    if not nplayer then
                        TriggerClientEvent("Notify", source, "negado", "Nenhum jogador proximo.", 5)
                        return cb(false)
                    end
                    if (GetEntityHealth(GetPlayerPed(nplayer)) > 105) then
                        TriggerClientEvent("Notify", source, "negado", "Este jogador não esta em coma.", 3)
                        return cb(false)
                    end
                    local nuser_id = vRP.getUserId(nplayer)

                    if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                        exports["vrp"]:setBlockCommand(user_id, 13)
                        TriggerClientEvent("Notify", source, "sucesso",
                            "O Cidadão está com <b>pulsação</b>, realizando aplicação de droga.", 5)
                        SetTimeout(3 * 1000, function()
                            vRPc._playAnim(source, false, { { "mini@cpr@char_a@cpr_def", "cpr_intro" } }, true)
                            SetTimeout(10 * 1000, function()
                                vRPc._stopAnim(source, false)
                                vRPc._setHealth(nplayer, 110)
                            end)
                        end)

                        SetTimeout(2000,
                            function()
                                vRPc._stopAnim(source, false)
                                TriggerClientEvent("inventory:useDrugs", source, item)
                            end)
                        return cb(true)
                    end
                else
                    TriggerClientEvent("Notify", source, "negado", "Você não pode usar heroina nesta área.", 5)
                end
            end
            return cb(false)
        end
    },

    ["apple_watch"] = {
        index = "apple_watch",
        name = "Apple Watch",
        png = "apple_watch",
        weight = 0.5,
        type = "use"
    },

    ["vodka"] = {
        index = "vodka",
        name = "Vodka",
        png = "vodka",
        weight = 1.0,
        type = "use",
        func = Beber_Alcoolico
    },

    ["clozapina"] = {
        index = "clozapina",
        name = "Clozapina",
        png = "clozapina",
        weight = 0.05,
        type = "use"
    },

    ["repairkit2"] = {
        index = "repairkit2",
        name = "Jogue Fora",
        png = "repairkit2",
        weight = 1.0,
        type = "use"
    },

    ["ammo_combatpistol"] = {
        index = "ammo_combatpistol",
        name = "M-Glock",
        png = "ammo_combatpistol",
        weight = 0.05,
        type = "recharge"
    },

    ["alterarrg"] = {
        index = "alterarrg",
        name = "Alterar RG",
        png = "alterarrg",
        weight = 0.0,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            Remote._closeInventory(source)
            Wait(500)
            local numero = vRP.prompt(source, "Digite o numero: (MAX 6) (EXEMPLO: ABC123)", "")
            if numero ~= nil and numero ~= "" and numero and string.len(numero) == 6 then
                if checkRG(numero) then
                    if vRP.request(source, "Tem certeza que deseja alterar seu rg para <b>" .. numero .. "</b> ?", 30) then
                        if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                            vRP.updateIdentity(user_id)
                            vRP.execute("vRP/update_registro", { user_id = user_id, registro = numero })
                            TriggerClientEvent("Notify", source, "sucesso",
                                "Você trocou o seu rg para <b>" ..
                                numero .. "</b>, aguarde a cidade reiniciar para alteração ser feita.", 15)
                        end
                    end
                    return cb(true)
                else
                    TriggerClientEvent("Notify", source, "negado", "Este rg ja existe.", 5)
                end
            else
                TriggerClientEvent("Notify", source, "negado", "Digite o rg correto. (EXEMPLO: ABC123)", 5)
            end
            return cb(false)
        end
    },

    ["acidolsd"] = {
        index = "acidolsd",
        name = "Acido LSD",
        png = "acidolsd",
        weight = 0.3,
        type = "use",

    },

    ["anfetamina"] = {
        index = "anfetamina",
        name = "Anfetamina",
        png = "anfetamina",
        weight = 0.3,
        type = "use"
    },

    ["valemansao100m"] = {
        index = "valemansao100m",
        name = "Vale mansao 100m",
        png = "valemansao100m",
        weight = 0.0,
        type = "use"
    },

    ["goiaba"] = {
        index = "goiaba",
        name = "Goiaba",
        png = "goiaba",
        weight = 1.0,
        type = "use"
    },

    ["pendrive"] = {
        index = "pendrive",
        name = "Pendrive",
        png = "pendrive",
        weight = 1.0,
        type = "use"
    },

    ["weapon_machete"] = {
        index = "weapon_machete",
        name = "Machete",
        png = "weapon_machete",
        weight = 3.0,
        type = "equip"
    },

    ["respingodesolda"] = {
        index = "respingodesolda",
        name = "Respingo de Solda",
        png = "respingodesolda",
        weight = 0.3,
        type = "use"
    },

    ["relogioroubado"] = {
        index = "relogioroubado",
        name = "Relogio",
        png = "relogioroubado",
        weight = 0.5,
        type = "use"
    },

    ["ammo_bzgas"] = {
        index = "ammo_bzgas",
        name = "M-Gas",
        png = "ammo_bzgas",
        weight = 0.05,
        type = "recharge"
    },

    ["carta"] = {
        index = "carta",
        name = "carta",
        png = "carta",
        weight = 0.1,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            local query = exports["oxmysql"]:executeSync("SELECT * FROM lotus_cards WHERE receiverid = ? LIMIT 1",
                { user_id })
            if #query >= 1 then
                if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                    Remote._closeInventory(source)
                    TriggerClientEvent('lotus_cards:sendCard', source, query)
                    exports["oxmysql"]:executeSync("DELETE FROM lotus_cards WHERE id = ?", { query[1].id })
                    return cb(true)
                end
            end
            return cb(false)
        end
    },

    ["cachorroq"] = {
        index = "cachorroq",
        name = "Cachorro Quente",
        png = "cachorroq",
        weight = 0.5,
        type = "use"
    },

    ["ammo_specialcarbine_mk2"] = {
        index = "ammo_specialcarbine_mk2",
        name = "M-G3",
        png = "ammo_specialcarbine_mk2",
        weight = 0.05,
        type = "recharge"
    },

    ["ammo_tacticalrifle"] = {
        index = "ammo_tacticalrifle",
        name = "M-Rifle Tatico",
        png = "ammo_tacticalrifle",
        weight = 0.05,
        type = "recharge"
    },

    ["ammo_bullpuprifle"] = {
        index = "ammo_bullpuprifle",
        name = "M-Rifle BullUp",
        png = "ammo_bullpuprifle",
        weight = 0.05,
        type = "recharge"
    },

    ["cocaina"] = {
        index = "cocaina",
        name = "Cocaina",
        png = "cocaina",
        weight = 0.5,
        type = "use",
        keep_item = true,
        func = OthersDrugs
    },

    ["folhamaconha"] = {
        index = "folhamaconha",
        name = "Folha de Maconha",
        png = "folhamaconha",
        weight = 0.3,
        type = "use"
    },

    ["donut"] = {
        index = "donut",
        name = "Donut",
        png = "donut",
        weight = 0.2,
        type = "use"
    },

    ["sucol2"] = {
        index = "sucol2",
        name = "Suco de Limao",
        png = "sucol2",
        weight = 0.5,
        type = "use",
        func = Beber
    },

    ["papel"] = {
        index = "papel",
        name = "Papel",
        png = "papel",
        weight = 0.05,
        type = "use"
    },

    ["c-ferro"] = {
        index = "c-ferro",
        name = "Ferro",
        png = "c-ferro",
        weight = 0.01,
        type = "use"
    },

    ["desbloqueadorsinal"] = {
        index = "desbloqueadorsinal",
        name = "Desbloqueador de Sinal",
        png = "desbloqueadorsinal",
        weight = 0.01,
        type = "use"
    },
    ["grampoprison"] = {
        index = "grampoprison",
        name = "Grampo",
        png = "grampoprison",
        weight = 0.01,
        type = "use"
    },
    ["moldeprison"] = {
        index = "moldeprison",
        name = "Molde",
        png = "moldeprison",
        weight = 0.01,
        type = "use"
    },
    ["copoprison"] = {
        index = "copoprison",
        name = "Copo",
        png = "copoprison",
        weight = 0.01,
        type = "use"
    },
    ["ferroprison"] = {
        index = "ferroprison",
        name = "Ferro",
        png = "ferroprison",
        weight = 0.01,
        type = "use"
    },
    ["cobreprison"] = {
        index = "cobreprison",
        name = "Cobre",
        png = "cobreprison",
        weight = 0.01,
        type = "use"
    },
    ["pedraprison"] = {
        index = "pedraprison",
        name = "Pedra",
        png = "pedraprison",
        weight = 0.01,
        type = "use"
    },
    ["papelprison"] = {
        index = "papelprison",
        name = "Papel",
        png = "papelprison",
        weight = 0.01,
        type = "use"
    },
    ["maconhaprison"] = {
        index = "maconhaprison",
        name = "Maconha",
        png = "maconhaprison",
        weight = 0.01,
        type = "use"
    },
    ["crackprison"] = {
        index = "crackprison",
        name = "Crack",
        png = "crackprison",
        weight = 0.01,
        type = "use"
    },
    ["plasticoprison"] = {
        index = "plasticoprison",
        name = "Plástico",
        png = "plasticoprison",
        weight = 0.01,
        type = "use"
    },
    ["garrafaquebradaprison"] = {
        index = "garrafaquebradaprison",
        name = "Garrafa Quebrada",
        png = "garrafaquebradaprison",
        weight = 0.01,
        type = "use"
    },
    ["pedacoarameprison"] = {
        index = "pedacoarameprison",
        name = "Pedaço de Arame",
        png = "pedacoarameprison",
        weight = 0.01,
        type = "use"
    },
    ["tijoloprison"] = {
        index = "tijoloprison",
        name = "Tijolo",
        png = "tijoloprison",
        weight = 0.01,
        type = "use"
    },
    ["dedodecepadoprison"] = {
        index = "dedodecepadoprison",
        name = "Dedo Decepado",
        png = "dedodecepadoprison",
        weight = 0.01,
        type = "use"
    },    

    ["fibradecarbono"] = {
        index = "fibradecarbono",
        name = "Fibra de Carbono",
        png = "fibradecarbono",
        weight = 0.05,
        type = "use"
    },

    ["maracuja"] = {
        index = "maracuja",
        name = "Maracujá",
        png = "maracuja",
        weight = 1.0,
        type = "use"
    },

    ["pacote_eletrico"] = {
        index = "pacote_eletrico",
        name = "Pacote Eletrico",
        png = "pacote_eletrico",
        weight = 3.0,
        type = "use"
    },

    ["ammo_barret"] = {
        index = "ammo_barret",
        name = "M-Barret",
        png = "ammo_barret",
        weight = 0.05,
        type = "recharge"
    },

    ["ouro"] = {
        index = "ouro",
        name = "Ouro",
        png = "ouro",
        weight = 1.0,
        type = "use"
    },

    ["alterarplaca"] = {
        index = "alterarplaca",
        name = "Alterar Placa",
        png = "alterarplaca",
        weight = 0.0,
        type = "use"
    },

    ["corda"] = {
        index = "corda",
        name = "Corda",
        png = "corda",
        weight = 1.0,
        type = "use",
    },

    ["m-capa_colete"] = {
        index = "m-capa_colete",
        name = "Capa Colete",
        png = "m-capa_colete",
        weight = 0.5,
        type = "use"
    },

    ["suspension"] = {
        index = "suspension",
        name = "Item de Tuning",
        png = "suspension",
        weight = 0.1,
        type = "use"
    },

    ["cicatricure"] = {
        index = "cicatricure",
        name = "Cicatricure",
        png = "cicatricure",
        weight = 0.05,
        type = "use"
    },

    ["weapon_specialcarbine_mk2"] = {
        index = "weapon_specialcarbine_mk2",
        name = "G3 MK2",
        png = "weapon_specialcarbine_mk2",
        weight = 8.0,
        type = "equip"
    },

    ["weapon_tacticalrifle"] = {
        index = "weapon_tacticalrifle",
        name = "Rifle Tatico",
        png = "weapon_tacticalrifle",
        weight = 8.0,
        type = "equip"
    },
    ["weapon_bullpuprifle "] = {
        index = "weapon_bullpuprifle ",
        name = "Rifle BullUp",
        png = "weapon_bullpuprifle ",
        weight = 8.0,
        type = "equip"
    },
    ["weapon_heavyrifle"] = {
        index = "weapon_heavyrifle",
        name = "Heavy Rifle",
        png = "weapon_heavyrifle",
        weight = 8.0,
        type = "equip"
    },

    ["weapon_akpentede90_relikiashop"] = {
        index = "weapon_akpentede90_relikiashop",
        name = "AK PENTE 90",
        png = "weapon_akpentede90_relikiashop",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_akpentedE90_relikiashop"] = {
        index = "ammo_akpentedE90_relikiashop",
        name = "M-AK PENTE 90",
        png = "ammo_akpentedE90_relikiashop",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_akdeferro_relikiashop"] = {
        index = "weapon_akdeferro_relikiashop",
        name = "AK DE FERRO",
        png = "weapon_akdeferro_relikiashop",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_akdeferro_relikiashop"] = {
        index = "ammo_akdeferro_relikiashop",
        name = "M-AK DE FERRO",
        png = "ammo_akdeferro_relikiashop",
        weight = 0.05,
        type = "recharge"
    },


    ["weapon_akcromo"] = {
        index = "weapon_akcromo",
        name = "AK CROMO",
        png = "weapon_akcromo",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_akcromo"] = {
        index = "ammo_akcromo",
        name = "M-AK CROMO",
        png = "ammo_akcromo",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_arrelikiashopfeminino1"] = {
        index = "weapon_arrelikiashopfeminino1",
        name = "AR FEMININO 1",
        png = "weapon_arrelikiashopfeminino1",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_arrelikiashopfeminino1"] = {
        index = "ammo_arrelikiashopfeminino1",
        name = "M-AR FEMININO 1",
        png = "ammo_arrelikiashopfeminino1",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_arrelikiashopfeminino2"] = {
        index = "weapon_arrelikiashopfeminino2",
        name = "AR FEMININO 2",
        png = "weapon_arrelikiashopfeminino2",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_arrelikiashopfeminino2"] = {
        index = "ammo_arrelikiashopfeminino2",
        name = "M-AR FEMININO 2",
        png = "ammo_arrelikiashopfeminino2",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_arvasco"] = {
        index = "weapon_arvasco",
        name = "AR VASCO",
        png = "weapon_arvasco",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_arvasco"] = {
        index = "ammo_arvasco",
        name = "M-AR VASCO",
        png = "ammo_arvasco",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_cheytac"] = {
        index = "weapon_cheytac",
        name = "CHEYTAC",
        png = "weapon_cheytac",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_cheytac"] = {
        index = "ammo_cheytac",
        name = "M-CHEYTAC",
        png = "ammo_cheytac",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_g3relikiashopfeminino"] = {
        index = "weapon_g3relikiashopfeminino",
        name = "G3 FEMININO",
        png = "weapon_g3relikiashopfeminino",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_g3relikiashopfeminino"] = {
        index = "ammo_g3relikiashopfeminino",
        name = "M-G3 FEMININO",
        png = "ammo_g3relikiashopfeminino",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_glockrajada"] = {
        index = "weapon_glockrajada",
        name = "GLOCK RAJADA",
        png = "weapon_glockrajada",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_glockrajada"] = {
        index = "ammo_glockrajada",
        name = "M-GLOCK RAJADA",
        png = "ammo_glockrajada",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_glockrelikiashopfeminino0"] = {
        index = "weapon_glockrelikiashopfeminino0",
        name = "GLOCK FEMININO 0",
        png = "weapon_glockrelikiashopfeminino0",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_glockrelikiashopfeminino0"] = {
        index = "ammo_glockrelikiashopfeminino0",
        name = "M-GLOCK FEMININO 0",
        png = "ammo_glockrelikiashopfeminino0",
        weight = 0.05,
        type = "recharge"
    },



    ["weapon_ak472"] = {
        index = "weapon_ak472",
        name = "AK 472",
        png = "weapon_ak472",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_ak472"] = {
        index = "ammo_ak472",
        name = "M-AK 472",
        png = "ammo_ak472",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_ar10preto_relikiashop"] = {
        index = "weapon_ar10preto_relikiashop",
        name = "AR 10 PRETO",
        png = "weapon_ar10preto_relikiashop",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_ar10preto_relikiashop"] = {
        index = "ammo_ar10preto_relikiashop",
        name = "M-AR 10 PRETO",
        png = "ammo_ar10preto_relikiashop",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_ar15bege_relikiashop"] = {
        index = "weapon_ar15bege_relikiashop",
        name = "AR 15 BEGE",
        png = "weapon_ar15bege_relikiashop",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_ar15bege_relikiashop"] = {
        index = "ammo_ar15bege_relikiashop",
        name = "M-AR 15 BEGE",
        png = "ammo_ar15bege_relikiashop",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_arpenteacrilico_relikiashop"] = {
        index = "weapon_arpenteacrilico_relikiashop",
        name = "AR PENTE ACRILICO",
        png = "weapon_arpenteacrilico_relikiashop",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_arpenteacrilico_relikiashop"] = {
        index = "ammo_arpenteacrilico_relikiashop",
        name = "M-AR PENTE ACRILICO",
        png = "ammo_arpenteacrilico_relikiashop",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_ardeluneta_relikiashop"] = {
        index = "weapon_ardeluneta_relikiashop",
        name = "AR DE LUNETA",
        png = "weapon_ardeluneta_relikiashop",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_ardeluneta_relikiashop"] = {
        index = "ammo_ardeluneta_relikiashop",
        name = "M-AR DE LUNETA",
        png = "ammo_ardeluneta_relikiashop",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_arlunetaprata"] = {
        index = "weapon_arlunetaprata",
        name = "AR LUNETA PRATA",
        png = "weapon_arlunetaprata",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_arlunetaprata"] = {
        index = "ammo_arlunetaprata",
        name = "M-AR LUNETA PRATA",
        png = "ammo_arlunetaprata",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_artambor"] = {
        index = "weapon_artambor",
        name = "AR TAMBOR",
        png = "weapon_artambor",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_artambor"] = {
        index = "ammo_artambor",
        name = "M-AR TAMBOR",
        png = "ammo_artambor",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_g3luneta_relikiashop"] = {
        index = "weapon_g3luneta_relikiashop",
        name = "G3 LUNETA",
        png = "weapon_g3luneta_relikiashop",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_g3luneta_relikiashop"] = {
        index = "ammo_g3luneta_relikiashop",
        name = "M-G3 LUNETA",
        png = "ammo_g3luneta_relikiashop",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_glockderoupa_relikiashop"] = {
        index = "weapon_glockderoupa_relikiashop",
        name = "GLOCK DE ROUPA",
        png = "weapon_glockderoupa_relikiashop",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_glockderoupa_relikiashop"] = {
        index = "ammo_glockderoupa_relikiashop",
        name = "M-GLOCK DE ROUPA",
        png = "ammo_glockderoupa_relikiashop",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_hkg3a3"] = {
        index = "weapon_hkg3a3",
        name = "HK G3A3",
        png = "weapon_hkg3a3",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_hkg3a3"] = {
        index = "ammo_hkg3a3",
        name = "M-HK G3A3",
        png = "ammo_hkg3a3",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_hk_relikiashop"] = {
        index = "weapon_hk_relikiashop",
        name = "HK",
        png = "weapon_hk_relikiashop",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_hk_relikiashop"] = {
        index = "ammo_hk_relikiashop",
        name = "M-HK",
        png = "ammo_hk_relikiashop",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_penteduplo1"] = {
        index = "weapon_penteduplo1",
        name = "PENTE DUPLO",
        png = "weapon_penteduplo1",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_penteduplo1"] = {
        index = "ammo_penteduplo1",
        name = "M-PENTE DUPLO",
        png = "ammo_penteduplo1",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_50_relikiashop"] = {
        index = "weapon_50_relikiashop",
        name = ".50",
        png = "weapon_50_relikiashop",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_50_relikiashop"] = {
        index = "ammo_50_relikiashop",
        name = "M-.50",
        png = "ammo_50_relikiashop",
        weight = 0.05,
        type = "recharge"
    },

    ["marmita"] = {
        index = "marmita",
        name = "Marmitex",
        png = "marmita",
        weight = 2.0,
        type = "use"
    },

    ["poliester"] = {
        index = "poliester",
        name = "Poliester",
        png = "poliester",
        weight = 0.05,
        type = "use"
    },

    ["m-corpo_snspistol_mk2"] = {
        index = "m-corpo_snspistol_mk2",
        name = "Corpo de Fajuta",
        png = "m-corpo_snspistol_mk2",
        weight = 1.0,
        type = "use"
    },

    ["weapon_wrench"] = {
        index = "weapon_wrench",
        name = "Wrench",
        png = "weapon_wrench",
        weight = 3.0,
        type = "equip"
    },

    ["weapon_petrolcan"] = {
        index = "weapon_petrolcan",
        name = "Galão de gasolina",
        png = "weapon_petrolcan",
        weight = 1.0,
        type = "equip"
    },

    ["resinacannabis"] = {
        index = "resinacannabis",
        name = "Resina de Cannabis",
        png = "resinacannabis",
        weight = 0.3,
        type = "use"
    },

    ["ammo_assaultrifle"] = {
        index = "ammo_assaultrifle",
        name = "M-AK-47",
        png = "ammo_assaultrifle",
        weight = 0.05,
        type = "recharge"
    },

    ["ammo_firework"] = {
        index = "ammo_firework",
        name = "M-Fogos",
        png = "ammo_firework",
        weight = 0.05,
        type = "recharge"
    },

    ["ferro"] = {
        index = "ferro",
        name = "Ferro",
        png = "ferro",
        weight = 0.05,
        type = "use"
    },

    ["weapon_snspistol_mk2"] = {
        index = "weapon_snspistol_mk2",
        name = "Fajuta",
        png = "weapon_snspistol_mk2",
        weight = 3.0,
        type = "equip"
    },

    ["carnedejavali"] = {
        index = "carnedejavali",
        name = "Carne de Javali",
        png = "carnedejavali",
        weight = 3.0,
        type = "use"
    },

    ["fluoxetina"] = {
        index = "fluoxetina",
        name = "Fluoxetina",
        png = "fluoxetina",
        weight = 0.05,
        type = "use"
    },

    ["opio"] = {
        index = "opio",
        name = "Ópio",
        png = "opio",
        weight = 0.5,
        type = "use"
    },

    ["keycard"] = {
        index = "keycard",
        name = "Keycard",
        png = "keycard",
        weight = 1.0,
        type = "use"
    },

    ["mamadeira"] = {
        index = "mamadeira",
        name = "Mamadeira",
        png = "mamadeira",
        weight = 0.5,
        type = "use",
        func = function(user_id, source, item, slot, cb)
            Remote._useBandagem(source, true, 'Mamadeira')
            cb(true)
        end
    },

    ["paracetamol"] = {
        index = "paracetamol",
        name = "Paracetamol",
        png = "paracetamol",
        weight = 0.05,
        type = "use"
    },

    ["isca"] = {
        index = "isca",
        name = "Isca",
        png = "isca",
        weight = 0.25,
        type = "use"
    },

    ["ammo_smg"] = {
        index = "ammo_smg",
        name = "M-SMG",
        png = "ammo_smg",
        weight = 0.05,
        type = "recharge"
    },

    ["pipoca"] = {
        index = "pipoca",
        name = "Pipoca",
        png = "pipoca",
        weight = 0.3,
        type = "use"
    },

    ["metanfetamina"] = {
        index = "metanfetamina",
        name = "Metanfetamina ",
        png = "metanfetamina",
        weight = 0.5,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            if vRP.hasPermission(user_id, 'perm.kids') then
                TriggerClientEvent("Notify", source, "negado", "Você não pode usar droga..", 5)
                return cb(false)
            end
            if not Remote.isInDrug(source) then
                local armour = vRPc.getArmour(source)
                if armour > 0 then
                    if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                        vRPc._playAnim(source, true, { { "mp_player_int_uppersmoke", "mp_player_int_smoke" } }, true)

                        SetTimeout(2000,
                            function()
                                vRPc._stopAnim(source, false)
                                TriggerClientEvent("inventory:useDrugs", source, item)
                            end)
                        return cb(true)
                    end
                else
                    TriggerClientEvent("Notify", source, "negado",
                        "Você não possui um colete equipado para usar a droga.", 5)
                end
            end
            return cb(false)
        end
    },

    ["riopan"] = {
        index = "riopan",
        name = "Riopan",
        png = "riopan",
        weight = 0.05,
        type = "use"
    },

    ["polvora"] = {
        index = "polvora",
        name = "Polvora",
        png = "polvora",
        weight = 0.01,
        type = "use"
    },
    ["capsulas"] = {
        index = "capsulas",
        name = "Capsulas",
        png = "capsulas",
        weight = 0.01,
        type = "use"
    },

    ["pulseiraroubada"] = {
        index = "pulseiraroubada",
        name = "Pulseira",
        png = "pulseiraroubada",
        weight = 0.1,
        type = "use"
    },

    ["scubagear"] = {
        index = "scubagear",
        name = "Kit de Mergulho",
        png = "scubagear",
        weight = 10.0,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            if not Remote.checkScuba(source) then
                if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                    Remote._setScuba(source, true)
                    return cb(true)
                end
            else
                TriggerClientEvent("Notify", source, "negado",
                    "Você ja possui uma scuba equipada, para retira-la /rscuba", 5)
                return cb(false)
            end
        end

    },

    ["tucunare"] = {
        index = "tucunare",
        name = "Tucunare",
        png = "tucunare",
        weight = 2.0,
        type = "use"
    },
    
    ["piranha"] = {
        index = "piranha",
        name = "Piranha",
        png = "piranha",
        weight = 2.0,
        type = "use"
    },
    
    ["pirarucu"] = {
        index = "pirarucu",
        name = "Pirarucu",
        png = "pirarucu",
        weight = 2.0,
        type = "use"
    },
    
    ["vara"] = {
        index = "vara",
        name = "Vara de Pesca",
        png = "vara",
        weight = 0.25,
        type = "use"
    },

    ["dirty_money"] = {
        index = "dirty_money",
        name = "Dinheiro Sujo",
        png = "dirty_money",
        weight = 0.0,
        type = "use"
    },

    ["valemansao8m"] = {
        index = "valemansao8m",
        name = "Vale mansao 8m",
        png = "valemansao8m",
        weight = 0.0,
        type = "use"
    },

    ["c-fio"] = {
        index = "c-fio",
        name = "Fio",
        png = "c-fio",
        weight = 0.4,
        type = "use"
    },

    ["attachs"] = {
        index = "attachs",
        name = "Attachs",
        png = "attachs",
        weight = 0.2,
        type = "use",
        func = function(user_id, source, item, slot, cb)
            TriggerClientEvent("Weapon:Attachs", source)
            return cb(true)
        end
    },

    ["ammo_pistol"] = {
        index = "ammo_pistol",
        name = "M-Pistol",
        png = "ammo_pistol",
        weight = 0.05,
        type = "recharge"
    },

    ["sprunk"] = {
        index = "sprunk",
        name = "Sprunk",
        png = "sprunk",
        weight = 0.5,
        type = "use",
        func = Beber
    },

    ["none"] = {
        index = "none",
        name = "none",
        png = "none",
        weight = 0.0,
        type = "use"
    },

    ["anticoncepcional"] = {
        index = "anticoncepcional",
        name = "Anticoncepcional",
        png = "anticoncepcional",
        weight = 0.05,
        type = "use"
    },

    ["weapon_raypistol"] = {
        index = "weapon_raypistol",
        name = "RayPistol",
        png = "weapon_raypistol",
        weight = 3.0,
        type = "equip"
    },

    ["fireworks"] = {
        index = "fireworks",
        name = "Fogos de Artifício",
        png = "fireworks",
        weight = 0.5,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            if not vRPc.isInVehicle(source) then
                local status, time = func:getCooldown(user_id, "fireworks")
                if status then
                    func:setCooldown(user_id, "fireworks", 80)

                    if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                        TriggerClientEvent("progress", source, 2)
                        exports["vrp"]:setBlockCommand(user_id, 4)
                        vRPc._playAnim(source, false, { { "anim@mp_fireworks", "place_firework_3_box" } }, true)

                        SetTimeout(2000, function()
                            Remote._closeInventory(source)
                            vRPc._stopAnim(source, false)
                            TriggerClientEvent("fireworks:use", source)
                        end)
                        return cb(true)
                    end
                else
                    TriggerClientEvent("Notify", source, "negado",
                        "Você não pode usar o fireworks novamente, espere um pouco: " .. time)
                end
            else
                TriggerClientEvent("Notify", source, "negado", "Você não pode usar o fireworks dentro do veículo.")
            end
            return cb(false)
        end
    },

    ["weapon_sawnoffshotgun"] = {
        index = "weapon_sawnoffshotgun",
        name = "Shotgun",
        png = "weapon_sawnoffshotgun",
        weight = 8.0,
        type = "equip"
    },

    ["balinha"] = {
        index = "balinha",
        name = "Balinha",
        png = "balinha",
        weight = 0.5,
        type = "use",
        keep_item = true,
        func = OthersDrugs
    },

    ["paoq"] = {
        index = "paoq",
        name = "Pao de Queijo",
        png = "paoq",
        weight = 0.3,
        type = "use"
    },

    ["weapon_barret"] = {
        index = "weapon_barret",
        name = "Barret",
        png = "weapon_barret",
        weight = 8.0,
        type = "equip"
    },

    ["weapon_bottle"] = {
        index = "weapon_bottle",
        name = "Bottle",
        png = "weapon_bottle",
        weight = 3.0,
        type = "equip"
    },

    ["macarico"] = {
        index = "macarico",
        name = "Maçarico",
        png = "macarico",
        weight = 1.0,
        type = "use"
    },

    ["mochila"] = {
        index = "mochila",
        name = "Mochila",
        png = "mochila",
        weight = 2.0,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            if 3 > tonumber(vRP.getMochilaAmount(user_id)) then
                if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                    vRP.addMochila(user_id)
                    TriggerClientEvent("Notify", source, "importante",
                        "Você equipou a mochila, limite maximo de <b>(" ..
                        vRP.getMochilaAmount(user_id) .. "/" .. 3 .. ")</b> mochilas.", 5)
                    return cb(true)
                end
            else
                TriggerClientEvent("Notify", source, "negado", "Você ja antigiu o limite maximo de <b>(3)</b> mochilas.",
                    5)
                return cb(false)
            end
        end

    },

    ["roupas"] = {
        index = "roupas",
        name = "Roupas",
        png = "roupas",
        weight = 0.0,
        type = "use"
    },

    ["pacote_polvora"] = {
        index = "pacote_polvora",
        name = "Pacote de Polvora",
        png = "pacote_polvora",
        weight = 3.0,
        type = "use"
    },

    ["m-corpo_smg_mk2"] = {
        index = "m-corpo_smg_mk2",
        name = "Corpo de SMG",
        png = "m-corpo_smg_mk2",
        weight = 2.0,
        type = "use"
    },

    ["weapon_grajada"] = {
        index = "weapon_grajada",
        name = "Grajada",
        png = "weapon_grajada",
        weight = 8.0,
        type = "equip"
    },

    ["weapon_carbinerifle_mk2"] = {
        index = "weapon_carbinerifle_mk2",
        name = "M4MK2",
        png = "weapon_carbinerifle_mk2",
        weight = 8.0,
        type = "equip"
    },

    ["weapon_firework"] = {
        index = "weapon_firework",
        name = "Fogos",
        png = "weapon_firework",
        weight = 3.0,
        type = "equip"
    },

    ["kitnitro"] = {
        index = "kitnitro",
        name = "Kit de Nitro",
        png = "kitnitro",
        weight = 1.0,
        type = "use",
        func = function(user_id, source, item, slot, cb)
            TriggerClientEvent("install_nitro", source)
        end
    },

    ["weapon_heavypistol"] = {
        index = "weapon_heavypistol",
        name = "HeavyPistol",
        png = "weapon_heavypistol",
        weight = 3.0,
        type = "equip"
    },

    ["weapon_combatpistol"] = {
        index = "weapon_combatpistol",
        name = "Glock",
        png = "weapon_combatpistol",
        weight = 3.0,
        type = "equip"
    },

    ["ammo_smg_mk2"] = {
        index = "ammo_smg_mk2",
        name = "M-Smg MK2",
        png = "ammo_smg_mk2",
        weight = 0.05,
        type = "recharge"
    },

    ["skate"] = {
        index = "skate",
        name = "Skate",
        png = "skate",
        weight = 1.0,
        type = "use"
    },

    ["money"] = {
        index = "money",
        name = "Dinheiro",
        png = "money",
        weight = 1e-05,
        type = "use"
    },

    ["valemansao500k"] = {
        index = "valemansao500k",
        name = "Vale mansao 500k",
        png = "valemansao500k",
        weight = 0.0,
        type = "use"
    },

    ["weapon_switchblade"] = {
        index = "weapon_switchblade",
        name = "SwitchBlade",
        png = "weapon_switchblade",
        weight = 3.0,
        type = "equip"
    },

    ["bandagem"] = {
        index = "bandagem",
        name = "Bandagem",
        png = "bandagem",
        weight = 0.5,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                vRPc._CarregarObjeto(source, "amb@world_human_clipboard@male@idle_a", "idle_c", "v_ret_ta_firstaid", 49,
                    60309)

                TriggerClientEvent("progress", source, 15)
                SetTimeout(15 * 1000, function()
                    vRPc._DeletarObjeto(source)
                    Remote._useBandagem(source, true, 'Bandagem')
                    TriggerClientEvent("Notify", source, "importante",
                        "Você utilizou a bandagem, não tome nenhum tipo de dano para não ser cancelada.", 5)
                end)
                func:setCooldown(user_id, "inventario", 5)

                return cb(true)
            end
            return cb(false)
        end
    },

    ["barrier"] = {
        index = "barrier",
        name = "Tenda",
        png = "barrier",
        weight = 0.5,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            local hash = "prop-tendarelikiashop"
            local application,Coords,heading = Remote.objectCoords(source, hash)
            if application then
                if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                    Remote.createObject(source, hash, vec4(Coords.x, Coords.y, Coords.z - 1.0, heading))
                    Remote.createItem(source, hash, Coords, heading)
                    func:setCooldown(user_id, "inventario", 5)
                    return cb(true)
                end
            end
            return cb(false)
        end
    },

    ["weapon_gusenberg"] = {
        index = "weapon_gusenberg",
        name = "Submetralhadora Thompson",
        png = "weapon_gusenberg",
        weight = 3.0,
        type = "equip"
    },

    ["ammo_assaultsmg"] = {
        index = "ammo_assaultsmg",
        name = "M-MTAR",
        png = "ammo_assaultsmg",
        weight = 0.05,
        type = "recharge"
    },

    ["chave_algemas"] = {
        index = "chave_algemas",
        name = "Chave de algemas",
        png = "chave_algemas",
        weight = 0.3,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            local nplayer = vRPc.getNearestPlayer(source, 3)
            if nplayer then
                if vRPc.isHandcuffed(source) then
                    if vRP.tryGetInventoryItem(user_id, "chave_algemas", 1, true, slot) then
                        vRP.giveInventoryItem(user_id, "algemas", 1, true)
                        TriggerClientEvent("vrp_sound:source", source, "uncuff", 0.4)
                        TriggerClientEvent("vrp_sound:source", nplayer, "uncuff", 0.4)
                        vRPc._setHandcuffed(nplayer, false)
                        return cb(true)
                    else
                        TriggerClientEvent("Notify", source, "negado", "Você não possui chave de algemas.", 5)
                    end
                end
            else
                TriggerClientEvent("Notify", source, "negado", "Nenhum jogador proximo.", 5)
            end
            return cb(false)
        end
    },

    ["c-cobre"] = {
        index = "c-cobre",
        name = "Cobre",
        png = "c-cobre",
        weight = 0.4,
        type = "use"
    },

    ["weapon_appistol"] = {
        index = "weapon_appistol",
        name = "Ap Pistol",
        png = "weapon_appistol",
        weight = 3.0,
        type = "equip"
    },

    ["tiner"] = {
        index = "tiner",
        name = "Tiner",
        png = "tiner",
        weight = 0.3,
        type = "use"
    },

    ["m-gatilho"] = {
        index = "m-gatilho",
        name = "Gatilho",
        png = "m-gatilho",
        weight = 0.8,
        type = "use"
    },

    ["ammo_doubleaction"] = {
        index = "ammo_doubleaction",
        name = "M-DOUBLEACTION",
        png = "ammo_doubleaction",
        weight = 0.05,
        type = "recharge"
    },

    ["ammo_snspistol_mk2"] = {
        index = "ammo_snspistol_mk2",
        name = "M-Fajuta",
        png = "ammo_snspistol_mk2",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_knuckle"] = {
        index = "weapon_knuckle",
        name = "Knuckle",
        png = "weapon_knuckle",
        weight = 3.0,
        type = "equip"
    },

    ["carnedelobo"] = {
        index = "carnedelobo",
        name = "Carne de Lobo",
        png = "carnedelobo",
        weight = 3.0,
        type = "use"
    },

    ["pacote_tecido"] = {
        index = "pacote_tecido",
        name = "Pacote de Tecido",
        png = "pacote_tecido",
        weight = 3.0,
        type = "use"
    },

    ["caixa"] = {
        index = "caixa",
        name = "Caixa de entrega",
        png = "caixa",
        weight = 1.5,
        type = "use"
    },

    ["weapon_flare"] = {
        index = "weapon_flare",
        name = "Sinalizador",
        png = "weapon_flare",
        weight = 3.0,
        type = "equip"
    },

    ["doritos"] = {
        index = "doritos",
        name = "Doritos",
        png = "doritos",
        weight = 0.5,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                vRPc._CarregarObjeto(source, "amb@code_human_wander_eating_donut@male@idle_a", "idle_a", "lg_doritos", 49,
                    28422)

                TriggerClientEvent("progress", source, 15)
                SetTimeout(15 * 1000, function()
                    vRPc._DeletarObjeto(source)
                    Remote._useBandagem(source, true, 'Doritos')
                    TriggerClientEvent("Notify", source, "importante",
                        "Você utilizou doritos, não tome nenhum tipo de dano para não ser cancelada.", 5)
                end)

                func:setCooldown(user_id, "inventario", 5)

                return cb(true)
            end
            return cb(false)
        end
    },

    ["sanduiche"] = {
        index = "sanduiche",
        name = "Sanduiche",
        png = "sanduiche",
        weight = 0.5,
        type = "use"
    },

    ["ferramenta"] = {
        index = "ferramenta",
        name = "Ferramenta",
        png = "ferramenta",
        weight = 1.0,
        type = "use"
    },

    ["weapon_battleaxe"] = {
        index = "weapon_battleaxe",
        name = "Battleaxe",
        png = "weapon_battleaxe",
        weight = 3.0,
        type = "equip"
    },

    ["distintivopolicial"] = {
        index = "distintivopolicial",
        name = "Distintivo Policial",
        png = "distintivopolicial",
        weight = 0.3,
        type = "use"
    },

    ["militec"] = {
        index = "militec",
        name = "Militec",
        png = "militec",
        weight = 1.0,
        type = "use"
    },

    ["cogumelo"] = {
        index = "cogumelo",
        name = "Cogumelo ",
        png = "cogumelo",
        weight = 0.5,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            if vRP.hasPermission(user_id, 'perm.kids') then
                TriggerClientEvent("Notify", source, "negado", "Você não pode usar droga..", 5)
                return cb(false)
            end
            if not Remote.isInDrug(source) then
                if GetEntityHealth(GetPlayerPed(source)) > 250 and GetEntityHealth(GetPlayerPed(source)) > 101 then
                    TriggerEvent("Notify", "negado",
                        "Você não pode utilizer com esse quantidade de vida.", 5)
                else
                    if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                        Remote._useBandagem(source, true, 'Cogumelo')
                        vRPc._playAnim(source, true, { { "mp_player_int_uppersmoke", "mp_player_int_smoke" } }, true)
                        SetTimeout(2000,
                            function()
                                vRPc._stopAnim(source, false)
                                TriggerClientEvent("inventory:useDrugs", source, item)
                            end)
                        return cb(true)
                    end
                end
            end
            return cb(false)
        end
    },

    ["ammo_carbinerifle_mk2"] = {
        index = "ammo_carbinerifle_mk2",
        name = "M-M4",
        png = "ammo_carbinerifle_mk2",
        weight = 0.05,
        type = "recharge"
    },

    ["m-corpo_pistol_mk2"] = {
        index = "m-corpo_pistol_mk2",
        name = "Corpo de Pistol",
        png = "m-corpo_pistol_mk2",
        weight = 1.5,
        type = "use"
    },

    ["repairkit"] = {
        index = "repairkit",
        name = "Jogue Fora",
        png = "repairkit",
        weight = 1.0,
        type = "use"
    },

    ["panetone"] = {
        index = "panetone",
        name = "Panetone",
        png = "panetone",
        weight = 0.5,
        type = "use"
    },

    ["pastabase"] = {
        index = "pastabase",
        name = "Pasta Base",
        png = "pastabase",
        weight = 0.3,
        type = "use"
    },

    ["ammo_heavypistol"] = {
        index = "ammo_heavypistol",
        name = "M-HeavyPistol",
        png = "ammo_heavypistol",
        weight = 0.05,
        type = "recharge"
    },

    ["cocacola"] = {
        index = "cocacola",
        name = "Coca Cola",
        png = "cocacola",
        weight = 0.5,
        type = "use",
        func = Beber
    },

    ["ammo_pumpshotgun_mk2"] = {
        index = "ammo_pumpshotgun_mk2",
        name = "M-Pump Shotgun",
        png = "ammo_pumpshotgun_mk2",
        weight = 0.05,
        type = "recharge"
    },

    ["aluminio"] = {
        index = "aluminio",
        name = "Aluminio",
        png = "aluminio",
        weight = 0.05,
        type = "use"
    },

    ["pao"] = {
        index = "pao",
        name = "Pao",
        png = "pao",
        weight = 0.5,
        type = "use"
    },

    ["pecadearma"] = {
        index = "pecadearma",
        name = "Peça de arma",
        png = "pecadearma",
        weight = 0.1,
        type = "use"
    },

    ["notafiscalarma"] = {
        index = "notafiscalarma",
        name = "Nota fiscal de Arma",
        png = "notafiscalarma",
        weight = 0.1,
        type = "use"
    },

    ["notafiscalmunicao"] = {
        index = "notafiscalmunicao",
        name = "Nota fiscal de Municao",
        png = "notafiscalmunicao",
        weight = 0.1,
        type = "use"
    },

    ["notafiscallavagem"] = {
        index = "notafiscallavagem",
        name = "Nota fiscal de Lavagem",
        png = "notafiscallavagem",
        weight = 0.1,
        type = "use"
    },

    ["notafiscaldroga"] = {
        index = "notafiscaldroga",
        name = "Nota fiscal de Droga",
        png = "notafiscaldroga",
        weight = 0.1,
        type = "use"
    },

    ["notafiscaldesmanche"] = {
        index = "notafiscaldesmanche",
        name = "Nota fiscal de Desmanche",
        png = "notafiscaldesmanche",
        weight = 0.1,
        type = "use"
    },

    ["coin"] = {
        index = "coin",
        name = "Coin",
        png = "coin",
        weight = 0.1,
        type = "use"
    },

    ["maca"] = {
        index = "maca",
        name = "Maça",
        png = "maca",
        weight = 1.0,
        type = "use"
    },

    ["m-corpo_machinepistol"] = {
        index = "m-corpo_machinepistol",
        name = "Corpo de TEC-9",
        png = "m-corpo_machinepistol",
        weight = 2.0,
        type = "use"
    },

    ["celular"] = {
        index = "celular",
        name = "Celular",
        png = "celular",
        weight = 1.0,
        type = "use"
    },

    ["barricada"] = {
        index = "barricada",
        name = "Barricada",
        png = "barricada",
        weight = 1.0,
        type = "use"
    },

    ["radio"] = {
        index = "radio",
        name = "Radio",
        png = "radio",
        weight = 1.0,
        type = "use"
    },

    ["tomate"] = {
        index = "tomate",
        name = "Tomate",
        png = "tomate",
        weight = 1.0,
        type = "use"
    },

    ["repairkit3"] = {
        index = "repairkit3",
        name = "Kit Reparo",
        png = "repairkit3",
        weight = 1.0,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            if vRPc.isInVehicle(source) then
                TriggerClientEvent("Notify", source, "negado", "Você não pode usar o kit de reparo dentro do veiculo.", 5)
                return cb(false)
            end

			local vehicle = vRPc.getNearestVehicle(source,3)
            if not vehicle then return cb(false) end 
            
            if vRP.tryGetInventoryItem(user_id, "repairkit3", 1, true, slot) then
                vRPc._playAnim(source, false, { { "mini@repair", "fixing_a_player" } }, true)
                TriggerClientEvent("progress", source, 30)
                exports["vrp"]:setBlockCommand(user_id, 35)
                TriggerClientEvent('abrircapo', source)
                exports.vrp_player:addSeatCooldown(user_id, 35)
                SetTimeout(30000, function()
                    TriggerClientEvent("reparar", source, vehicle)
                    vRPc._stopAnim(source, false)
                    TriggerClientEvent("Notify", source, "sucesso", "Você reparou o veiculo.", 5)
                end)
            return cb(true)
            end
            return cb(false)
        end
    },

    ["graosimpuros"] = {
        index = "graosimpuros",
        name = "Graos",
        png = "graosimpuros",
        weight = 1.0,
        type = "use"
    },

    ["c4"] = {
        index = "c4",
        name = "C4",
        png = "c4",
        weight = 0.1,
        type = "use"
    },

    ["c-polvora"] = {
        index = "c-polvora",
        name = "Polvora",
        png = "c-polvora",
        weight = 0.3,
        type = "use"
    },

    ["lockpick"] = {
        index = "lockpick",
        name = "Lock Pick",
        png = "lockpick",
        weight = 1.0,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            local plate, mName, mNet, mPortaMalas, mPrice, mLock, mModel = vRPc.ModelName(source, 7)
            local plateUser = vRP.getUserByRegistration(plate)
            if not plate then
                TriggerClientEvent("Notify", source, "negado", "Você não perto de um veículo.", 5)
                return cb(false)
            end

            local plyCoords = GetEntityCoords(GetPlayerPed(source))
            local distance = #(plyCoords - vec3(178.01, -1014.68, 29.35))
            local distance2 = #(plyCoords - vec3(-450.4, -365.93, 33.3))
            if distance <= 94.0 or distance2 <= 104.0 then
                TriggerClientEvent("Notify", source, "negado", "Você não pode usar lockpick nesta área.", 5)
                return cb(false)
            end

            if not mLock then
                TriggerClientEvent("Notify", source, "negado", "O veículo não está trancado.", 5)
                return cb(false)
            end

            if vRP.tryGetInventoryItem(user_id, "lockpick", 1, true, slot) then
                Remote._closeInventory(source)
                Wait(1000)
                Remote._startAnimHotwired(source)
                local finished = vRPc.taskBar(source)
                if finished then
                    local entity = NetworkGetEntityFromNetworkId(mNet)
                    if entity then
                        SetVehicleDoorsLocked(entity, 1)
                    end

                    TriggerClientEvent("vrp_sound:source", source, "lock", 0.1)
                    TriggerClientEvent("Notify", source, "negado",
                        "Você destrancou o veiculo, cuidado a policia foi acionada.", 5)
                    vRP.sendLog("LOCKPICK",
                        "**SUCESSO** O [ID: " ..
                        user_id ..
                        "] Roubou o veiculo " ..
                        mModel .. "(ID:" .. plateUser .. ") nas nas cordenadas: " .. plyCoords.x .. "," .. plyCoords.y .. "," .. plyCoords.z)

                    
                    exports["vrp_admin"]:generateLog({
                        category = "inventario",
                        room = "lockpick",
                        user_id = user_id,
                        message = ([[O usuário %s roubou o veículo %s do usuário %s nas coordenadas %s]]):format(user_id, mModel,
                            plateUser, vec3(plyCoords.x, plyCoords.y, plyCoords.z))
                    })
                    -- end
                    -- end
                end

                exports['vrp']:alertPolice({
                    x = x,
                    y = y,
                    z = z,
                    blipID = 161,
                    blipColor = 63,
                    blipScale = 0.5,
                    time = 20,
                    code =
                    "911",
                    title = "Veiculo Roubado (" .. mModel .. ")",
                    name =
                        "Um novo registro de tentativa de roubo de veiculo, Modelo: " ..
                        mModel .. " Placa: " .. plate .. ". "
                })
                vRPc._stopAnim(source, false)
            end
        end
    },

    ["weapon_militaryrifle"] = {
        index = "weapon_militaryrifle",
        name = "MilitaryRifle",
        png = "weapon_militaryrifle",
        weight = 8.0,
        type = "equip"
    },

    ["valemansao10m"] = {
        index = "valemansao10m",
        name = "Vale mansao 10m",
        png = "valemansao10m",
        weight = 0.0,
        type = "use"
    },

    ["ammo_grajada"] = {
        index = "ammo_grajada",
        name = "M-Grajada",
        png = "ammo_grajada",
        weight = 0.05,
        type = "recharge"
    },

    ["m-malha"] = {
        index = "m-malha",
        name = "Malha",
        png = "m-malha",
        weight = 0.4,
        type = "use"
    },

    ["capuz"] = {
        index = "",
        name = "Capuz",
        png = "capuz",
        weight = 0.1,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            local nplayer = vRPc.getNearestPlayer(source, 5)
            if not nplayer or nplayer <= 0 then
                TriggerClientEvent("Notify", source, "negado", "Nenhum jogador proximo.", 5)
                return
            end

            if vRPc.isHandcuffed(nplayer) then
                if not vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                    return cb(false)
                end

                if vRPc.isCapuz(nplayer) then
                    vRPc._setCapuz(nplayer, false)
                    TriggerClientEvent("Notify", source, "sucesso", "Você retirou o capuz desse jogador.", 5)
                else
                    vRPc._setCapuz(nplayer, true)
                    TriggerClientEvent("Notify", source, "sucesso", "Você colocou o capuz nesse jogador, para retirar use o item novamente.", 5)
                end
                local nuser_id = vRP.getUserId(nplayer)
                vRP.sendLog("https://ptb.discord.com/api/webhooks/1282365336401743954/bczAKpoNZmvzieys9fpdUB-r0lRUIpCv2lY-iHnAtT6x2-Es7fIQfbu5Pj0mI8FGnOWn", "O USER_ID: " .. user_id .. " Usou o Capuz no USER_ID: " .. nuser_id)

                exports["vrp_admin"]:generateLog({
                    category = "inventario",
                    room = "capuz",
                    user_id = user_id,
                    message = ([[O USER_ID %s USOU O CAPUZ NO USER_ID %s]]):format(user_id, nuser_id)
                })
                return cb(true)
            else
                TriggerClientEvent("Notify", source, "importante", "O jogador não está rendido ou algemado!", 5)
                return cb(false)
            end

            return cb(false)
        end
    },
    ["sucol"] = {
        index = "sucol",
        name = "Suco de Laranja",
        png = "sucol",
        weight = 0.5,
        type = "use",
        func = Beber
    },

    ["pizza"] = {
        index = "pizza",
        name = "Pizza",
        png = "pizza",
        weight = 1.5,
        type = "use"
    },

    ["ammo_carbinerifle"] = {
        index = "ammo_carbinerifle",
        name = "M-M4",
        png = "ammo_carbinerifle",
        weight = 0.05,
        type = "recharge"
    },

    ["ammo_parafal"] = {
        index = "ammo_parafal",
        name = "M-PARAFAL",
        png = "ammo_parafal",
        weight = 0.05,
        type = "recharge"
    },

    ["ammo_advancedrifle"] = {
        index = "ammo_advancedrifle",
        name = "M-Aug",
        png = "ammo_advancedrifle",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_parafal"] = {
        index = "weapon_parafal",
        name = "PARAFAL",
        png = "weapon_parafal",
        weight = 8.0,
        type = "equip"
    },
    ["weapon_advancedrifle"] = {
        index = "weapon_advancedrifle",
        name = "Aug",
        png = "weapon_advancedrifle",
        weight = 8.0,
        type = "equip"
    },
    ["weapon_heavysniper"] = {
        index = "weapon_heavysniper",
        name = "SNIPER",
        png = "weapon_heavysniper",
        weight = 8.0,
        type = "equip"
    },

    ["colarroubado"] = {
        index = "colarroubado",
        name = "Colar",
        png = "colarroubado",
        weight = 0.1,
        type = "use"
    },

    ["m-corpo_g3"] = {
        index = "m-corpo_g3",
        name = "Corpo de G3",
        png = "m-corpo_g3",
        weight = 5.0,
        type = "use"
    },

    ["cafe"] = {
        index = "cafe",
        name = "Cafe",
        png = "cafe",
        weight = 0.25,
        type = "use",
        func = Beber
    },

    ["whisky"] = {
        index = "whisky",
        name = "Whisky",
        png = "whisky",
        weight = 1.0,
        type = "use",
        func = Beber_Alcoolico
    },

    ["weapon_assaultrifle_mk2"] = {
        index = "weapon_assaultrifle_mk2",
        name = "AK MK2",
        png = "weapon_assaultrifle_mk2",
        weight = 8.0,
        type = "equip"
    },

    ["weapon_assaultrifle"] = {
        index = "weapon_assaultrifle",
        name = "AK 47",
        png = "weapon_assaultrifle",
        weight = 8.0,
        type = "equip"
    },

    ["bronze"] = {
        index = "bronze",
        name = "Bronze",
        png = "bronze",
        weight = 1.0,
        type = "use"
    },

    ["weapon_pumpshotgun_mk2"] = {
        index = "weapon_pumpshotgun_mk2",
        name = "Pump Shotgun",
        png = "weapon_pumpshotgun_mk2",
        weight = 8.0,
        type = "equip"
    },

    ["weapon_pumpshotgun"] = {
        index = "weapon_pumpshotgun",
        name = "Pump Shotgun",
        png = "weapon_pumpshotgun",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_pumpshotgun"] = {
        index = "ammo_pumpshotgun",
        name = "M-Pump Shotgun",
        png = "ammo_pumpshotgun",
        weight = 0.05,
        type = "recharge"
    },

    ["skolb"] = {
        index = "skolb",
        name = "Skol Beats",
        png = "skolb",
        weight = 0.25,
        type = "use",
        func = Beber_Alcoolico
    },

    ["weapon_microsmg"] = {
        index = "weapon_microsmg",
        name = "MICROSMG",
        png = "weapon_microsmg",
        weight = 6.0,
        type = "equip"
    },

    ["ammo_pistol50"] = {
        index = "ammo_pistol50",
        name = "M-Desert",
        png = "ammo_pistol50",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_smg"] = {
        index = "weapon_smg",
        name = "SMG",
        png = "weapon_smg",
        weight = 6.0,
        type = "equip"
    },

    ["weapon_smg_mk2"] = {
        index = "weapon_smg_mk2",
        name = "Smg MK2",
        png = "weapon_smg_mk2",
        weight = 6.0,
        type = "equip"
    },

    ["ammo_machinepistol"] = {
        index = "ammo_machinepistol",
        name = "M-Tec-9",
        png = "ammo_machinepistol",
        weight = 0.05,
        type = "recharge"
    },

    ["weapon_pistol"] = {
        index = "weapon_pistol",
        name = "Pistol",
        png = "weapon_pistol",
        weight = 3.0,
        type = "equip"
    },

    ["plastica"] = {
        index = "plastica",
        name = "Plastica",
        png = "plastica",
        weight = 0.0,
        type = "use"
    },

    ["weapon_poolcue"] = {
        index = "weapon_poolcue",
        name = "Poolcue",
        png = "weapon_poolcue",
        weight = 3.0,
        type = "equip"
    },

    ["pacote_metalico"] = {
        index = "pacote_metalico",
        name = "Pacote Metalico",
        png = "pacote_metalico",
        weight = 10.0,
        type = "use"
    },

    ["weapon_bat"] = {
        index = "weapon_bat",
        name = "Bastão de Beisebol",
        png = "weapon_bat",
        weight = 3.0,
        type = "equip"
    },

    ["weapon_crowbar"] = {
        index = "weapon_crowbar",
        name = "CrowBar",
        png = "weapon_crowbar",
        weight = 3.0,
        type = "equip"
    },

    ["cerveja"] = {
        index = "cerveja",
        name = "Cerveja",
        png = "cerveja",
        weight = 0.5,
        type = "use",
        func = Beber_Alcoolico
    },

    ["weapon_dagger"] = {
        index = "weapon_dagger",
        name = "Dagger",
        png = "weapon_dagger",
        weight = 3.0,
        type = "equip"
    },

    ["weapon_knife"] = {
        index = "weapon_knife",
        name = "Faca",
        png = "weapon_knife",
        weight = 3.0,
        type = "equip"
    },

    ["weapon_combatpdw"] = {
        index = "weapon_combatpdw",
        name = "Combat Pdw",
        png = "weapon_combatpdw",
        weight = 3.0,
        type = "equip"
    },

    ["weapon_snowball"] = {
        index = "weapon_snowball",
        name = "Bola de Neve",
        png = "weapon_snowball",
        weight = 3.0,
        type = "equip"
    },

    ["pinga"] = {
        index = "pinga",
        name = "Pinga",
        png = "pinga",
        weight = 1.0,
        type = "use",
        func = Beber_Alcoolico
    },

    ["weapon_pistol50"] = {
        index = "weapon_pistol50",
        name = "Desert Eagle",
        png = "weapon_pistol50",
        weight = 3.0,
        type = "equip"
    },

    ["ammo_gusenberg"] = {
        index = "ammo_gusenberg",
        name = "M-Thompson",
        png = "ammo_gusenberg",
        weight = 0.05,
        type = "recharge"
    },

    ["water"] = {
        index = "water",
        name = "Agua",
        png = "water",
        weight = 0.5,
        type = "use",
        func = Beber
    },

    ["laranja"] = {
        index = "laranja",
        name = "Laranja",
        png = "laranja",
        weight = 1.0,
        type = "use"
    },
    ["weapon_bzgas"] = {
        index = "weapon_bzgas",
        name = "Gas",
        png = "weapon_bzgas",
        weight = 3.0,
        type = "equip"
    },

    ["weapon_doubleaction"] = {
        index = "weapon_doubleaction",
        name = "DOUBLEACTION",
        png = "weapon_doubleaction",
        weight = 8.0,
        type = "equip"
    },

    ["ammo_appistol"] = {
        index = "ammo_appistol",
        name = "M-Ap Pistol",
        png = "ammo_appistol",
        weight = 0.05,
        type = "recharge"
    },

    ["dorflex"] = {
        index = "dorflex",
        name = "Dorflex",
        png = "dorflex",
        weight = 0.05,
        type = "use"
    },

    ["gadget_parachute"] = {
        index = "gadget_parachute",
        name = "Paraquedas",
        png = "gadget_parachute",
        weight = 3.0,
        type = "equip"
    },

    ["manga"] = {
        index = "manga",
        name = "Manga",
        png = "manga",
        weight = 1.0,
        type = "use"
    },

    ["alterartelefone"] = {
        index = "alterartelefone",
        name = "Alterar Telefone",
        png = "alterartelefone",
        weight = 0.0,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            Remote._closeInventory(source)
            Wait(300)
            local numero = vRP.prompt(source, "Digite o numero: (MAX 6) (EXEMPLO: 123456)", "")
            if tonumber(numero) ~= nil and numero ~= "" and tonumber(numero) and string.len(numero) == 6 then
                numero = formatNumber(numero)
                if checkNumber(numero) then
                    if vRP.request(source, "Tem certeza que deseja alterar o numero de telefone para <b>" .. numero .. "</b> ?", 30) then
                        if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                            vRP.execute("vRP/update_number", { user_id = user_id, telefone = numero })
                            TriggerClientEvent("Notify", source, "sucesso",
                                "Você trocou o numero de telefone para <b>" ..
                                numero .. "</b>, aguarde a cidade reiniciar para alteração ser feita.", 15)
                        end
                    end
                    return cb(true)
                else
                    TriggerClientEvent("Notify", source, "negado", "Este numero de telefone ja existe.", 5)
                end
            else
                TriggerClientEvent("Notify", source, "negado", "Digite o numero de telefone correto. (EXEMPLO: 123456)",
                    5)
            end
            return cb(false)
        end
    },

    ["ovodapascoa"] = {
        index = "ovodapascoa",
        name = "Ovo da Pascoa",
        png = "ovodapascoa",
        weight = 0.5,
        type = "use",
        func = function(user_id, source, item, slot, cb)
            if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                vRPc._CarregarObjeto(source, "amb@world_human_clipboard@male@idle_a", "idle_c", "mah_lotus_pascoa", 49,
                    60309)

                TriggerClientEvent("progress", source, 15)
                SetTimeout(15 * 1000, function()
                    vRPc._DeletarObjeto(source)
                    Remote._useBandagem(source, false)
                    TriggerClientEvent("Notify", source, "importante",
                        "Você comeu o ovo da pascoa, não tome nenhum tipo de dano para não ser cancelada.", 5)
                end)

                func:setCooldown(user_id, "inventario", 5)

                return cb(true)
            end
            return cb(false)
        end
    },

    ["tartaruga"] = {
        index = "tartaruga",
        name = "Tartaruga",
        png = "tartaruga",
        weight = 3.0,
        type = "use"
    },

    ["camisinha"] = {
        index = "camisinha",
        name = "Camisinha",
        png = "camisinha",
        weight = 0.05,
        type = "use"
    },

    ["tilapia"] = {
        index = "tilapia",
        name = "Tilapia",
        png = "tilapia",
        weight = 0.5,
        type = "use"
    },

    ["brincoroubado"] = {
        index = "brincoroubado",
        name = "Brinco",
        png = "brincoroubado",
        weight = 0.1,
        type = "use"
    },

    ["maconha"] = {
        index = "maconha",
        name = "Maconha",
        png = "maconha",
        weight = 0.5,
        type = "use",
        keep_item = true,
        func = OthersDrugs
    },

    ["coumadin"] = {
        index = "coumadin",
        name = "Coumadin",
        png = "coumadin",
        weight = 0.05,
        type = "use"
    },

    ["coumadin"] = {
        index = "coumadin",
        name = "Coumadin",
        png = "coumadin",
        weight = 0.05,
        type = "use",
    },

    ["luftal"] = {
        index = "luftal",
        name = "Luftal",
        png = "luftal",
        weight = 0.05,
        type = "use"
    },

    ["barrac"] = {
        index = "barrac",
        name = "Barra de chocolate",
        png = "barrac",
        weight = 0.5,
        type = "use"
    },

    ["cataflan"] = {
        index = "cataflan",
        name = "Cataflan",
        png = "cataflan",
        weight = 0.05,
        type = "use"
    },

    ["amoxilina"] = {
        index = "amoxilina",
        name = "Amoxilina",
        png = "amoxilina",
        weight = 0.05,
        type = "use"
    },

    ["flordelotus"] = {
        index = "flordelotus",
        name = "Flor de Lotus",
        png = "flordelotus",
        weight = 1.0,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                vRPc._CarregarObjeto(source, "amb@world_human_clipboard@male@idle_a", "idle_c", "v_ret_ta_firstaid", 49,
                    60309)

                TriggerClientEvent("progress", source, 15)
                SetTimeout(15 * 1000, function()
                    vRPc._DeletarObjeto(source)
                    Remote._useMedical(source, true)
                    TriggerClientEvent("Notify", source, "importante",
                        "Você utilizou a flor de lotus, não tome nenhum tipo de dano para não ser cancelada.", 5)
                end)
                func:setCooldown(user_id, "inventario", 5)

                return cb(true)
            end
            return cb(false)
        end
    },

    ["alianca"] = {
        index = "alianca",
        name = "Alianca",
        png = "alianca",
        weight = 1.0,
        type = "use"
    },

    ["ammo_militaryrifle"] = {
        index = "ammo_militaryrifle",
        name = "M-MilitaryRifle",
        png = "ammo_militaryrifle",
        weight = 0.05,
        type = "recharge"
    },

    ["absinto"] = {
        index = "absinto",
        name = "Absinto",
        png = "absinto",
        weight = 0.5,
        type = "use",
        func = Beber_Alcoolico
    },

    ["corote"] = {
        index = "corote",
        name = "Corote",
        png = "corote",
        weight = 0.5,
        type = "use",
        func = Beber_Alcoolico
    },

    ["weapon_golfclub"] = {
        index = "weapon_golfclub",
        name = "GolfClub",
        png = "weapon_golfclub",
        weight = 3.0,
        type = "equip"
    },

    ["metal"] = {
        index = "metal",
        name = "Placa de Metal",
        png = "metal",
        weight = 0.15,
        type = "use"
    },

    ["weapon_revolver_mk2"] = {
        index = "weapon_revolver_mk2",
        name = "Revolver",
        png = "weapon_revolver_mk2",
        weight = 3.0,
        type = "equip"
    },

    ["emptybottle"] = {
        index = "emptybottle",
        name = "Garrafa Vazia",
        png = "emptybottle",
        weight = 0.2,
        type = "use",
        func = function(user_id, source, item, slot, cb)
            local status, style = Remote.checkFountain(source)
            if status then
                if vRP.tryGetInventoryItem(user_id, item, 1, true, slot) then
                    if style == "fountain" then
                        Remote._closeInventory(source)
                        vRPc._playAnim(source, false,
                            { { "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" } },
                            true)
                    elseif style == "floor" then
                        Remote._closeInventory(source)
                        vRPc._playAnim(source, false, { { "amb@world_human_bum_wash@male@high@base", "base" } }, true)
                    end

                    TriggerClientEvent("progress", source, 10)
                    exports["vrp"]:setBlockCommand(user_id, 10)
                    Wait(10000)
                    vRP.giveInventoryItem(user_id, "water", 1, true)
                    vRPc._stopAnim(source, false)
                end
            end
        end

    },

    ["ammo_assaultrifle_mk2"] = {
        index = "ammo_assaultrifle_mk2",
        name = "M-AK MK2",
        png = "ammo_assaultrifle_mk2",
        weight = 0.05,
        type = "recharge"
    },

    ["ammo_specialcarbine"] = {
        index = "ammo_specialcarbine",
        name = "M-Parafal",
        png = "ammo_specialcarbine",
        weight = 0.05,
        type = "recharge"
    },

    ["coxinha"] = {
        index = "coxinha",
        name = "Coxinha",
        png = "coxinha",
        weight = 0.5,
        type = "use"
    },

    ["rivotril"] = {
        index = "rivotril",
        name = "Rivotril",
        png = "rivotril",
        weight = 0.05,
        type = "use"
    },

    ["weapon_specialcarbine"] = {
        index = "weapon_specialcarbine",
        name = "G36",
        png = "weapon_specialcarbine",
        weight = 8.0,
        type = "equip"
    },

    ["pneus"] = {
        index = "pneus",
        name = "Pneus",
        png = "pneus",
        weight = 10.0,
        type = "use",
        keep_item = true,
        func = function(user_id, source, item, slot, cb)
            if not vRPc.isInVehicle(source) then
                local vehicle = vRPc.getNearestVehicle(source, 7)
                if vRP.tryGetInventoryItem(user_id, "pneus", 1, true, slot) then
                    vRPc._playAnim(source, false,
                        { { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" } }, true)
                    TriggerClientEvent("progress", source, 10000)
                    exports["vrp"]:setBlockCommand(user_id, 15)
                    exports.vrp_player:addSeatCooldown(user_id, 15)
                    SetTimeout(10000, function()
                        TriggerClientEvent('repararpneus', source, vehicle)
                        vRPc._stopAnim(source, false)
                        TriggerClientEvent("Notify", source, "sucesso", "Você reparou o pneu do veiculo.", 5)
                    end)
                    return cb(true)
                end
            else
                TriggerClientEvent("Notify", source, "negado",
                    "Precisa estar próximo ou fora do veículo para efetuar os reparos.", 5)
            end
            return cb(false)
        end
    },

    ["rubi"] = {
        index = "rubi",
        name = "Rubi",
        png = "rubi",
        weight = 1.0,
        type = "use"
    },

    ["ammo_pistol_mk2"] = {
        index = "ammo_pistol_mk2",
        name = "M-Five-Seven",
        png = "ammo_pistol_mk2",
        weight = 0.05,
        type = "recharge"
    },

    ["ammo_heavyrifle"] = {
        index = "ammo_heavyrifle",
        name = "M-Heavy Rifle",
        png = "ammo_heavyrifle",
        weight = 0.05,
        type = "recharge"
    },

    ["energetico"] = {
        index = "energetico",
        name = "Energetico",
        png = "energetico",
        weight = 0.25,
        type = "use",
        func = function(user_id, source, item, slot, cb)
            TriggerClientEvent("progress", source, 3)
            play_drink(source, item, 3)
            SetTimeout(3000, function()
                TriggerClientEvent("Notify", source, "sucesso", "Energetico utilizado com sucesso.", 5)
                Remote._setEnergetico(source, true)
                SetTimeout(15000, function()
                    TriggerClientEvent("Notify", source, "negado", "O Efeito do energetico acabou.", 5)
                    Remote._setEnergetico(source, false)
                end)
            end)
        end
    },

    ["adrenalina"] = {
        index = "adrenalina",
        name = "Adrenalina",
        png = "adrenalina",
        weight = 0.25,
        type = "use",
        func = function(user_id, source, item, slot, cb)
            local nplayer = vRPc.getNearestPlayer(source, 2)
            if nplayer then
                local nuser_id = vRP.getUserId(source)
                if GetEntityHealth(GetPlayerPed(nplayer)) > 101 then 
                    return cb(false)
                end
                
                local plyGroup = vRP.getUserGroupByType(user_id, "org")
                
                if not plyGroup or plyGroup == '' then 
                    return cb(false)
                end
                
                local nplyGroup = vRP.getUserGroupByType(nuser_id, "org")
                
                if not nplyGroup or nplyGroup == '' or nplyGroup ~= plyGroup then 
                    return cb(false)
                end
                
                vRPc._playAnim(source, false,{{"mini@cpr@char_a@cpr_def","cpr_intro"}},true)
                SetTimeout(30*1000, function()  
                    print(9)
                    if GetEntityHealth(GetPlayerPed(nplayer)) > 101 then 
                        return cb(false)
                    end
                    vRPc._stopAnim(source, false)
                    vRPc._setHealth(nplayer, 110)
                    vRPc._stopAnim(nplayer, false)
                    return cb(true)
                end)
                
            end
            TriggerClientEvent("Notify", source, "negado", "Nenhum jogador proximo.", 5)
            return cb(false)
        end
    },

    ["madeira"] = {
        index = "madeira",
        name = "Madeira",
        png = "madeira",
        weight = 2.5,
        type = "use"
    },

    ["dourado"] = {
        index = "dourado",
        name = "Dourado",
        png = "dourado",
        weight = 3.0,
        type = "use"
    },

    ["salmao"] = {
        index = "salmao",
        name = "Salmao",
        png = "salmao",
        weight = 1.0,
        type = "use"
    },

    ["podemd"] = {
        index = "podemd",
        name = "Pó de MD",
        png = "podemd",
        weight = 0.3,
        type = "use"
    },

    ["morfina"] = {
        index = "morfina",
        name = "Morfina",
        png = "morfina",
        weight = 0.3,
        type = "use"
    },

    ["lsd"] = {
        index = "lsd",
        name = "LSD",
        png = "lsd",
        weight = 0.5,
        type = "use",
        keep_item = true,
        func = OthersDrugs
    },

    ["anelroubado"] = {
        index = "anelroubado",
        name = "Anel",
        png = "anelroubado",
        weight = 0.1,
        type = "use"
    },

    ["lancaperfume"] = {
        index = "lancaperfume",
        name = "Lança Perfume",
        png = "lancaperfume",
        weight = 0.5,
        type = "use",
        keep_item = true,
        func = OthersDrugs
    },

    ["haxixe"] = {
        index = "haxixe",
        name = "Haxixe",
        png = "haxixe",
        weight = 0.5,
        type = "use"
    },

    ["m-tecido"] = {
        index = "m-tecido",
        name = "Tecido",
        png = "m-tecido",
        weight = 0.4,
        type = "use"
    },
    ["gatilho"] = {
        index = "gatilho",
        name = "Gatilho",
        png = "gatilho",
        weight = 0.2,
        type = "use"
    },

    ["m-corpo_ak47_mk2"] = {
        index = "m-corpo_ak47_mk2",
        name = "Corpo de AK47",
        png = "m-corpo_ak47_mk2",
        weight = 5.0,
        type = "use"
    },
}

if IsDuplicityVersion() then
    RegisterCommand('rscuba', function(source, args)
        local user_id = vRP.getUserId(source)
        if user_id then
            local ok = vRP.request(source, "Você deseja retirar a sua scuba?", 30)
            if ok and (GetEntityHealth(GetPlayerPed(source)) > 105) then
                if Remote.checkScuba(source) then
                    Remote._setScuba(source, false)
                    TriggerClientEvent('cancelando', source, false)
                    TriggerClientEvent("Notify", source, "negado",
                        "Você retirou sua scuba, não conseguimos recuperar ela houve um vazamento.", 5)
                else
                    TriggerClientEvent("Notify", source, "negado", "Você não possui scuba equipada.", 5)
                end
            end
        end
    end)
end



function itemBodyList(item)
    if Items[item] then
        return Items[item]
    end
end

function itemIndexList(item)
    if Items[item] then
        return Items[item].index
    end
end

exports("itemIndexList",itemIndexList)


function itemNameList(item)
    if Items[item] then
        return Items[item].name
    end
end


function itemImageList(item)
    if Items[item] then
        if Items[item].png then
            return Items[item].png
        end
        return Items[item].index
    end
end

function itemList(item)
    if Items[item] then
        return Items[item].name
    end
    return "Deleted"
end

function itemTypeList(item)
    if Items[item] then
        return Items[item].type
    end
end

function itemAmmoList(item)
    if Items[item] then
        return Items[item].ammo
    end
end

function itemWeightList(item)
    if Items[item] then
        return Items[item].weight
    end
    return 0
end


function formatNumber(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1-'):reverse())..right
end

function checkNumber(numero)
	local rows = vRP.query("vRP/getNumber", {telefone = numero} ) or nil
	if not rows[1] then
		return true
	end
end