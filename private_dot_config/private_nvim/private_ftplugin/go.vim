let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_hightlight_fields = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

function! CompileMyCode()
    if executable('go')
        call Run("go build %")
    else
        echo 'Go is not installed!'
    endif
endfunction

function! RunMyCode()
    if executable('go')
        call Run("go run %")
    else
        echo 'Go is not installed!'
    endif
endfunction
