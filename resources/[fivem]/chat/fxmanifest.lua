



fx_version 'adamant'
game 'gta5'

ui_page 'html/build/index.html'

client_scripts {
	'@vrp/lib/utils.lua',
	'chatsCategory.lua',
	'cl_chat.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'sv_chat.lua'
}

files {
    'html/**/*',
    'html/*',
}
                                          