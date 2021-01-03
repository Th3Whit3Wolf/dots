local G = require "global"
local g =  vim.g

-- DB UI
g["db_ui_env_variable_url"] = "DATABASE_URL"
g["db_ui_env_variable_name"] = "DATABASE_NAME"
g["db_ui_save_location"] = G.cache_dir .. "dadbod_queries"
-- Vsnip snippet directories
g["vsnip_snippet_dir"] = G.vim_path .. "snippets"

-- Endwise No default mapping

g["endwise_no_mappings"] = 1
require 'plugins.lsp'
require 'plugins.statusline'
require('indent_guides').setup(
    {
        even_colors = {fg = "#5C5E61", bg = "#5C5E61"},
        odd_colors = {fg = "#434548", bg = "#434548"},
        indent_space_guides = true,
        indent_tab_guides = true,
        indent_guide_size = 4
    }
)
require('indent_guides').indent_guides_enable()
require"toggleterm".setup{
    size = 12,
    open_mapping = [[<a-t>]],
    shade_terminals = true,
    persist_size = true,
    direction = 'horizontal'
  }