
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Feijonts <https://github.com/joaowcitino>'

ui_page 'https://cidadealta.lotusgroup.dev/raffle/build/index.html'

shared_scripts {
    '@vrp/lib/utils.lua',
    'shared/*.lua',
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua',
}