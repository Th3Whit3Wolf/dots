local lspconfig = require('lspconfig')
local completion = require('completion')
local G = require('global')
local vim = vim

-- Configure the completion chains
local chain_complete_list = {
    default = {{
        complete_items = {
            'lsp',
            'ts',
            'snippet',
            'buffers'
        }
    }, {
        complete_items = {'path'},
        triggered_only = {'/'}
    }, {
        complete_items = {'buffers'}
    }},
    string = {{
        complete_items = {'path'},
        triggered_only = {'/'}
    }},
    comment = {},
    sql = {{
        complete_items = {
            'vim-dadbod-completion',
            'lsp'
        }
    }},
    vim = {{
        complete_items = {'snippet'}
    }, {
        mode = {'cmd'}
    }}
}

-- Completion Nvim settings
-- Fix for completion with other plugins mapped to enter
vim.g.completion_confirm_key = ""
-- Use snippets.nvim for snippet completion
vim.g.completion_enable_snippet = 'vim-vsnip'
-- Enable auto signature
vim.g.completion_enable_auto_signature = 1
-- Auto change completion source
vim.g.completion_auto_change_source = 1
-- Complete on delete
vim.g.completion_trigger_on_delete = 1
-- ignore case matching
vim.g.completion_matching_ignore_case = 1
-- Custom label
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

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true
  }
)

local on_attach = function(client)
    completion.on_attach(client, {
        sorting = 'alphabet',
        matching_strategy_list = {'exact', 'fuzzy', 'substring'},
        chain_complete_list = chain_complete_list
    })

    -- Keybindings for LSPs
    -- Note these are in on_attach so that they don't override bindings in a non-LSP setting
    local opts = {
        noremap = true,
        silent = true
    }

    vim.api.nvim_buf_set_keymap(0, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>cD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    --vim.api.nvim_buf_set_keymap(0, "n", "<leader>ch", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>ci", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>cs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>ct", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>cr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>cpd", "<cmd>lua vim.lsp.buf.peek_definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>cR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>csd", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>csw", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)

    -- diagnostics-lsp
    vim.fn.sign_define('LspDiagnosticsErrorSign', {text='✘', texthl='LspDiagnosticsError',linehl='', numhl=''})
    vim.fn.sign_define('LspDiagnosticsWarningSign', {text='', texthl='LspDiagnosticsWarning', linehl='', numhl=''})
    vim.fn.sign_define('LspDiagnosticsInformationSign', {text='', texthl='LspDiagnosticsInformation', linehl='', numhl=''})
    vim.fn.sign_define('LspDiagnosticsHintSign', {text='ஐ', texthl='LspDiagnosticsHint', linehl='', numhl=''})
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>c]", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>cd[", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>cdo", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
    end

    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_command('augroup lsp_aucmds')
        vim.api.nvim_command('au!')
        vim.api.nvim_command('au CursorHold <buffer> lua vim.lsp.buf.document_highlight()')
        vim.api.nvim_command('au CursorMoved <buffer> lua vim.lsp.buf.clear_references()')
        vim.api.nvim_command('augroup END')
    end

end

