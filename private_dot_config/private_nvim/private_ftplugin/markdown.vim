packadd vim-markdown
packadd vim-markdown-composer
packadd vim-lexical
packadd vim-pencil
packadd vim-ditto

DittoOn

setlocal spell nofoldenable

call lexical#init()
call pencil#init({'wrap': 'hard'})

let &makeprg='proselint %'

let g:lexical#thesaurus = ['~/.config/nvim/thesaurus/mthesaur.txt', '~/.config/nvim/moby_thesaurus.txt']
let g:lexical#dictionary = ['/usr/share/dict/words']
let g:lexical#spellfile = ['~/.config/nvim/spell/en.utf-8.add']
let g:lexical#thesaurus_key = '<leader>lt'
let g:lexical#dictionary_key = '<leader>ld'

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_fenced_languages =  ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'rs=rust']
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_no_extensions_in_markdown = 1

let g:markdown_composer_open_browser = 0
let g:markdown_composer_custom_css = ['file://' . expand('~/.config/nvim/misc/github.css')]

let hr = str2nr(strftime('%H'))
if strftime("%H") >= 7 && strftime("%H") < 19
    let g:markdown_composer_syntax_theme = 'atom-one-light'
else
    let g:markdown_composer_syntax_theme = 'atom-one-dark'
endif

function! RunMyCode()
    ComposerOpen
	ComposerUpdate
endfunction
