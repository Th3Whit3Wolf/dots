if !exists(":Abolish")
    finish
endif

function s:name()
    let l:name = system('git config --list | rg "user.name" | cut -d "=" -f2')
    return l:name
endfunction
function s:email()
    let l:email = system('git config --list | rg "user.email" | cut -d "=" -f2')
    return l:email
endfunction
function s:firstName()
    let l:firstname = split(system('git config --list | rg "user.name" | cut -d "=" -f2'))[0]
    return l:firstname
endfunction
function s:lastName()
    let l:lastname = split(system('git config --list | rg "user.name" | cut -d "=" -f2'))[1]
    return l:lastname
endfunction

" if git config has user name
let s:has_user_name  = system('git config --list | rg "user.name" | cut -d "=" -f2')
if !v:shell_error
    if !empty(s:has_user_name)
        inoremap <expr> ;name <SID>name()
        let name_split = split(system('git config --list | rg "user.name" | cut -d "=" -f2'))
        if len(name_split) > 1
            inoremap <expr> ;fn <SID>firstName()
            inoremap <expr> ;ln <SID>lastName()
        endif
    endif
endif

" if git config has user email
let s:has_user_email  = system('git config --list | rg "user.email" | cut -d "=" -f2')
if !v:shell_error
    if !empty(s:has_user_email)
        "imap ;name name
        inoremap <expr> ;email <SID>email()
    endif
endif


 
