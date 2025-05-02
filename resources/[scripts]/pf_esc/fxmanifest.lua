
lua54 'yes'

fx_version "adamant"
game "gta5"

ui_page "web/build/index.html"

files {
	'web/*', 
	'web/**/*', 
	'web/**/**/*'
}

shared_script { "@vrp/lib/utils.lua", "lib/*", 'config.lua' }
client_scripts { "@vrp/lib/utils.lua", "client/**/*" }
server_scripts { "@vrp/lib/utils.lua", "server/**/*" }