local packer = nil

local function init()
  if packer == nil then
    packer = require("packer")
    packer.init()
  end

  local use = packer.use
  packer.reset()

  use {"wbthomason/packer.nvim", opt = true}

  -- My spacemacs colorscheme
  use {
    "Th3Whit3Wolf/space-nvim-theme",
    branch = "main"
  }

  use {
    "Th3Whit3Wolf/Dusk-til-Dawn.nvim",
    opt = true,
    branch = "main",
    setup = function()
      vim.g.dusk_til_dawn_light_luafile =
        "~/.local/share/nvim/site/pack/packer/opt/space-nvim-theme/lua/space-nvim-theme.lua"
      vim.g.dusk_til_dawn_dark_luafile =
        "~/.local/share/nvim/site/pack/packer/opt/space-nvim-theme/lua/space-nvim-theme.lua"
      vim.g.dusk_til_dawn_morning = 7
      vim.g.dusk_til_dawn_night = 19
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
    branch = "main"
  }

  -- Modern vim-startify
  use {"glepnir/dashboard-nvim"}

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

  -- auto completion framework that aims to provide a better completion experience with neovim's built-in LSP
  use {
    "nvim-lua/completion-nvim",
    config = function()
      require "plugins.lsp"
    end
  }

  -- Collection of common configurations for the Nvim LSP client.
  use {"neovim/nvim-lspconfig"}

  -- bunch of info & extension callbacks for built-in LSP (provides inlay hints)
  use {"tjdevries/lsp_extensions.nvim"}

  -- Snippet plugin for vim/nvim that supports LSP/VSCode's snippet forma
  use {"hrsh7th/vim-vsnip"}

  -- vim-vsnip integrations to other plugins
  use {"hrsh7th/vim-vsnip-integ"}

  --use "nvim-treesitter/completion-treesitter"
  use "kristijanhusak/vim-dadbod-completion"

  -- Completion for buffers word.
  use "steelsojka/completion-buffers"

  -- Treesitter configurations and abstraction layer for Neovim.
  -- use {
  --  "nvim-treesitter/nvim-treesitter",
  --  run = ":TSUpdate"
  --}

  -- high-performance color highlighter for Neovim
  use {
    "norcalli/nvim-colorizer.lua",
    opt = true
  }

  -- A surround text object plugin for neovim, written in lua.
  use {
    "blackcauldron7/surround.nvim",
    opt = true
  }

  use {
    "Raimondi/delimitMate",
    event = "InsertEnter *"
  }

  ----------
  -- Lazy --
  ----------

  -- uses the sign column to indicate added, modified and removed lines in a file that is managed by a version control system
  use {
    "mhinz/vim-signify",
    opt = true,
    config = function()
      vim.g.signify_sign_add = ""
      vim.g.signify_sign_delete = ""
      vim.g.signify_sign_delete_first_line = ""
      vim.g.signify_sign_change = ""
      vim.g.signify_sign_change = ""
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

  -- shows the history of commits under the cursor in popup window
  use {
    "rhysd/git-messenger.vim",
    cmd = "GitMessenger"
  }

  -- Vim plugin that shows keybindings in popup
  use {
    "liuchengxu/vim-which-key",
    opt = true
  }

  -- improves the git commit buffer
  use {
    "rhysd/committia.vim",
    opt = true
  }

  -- Asynchronously control git repositories in Neovim
  use {
    "lambdalisue/gina.vim",
    opt = true
  }

  -- A simple, easy-to-use Vim alignment plugin
  use {
    "junegunn/vim-easy-align"
  }

  -- Viewer & Finder for LSP symbols and tags
  use {
    "liuchengxu/vista.vim",
    cmd = "Vista"
    --config = function()
    -- How each level is indented and what to prepend.
    -- This could make the display more compact or more spacious.
    -- e.g., more compact: ["▸ ", ""]
    -- Note: this option only works the LSP executives, doesn't work for `:Vista ctags`
    --    vim.cmd [[ let g:vista_icon_indent = ["╰─▸ ", "├─▸ "] ]]
    -- Executive used when opening vista sidebar without specifying it.
    -- See all the avaliable executives via `:echo g:vista#executives`.
    --    vim.cmd [[ let g:vista_default_executive = 'ctags' ]]
    -- To enable fzf's preview window set g:vista_fzf_preview.
    -- The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
    -- For example:
    --    vim.cmd [[ let g:vista_fzf_preview = ['right:50%'] ]]
    -- Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
    --    vim.cmd [[ let g:vista#renderer#enable_icon = 1 ]]
    -- The default icons can't be suitable for all the filetypes, you can extend it as you wish.
    --    vim.cmd [[ let g:vista#renderer#icons = { "function": "\uf794", "variable": "\uf71b" } ]]
    --end
  }

  -- Auto close (X)HTML tags
  use {
    "alvan/vim-closetag",
    opt = true
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
    event = "InsertEnter *"
    -- config = function()
    --vim.cmd('RainbowParentheses')
    --end
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
    opt = true
  }

  -- handful of tweaks needed to smooth the path to writing prose
  use {
    "reedes/vim-pencil",
    opt = true
  }
  -- Zinit
  use {
    "zinit-zsh/zinit-vim-syntax",
    opt = true
  }

  -- Zsh
  use {
    "chrisbra/vim-zsh",
    opt = true
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
