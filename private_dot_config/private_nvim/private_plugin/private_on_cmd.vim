if isdirectory(expand(($XDG_DATA_HOME ? $XDG_DATA_HOME : '~/.local/share') . '/nvim/site/pack/paqs'))
    function! s:do_cmd(cmd, bang, start, end, args)
        exec printf('%s%s%s %s', (a:start == a:end ? '' : (a:start.','.a:end)), a:cmd, a:bang, a:args)
    endfunction
    augroup Pack
        " Rainbow Parentheses & Vim Abolish
        autocmd InsertEnter * packadd rainbow_parentheses.vim | RainbowParentheses | packadd delimitMate
        " Eunuch Vim
        command! -nargs=* -range -bang Delete    packadd vim-eunuch | call s:do_cmd('Delete'   , "<bang>", <line1>, <line2>, <q-args>)
        command! -nargs=* -range -bang Unlink    packadd vim-eunuch | call s:do_cmd('Unlink'   , "<bang>", <line1>, <line2>, <q-args>)
        command! -nargs=* -range -bang Move      packadd vim-eunuch | call s:do_cmd('Move'     , "<bang>", <line1>, <line2>, <q-args>)
        command! -nargs=* -range -bang Rename    packadd vim-eunuch | call s:do_cmd('Rename'   , "<bang>", <line1>, <line2>, <q-args>)
        command! -nargs=* -range -bang Chmod     packadd vim-eunuch | call s:do_cmd('Chmod'    , "<bang>", <line1>, <line2>, <q-args>)
        command! -nargs=* -range -bang Mkdir     packadd vim-eunuch | call s:do_cmd('Mkdir'    , "<bang>", <line1>, <line2>, <q-args>)
        command! -nargs=* -range -bang Cfind     packadd vim-eunuch | call s:do_cmd('Cfind'    , "<bang>", <line1>, <line2>, <q-args>)
        command! -nargs=* -range -bang Clocate   packadd vim-eunuch | call s:do_cmd('Clocate'  , "<bang>", <line1>, <line2>, <q-args>)
        command! -nargs=* -range -bang Lfind     packadd vim-eunuch | call s:do_cmd('Lfind'    , "<bang>", <line1>, <line2>, <q-args>)
        command! -nargs=* -range -bang Llocate   packadd vim-eunuch | call s:do_cmd('Llocate'  , "<bang>", <line1>, <line2>, <q-args>)
        command! -nargs=* -range -bang Wall      packadd vim-eunuch | call s:do_cmd('Wall'     , "<bang>", <line1>, <line2>, <q-args>)
        command! -nargs=* -range -bang SudoWrite packadd vim-eunuch | call s:do_cmd('SudoWrite', "<bang>", <line1>, <line2>, <q-args>)
        command! -nargs=* -range -bang SudoEdit  packadd vim-eunuch | call s:do_cmd('SudoEdit' , "<bang>", <line1>, <line2>, <q-args>)
        " Vim Wordy
        command! -nargs=* -range -bang PrevWordy packadd vim-wordy | call s:do_cmd('PrevWordy' , "<bang>", <line1>, <line2>, <q-args>)
        command! -nargs=* -range -bang Wordy     packadd vim-wordy | call s:do_cmd('Wordy'     , "<bang>", <line1>, <line2>, <q-args>)
        command! -nargs=* -range -bang NextWordy packadd vim-wordy | call s:do_cmd('NextWordy' , "<bang>", <line1>, <line2>, <q-args>)
        " Startup Time
        command! -nargs=* -range -bang StartupTime packadd startuptime.vim | call s:do_cmd('StartupTime' , "<bang>", <line1>, <line2>, <q-args>)
        " DotEnv
        command! -nargs=* -range -bang Dotenv packadd vim-dotenv | call s:do_cmd('Dotenv' , "<bang>", <line1>, <line2>, <q-args>)
        " Nvim Tree
        command! -nargs=* -range -bang NvimTreeToggle packadd nvim-tree.lua | call s:do_cmd('NvimTreeToggle' , "<bang>", <line1>, <line2>, <q-args>)
        command! -nargs=* -range -bang NvimTreeRefresh packadd nvim-tree.lua | call s:do_cmd('NvimTreeRefresh' , "<bang>", <line1>, <line2>, <q-args>)
        command! -nargs=* -range -bang NvimTreeFindFile packadd nvim-tree.lua | call s:do_cmd('NvimTreeFindFile' , "<bang>", <line1>, <line2>, <q-args>)
    augroup END
endif
