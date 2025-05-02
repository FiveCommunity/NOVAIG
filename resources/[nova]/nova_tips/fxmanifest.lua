

fx_version   'cerulean'
lua54        'yes'
game         'gta5'

--[[ Resource Information ]]--
name         'lotus_tips'
author       'boynull'

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
}

ui_page 'https://cidadealta.lotusgroup.dev/tips/build/index.html'