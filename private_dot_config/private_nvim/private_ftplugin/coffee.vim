function! CompileMyCode()
    if executable('coffee')
        call Run("coffee %")
    else
        echom 'Coffe is not installed!'
    endif
endfunction

autocmd BufWritePost *.coffee silent make!