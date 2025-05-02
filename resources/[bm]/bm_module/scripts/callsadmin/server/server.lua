------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QUERYS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("bm_module/chamados/getAllCalls", "SELECT * FROM bm_chamados")
vRP._prepare("bm_module/chamados/addCalls", "REPLACE INTO bm_chamados(user_id,qtd) VALUES(@user_id, @qtd)")
vRP._prepare("bm_module/chamados/topCalls", "SELECT * FROM bm_chamados ORDER BY qtd DESC;")
vRP._prepare("bm_module/chamados/wipeTable", "DELETE FROM bm_chamados")

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local calls = {
    cache = {}
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function calls:generateCache()
    local query = vRP.query("bm_module/chamados/getAllCalls", {})
    for i = 1, #query do
        self.cache[query[i].user_id] = query[i].qtd
    end
end

function calls:updateUserQtd(user_id)
    if not self.cache[user_id] then self.cache[user_id] = 0 end

    self.cache[user_id] += 1
    vRP._execute("bm_module/chamados/addCalls", { user_id = user_id, qtd = self.cache[user_id] })
end

function calls:resetUsers()
    self.cache = {}
    vRP._execute("bm_module/chamados/wipeTable", {})
end

function calls:allCalls()
    local query = vRP.query("bm_module/chamados/topCalls", {})
    return query
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMANDOS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mchamados', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then

        if vRP.hasPermission(user_id, callsConfig.main['permission']) then
            local tops = calls:allCalls()
            if #tops > 0 then
                local t = ""
                for i = 1, #tops do
                    t = t.. "```cs\nUSER_ID: "..tops[i].user_id.. " • Chamados: "..tops[i].qtd.."```"
                end
                
                sendToDiscord("", { { ["color"] = 6356736, ["title"] = "** Sistema de Chamados **", ["description"] = "\n**TOP LIST:**".. t, ["footer"] = { ["text"] = "© Mirt1n Store", }, } })
                TriggerClientEvent("Notify",source,"sucesso","Lista Enviada no discord..")
            else
                TriggerClientEvent("Notify",source,"negado","Nenhum chamado encontrado...")
            end
        end
    end
end)

RegisterCommand('rchamados', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, callsConfig.main['permission']) then
            calls:resetUsers()
            TriggerClientEvent("Notify",source,"sucesso","Lista Limpa..")
        end
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
exports("addCall",function(...) 
    calls:updateUserQtd(...)
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    calls:generateCache()
end)