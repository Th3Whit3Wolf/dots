packadd conjure
packadd parinfer-rust
packadd fennel.vim

lua require 'plugins.tree_sitter'
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

