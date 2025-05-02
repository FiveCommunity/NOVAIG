

fx_version "bodacious"
game "gta5"

files {
    "web/*",
    "web/**",
    "web/**/*",
}

ui_page "web/index.html"


shared_scripts {
    "@vrp/lib/utils.lua",
    "shared.lua"
}

client_scripts {
    "client-side/client.lua"
}

server_scripts {
    "server-side/server.lua",
}