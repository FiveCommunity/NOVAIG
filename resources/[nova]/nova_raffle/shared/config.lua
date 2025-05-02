Config = {}

Config.Commands = {
    MainCommand = 'rifa',
    ConfigCommand = 'criarrifa',
    ResetCommand = 'resetarrifa',
    FinishCommand = 'finalizarrifa',
}

Config.BaseImageURL = 'https://images.lotusgroup.dev/inventario_cda/'

Config.StaffPermissions = {
    { permissionType = 'group', permission = 'TOP1' },
    { permissionType = 'perm', permission = 'developer.permissao' },
}

Config.Items = {
    { title = 'Radio', description = 'Um celular comum.', image = Config.BaseImageURL .. 'radio.png', rewardType = 'item', reward = { item = 'radio', amount = 1 } },
    { title = 'Kuruma', description = 'Um carro comum.', image = Config.BaseImageURL .. 'kuruma.png', rewardType = 'vehicle', reward = { item = 'kuruma' } },
    { title = 'VIP', description = 'Um VIP 2025.', image = Config.BaseImageURL .. 'ukiLrRiB8zopYJdW4XtDNI0OeSXQ6NvJooms6NpyrtgrJysThI0pMsQqzhwiAo3z.png', rewardType = 'group', reward = { item = 'Vip2025' } },
    { title = 'Dinheiro 100k', description = 'Uma quantidade de dinheiro.', image = Config.BaseImageURL .. 'money.png', rewardType = 'money', reward = { amount = 100000 } },
}

Config.RewardsTypes = {
    ['vehicle'] = {
        label = 'Veículo',
        reward = function(userId, reward)
            return exports.oxmysql:execute('INSERT IGNORE INTO vrp_user_veiculos(user_id, veiculo) VALUES(?, ?)', { userId, reward.item })
        end
    },
    ['group'] = {
        label = 'Grupo',
        reward = function(userId, reward)
            exports.hydrus:schedule(userId, { 'ungroup', userId, reward.item }, 86400 * 30)
            local source = vRP.getUserSource(userId)
            if source then
                return vRP.addUserGroup(userId, reward.item)
            end

            local query = exports.oxmysql:singleSync('SELECT * FROM vrp_user_data WHERE user_id = ? AND dkey = ?', { userId, 'vRP:datatable' })
            if query then
                local data = json.decode(query.dvalue)
                if data.groups then
                    if not data.groups[reward.item] then
                        data.groups[reward.item] = true
                        exports.oxmysql:execute('UPDATE vrp_user_data SET dvalue = ? WHERE user_id = ? AND dkey = ?', { json.encode(data), userId, 'vRP:datatable' })
                    end
                end
            end
        end
    },
    ['item'] = {
        label = 'Item',
        reward = function(userId, reward)
            return vRP.giveInventoryItem(userId, reward.item, reward.amount, true)
        end
    },
    ['money'] = {
        label = 'Dinheiro',
        reward = function(userId, reward)
            return vRP.giveBankMoney(userId, reward.amount)
        end
    },
}