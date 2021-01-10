let b:endwise_addition = '{% end& %}'
let b:endwise_words = 'autoescape,block,cache,call,filter,for,if,macro,raw,set,trans,with'
let b:endwise_syngroups = 'jinjaTagBlock,jinjaStatement'

if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/vim-endwise.vim'))) == 0
    execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/vim-endwise.vim')))
endif

imap <buffer> <CR> <CR><Plug>DiscretionaryEnd