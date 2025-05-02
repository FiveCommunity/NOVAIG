--------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------------------------------------------------------------------------------
Taxi = {
    inService = false,
    ActualRoute = 1,
    blip = false,
}

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------------------------------------------------------------------------------

function Taxi:createCheckpoint(coords)
	self.blip = AddBlipForCoord(coords[1],coords[2],coords[3])
	SetBlipSprite(self.blip,1)
	SetBlipColour(self.blip,5)
	SetBlipScale(self.blip,0.4)
	SetBlipAsShortRange(self.blip,false)
	SetBlipRoute(self.blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Destino do passageiro")
	EndTextCommandSetBlipName(self.blip)
end

function Taxi:StartThread()
    CreateThread(function()
        while true do
            local SLEEP_TIME = 1000
            
            local dist = #(GetEntityCoords(PlayerPedId()) - vec3(TaxiConfig.Init.x,TaxiConfig.Init.y,TaxiConfig.Init.z))
            if dist <= 10.0 then
                SLEEP_TIME = 0
                
                if not self.inService then
                    if not IsPedInAnyVehicle(PlayerPedId()) then
                        DrawText3D(TaxiConfig.Init.x,TaxiConfig.Init.y,TaxiConfig.Init.z, "Pressione ~b~ E ~w~ para iniciar o emprego de ~b~Taxista.")
                        if IsControlJustReleased(1, 51) then
                            self.inService = true
                            self:StartThreadService()
                            self:createCheckpoint(TaxiConfig.Routes[self.ActualRoute].coords)
                            TriggerEvent("Notify", "sucesso", "Foi marcado no seu GPS o destino do seu cliente.",5000)
                        end
                    end
                end

            end

            Wait( SLEEP_TIME )
        end
    end)
end

function Taxi:StartThreadService()
    CreateThread(function()
        local myPlate = vTunnel.myRegistration()

        while self.inService do
            local ped = PlayerPedId()

            local plyCoords = GetEntityCoords(ped)
            local distRoute = #(TaxiConfig.Routes[self.ActualRoute].coords - plyCoords)
            local vehicle = GetVehiclePedIsIn(ped)
            if vehicle then
                if GetEntityModel(vehicle) == GetHashKey(TaxiConfig.Vehicle) and GetVehicleNumberPlateText(vehicle):gsub(" ", "") == myPlate then
                    local speedVeh = GetEntitySpeed(vehicle) * 3.6

                    if distRoute <= 5 then
                        local nCoords = TaxiConfig.Routes[self.ActualRoute].coords

                        if not LocalPlayer.state.hasCollecting then
                            DrawText3D(nCoords[1],nCoords[2],nCoords[3]+0.2, "Pressione ~b~ E ~w~ para entregar o passageiro.")

                            if IsControlJustReleased(1, 51) and speedVeh < 40 then
                                if IsPedInAnyVehicle(PlayerPedId()) then 
                                    LocalPlayer.state.hasCollecting = true
                                    FreezeEntityPosition(vehicle,true)
                                    
                                    TriggerEvent("Progress", TaxiConfig.Delay * 1000)
                               
                                    SetTimeout(TaxiConfig.Delay * 1000, function()
                                        FreezeEntityPosition(vehicle,false)
                                        LocalPlayer.state.hasCollecting = false
                                        self.ActualRoute = vTunnel.taxiPayment(self.ActualRoute)    

                                        RemoveBlip(self.blip)
                                        self:createCheckpoint(TaxiConfig.Routes[self.ActualRoute].coords)
                                    end)
        
                                end
                            end
                        end

                    end

                end
            end

            drawTxt("~w~APERTE ~r~F7~w~ PARA FINALIZAR O EXPEDIENTE.", 0.215,0.94)
            if IsControlJustPressed(0, 168) then
                self.inService = false

                RemoveBlip(self.blip)
            end

            Wait( 0 )
        end
    end)
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
--------------------------------------------------------------------------------------------------------------------------------------------------------

CreateThread(function()
    Taxi:StartThread()
end)