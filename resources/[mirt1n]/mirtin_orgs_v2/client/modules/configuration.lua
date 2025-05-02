RegisterNUICallback('GetPermissions', function(data, cb)
    local permissions = vTunnel.getPermissions(data.roleEdit)
    local t = {}
    for perm, status in pairs(permissions) do
        if perm ~= 'leader' then
            if not Config.defaultPermissions[perm] then print(perm) end
            t[perm] = {
                name = Config.defaultPermissions[perm].name,
                description = Config.defaultPermissions[perm].description,
                status = status
            }
        end
    end
    cb(t)
end)

RegisterNUICallback('SetPermissions', function(data, cb)
    local t = {}
    for perm, v in pairs(data.permissions) do
        t[perm] = v.status
    end
    cb(vTunnel.updatePermissions(data.role, t))
end)

RegisterNUICallback('SetRadio', function(data, cb)
    cb(vTunnel.updateRadio(data))
end)

RegisterNUICallback('SetPreset', function(data, cb)
    cb(vTunnel.updatePreset(data))
end)

RegisterNUICallback('SetConfig', function(data, cb)
    if (not data.discord:find('https://')) then
        return print('Discord: Insira um URL Valido Insira um URL Valido Exemplo: https://discord.gg/MPm3Pptfn5.')
    end

    -- if (not data.logo:find('https://')) then
    --     return print('Logo: Insira um URL Valido Exemplo: https://mirtin-store.com/imagem.png.')
    -- end

    cb(vTunnel.updateConfig(data))
end)