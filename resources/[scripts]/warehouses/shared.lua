TaxDays = 15
TaxPrice = 0.15 --[[ 10% DO VALOR DA PROPRIEDADE ]]
RemoveDays = 3


WarehouseState = vec3(8.79,-243.28,47.65)
GaragePrice = 25000
Warehouses = { 
    ["Apartamento1"] = { 
        Id = 1,
        Chest = vec3(9.67,-248.39,47.67),
        Price = 10000, --[[ PREÇO DE COMPRA ]]
        Weight = { Default = 1000 --[[PESO INICIAL E QUE AUMENTA A CADA COMPRA]], Max = 10000, Buy = 150000 --[[PREÇO DE COMPRA]]  }, 
        Slots = 3, --[[LIMITE DE PESSOAS]]
        Image = "https://cdn.discordapp.com/attachments/1153339523091157072/1249854020894588989/Sem_Titulo-1.png?ex=6668d0c3&is=66677f43&hm=3ed0387ece46d27874b1763761d55616c4edadb16b8a3d237f902893832d09d1&"
    },
}

exports("List",function()
    return Warehouses
end)