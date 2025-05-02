fx_version "cerulean"
game "gta5"
lua54 'yes'

dependencies {
    'vrp'  
}

shared_scripts {
    "@vrp/lib/utils.lua"
}

client_scripts {
    "doors_client.lua"
}

server_scripts {
    "doors_server.lua"
}

