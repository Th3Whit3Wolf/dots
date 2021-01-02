packadd vim-closetag
packadd bracey.vim
packadd vim-graphql
packadd vim-jsx-pretty

function! RunMyCode()
    if executable('node')
        call Run("node %")
    else
        echo 'Node is not installed!'
    endif
endfunction

