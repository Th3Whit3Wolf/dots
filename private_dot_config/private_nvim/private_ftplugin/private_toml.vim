let b:undo_ftplugin = 'setlocal commentstring< comments<'

setlocal commentstring=#\ %s
setlocal comments=:#

if expand('%') =~ "Cargo.toml"
    packadd vim-crates
    call crates#toggle()
endif
