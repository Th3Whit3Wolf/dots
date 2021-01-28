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

if G.exists("/tmp/sway-colord/dawn") then
    g["dusk_til_dawn_sway_colord"] = true
end
-- Dusk til Dawn
g["dusk_til_dawn_morning"] = 7
g["dusk_til_dawn_night"] = 19
g["space_nvim_transparent_bg"] = true

-- Prose
--g["lexical#thesaurus"] = {'~/.config/nvim/thesaurus/mthesaur.txt', '~/.config/nvim/moby_thesaurus.txt'}
g["lexical#dictionary"] = {'/usr/share/dict/words'}
g["lexical#spellfile"] = {'~/.config/nvim/spell/en.utf-8.add'}
g["lexical#thesaurus_key"] = '<leader>lt'
g["lexical#dictionary_key"] = '<leader>ld'

-- No default mapping for git_messenger
g["git_messenger_no_default_mappings"] = true

require("Dusk-til-Dawn").timeMan(
    function()
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
    end,
    function()
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
)()

require"toggleterm".setup{
    size = 12,
    open_mapping = [[<a-t>]],
    shade_terminals = false,
    persist_size = true,
    direction = 'horizontal'
}

require('telescope').setup{
    defaults = {
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
      file_sorter =  require'telescope.sorters'.get_fuzzy_file,
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
      file_previewer = require'telescope.previewers'.cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
      grep_previewer = require'telescope.previewers'.vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
      qflist_previewer = require'telescope.previewers'.qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`
  
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    }
}

require 'plugins.lsp'
require('nvim-autopairs').setup()
require 'plugins.statusline'