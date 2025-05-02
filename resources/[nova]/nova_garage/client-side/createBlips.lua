CreateThread(function()
    local function createBlipsInMap() -- void
        for i = 1, #garages do
            if types[garages[i].type] ~= nil and types[garages[i].type].blip['showBlip'] then
                local blip = AddBlipForCoord(garages[i].coords[1],garages[i].coords[2],garages[i].coords[3])
                SetBlipSprite(blip, types[garages[i].type].blip['blipId'])
                SetBlipAsShortRange(blip,true)
                SetBlipColour(blip, types[garages[i].type].blip['blipColor'])
                SetBlipScale(blip, types[garages[i].type].blip['blipScale'])
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(types[garages[i].type].blip['name'])
                EndTextCommandSetBlipName(blip)
    
                Wait(150)
            end
        end
    end

    createBlipsInMap() -- void
end)