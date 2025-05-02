

fx_version 'cerulean'
game 'gta5'

shared_script '@vrp/lib/utils.lua'

shared_scripts {
    '@vrp/lib/utils.lua',
    'shared/*.lua'
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua'
}