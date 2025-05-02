--------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------------------------------------------------------------------------------
Orange = {
    ActualRoute = 1,
    Delay = GetGameTimer()
}

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
--------------------------------------------------------------------------------------------------------------------------------------------------------
function Orange:StartThread()
    CreateThread(function()
        while true do
            local SLEEP_TIME = 1000
            local ped = PlayerPedId()

            local Coords = orangeConfig.Routes[self.ActualRoute] and orangeConfig.Routes[self.ActualRoute].coords or false

            if Coords then
                local dist = #(GetEntityCoords(PlayerPedId()) - Coords)
                if dist <= 300 then
                    SLEEP_TIME = 0
                    DrawMarker(22,Coords[1],Coords[2],Coords[3],0,0,0,0,180.0,130.0,1.0,1.0,0.5, 255,0,0,200 ,1,0,0,1)
                end

                if dist <= 3.0 then
                    if IsControlJustReleased(1, 51) and (self.Delay - GetGameTimer()) <= 0 then
                        LocalPlayer.state.hasCollecting = true
                        self.Delay = (GetGameTimer() + (orangeConfig.Delay  * 1000) + 2000)
                        
                        vRP._playAnim(false,{{"amb@prop_human_movie_bulb@base","base"}},true)
                        TriggerEvent("Progress", orangeConfig.Delay)
                       
                        SetTimeout(orangeConfig.Delay * 1000, function()
                            LocalPlayer.state.hasCollecting = false
                            Orange.ActualRoute = vTunnel.OrangeCollect(Orange.ActualRoute)    
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
    Orange:StartThread()
end)
