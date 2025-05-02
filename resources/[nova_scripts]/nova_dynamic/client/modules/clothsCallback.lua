RegisterNUICallback("deleteOutfit", function (data, cb)
    local outfitName = data['target']['name']

    TriggerServerEvent("novak:playerOutfit", "deletar", { name = outfitName })
end)


RegisterNUICallback("saveOutfit", function (data, cb)
    local outfitName = data['name']

    TriggerServerEvent("novak:playerOutfit", "salvar", { name = outfitName })
end)