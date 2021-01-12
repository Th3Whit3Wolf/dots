packadd dart-vim-plugin

let g:dart_html_in_string=v:true
let g:dart_style_guide = 2
let g:dart_format_on_save = 1

lua require 'plugins.tree_sitter'
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

