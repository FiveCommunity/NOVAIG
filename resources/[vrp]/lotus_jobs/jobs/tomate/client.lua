--------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------------------------------------------------------------------------------
Tomato = {
    ActualRoute = 1,
    Delay = GetGameTimer()
}

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
--------------------------------------------------------------------------------------------------------------------------------------------------------
function Tomato:StartThread()
    CreateThread(function()
        while true do
            local SLEEP_TIME = 1000
            local ped = PlayerPedId()

            local Coords = tomatoConfig.Routes[self.ActualRoute] and tomatoConfig.Routes[self.ActualRoute].coords or false

            if Coords then
                local dist = #(GetEntityCoords(PlayerPedId()) - Coords)
                if dist <= 300 then
                    SLEEP_TIME = 0
                    DrawMarker(22,Coords[1],Coords[2],Coords[3],0,0,0,0,180.0,130.0,1.0,1.0,0.5, 255,0,0,200 ,1,0,0,1)
                end

                if dist <= 3.0 then
                    if IsControlJustReleased(1, 51) and (self.Delay - GetGameTimer()) <= 0 then
                        LocalPlayer.state.hasCollecting = true
                        self.Delay = (GetGameTimer() + (tomatoConfig.Delay  * 1000) + 2000)
                        
                        vRP._playAnim(false,{{"amb@world_human_gardener_plant@female@base","base_female"}},true)
                        TriggerEvent("Progress", tomatoConfig.Delay)
                       
                        SetTimeout(tomatoConfig.Delay * 1000, function()
                            LocalPlayer.state.hasCollecting = false
                            Tomato.ActualRoute = vTunnel.TomatoCollect(Tomato.ActualRoute)    
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
    Tomato:StartThread()
end)
