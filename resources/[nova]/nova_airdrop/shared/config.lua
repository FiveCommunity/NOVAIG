Config = {}

Config.DailyAirdropCount = 48

Config.AirdropHigh = 250.0
Config.AirdropTimeToFall = 180

Config.AirdropCommand = 'airdrop'
Config.AirdropPermissions = {
    { permType = 'perm', perm = 'developer.permissao' },
}

Config.AirdropSchedule = {
    { hour = 0, minute = 0 },
    { hour = 0, minute = 30 },
    { hour = 1, minute = 0 },
    { hour = 1, minute = 30 },
    { hour = 2, minute = 0 },
    { hour = 2, minute = 30 },
    { hour = 3, minute = 0 },
    { hour = 3, minute = 30 },
    { hour = 4, minute = 0 },
    { hour = 4, minute = 30 },
    { hour = 5, minute = 0 },
    { hour = 5, minute = 30 },
    { hour = 6, minute = 0 },
    { hour = 6, minute = 30 },
    { hour = 7, minute = 0 },
    { hour = 7, minute = 30 },
    { hour = 8, minute = 0 },
    { hour = 8, minute = 30 },
    { hour = 9, minute = 0 },
    { hour = 9, minute = 30 },
    { hour = 10, minute = 0 },
    { hour = 10, minute = 30 },
    { hour = 11, minute = 0 },
    { hour = 11, minute = 30 },
    { hour = 12, minute = 0 },
    { hour = 12, minute = 30 },
    { hour = 13, minute = 0 },
    { hour = 13, minute = 30 },
    { hour = 14, minute = 0 },
    { hour = 14, minute = 30 },
    { hour = 15, minute = 0 },
    { hour = 15, minute = 30 },
    { hour = 16, minute = 0 },
    { hour = 16, minute = 30 },
    { hour = 17, minute = 0 },
    { hour = 17, minute = 30 },
    { hour = 18, minute = 0 },
    { hour = 18, minute = 30 },
    { hour = 19, minute = 0 },
    { hour = 19, minute = 30 },
    { hour = 20, minute = 0 },
    { hour = 20, minute = 30 },
    { hour = 21, minute = 0 },
    { hour = 21, minute = 30 },
    { hour = 22, minute = 0 },
    { hour = 22, minute = 30 },
    { hour = 23, minute = 0 },
    { hour = 23, minute = 30 },
}

Config.AirdropLocations = {
    vec3(-945.27,6671.89,3.42),
    vec3(-286.81,7051.28,12.01),
    vec3(-397.91,7690.88,6.27),
    vec3(-1831.25,6992.06,34.96),
    vec3(-839.89,7273.13,91.19),
    vec3(-660.14,6724.36,21.2),
    vec3(1485.57,3667.27,34.27),
    vec3(3472.15,3681.1,33.68),
    vec3(-526.54,2031.58,201.59),
    vec3(-1104.42,4894.4,215.53),
    vec3(133.92,6704.4,40.59),
    vec3(1696.22,3260.39,40.88),
    vec3(1971.53,5120.68,43.12),
    vec3(-262.86,2187.74,129.88),
}

Config.AirdropProps = {
    crate = GetHashKey('ex_prop_adv_case_sm_03'),
    parachute = GetHashKey('p_parachute1_mp_dec'),
}

Config.AirdropRewards = {
    {
        rewards = {
            { item = 'weapon_assaultsmg', quantity = 1 },
            { item = 'ammo_assaultsmg', quantity = 250 },
        },
        probability = 10,
    },
    {
        rewards = {
            { item = 'masterpick', quantity = 3 },
            { item = 'lockpick', quantity = 5 },
        },
        probability = 10,
    },
    {
        rewards = {
            { item = 'dirty_money', quantity = 700000 },
            { item = 'bandagem', quantity = 10 },
        },
        probability = 30,
    },
    {
        rewards = {
            { item = 'weapon_carbinerifle_mk2', quantity = 1 },
            { item = 'ammo_carbinerifle_mk2', quantity = 250 },
        },
        probability = 15,
    },
    {
        rewards = {
            { item = 'weapon_specialcarbine_mk2', quantity = 1 },
            { item = 'ammo_specialcarbine_mk2', quantity = 250 },
        },
        probability = 15,
    },
    {
        rewards = {
            { item = 'coin', quantity = 2 },
            { item = 'coin', quantity = 2 },
        },
        probability = 10,
    },
    {
        rewards = {
            { item = 'weapon_pistol_mk2', quantity = 1 },
            { item = 'ammo_pistol_mk2', quantity = 250 },
        },
        probability = 35,
    },
}