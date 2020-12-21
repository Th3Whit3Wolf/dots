syntax enable
filetype plugin indent on

lua require 'init'

" Packer commands (dressed like vim-plug)
" Only install missing plugins
command! PlugInstall execute 'luafile ' . stdpath('config') . '/lua/plug.lua' | packadd packer.nvim | lua require('plug').install()
" Update and install plugins
command! PlugUpdate  execute 'luafile ' . stdpath('config') . '/lua/plug.lua' | packadd packer.nvim | lua require('plug').update()
" Remove any disabled or unused plugins
command! PlugClean   execute 'luafile ' . stdpath('config') . '/lua/plug.lua' | packadd packer.nvim | lua require('plug').clean()
" Recompiles lazy loaded plugins
command! PlugCompile execute 'luafile ' . stdpath('config') . '/lua/plug.lua' | packadd packer.nvim | lua require('plug').compile()
" Performs `PlugClean` and then `PlugUpdate`
command! PlugSync    execute 'luafile ' . stdpath('config') . '/lua/plug.lua' | packadd packer.nvim | lua require('plug').sync()
" Check if lsp is installed for current filetype
"api.nvim_command("command! CheckLSP lua require('myplugins/lsp_install_prompt').check_lsp_installed()
