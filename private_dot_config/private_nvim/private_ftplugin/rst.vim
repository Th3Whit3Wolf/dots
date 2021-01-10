packadd vim-lexical
packadd vim-pencil
packadd vim-ditto

DittoOn

call lexical#init()
call pencil#init({'wrap': 'hard'})

let g:lexical#thesaurus = ['~/.config/nvim/thesaurus/mthesaur.txt', '~/.config/nvim/moby_thesaurus.txt']
let g:lexical#dictionary = ['/usr/share/dict/words']
let g:lexical#spellfile = ['~/.config/nvim/spell/en.utf-8.add']
let g:lexical#thesaurus_key = '<leader>lt'
let g:lexical#dictionary_key = '<leader>ld'


lua require 'plugins.tree_sitter'
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

let b:undo_ftplugin = "setl com< cms< et< fo<"
setlocal comments=fb:.. commentstring=..\ %s expandtab
setlocal formatoptions+=tcroql

setlocal expandtab shiftwidth=3 softtabstop=3 tabstop=8