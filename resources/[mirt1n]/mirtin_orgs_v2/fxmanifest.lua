fx_version 'adamant'
game 'gta5'
lua54 'yes'

shared_scripts {
    '@vrp/lib/utils.lua',
    'lib/**',
    'config.lua',
}

server_scripts {
    'server/*.lua',
    'server/modules/*.lua',
}  

client_scripts {
    'client/*.lua',
    'client/modules/*.lua',
}  

ui_page 'web/build/index.html'

files {
	'web/build/index.html',
	'web/build/**/*'
}                            

              

