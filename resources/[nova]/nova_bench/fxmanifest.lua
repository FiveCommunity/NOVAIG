
lua54 'yes'

fx_version 'bodacious'
game 'gta5'

author '@likizao'
description 'Lotus Sales'
version '1.0.0'

ui_page 'web/build/index.html'

files {
    'web/build/**'
}

shared_scripts {
    '@vrp/lib/utils.lua',
    'shared/config.lua',
    'shared/shared.lua',
    '@inventory/config/shared.items.lua',
}

client_script 'client/main.lua'
server_scripts {
    'server/prepare.lua',
    'server/main.lua'
}
