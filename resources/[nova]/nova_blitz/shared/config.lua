Config = {}

Config.MainCommand = 'blitz'

Config.Permissions = {
    { permType = 'group', perm = 'developerlotusgroup@445' },
    { permType = 'perm', perm = 'perm.blitz', checkService = true },
}


Config.Props = {
    ['wall'] = GetHashKey('prop_mp_barrier_02b'),
    ['wall2'] = GetHashKey('prop_mp_conc_barrier_01'),
    ['cone'] = GetHashKey('prop_mp_cone_01'),
    ['high-cone'] = GetHashKey('prop_mp_cone_04'),
    ['rounded-cone'] = GetHashKey('prop_mp_cone_02'),
    ['nails'] = GetHashKey('p_ld_stinger_s'),
    ['barricade'] = GetHashKey('prop_barrier_work06a'),
    ['barricade2'] = GetHashKey('prop_barrier_work01a'),
}