
lua54 'yes'

fx_version 'bodacious'
game 'gta5'

author '@likizao'
description 'Lotus Apreender'
version '1.0.0'


shared_scripts {
    '@vrp/lib/utils.lua',
    'shared/config.lua',
    'shared/shared.lua',
    '@inventory/config/shared.items.lua',
}

client_script 'client/main.lua'
server_scripts {
    'server/main.lua'
}