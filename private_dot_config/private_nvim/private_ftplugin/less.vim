function! CompileMyCode()
    if executable('less')
        call Run("lessc % > %:t:r.css")
    else
        echom 'Less compiler is not installed!'
    endif
endfunction
