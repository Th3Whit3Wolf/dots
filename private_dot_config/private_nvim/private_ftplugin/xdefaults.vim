let b:endwise_addition = '#endif'
let b:endwise_words = 'if,ifdef,ifndef'
let b:endwise_pattern = '^\s*#\%(if\|ifdef\|ifndef\)\>'
let b:endwise_syngroups = 'cPreCondit,cPreConditMatch,cCppInWrapper,xdefaultsPreProc'

if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/vim-endwise.vim'))) == 0
    execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/vim-endwise.vim')))
endif

imap <buffer> <CR> <CR><Plug>DiscretionaryEnd