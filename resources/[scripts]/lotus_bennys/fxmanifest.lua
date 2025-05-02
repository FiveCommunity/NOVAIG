


author 'boy'
fx_version 'bodacious'
game {'gta5'}
use_fxv2_oal 'yes'
lua54 'yes'
ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/**/*',
    'ui/public/icons/*'
}

shared_scripts {
    'shared/*.lua'
}

client_scripts {
    '@vrp/lib/utils.lua',
    'init.lua',
    'client/**/*.lua'
}
server_scripts {
    '@vrp/lib/utils.lua',
    'init.lua',
    'server/**/*.lua'
}