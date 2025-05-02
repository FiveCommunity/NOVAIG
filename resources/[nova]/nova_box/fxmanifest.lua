
fx_version 'adamant'
game 'gta5'

lua54 'yes'

shared_scripts { "@vrp/lib/utils.lua", 'shared/tunnel.lua', 'shared/config.lua' }
client_scripts { 'client/**/*.lua', 'client/*.lua' }
server_scripts { 'server/**/*.lua', 'server/*.lua' }

ui_page 'web/index.html'

files {
	'web/index.html',
	'web/**/*',
}              