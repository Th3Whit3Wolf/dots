local G = require "global"
local g =  vim.g

-- DB UI
g["db_ui_save_location"] = G.cache_dir .. "dadbod_queries"

-- Dusk til Dawn
if G.exists("/tmp/sway-colord/dawn") then
  g["dusk_til_dawn_sway_colord"] = true
end

-- Vsnip snippet directories
g["vsnip_snippet_dir"] = G.vim_path .. "snippets"

-- Endwise No default mapping
g["endwise_no_mappings"] = 1

-- Gutentags
g["gutentags_cache_dir"] = G.cache_dir .. '/tags'
