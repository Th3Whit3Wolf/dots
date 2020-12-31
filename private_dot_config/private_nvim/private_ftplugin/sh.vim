let b:endwise_addition = '\=submatch(0)=="then" ? "fi" : submatch(0)=="case" ? "esac" : "done"'
let b:endwise_words = 'then,case,do'
let b:endwise_pattern = '\%(^\s*\zscase\>\ze\|\zs\<\%(do\|then\)\ze\s*$\)'
let b:endwise_syngroups = 'shConditional,shLoop,shIf,shFor,shRepeat,shCaseEsac,zshConditional,zshRepeat,zshDelimiter'

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
        elseif choice == 7
            set ft=ion
        elseif choice == 12
            set ft=zsh
        endif
        0put = '#!/usr/bin/env ' . (options)[choice - 1]
        call append(line("."), "")
        3
	endif
endfunction

command! -bang -nargs=0 -bar ShellBang call <SID>shellbang()

function! RunMyCode()
    if getline(1)[0:18] ==# "#!/usr/bin/env bash" || getline(1)[0:14] ==# "#!/usr/bin/bash"
        if executable('bash')
                call Run("bash %")
            else
                echom 'Bash is not installed!'
            endif
    elseif getline(1)[0:17] ==# "#!/usr/bin/env csh" || getline(1)[0:13] ==# "#!/usr/bin/csh"
        if executable('csh')
            call Run("csh %")
        else
            echom 'Csh is not installed!'
        endif
    elseif getline(1)[0:18] ==# "#!/usr/bin/env dash" || getline(1)[0:14] ==# "#!/usr/bin/dash"
        if executable('dash')
            call Run("dash %")
        else
            echom 'Dash is not installed!'
        endif
    elseif getline(1)[0:17] ==# "#!/usr/bin/env ksh" || getline(1)[0:13] ==# "#!/usr/bin/ksh"
        if executable('ksh')
            call Run("ksh %")
        else
            echom 'Ksh is not installed!'
        endif
    elseif getline(1)[0:18] ==# "#!/usr/bin/env tcsh" || getline(1)[0:14] ==# "#!/usr/bin/tcsh"
        if executable('tcsh')
            call Run("tcsh %")
        else
            echom 'Tcsh is not installed!'
        endif
    elseif getline(1)[0:13] ==# "#!/usr/bin/env" || getline(1)[0:10] ==# "#!/usr/bin/"
        echom 'I dunno how to handle this shebang'
    else
        echom 'Please set a shebang'
    endif
endfunction

if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/vim-endwise.vim'))) == 0
    execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/vim-endwise.vim')))
endif

imap <buffer> <CR> <CR><Plug>DiscretionaryEnd