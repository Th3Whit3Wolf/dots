packadd html5.vim
packadd vim-closetag
packadd bracey.vim
packadd vim-lexical
packadd vim-pencil

call lexical#init()
call pencil#init({'wrap': 'soft'})

set backupcopy=yes

function! RunMyCode()
	let g:bracey_refresh_on_save = 1
	Bracey
endfunction

lua require 'plugins.tree_sitter'
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()


