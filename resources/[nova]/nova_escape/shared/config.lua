Config = {}

Config.TrashProp = `prop_bin_14a`

Config.CraftItem = 'desbloqueadorsinal'

Config.TrashCooldown = 60

Config.PrisonEscapeTime = 15

Config.CraftNecessaryItems = {
    { item = 'grampoprison', amount = 1 },
    { item = 'moldeprison', amount = 1 }
}

Config.ItemsToEscape = {
    Rare = {
        { item = 'grampoprison', amount = 1 },
        { item = 'moldeprison', amount = 1 }
    },
    Common = {
        { item = 'copoprison', amount = 1 },
        { item = 'ferroprison', amount = 1 },
        { item = 'cobreprison', amount = 1 },
        { item = 'pedraprison', amount = 1 },
        { item = 'papelprison', amount = 1 },
        { item = 'maconhaprison', amount = 1 },
        { item = 'crackprison', amount = 1 },
        { item = 'plasticoprison', amount = 1 },
        { item = 'garrafaquebradaprison', amount = 1 },
        { item = 'pedacoarameprison', amount = 1 },
        { item = 'tijoloprison', amount = 1 },
        { item = 'dedodecepadoprison', amount = 1 }
    }
}

Config.ProbabilityRanges = {
    RareItems = { min = 0, max = 5 },
    CommonItems = { min = 6, max = 60 },
    NoItem = { min = 61, max = 100 },
}

Config.TrashLocations = {
    vec3(1646.23,2565.55,45.54),
    vec3(1656.84,2548.92,45.54),
    vec3(1654.22,2530.66,45.54),
    vec3(1648.4,2512.04,45.54),
    vec3(1695.74,2490.73,45.54),
    vec3(1717.68,2508.39,45.54),
    vec3(1750.79,2535.29,45.54),
    vec3(1740.91,2554.83,45.54),
    vec3(1716.55,2567.81,45.54),
    vec3(1616.46,2524.29,45.54),
}

Config.EscapeLocations = {
    vec3(1818.28,2592.66,45.68),
}

Config.CraftLocations = {
    vec3(1619.46,2519.91,45.85)
}

Config.Doors = {
    { coords = vec3(1818.2,2594.35,45.68), hash = 705715602 },
}