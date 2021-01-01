packadd vim-xml
packadd vim-lexical
ackadd vim-closetag

call lexical#init()
call pencil#init({'wrap': 'soft', 'autoformat': 1})

let g:lexical#thesaurus_key = '<leader>t'
let g:lexical#thesaurus = ['~/.config/nvim/thesaurus/mthesaur.txt', '~/.config/nvim/moby_thesaurus.txt']
let g:lexical#dictionary = ['/usr/share/dict/words']
let g:lexical#spellfile = ['~/.config/nvim/spell/en.utf-8.add']
let g:lexical#thesaurus_key = '<leader>lt'
let g:lexical#dictionary_key = '<leader>ld'