inoremap <silent> <SID>DiscretionaryEnd <C-R>=<SID>crend()<CR>
imap    <script> <Plug>DiscretionaryEnd <SID>DiscretionaryEnd

" This is a simple plugin that helps to end certain structures automatically. 
" In Ruby, this means adding end after if, do, def and several other keywords. 
" In Vimscript, this amounts to appropriately adding endfunction, endif, etc. 
" There's also Bourne shell, Z shell, VB (don't ask), C/C++ preprocessor, Lua, Elixir, Haskell, Objective-C, Matlab, Crystal, Make, Verilog and Jinja templates support.

function! s:mysearchpair(beginpat,endpat,synidpat)
    let s:lastline = line('.')
    call s:synid()
    let line = searchpair(a:beginpat,'',a:endpat,'Wn','<SID>synid() !~# "^'.substitute(a:synidpat,'\\','\\\\','g').'$"',line('.')+50)
    return line
endfunction

function! s:crend()
    let n = ""
    if !exists("b:endwise_addition") || !exists("b:endwise_words") || !exists("b:endwise_syngroups")
        return n
    endif
    let synids = join(map(split(b:endwise_syngroups, ','), 'hlID(v:val)'), ',')
    let wordchoice = '\%('.substitute(b:endwise_words,',','\\|','g').'\)'
    if exists("b:endwise_pattern")
        let beginpat = substitute(b:endwise_pattern,'&',substitute(wordchoice,'\\','\\&','g'),'g')
    else
        let beginpat = '\<'.wordchoice.'\>'
    endif
    let lnum = line('.') - 1
    let space = matchstr(getline(lnum),'^\s*')
    let col  = match(getline(lnum),beginpat) + 1
    let word  = matchstr(getline(lnum),beginpat)
    let endword = substitute(word,'.*',b:endwise_addition,'')
    let y = n.endword."\<C-O>O"
    if exists("b:endwise_end_pattern")
        let endpat = '\w\@<!'.substitute(word, '.*', substitute(b:endwise_end_pattern, '\\', '\\\\', 'g'), '').'\w\@!'
    elseif b:endwise_addition[0:1] ==# '\='
        let endpat = '\w\@<!'.endword.'\w\@!'
    else
        let endpat = '\w\@<!'.substitute('\w\+', '.*', b:endwise_addition, '').'\w\@!'
    endif
    let synidpat  = '\%('.substitute(synids,',','\\|','g').'\)'
    if col <= 0 || synID(lnum,col,1) !~ '^'.synidpat.'$'
        return n
    elseif getline('.') !~# '^\s*#\=$'
        return n
    endif
    let line = s:mysearchpair(beginpat,endpat,synidpat)
    " even is false if no end was found, or if the end found was less
    " indented than the current line
    let even = strlen(matchstr(getline(line),'^\s*')) >= strlen(space)
    if line == 0
        let even = 0
    endif
    if !even && line == line('.') + 1
        return y
    endif
    if even
        return n
    endif
    return y
endfunction

function! s:synid()
    " Checking this helps to force things to stay in sync
    while s:lastline < line('.')
        let s = synID(s:lastline,indent(s:lastline)+1,1)
        let s:lastline = nextnonblank(s:lastline + 1)
    endwhile
    let s = synID(line('.'),col('.'),1)
    let s:lastline = line('.')
    return s
endfunction