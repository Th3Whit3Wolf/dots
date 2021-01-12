packadd vim-closetag
packadd bracey.vim

function! RunMyCode()
    if executable('node')
        call Run("node %")
    else
        echo 'Node is not installed!'
    endif
endfunction

lua require 'plugins.tree_sitter'
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

