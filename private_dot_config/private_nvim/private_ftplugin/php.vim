packadd php.vim
lua require 'plugins.tree_sitter'
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

