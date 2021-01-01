function! RunMyCode()
    if executable('fish')
        call Run("fish %")
    else
        echom 'Fish is not installed!'
    endif
endfunction

function s:shellbang() abort
    let options  = [
        \ 'ash',
        \ 'bash',
        \ 'csh',
        \ 'dash',
        \ 'fish',
        \ 'ksh',
        \ 'ion',
        \ 'mksh',
        \ 'pdksh',
        \ 'sh',
        \ 'tcsh',
        \ 'zsh',
        \ 'none'
        \ ]

    unsilent let choice = inputlist([ 'Select your shell:' ]
        \ + map(copy(options), '"[".(v:key+1)."] ".v:val'))

    if choice >= 1 && choice <= (len(copy(options)) - 2)
        if choice == 7
            set ft=ion
        elseif choice == 12
            set ft=zsh
        elseif choice =! 5
            set ft=sh
        endif
        0put = '#!/usr/bin/env ' . (options)[choice - 1]
        call append(line("."), "")
        call append(line("."), "")
	endif
endfunction

command! -bang -nargs=0 -bar ShellBang call <SID>shellbang()
