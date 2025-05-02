CreateThread(function()
    SetNuiFocus(false,false) -- ?

    local function createBlipsInMap() -- void
        for index, parameters in pairs(locateShops) do
            if parameters[4] then
                blipsInMap[index] = AddBlipForCoord(parameters[1],parameters[2],parameters[3])
                SetBlipSprite(blipsInMap[index], 73)
                SetBlipColour(blipsInMap[index], 49)
                SetBlipScale(blipsInMap[index], 0.5)
                SetBlipAsShortRange(blipsInMap[index], true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Loja de Roupas")
                EndTextCommandSetBlipName(blipsInMap[index])
            end
        end
    end

    createBlipsInMap() -- void
end)