


lua54 'yes'
 --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'bodacious'
game 'gta5'
lua54 ''

shared_scripts { '@vrp/lib/utils.lua', 'lib/*.lua', 'scripts/**/config/config.lua' }
client_scripts {'@vrp/lib/utils.lua', 'client_main.lua', 'scripts/**/client/*.lua'}
server_scripts {'@vrp/lib/utils.lua', 'server_main.lua', 'scripts/**/server/*.lua'}

ui_page 'web/index.html'

files {
    'web/*',
    'web/**/*',
    'web/**/**/*'
}