--------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------------------------------------------------------------------------------
Miner = {
    ActualRoute = 1,
    Delay = GetGameTimer()
}

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
--------------------------------------------------------------------------------------------------------------------------------------------------------
function Miner:StartThread()
    CreateThread(function()
        while true do
            local SLEEP_TIME = 1000
            local ped = PlayerPedId()

            local Coords = MinerConfig.Routes[self.ActualRoute] and MinerConfig.Routes[self.ActualRoute].coords or false

            if Coords then
                local dist = #(GetEntityCoords(PlayerPedId()) - Coords)
                if dist <= 300 then
                    SLEEP_TIME = 0
                    DrawMarker(22,Coords[1],Coords[2],Coords[3],0,0,0,0,180.0,130.0,1.0,1.0,0.5, 255,0,0,200 ,1,0,0,1)
                end

                if dist <= 3.0 then
                    local isInVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
                    if IsControlJustReleased(1, 51) and (self.Delay - GetGameTimer()) <= 0 and not isInVehicle then
                        LocalPlayer.state.hasCollecting = true
                        self.Delay = (GetGameTimer() + (MinerConfig.Delay  * 1000) + 2000)
                        
                        vRP.CarregarObjeto("amb@world_human_const_drill@male@drill@base","base","prop_tool_jackham",15,28422)
                        TriggerEvent("Progress", MinerConfig.Delay)
                       
                        SetTimeout(MinerConfig.Delay * 1000, function()
                            LocalPlayer.state.hasCollecting = false
                            Miner.ActualRoute = vTunnel.MinerCollect(Miner.ActualRoute)    
                            vRP._stopAnim(false)
                            vRP._DeletarObjeto()
                        end)
                    end
                end
            end

            Wait( SLEEP_TIME )
        end
    end)
end

CreateThread(function()
    Miner:StartThread()
end)


