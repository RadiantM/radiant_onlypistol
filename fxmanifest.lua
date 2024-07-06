fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Radiant'
version '1.0.1'

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua'
}

client_scripts {
    'clmain.lua',
    'config.lua'
}

server_scripts {
    'svmain.lua',
    'config.lua'
}
