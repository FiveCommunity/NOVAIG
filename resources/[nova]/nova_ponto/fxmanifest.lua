

--[[ @likizao ]]--

fx_version   'cerulean'
lua54        'yes'
game         'gta5'

--[[ Resource Information ]]--
name         'nova_ponto'
author       'likizao'

--[[ Manifest ]]--
dependencies {
    '/server:5181',
    '/onesync',
    'vrp',
}

shared_scripts {
    '@vrp/lib/utils.lua',
    'shared/**'
}

server_scripts {
    "server/server.lua",
}

client_scripts {
    "client/utils.lua",
    "client/client.lua",
}

ui_page 'web/build/index.html'

files {
    'web/build/**'
}
