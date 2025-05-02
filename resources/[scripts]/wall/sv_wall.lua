local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local src = {}
Tunnel.bindInterface("wall",src)


local playerList = {}
local adminList = {}

AddEventHandler("vRP:playerSpawn",function(user_id,source)
    local identity = vRP.getUserIdentity(user_id)
    if identity then
        playerList[source] = { 
            steamName = GetPlayerName(source), 
            user_id = user_id, 
            name = identity.nome.." "..identity.sobrenome, 
            isStaff = vRP.hasPermission(user_id, "ticket.permissao"),
            orgName = vRP.getUserGroupOrg(user_id) or "Desempregado"
        }
    else
        playerList[source] = { 
            steamName = GetPlayerName(source), 
            user_id = user_id, 
            name = "Não encontrado", 
            isStaff = vRP.hasPermission(user_id, "ticket.permissao"),
            orgName = vRP.getUserGroupOrg(user_id) or "Desempregado"
        }
    end 

    for k,v in pairs(adminList) do
        TriggerClientEvent("wall:Blips:UpdateList",v,playerList)
    end
end)

AddEventHandler("playerDropped",function()
    local user_id = vRP.getUserId(source)
    if playerList[source] then
        playerList[source] = nil
        if adminList[user_id] then
            adminList[user_id] = nil
        end

        for k,v in pairs(adminList) do
            TriggerClientEvent("wall:Blips:UpdateList",v,playerList)
        end
    end
end)

local function forceSync()
    for k,v in pairs(vRP.getUsers()) do
        local source = vRP.getUserSource(k)
        local identity = vRP.getUserIdentity(k)
        local isStaff = vRP.hasPermission(k,"ticket.permissao")

        playerList[v] = {
            steamName = GetPlayerName(source), 
            user_id = k, 
            name = identity.nome.." "..identity.sobrenome, 
            staff = isStaff,
            orgName = vRP.getUserGroupOrg(k) or "Desempregado"
        }
    end
    
    for k,v in pairs(adminList) do
        TriggerClientEvent("wall:Blips:UpdateList",v,playerList)
    end
end


AddEventHandler("onResourceStart",function(resName)
    if resName ~= GetCurrentResourceName() then
        return
    end

    forceSync()
end)

local userConfig = {}
local blipsStatus = {}
RegisterCommand("wall",function(source,args,rawCmd)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if not vRP.hasPermission(user_id,"ticket.permissao") then
        return
    end

    userConfig[user_id] = {
        Vida = true,
        Arma = true,
        Nome = true,
        Source = false,
        Linhas = false,
        Colete = true,
    }
    if not blipsStatus[user_id] then 
        msg = "`ATIVADO`"
        blipsStatus[user_id] = true
    else
        msg = "`DESATIVADO`"
        blipsStatus[user_id] = false
    end
    local loc = {}
    if(source~=nil)then
        local ped = GetPlayerPed(source)
        loc = GetEntityCoords(ped)
    else
        loc.x = "?"				
        loc.y = "?"	
        loc.z = "?"	
    end
    local reason = "[Localização]: `"..loc.x..","..loc.y..","..loc.z.."`"
    TriggerClientEvent("wall:Blips:LoadAdminMode", source, userConfig[user_id])
end)

function src.loadInfos()
    local source = source
    local user_id = vRP.getUserId(source)
     if not vRP.hasPermission(user_id,"ticket.permissao") then
         return
     end
    
    adminList[user_id] = source
    TriggerClientEvent("wall:Blips:UpdateList",source,playerList)
    TriggerClientEvent("wall:stateUpdate",source, 'infosWall',  'Ativado' )
end

function src.unloadInfos()
    local source = source
    local user_id = vRP.getUserId(source)
    
    if adminList[user_id] then
        adminList[user_id] = nil
        TriggerClientEvent("wall:stateUpdate",source, 'infosWall',  'Desativado' )
    end
end

RegisterCommand("wallall",function(source,args,rawCmd)
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id,"ticket.permissao") then
        return
    end

    forceSync()
end)


local menuFunctions = {

    ["Vida"] = {
        eventChoice = "wall:UpdateConfig",
        permission = "ticket.permissao",
    },

    ["Colete"] = {
        eventChoice = "wall:UpdateConfig",
        permission = "ticket.permissao",
    },

    ["Arma"] = {
        eventChoice = "wall:UpdateConfig",
        permission = "ticket.permissao",
    },
    
    ["Source"] = {
        eventChoice = "wall:UpdateConfig",
        permission = "ticket.permissao",
    },

    ["Nome"] = {
        eventChoice = "wall:UpdateConfig",
        permission = "ticket.permissao",
    },

    ["Linhas"] = {
        eventChoice = "wall:UpdateConfig",
        permission = "ticket.permissao",
    },

    ["Objetos"] = {
        permission = "ticket.permissao",
        execute = function(source,user_id) 
            local nuser_id = vRP.prompt(source, "Qual id do jogador?", "")
            local nsource = vRP.getUserSource(parseInt(nuser_id))
            if nuser_id and nsource then 
                if vRP.request(source,"Deseja apagar as entidades de: <b>"..nuser_id.." </b> ?",30) then
                    for _,vehicles in pairs(GetAllVehicles()) do
                        if DoesEntityExist(vehicles) then 
                            if NetworkGetEntityOwner(vehicles) == nsource then 
                                DeleteEntity(vehicles)
                            end
                        end
                    end
                    for _,obj in pairs(GetAllObjects()) do
                        if DoesEntityExist(obj) then 
                            if NetworkGetEntityOwner(obj) == nsource then 
                                DeleteEntity(obj)
                            end
                        end
                    end
                    TriggerClientEvent("Notify",source,"aviso","Todos os objetos foram deletados com sucesso.",10000)
                end
            end
        end
    },

}

