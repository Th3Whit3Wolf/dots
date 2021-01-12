let c_no_curly_error = 1
let b:endwise_addition = '@end'
let b:endwise_words = 'interface,implementation'
let b:endwise_pattern = '^\s*@\%(interface\|implementation\)\>'
let b:endwise_syngroups = 'objcObjDef'

if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/vim-endwise.vim'))) == 0
    execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/vim-endwise.vim')))
endif

imap <buffer> <CR> <CR><Plug>DiscretionaryEnd