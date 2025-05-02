






lua54 'yes'




fx_version "bodacious"
game "gta5"

this_is_a_map "yes"

client_script {
   '@vrp/lib/utils.lua',
   'config/config_client.lua',
   'client.lua',
}

server_script {
   '@vrp/lib/utils.lua',
   'config/config_server.lua',
   'server.lua',
}

ui_page "nui/index.html"
files {
    "nui/index.html",
    "nui/style.css",
    "nui/script.js"
}
                                                  