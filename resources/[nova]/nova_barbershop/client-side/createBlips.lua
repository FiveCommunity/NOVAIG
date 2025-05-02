CreateThread(function()
    local function createBlipInMap() -- void
        for index, parameters in pairs(locations) do
            if parameters[4] then
                blipsInMap[index] = AddBlipForCoord(parameters[1], parameters[2], parameters[3])
                SetBlipSprite(blipsInMap[index], 71)
                SetBlipColour(blipsInMap[index], 49)
                SetBlipScale(blipsInMap[index], 0.5)
                SetBlipAsShortRange(blipsInMap[index], true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Barbearia")
                EndTextCommandSetBlipName(blipsInMap[index])
            end
        end
    end

    createBlipInMap() -- void
end)