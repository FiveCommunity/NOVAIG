--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local RANKINGS = {
    online = {},
    famous = {},
    richs = {},
    factions = {},
}

local finishDate = json.decode(LoadResourceFile(GetCurrentResourceName(), 'finishdate.json')) or false

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.requestMenu()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local identity = vRP.getUserIdentity(user_id)
    if not identity then return end

    local org = vRP.getUserGroupByType(user_id, "org")
	if (org == nil or org == "") then
		org = "Não possui"
	end

    local currentVips = {}
    for k, v in pairs(config.vipGroups) do
		if (vRP.hasGroup(user_id, v)) then
			currentVips[#currentVips + 1] = v
		end
	end

    local spouse = json.decode(identity.relacionamento)
	if (identity.relacionamento == '{}') then
		spouse = 'Solteiro'
	end

    local result = exports['oxmysql']:executeSync("SELECT avatarURL FROM smartphone_instagram WHERE user_id = ?", { user_id })
    local avatar = #result > 0 and result[1].avatarURL or nil
    
    return {
        id = user_id,
        age = identity.idade,
        name = ('%s %s'):format(identity.nome, identity.sobrenome),
        avatar = avatar,
        phone = identity.telefone,
        org = org,
        status = spouse.tipo or 'Solteiro',
        vips = currentVips,
        rankings = RANKINGS
    }
end

function RegisterTunnel.requestStore()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local makapoints = vRP.getMakapoints(user_id)

    return {
        makapoints = parseInt(makapoints) > 0 and parseInt(makapoints) or 0,
        remaingTime = (finishDate.time - os.time())
    }
end

function RegisterTunnel.buyPackage()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local makapoints = vRP.getMakapoints(user_id)
    if parseInt(makapoints)  == 0 then return end

    if makapoints > config.package.price then
        remCoins(user_id, config.package.price)

        for i = 1, #config.package.items do
            local item = config.package.items[i]
            vRP.execute("vRP/inserir_veh",{ veiculo = item.spawn, user_id = user_id, ipva = os.time(), expired = "{}" })
        end

        local identity = vRP.getUserIdentity(user_id)
        if not identity then return end
        
        TriggerClientEvent("chat:addMessage",-1,{args = { identity.nome.. ' '..identity.sobrenome, 'comprou o pacote (<b>'..config.package.title..')</b> com seus makapoints' }})

        TriggerClientEvent("Notify",source,"sucesso","Compra efetuada com sucesso.", 5)
        return true
    else
        TriggerClientEvent("Notify",source,"negado","Você não possui coins sufuciente.", 5)
    end

    return false
end

function RegisterTunnel.buyItem(data)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local makapoints = vRP.getMakapoints(user_id)
    if parseInt(makapoints)  == 0 then return end

    for i = 1, #config.stores do
        local item = config.stores[i]
        if item.name == data.name then
  
            if makapoints >= item.price then
                remCoins(user_id, item.price)
                vRP.execute("vRP/inserir_veh",{ veiculo = item.spawn, user_id = user_id, ipva = os.time(), expired = "{}" })


                
                local identity = vRP.getUserIdentity(user_id)
                if not identity then return end

                -- TriggerClientEvent('chat:addMessage',-1,{template='<div style="display:flex;align-items:center;justify-content:center;padding:10px;margin:5px 0;background: radial-gradient(126.79% 126.79% at 50% 100%, rgba(0, 80, 205, 0.6) 0%, rgba(0, 80, 205, 0) 100%), rgba(0, 0, 0, 0.1);border-radius: 5px;"><img width="32" style="float: left;" src="https://cdn.discordapp.com/attachments/844907458975105024/1094333097341890570/medal.png">&nbsp &nbsp<b>'..identity.nome.. ' '..identity.sobrenome..'</b>&nbsp resgatou o item (<b>'..item.spawn..')</b> com seus makapoints. </div>'})



                TriggerClientEvent("Notify",source,"sucesso","Compra efetuada com sucesso.", 5)
                return true
            else
                TriggerClientEvent("Notify",source,"negado","Você não possui coins sufuciente.", 5)
            end

            return false
        end
    end
    
    return false
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function remCoins(user_id, amount)
    local makapoints = vRP.getMakapoints(user_id)
    if parseInt(makapoints) == 0 then return end

    totalAmount = (makapoints - amount)
    if totalAmount < 0 then
        totalAmount = 0
    end

    vRP.setMakapoints(user_id,parseInt(totalAmount))
end


function FormatMoney(amount)
    local formatted = amount
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end

function generateRanks()
    local queryFactions = exports.oxmysql:executeSync('SELECT * FROM dm_ranks ORDER BY wins DESC LIMIT 10')
    local queryRichers = exports.oxmysql:executeSync('SELECT user_id, banco FROM vrp_user_identities ORDER BY banco DESC LIMIT 10;')
    local queryOnlines = exports.oxmysql:executeSync('SELECT user_id, time FROM lotusbox_hours ORDER BY time DESC LIMIT 10')
    -- local queryPopularity = exports.oxmysql:executeSync('SELECT si.user_id, COUNT(si.id) AS count FROM smartphone_instagram si INNER JOIN smartphone_instagram_followers sf ON si.id = sf.profile_id GROUP BY si.user_id ORDER BY count DESC LIMIT 10;')

    RANKINGS.online = {}
    RANKINGS.richs = {}
    RANKINGS.famous = {}
    RANKINGS.factions = {}
    
    -- for k, v in pairs(queryPopularity) do
    --     local identity = vRP.getUserIdentity(v.user_id)
    --     if identity then
    --         RANKINGS.famous[#RANKINGS.famous + 1] = {
    --             name = identity.nome,
    --             value = tonumber(v.count).." Follow"
    --         }
    --     end
    -- end
    
    for k,v in pairs(queryRichers) do
        local identity = vRP.getUserIdentity(v.user_id)
        if identity then
            RANKINGS.richs[#RANKINGS.richs + 1] = {
                name = identity.nome,
                value = '$'..FormatMoney(v.banco)
            }
        end
    end

    for k,v in pairs(queryOnlines) do
        local identity = vRP.getUserIdentity(v.user_id)
        if identity then
            local seconds = v.time
            local hours = math.floor(seconds / 3600) 
            local minutes = math.floor((seconds % 3600) / 60) 
            RANKINGS.online[#RANKINGS.online + 1] = {
                name = identity.nome,
                value = string.format("%02d Hrs e %02d Min", hours, minutes) 
            }
        end
    end

    for k,v in pairs(queryFactions) do
        RANKINGS.factions[#RANKINGS.factions + 1] = {
            name = v.org,
            value = v.wins
        }
    end

    SetTimeout(15 * 1000, generateRanks)
end

async(function()
    generateRanks()
end)

CreateThread(function()
    -- GERAR MES
    if not finishDate or (finishDate.time - os.time()) <= 0 then
        local actualMonth = parseInt(os.date('%m'))
        actualMonth = (actualMonth + 1)
        if actualMonth > 12 then actualMonth = 1 end

        local time = os.time({year = os.date('%Y'), month = actualMonth, day = 1})
        finishDate = {
            time = time
        }

        SaveResourceFile(GetCurrentResourceName(), 'finishdate.json', json.encode({time = time}), -1)
    end
end)

