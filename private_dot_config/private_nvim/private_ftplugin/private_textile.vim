packadd textile.vim
packadd vim-lexical
packadd vim-pencil

call lexical#init()
call pencil#init()

" replace common punctuation
iabbrev <buffer> -- –
iabbrev <buffer> --- —
iabbrev <buffer> << «
iabbrev <buffer> >> »