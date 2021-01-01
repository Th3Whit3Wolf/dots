vim.cmd "packadd paq-nvim"
local Paq = require "paq-nvim"
local paq = Paq.paq

local M = {}
local function plugins()
    paq {"savq/paq-nvim", opt = true}

    -- My spacemacs colorscheme
    paq {
        "Th3Whit3Wolf/space-nvim-theme",
        branch = "main"
    }

    -- neovim statusline plugin written in lua
    paq {
        "glepnir/galaxyline.nvim",
        branch = "main"
    }

    -- Indent Guides (written in lua)
    paq {
        "glepnir/indent-guides.nvim",
        branch = "main"
    }

    -- Modern vim-startify
    paq "glepnir/dashboard-nvim"

    -- devicons in lua
    paq "kyazdani42/nvim-web-devicons"

    -- A File Explorer For Neovim Written In Lua
    paq {"kyazdani42/nvim-tree.lua", opt = true}

    -- auto completion framework that aims to provide a better completion experience with neovim's built-in LSP
    paq "nvim-lua/completion-nvim"

    -- Collection of common configurations for the Nvim LSP client.
    paq "neovim/nvim-lspconfig"

    -- bunch of info & extension callbacks for built-in LSP (provides inlay hints)
    paq "tjdevries/lsp_extensions.nvim"

    -- Snippet plugin for vim/nvim that supports LSP/VSCode's snippet forma
    paq "hrsh7th/vim-vsnip"

    -- vim-vsnip integrations to other plugins
    paq "hrsh7th/vim-vsnip-integ"

    --use "nvim-treesitter/completion-treesitter"
    paq "kristijanhusak/vim-dadbod-completion"

    -- Completion for buffers word.
    paq "steelsojka/completion-buffers"

    -- high-performance color highlighter for Neovim
    paq {
        "norcalli/nvim-colorizer.lua",
        opt = true
    }

    -- A surround text object plugin for neovim, written in lua.
    paq {
        "blackcauldron7/surround.nvim",
        opt = true
    }

    paq {
        "Raimondi/delimitMate",
        opt = true
    }

    -- uses the sign column to indicate added, modified and removed lines in a file that is managed by a version control system
    paq {
        "mhinz/vim-signify",
        opt = true
    }

    -- Vim sugar for the UNIX shell commands
    paq {
        "tpope/vim-eunuch",
        opt = true
    }

    -- shows the history of commits under the cursor in popup window
    paq {
        "rhysd/git-messenger.vim",
        opt = true
    }

    -- Vim plugin that shows keybindings in popup
    paq {
        "liuchengxu/vim-which-key",
        opt = true
    }

    -- improves the git commit buffer
    paq {
        "rhysd/committia.vim",
        opt = true
    }

    -- Asynchronously control git repositories in Neovim
    paq {
        "lambdalisue/gina.vim",
        opt = true
    }

    -- A simple, easy-to-use Vim alignment plugin
    paq "junegunn/vim-easy-align"

    paq {
        "liuchengxu/vista.vim",
        opt = true
    }

    -- Auto close (X)HTML tags
    paq {
        "alvan/vim-closetag",
        opt = true
    }

    paq {
        "turbio/bracey.vim",
        hook = "npm install --prefix server",
        opt = true
    }

    -- An asynchronous markdown preview plugin for Neovim
    paq {
        "euclio/vim-markdown-composer",
        hook = "cargo build --release",
        opt = true
    }

    -- Simpler Rainbow Parentheses
    paq {
        "junegunn/rainbow_parentheses.vim",
        opt = true
    }

    -- Read DotEnv
    paq {
        "tpope/vim-dotenv",
        opt = true
    }

    -- Profiling
    paq {
        "tweekmonster/startuptime.vim",
        opt = true
    }

    --------------------------------------------
    --     ____                               --
    --    / __ \   _____  ____    _____  ___  --
    --   / /_/ /  / ___/ / __ \  / ___/ / _ \ --
    --  / ____/  / /    / /_/ / (__  ) /  __/ --
    -- /_/      /_/     \____/ /____/  \___/  --
    --------------------------------------------

    -- Add all of these in  `lazy/git`
    -- Uncover usage problems in your writing
    paq {
        "reedes/vim-wordy",
        opt = true
    }

    -- Highlights overused words
    paq {
        "dbmrq/vim-ditto",
        opt = true
    }

    -- Building on Vim’s spell-check and thesaurus/dictionary completion
    paq {
        "reedes/vim-lexical",
        opt = true
    }

    -- handful of tweaks needed to smooth the path to writing prose
    paq {
        "reedes/vim-pencil",
        opt = true
    }

    -----------------------------------------------------------------------------
    --     __                                                                  --
    --    / /   ____ _   ____    ____ _  __  __  ____ _   ____ _  ___    _____ --
    --   / /   / __ `/  / __ \  / __ `/ / / / / / __ `/  / __ `/ / _ \  / ___/ --
    --  / /___/ /_/ /  / / / / / /_/ / / /_/ / / /_/ /  / /_/ / /  __/ (__  )  --
    -- /_____/\__,_/  /_/ /_/  \__, /  \__,_/  \__,_/   \__, /  \___/ /____/   --
    --                        /____/                   /____/                  --
    -----------------------------------------------------------------------------

    -- Zinit
    paq {
        "zinit-zsh/zinit-vim-syntax",
        opt = true
    }

    -- Zsh
    paq {
        "chrisbra/vim-zsh",
        opt = true
    }
end

function M.install()
    plugins()
    Paq.install()
end

function M.update()
    plugins()
    Paq.update()
end

function M.clean()
    plugins()
    Paq.clean()
end

return M