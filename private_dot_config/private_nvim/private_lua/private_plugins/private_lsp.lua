local vim, api, fn = vim, vim.api, vim.fn
local lspconfig = require 'lspconfig'
local G = require("global")
local saga = require 'lspsaga'

function get_exec_path(exec)
    if vim.fn.executable(exec) then
        local paths = {}
        for match in (vim.env.PATH..":"):gmatch("(.-):") do
            table.insert(paths, match);
        end
        for _,path in pairs(paths) do
            local t_path = path .. G.path_sep .. exec
            if G.exists(t_path) then
                return true, t_path
            end
        end
    else
        return false, 0
    end
end

--[[
-- Keeping these in case it gets implemented in nvim-compe
vim.g.completion_customize_lsp_label = {
    Function = "",
    Method = "",
    Variable = "",
    Constant = "",
    Struct = "פּ",
    Class = "",
    Interface = "禍",
    Text = "",
    Enum = "",
    EnumMember = "",
    Module = "",
    Color = "",
    Property = "襁",
    Field = "綠",
    Unit = "",
    File = "",
    Value = "",
    Event = "鬒",
    Folder = "",
    Keyword = "",
    Snippet = "",
    Operator = "洛",
    Reference = " ",
    TypeParameter = "",
    Default = ""
}
--]]
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = true,
        signs = true,
        update_in_insert = true,
        underline = true
    }
)

local on_attach = function(client,bufnr)
  if client.resolved_capabilities.document_formatting then
    local defs = {}
    local ext = vim.fn.expand('%:e')
    table.insert(defs,{"BufWritePre", '*.'..ext ,
                        "lua vim.lsp.buf.formatting_sync(nil,1000)"})
    vim.api.nvim_command('augroup lsp_before_save')
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(defs) do
        local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
        vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
    if client.config.flags then
        client.config.flags.allow_incremental_sync = true
    end

    local saga_opts = {
        error_sign = '✘',
        warn_sign = '',
        hint_sign = 'ஐ',
        infor_sign = '',
        code_action_icon = ' '
        -- finder_definition_icon = '  ',
        -- finder_reference_icon = '  ',
        -- definition_preview_icon = '  '
        -- 1: thin border | 2: rounded border | 3: thick border
        -- border_style = 1
    }

    saga.init_lsp_saga(saga_opts)
    vim.fn.sign_define('LspDiagnosticsSignError', {text='✘'})
    vim.fn.sign_define('LspDiagnosticsSignWarning', {text=''})
    vim.fn.sign_define('LspDiagnosticsSignInformation', {text=''})
    vim.fn.sign_define('LspDiagnosticsSignHint', {text='ஐ'})

    -- Keybindings for LSPs
    -- Note these are in on_attach so that they don't override bindings in a non-LSP setting
    local opts = {
        noremap = true,
        silent = true
    }

    local function leader_buf_map(key, command)
        local options = {noremap = true}
        if opts then options = vim.tbl_extend('force', options, opts) end
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>' ..key, "<cmd>lua " .. command .. "()<CR>", opts)
    end
      
    -- preview definition
    leader_buf_map("cD", "require'lspsaga.provider'.preview_definition")
    -- lsp provider to find the currsor word definition and reference
    leader_buf_map("cf", "require'lspsaga.provider'.lsp_finder")
    -- show hover doc
    -- code action
    leader_buf_map("ca",  "require('lspsaga.codeaction').code_action")
    leader_buf_map("clh", "vim.lsp.buf.hover")
    leader_buf_map("cli", "vim.lsp.buf.implementation")
    leader_buf_map("clS", "vim.lsp.buf.signature_help")
    leader_buf_map("clt", "vim.lsp.buf.type_definition")
    leader_buf_map("clr", "vim.lsp.buf.references")
    leader_buf_map("clp", "vim.lsp.buf.peek_definition")
    leader_buf_map("clR", "vim.lsp.buf.rename")
    -- leader_buf_map("cb",  "require'lspsaga.diagnostic'.show_buf_diagnostics")
    leader_buf_map("clsd", "vim.lsp.buf.document_symbol")
    leader_buf_map("clsw", "vim.lsp.buf.workspace_symbol")
    leader_buf_map("cdp", "require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev")
    leader_buf_map("cdn", "require'lspsaga.diagnostic'.lsp_jump_diagnostic_next")
    leader_buf_map("cdl", "vim.lsp.diagnostic.set_loclist")

    -- Telescope
    api.nvim_buf_set_keymap(bufnr, "n", "gr", "Telescope lsp_references", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "<leader>fw", "Telescope lsp_workspace_symbols", opts)
end

-- List of servers where config = {on_attach = on_attach}
local simple_lsp = {
    angularls = "ngserver",
    dockerls = "docker-langserver",
    elmls = "elm-language-server",
    graphql = "graphql-lsp",
    html = "html-languageserver",
    intelephense = "intelephense",
    purescriptls = "purescript-language-server",
    rnix = "rnix",
    rome = "rome",
    svelte= "svelteserver",
    texlab = "texlab",
    vimls = "vim-language-server",
    vuels = "vls",
    yamlls = "yaml-language-server",
}

