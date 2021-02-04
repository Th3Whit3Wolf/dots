let b:endwise_addition = 'end'
let b:endwise_words = 'module,class,lib,macro,struct,union,enum,def,if,unless,ifdef,case,while,until,for,begin,do'
let b:endwise_pattern = '^\(.*=\)\?\s*\%(private\s\+\|protected\s\+\|public\s\+\|abstract\s\+\)*\zs\%(module\|class\|lib\|macro\|struct\|union\|enum\|def\|if\|unless\|ifdef\|case\|while\|until\|for\|begin\)\>\%(.*[^.:@$]\<end\>\)\@!\|\<do\ze\%(\s*|.*|\)\=\s*$'
let b:endwise_syngroups = 'crystalModule,crystalClass,crystalLib,crystalMacro,crystalStruct,crystalEnum,crystalDefine,crystalConditional,crystalRepeat,crystalControl'

if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/vim-endwise.vim'))) == 0
    execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/vim-endwise.vim')))
endif

imap <buffer> <CR> <CR><Plug>DiscretionaryEnd