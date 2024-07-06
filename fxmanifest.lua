shared_script '@radiant-pvp/ai_module_fg-obfuscated.lua'
shared_script '@radiant-pvp/shared_fg-obfuscated.lua'

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Cifuentes'
version '1.0.1'

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua'
}

client_scripts {
    'client/*.lua',
    'shared/*.lua'
}

server_scripts {
    'server/*.lua',
    'shared/*.lua'
}