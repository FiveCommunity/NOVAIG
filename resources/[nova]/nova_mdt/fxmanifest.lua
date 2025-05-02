



fx_version 'cerulean'
game 'gta5'

lua54 'yes'

authors { '_flaviin', 'ruanjkz', 'feijonts_' }

shared_script '@vrp/lib/utils.lua'
client_scripts {
    'client/client.lua',
    'client/modules/*.lua',
}
server_scripts {
    'config/*.lua',
    'server/server.lua',
    'server/modules/*.lua',
}

files {
    'web/build/**',
    'web/build/**/**',
}

ui_page 'web/build/index.html'