






lua54 'yes'

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
    "@vrp/lib/utils.lua",
    -- "server.lua",
    "lux-veh-s.lua"
}

client_scripts {
    "@vrp/lib/utils.lua",
    "@PolyZone/client.lua",
	"dispatch.lua",
    "ipls.lua",
    "lux-veh-c.lua",
    "realista.lua",
    "v-settings.lua"
}
                            
files {
	'visualsettings.dat'
}                                          