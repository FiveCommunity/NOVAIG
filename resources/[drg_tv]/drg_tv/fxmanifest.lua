
fx_version 'cerulean'
game 'gta5'
description 'DRG_TV > 1NOVAK'
version '0.1'

lua54 'yes'

ui_page "web/ui.html"

shared_scripts {
    '@vrp/lib/utils.lua',
    'shared/*',
    'config/config.lua',
}
client_scripts {
    'client/main.lua',
}

server_scripts {
    'server/main.js',
    'server/main.lua',
}

files {
    'web/*',
    'web/**/*',
    'web/**/**/*',
    'config/token.js',
}   