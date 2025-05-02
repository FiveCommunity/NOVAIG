local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface(GlobalState["RandomIdentifier_roubos"],src)
vSERVER = Tunnel.getInterface(GlobalState["RandomIdentifier_roubos"])
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local roubando = false
local contadorRoubo = 0
local rouboId = 0
local tipoRoubo = ""
local delay = false
local cooldownExecute = 0
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("roubar2","Roubar","keyboard","f")
RegisterCommand('roubar2', function(source,args)
    local ped = PlayerPedId()
    Wait(math.random(300,2000))
    if GetGameTimer() - cooldownExecute < 3000 then
        print('Aguarde!')
        return
    end
    cooldownExecute = GetGameTimer()
    if not roubando then
        local pedCoords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(cfg.locationRoubos) do
            local distance = #(pedCoords - v.coords)
            if distance <= 1.5 then
                if not delay then
                    if cfg.roubos[v.type] then
                        delay = true
                        if vSERVER.checkRobbery(k) then
                            roubando = true
                            contadorRoubo = cfg.roubos[v.type].tempo
                            rouboId = k
                            tipoRoubo = v.type

                            SetEntityHeading(PlayerPedId(), v.heading)
                            vRP._playAnim(false,{{"oddjobs@shop_robbery@rob_till", "loop"}},true)
                            vSERVER._alertPolice(v.coords[1],v.coords[2],v.coords[3], "Roubo "..tipoRoubo, "Um Roubo em "..tipoRoubo.." acaba de ser iniciado, intercepte os assaltantes.")
                            
                            CreateThread(function()
                                while roubando do
                                    contadorRoubo = contadorRoubo - 1

                                    if GetEntityHealth(ped) <= 105 and roubando then
                                        vSERVER._alertPolice(v.coords[1],v.coords[2],v.coords[3], "Roubo "..tipoRoubo, "O Roubo em "..tipoRoubo.." foi cancelado, um dos assaltantes morreu.")
                                        vSERVER._cancelRobbery()

                                        TriggerEvent("Notify","negado","O Roubo foi cancelado, você morreu.", 5)
                                        ClearPedTasks(PlayerPedId())

                                        roubando = false
                                        contadorRoubo = 0
                                        rouboId = 0
                                        tipoRoubo = ""
                                    end

                                    if not IsEntityPlayingAnim(ped,"oddjobs@shop_robbery@rob_till", "loop",3) and GetEntityHealth(ped) > 105 and roubando then
                                        SetEntityCoords(PlayerPedId(), v.coords[1],v.coords[2],v.coords[3]-1)
                                        SetEntityHeading(PlayerPedId(), v.heading)
                                        vRP._playAnim(false,{{"oddjobs@shop_robbery@rob_till", "loop"}},true)
                                    end

                                    if contadorRoubo <= 0 and roubando then
                                        vSERVER._alertPolice(v.coords[1],v.coords[2],v.coords[3], "Roubo "..tipoRoubo, "O Roubo em "..tipoRoubo.." foi concluido com sucesso, intercepte os assaltantes.")
                                        vSERVER._cancelRobbery()

                                        TriggerEvent("Notify","sucesso","O Roubo foi concluido com sucesso.", 5)
                                        ClearPedTasks(PlayerPedId())

                                        roubando = false
                                        contadorRoubo = 0
                                        rouboId = 0
                                        tipoRoubo = ""
                                    end

                                    Citizen.Wait(1000)
                                end
                            end)
                        end

                    end
                end

                delay = false
            end
        end
    end
end)


RegisterKeyMapping("croubar","Roubar","keyboard","m")
RegisterCommand('croubar', function(source,args)
    if roubando then
        vSERVER._alertPolice(cfg.locationRoubos[rouboId].coords[1],cfg.locationRoubos[rouboId].coords[2],cfg.locationRoubos[rouboId].coords[3], "Roubo "..tipoRoubo, "O Roubo em "..tipoRoubo.." foi cancelado pelos assaltantes.")
        vSERVER._cancelRobbery()
        
        TriggerEvent("Notify","negado","Você cancelou o roubo.", 5)
        ClearPedTasks(PlayerPedId())

        roubando = false
        contadorRoubo = 0
        rouboId = 0
        tipoRoubo = ""
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local time = 1000
        local pedCoords = GetEntityCoords(PlayerPedId())

        if not roubando then
            for k,v in pairs(cfg.locationRoubos) do
                local distance = #(pedCoords - v.coords)
                if distance <= 3.0 then
                    time = 5
                    
                    if v.type ~= "Caixa Eletronico" then
                        DrawText3D(v.coords[1],v.coords[2],v.coords[3], v.mensagem)
                    end
                end
            end
        end
        
        Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
    while true do
        local time = 1000

        if roubando then
            time = 5

            drawTxt("Pressione ~g~M~w~ para cancelar o roubo.",4,0.5,0.935,0.50,255,255,255,100)
            drawTxt("Ainda Faltam ~r~"..contadorRoubo.."~w~ segundo(s) para concluir o roubo.",4,0.5,0.96,0.50,255,255,255,100)
        end
        
        Citizen.Wait(time)
    end
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 400
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,140)
end

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end