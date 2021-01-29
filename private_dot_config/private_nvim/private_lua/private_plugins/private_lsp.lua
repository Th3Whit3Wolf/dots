local vim, api = vim, vim.api
local lspconfig = require 'lspconfig'
local G = require("global")
local saga = require 'lspsaga'
local action = require 'lspsaga.action'

--[[
-- Configure the completion chains
local chain_complete_list = {
    default = {
        {
            complete_items = {
                "lsp",
                "ts",
                "snippet",
                "buffers"
            }
        },
        {
            complete_items = {"path"},
            triggered_only = {"/"}
        },
        {
            complete_items = {"buffers"}
        }
    },
    string = {
        {
            complete_items = {"path"},
            triggered_only = {"/"}
        }
    },
    comment = {},
    sql = {
        {
            complete_items = {
                "vim-dadbod-completion",
                "lsp"
            }
        }
    },
    vim = {
        {
            complete_items = {"snippet"}
        },
        {
            mode = {"cmd"}
        }
    }
}


-- Completion Nvim settings
-- Fix for completion with other plugins mapped to enter
vim.g.completion_confirm_key = ""
-- Use snippets.nvim for snippet completion
vim.g.completion_enable_snippet = "vim-vsnip"
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
  --[[
  completion.on_attach(
        client,
        {
            sorting = "alphabet",
            matching_strategy_list = {"exact", "fuzzy", "substring"},
            chain_complete_list = chain_complete_list
        }
    )
    --]]

  if client.resolved_capabilities.document_formatting then
    action.lsp_before_save()
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
    leader_buf_map("cd", "require'lspsaga.provider'.preview_definition")
    -- lsp provider to find the currsor word definition and reference
    leader_buf_map("cD", "require'lspsaga.provider'.lsp_finder")
    -- show hover doc
    leader_buf_map("ch",  "vim.lsp.buf.hover")
    leader_buf_map("ci",  "vim.lsp.buf.implementation")
    leader_buf_map("cS",  "vim.lsp.buf.signature_help")
    leader_buf_map("ct",  "vim.lsp.buf.type_definition")
    leader_buf_map("cr",  "vim.lsp.buf.references")
    leader_buf_map("cp", "vim.lsp.buf.peek_definition")
    leader_buf_map("cR",  "vim.lsp.buf.rename")
    -- leader_buf_map("cb",  "require'lspsaga.diagnostic'.show_buf_diagnostics")
    leader_buf_map("csd", "vim.lsp.buf.document_symbol")
    leader_buf_map("csw", "vim.lsp.buf.workspace_symbol")
    
    -- code action
    leader_buf_map("ca", "require('lspsaga.codeaction').code_action")
    leader_buf_map("c]", "require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev")
    leader_buf_map("c[", "require'lspsaga.diagnostic'.lsp_jump_diagnostic_next")
    leader_buf_map("co", "vim.lsp.diagnostic.set_loclist")

    -- Telescope
    api.nvim_buf_set_keymap(bufnr, "n", "gr", "Telescope lsp_references", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "<leader>fw", "Telescope lsp_workspace_symbols", opts)
end

-- List of servers where config = {on_attach = on_attach}
local simple_lsp = {
    "als",
    "dockerls",
    "elmls",
    "html",
    "jdtls",
    "metals",
    "ocamlls",
    "purescriptls",
    "rnix",
    "sqlls",
    "vimls",
    "vuels",
    "yamlls"
}

-- List of installed LSP servers
local installed_lsp = vim.fn.systemlist("ls ~/.cache/nvim/nvim_lsp")
for k, _ in pairs(installed_lsp) do
    if installed_lsp[k] == "bashls" then
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
    elseif installed_lsp[k] == "cssls" then
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
    elseif installed_lsp[k] == "jsonls" then
        lspconfig.jsonls.setup {
            cmd = {
                "json-languageserver",
                "--stdio"
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
            root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
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