RegisterCommand('blips2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
        if not vRP.hasPermission(user_id, "ticket.permissao") or not adminList[user_id] then return false end
        
		local menu = vRP.buildMenu("admBlips",{ user_id = user_id, player = source, vname = name })
		menu.name = "Menu BLIPS"

		local kitems = {}
        local vmodel = {}
		local choose = function(source,choice)
			local tosub = false
			local submenu = { name = vmodel[choice] }
			submenu.onclose = function()
				tosub = false
				vRP.openMenu(source,menu)
			end
            local NameOption = submenu.name

			local ch_option = function(source,choice)
                local Option = menuFunctions[NameOption]
                if Option then 
                    if userConfig[user_id][NameOption] then 
                        userConfig[user_id][NameOption] = false
                        if Option.eventChoice then 
                            TriggerClientEvent(Option.eventChoice, source, NameOption, false)
                            TriggerClientEvent("Notify",source,"aviso", NameOption.." Desativado!") 
                        end
                        vRP.closeMenu(source)
                        return
                    end
                    userConfig[user_id][NameOption] = true
                    if Option.eventChoice then 
                        TriggerClientEvent(Option.eventChoice, source, NameOption, true)
                        TriggerClientEvent("Notify",source,"sucesso", NameOption.." Ativado!") 
                    end
                    if Option.execute then 
                        Option.execute(source,user_id)
                    end
                    vRP.closeMenu(source)
                else
                    print('[ERROR] >> - TABLE NIL BLIPS CONFIGURATION')
			        TriggerClientEvent("Notify",source,"aviso","Algo deu errado na configuracao do script.")
                    vRP.closeMenu(source)
                end
			end
            
            local possibles = (userConfig[user_id][NameOption] or menuFunctions[NameOption].execute) and "Desativar" or "Ativar"
			submenu[possibles] = { ch_option }
			tosub = true
			vRP.openMenu(source,submenu)
		end

		local chooseNoPerm = function(source,choice)
			TriggerClientEvent("Notify",source,"aviso","Voce nao tem permissao para esta ação.")
		end

		for k,v in pairs(menuFunctions) do
			if k and v then
				if vRP.hasPermission(user_id, v.permission) then
					menu[k] = { choose }
				else
					menu[k] = { chooseNoPerm }
				end
				kitems[k] = v
                vmodel[k] = k
			end
		end

		vRP.openMenu(source,menu)
	end
end)


function getTimeFunction(seconds)
    local days = math.floor(seconds/86400)
    seconds = seconds - days * 86400
    local hours = math.floor(seconds/3600)
    seconds = seconds - hours * 3600
    local minutes = math.floor(seconds/60)
    seconds = seconds - minutes * 60

    if days > 0 then
        return string.format("%d Dias, %d Horas, %d Minutos",days,hours,minutes)
    elseif hours > 0 then
        return string.format("%d Horas, %d Minutos",hours,minutes)
    elseif minutes > 0 then
        return string.format("%d Minutos",minutes)
    elseif seconds > 0 then
        return string.format("%d Segundos",seconds)
    end
end

RegisterCommand("wallid",function(source,args,rawCmd)
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id,"ticket.permissao") then
        return
    end
    
    if not args[1] then return end
    
    local nsource = vRP.getUserSource(parseInt(args[1]))
    if nsource then
        local nuser_id = vRP.getUserId(nsource)
        local identity = vRP.getUserIdentity(nuser_id)
        playerList[nsource] = {}
        playerList[nsource] = { steamName = GetPlayerName(nsource), user_id = nuser_id, name = identity.nome.." "..identity.sobrenome }
    end
    
    for k,v in pairs(adminList) do
        TriggerClientEvent("wall:Blips:UpdateList",v,playerList)
    end
end)


local UserRentability = {}
AddEventHandler("controlUser",function(src, user_id, amount)
	if src and user_id and amount then 
        if not UserRentability[user_id] then 
            UserRentability[user_id] = 0
        end
        UserRentability[user_id] = UserRentability[user_id] + amount
        TriggerClientEvent("wall:stateUpdate",src, 'infosWallRent', UserRentability[user_id])
	end
end)

AddEventHandler("controlUserPlayed",function(src, user_id, value)
	if src and user_id and value then 
        TriggerClientEvent("wall:stateUpdate",src, 'infosWallTime', getTimeFunction(value))
	end
end)
