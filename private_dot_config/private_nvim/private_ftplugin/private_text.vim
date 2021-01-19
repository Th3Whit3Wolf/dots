packadd vim-lexical
packadd vim-pencil

call lexical#init({ 'spell': 0 })
call pencil#init({'wrap': 'hard', 'autoformat': 0})

setlocal nofoldenable

" replace common punctuation
iabbrev <buffer> -- –
iabbrev <buffer> --- —
iabbrev <buffer> << «
iabbrev <buffer> >> »