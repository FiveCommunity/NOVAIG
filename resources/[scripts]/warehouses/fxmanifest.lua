

fx_version "bodacious"
game "gta5"

files {
  "web/build/*",
  "web/build/**/*",
}

ui_page "web/build/index.html"


shared_scripts {
  "shared.lua",
  "@vrp/lib/utils.lua"
}

client_scripts {
  "client/client.lua",
  "client/routes.lua"
}

server_scripts {
  "server/server.lua",
}