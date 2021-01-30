local g =  vim.g
local G = require "global"


-- DB UI
g["db_ui_env_variable_url"] = "DATABASE_URL"
g["db_ui_env_variable_name"] = "DATABASE_NAME"
g["db_ui_save_location"] = G.cache_dir .. "dadbod_queries"
g["db_ui_win_position"] = 'left'
g["db_ui_use_nerd_fonts"] = 1
g["db_ui_winwidth"] = 35

-- Vsnip snippet directories
g["vsnip_snippet_dir"] = G.vim_path .. "snippets"


-- Barbar
-- Enable/disable animations
g["bufferline.animation"] = false

-- Vista
--- How each level is indented and what to prepend.
--- This could make the display more compact or more spacious.
--- e.g., more compact: ["▸ ", ""]
--- Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
g["vista_icon_indent"] = {"╰─▸ ", "├─▸ "}

--- Executive used when opening vista sidebar without specifying it.
--- See all the avaliable executives via `:echo g:vista#executives`.
g["vista_default_executive"] = 'ctags'

-- Set the executive for some filetypes explicitly. Use the explicit executive
-- instead of the default one for these filetypes when using `:Vista` without
-- specifying the executive.
g["vista_executive_for"] = {
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

g["vista_disable_statusline"] = 1

-- Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
g["vista#renderer#enable_icon"] = 1

-- Endwise No default mapping
g["endwise_no_mappings"] = 1

if G.exists("/tmp/sway-colord/dawn") then
    g["dusk_til_dawn_sway_colord"] = true
end

-- Gutentags
g["gutentags_cache_dir"] = G.cache_dir .. '/tags'
g["gutentags_project_root"] = {'.root', '.git', '.svn', '.hg', '.project','go.mod', 'Cargo.toml', '.bzr', '_darcs', '_FOSSIL_', '.fslckout','tsconfig.js','jsconfig.js'}
g["gutentags_generate_on_write"] = 0
g["gutentags_generate_on_missing"] = 0
g["gutentags_generate_on_new"] = 0
g["gutentags_exclude_filetypes"] = {'defx', 'denite', 'vista', 'magit'}
g["gutentags_ctags_extra_args"] = {'--output-format=e-ctags'}
g["gutentags_ctags_exclude"] = {'*.json', '*.js', '*.ts', '*.jsx', '*.css', '*.less', '*.sass', '*.go', '*.dart', 'node_modules', 'dist', 'vendor'}

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