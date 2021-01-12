packad rust-vim

let g:rustfmt_autosave = 1

set colorcolumn=9999
setlocal tags=./rusty-tags.vi;/

" Code formatting on save
augroup rustPreWrite
    autocmd!
    autocmd BufWritePost *.rs silent! call Rustfmt_PreWrite() | TSBufEnable highlight
augroup END

function! InCargoProject(...)
	return filereadable("Cargo.toml") || filereadable("../Cargo.toml") || filereadable("../../Cargo.toml") || filereadable("../../../Cargo.toml")
endfunction

function! CompileMyCode() abort
    if InCargoProject()
        if executable('cargo')
            call Run("cargo build")
        else
            echom 'Cargo is not installed!'
        endif
    else
        if executable('rustc')
            call Run("rustc % -o %<")
        else
            echom 'Rustc is not installed or this is not a cargo project'
        endif
    endif
endfunction!

function! RunMyCode() abort
    if InCargoProject()
        if executable('cargo')
            lua require'myplugins/async_make'.cmdRunner("cargo run")
        else
            echom 'Cargo is not installed!'
        endif
    else
        if executable('rustc')
            lua require'myplugins/async_make'.cmdRunner(vim.fn.expandcmd("rustc % -o %<; ./%<"))
        else
            echom 'Rustc is not installed!'
        endif
    endif
endfunction!

function! TestMyCode()
	if InCargoProject()
        if executable('cargo')
            lua require'myplugins/async_make'.cmdRunner("cargo test --all -- --test-threads=1")
        else
            echo 'Rust is not installed or this is not a cargo project'
        endif
    else
        echom "Testing is only support for Cargo projects"
    endif
endfunction!


lua require 'plugins.tree_sitter'
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
