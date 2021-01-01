function! CompileMyCode()
    if executable('scssc')
        call Run("scssc  % > %:t:r.css")
    elseif executable('sass')
        call Run("sassc  % > %:t:r.css")
    else
        echom 'SCSS compiler is not installed!'
    endif
endfunction
