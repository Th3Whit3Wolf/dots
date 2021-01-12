let b:endwise_addition = '\="end" . submatch(0)'
let b:endwise_words = 'ifdef,ifndef,ifeq,ifneq,define'
let b:endwise_pattern = '^\s*\(d\zsef\zeine\|\zsif\zen\=\(def\|eq\)\)\>'
let b:endwise_syngroups = 'makePreCondit,makeDefine'

if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/vim-endwise.vim'))) == 0
    execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/vim-endwise.vim')))
endif

imap <buffer> <CR> <CR><Plug>DiscretionaryEnd