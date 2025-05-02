


fx_version 'bodacious'
game "gta5"

author "Mirt1n#9985"
description "Mirt1n Store - https://discord.gg/MPm3Pptfn5"
api_version "1.0"

shared_script { '@vrp/lib/utils.lua', "lib/*.lua", "config.lua" }
client_script { '@vrp/lib/utils.lua', 'client.lua', }
server_script { '@vrp/lib/utils.lua', 'server.lua', }

ui_page "ui/index.html"
files { 'ui/**/*' }    
              