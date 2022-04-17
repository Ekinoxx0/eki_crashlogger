fx_version "adamant"
game "gta5"
lua54 'yes'

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"server.lua",
}

client_scripts {
	"client.lua",
}
