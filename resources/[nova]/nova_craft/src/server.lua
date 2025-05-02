---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VRP
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Groups = module("cfg/groups").groups
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNEL
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterTunnel = {}
Tunnel.bindInterface(GetCurrentResourceName(), RegisterTunnel)
vTunnel = Tunnel.getInterface(GetCurrentResourceName())
local groupsMaxItems = {}

local Weebhooks = {
    -- Dominacao
    ['Dominacao [MUNICAO]'] = 'https://discord.com/api/webhooks/1315131674090279063/2VNRt8AAyHHbIy16xmMIT1SAmy8t9r4O-R4S4Ok7PJNcRWHgiqlIXndXqdFaBtYsBQ3e',
    ['Dominacao [DESMANCHE]'] = 'https://discord.com/api/webhooks/1315131739001327686/mG-RCmh3EtRNSx4Rpi87JTeR6229wNcA3WEd7v-a-nV9lDzD5LvElzY6fmqXGu6kGmFH',
    ['Dominacao [ARMAS]'] = 'https://discord.com/api/webhooks/1315131793715892264/Gqsd58BbUUYvQhcjtc5rU3bC-lgnDozRdiAwgIW3Gla3Y2OyVghqSLbIW_EWoeRwWDH9',
    ['Dominacao [DROGAS]'] = 'https://discord.com/api/webhooks/1315131845368610887/YCWryDvFtmYGz1VrHkO6mhrHPSt1lUngqcVXfJKzfnTgf-FtvswN12fFpFbntuodzAZX',
    ['Dominacao [LAVAGEM]'] = 'https://discord.com/api/webhooks/1315131912448249948/AQTpnu2RZzLQkMGis-zdz6N_BUp8zue8wS4OmOzz11-m5oP4a3paVw9mG1svG6uBipwU',

    -- Armas
    ['Hospicio'] = 'https://discord.com/api/webhooks/1315114059296936057/NUowUdh7PVkQa-SHR4AEE0CI72qtn_-Mrfbk0MV_Fku6aVS2tvS8sUPSfcfbsy8FI85e',
    ['Inglaterra'] = 'https://discord.com/api/webhooks/1315114176246579200/aTNCyr23cWEHz84HYMeuYl0Xin7W9JnoZDKQEZqmfB4WBone7ZWxFAJRCXDj_MC1-FH_',
    ['CV'] = 'https://discord.com/api/webhooks/1316409790016258119/rFUdNLugFRNM-UC-gFcUc51EYsYwWnt7PjeXCTcqcw47RcrPLk07IfvDd7U7E5kHJdjs',
    ['Vaticano'] = 'https://discord.com/api/webhooks/1315115494226919495/adkPXkx3pOLvb8ypvaq7shKhBgnXEOquL9drjbvvn5hLb3YJ3dj6W4FqfWnqgEvM9hA1',
    ['Grota'] = 'https://discord.com/api/webhooks/1315115601353637928/B7qGOxcwKJNs1LdYf2Tyy0yAKEhX7plg3GzkopmVD0CMAmZFipHjrqZ6M5hI_QbgSr7J',
    ['Magnatas'] = 'https://discord.com/api/webhooks/1315115725618155521/8QqhuSuC2NUJEAX-j_ZeI0N_GQr8CMrSJ8887PE9mDs4Sqtof0Aer6ALscOY-R-1qqYD',
    ['Milicia'] = 'https://discord.com/api/webhooks/1315115851388551280/xVmZAgzRGjq9V1MXkLF0guKs5r-yT4wULXBjMwldj5BIkGxuOO24F4luq-A98ys28dNf',
    ['Mafia'] = 'https://discord.com/api/webhooks/1315116101658742886/Lzy1vfFqjoWd0FKCUjLgMVK_Xz1Kotp005m0igqXY7gZqs0NLY7g-QeIIM7M_hO4AR7P',
    ['Corleone'] = 'https://discord.com/api/webhooks/1315116230570414182/LrstgdC65mPrZWZTU9VIwCIiQBC7MzZLO0J4PnhaYeTjOTdrr1aCFZAwfZJu4wsGxyMA',

    -- Municao
    ['Okayda'] = 'https://discord.com/api/webhooks/1315117151526453308/zraDlRQslYKDgsxXvn1m5Uj_u-XvgicYEl9T-e6w4GS4qbVG0PeGRKJflEnmqy_Zicvm',
    ['Korea'] = 'https://discord.com/api/webhooks/1315117195348541521/CZFDu9tscP3gefF6hNC54VYJU1L5xKNrygF2EZUfzvIhSbXoke6UTIgqKTbrIWVLQJmC',
    ['Egito'] = 'https://discord.com/api/webhooks/1315117240936566814/2fyi3we8u8kVWq-07-o0FxcESDz363Eaz4DT0InDILnvSLOb_rfyuKZXtITiSqTM0CfI',
    ['Colombia'] = 'https://discord.com/api/webhooks/1315117287606583407/NCWyTrVar40ugMBxN0oRdO8kLmpgdyedzneLvUS2RRiZcCEwD8FCeVlV2bY45uocoOjH',
    ['Medellin'] = 'https://discord.com/api/webhooks/1315117334423273492/DahVNVde0Yu6EWSnp9NqDE71-XpD75LlISn3MSzWfnbJ0JkVlyO8ncvoL3u9gXYiX17Z',
    ['Franca'] = 'https://discord.com/api/webhooks/1315117511003471962/LVfQKWb866gdwUbAO4GBRYMTq7CsdlMnuHqdygiwyKXQ2hxBwV0FuMeVsneRqUUMPmIL',
    ['Mexico'] = 'https://discord.com/api/webhooks/1315118047132127242/2ZeFDmtQrAZw6qGs6cj-UY5v8lvB813iHTPmq85BA5pqh2Ob-fv443JP9vn2jY9TGV9g',
    ['Yakuza'] = 'https://discord.com/api/webhooks/1315122040868573306/avm1fuSVh3l8oIL5MINcRAE2lqCyLqn2uWwSSsKb94RTUoICbS75lWu9qTRDUpMO_H0T',
    ['Pcc'] = 'https://discord.com/api/webhooks/1315124127920689214/J_sJ22mk4WHii0bJEnKJmXlWhSo--4U0RPV9SP6tWneU8gGJ4Om503twfkXxos9V4PA2',
    ['Bratva'] = 'https://discord.com/api/webhooks/1315124564786679858/N6uVUhWTJqzR9qQyvkAP3JwsOc8gcM_lVNOqjLlrdcr7Aq80kR_4AyET2EIS0TS1QMSD',

    -- Lavagem
    ['Bahamas'] = 'https://discord.com/api/webhooks/1315128716942377011/G6u-nnvbA5jkcCnRx5vqChhHX7BK7wREY6YEvh3EjwCPRPxXoj-XAbdwpKSmp5Yfqino',
    ['Cassino'] = 'https://discord.com/api/webhooks/1316411147242438706/BGwf4IlO3zHXjZcWi7OXyuDgX6lXEkCCKgH3djP6DTTSzXpoiUVIdTzpev6DxJOQEJDg',
    ['Sete'] = 'https://discord.com/api/webhooks/1315129445753028678/GG0-bnrf1e7XjQhBCQJd6Cu-3LBdLN0bAdzUCl_RRcf2WSKoMXzzsp4vq1MBPpHyP1AO',
    ['Anubis'] = 'https://discord.com/api/webhooks/1315129535791890442/ad__DTY44DQxzdIyu49wfdShCYFIyBfMU3FO_q9za1atUcqWB8n-i07Fokt7clzfWAd5',
    ['Anonymous'] = 'https://discord.com/api/webhooks/1315129633263452160/ntpiCNPhNSYoXojKVAizybwYy_oVMoMv-AWcM7ebaRcekOxMFZfepeloHAtZ0P16t2S5',
    ['Lux'] = 'https://discord.com/api/webhooks/1315129728713359470/lKrtrsn-fOGMayJu0RvOgaLRjQrMOMmTeAAGjvvnzUEtJjWu1t59UQn_TK8X5gSgI_t-',
    ['Tequila'] = 'https://discord.com/api/webhooks/1315129822065725520/4n1X1BQPz4rYre01mlBDPLakUsGSfZJDP81snhY3jo023lg6nnSsrTJ22CLU3Wl1u8hA',

    -- Desmanche
    ['Cohab'] = 'https://discord.com/api/webhooks/1315116009707012106/KRgtsEx8wm2PZoQUFKY75xEoleL8_mopLUOh2iyAdcpzhAzAN3Yq2TNT98MOUu-eXkmX',
    ['CDD'] = 'https://discord.com/api/webhooks/1316411254054584391/NeE17p-UtZ0myEpx9O8Rn4SVLT6-hLmSwtlGZOwhEpZVeRobwNjrcn18DFDqFcteAycz',
    ['Motoclube'] = 'https://discord.com/api/webhooks/1316411559563497504/sWHqupKKQdZUiJdBdHdtqkJdhZINJSJ_G-1SZrP1fOoJdB7ErMmn83gUWLhKDDPnyvuS',
    ['Lacoste'] = 'https://discord.com/api/webhooks/1315117231528611890/ap47jzBIyfXRrCF4L6dWyWFDhLy7E5UYDEkn3xJY-DYlu6XdA7gUWG-loL0CeSXZeBs6',
    ['Bennys'] = 'https://discord.com/api/webhooks/1315118651086602320/gVuF_9mAIOBthA7HlSnSTVK5X5geyfoEj07PeCtgfEQBGmhE2NqpuZM6lo9W6kb9X_Nq',
    ['Roxo'] = 'https://discord.com/api/webhooks/1315119255028498482/wt1W8Rxy36DKJGOIBiTcvv2tsDZTeBgaHeWi1q7DX52_Wt-0bOmoCSabTu3Qge1xqF8K',
    ['Hellsangels'] = 'https://discord.com/api/webhooks/1315120524031954976/V9-B4GIoCI1qAEEaPB7U8tUVeZH1wynhQk_lpOIjYWbphZ8BSOCojdEyQljhsVxOESMC',
    ['Escocia'] = 'https://discord.com/api/webhooks/1315121466823675904/p0gN2xAc7Dm3_rUzV-G_ZsNPPmIYe8WxhGwYNR-IEpZj1ijUiB__rWx-BO4JIO47nQeh',
    ['Hellsangels'] = 'https://discord.com/api/webhooks/1336743905642938500/NKICiJoHjLkd9tc-TAfCKo6foA01dK_k4ClhtYJbczEq5RZMDBg6wA-w4p4hoBjv4k4R',

    -- Drogas
    ['Elements'] = 'https://discord.com/api/webhooks/1315118996034687047/IkpbF921KfxoMYnJQY-SEFZnWP3c4Mzz6FH14Ycd3KlbhrNYOXk9w9GGNZw67Hm0mACo',
    ['Sindicato'] = 'https://discord.com/api/webhooks/1315119879858421821/EQaKOWC6qzI0q5b4JBwUZZqg3VEQTs-o3hLz_COeCdZriUeDWP-0RWsP4rinldWlCerZ',
    ['Russia'] = 'https://discord.com/api/webhooks/1315120206128873492/gmr8BXyHg0sKldm0mgEcqiTLgcEcWe0ATezRpH2YzM9xIQJdreSTEISA0REyJbvoeQ2e',
    ['China'] = 'https://discord.com/api/webhooks/1315120906489561128/VL3aA5DqjWsoFf2CuEridyOH0EsFdwPSXm5s4weF1EHA1ZmPsNt7_0YqEdSEbV_XBXAI',
    ['Grecia'] = 'https://discord.com/api/webhooks/1315121685048852541/qZoc2J842095TWuFWcu9pV_ARFvDUREnZ7OWquFvGpkZKl3ohoDtfZ9yYmzWwBQG4J-2',
    ['Irlanda'] = 'https://discord.com/api/webhooks/1315122275170779166/N-XyZSFTHxemcH4vaTj9EeYQJlaSPKZxIiCHtKD5b7jSfaCr4e8zGOFx6sbZ4aCUM8gs',
    ['Taliba'] = 'https://discord.com/api/webhooks/1315122586014978140/1A1JAg3i8qexda6m6E6cDp5bomk9f0ZS3xjBvJqR-AHdidwV19wu0JFXoCFybTDQjXU4',
    ['Medusa'] = 'https://discord.com/api/webhooks/1315122939946860565/Js-8DfIV_XNSmlJXDE3e9u4pSQzx4hr0Bh0SS2NxQ3lqwaJdnHXKbJun40bSI4JOweqV',
    ['Abutres'] = 'https://discord.com/api/webhooks/1315123181241106504/VtHzmWSmzIXnZaFSsfw8MgKXJzj10Q6EF4qQUJiwGpaAGnOG_-RYrcLnwUeM8czZwujm',
    ['Italia'] = 'https://discord.com/api/webhooks/1315123496396783646/w_tdkNYWaiIl4G2pqPB5zdWUguPvg3HeYi9sQiDBWFRVZ-npqlu0yO0H7ujP8dQQnrwe',
    ['Psico'] = 'https://discord.com/api/webhooks/1315123791244038195/ufG1eN74PmunLcFFmyvsK8VmNnHQfGNWTSWHN4b9kaEfNX6cbJC528p9zFzB7UCdIEMX',
    ['Roxos'] = 'https://discord.com/api/webhooks/1323090898157830214/34c6ND_ce3QgK_9P6-UJBqsDLNKGCv6v5ShD5iQeaH4iljJvpNl9i4WpReFKPfsEb_7W',

    -- Legal
    ['Hospital'] = 'https://discord.com/api/webhooks/1340976439771660308/3fzUTkrQRjLvEA9NxlDIZRUuHadX7snPgtdDEMmFMtq_kKLgq0Kk3Jab7Tusk3V-7xJJ',
}

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Craft = {
    List = {},
    Users = {}
}
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS CRAFT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Craft:StartPlayerCraft(ply, craft)
    self.Users[ply.source] = true
    if not vRP.getInventoryMaxWeight(ply.user_id) then
        return print('not vRP.getInventoryMaxWeight(ply.user_id) ', ply.user_id)
    end
    if vRP.computeInvWeight(ply.user_id)+vRP.getItemWeight(craft.item)*parseInt(craft.amount) <= vRP.getInventoryMaxWeight(ply.user_id) then
        vTunnel._BlockAnims(ply.source, true, craft.anim)
        TriggerClientEvent("Progress", ply.source, craft.time)
        TriggerClientEvent("Crafting:updateProgress", ply.source, craft.time)
        
        SetTimeout(craft.time * 1000, function()
            self.Users[ply.source] = false
            vTunnel._BlockAnims(ply.source, false)

            local itemCraft = craft.item    
            local itemName = exports.vrp:itemIndexList(itemCraft)
            if itemName == nil or itemName == "Deleted" then 
                itemName = exports.vrp:itemIndexList(itemCraft:lower())
            end

            if craft.maxItems then
                if not groupsMaxItems[craft.org] then
                    groupsMaxItems[craft.org] = { [itemName] = 0 }
                end

                if (groupsMaxItems[craft.org][itemName] + craft.amount) > craft.maxItems then
                    TriggerClientEvent("Notify",ply.source,"negado","Limite de produção de <b>"..itemName.."</b> atingido.", 5)
                    return
                end

                groupsMaxItems[craft.org][itemName] = groupsMaxItems[craft.org][itemName] + craft.amount
            end
            vRP.giveInventoryItem(ply.user_id, itemName, craft.amount, true)

            corpoHook = { 
                { 
                    ["color"] = 6356736, 
                    ["title"] = "**".. ":man_construction_worker: | Craft de Item " .."**\n", 
                    ["thumbnail"] = { ["url"] = 'https://media.discordapp.net/attachments/980387548721455134/1096229393891856466/CONEXÃO-01_2.png?width=867&height=662' }, 
                    ["description"] = "**USER_ID:**\n```cs\n"..ply.user_id.."```\n**CRAFTOU:** ```css\n".. craft.item .." " .. parseInt(craft.amount) .."x```\n**MESA:**\n ```cs\n"..craft.org.."```", 
                    ["footer"] = { ["text"] = "© FIVE GROUP", }, 
                } 
            }
            sendToDiscord(Weebhooks[craft.org], corpoHook)
 
        end)
    else
        self.Users[ply.source] = false
        TriggerClientEvent("Notify",ply.source,"negado","Mochila cheia.", 5)
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TUNNELS CRAFT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- function RegisterTunnel.checkOpenCraft(id)
--     local source = source
--     local user_id = vRP.getUserId(source)
--     if not user_id then return end
    
