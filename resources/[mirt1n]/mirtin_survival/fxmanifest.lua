
lua54 'yes'
fx_version 'bodacious' 
game 'gta5'

client_scripts {
	'@vrp/lib/utils.lua',
	'config/config_client.lua',
	'client.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'config/config_server.lua',
	'server.lua'
}

ui_page 'web/index.html'
files {
	'web/**'
}