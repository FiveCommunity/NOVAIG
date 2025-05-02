
fx_version "cerulean"
game "gta5"
author "_flaviin"

shared_script "@vrp/lib/utils.lua"

client_scripts {
  "client/*.lua"
}
server_scripts {
  "server/*.lua"
}

files {
  "web/*",
  "web/**/*",
}

ui_page "web/index.html"              