let b:endwise_addition='end'
let b:endwise_words='module,class,def,if,unless,case,while,until,begin,do'
let b:endwise_pattern='^\(.*=\)\?\s*\%(private\s\+\|protected\s\+\|public\s\+\|module_function\s\+\)*\zs\%(module\|class\|def\|if\|unless\|case\|while\|until\|for\|\|begin\)\>\%(.*[^.:@$]\<end\>\)\@!\|\<do\ze\%(\s*|.*|\)\=\s*$'
let b:endwise_syngroups='rubyModule,rubyClass,rubyDefine,rubyControl,rubyConditional,rubyRepeat'

function! RunMyCode()
    if InRailsApp()
        if executable('rails')
            call Run("rails runner %")
        else
            echo 'Rails is not installed!'
        endif
    else
        if executable('ruby')
            call Run("ruby %")
        else
            echo 'Ruby is not installed!'
        endif
    endif
endfunction

if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/vim-endwise.vim'))) == 0
    execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/vim-endwise.vim')))
endif

imap <buffer> <CR> <CR><Plug>DiscretionaryEnd