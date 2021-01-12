" Check if repository
" If yes change to github flavored markdown
"function! s:CheckIfGithub()
    " call asyncrun#run('', {'mode': 'async', 'cwd': '<root>', 'raw': 1},'git remote show origin | grep "Push  URL" | grep "github.com/" | wc -l')
"    let cwd = getcwd()
"    let parent_dir = expand('%:p:h')
"    exe 'cd ' . parent_dir
"	let github = system('git remote show origin | grep "Push  URL" | grep "github.com/" | wc -l')
"    exe 'cd ' . cwd
	" if in a git repo
"	if !v:shell_error && github > 0
"        packadd vim-gfm-syntax
"        let b:gfm_syntax_enable = 1
"        let g:gfm_syntax_enable_always = 0
"        let g:markdown_fenced_languages = ['cpp', 'ruby', 'json']
"	endif
"endfunction

"autocmd BufEnter * call s:CheckIfGithub()