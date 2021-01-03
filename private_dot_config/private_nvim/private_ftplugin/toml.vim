packadd vim-toml
if expand('%') =~ "Cargo.toml"
    packadd vim-crates
    call crates#toggle()
endif
