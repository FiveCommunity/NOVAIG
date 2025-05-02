


fx_version "bodacious"
game "gta5"

files {
    "web-side/*",
    "web-side/**",
}

ui_page "web-side/index.html"


shared_script "@vrp/lib/utils.lua"

client_scripts {
    "client-side/client.lua"
}

server_scripts {
    "server-side/server.lua",
}