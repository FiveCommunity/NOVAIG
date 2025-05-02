

fx_version   'bodacious'
lua54        'yes'
game         'gta5'

dependencies {
    '/onesync',
}

shared_scripts {
    '@vrp/lib/utils.lua',
    'config/shared.*.lua'
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
    "server/main.lua",
    "server/utils/**",
    'config/server.*.lua',
    "server/modules/**",
}

client_scripts {
    "client/main.lua",
    "client/utils/**",
    "client/modules/**",
}

ui_page 'web/index.html'

files {
    "web/**/*"
}