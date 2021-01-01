function! s:pybang()
    let options  = [
        \ 'python2',
        \ 'python3',
        \ 'pypy',
        \ 'pypy3',
        \ 'jython',
        \ 'none'
        \ ]

    unsilent let choice = inputlist([ 'Select your shell:' ]
        \ + map(copy(options), '"[".(v:key+1)."] ".v:val'))

    if choice >= 1 && choice <= (len(copy(options)) - 2)
        0put = '#!/usr/bin/env ' . (options)[choice - 1]
        call append(line("."), "")
        3
    endif
endfunction


command! -bang -nargs=0 -bar PyBang call <SID>pybang()

function! RunMyCode()
    if getline(1)[0:21] ==# "#!/usr/bin/env python3" || getline(1)[0:17] ==# "#!/usr/bin/python3"
        if executable('python3')
            call Run("python3 %")
        else
            echo 'Python3 is not installed!'
        endif
    elseif getline(1)[0:21] ==# "#!/usr/bin/env python2" || getline(1)[0:17] ==# "#!/usr/bin/python2"
        if executable('python2')
            call Run("python2 %")
        else
            echo 'Python2 is not installed!'
        endif
    elseif getline(1)[0:20] ==# "#!/usr/bin/env python" || getline(1)[0:16] ==# "#!/usr/bin/python"
        if executable('python')
            call Run("python %")
        else
            echo 'Python executable can not be found!'
        endif
    elseif getline(1)[0:19] ==# "#!/usr/bin/env pypy3" || getline(1)[0:15] ==# "#!/usr/bin/pypy3"
        if executable('pypy3')
            call Run("pypy3 %")
        else
            echo 'Pypy3 is not installed!'
        endif
    elseif getline(1)[0:18] ==# "#!/usr/bin/env pypy" || getline(1)[0:14] ==# "#!/usr/bin/pypy"
        if executable('pypy')
            call Run("pypy %")
        else
            echo 'Pypy is not installed!'
        endif
    elseif getline(1)[0:20] ==# "#!/usr/bin/env jython" || getline(1)[0:16] ==# "#!/usr/bin/jython"
        if executable('jython')
            call Run("jython %")
        else
            echo 'Jython is not installed!'
        endif
    else
        call Run("python %")
        echom 'Please set a python shebang'
    endif
endfunction

set expandtab tabstop=4 softtabstop=4 shiftwidth=4
