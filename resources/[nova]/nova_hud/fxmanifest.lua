
fx_version "cerulean"
game "gta5"

ui_page "web/build/index.html"

files {
	'web/*', 
	'web/**/*', 
	'web/**/**/*'
}

client_scripts {
	"@vrp/lib/utils.lua",
	'@PolyZone/client.lua',
	"client-side/*",
	"cfg/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server-side/server.lua",
	"server-side/notify.lua",
	"cfg/*"
}