
-- EXAMPLE CREATE MENU OPTIONS
createMenu = {
    ["Outifits"] = {
        ["description"] = "Gerencie suas roupas.",
        ["options"] = {
            {
                ["name"] = "Salvar",
                ["image"] = "vehicle",
                ["description"] = "Guardar as roupas do corpo.",
                ["trigger"] = {
                    ["name"] = "player:outfitFunctions",
                    ["isServer"] = true,
                }
            },
            {
                ["name"] = "Retirar",
                ["image"] = "vehicle",
                ["description"] = "Retirar sua roupa.",
                ["trigger"] = {
                    ["name"] = "player:outfitFunctions",
                    ["isServer"] = true,
                }
            },
            {
                ["name"] = "Deletar",
                ["image"] = "vehicle",
                ["description"] = "Deletar uma roupa salva.",
                ["trigger"] = {
                    ["name"] = "player:outfitFunctions",
                    ["isServer"] = true,
                }
            }
        }
    },

    ["Novak"] = {
        ["description"] = "Teste de.",
        ["image"] = "vehicle",
        ["options"] = {
            {
                ["name"] = "Teste",
                ["description"] = "Teste de descrição.",
                ["trigger"] = {
                    ["name"] = "novak:gostoso",
                    ["isServer"] = false,
                    ["args"] = { 1, "save", 44 }
                }
            }
        }
    }
}

-- EXAMPLE CREATE OPTIONS BUTTONS...

createButton = {
    {
        ["name"] = "Teste",
        ["image"] = "vehicle",
        ["description"] = "Teste de descrição.",
        ["trigger"] = {
            ["name"] = "novak:gostoso",
            ["isServer"] = false,
            ["args"] = { 1, "save", 44 }
        }
    },
    {
        ["name"] = "Teste 2",
        ["image"] = "vehicle",
        ["description"] = "Teste de descrição.",
        ["trigger"] = {
            ["name"] = "novak:gostoso",
            ["isServer"] = false,
            ["args"] = { 99, "ufhwfhuifhui", 42434 }
        }
    },

}


RegisterCommand("nvk", function(src, args)
    if args[1] == "button" then
        exports.nova_dynamic:createButton(createButton)
    else
        exports.nova_dynamic:createMenu(createMenu)
    end
end)


RegisterNetEvent("novak:gostoso")
AddEventHandler("novak:gostoso", function (numeral, texto, numeral2)
    print("Recebido: " .. numeral .. " " .. texto .. " " .. numeral2)
end)