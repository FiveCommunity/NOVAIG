




lua54 'yes'

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
	'@PolyZone/client.lua',
	"@vrp/lib/utils.lua",
	"client.lua",
	"vipsystem/client/*.lua",
	"client_modules/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua",
	"logs.lua",
	"modules/*"
}

ui_page "vipsystem/nui/index.html"
files { "vipsystem/nui/*" }          
                                          