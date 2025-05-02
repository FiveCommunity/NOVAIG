local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
atl = {}
Tunnel.bindInterface("ranking_chamados",atl)
	
local Ranking = {}

vRP.prepare('apz/Ranking', 'SELECT * FROM bm_chamados ORDER BY qtd DESC')

function atl.ranking() 
    local source = source
    local queryRanking = vRP.query("apz/Ranking", {})
    for k in pairs(queryRanking) do
        local playerId = queryRanking[k].user_id
        local playerIdentity = vRP.getUserIdentity(parseInt(playerId))
        if playerIdentity then
            local user_name = playerIdentity.nome..' | '..playerId
            table.insert(Ranking, { name = user_name, qtd = queryRanking[k].qtd })
        end
    end 

    return Ranking
end

function atl.checkpermranking()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.permissao") or vRP.hasPermission(user_id, "diretor.permissao") then
        return true
    else
        TriggerClientEvent("Notify",source,"negado","Você não tem permissão a este comando!")
        return false
    end
end