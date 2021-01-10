setlocal comments=s:--[[,mb:-,ex:]],:--,f:#,:--
setlocal commentstring=--%s
setlocal suffixesadd=.tl

let b:undo_ftplugin = "setl com< cms< mp< sua<"
let b:endwise_addition = 'end'
let b:endwise_words = 'function,do,then,enum,record'
let b:endwise_pattern = '\zs\<\%(then\|do\)\|\(\%(function\|record\|enum\).*\)\ze\s*$'
let b:endwise_syngroups = 'tealFunction,tealDoEnd,tealIfStatement,tealRecord,tealEnum'

lua require 'plugins.tree_sitter'
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()