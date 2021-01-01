let b:endwise_addition = 'endsnippet'
let b:endwise_words = 'snippet'
let b:endwise_syngroups = 'snipSnippet,snipSnippetHeader,snipSnippetHeaderKeyword'

if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/vim-endwise.vim'))) == 0
    execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/vim-endwise.vim')))
endif

imap <buffer> <CR> <CR><Plug>DiscretionaryEnd