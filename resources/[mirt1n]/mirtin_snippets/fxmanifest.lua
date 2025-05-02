








lua54 'yes'


fx_version 'adamant'
game 'gta5'

ui_page 'web-site/nui/ui.html'

client_script {
   '@PolyZone/client.lua',
   '@vrp/lib/utils.lua',
   'config/*',
   'others-client/main.lua',
}

server_script {
   '@vrp/lib/utils.lua',
   'config/*',
   'others-server/main.lua',
}

files {
	'web-site/nui/**/*',
	'web-site/nui/*'
}
                                          