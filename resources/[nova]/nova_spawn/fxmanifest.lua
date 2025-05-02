
fx_version   'cerulean'
lua54        'yes'
game         'gta5'

--[[ Resource Information ]]--
name         'lotus_spawn'
author       'boynull'

ui_page 'web/index.html'

files {
    'web/*',
    'web/**/*'
}

--[[ Manifest ]]--
shared_scripts {
    '@vrp/lib/utils.lua',
    'shared/**'
}

server_scripts {
    "server/server.lua",
}

client_scripts {
    "client/client.lua",
    "client/utils.lua"
}