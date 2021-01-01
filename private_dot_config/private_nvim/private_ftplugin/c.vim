let b:endwise_addition = '#endif'
let b:endwise_words = 'if,ifdef,ifndef'
let b:endwise_pattern = '^\s*#\%(if\|ifdef\|ifndef\)\>'
let b:endwise_syngroups = 'cPreCondit,cPreConditMatch,cCppInWrapper,xdefaultsPreProc'

function! CompileMyCode()
    if executable('gcc')
        call Run("gcc % -o %< -Wall -Wextra -Wshadow -Wdouble-promotion -Wformat=2 -Wformat-truncation -Wformat-overflow -Wundef -fno-common -ffunction-sections -fdata-sections -O0")
    endif
endfunction

function! RunMyCode()
    if executable('gcc')
        call Run("gcc % -o %<  -Wall -Wextra -Wshadow -Wdouble-promotion -Wformat=2 -Wformat-truncation -Wformat-overflow -Wundef -fno-common -ffunction-sections -fdata-sections -O0 ; ./%<")
    endif
endfunction

lua << EOF
require('myplugins/lsp_install_prompt').lsp_installed()
EOF

if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/vim-endwise.vim'))) == 0
    execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/vim-endwise.vim')))
endif

imap <buffer> <CR> <CR><Plug>DiscretionaryEnd
