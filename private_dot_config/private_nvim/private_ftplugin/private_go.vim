function! CompileMyCode()
    if executable('go')
        call Run("go build %")
    else
        echo 'Go is not installed!'
    endif
endfunction

function! RunMyCode()
    if executable('go')
        call Run("go run %")
    else
        echo 'Go is not installed!'
    endif
endfunction
