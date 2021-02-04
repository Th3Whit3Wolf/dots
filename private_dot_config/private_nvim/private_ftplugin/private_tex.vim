call lexical#init()
call pencil#init()

let b:endwise_addition = '\="\\end" . matchstr(submatch(0), "{.\\{-}}")'
let b:endwise_words = 'begin'
let b:endwise_pattern = '\\begin{.\{-}}'
let b:endwise_syngroups = 'texSection,texBeginEnd,texBeginEndName,texStatement'

let g:tex_flavor="latex"
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'

if exist('zathura')
    let g:vimtex_view_method='zathura'
endif

set conceallevel=1
setl updatetime=100

function! CompileMyCode()
    if executable('latexmk')
        call Run("latexmk -pdf %")
    elseif executable('latexrun')
        call Run("latexrun %")
    elseif executable('textonic')
        call Run("textonic %")
    endif
endfunction

function! RunMyCode()
    LLPStartPreview
endfunction

if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/vim-endwise.vim'))) == 0
    execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/vim-endwise.vim')))
endif

imap <buffer> <CR> <CR><Plug>DiscretionaryEnd