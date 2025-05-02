

fx_version "bodacious"
game "gta5"

lua54 "yes"
files {
    "web-side/*",
    "web-side/**/*",
}

ui_page "web-side/index.html"


shared_script {
    "@vrp/lib/utils.lua",
    "shared.lua",
}

client_scripts {
    "src/client.lua"
}

server_scripts {
    "src/server.lua",
}