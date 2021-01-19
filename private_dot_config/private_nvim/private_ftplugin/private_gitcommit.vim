packadd committia.vim
packadd vim-pencil
packadd vim-lexical
packadd vim-git

call pencil#init({'wrap': 'soft', 'textwidth': 72})

setlocal spell
setlocal textwidth=72

" replace common punctuation
iabbrev <buffer> -- –
iabbrev <buffer> --- —
iabbrev <buffer> << «
iabbrev <buffer> >> »

" Strip space on save.
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction
autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

if exists("g:lazygit_opened") && g:lazygit_opened && g:lazygit_use_neovim_remote && executable("nvr")
    augroup lazygit_neovim_remote
      autocmd!
      autocmd WinLeave <buffer> :LazyGit
      autocmd WinLeave <buffer> :let g:lazygit_opened=0
    augroup END
end