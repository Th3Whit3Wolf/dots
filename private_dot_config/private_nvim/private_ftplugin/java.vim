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
