------ -- shared_script '@likizao_ac/client/library.lua'

fx_version 'cerulean'
game 'gta5'

ui_page 'web/build/index.html'

files {"web/**/*"}

lua54 'yes'

shared_scripts {
    '@vrp/lib/utils.lua',
    'shared/*'
}

client_scripts {
    'client/main.lua',
	'client/modules/*'
}

server_scripts {
    'server/prepare.lua',
    'server/main.lua',
    'server/modules/*'
}