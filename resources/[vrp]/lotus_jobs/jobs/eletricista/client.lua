--------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------------------------------------------------------------------------------
Eletricist = {
    inService = false,
    ActualRoute = 1,
    Delay = GetGameTimer(),
    Ladder = nil,
    LadderHand = nil,
    LadderStatus = false,
    LadderInHand = false,
    blip = nil
}

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
--------------------------------------------------------------------------------------------------------------------------------------------------------
function Eletricist:StartThread()
    CreateThread(function()
        local myPlate = vTunnel.myRegistration()

        while Eletricist.inService do
            local SLEEP_TIME = 1000
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)

            local vehicle = GetNerarestVehicle(5.0)
            if vehicle and not IsPedInAnyVehicle(ped) then
                if GetEntityModel(vehicle) == GetHashKey(eletricistConfig.Vehicle) and GetVehicleNumberPlateText(vehicle):gsub(" ", "") == myPlate then
                    local Coords = GetEntityCoords(vehicle)
                    local distVeh = #(Coords - pedCoords)

                    if distVeh <= 5.0 then
                        SLEEP_TIME = 0

                        if Eletricist.LadderInHand then
                            DrawText3D(Coords.x,Coords.y,Coords.z+0.3,'Pressione ~b~E~w~ para ~r~guardar~w~ a escada')

                            if IsControlJustReleased(1, 51) then
                                Eletricist.LadderInHand = false
                                
                                if Eletricist.LadderHand then
                                    if DoesEntityExist(Eletricist.LadderHand) then
                                        DeleteEntity(Eletricist.LadderHand)
                                    end
                                end

                                ClearPedTasks(ped)
                            end
                        else
                            DrawText3D(Coords.x,Coords.y,Coords.z+0.3,'Pressione ~b~E~w~ para ~g~pegar~w~ a escada')

                            if IsControlJustReleased(1, 51) then
                                Eletricist.LadderInHand = true

                                Eletricist.LadderHand = CreateObject(GetHashKey("prop_byard_ladder01"), 0, 0, 0, true, true, true)

                                StartAnim('amb@world_human_muscle_free_weights@male@barbell@idle_a', 'idle_a') 
                                AttachEntityToEntity(Eletricist.LadderHand, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.05, 0.1, -0.3, 300.0, 100.0, 20.0, true, true, false, true, 1, true)
                            end
                        end
                    end
                    
                end
            end

            -- ESCADA
            local Coords = eletricistConfig.Routes[self.ActualRoute] and eletricistConfig.Routes[self.ActualRoute].coords or false
            if Coords then
                local dist = #(GetEntityCoords(ped) - vec3(Coords.x,Coords.y,Coords.z))

                -- CONSERTANDO POSTE
                if dist <= 50 then
                    SLEEP_TIME = 0

                    if Eletricist.LadderStatus then
                        DrawText3Ds(Coords.x, Coords.y, Coords.z-0.5, "Suba a ~g~escada~w~ e conserte o poste.")
                        DrawMarker(22,Coords.x,Coords.y, eletricistConfig.Routes[self.ActualRoute].top,0,0,0,0,180.0,130.0,1.0,1.0,0.5, 255,0,0,200 ,1,0,0,1)

                        if #(GetEntityCoords(ped) - vec3(Coords.x,Coords.y, eletricistConfig.Routes[self.ActualRoute].top)) <= 2.0 then
                            if IsControlJustReleased(1, 51) then
                                vRP.CarregarObjeto("amb@world_human_hammering@male@base","base", "prop_tool_hammer",49,28422)
                                TriggerEvent("progress",5)

                                SetTimeout(5 * 1000, function()
                                    vRP.DeletarObjeto()
                                    ClearPedTasks(ped)

                                    Eletricist.ActualRoute = vTunnel.EletricistCollect(Eletricist.ActualRoute)    
                                    Eletricist.LadderStatus = false

                                    Eletricist:createCheckpoint(eletricistConfig.Routes[Eletricist.ActualRoute].coords)
                                end)
                            end
                        end

                    else
                        DrawText3Ds(Coords.x, Coords.y, Coords.z-0.5, "Pressione ~b~E~w~ para colocar a escada.")
                    end
                end

                -- COLOCANDO ESCADA
                if dist <= 3.0 and not Eletricist.LadderStatus then
                    if IsControlJustReleased(1, 51) and (self.Delay - GetGameTimer()) <= 0 then
                        if Eletricist.LadderInHand  then
                            Eletricist.LadderInHand = false
                            if Eletricist.LadderHand then
                                if DoesEntityExist(Eletricist.LadderHand) then
                                    DeleteEntity(Eletricist.LadderHand)
                                end
                            end
    
                            Eletricist.LadderStatus = true
                            if Eletricist.Ladder then
                                if DoesEntityExist(Eletricist.Ladder) then
                                    DeleteEntity(Eletricist.Ladder)
                                end
                            end
    
                            vRP._playAnim(false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}}, true)
                            SetTimeout(5 * 1000, function()
                                local HashKey = GetHashKey("hw1_06_ldr_")
                                Eletricist.Ladder = CreateObject(HashKey, Coords.x, Coords.y, Coords.z)
                                PlaceObjectOnGroundProperly(Eletricist.Ladder)
                                SetEntityHeading(Eletricist.Ladder, Coords.h)
                                FreezeEntityPosition(Eletricist.Ladder, true)
                                SetEntityAsMissionEntity(Eletricist.Ladder, true, true)
    
    
                                ClearPedTasks(ped)
                            end)			
                        else
                            TriggerEvent("Notify", "negado", "Você precisa pegar a escada no carro.",5000)
                        end
                    end
                end

            end

            Wait( SLEEP_TIME )
        end
    end)
