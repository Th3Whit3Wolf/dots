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

-- Dusk til Dawn
g["dusk_til_dawn_morning"] = 7
g["dusk_til_dawn_night"] = 19

-- Prose
g["lexical#thesaurus"] = {'~/.config/nvim/thesaurus/mthesaur.txt', '~/.config/nvim/moby_thesaurus.txt'}
g["lexical#dictionary"] = {'/usr/share/dict/words'}
g["lexical#spellfile"] = {'~/.config/nvim/spell/en.utf-8.add'}
g["lexical#thesaurus_key"] = '<leader>lt'
g["lexical#dictionary_key"] = '<leader>ld'

require 'plugins.lsp'
if vim.o.background ~= nil and vim.o.background == "light" then
    require('indent_guides').setup(
        {
            even_colors = {fg = "#d3d3e7", bg = "#d3d3e7"},
            odd_colors = {fg = "#e7e5eb", bg = "#e7e5eb"},
            indent_space_guides = true,
            indent_tab_guides = true,
            indent_guide_size = 4
        }
    )
    require('indent_guides').indent_guides_enable()
elseif vim.o.background ~= nil and vim.o.background == "dark" then
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
else
    local hours = tonumber(os.date("%H"))
    if hours >= vim.g["dusk_til_dawn_morning"] and hours < vim.g["dusk_til_dawn_night"] then
        require('indent_guides').setup(
            {
                even_colors = {fg = "#d3d3e7", bg = "#d3d3e7"},
                odd_colors = {fg = "#e7e5eb", bg = "#e7e5eb"},
                indent_space_guides = true,
                indent_tab_guides = true,
                indent_guide_size = 4
            }
        )
        require('indent_guides').indent_guides_enable()
    else
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
    end
end

require"toggleterm".setup{
    size = 12,
    open_mapping = [[<a-t>]],
    shade_terminals = true,
    persist_size = true,
    direction = 'horizontal'
  }

require 'plugins.tree_sitter'
require 'plugins.statusline'
