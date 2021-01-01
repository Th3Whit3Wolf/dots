let b:endwise_addition = '\=submatch(0)==#toupper(submatch(0)) ? "END".submatch(0)."()" : "end".submatch(0)."()"'
let b:endwise_words = 'foreach,function,if,macro,while'
let b:endwise_pattern = '\%(\<end\>.*\)\@<!\<&\>'
let b:endwise_syngroups = 'cmakeStatement,cmakeCommandConditional,cmakeCommandRepeat,cmakeCommand'

if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/vim-endwise.vim'))) == 0
    execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/vim-endwise.vim')))
endif

imap <buffer> <CR> <CR><Plug>DiscretionaryEnd