
fx_version   'cerulean'
lua54        'yes'
game         'gta5'


shared_scripts {
    '@vrp/lib/utils.lua',
}

server_scripts {
    "server/server.lua",
}

client_scripts {
    "client/client.lua",
}

ui_page 'nui/index.html'

files {
    'nui/**'
}
