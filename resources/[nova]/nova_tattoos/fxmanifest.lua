


fx_version "bodacious"
game "gta5"

ui_page "http://cidadealta.lotusgroup.dev/tattoos/build/index.html"

shared_scripts {
	"shared/*.lua"
}

client_scripts {
	"@vrp/lib/utils.lua",
	"client/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server/*"
}