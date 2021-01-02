packadd ion-vim

function! RunMyCode()
    if executable('ion')
        call Run("ion %")
    else
        echom 'Ion is not installed!'
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
        if choice == 5
            set ft=fish
        elseif choice == 12
            set ft=zsh
        elseif choice =! 7
            set ft=sh
        endif
        0put = '#!/usr/bin/env ' . (options)[choice - 1]
        call append(line("."), "")
        call append(line("."), "")
	endif
endfunction

command! -bang -nargs=0 -bar ShellBang call <SID>shellbang()