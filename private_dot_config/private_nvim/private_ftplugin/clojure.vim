packadd vim-fireplace
packadd vim-clojure-highlight
packadd conjure
packadd parinfer-rust

lua require 'plugins.tree_sitter'
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