-- List of servers where config = {on_attach = on_attach}
local simple_lsp = {
    'als',
    'dockerls',
    'elmls',
    'html',
    'jdtls',
    'metals',
    'ocamlls',
    'purescriptls',
    'rnix',
    'sqlls',
    'vimls',
    'vuels',
    'yamlls'
}
-- List of installed LSP servers
local installed_lsp = vim.fn.systemlist('ls ~/.cache/nvim/nvim_lsp')
for k, _ in pairs(installed_lsp) do
    if installed_lsp[k] == "bashls" then
        lspconfig.bashls.setup {
            cmd = {
                'bash-language-server',
                'start'
            },
            filetypes = {
                'sh',
                'zsh'
            },
            root_dir = lspconfig.util.root_pattern('.git'),
            on_attach = on_attach
        }
    elseif installed_lsp[k] == "cssls" then
        lspconfig.cssls.setup {
            filetypes = {
                "css",
                "less",
                "sass",
                "scss"
            },
            root_dir = lspconfig.util.root_pattern(
                "package.json",
                ".git"
            ),
            on_attach = on_attach
        }
    elseif installed_lsp[k] == "jsonls" then
        lspconfig.jsonls.setup {
            cmd = {
                'json-languageserver',
                '--stdio'
            },
            on_attach = on_attach
        }
    elseif installed_lsp[k] == "sumneko_lua" then
        lspconfig.sumneko_lua.setup {
            on_attach = on_attach,
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                        path = vim.split(package.path, ';')
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
    elseif installed_lsp[k] == "tsserver" then
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
            root_dir = lspconfig.util.root_pattern(
                'package.json',
                'tsconfig.json',
                '.git'
            ),
            on_attach = on_attach
        }
    else
        for j, _ in pairs(simple_lsp) do
            if installed_lsp[k] == simple_lsp[j] then
                lspconfig[simple_lsp[j]].setup {
                    on_attach = on_attach
                }
            end
        end
    end
end

if vim.fn.executable('ccls') then
    lspconfig.ccls.setup {
        on_attach = on_attach
    }
elseif vim.fn.executable('clangd') then
    lspconfig.clangd.setup {
        cmd = {
            'clangd',
            '--clang-tidy',
            '--completion-style=bundled',
            '--header-insertion=iwyu',
            '--suggest-missing-includes',
            '--cross-file-rename'
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

if vim.fn.executable('clojure-lsp') then
    lspconfig.clojure_lsp.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable('cmake-language-server') then
    lspconfig.cmake.setup {
        on_attach = on_attach
    }
end

if G.exists('/opt/dart-sdk/bin/snapshots/analysis_server.dart.snapshot') then
    lspconfig.dartls.setup {
        cmd = {
            "dart",
            "/opt/dart-sdk/bin/snapshots/analysis_server.dart.snapshot",
            "--lsp"
        },
        on_attach = on_attach
    }
end

if vim.fn.executable('fortls') then
    lspconfig.fortls.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable('nc') then
    lspconfig.gdscript.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable('hie-wrapper') then
    lspconfig.hie.setup {
        on_attach = on_attach
    }
elseif vim.fn.executable('ghcide') then
    lspconfig.ghcide.setup {
        on_attach = on_attach
    }
elseif vim.fn.executable('haskell-language-server-wrapper') then
    lspconfig.hls.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable('gopls') then
    lspconfig.gopls.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable('kotlin-language-server') then
    lspconfig.kotlin_language_server.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable('lean-language-server') then
    lspconfig.leanls.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable(G.python3 .. 'bin' .. G.path_sep ..'pyls') then
    lspconfig.pyls.setup {
        cmd = {G.python3 .. 'bin' .. G.path_sep ..'pyls'},
        settings = {
            pyls = {
                executable = G.python3 .. 'bin' .. G.path_sep ..'pyls'
            }
        },
        on_attach = on_attach,
        root_dir = function(fname)
            return lspconfig.util.root_pattern(
                'pyproject.toml',
                'setup.py',
                'setup.cfg',
                'requirements.txt',
                'mypy.ini',
                '.pylintrc',
                '.flake8rc',
                '.gitignore'
            )(fname)
            or lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
        end
    }
end

if vim.fn.executable('R') then
    lspconfig.r_language_server.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable('rust_analyzer') then
    lspconfig.rust_analyzer.setup {
        on_attach = on_attach
    }
elseif vim.fn.executable('rls') then
    lspconfig.rls.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable('scry') then
    lspconfig.scry.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable('solargraph') then
    lspconfig.solargraph.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable('sourcekit') then
    lspconfig.sourcekit.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable('terraform-ls') then
    lspconfig.terraformls.setup {
        on_attach = on_attach
    }
end

if vim.fn.executable('texlab') then
    lspconfig.texlab.setup {
        on_attach = on_attach
    }
end