" Taken from https://github.com/dougireton/vim-chef
let s:cpo_save = &cpo
set cpo&vim

setlocal path+= .,**1/recipes;cookbooks,**1;cookbooks

if isdirectory($BERKSHELF_PATH . '/cookbooks')
    setlocal path+=$BERKSHELF_PATH/cookbooks/**1/recipes,$BERKSHELF_PATH/cookbooks/**1
elseif isdirectory($HOME . '/.berkshelf/cookbooks')
    setlocal path+=$HOME/.berkshelf/cookbooks/**1/recipes,$HOME/.berkshelf/cookbooks/**1
endif

setlocal suffixesadd+=/recipes/default.rb

let &cpo = s:cpo_save
unlet s:cpo_save