-- List of installed LSP servers
if fn.executable("bash-language-server") == 1 then
    lspconfig.bashls.setup {
        cmd = {
            "bash-language-server",
            "start"
        },
        filetypes = {
            "sh",
            "zsh"
        },
        root_dir = lspconfig.util.root_pattern(".git"),
        on_attach = on_attach
    }
end
if fn.executable("css-languageserver") == 1 then
    lspconfig.cssls.setup {
        filetypes = {
            "css",
            "less",
            "sass",
            "scss"
        },
        root_dir = lspconfig.util.root_pattern("package.json", ".git"),
        on_attach = on_attach
    }
end
if fn.executable("vscode-json-languageserver") == 1 then
    lspconfig.jsonls.setup {
        cmd = {
            "vscode-json-languageserver",
            "--stdio"
        },
        on_attach = on_attach
    }
end

local sqlls_exists, sqlls_path = get_exec_path("sql-language-server")
if sqlls_exists == true then
    lspconfig.sqlls.setup {
        cmd = {sqlls_path, "up", "--method", "stdio"};
        on_attach = on_attach
    }
end
if fn.executable("sumneko_lua") == 1 then
    lspconfig.sumneko_lua.setup {
        on_attach = on_attach,
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    path = vim.split(package.path, ";")
                },
                diagnostics = {
                    enable = true,
                    globals = {"vim"}
                },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                    }
                }
            }
        }
    }
end
if fn.executable("typescript-language-server") == 1 then
    lspconfig.tsserver.setup {
        cmd = {
            "typescript-language-server",
            "--stdio"
        },
        filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx"
        },
        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
        on_attach = on_attach
    }
end
for lsp, executable in pairs(simple_lsp) do
    if vim.fn.executable(executable) == 1 then
        lspconfig[lsp].setup {
            on_attach = on_attach
        }
    end
end


if vim.fn.executable("ccls") > 0 then
    lspconfig.ccls.setup {
        on_attach = on_attach
    }
elseif vim.fn.executable("clangd") > 0 then
    lspconfig.clangd.setup {
        cmd = {
            "clangd",
            "--clang-tidy",
            "--completion-style=bundled",
            "--header-insertion=iwyu",
            "--suggest-missing-includes",
            "--cross-file-rename"
        },
        init_options = {
            clangdFileStatus = true,
            usePlaceholders = true,
            completeUnimported = true,
            semanticHighlighting = true
        },
        on_attach = on_attach
    }
end

if vim.fn.executable("clojure-lsp") > 0 then
    lspconfig.clojure_lsp.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable("cmake-language-server") > 0 then
    lspconfig.cmake.setup {
        on_attach = on_attach
    }
end

if G.exists("/opt/dart-sdk/bin/snapshots/analysis_server.dart.snapshot") then
    lspconfig.dartls.setup {
        cmd = {
            "dart",
            "/opt/dart-sdk/bin/snapshots/analysis_server.dart.snapshot",
            "--lsp"
        },
        on_attach = on_attach
    }
end

if vim.fn.executable("fortls") > 0 then
    lspconfig.fortls.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable("nc") > 0 then
    lspconfig.gdscript.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable("hie-wrapper") > 0 then
    lspconfig.hie.setup {
        on_attach = on_attach
    }
elseif vim.fn.executable("ghcide") > 0 then
    lspconfig.ghcide.setup {
        on_attach = on_attach
    }
elseif vim.fn.executable("haskell-language-server-wrapper") > 0 then
    lspconfig.hls.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable("gopls") > 0 then
    lspconfig.gopls.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable("kotlin-language-server") > 0 then
    lspconfig.kotlin_language_server.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable("lean-language-server") > 0 then
    lspconfig.leanls.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable(G.python3 .. "bin" .. G.path_sep .. "pyls") then
    lspconfig.pyls.setup {
        cmd = {G.python3 .. "bin" .. G.path_sep .. "pyls"},
        settings = {
            pyls = {
                executable = G.python3 .. "bin" .. G.path_sep .. "pyls"
            }
        },
        on_attach = on_attach,
        root_dir = function(fname)
            return lspconfig.util.root_pattern(
                "pyproject.toml",
                "setup.py",
                "setup.cfg",
                "requirements.txt",
                "mypy.ini",
                ".pylintrc",
                ".flake8rc",
                ".gitignore"
            )(fname) or
                lspconfig.util.find_git_ancestor(fname) or
                vim.loop.os_homedir()
        end
    }
end

if vim.fn.executable("R") > 0 then
    lspconfig.r_language_server.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable("rust-analyzer") > 0 then
    lspconfig.rust_analyzer.setup {
        checkOnSave = {
            command = "clippy"
        },
        on_attach = on_attach
    }
elseif vim.fn.executable("rls") > 0 then
    lspconfig.rls.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable("scry") > 0 then
    lspconfig.scry.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable("solargraph") > 0 then
    lspconfig.solargraph.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable("sourcekit") > 0 then
    lspconfig.sourcekit.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable("terraform-ls") > 0 then
    lspconfig.terraformls.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable("texlab") > 0 then
    lspconfig.texlab.setup {
        on_attach = on_attach
    }
end
