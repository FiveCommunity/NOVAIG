






lua54 'yes'


fx_version "cerulean"
game "gta5"
author 'decibel#0001'
ui_page "web/index.html"

files {
	"web/*",
	"web/**/*",
}

client_scripts {
    "@vrp/lib/utils.lua",
    "client/*"
}

server_scripts {
    "@vrp/lib/utils.lua",
    "server/*",
}