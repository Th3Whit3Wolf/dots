packadd vim-pencil
packadd vim-lexical
packadd vim-git

call pencil#init({'wrap': 'soft', 'textwidth': 72})

" replace common punctuation
iabbrev <buffer> -- –
iabbrev <buffer> --- —
iabbrev <buffer> << «
iabbrev <buffer> >> »
