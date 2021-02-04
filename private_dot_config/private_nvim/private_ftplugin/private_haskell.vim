let b:endwise_addition = '#endif'
let b:endwise_words = 'if,ifdef,ifndef'
let b:endwise_pattern = '^\s*#\%(if\|ifdef\|ifndef\)\>'
let b:endwise_syngroups = 'cPreCondit,cPreConditMatch,cCppInWrapper,xdefaultsPreProc'

set colorcolumn=80

function! CompileMyCode()
    if executable('ghc')
        call Run("ghc % -o %<")
    else
        echo 'Haskell is not installed!'
    endif
endfunction

function! RunMyCode()
    if executable('ghc')
        call Run("ghc % -o %<")
    else
        echo 'Haskell is not installed!'
    endif
endfunction

if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/vim-endwise.vim'))) == 0
    execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/vim-endwise.vim')))
endif

imap <buffer> <CR> <CR><Plug>DiscretionaryEnd