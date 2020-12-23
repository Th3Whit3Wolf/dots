local packer = nil

local function init()
  if packer == nil then
    packer = require("packer")
    packer.init({})
  end

  local use = packer.use
  packer.reset()

  use {"wbthomason/packer.nvim", opt = true}

  -- My spacemacs colorscheme
  use {
    "Th3Whit3Wolf/space-nvim-theme",
    branch = "main"
  }

  -- neovim statusline plugin written in lua
  use {
    "glepnir/galaxyline.nvim",
    branch = "main",
    config = function()
      require "plugins.statusline"
    end
  }

  -- Modern vim-startify
  use {"glepnir/dashboard-nvim"}

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
  use "steelsojka/completion-buffers"

  -- Treesitter configurations and abstraction layer for Neovim.
  -- use {
  --  "nvim-treesitter/nvim-treesitter",
  --  run = ":TSUpdate"
  --}

  ---------------
  -- FTPlugins --
  ---------------
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
