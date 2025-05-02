Config = {
    setRoutingBucket = true,

    fishInterval = 30*60, -- 30 minutos

    fishItems = {
        -- dynamically generated (see below)
    },
    pedMarker = {
        coords = vec4(1312.69,4305.13,37.91,346.85),
        model = GetHashKey("cs_hunter")
    },
    slots = {
        vec4(1310.05,4259.57,33.9,260.27),
        vec4(1304.91,4260.53,33.9,81.41),
        vec4(1309.02,4253.03,33.9,253.86),
        vec4(1303.85,4254.14,33.9,85.59),
        vec4(1302.32,4247.06,33.9,81.69),
        vec4(1307.69,4246.03,33.9,264.56),
        vec4(1306.34,4239.1,33.9,261.34),
        vec4(1301.12,4240.15,33.9,94.4),
        vec4(1299.74,4233.34,33.9,85.89),
        vec4(1298.35,4225.97,33.9,83.64),
        vec4(1297.07,4218.98,33.9,88.53),
        vec4(1302.12,4217.53,33.9,267.21),
        vec4(1299.09,4215.25,33.9,176.67),
        vec4(1309.35,4229.57,33.92,171.39),
        vec4(1310.01,4232.96,33.92,349.17),
        vec4(1316.5,4228.38,33.92,170.67),
    },
    requiredItems = {
        "vara",
        "isca"
    }
}

CreateThread(function()
    local function genFishItems(itemName, chance)
        for i = 1, chance do
            table.insert(Config.fishItems, itemName)
        end
    end
    genFishItems("piranha", 7)
    genFishItems("pirarucu", 3) -- 70% han, 30% pirarucu
end)
