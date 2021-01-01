packadd vimtex
packadd vim-latex-live-preview
packadd vim-lexical
packadd vim-pencil
packadd vim-ditto

DittoOn

call lexical#init()
call pencil#init()

let b:endwise_addition = '\="\\end" . matchstr(submatch(0), "{.\\{-}}")'
let b:endwise_words = 'begin'
let b:endwise_pattern = '\\begin{.\{-}}'
let b:endwise_syngroups = 'texSection,texBeginEnd,texBeginEndName,texStatement'

let g:lexical#thesaurus = ['~/.config/nvim/thesaurus/mthesaur.txt', '~/.config/nvim/moby_thesaurus.txt']
let g:lexical#dictionary = ['/usr/share/dict/words']
let g:lexical#spellfile = ['~/.config/nvim/spell/en.utf-8.add']
let g:lexical#thesaurus_key = '<leader>lt'
let g:lexical#dictionary_key = '<leader>ld'

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