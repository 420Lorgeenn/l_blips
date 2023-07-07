fx_version "bodacious"

games {"gta5"}
lua54 'yes'

description 'Skrypt zrobiony przez 420lorgen dla discord.gg/nightside'

files {
  'config.json'
}

client_scripts {
  'client.lua',
}

server_scripts {
  'server.lua',
}

shared_scripts {
  '@ox_lib/init.lua',
  '@es_extended/imports.lua'
}

dependency 'ox_lib'