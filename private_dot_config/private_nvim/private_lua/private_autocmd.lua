local vim, api = vim, vim.api

local function augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_command("augroup " .. group_name)
        api.nvim_command("autocmd!")
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten {"autocmd", def}, " ")
            api.nvim_command(command)
        end
        api.nvim_command("augroup END")
    end
end

local autocmds = {
    bufs = {
        -- Reload vim config automatically
        {"BufWritePost", [[$VIM_PATH/{*.vim,*.yaml,vimrc} nested source $MYVIMRC | redraw]]},
        -- Reload Vim script automatically if setlocal autoread
        {
            "BufWritePost,FileWritePost",
            "*.vim",
            [[nested if &l:autoread > 0 | source <afile> | echo 'source ' . bufname('%') | endif]]
        },
        -- Disable swap/undo/viminfo/shada files in temp directories or shm
        {
            "BufNewFile,BufReadPre",
            "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
            "setlocal noswapfile noundofile nobackup nowritebackup viminfo= shada="
        },
        {
            "BufWritePost",
            "bash,c,cs,slojure,cpp,css,dart,erlang,fennel,gdscript3,go,graphql,html,java,javascript,javascriptreact,jsdoc,julia,kotlin.lua,nix,ocaml,php,python,ql,rst,ruby,rust,scala,sparql,teal,toml,turtle,typescript,typescriptreact, verilog",
            "edit | TSBufEnable highlight"
        },
        {"BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile"},
        {"BufWritePre", "MERGE_MSG", "setlocal noundofile"},
        {"BufWritePre", "*.tmp", "setlocal noundofile"},
        {"BufWritePre", "*.bak", "setlocal noundofile"},
        {"BufLeave", "*", "silent! update"}
    },
    niceties = {
        {"Syntax", "*", [[if line('$') > 5000 | syntax sync minlines=300 | endif]]},
        {"BufEnter,WinEnter,InsertLeave,VimEnter", "*", "set cursorline"},
        {"BufLeave,WinLeave,InsertEnter", "*", "set nocursorline"},
        {
            "BufWritePost",
            "*",
            [[nested  if &l:filetype ==# '' || exists('b:ftdetect') | unlet! b:ftdetect | filetype detect | endif]]
        },
        {
            "BufReadPost",
            "*",
            [[if &ft !~# 'commit' && ! &diff && line("'\"") >= 1 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif]]
        }
    },
    --- Current window has hybrid numbers
    --- All other windows have absolute numbers
    numberToggle = {
        {"BufEnter,FocusGained,InsertLeave", "*", "set relativenumber"},
        {"BufLeave,FocusLost,InsertEnter", "*", "set norelativenumber"}
    },
    windows = {
        -- Highlight current line only on focused window
        {"WinEnter,InsertLeave", "*", [[if &ft !~# '^\(denite\|clap_\)' | set cursorline | endif]]},
        {"WinEnter,InsertLeave", "*", [[if &ft !~# '^\(denite\|clap_\)' | set nocursorline | endif]]},
        -- Equalize window dimensions when resizing vim window
        {"VimResized", "*", [[tabdo wincmd =]]},
        -- Force write shada on leaving nvim
        {"VimLeave", "*", "wshada!"},
        -- Check if file changed when its window is focus, more eager than 'autoread'
        {"BufEnter,FocusGained", "*", "checktime"}
    },
    yank = {
        {"TextYankPost", "*", [[ silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=400})]]}
    },
    vcs = {
        {"BufEnter", "*", "lua require'myplugins/vcs'"}
    },
    plugins = {
        {
            "InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost",
            "*.rs",
            [[ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"}} ]]
        },
        -- Code action
        { "CursorHold,CursorHoldI", "*", "lua require'nvim-lightbulb'.update_lightbulb()" },
        -- Show type in virtual text while in rust
        { "CursorHold", "*", "lua vim.lsp.diagnostic.show_line_diagnostics()" },
        -- Automatically load .env variables
        {"BufEnter", "*", "call v:lua.check_env(expand('%:p:h'))"},
        {"BufEnter", "*", "call v:lua.WhichKey.SetKeyOnFT()"},
    }
}

if vim.fn.executable('ctags') ~= 0 then
    autocmds.filetype = {
        {
            "FileType", 
            "ada,ansible,asm,awk,asciidoc,clojure,cmake,d,elixir,erlang,java,make,matlab,markdown,objc,ocaml,perl,pod,proto,ps1,ps1xml,pug,puppet,ruby,rspec,rst,svg,systemd,tex,verilog,xml,xsl,zephir",
            "packadd vim-gutentags"
        }
    }
end

augroups(autocmds)