--     -- CHECANDO SE TEM DOMINAÇÃO
--     local hasDominas = CraftConfig.Tables[id].Config.hasDominas or false
--     if hasDominas then
--         local data = exports['dm_module']:GetUserDomination(user_id)
--         if not data then 
--             TriggerClientEvent("Notify",source,"negado","Sua organização não dominou essa area.")
--             return false
--         end

--         if hasDominas == data.zone then
--             return true
--         end
--     else
--         -- CHECANDO SE TEM PERMISSAO
--         local Permission = CraftConfig.Tables[id].Config.permission
--         if Permission and vRP.hasPermission(user_id, Permission) then
--             return true
--         end
--     end

--     TriggerClientEvent("Notify",source,"negado","Você não possui permissão para acessar.")
--     return false
-- end


local minMembers = {
    ['fArmas'] = 1,
    ['fMunicao'] = 1,
}

local minOrgs = {
    ['Grota'] = 1,
}


function RegisterTunnel.checkOpenCraft(id)
    local source = source
    local user_id = vRP.getUserId(source)
    local Permission = CraftConfig.Tables[id].Config.permission
    if not user_id then return end

    -- CHECANDO SE TEM DOMINAÇÃO
    local hasDominas = CraftConfig.Tables[id].Config.hasDominas or false
    if hasDominas then
        local userOrg = vRP.getUserGroupOrg(user_id)
        if hasDominas == 'Geral' then
            if GlobalState.dominationOwner == userOrg then 
                return true
            end

            TriggerClientEvent("Notify",source,"negado","Sua organização não dominou essa área.")
            return false
        end

        local hasNovat = string.find(vRP.getUserGroupByType(user_id, "org"), "Novato")
        if hasNovat then
            TriggerClientEvent("Notify",source,"negado","Você não pode acessar essa bancada..")
            return false
        end

        local data = exports['dm_module']:GetUserDomination(user_id)
        if not data then
            TriggerClientEvent("Notify",source,"negado","Sua organização não dominou essa área.")
            return false
        end

        local isZoneDominated = false
        for _, zoneData in ipairs(data.zones) do
            if hasDominas == zoneData.zone and userOrg == zoneData["orgName"] then
                isZoneDominated = true
                break
            end
        end

        if isZoneDominated then
            if Permission and vRP.hasPermission(user_id, Permission) then
                return true
            end

            TriggerClientEvent("Notify",source,"negado","Você não possui permissão para acessar.")
            return false
        else
            TriggerClientEvent("Notify",source,"negado","Sua organização não dominou essa área.")
            return false
        end
    end
 
    -- CHECANDO SE TEM PERMISSAO
    if Permission and vRP.hasPermission(user_id, Permission) then
        
        -- VALIDAR QUANTIDADE DE MEMBROS PARA CRAFTAR
        local plyType,plyOrg = GetGroupType(user_id)
        if minOrgs[plyOrg] then
            local perm = vRP.getUsersByPermission('perm.'..plyOrg:lower())
    
            if #perm < minOrgs[plyOrg] then
                TriggerClientEvent("Notify",source,"negado","Você precisa de "..#perm.."/"..minOrgs[plyOrg].." membro(s) online conseguir craftar..",6000)
                return
            end
        end

        if minMembers[plyType] then
            local perm = vRP.getUsersByPermission('perm.'..plyOrg:lower())
    
            if #perm < minMembers[plyType] then
                TriggerClientEvent("Notify",source,"negado","Você precisa de "..#perm.."/"..minMembers[plyType].." membro(s) online conseguir craftar..",6000)
                return
            end
        end

        local hasNovat = string.find(vRP.getUserGroupByType(user_id, "org"), "Novato")
        if hasNovat then
            TriggerClientEvent("Notify",source,"negado","Você não pode acessar essa bancada..")
            return false
        end
    
        return true
    end

    TriggerClientEvent("Notify",source,"negado","Você não possui permissão para acessar.")
    return false
end

function GetGroupType(user_id)
    local plyGroup = vRP.getUserGroupByType(user_id, "org")
    if plyGroup == "" and not Groups[plyGroup] then return false end
    
    return (Groups[plyGroup]._config and Groups[plyGroup]._config.orgType or false), (Groups[plyGroup]._config and Groups[plyGroup]._config.orgName or false)
end

function RegisterTunnel.requestCraft(id)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local myOrg = vRP.getUserGroupOrg(user_id)
    if not myOrg then return end

    local StorageItens = json.decode(vRP.getSData('armazem:'..myOrg)) or {} 
    local FormatItems = {}
    for item,amount in pairs(StorageItens) do
        FormatItems[#FormatItems + 1] = {
            item = exports["vrp"]:itemNameList(item),
            amount = amount
        }
    end

    local listBuyeds  = Shops
    local responseList = json.decode(vRP.getSData("purchasedStorage:"..myOrg)) or {}
    if responseList and responseList.Buyeds then 
        for k,v in pairs(responseList.Buyeds) do 
            local Buyed = parseInt(k)
            if listBuyeds[Buyed] then 
                listBuyeds[Buyed].buyed = true 
            end
        end
    end

    return Craft.List[id] or {},FormatItems,listBuyeds
end

function RegisterTunnel.productionList(List)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local myOrg = vRP.getUserGroupOrg(user_id)
    if not myOrg then return end

    -- ARMAZEM
    local Storage = CraftConfig.Storage[myOrg]
    if not Storage then 
        return 
    end

    local returnStatus = true 
    local StorageItens = json.decode(vRP.getSData('armazem:'..myOrg)) or {}


    for index,__ in pairs(List) do 
        for _,v in pairs(List[index].requires) do 
            if not StorageItens[v.item] or (StorageItens[v.item] and StorageItens[v.item] < v.amount) then 
                returnStatus = false 
            end

        end
    end

    return returnStatus
end

function RegisterTunnel.craftingList(Org,List)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    
    local myOrg = vRP.getUserGroupOrg(user_id)
    if not myOrg then return end

    if Craft.Users[source] then
        return false,TriggerClientEvent("Notify",source, "negado","Você já está fabricando um item.")
    end

    -- ARMAZEM
    local Storage = CraftConfig.Storage[myOrg]
    if not Storage then 
        return 
    end

    local StorageItens = json.decode(vRP.getSData('armazem:'..myOrg)) or {}
    local StorageList = Storage.List
     
    local closeInterface = false
    for index,table in pairs(List) do 

        local hasBoostPistolDomination = exports['nova_dominacao_pistol']:isBoostDominationPistol(myOrg)

        local NecessarityItems = {}
        for k, v in pairs(Table.Itens[index].requires) do
            if hasBoostPistolDomination then
                local reducedAmount = math.floor(v.amount * 0.9)
                NecessarityItems[v.item] = reducedAmount * amount
            else
                NecessarityItems[v.item] = v.amount * amount
            end
        end
        
        local ErrorMessage = ""
        local StartCraft = true
        for item,amount in pairs(NecessarityItems) do
            if not StorageItens[item] then StorageItens[item] = 0 end

            if StorageItens[item] < amount then
                ErrorMessage = ErrorMessage.. ("<br>Item <b>%s</b> quantidade <b>%s/%s</b>"):format(exports["vrp"]:itemNameList(item), StorageItens[item], amount)
                StartCraft = false
            end

            Citizen.Wait(10)
        end

        if not StartCraft then
            TriggerClientEvent("Notify",source, "negado","O Armazem não possui: <br>"..ErrorMessage)
            return false
        end

        -- if not closeInterface then
        --     TriggerClientEvent("Crafting:closeInterface",source) 
        --     closeInterface = true 
        -- end

        if table.maxItems then
            if not groupsMaxItems[myOrg] then
                groupsMaxItems[myOrg] = { [table.item] = 0 }
            end

            if (groupsMaxItems[myOrg][table.item] + table.customAmount * (table.amount or 1)) > craft.maxItems then
                TriggerClientEvent("Notify",source,"negado","Limite de produção de <b>"..table.item.."</b> atingido.", 5)
                return
            end
        end
        
        if vRP.computeInvWeight(user_id)+vRP.getItemWeight(table.item)*parseInt(table.customAmount * (table.amount or 1)) <= vRP.getInventoryMaxWeight(user_id) then
            for item,amount in pairs(NecessarityItems) do
                StorageItens[item] -= amount
                if StorageItens[item] <= 0 then 
                    StorageItens[item] = 0 
                end
            end

            vRP.setSData('armazem:'..myOrg, json.encode(StorageItens))

            Craft:StartPlayerCraft(
                { 
                    source = source, 
                    user_id = user_id 
                }, 
                {
                    item = table.item,
                    org = myOrg,
                    amount = table.customAmount * (table.amount or 1),
                    time = (table.time * (amount or 1)),
                    anim = table.anim,
                    maxItems = table.maxItems or nil
                }
            )
         

            Citizen.Wait(parseInt(table.time * 1000))
            TriggerClientEvent("Crafting:updateQueue",source,index)
        end
    end
    
    return true 
end

-- function RegisterTunnel.requestToQueue(Lis)

function RegisterTunnel.buyMaterial(Reference)
    local purchaseIndex = 0 
    for k,v in pairs(Shops) do 
        if v.amount == Reference then 
            purchaseIndex = k 
            break 
        end
    end

    if purchaseIndex == nil or purchaseIndex == 0 then 
        return 
    end


    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end
    


    local myOrg = vRP.getUserGroupOrg(user_id)
    if not myOrg then return end


    if not vRP.hasGroup(user_id,"Lider ["..myOrg:upper().."]") and not vRP.hasGroup(user_id,"Sub-Lider ["..myOrg:upper().."]") then 
        return false, TriggerClientEvent("Notify",source,"negado","Você não tem permissão.",5)
    end

    local orgBank = exports.oxmysql:query_async("SELECT bank FROM mirtin_orgs_info WHERE organization = @org",{ org = myOrg })
    if #orgBank <= 0 then 
        return false, TriggerClientEvent("Notify",source,"negado","Não encontrado",5)
    end

    if orgBank[1] and parseInt(Shops[purchaseIndex].price) > orgBank[1].bank then 
        return false, TriggerClientEvent("Notify",source,"negado","Saldo insuficiente no banco da organização.") 
    end

    local responseList = json.decode(vRP.getSData("purchasedStorage:"..myOrg)) or {}
    local balanceOrg = orgBank[1].bank
    if responseList then 
        local checkBuyed = tostring(purchaseIndex)
        if responseList.Buyeds[checkBuyed] then 
            return false
        end

        responseList.Amount = parseInt(responseList.Amount) + Shops[purchaseIndex].amount
        responseList.Buyeds[tostring(purchaseIndex)] = true 

        balanceOrg = balanceOrg - parseInt(Shops[purchaseIndex].price)
        if balanceOrg <= 0 then 
            balanceOrg = 0 
        end

        vRP.setSData("purchasedStorage:"..myOrg,json.encode(responseList))
    
        exports.oxmysql:query("UPDATE mirtin_orgs_info SET bank = @bank WHERE organization = @org",{ org = myOrg, bank = balanceOrg  })
    
        local listBuyeds = Shops
        for k,v in pairs(responseList.Buyeds) do 
            local Buyed = parseInt(k)
            if listBuyeds[Buyed] then 
                listBuyeds[Buyed].buyed = true 
            end
        end
    
        return listBuyeds
    else
        responseList = {
            Amount = Shops[purchaseIndex].amount,
            Buyeds = { [tostring(purchaseIndex)] = true }
        }

        balanceOrg = balanceOrg - parseInt(Shops[purchaseIndex].price)
        if balanceOrg <= 0 then 
            balanceOrg = 0 
        end

        vRP.setSData("purchasedStorage:"..myOrg,json.encode(responseList))
        exports.oxmysql:query("UPDATE mirtin_orgs_info SET bank = @bank WHERE organization = @org",{ org = myOrg, bank = balanceOrg  })
      
        local listBuyeds = Shops
        for k,v in pairs(responseList.Buyeds) do 
            local Buyed = parseInt(k)
            if listBuyeds[Buyed] then 
                listBuyeds[Buyed].buyed = true 
            end
        end

        return listBuyeds
    end
end

function RegisterTunnel.rankingOrg()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local myOrg = vRP.getUserGroupOrg(user_id)
    if not myOrg then 
        return false
    end


    local returnRanking = {}
    local rankingOrganization = exports.oxmysql:query_async("SELECT * FROM crafting_ranking WHERE organization = @org ORDER BY monthly DESC, week DESC, daily DESC", { org = myOrg })
    if #rankingOrganization > 0 then 
        for k,v in pairs(rankingOrganization) do 
            local nameMember = "Individuo Indigente"
            local userIdentity = vRP.getUserIdentity(user_id)
            if userIdentity then
                nameMember = userIdentity.nome.." "..userIdentity.sobrenome
            end

            table.insert(returnRanking,{ position = (#returnRanking or 0) + 1, name = nameMember, id = v.user_id, daily = v.daily, weekly = v.week, monthly = v.monthly, isMy = v.user_id == user_id and true or nil })
        end
    end
    
    return returnRanking
end

function RegisterTunnel.extraSlots()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local myOrg = vRP.getUserGroupOrg(user_id)
    if not myOrg then 
        return false
    end
    
    
    local slotAmount = 4 
    return slotAmount
end

exports("registerInRanking",function(user_id,amount)
    local myOrg = vRP.getUserGroupOrg(user_id)
    if myOrg then 
        local queryOrganization = exports.oxmysql:query_async("SELECT user_id FROM crafting_ranking WHERE user_id = @id",{ id = user_id })
        if #queryOrganization <= 0 then 
            exports.oxmysql:query("INSERT INTO crafting_ranking(user_id,organization) VALUES(@user_id,@organization)",{ user_id = user_id, organization = myOrg })
        end


        exports.oxmysql:query("UPDATE crafting_ranking SET daily = daily + @amount, week = week + @amount, monthly = monthly + @amount WHERE user_id = ? AND organization = ?",{ user_id, myOrg })
    end
end)


AddEventHandler('vRP:playerJoinGroup', function(user_id,group)
 	local source = vRP.getUserSource(user_id)
 	if not source then return end 

    if CraftConfig.Tables[group] then 
        local queryOrganization = exports.oxmysql:query_async("SELECT user_id FROM crafting_ranking WHERE user_id = @id",{ id = user_id })
        if #queryOrganization > 0 then 
            exports.oxmysql:query("DELETE FROM crafting_ranking WHERE user_id = @id",{ id = user_id })
        end

        exports.oxmysql:query("INSERT INTO crafting_ranking(user_id,organization) VALUES(@user_id,@organization)",{ user_id = user_id, organization = group })
    end
end)

AddEventHandler("vRP:playerLeaveGroup",function(user_id,group)
    local source = vRP.getUserSource(user_id)
    if not source then return end 
   
    if CraftConfig.Tables[group] then 
        local queryOrganization = exports.oxmysql:query_async("SELECT user_id FROM crafting_ranking WHERE user_id = @id",{ id = user_id })
        if #queryOrganization > 0 then 
            exports.oxmysql:query("DELETE FROM crafting_ranking WHERE user_id = @id",{ id = user_id })
        end
    end
end)

Citizen.CreateThread(function()
    local currentTime = os.time()
    local queryRanking = exports.oxmysql:query_async("SELECT * FROM crafting_ranking")

    for _, v in pairs(queryRanking) do
        local updateDaily = (v.dailyTime + 24 * 60 * 60) < currentTime
        local updateWeekly = (v.weekTime + 7 * 24 * 60 * 60) < currentTime
        local updateMonthly = (v.monthlyTime + 30 * 24 * 60 * 60) < currentTime

        if updateDaily then
            exports.oxmysql:query("UPDATE crafting_ranking SET daily = 0, dailyTime = @time WHERE user_id = @user_id", { user_id = v.user_id, time = currentTime })
        end

        if updateWeekly then
            exports.oxmysql:query("UPDATE crafting_ranking SET week = 0, weekTime = @time WHERE user_id = @user_id", { user_id = v.user_id, time = currentTime })
        end

        if updateMonthly then
            exports.oxmysql:query("UPDATE crafting_ranking SET monthly = 0, monthlyTime = @time WHERE user_id = @user_id", { user_id = v.user_id, time = currentTime })
        end
    end
end)

AddEventHandler("vRP:playerSpawn",function(user_id,source)
    local queryRanking = exports.oxmysql:query_async("SELECT * FROM crafting_ranking WHERE user_id = @user_id",{ user_id = user_id })
    if #queryRanking > 0 then 
        local currentTime = os.time()
        local updateDaily = (queryRanking[1].dailyTime + 24 * 60 * 60) < currentTime
        local updateWeekly = (queryRanking[1].weekTime + 7 * 24 * 60 * 60) < currentTime
        local updateMonthly = (queryRanking[1].monthlyTime + 30 * 24 * 60 * 60) < currentTime

        if updateDaily then
            exports.oxmysql:query("UPDATE crafting_ranking SET daily = 0, dailyTime = @time WHERE user_id = @user_id", { user_id = user_id, time = currentTime })
        end

        if updateWeekly then
            exports.oxmysql:query("UPDATE crafting_ranking SET week = 0, weekTime = @time WHERE user_id = @user_id", { user_id = user_id, time = currentTime })
        end

        if updateMonthly then
            exports.oxmysql:query("UPDATE crafting_ranking SET monthly = 0, monthlyTime = @time WHERE user_id = @user_id", { user_id = user_id, time = currentTime })
        end 
    end
end)

local dominations = {
    ['Dominacao [GERAL]'] = true,
    ['Dominacao [ARMAS]'] = true,
    ['Dominacao [MUNICAO]'] = true,
    ['Dominacao [DROGAS]'] = true,
    ['Dominacao [LAVAGEM]'] = true,
    ['Dominacao [DESMANCHE]'] = true,
}

local differentCrafts = {
    ['Cocaina'] = true,
    ['Heroina'] = true,
    ['Metanfetamina'] = true,
    ['Balinha'] = true,
}

function RegisterTunnel.startProduction(tables, item, amount)
    
    if not amount or amount <= 0 then amount = 1 end

    amount = parseInt(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then 
        return
    end

    local myOrg = vRP.getUserGroupOrg(user_id)
    if not myOrg then 
        return false
    end
    if not dominations[tables] and not differentCrafts[tables] then
        tables = myOrg
    end
    local index = 1
    for k,v in pairs(CraftConfig.Tables[tables].Itens) do 
        if CraftConfig.Tables[tables].Itens[k].item == item.item then 
            index = k
            break
        end
    end

    if Craft.Users[source] then
        return false,TriggerClientEvent("Notify",source, "negado","Você já está fabricando um item.")
    end

    local Table = CraftConfig.Tables[tables]
    if not Table then 
        return false
    end

    -- CRAFT DOMINAS GERAL
    if tables == 'Dominacao [GERAL]' then
        if vRP.computeInvWeight(user_id)+vRP.getItemWeight(Table.Itens[index].item)*parseInt(Table.Itens[index].customAmount * amount) <= vRP.getInventoryMaxWeight(user_id) then
            local storageItens = json.decode(vRP.getSData('armazem:'..myOrg)) or {}
            if Table.Itens[index].item == "cogumelo" then 
                local missingDrugs = {}

                local hasEnoughDrugs = true 
                for _, drug in pairs(Table.Itens[index].requires) do 
                    local amount = tonumber(storageItens[drug.item]) or 0
                    if amount < tonumber(drug.amount) then 
                        table.insert(missingDrugs,  drug.amount - amount.."x "..drug.item)
                    end
                end

                if #missingDrugs == 0 then 
                    for _, drug in pairs(Table.Itens[index].requires) do 
                        storageItens[drug.item] = tonumber(storageItens[drug.item]) - tonumber(drug.amount)
                    end

                    vRP.setSData('armazem:'..myOrg,json.encode(storageItens))
                    Craft:StartPlayerCraft(
                        { 
                            source = source, 
                            user_id = user_id 
                        }, 
                        {
                            item = Table.Itens[index].item,
                            org = myOrg,
                            amount = Table.Itens[index].customAmount * amount,
                            time = (Table.Itens[index].time * amount),
                            anim = Table.Itens[index].anim,
                            maxItems = Table.Itens[index].maxItems or nil
                        }
                    )
                    return true
                else 
                    TriggerClientEvent("Notify",source,'negado','Faltam '..table.concat(missingDrugs, ", ")..' no armazém de sua organização para produzir o cogumelo.')
                    return false 
                end
                return false
            end

            local payment = 0

            for k,v in pairs(Table.Itens[index].requires) do
                payment = v.amount * amount
            end

            local money = storageItens['money']

            if (money < payment) then 
                local notifyText = ('A sua organização não tem %sR$ no armazém.'):format(vRP.format(payment))
                return TriggerClientEvent("Notify",source, "negado",notifyText, 15000) 
            end

            newMoney = money - payment 
            if (newMoney < 0) then 
                newMoney = 0 
            end

            storageItens['money'] = newMoney

            storageItens = json.encode(storageItens)

            vRP.setSData('armazem:'..myOrg, storageItens)

            -- if not vRP.tryFullPayment(user_id, payment) then TriggerClientEvent("Notify",source, "negado","Você não possui "..vRP.format(payment).." em dinheiro.") return end
            Craft:StartPlayerCraft(
                { 
                    source = source, 
                    user_id = user_id 
                }, 
                {
                    item = Table.Itens[index].item,
                    org = myOrg,
                    amount = Table.Itens[index].customAmount * amount,
                    time = (Table.Itens[index].time * amount),
                    anim = Table.Itens[index].anim,
                    maxItems = Table.Itens[index].maxItems or nil
                }
            )

            return true
        end 
        return false 
    end

    local hasBoostPistolDomination = exports['nova_dominacao_pistol']:isBoostDominationPistol(myOrg)

    local NecessarityItems = {}
    for k, v in pairs(Table.Itens[index].requires) do
        if hasBoostPistolDomination then
            local reducedAmount = math.floor(v.amount * 0.9)
            NecessarityItems[v.item] = reducedAmount * amount
        else
            NecessarityItems[v.item] = v.amount * amount
        end
    end
    

    -- CRAFTAR COM ITENS DA MAO
    if Table.Config.craftHand then
        local ErrorMessage = ""
        for item, amount in pairs(NecessarityItems) do
            local itemAmount = vRP.getInventoryItemAmount(user_id, item)
            if itemAmount < amount then
                ErrorMessage = ErrorMessage.. ("<br>Item <b>%s</b> quantidade <b>%s/%s</b>"):format(exports["vrp"]:itemNameList(item), itemAmount, amount)
            end
        end
        
        if ErrorMessage ~= "" then
            TriggerClientEvent("Notify",source, "negado","Você não possui: <br>"..ErrorMessage)
            return
        end

        for item, amount in pairs(NecessarityItems) do
            vRP.tryGetInventoryItem(user_id, item, amount, true)
        end

        local boostFarm = 1
        local data = exports['dm_module']:GetUserDomination(user_id)
        local orgType, orgName = exports['dm_module']:GetGroupType(user_id)

        local hasDomination = data and data.zones and #data.zones > 0
        local hasGlobalDomination = GlobalState.dominationOwner == orgName
        local hasPistolDomination = exports['nova_dominacao_pistol']:isBoostDominationPistol(orgName)


        if hasDomination and hasGlobalDomination then
            boostFarm = 4
        elseif hasDomination or hasGlobalDomination or hasPistolDomination then
            boostFarm = 2  
        end
        
        if vRP.hasPermission(user_id, 'perm.vipmaio') then
            boostFarm = boostFarm * 2
        end

        if table.maxItems then
            if not groupsMaxItems[myOrg] then
                groupsMaxItems[myOrg] = { [Table.Itens[index].item] = 0 }
            end

            if (groupsMaxItems[myOrg][Table.Itens[index].item] + (Table.Itens[index].customAmount * amount) * boostFarm) > craft.maxItems then
                TriggerClientEvent("Notify",source,"negado","Limite de produção de <b>"..Table.Itens[index].item.."</b> atingido.", 5)
                return
            end
        end
        
        TriggerClientEvent("Notify", source, "aviso",("Sua organização está com boost de farm %s x ativo."):format(boostFarm), 15000)        
        return Craft:StartPlayerCraft(
            { 
                source = source, 
                user_id = user_id 
            }, 
            {
                item = Table.Itens[index].item,
                org = myOrg,
                amount = (Table.Itens[index].customAmount * amount) * boostFarm,
                time = (Table.Itens[index].time * amount),
                anim = Table.Itens[index].anim,
                maxItems = Table.Itens[index].maxItems or nil
            }
        )
    end

    -- ARMAZEM
    local Storage = CraftConfig.Storage[myOrg]
    if not Storage then 
        return 
    end
    
    local StorageItens = json.decode(vRP.getSData('armazem:'..myOrg)) or {}
    local StorageList = Storage.List
    
    local ErrorMessage = ""
    local StartCraft = true
    for item,amount in pairs(NecessarityItems) do
        if not StorageItens[item] then StorageItens[item] = 0 end

        if StorageItens[item] < amount then
            ErrorMessage = ErrorMessage.. ("<br>Item <b>%s</b> quantidade <b>%s/%s</b>"):format(exports["vrp"]:itemNameList(item), StorageItens[item], amount)
            StartCraft = false
        end

        Citizen.Wait(10)
    end

    if not StartCraft then
        TriggerClientEvent("Notify",source, "negado","O Armazem não possui: <br>"..ErrorMessage)
        return false
    end

    if vRP.computeInvWeight(user_id)+vRP.getItemWeight(Table.Itens[index].item)*parseInt(Table.Itens[index].customAmount * amount) <= vRP.getInventoryMaxWeight(user_id) then
        for item,amount in pairs(NecessarityItems) do
            StorageItens[item] -= amount
            if StorageItens[item] <= 0 then 
                StorageItens[item] = 0 
            end
        end

        vRP.setSData('armazem:'..myOrg, json.encode(StorageItens))
        Craft:StartPlayerCraft(
            { 
                source = source, 
                user_id = user_id 
            }, 
            {
                item = Table.Itens[index].item,
                org = myOrg,
                amount = Table.Itens[index].customAmount * amount,
                time = (Table.Itens[index].time * amount),
                anim = Table.Itens[index].anim,
                maxItems = Table.Itens[index].maxItems or nil
            }
        )
    end
end 

function RegisterTunnel.storageList(index)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local Storage = CraftConfig.Storage[index]
    if not Storage then return end

    if not vRP.hasPermission(user_id, Storage.Config.permission) then
        TriggerClientEvent("Notify",source, "negado","Você não possui permissão.")
        return
    end

    local StorageItens = json.decode(vRP.getSData('armazem:'..index)) or nil
    if not StorageItens then
        TriggerClientEvent("Notify",source, "negado","O Armazem não possui Itens.")
        return
    end

    local Text = ""

    local StorageAmount = 0
    local StorageBuys = json.decode(vRP.getSData("purchasedStorage:"..index)) or {} 
    if StorageBuys and StorageBuys.Amount then 
        StorageAmount = parseInt(StorageBuys.Amount)
    end

    -- local StorageMax = ((Storage.Max or 30000) + StorageAmount) or 30000
    local StorageMax = 1000000
    for item,amount in pairs(StorageItens) do
        Text = Text.. '<br>Item: <b>'..exports["vrp"]:itemNameList(item)..'</b> <b>'..amount..'</b>x / <b>'..StorageMax..'</b>x'
    end
   
    TriggerClientEvent("Notify",source, "sucesso","Lista de Itens: <br>"..Text, 15)
end



local SkipItens = { ["money"] = true, ["dirty_money"] = true }
function RegisterTunnel.storageStore(index)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local Storage = CraftConfig.Storage[index]
    if not Storage then return end
        
    if not vRP.hasPermission(user_id, Storage.Config.permission) then
        TriggerClientEvent("Notify",source, "negado","Você não possui permissão.")
        return
    end

    local StorageItens = json.decode(vRP.getSData('armazem:'..index)) or {}
    local ItensList = Storage.List
    local Text = ""


    for item,maxAmount in pairs(ItensList) do
        local plyItemAmount = vRP.getInventoryItemAmount(user_id, item)

        local StorageAmount = 0
        local StorageBuys = json.decode(vRP.getSData("purchasedStorage:"..index)) or {} 
        if StorageBuys and StorageBuys.Amount then 
            StorageAmount = parseInt(StorageBuys.Amount)
        end

        -- local StorageMax = ((Storage.Max or 30000) + StorageAmount) or 30000
        local StorageMax = 1000000
        if not SkipItens[item] and (StorageItens[item] and (StorageItens[item] + plyItemAmount) > StorageMax)  then 
            TriggerClientEvent("Notify",source,"negado","O Limite para o item "..item.." foi atingido.",100)
            goto continue 
        end


        if vRP.tryGetInventoryItem(user_id, item, plyItemAmount, true) then
            if StorageItens[item] then
                StorageItens[item] += plyItemAmount

                Text = Text ~= nil and Text.. '<br>Item: '..exports["vrp"]:itemNameList(item).. ' '..plyItemAmount..'x ' or 'Item: '..exports["vrp"]:itemNameList(item).. ' '..plyItemAmount..'x '
            else
                StorageItens[item] = plyItemAmount

                Text = Text ~= nil and Text.. '<br>Item: '..exports["vrp"]:itemNameList(item).. ' '..plyItemAmount..'x ' or 'Item: '..exports["vrp"]:itemNameList(item).. ' '..plyItemAmount..'x '
            end

            if item and plyItemAmount then
                exports.mirtin_orgs_v2:addGoal(user_id, item, plyItemAmount)
                exports["mirtin_orgs_v2"]:addLogChest(user_id,item,plyItemAmount)
                exports["nova_craft"]:registerInRanking(user_id,plyItemAmount)
            end
        end

        ::continue::
    end

    if Text == "" then
        TriggerClientEvent("Notify",source, "negado","Você não possui itens para guardar.")
        return
    end

    vRP.setSData('armazem:'..index, json.encode(StorageItens))
    TriggerClientEvent("Notify",source, "sucesso",'Você guardou: <br>'..Text, 5)

    corpoHook = { 
        { 
            ["color"] = 6356736, 
            ["title"] = "**".. ":man_construction_worker: | Armazem " .."**\n", 
            ["thumbnail"] = { ["url"] = 'https://media.discordapp.net/attachments/980387548721455134/1096229393891856466/CONEXÃO-01_2.png?width=867&height=662' }, 
            ["description"] = "**USER_ID:**\n```cs\n"..user_id.."```\n**GUARDOU:** ```css\n".. Text .." ```\n**ORG:**\n ```cs\n"..index.."```", 
            ["footer"] = { ["text"] = "© FIVE GROUP", }, 
        } 
    }
    sendToDiscord(Weebhooks[index], corpoHook)

    return true
end

function RegisterTunnel.storageItens(org)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end
    
    if not CraftConfig.Storage[org] then return end

    local Storage = CraftConfig.Storage[org].List
    local FormatStorage = {}
    for item in pairs(Storage) do
        FormatStorage[#FormatStorage + 1] = { value = item, name = exports["vrp"]:itemNameList(item) }
    end
    
    return FormatStorage or {}
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GERAR CACHE DOS CRAFTS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    for tableName in pairs(CraftConfig.Tables) do
        if not Craft.List[tableName] then Craft.List[tableName] = {} end

        local ListItems = CraftConfig.Tables[tableName].Itens
        for i = 1, #ListItems do

            local ActualItem = #Craft.List[tableName] + 1
            local Item = ListItems[i]

            local nameItem = exports["vrp"]:itemNameList(Item.item)
            if nameItem == "Deleted" then 
                nameItem = exports["vrp"]:itemNameList(Item.item:lower())
            end
            
            Craft.List[tableName][ActualItem] = {
                item = Item.item,
                name = nameItem,
                time = Item.time,
                anim = Item.anim,
                image = Item.item,
                customAmount = Item.customAmount,
            }

            for i = 1, #Item.requires do
                local Item = Item.requires[i]
                if not Craft.List[tableName][ActualItem].requires then Craft.List[tableName][ActualItem].requires = {} end

                local nameItem = exports["vrp"]:itemNameList(Item.item)
                if nameItem == "Deleted" then 
                    nameItem = exports["vrp"]:itemNameList(Item.item:lower())
                end

                Craft.List[tableName][ActualItem].requires[#Craft.List[tableName][ActualItem].requires + 1] = {
                    item = Item.item,
                    name = nameItem,
                    amount = Item.amount,
                    image = Item.item,
                } 
            end
        end
    end
end)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OTHERS FUNCTIONS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function sendToDiscord(weebhook, message)
    PerformHttpRequest(weebhook, function(err, text, headers) end, 'POST', json.encode({embeds = message}), { ['Content-Type'] = 'application/json' })
end

RegisterCommand('cleararmazem', function(source, args)
    local userId = vRP.getUserId(source)

    if not vRP.hasPermission(userId, 'developer.permissao') then 
        return 
    end

    local fac = vRP.prompt(source, 'Qual fação você deseja limpar o armazem? ', '')
    if not fac or fac == '' then 
        return 
    end

    local query = exports.oxmysql:executeSync('SELECT * FROM vrp_srv_data WHERE dkey = ?', { 'armazem:'..fac })
    if #query <= 0 then 
        TriggerClientEvent('Notify', source, 'negado', 'Armazem não encontrado.')
        return 
    end

    local data = {}
    exports.oxmysql:query('UPDATE vrp_srv_data SET dvalue = ? WHERE dkey = ?', { json.encode(data), 'armazem:'..fac })
    TriggerClientEvent('Notify', source, 'sucesso', 'Armazem '..fac..' limpado com sucesso!')
end)