function! CompileMyCode()
    if executable('javac')
        call Run("javac %")
    else
        echo 'Java is not installed!'
    endif
endfunction

function! RunMyCode()
    if executable('javac')
        call Run("javac %")
    else
        echo 'Java is not installed!'
    endif
endfunction

lua require 'plugins.tree_sitter'
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()


