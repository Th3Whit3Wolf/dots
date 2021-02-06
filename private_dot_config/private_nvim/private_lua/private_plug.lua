local G = require 'global'

local packer = nil
local function init()
    if packer == nil then
        packer = require('packer')
        packer.init({
            compile_path = G.local_nvim .. 'site' .. G.path_sep .. 'plugin' .. G.path_sep .. 'packges.vim',
            config = {
                display = {
                    _open_fn = function(name)
                        -- Can only use plenary when we have our plugins.
                        --  We can only get plenary when we don't have our plugins ;)
                        local ok, float_win = pcall(function()
                            return require('plenary.window.float').percentage_range_window(0.8, 0.8)
                        end)

                        if not ok then
                            vim.cmd [[65vnew  [packer] ]]

                            return vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
                        end

                        local bufnr = float_win.buf
                        local win = float_win.win

                        vim.api.nvim_buf_set_name(bufnr, name)
                        vim.api.nvim_win_set_option(win, 'winblend', 10)

                        return win, bufnr
                    end
                }
            }
        })
    end

    local use = packer.use
    packer.reset()



  local use = packer.use
  packer.reset()

  use {"wbthomason/packer.nvim", opt = true}


  -- My spacemacs colorscheme
  use {
    "Th3Whit3Wolf/space-nvim",
    branch = "main",
    config = function()
      vim.g.space_nvim_transparent_bg = "true"
    end
  }

  use {
    "Th3Whit3Wolf/Dusk-til-Dawn.nvim",
    branch = "main",
    config = function()
      vim.g.dusk_til_dawn_light_theme = "space-nvim"
      vim.g.dusk_til_dawn_dark_theme = "space-nvim"
    end
  }

  -- neovim statusline plugin written in lua
  use {
    "glepnir/galaxyline.nvim",
    branch = "main",
    config = function()
      require "plugins.statusline"
    end
  }

  use {
    "glepnir/indent-guides.nvim",
    branch = "main",
    config = function()
      require("Dusk-til-Dawn").timeMan(
        function()
          require('indent_guides').setup({
            even_colors = {fg = "#d3d3e7", bg = "#d3d3e7"},
            odd_colors = {fg = "#e7e7fc", bg = "#e7e7fc"},
            indent_guide_size = 4
          })
          require('indent_guides').indent_guides_enable()
        end,
        function()
          require('indent_guides').setup({
            even_colors = {fg = "#444155", bg = "#444155"},
            odd_colors = {fg = "#3b314d", bg = "#3b314d"},
            indent_guide_size = 4
          })
          require('indent_guides').indent_guides_enable()
        end
      )()
    end
  }

  -- Modern vim-startify
  use {"glepnir/dashboard-nvim"}

  -- A neovim tabline plugin. 
  use {
    'romgrk/barbar.nvim',
    config = function()
      vim.g.bufferline = {
        animation = true,
        auto_hide = false,
        clickable = true,
        closable = true,
        icon_close_tab = "",
        icon_close_tab_modified = "●",
        icon_separator_active = "▎",
        icon_separator_inactive = "▎",
        icons = true,
        letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
        maximum_padding = 0,
        semantic_letters = true,
        tabpages = true,
      }
    end
  }

  -- A snazzy bufferline for Neovim 
  -- use 'akinsho/nvim-bufferline.lua'

  -- A File Explorer For Neovim Written In Lua
  use {
    "kyazdani42/nvim-tree.lua",
    cmd = {
      "NvimTreeToggle",
      "NvimTreeRefresh",
      "NvimTreeFindFile"
    },
    -- devicons in lua
    requires = "kyazdani42/nvim-web-devicons"
  }

  -- Auto completion plugin for nvim
  use {
    "hrsh7th/nvim-compe",
    config = function()
      require('compe').setup {
        enabled = true;
        debug = false;
        min_length = 2;
        preselect = "enable";
        source_timeout = 200;
        incomplete_delay = 400;
        allow_prefix_unmatch = false;
        source = {
          nvim_lsp = true;
          vim_dadbod_completion = true;
          vsnip = true;
          path = true;
          buffer = false;
        };
    }
  end

  }

  -- Collection of common configurations for the Nvim LSP client.
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require 'plugins.lsp'
    end,
  }
  
  use "onsails/lspkind-nvim"

  -- bunch of info & extension callbacks for built-in LSP (provides inlay hints)
  use {"tjdevries/lsp_extensions.nvim"}

  -- elescope is a highly extendable fuzzy finder over lists. Items are shown in a popup with a prompt to search over.
  use {
    "nvim-lua/telescope.nvim",
    config = function()
      require('telescope').setup{
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = require('telescope.actions').close
            },
          },
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
          },
          prompt_position = "bottom",
          prompt_prefix = ">",
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "descending",
          layout_strategy = "horizontal",
          layout_defaults = {
            -- TODO add builtin options.
          },
          file_sorter =  require'telescope.sorters'.get_fzy_sorter,
          file_ignore_patterns = {"target/*"},
          generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
          shorten_path = true,
          winblend = 0,
          width = 0.75,
          preview_cutoff = 120,
          results_height = 1,
          results_width = 0.8,
          border = {},
          borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
          color_devicons = true,
          use_less = true,
          set_env = { ['COLORTERM'] = 'truecolor' }, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
          file_previewer = require'telescope.previewers'.vim_buffer_cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
          grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
          qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`
        },
      }
    end,
    requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}
  }
  -- A light-weight lsp plugin based on neovim built-in lsp with highly performance UI.
  use 'glepnir/lspsaga.nvim'

  --  VSCode bulb for neovim's built-in LSP.
  use 'kosayoda/nvim-lightbulb'

  -- Snippet plugin for vim/nvim that supports LSP/VSCode's snippet forma
  use {"hrsh7th/vim-vsnip"}

  -- vim-vsnip integrations to other plugins
  use {"hrsh7th/vim-vsnip-integ"}

  -- plugin for interacting with databases
  use {"tpope/vim-dadbod"}

  -- Like pgadmin but for vim
  use {
    "kristijanhusak/vim-dadbod-ui",
    config = function()
      vim.g["db_ui_env_variable_url"] = "DATABASE_URL"
      vim.g["db_ui_env_variable_name"] = "DATABASE_NAME"
      vim.g["db_ui_win_position"] = 'left'
      vim.g["db_ui_use_nerd_fonts"] = 1
      vim.g["db_ui_winwidth"] = 35
    end
  }

  -- UI for vim dadbod
  use "kristijanhusak/vim-dadbod-completion"

  -- Treesitter configurations and abstraction layer for Neovim.
   use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = {
      {'nvim-treesitter/playground', after = 'nvim-treesitter'},
      {'romgrk/nvim-treesitter-context', after = 'nvim-treesitter'}
    },
    config = function()
      require 'plugins.tree_sitter'
    end,
    ft = {
      'sh',
      'c',
      'cs',
      'cpp',
      'css',
      'dart',
      'elm',
      'fennel',
      'go',
      'haskell',
      'html',
      'java',
      'javascript',
      'jsdoc',
      'julia',
      'lua',
      'markdown',
      'nix',
      'ocaml',
      'php',
      'python',
      'ql',
      'rst',
      'ruby',
      'rust',
      'scala',
      'swift',
      'toml',
      'tsx',
      'typescript',
      'vue',
      'yaml'
    },
    event = 'VimEnter *'
  }

  -- high-performance color highlighter for Neovim
  use {
    "norcalli/nvim-colorizer.lua",
    opt = true
  }

  -- Make neovim termminal more functional
  use {
    "akinsho/nvim-toggleterm.lua",
    config = function()
      require"toggleterm".setup{
        size = 12,
        open_mapping = [[<a-t>]],
        shade_terminals = false,
        persist_size = true,
        direction = 'horizontal'
    }
  end
  }

  -- A surround text object plugin for neovim, written in lua.
  use {
    "blackcauldron7/surround.nvim",
    opt = true
  }

  -- Auto pair for neovim written in lua
  use {
    "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup({
        pairs_map = {
          ["'"] = "'",
          ['"'] = '"',
          ['('] = ')',
          ['['] = ']',
          ['{'] = '}',
          ['`'] = '`',
          ['<'] = '>',
        }
      })
    end
  }

  --  commentary.vim: comment stuff out
  use "b3nj5m1n/kommentary"

  ----------
  -- Lazy --
  ----------

  --[[
  -- uses the sign column to indicate added, modified and removed lines in a file that is managed by a version control system
  use {
    "mhinz/vim-signify",
    opt = true,
    config = function()
      vim.g.signify_sign_add = ""
      vim.g.signify_sign_delete = ""
      vim.g.signify_sign_delete_first_line = ""
      vim.g.signify_sign_change = ""
    end
  }
  --]]

  -- Git signs written in pure lua 
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = {hl = 'SignifySignAdd'   , text = '', numhl='DiffAdd'},
          change       = {hl = 'SignifySignChange', text = '', numhl='DiffChange'},
          delete       = {hl = 'SignifySignDelete', text = '', numhl='DiffDelete'},
          topdelete    = {hl = 'SignifySignDelete', text = '‾', numhl='DiffDelete'},
          changedelete = {hl = 'SignifySignChange', text = '~', numhl='DiffChange'},
        },
        numhl = false,
        keymaps = {
          -- Default keymap options
          noremap = true,
          buffer = true,
      
          ['n gsn'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
          ['n gsp'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},
      
          -- Text objects
          ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
          ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
        },
        watch_index = {
          interval = 1000
        },
        sign_priority = 6,
        status_formatter = nil, -- Use default
      }
    end
  }

  -- Vim sugar for the UNIX shell commands
  use {
    "tpope/vim-eunuch",
    cmd = {
      "Delete",
      "Unlink",
      "Move",
      "Rename",
      "Chmod",
      "Mkdir",
      "Cfind",
      "Clocate",
      "Lfind",
      "Llocate",
      "Wall",
      "SudoWrite",
      "SudoEdit"
    }
  }

  -- A Vim plugin that manages your tag files 
  use {
    "ludovicchabant/vim-gutentags",
    opt = true,
    config = function()
      vim.g["gutentags_project_root"] = {'.root', '.git', '.svn', '.hg', '.project','go.mod', 'Cargo.toml', '.bzr', '_darcs', '_FOSSIL_', '.fslckout','tsconfig.js','jsconfig.js'}
      vim.g["gutentags_generate_on_write"] = 0
      vim.g["gutentags_generate_on_missing"] = 0
      vim.g["gutentags_generate_on_new"] = 0
      vim.g["gutentags_exclude_filetypes"] = {'defx', 'denite', 'vista', 'magit'}
      vim.g["gutentags_ctags_extra_args"] = {'--output-format=e-ctags'}
      vim.g["gutentags_ctags_exclude"] = {'*.json', '*.js', '*.ts', '*.jsx', '*.css', '*.less', '*.sass', '*.go', '*.dart', 'node_modules', 'dist', 'vendor'}
    end
  }

  -- shows the history of commits under the cursor in popup window
  use {
    "rhysd/git-messenger.vim",
    cmd = "GitMessenger",
    config = function()
      vim.g.git_messenger_no_default_mappings = true
      vim.api.nvim_set_keymap("n", "gm", "<cmd>GitMessenger<CR>", {silent = true})
    end
  }

  -- Vim plugin that shows keybindings in popup
  use {
    "liuchengxu/vim-which-key",
    config = function()
      require 'plugins.which-key'
    end
  }

  -- improves the git commit buffer
  use {
    "rhysd/committia.vim",
    opt = true
  }

  -- Asynchronously control git repositories in Neovim
  use {
    "lambdalisue/gina.vim",
    opt = true,
    config = function()
      vim.api.nvim_set_keymap("n", "<Space>gs", "<cmd>Gina status<CR>",         {noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<Space>gb", "<cmd>Gina branch<CR>",         {noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<Space>gc", "<cmd>Gina commit<CR>",         {noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<Space>gC", "<cmd>Gina commit --amend<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<Space>gt", "<cmd>Gina tag<CR>",            {noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<Space>gL", "<cmd>Gina log<CR>",            {noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<Space>gf", "<cmd>Gina ls<CR>",             {noremap = true, silent = true})
      vim.fn["gina#custom#command#option"]("commit", "-v|--verbose")
      vim.fn["gina#custom#command#option"]([[/\%(status\|commit\)]], "-u|--untracked-files")
      vim.fn["gina#custom#command#option"]("status", "-b|--branch")
      vim.fn["gina#custom#command#option"]("status", "-s|--short")
      vim.fn["gina#custom#command#option"]([[/\%(commit\|tag\)]], "--restore")
      vim.fn["gina#custom#command#option"]("show", "--show-signature")
      vim.fn["gina#custom#action#alias"]("branch", "track",  "checkout:track")
      vim.fn["gina#custom#action#alias"]("branch", "merge",  "commit:merge")
      vim.fn["gina#custom#action#alias"]("branch", "rebase", "commit:rebase")
      vim.fn["gina#custom#action#alias"]([[/\%(blame\|log\|reflog\)]], "preview", "topleft show:commit:preview")
      vim.fn["gina#custom#action#alias"]([[/\%(blame\|log\|reflog\)]], "changes", "topleft changes:of:preview")
      vim.fn["gina#custom#mapping#nmap"]("branch", "g<CR>", "<Plug>(gina-commit-checkout-track)")
      vim.fn["gina#custom#mapping#nmap"]("status", "<C-^>", ":<C-u>Gina commit<CR>", {noremap = true, silent = true})
      vim.fn["gina#custom#mapping#nmap"]("commit", "<C-^>", ":<C-u>Gina status<CR>", {noremap = true, silent = true})
      vim.fn["gina#custom#mapping#nmap"]("status", "<C-6>", ":<C-u>Gina commit<CR>", {noremap = true, silent = true})
      vim.fn["gina#custom#mapping#nmap"]("commit", "<C-6>", ":<C-u>Gina status<CR>", {noremap = true, silent = true})
      vim.fn["gina#custom#mapping#nmap"]([[/\%(blame\|log\|reflog\)]], "p", "<cmd>call gina#action#call(''preview'')<CR>", {noremap = true, silent = true})
      vim.fn["gina#custom#mapping#nmap"]([[/\%(blame\|log\|reflog\)]], "c", "<cmd>call gina#action#call(''changes'')<CR>", {noremap = true, silent = true})
    end
  }

  -- A simple, easy-to-use Vim alignment plugin
  use {
    "junegunn/vim-easy-align"
  }

  -- Viewer & Finder for LSP symbols and tags
  use {
    "liuchengxu/vista.vim",
    cmd = "Vista",
    config = function()
      --- How each level is indented and what to prepend.
      --- This could make the display more compact or more spacious.
      --- e.g., more compact: ["▸ ", ""]
      --- Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
      vim.g["vista_icon_indent"] = {"╰─▸ ", "├─▸ "}

      --- Executive used when opening vista sidebar without specifying it.
      --- See all the avaliable executives via `:echo g:vista#executives`.
      vim.g["vista_default_executive"] = 'ctags'

      -- Set the executive for some filetypes explicitly. Use the explicit executive
      -- instead of the default one for these filetypes when using `:Vista` without
      -- specifying the executive.
      vim.g["vista_executive_for"] = {
          angular = 'nvim_lsp',
          bash = 'nvim_lsp',
          bib = 'nvim_lsp',
          docker = 'nvim_lsp',
          c = 'nvim_lsp',
          cpp = 'nvim_lsp',
          css = 'nvim_lsp',
          elm = 'nvim_lsp',
          graphql = 'nvim_lsp',
          html = 'nvim_lsp',
          json = 'nvim_lsp',
          latex = 'nvim_lsp',
          less = 'nvim_lsp',
          markdown = 'toc',
          php = 'nvim_lsp',
          purescript = 'nvim_lsp',
          python = 'nvim_lsp',
          rome = 'nvim_lsp',
          rust = 'nvim_lsp',
          sass = 'nvim_lsp',
          scss = 'nvim_lsp',
          sql = 'nvim_lsp',
          svelte = 'nvim_lsp',
          typescript = 'nvim_lsp',
          typescriptreact = 'nvim_lsp',
          yaml = 'nvim_lsp',
          vim = 'nvim_lsp',
          vue = 'nvim_lsp',
      }
      vim.g["vista_disable_statusline"] = 1
      -- Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
      vim.g["vista#renderer#enable_icon"] = 1
    end
  }

  -- Auto close (X)HTML tags
  use {
    "alvan/vim-closetag",
    opt = true,
    event = "InsertEnter *"
  }

  use {
    "turbio/bracey.vim",
    run = "npm install --prefix server",
    opt = true
  }

  -- An asynchronous markdown preview plugin for Neovim
  use {
    "euclio/vim-markdown-composer",
    run = "cargo build --release",
    opt = true
  }

  -- Simpler Rainbow Parentheses
  use {
    "junegunn/rainbow_parentheses.vim",
    event = "InsertEnter *",
    config = function()
      vim.cmd('RainbowParentheses')
    end
  }

  -- Read DotEnv
  use {
    "tpope/vim-dotenv",
    cmd = "Dotenv"
  }

  -- Profiling
  use {
    "tweekmonster/startuptime.vim",
    cmd = "StartupTime"
  }

  -----------
  -- Prose --
  -----------

  -- Add all of these in  `lazy/git`
  -- Uncover usage problems in your writing
  use {
    "reedes/vim-wordy",
    cmd = {
      "PrevWordy",
      "Wordy",
      "NextWordy"
    }
  }

  -- Highlights overused words
  use {
    "dbmrq/vim-ditto",
    opt = true
  }

  -- Building on Vim’s spell-check and thesaurus/dictionary completion
  use {
    "reedes/vim-lexical",
    opt = true,
    config = function()
      vim.g["lexical#dictionary"] = {'/usr/share/dict/words'}
      vim.g["lexical#spellfile"] = {'~/.config/nvim/spell/en.utf-8.add'}
      vim.g["lexical#thesaurus_key"] = '<leader>lt'
      vim.g["lexical#dictionary_key"] = '<leader>ld'
    end
  }

  -- handful of tweaks needed to smooth the path to writing prose
  use {
    "reedes/vim-pencil",
    opt = true
  }

  ---------------
  -- FTPlugins --
  ---------------

  -- ACPI ASL
  use {
    "martinlroth/vim-acpi-asl",
    ft = "asl"
  }

  -- Ansible 2.x
  use {
    "pearofducks/ansible-vim",
    ft = "ansible"
  }

  -- API Blueprint
  use {
    "sheerun/apiblueprint.vim",
    ft = "apiblueprint"
  }

  -- AppleScript
  use {
    "mityu/vim-applescript",
    ft = "applescript"
  }

  -- Arduino
  use {
    "sudar/vim-arduino-syntax",
    ft = "arduino"
  }

  -- AsciiDoc
  use {
    "asciidoc/vim-asciidoc",
    ft = "asciidoc",
    config = function()
      vim.call("lexical#init")
      vim.call("pencil#init", {wrap = "hard"})
    end
  }

  -- BATS
  use {
    "aliou/bats.vim",
    ft = "bats"
  }

  -- Bazel
  use {
    "bazelbuild/vim-bazel",
    ft = "bzl"
  }

  -- Bazel
  use {
    "google/vim-maktaba",
    ft = "bzl"
  }

  -- Blade templates
  use {
    "jwalton512/vim-blade",
    ft = "blade"
  }

  -- Brewfile
  use {
    "bfontaine/Brewfile.vim",
    ft = "brewfile"
  }

  -- C#
  use {
    "OrangeT/vim-csharp",
    ft = {
      "cs",
      "xml",
      "cshtml.html",
      "aspx.html"
    }
  }

  -- C#
  use {
    "OmniSharp/omnisharp-vim",
    ft = {
      "cs",
      "omnisharplog"
    }
  }

  -- Caddyfile
  use {
    "isobit/vim-caddyfile",
    ft = "caddyfile"
  }

  -- Cargo Make (Rust cargo extension)
  use {
    "nastevens/vim-cargo-make",
    ft = "cargo-make"
  }

  -- Cargo.toml (Rust)
  use {
    "mhinz/vim-crates",
    opt = true
  }

  -- Carp
  use {
    "hellerve/carp-vim",
    ft = "carp"
  }

  -- Chef
  use {
    "vadv/vim-chef",
    ft = "chef",
  }

  -- Clojure
  use {
    "guns/vim-clojure-static",
    ft = "clojure"
  }

  -- Clojure
  use {
    "tpope/vim-fireplace",
    ft = "clojure"
  }

  -- Clojure
  use {
    "guns/vim-clojure-highlight",
    ft = "clojure"
  }

  -- Clojure
  use {
    "Olical/conjure",
    tag = "v4.8.0",
    ft = {
      "clojure",
      "fennel"
    }
  }

  -- LISP languages
  use {
    "eraserhd/parinfer-rust",
    ft = {
      "clojure",
      "lisp",
      "scheme",
      "racket",
      "jbuild",
      "fennel",
      "pddl"
    },
    run = "cargo build --release"
  }

  -- Cmake
  use {
    "pboettch/vim-cmake-syntax",
    ft = "cmake"
  }

  -- Cmake
  use {
    "vhdirk/vim-cmake",
    ft = "cmake"
  }

  -- CoffeScript
  use {
    "kchmck/vim-coffee-script",
    ft = "coffee"
  }

  -- CJSX (JSX equivalent in CoffeeScript)
  use {
    "mtscout6/vim-cjsx",
    ft = "coffee"
  }

  -- Cassandra CQL
  use {
    "elubow/cql-vim",
    ft = "cql"
  }

  -- Cryptol
  use {
    "victoredwardocallaghan/cryptol.vim",
    ft = "cryptol"
  }

  -- Crystal
  use {
    "vim-crystal/vim-crystal",
    ft = "crystal"
  }

  -- CSV
  use {
    "chrisbra/csv.vim",
    ft = "csv"
  }

  -- Cucumber
  use {
    "tpope/vim-cucumber",
    ft = "cucumber"
  }

  -- Cue
  use {
    "mgrabovsky/vim-cuesheet",
    ft = "cue"
  }

  -- D Lang
  use {
    "JesseKPhillips/d.vim",
    ft = {
      "d",
      "dcov",
      "dd",
      "ddoc",
      "dsdl"
    }
  }

  -- Dafny
  use {
    "mlr-msft/vim-loves-dafny",
    ft = "dafny"
  }

  -- Dart
  use {
    "dart-lang/dart-vim-plugin",
    ft = "dart",
    config = function()
      vim.g.dart_html_in_string= true
      vim.g.dart_style_guide = 2
      vim.g.dart_format_on_save = 1
    end
  }

  -- Dhall
  use {
    "vmchale/dhall-vim",
    ft = "dhall"
  }

  -- Dockerfile
  use {
    "ekalinin/Dockerfile.vim",
    ft = {
      "yaml.docker-compose",
      "dockerfile"
    }
  }

  -- Duckscript
  use {
    "nastevens/vim-duckscript",
    ft = {
      "cargo-make",
      "duckscript"
    }
  }

  -- Elixir
  use {
    "elixir-editors/vim-elixir",
    ft = "elixir"
  }

  -- Emblem
  use {
    "yalesov/vim-emblem",
    ft = "emblem"
  }

  -- Erlang
  use {
    "vim-erlang/vim-erlang-runtime",
    ft = "erlang"
  }

  -- Fennel
  use {
    "bakpakin/fennel.vim",
    ft = "fennel"
  }

  -- Ferm
  use {
    "vim-scripts/ferm.vim",
    ft = "ferm"
  }

  -- Fish
  use {
    "georgewitteman/vim-fish",
    ft = "fish"
  }

  -- Flatbuffers
  use {
    "dcharbon/vim-flatbuffers",
    ft = "fbs"
  }

  -- Fountain
  use {
    "kblin/vim-fountain",
    ft = "fountain"
  }

  -- GDScript 3
  use {
    "calviken/vim-gdscript3",
    ft = {
      "gdscript3",
      "gsl",
      "gd"
    }
  }

  -- Git
  use {
    "tpope/vim-git",
    ft = {
      "git",
      "gitcommit",
      "gitconfig",
      "gitrebase",
      "gitsendemail"
    }
  }

  -- OpenGL Shading Language
  use {
    "tikhomirov/vim-glsl",
    ft = "glsl"
  }

  -- Gleam
  use {
    "gleam-lang/gleam.vim",
    ft = "gleam"
  }

  -- GMPL
  use {
    "maelvls/gmpl.vim",
    ft = "gmpl"
  }

  -- GNUPlot
  use {
    "vim-scripts/gnuplot-syntax-highlighting",
    ft = "gnuplot"
  }

  -- Go
  use {
    "fatih/vim-go",
    ft = "go",
    run = ":GoUpdateBinaries",
    config = function()
      vim.g.go_highlight_structs = 1
      vim.g.go_highlight_interfaces = 1
      vim.g.go_highlight_methods = 1
      vim.g.go_highlight_functions = 1
      vim.g.go_highlight_operators = 1
      vim.g.go_highlight_build_constraints = 1
      vim.g.go_highlight_extra_types = 1
      vim.g.go_highlight_function_parameters = 1
      vim.g.go_highlight_function_calls = 1
      vim.g.go_highlight_types = 1
      vim.g.go_hightlight_fields = 1
      vim.g.go_highlight_generate_tags = 1
      vim.g.go_highlight_variable_declarations = 1
      vim.g.go_highlight_variable_assignments = 1
    end
  }
  

  -- Gradle
  use {
    "tfnico/vim-gradle",
    ft = "groovy"
  }

  -- Hack
  use {
    "hhvm/vim-hack",
    ft = "hack"
  }

  -- Haml
  use {
    "sheerun/vim-haml",
    ft = {
      "haml",
      "sass"
    }
  }

  -- Handlebars
  use {
    "mustache/vim-mustache-handlebars",
    ft = {
      "handlebars",
      "mustache"
    }
  }

  -- HAProxy
  use {
    "CH-DanReif/haproxy.vim",
    ft = "haproxy"
  }

  -- Haskel
  use {
    "neovimhaskell/haskell-vim",
    ft = "haskell",
    config = function()
      -- enable highlighting of `forall`
      vim.g.haskell_enable_quantification = 1
      -- enable highlighting of `mdo` and `rec`
      vim.g.haskell_enable_recursivedo = 1
      -- enable highlighting of `proc`
      vim.g.haskell_enable_arrowsyntax = 1
      -- enable highlighting of `pattern`
      vim.g.haskell_enable_pattern_synonyms = 1
      -- enable highlighting of type roles
      vim.g.haskell_enable_typeroles = 1
      -- enable highlighting of `static`
      vim.g.haskell_enable_static_pointers = 1
      -- enable highlighting of backpack keywords
      vim.g.haskell_backpack = 1
    end
  }

  -- Haxe
  use {
    "yaymukund/vim-haxe",
    ft = "haxe"
  }

  -- HCL
  use {
    "b4b4r07/vim-hcl",
    ft = "hcl"
  }

  -- Helm Templates
  use {
    "towolf/vim-helm",
    ft = "helm"
  }

  -- Hive
  use {
    "zebradil/hive.vim",
    ft = "hive"
  }

  -- HTML5
  use {
    "othree/html5.vim",
    ft = "html",
    config = function()
      vim.call("lexical#init")
      vim.call("pencil#init", {wrap = "soft"})
    end
  }

  -- i3
  use {
    "mboughaba/i3config.vim",
    ft = "i3config"
  }

  -- icalendar
  use {
    "dannywillems/vim-icalendar",
    ft = "icalendar"
  }

  -- Idris
  use {
    "idris-hackers/idris-vim",
    ft = "idris"
  }

  -- Info
  use {
    "HiPhish/info.vim",
    ft = "info"
  }

  -- Ion
  use {
    "vmchale/ion-vim",
    ft = "ion"
  }

  -- ISPC
  use {
    "jez/vim-ispc",
    ft = "ispc"
  }

  -- JST
  use {
    "briancollins/vim-jst",
    ft = "jst"
  }

  -- Jenkins
  use {
    "martinda/Jenkinsfile-vim-syntax",
    ft = "jenkins"
  }

  -- Jinja
  use {
    "lepture/vim-jinja",
    ft = "jinja"
  }

  -- Json
  use {
    "elzr/vim-json",
    ft = "json"
  }

  -- Json5
  use {
    "GutenYe/json5.vim",
    ft = "json5"
  }

  -- Julia
  use {
    "JuliaEditorSupport/julia-vim",
    ft = "julia"
  }

  -- Kotlin
  use {
    "udalov/kotlin-vim",
    ft = "kotlin"
  }

  -- Latex
  use {
    "lervag/vimtex",
    ft = {
      "tex",
      "bib"
    },
    config = function()
      vim.oupdatetime = 100
      vim.glivepreview_use_biber = 1
    end
  }

  -- Latex
  use {
    "xuhdev/vim-latex-live-preview",
    ft = "tex"
  }

  -- Ledger
  use {
    "ledger/vim-ledger",
    ft = "ledger"
  }

  -- Less
  use {
    "groenewege/vim-less",
    ft = "less"
  }

  -- Lilypond
  use {
    "sersorrel/vim-lilypond",
    ft = "lilypond"
  }

  -- LiveScript
  use {
    "gkz/vim-ls",
    ft = "ls"
  }

  -- Log
  use {
    "MTDL9/vim-log-highlighting",
    ft = "log"
  }

  -- Macports
  use {
    "jstrater/mpvim",
    ft = "portfile"
  }

  -- Mako
  use {
    "sophacles/vim-bundle-mako",
    ft = "mako"
  }

  -- Markdown
  use {
    "plasticboy/vim-markdown",
    ft = "markdown"
  }

  -- Markdown (Github)
  use {
    "rhysd/vim-gfm-syntax",
    opt = true
  }

  -- Mathematica
  use {
    "voldikss/vim-mma",
    ft = "mma"
  }

  -- Matlab
  use {
    "daeyun/vim-matlab",
    ft = "matlab"
  }

  -- MDX
  use {
    "jxnblk/vim-mdx-js",
    ft = "mdx"
  }

  -- Mercury
  use {
    "stewy33/mercury-vim",
    ft = "mercury"
  }

  -- MoonScript
  use {
    "leafo/moonscript-vim",
    ft = "moon"
  }

  -- Nginx
  use {
    "chr4/nginx.vim",
    ft = "nginx"
  }

  -- Nim
  use {
    "zah/nim.vim",
    ft = "nim"
  }

  -- Nix
  use {
    "LnL7/vim-nix",
    ft = "nix"
  }

  -- Objective-C
  use {
    "b4winckler/vim-objc",
    ft = "objc"
  }

  -- OCaml
  use {
    "ocaml/vim-ocaml",
    ft = {
      "dune",
      "oasis",
      "ocaml",
      "ocamlbuild_tags",
      "omake",
      "sexplib"
    }
  }

  -- Octave
  use {
    "McSinyx/vim-octave",
    ft = "octave"
  }

  -- Pawn
  use {
    "mcnelson/vim-pawn",
    ft = "pawn"
  }

  -- Pandoc
  use {
    "vim-pandoc/vim-pandoc",
    ft = "pandoc"
  }

  -- Pandoc
  use {
    "vim-pandoc/vim-pandoc-syntax",
    ft = "pandoc"
  }

  -- PERL
  use {
    "vim-perl/vim-perl",
    ft = {
      "perl",
      "perl6"
    }
  }

  -- PostgreSQL
  use {
    "lifepillar/pgsql.vim",
    ft = "pgsql"
  }

  -- PlantUML
  use {
    "aklt/plantuml-syntax",
    ft = "plantuml"
  }

  -- Ponylang
  use {
    "jakwings/vim-pony",
    ft = "pony"
  }

  -- PowerShell
  use {
    "PProvost/vim-ps1",
    ft = {
      "ps1",
      "ps1xml"
    }
  }

  -- Prolog
  use {
    "adimit/prolog.vim",
    ft = "prolog"
  }

  -- Protocol Buffers
  use {
    "uarun/vim-protobuf",
    ft = "proto"
  }

  -- Pug
  use {
    "digitaltoad/vim-pug",
    ft = "pug"
  }

  -- Puppet
  use {
    "rodjek/vim-puppet",
    ft = {
      "puppet",
      "embeddedpuppet"
    }
  }

  -- PureScript
  use {
    "purescript-contrib/purescript-vim",
    ft = "purescript"
  }

  -- QMake
  use {
    "artoj/qmake-syntax-vim",
    ft = "qmake"
  }

  -- QML
  use {
    "peterhoeg/vim-qml",
    ft = "qml"
  }

  -- R
  use {
    "jalvesaq/Nvim-R",
    ft = "r"
  }

  -- Racket
  use {
    "wlangstroth/vim-racket",
    ft = "racket"
  }

  -- Ragel
  use {
    "jneen/ragel.vim",
    ft = "ragel"
  }

  -- Raku
  use {
    "Raku/vim-raku",
    ft = "raku"
  }

  -- RAML
  use {
    "IN3D/vim-raml",
    ft = "raml"
  }

  -- Razor view engine
  use {
    "adamclerk/vim-razor",
    ft = "razor"
  }

  -- Reason
  use {
    "reasonml-editor/vim-reason-plus",
    ft = "reason"
  }

  -- reStructuredText
  use {
    "marshallward/vim-restructuredtext",
    ft = "rst"
  }

  -- RSpec
  use {
    "keith/rspec.vim",
    ft = "rspec"
  }

  -- RON
  use {
    "ron-rs/ron.vim",
    ft = "ron"
  }

  -- Ruby
  use {
    "vim-ruby/vim-ruby",
    ft = {
      "eruby",
      "ruby"
    }
  }

  -- Rust
  use {
    "rust-lang/rust.vim",
    ft = "rust"
  }

  -- SBT
  use {
    "derekwyatt/vim-sbt",
    ft = "sbt"
  }

  -- Scala
  use {
    "derekwyatt/vim-scala",
    ft = "scala"
  }

  -- SCSS
  use {
    "cakebaker/scss-syntax.vim",
    ft = "scss"
  }

  -- Shell
  use {
    "arzg/vim-sh",
    ft = "sh"
  }

  -- Slim
  use {
    "slim-template/vim-slim",
    ft = "slim"
  }

  -- Slime
  use {
    "slime-lang/vim-slime-syntax",
    ft = "slime"
  }

  -- SML
  use {
    "jez/vim-better-sml",
    ft = "sml"
  }

  -- SMT-LIB2
  use {
    "bohlender/vim-smt2",
    ft = "smt2"
  }

  -- Solidity
  use {
    "tomlion/vim-solidity",
    ft = "solidity"
  }

  -- Starlark
  use {
    "cappyzawa/starlark.vim",
    ft = "starlark"
  }

  -- Sugarss
  use {
    "hhsnopek/vim-sugarss",
    ft = "sugarss"
  }

  -- Stylus
  use {
    "wavded/vim-stylus",
    ft = "stylus"
  }

  -- Svelte
  use {
    "leafOfTree/vim-svelte-plugin",
    ft = "svelte",
    config = function()
        vim.g.vim_svelte_plugin_load_full_syntax = 1
    end
  }

  -- Swift
  use {
    "keith/swift.vim",
    ft = "swift"
  }

  -- Systemd
  use {
    "wgwoods/vim-systemd-syntax",
    ft = "systemd"
  }

  -- SXHKD (bspwm)
  use {
    "baskerville/vim-sxhkdrc",
    ft = "sxhkdrc"
  }

  -- Terraform
  use {
    "hashivim/vim-terraform",
    ft = "terraform"
  }

  -- Textile
  use {
    "timcharper/textile.vim",
    ft = "textile"
  }

  -- Thrift
  use {
    "solarnz/thrift.vim",
    ft = "thrift"
  }

  -- TomDoc
  use {
    "wellbredgrapefruit/tomdoc.vim",
    ft = "tomdoc"
  }

  -- TPTP
  use {
    "c-cube/vim-tptp",
    ft = "tptp"
  }

  -- Twig
  use {
    "lumiliet/vim-twig",
    ft = "twig"
  }

  -- V
  use {
    "ollykel/v-vim",
    ft = {
      "v",
      "vlang"
    }
  }

  -- Vala
  use {
    "arrufat/vala.vim",
    ft = "vala"
  }

  -- VB.NET
  use {
    "vim-scripts/vbnet.vim",
    ft = "vb.net"
  }

  -- VCL
  use {
    "smerrill/vcl-vim-plugin",
    ft = "vcl"
  }

  -- Velocity
  use {
    "lepture/vim-velocity",
    ft = "velocity"
  }

  -- vifm
  use {
    "vifm/vifm.vim",
    ft = {
      "vifm",
      "vifm-rename"
    }
  }

  -- VHDL
  use {
    "suoto/vim-hdl",
    ft = "vhdl"
  }

  -- Vue
  use {
    "posva/vim-vue",
    ft = "vue"
  }

  -- XDC
  use {
    "amal-khailtash/vim-xdc-syntax",
    ft = "xdc"
  }

  -- XSL
  use {
    "vim-scripts/XSLT-syntax",
    ft = "xsl"
  }

  -- XML
  use {
    "amadeus/vim-xml",
    ft = "xml"
  }

  -- YAML
  use {
    "stephpy/vim-yaml",
    ft = "yaml"
  }

  -- YANG
  use {
    "nathanalderson/yang.vim",
    ft = "yang"
  }

  -- YARD Documentation
  use {
    "sheerun/vim-yardoc",
    ft = {
      "eruby",
      "ruby"
    }
  }

  -- Zephir
  use {
    "xwsoul/vim-zephir",
    ft = "zephir"
  }

  -- Zig
  use {
    "ziglang/zig.vim",
    ft = "zig"
  }

  -- Zinit
  use {
    "zinit-zsh/zinit-vim-syntax",
    ft = "zsh"
  }

  -- Zsh
  use {
    "chrisbra/vim-zsh",
    ft = "zsh"
  }
end

local plugins =
  setmetatable(
  {},
  {
    __index = function(_, key)
      init()
      return packer[key]
    end
  }
)
return plugins
