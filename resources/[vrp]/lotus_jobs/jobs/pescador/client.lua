--------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------------------------------------------------------------------------------
Fisher = {
    Delay = GetGameTimer()
}

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
--------------------------------------------------------------------------------------------------------------------------------------------------------
function Fisher:StartThread()
    CreateThread(function()
        while true do
            local ped  = PlayerPedId()
            local SLEEP_TIME = 1000

            for _,cds in pairs(FisherConfig.Locations) do
                local dist = #(GetEntityCoords(PlayerPedId()) - vec3(cds.x,cds.y,cds.z))
                if dist <= 30.0 then
                    SLEEP_TIME = 0
                    DrawMarker(20,cds.x,cds.y,cds.z,0,0,0,0,180.0,130.0, 0.2,0.2,0.2, 255,255,255,200 ,1,0,0,1)
                end

                if dist <= 2.0 then
                    if IsControlJustReleased(1, 51) and (self.Delay - GetGameTimer()) <= 0 then
                        LocalPlayer.state.hasCollecting = true

                        SetEntityCoords(ped, cds.x,cds.y,cds.z-0.8)
                        SetEntityHeading(ped, cds.w)

                        self.Delay = (GetGameTimer() + (FisherConfig.Delay  * 1000) + 2000)
                        vRP._CarregarObjeto("amb@world_human_stand_fishing@idle_a","idle_c","prop_fishing_rod_01",15,60309)
                        TriggerEvent("Progress", FisherConfig.Delay)

                        SetTimeout(FisherConfig.Delay * 1000, function()
                            LocalPlayer.state.hasCollecting = false
                            vTunnel._FisherCollect()

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
    Fisher:StartThread()
end)