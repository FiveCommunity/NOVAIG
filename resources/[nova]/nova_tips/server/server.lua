local Services <const> = {
    cache = {}
}

function API.GetIdentity()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local identity = vRP.getUserIdentity(user_id)
    local result = exports['oxmysql']:executeSync("SELECT avatarURL FROM smartphone_instagram WHERE user_id = ?", { user_id })
    
    local fullName = identity and (identity.nome .. ' ' .. identity.sobrenome) or 'Desconhecido'

    return {
        name = fullName,
        id = user_id,
        avatar = #result > 0 and result[1].avatarURL or nil
    }
end

function API.Call(type, description)
    if not Config.Services[type] then return end

    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local plyCoords = GetEntityCoords(GetPlayerPed(source))
    local x,y,z = table.unpack(plyCoords)

    if type == "staff" then
        type = "god"
    end

    ExecuteCommand("call "..type)

    -- if Services.cache[user_id] and Services.cache[user_id][type] then
    --     TriggerClientEvent("Notify", source, "negado", "Você já possui um chamado em andamento.", 5000)
    --     return 
    -- end

    -- Services.cache[user_id] = Services.cache[user_id] or {}
    
    -- SetTimeout(10 * 60 * 1000, function()
    --     if Services.cache[user_id] and Services.cache[user_id][type] then
    --         Services.cache[user_id][type] = nil
    --         if next(Services.cache[user_id]) == nil then
    --             Services.cache[user_id] = nil
    --         end
    --         TriggerClientEvent("Notify", source, "negado", "Seu chamado expirou pois ninguém aceitou.", 5000)
    --     end
    -- end)

    -- local function handleAcceptedCall(player, userId, nidentity)
    --     if not Services.cache[user_id][type] then
    --         Services.cache[user_id][type] = true
            
    --         if type == "staff" then
    --             TriggerClientEvent("Notify", source, "sucesso", 
    --                 ("O Membro da staff <b> %s %s </b> aceitou o seu chamado.."):format(
    --                     nidentity.nome, 
    --                     nidentity.sobrenome
    --                 ), 5)
    --             vRPC._teleport(player, x, y, z)
    --         else
    --             TriggerClientEvent("Notify", source, "sucesso", "O seu chamado foi aceito com sucesso.", 5000)
    --             TriggerClientEvent("Notify", player, "sucesso", "Chamado aceito com sucesso.", 5000)
    --             Remote.setWaypoint(player, x, y, z)
    --         end
    --     else
    --         TriggerClientEvent("Notify", player, "negado", "Este chamado ja foi aceito por outro usuário.", 5000)
    --     end
    -- end

    -- local users = vRP.getUsersByPermission(Config.Services[type])
    -- for _, userId in pairs(users) do
    --     async(function()
    --         local player = vRP.getUserSource(parseInt(userId))
    --         if player then
    --             local requestMsg = ("Você deseja aceitar o chamado de %s?\nDescrição: %s"):format(user_id, description)
    --             if vRP.request(player, requestMsg, 30) then
    --                 local nidentity = vRP.getUserIdentity(parseInt(userId))
    --                 handleAcceptedCall(player, parseInt(userId), nidentity)
    --             end
    --         end
    --     end)
    -- end
end

AddEventHandler("playerDropped", function(reason)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    if Services.cache[user_id] then
        Services.cache[user_id] = nil
    end
end)