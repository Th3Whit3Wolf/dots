let g:lua_syntax_fancynotequal = 1

let b:endwise_addition = 'end'
let b:endwise_words = 'function,do,then'
let b:endwise_pattern = '^\s*\zs\%(\%(local\s\+\)\=function\)\>\%(.*\<end\>\)\@!\|\<\%(then\|do\)\ze\s*$'
let b:endwise_syngroups = 'luaFunction,luaStatement,luaCond'

lua << EOF
require('myplugins/lsp_install_prompt').lsp_installed()
EOF

if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/vim-endwise.vim'))) == 0
    execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/vim-endwise.vim')))
endif

imap <buffer> <CR> <CR><Plug>DiscretionaryEnd