end

CreateThread(function()
    while true do
        local SLEEP_TIME = 1000
        
        if not Eletricist.inService then
            local dist = #(GetEntityCoords(PlayerPedId()) - vec3(eletricistConfig.Init.x,eletricistConfig.Init.y,eletricistConfig.Init.z))
            if dist <= 10.0 then
                SLEEP_TIME = 0
                DrawText3D(eletricistConfig.Init.x,eletricistConfig.Init.y,eletricistConfig.Init.z, "Pressione ~b~ E ~w~ para iniciar o emprego de ~b~Eletricista.")

                if IsControlJustReleased(1, 51) then
                    Eletricist.inService = true

                    Eletricist:StartThread()
                    TriggerEvent("Notify", "sucesso", "Foi marcado no seu GPS o destino do seu cliente.",5000)

                    Eletricist:createCheckpoint(eletricistConfig.Routes[Eletricist.ActualRoute].coords)
                end
            end
        else
            SLEEP_TIME = 0
            drawTxt("~w~APERTE ~r~F7~w~ PARA FINALIZAR O EXPEDIENTE.", 0.215,0.94)
            if IsControlJustPressed(0, 168) then
                Eletricist.inService = false
                RemoveBlip(Eletricist.blip)

                vRP._stopAnim(false)
                vRP._DeletarObjeto()
            end
        end

        Wait( SLEEP_TIME )
    end
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- OTHERS FUNCTIONS
--------------------------------------------------------------------------------------------------------------------------------------------------------
function Eletricist:createCheckpoint(coords)
    if self.blip then
        RemoveBlip(self.blip)
    end

    self.blip = AddBlipForCoord(coords.x,coords.y,coords.z)
    SetBlipSprite(self.blip,566)
    SetBlipColour(self.blip,5)
    SetBlipScale(self.blip,0.4)
    SetBlipAsShortRange(self.blip,false)
    SetBlipRoute(self.blip,true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Consertar Poste")
    EndTextCommandSetBlipName(self.blip)
end

StartAnim = function(lib, anim)
    RequestAnimDict(lib)
    while not HasAnimDictLoaded(lib) do
        Wait(1)
    end
    TaskPlayAnim(PlayerPedId(), lib, anim ,8.0, -8.0, -1, 50, 0, false, false, false)
end

-- local in_creator = false
-- local SpawnObject = nil
-- RegisterCommand('kobe_gay', function(source,args)
--     CreateThread(function()
--         in_creator = true

--         local pedCoords = GetEntityCoords(PlayerPedId())
--         local HashKey = GetHashKey("hw1_06_ldr_")

--         SpawnObject = CreateObject(HashKey, pedCoords.x, pedCoords.y, pedCoords.z)
--         PlaceObjectOnGroundProperly(SpawnObject)
--         SetEntityHeading(SpawnObject, GetEntityHeading(PlayerPedId()))
--         FreezeEntityPosition(SpawnObject, true)
--         SetEntityAsMissionEntity(SpawnObject, true, true)

--         SetEntityDrawOutline(SpawnObject, true)
--         SetEntityDrawOutlineColor(0, 255, 0, 150)

--         FreezeEntityPosition(PlayerPedId(), true)

--         while in_creator do
--             if IsControlJustPressed(1,32) then
--                 local entCoords = GetEntityCoords(SpawnObject)
--                 SetEntityCoords(SpawnObject, entCoords.x + 0.2, entCoords.y, entCoords.z)
--             end

--             if IsControlJustPressed(1,33) then
--                 local entCoords = GetEntityCoords(SpawnObject)
--                 SetEntityCoords(SpawnObject, entCoords.x - 0.2, entCoords.y, entCoords.z)
--             end

--             if IsControlJustPressed(1,34) then
--                 local entCoords = GetEntityCoords(SpawnObject)
--                 SetEntityCoords(SpawnObject, entCoords.x, entCoords.y + 0.2, entCoords.z)
--             end

--             if IsControlJustPressed(1,35) then
--                 local entCoords = GetEntityCoords(SpawnObject)
--                 SetEntityCoords(SpawnObject, entCoords.x, entCoords.y - 0.2, entCoords.z)
--             end

--             if IsControlJustPressed(1,38) then
--                 local entCoords = GetEntityCoords(SpawnObject)
--                 SetEntityHeading(SpawnObject, GetEntityHeading(SpawnObject) + 5.0)
--             end

--             if IsControlJustPressed(1,45) then
--                 local entCoords = GetEntityCoords(SpawnObject)
--                 SetEntityHeading(SpawnObject, GetEntityHeading(SpawnObject) - 5.0)
--             end


--             if IsControlJustPressed(1,176) then
--                 in_creator = false
--                 local entCoords = GetEntityCoords(SpawnObject)
--                 local entHeading = GetEntityHeading(SpawnObject)

--                 vRP.prompt('Enfie no CU', ('vec4(%s,%s,%s,%s)'):format(entCoords.x,entCoords.y,entCoords.z,entHeading))
--             end

--             Wait(0)
--         end

--         FreezeEntityPosition(PlayerPedId(), false)
--     end)
-- end)


-- RegisterCommand('altura', function(source,args)
--     local plyCoords = GetEntityCoords(PlayerPedId())
--     vRP.prompt('Enfie no CU', ('%s'):format(plyCoords.z))

--     DeleteEntity(SpawnObject)
-- end)