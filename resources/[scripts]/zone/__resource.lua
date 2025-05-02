lua54 'yes'
--------------  Walkerz #0083 -----------------
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'
client_script {
	'@PolyZone/client.lua',
	"@vrp/lib/utils.lua",
    "client.lua"   
}

server_script {
	"@vrp/lib/utils.lua",
    'server.lua'                            
}

files {
	"web-side/*",
	"web-side/**/*"
}

ui_page "web-side/index.html"              