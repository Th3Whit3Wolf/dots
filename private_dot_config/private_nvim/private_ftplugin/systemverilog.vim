let b:endwise_addition = '\="end" . submatch(0)'
let b:endwise_words = 'begin,module,case,function,primitive,specify,task'
let b:endwise_pattern = '\<\%(\zs\zebegin\|module\|case\|function\|primitive\|specify\|task\)\>.*$'
let b:endwise_syngroups = 'verilogConditional,verilogLabel,verilogStatement'

if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/vim-endwise.vim'))) == 0
    execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/vim-endwise.vim')))
endif

imap <buffer> <CR> <CR><Plug>DiscretionaryEnd