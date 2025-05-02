fx_version 'cerulean'
game 'gta5'

lua54 'yes'

client_scripts {
    '@PolyZone/client.lua',
    "@vrp/lib/utils.lua",
    "client.lua"
}

server_scripts {
    "@vrp/lib/utils.lua",
    "server.lua"
}

files {
    "web-side/*",
    "web-side/**/*"
}

ui_page "web-side/index.html"
