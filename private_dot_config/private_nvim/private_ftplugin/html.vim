packadd html5.vim
packadd vim-closetag
packadd bracey.vim
packadd vim-lexical
packadd vim-pencil

call lexical#init()
call pencil#init({'wrap': 'soft'})

set backupcopy=yes

let g:bracey_refresh_on_save = 1
let g:lexical#thesaurus = ['~/.config/nvim/thesaurus/mthesaur.txt', '~/.config/nvim/moby_thesaurus.txt']
let g:lexical#dictionary = ['/usr/share/dict/words']
let g:lexical#spellfile = ['~/.config/nvim/spell/en.utf-8.add']
let g:lexical#thesaurus_key = '<leader>lt'
let g:lexical#dictionary_key = '<leader>ld'

function! RunMyCode()
	let g:bracey_refresh_on_save = 1
	Bracey
endfunction
