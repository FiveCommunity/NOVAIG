CreateThread(function()
    while true do
        local SLEEP_TIME = 1000

        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)

        for i = 1, #ConfigDrugs.Locations do
            local coords = ConfigDrugs.Locations[i].coords
            local dist = #(pedCoords - coords)
            if dist <= 5.0 then
                SLEEP_TIME = 0
                DrawText3D(coords[1],coords[2],coords[3], "Pressione ~g~E~w~ para fabricar ~b~"..ConfigDrugs.Locations[i].type.."~w~.")
                if IsControlJustPressed(0,38) and dist < 2 then
                    TriggerEvent("Progress", ConfigDrugs.Locations[i].seconds * 1000, 'Coletando')
                    vRP._playAnim(false,{{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}},true)
                    
                    SetTimeout(ConfigDrugs.Locations[i].seconds * 1000, function()
                        ClearPedTasks(ped)
                        vTunnel._craftDrug(ConfigDrugs.Locations[i].type)
                    end)
                end
            end
        end


        Wait( SLEEP_TIME )
    end
end)