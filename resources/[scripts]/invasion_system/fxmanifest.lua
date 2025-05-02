


fx_version 'bodacious'
author 'boynull'
lua54 'yes'
game 'gta5'
ui_page_preload 'yes'

ui_page 'web/build/index.html'

shared_scripts {
    '@vrp/lib/utils.lua',
    'shared/*.lua',
}

client_scripts {
    'client/*.lua',
    'client/zone/creator.lua',
    'client/zone/zone.lua',
}
server_scripts {
    'server/*.lua',
}

files {
    'web/build/*',
    'web/build/**/*',
    'web/build/**/**/*',
}