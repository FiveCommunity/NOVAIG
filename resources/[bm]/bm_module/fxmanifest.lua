

lua54 'yes'
 --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'bodacious'
game 'gta5'
lua54 ''

ui_page 'scripts/index.html'

shared_scripts {
    '@vrp/lib/utils.lua',
    'lib/*.lua',
    'scripts/**/config.lua'
}

client_scripts {'@vrp/lib/utils.lua', 'client_main.lua', 'scripts/**/client/*.lua'}
server_scripts {'@vrp/lib/utils.lua', 'server_main.lua', 'scripts/**/server/*.lua'}

files {
    'scripts/*',
    'scripts/**/nui/*',
    'scripts/**/nui/**/*',
    'scripts/**/nui/**/**/*',
    'scripts/**/nui/**/**/**/*',
}
              