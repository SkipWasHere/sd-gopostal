fx_version 'cerulean'
game 'gta5'

author 'Skipsdev'

discription 'Simple but basic Postal Job'
version '1.0.0'


shared_scripts {
    --'@ox_lib/init.lua',
    --'@es_extended/imports.lua',
    'config.lua'
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

lua54 'yes'


escrow_ignore {
    'config.lua',
}