
fx_version 'bodacious'
game 'gta5'

files {
    'ui/*',
    'ui/**/*',
}

ui_page 'ui/index.html'


shared_scripts {
    '@vrp/lib/utils.lua',
} 

client_scripts {
    'client/*.lua',
}

server_scripts {
    'config/*.lua',
    'server/*.lua',
}