--------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------------------------------------------------------------------------------
Ifood = {
    inService = false,
    ActualRoute = 1,
    carStorage = 0,
    carrying = false,
    blip = false,

    Delay = GetGameTimer(),
}

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------------------------------------------------------------------------------
function Ifood:createCheckpoint(coords)
	self.blip = AddBlipForCoord(coords[1],coords[2],coords[3])
	SetBlipSprite(self.blip,1)
	SetBlipColour(self.blip,5)
	SetBlipScale(self.blip,0.4)
	SetBlipAsShortRange(self.blip,false)
	SetBlipRoute(self.blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega Do Ifood")
	EndTextCommandSetBlipName(self.blip)
end

function Ifood:StartThread()
    CreateThread(function()
        while true do
            local SLEEP_TIME = 1000
            
            local dist = #(GetEntityCoords(PlayerPedId()) - vec3(IfoodConfig.Init.x,IfoodConfig.Init.y,IfoodConfig.Init.z))
            if dist <= 10.0 then
                SLEEP_TIME = 0
                
                if self.inService then
                    if not IsPedInAnyVehicle(PlayerPedId()) then 
                        if self.carrying then
                            DrawText3D(IfoodConfig.Init.x,IfoodConfig.Init.y,IfoodConfig.Init.z, "Leve a pizza até a moto.")
                        else
                            DrawText3D(IfoodConfig.Init.x,IfoodConfig.Init.y,IfoodConfig.Init.z, "Pressione ~g~ E ~w~ para coletar.")
                        end
    
                        if IsControlJustReleased(1, 51) and not self.carrying and dist <= 1.5 then
                            self.carrying = true
                            vRP._CarregarObjeto("anim@heists@box_carry@","idle","prop_pizza_box_02",49,28422)
                        end
    
                        if IsControlJustReleased(1, 47) and self.carrying and dist <= 1.5 then
                            self.carrying = true
    
                            vRP._stopAnim(false)
                            vRP._DeletarObjeto()
                        end
                    end
                else
                    DrawText3D(IfoodConfig.Init.x,IfoodConfig.Init.y,IfoodConfig.Init.z, "Pressione ~b~ E ~w~ para iniciar o emprego de ~b~Entregador.")

                    if IsControlJustReleased(1, 51) then
                        self.inService = true
                        self:StartThreadService()
                        self:createCheckpoint(IfoodConfig.Routes[self.ActualRoute].coords)
                        TriggerEvent("Notify", "sucesso", "Foi marcado no seu GPS o destino do seu cliente.",5000)
                    end
                end

            end

            Wait( SLEEP_TIME )
        end
    end)
end

function Ifood:StartThreadService()
    CreateThread(function()
        local myPlate = vTunnel.myRegistration()--[[ vRP.getRegistrationNumber() ]]

        while self.inService do
            local plyCoords = GetEntityCoords(PlayerPedId())
            local distInit = #(GetEntityCoords(PlayerPedId()) - vec3(IfoodConfig.Init.x,IfoodConfig.Init.y,IfoodConfig.Init.z))
            local distRoute = #(IfoodConfig.Routes[self.ActualRoute].coords - plyCoords)
            local vehicle = GetNerarestVehicle(5.0)
            if vehicle then
                if GetEntityModel(vehicle) == GetHashKey(IfoodConfig.Vehicle) or GetEntityModel(vehicle) == GetHashKey(IfoodConfig.Vehicle2) then
                    if GetVehicleNumberPlateText(vehicle):gsub(" ", "") == myPlate then
                        print(myPlate)
                        local Coords = GetEntityCoords(vehicle)
                        DrawText3D(Coords.x,Coords.y,Coords.z+0.3,("Total ~b~%s/%s~w~ pizza(s)"):format(self.carStorage, IfoodConfig.maxStorage))

                        local distVeh = #(Coords - plyCoords)
                        if IsControlJustReleased(1, 51) and distVeh <= 3.0 then
                            if not IsPedInAnyVehicle(PlayerPedId()) then 
                                if self.carrying then
                                    self.carrying = false
                                    self.carStorage = (self.carStorage + 1)
            
                                    if self.carStorage >= IfoodConfig.maxStorage then
                                        self.carStorage = IfoodConfig.maxStorage
                                    end
            
                                    vRP._stopAnim(false)
                                    vRP._DeletarObjeto()
                                elseif not self.carrying then
                                    if self.carStorage > 0 then
                                        self.carrying = true
                                        vRP._CarregarObjeto("anim@heists@box_carry@","idle","prop_pizza_box_02",49,28422)
            
                                        self.carStorage = (self.carStorage - 1)
                                    end
                                end
                            end
                        end

                        if distInit >= 25 and not IsPedInAnyVehicle(PlayerPedId()) then
                            if self.carrying then
                                DrawText3D(Coords[1],Coords[2],Coords[3]+0.1, "Pressione ~b~ E ~w~ para colocar a pizza no baú.")
                            else
                                DrawText3D(Coords[1],Coords[2],Coords[3]+0.1, "Pressione ~b~ E ~w~ para pegar a pizza no baú.")
                            end
                        end
                    end
                end
            end

            if self.carrying then
                if distRoute <= 10 then
                    DrawText3D(
                        IfoodConfig.Routes[self.ActualRoute].coords[1],
                        IfoodConfig.Routes[self.ActualRoute].coords[2],
                        IfoodConfig.Routes[self.ActualRoute].coords[3],
                        "Pressione ~b~ G ~w~ para efetuar a entrega."
                    )
                    if IsControlJustReleased(1, 47) then
                        self.carrying = false

                        RemoveBlip(self.blip)
                        self.ActualRoute = vTunnel.ifoodPayment(self.ActualRoute)
                        self:createCheckpoint(IfoodConfig.Routes[self.ActualRoute].coords)
                            
                        vRP._stopAnim(false)
                        vRP._DeletarObjeto()
                    end
                end
            end

            drawTxt("~w~APERTE ~r~F7~w~ PARA FINALIZAR O EXPEDIENTE.", 0.215,0.94)
            if IsControlJustPressed(0, 168) then
                self.inService = false
                self.carStorage = 0
                self.carrying = false

                RemoveBlip(self.blip)

                vRP._stopAnim(false)
                vRP._DeletarObjeto()
            end

            Wait( 0 )
        end
    end)
end



--------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
--------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    Ifood:StartThread()
end)