
lua54 'yes'

fx_version 'cerulean'
game 'gta5'

author 'Lotus'
description 'Lotus Access'
version '1.0.0'

ui_page 'web/index.html'

files {
    'web/**'
}

shared_scripts {
    '@vrp/lib/utils.lua',
    'shared/**'
}

client_script 'client/main.lua'
server_script 'server/main.lua'
