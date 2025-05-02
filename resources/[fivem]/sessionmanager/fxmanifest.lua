








lua54 'yes'



fx_version 'adamant'
game 'gta5'   

resource_type 'map' { gameTypes = { ['basic-gamemode'] = true },  name = 'Mirt1n Store' }
map 'map.lua'

client_script { 
    '@vrp/lib/utils.lua',
    'fivem/client.lua',
    'spawnmanager/client.lua',
    'mapmanager/client.lua',
    'mapmanager/shared.lua'
}

server_script { 
    '@vrp/lib/utils.lua',
    'sessionmanager/server.lua',
    'mapmanager/server.lua',
    'mapmanager/shared.lua'
}
                                       