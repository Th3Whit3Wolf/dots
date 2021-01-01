function! FoldText()
let l:lpadding = &fdc
redir => l:signs
    execute 'silent sign place buffer='.bufnr('%')
redir End
let l:lpadding += l:signs =~ 'id=' ? 2 : 0

let l:lpadding += max([&numberwidth, strlen(v:foldstart - line('w0')), strlen(line('w$') - v:foldstart), strlen(v:foldstart)]) + 1

" expand tabs
let l:start = substitute(getline(v:foldstart), '\t', repeat(' ', &tabstop), 'g')
let l:end = substitute(substitute(getline(v:foldend), '\t', repeat(' ', &tabstop), 'g'), '^\s*', '', 'g')

let l:info = ' (' . (v:foldend - v:foldstart) . ')'
let l:infolen = strlen(substitute(l:info, '.', 'x', 'g'))
let l:width = winwidth(0) - l:lpadding - l:infolen

let l:separator = ' … '
let l:separatorlen = strlen(substitute(l:separator, '.', 'x', 'g'))
let l:start = strpart(l:start , 0, l:width - strlen(substitute(l:end, '.', 'x', 'g')) - l:separatorlen)
let l:text = l:start . ' … ' . l:end

return l:text . repeat(' ', l:width - strlen(substitute(l:text, ".", "x", "g"))) . l:info
endfunction

set foldtext=FoldText()