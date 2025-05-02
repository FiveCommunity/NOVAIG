



fx_version 'cerulean'
game 'gta5'

shared_script { '@vrp/lib/utils.lua', 'lib/*.lua', 'config.lua' }

client_script {
	"@vrp/lib/utils.lua",
	"client/*.lua"
}

server_scripts{ 
	"@vrp/lib/utils.lua",
	"server/*.lua"
}

files {
	'web/**/*',
}
ui_page 'web/index.html'
                                          