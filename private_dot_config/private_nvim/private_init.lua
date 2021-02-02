-------------------- HELPERS -------------------------------
local vim = vim
local api, cmd, fn, g, env = vim.api, vim.cmd, vim.fn, vim.g, vim.env
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local G = require "global"
require "setup"

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end

local function command(name, exec)
    api.nvim_command("command! " .. name .. " " .. exec)
end

-- Set map leader (needs to be set before mappings)
g["mapleader"] = " "
g["completion_confirm_key"] = ""

-- Check for .env in local and parent recursively
-- Until after home directory is checked
function _G.check_env(path)
    local new_path = path .. G.path_sep .. ".env"
    if G.exists(new_path) then
        cmd("Dotenv " .. new_path)
    elseif path == env.HOME or path == "/" then 
        return
    else
        check_env(vim.fn.fnamemodify(path, ':h'))
    end
end
-------------------- VARIABLES ----------------------------
if G.isdir(G.python3 .. "bin") then
    g["python3_host_prog"] = G.python3 .. "bin" .. G.path_sep .. "python"
end
if G.exists(G.node) then
    g["node_host_prog"] = G.node
end

-- Disable builtin plugins
g["loaded_gzip"] = 1
g["loaded_tar"] = 1
g["loaded_tarPlugin"] = 1
g["loaded_zip"] = 1
g["loaded_zipPlugin"] = 1
g["loaded_getscript"] = 1
g["loaded_getscriptPlugin"] = 1
g["loaded_vimball"] = 1
g["loaded_vimballPlugin"] = 1
g["loaded_matchit"] = 1
g["loaded_matchparen"] = 1
g["loaded_2html_plugin"] = 1
g["loaded_logiPat"] = 1
g["loaded_rrhelper"] = 1
g["loaded_netrw"] = 1
g["loaded_netrwPlugin"] = 1
g["loaded_netrwSettings"] = 1
g["loaded_netrwFileHandlers"] = 1
g["loaded_fzf"] = 1
g["loaded_skim"] = 1
g["loaded_tutor_mode_plugin"] = 1

-- Disable provider for perl, python2, & ruby
g["loaded_python_provider"] = 0
g["loaded_ruby_provider"] = 0
g["loaded_perl_provider"] = 0

-- Used for floating windows
g["floating_window_winblend"] = 0
g["floating_window_scaling_factor"] = 0.8
g["neovim_remote"] = 1

g["rg_derive_root"] = true
-------------------- OPTIONS -------------------------------
opt("o", "mouse", "a") -- Enable mouse
opt("o", "report", 2) -- 2 for telescope --0 Automatically setting options from modelines
opt("o", "errorbells", true) -- Trigger bell on error
opt("o", "visualbell", true) -- Use visual bell instead of beeping
opt("o", "hidden", true) -- hide buffers when abandoned instead of unload
opt("o", "fileformats", "unix,mac,dos") -- Use Unix as the standard file type
opt("o", "magic", true) -- For regular expressions turn magic on
opt("o", "path", ".,**") -- Directories to search when using gf
opt("o", "virtualedit", "block") -- Position cursor anywhere in visual block
opt("o", "synmaxcol", 2500) -- Don't syntax highlight long lines
opt("o", "formatoptions", "1jtcroq") -- Don't break lines after a one-letter word & Don't auto-wrap text
opt("o", "lazyredraw", true) -- Don't redraw screen while running macros
opt("o", "encoding", "utf-8")

-- What to save for views and sessions:
opt("o", "viewoptions", "folds,cursor,curdir,slash,unix")
opt("o", "sessionoptions", "curdir,globals,help,tabpages,winsize")
opt("o", "clipboard", "unnamedplus")

-- Wildmenu
opt("o", "wildmenu", false)
opt("o", "wildmode", "list:longest,full")
opt("o", "wildoptions", "tagfile")
opt("o", "wildignorecase", true)
opt(
    "o",
    "wildignore",
    "*.so,.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**,*/.sass-cache/*,application/vendor/**,**/vendor/ckeditor/**,media/vendor/**,__pycache__,*.egg-info"
)

-- Neovim Directories
opt("o", "backup", false)
opt("o", "writebackup", false)
opt("b", "undofile", true)
opt("o", "undolevels", 1000) -- How many steps of undo history Vim should remember
opt("o", "directory", G.cache_dir .. "swap/," .. G.cache_dir .. ",~/tmp,/var/tmp,/tmp")
opt("o", "undodir", G.cache_dir .. "undo/," .. G.cache_dir .. ",~/tmp,/var/tmp,/tmp")
opt("o", "backupdir", G.cache_dir .. "backup/," .. G.cache_dir .. ",~/tmp,/var/tmp,/tmp")
opt("o", "backupskip", "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim")
opt("o", "viewdir", G.cache_dir .. "view/," .. G.cache_dir .. ",~/tmp,/var/tmp,/tmp")
opt("o", "spellfile", G.cache_dir .. "spell/en.uft-8.add")
opt("o", "swapfile", true)
opt("o", "history", 2000) -- History saving

--  ShaDa/viminfo:
--   ' - Maximum number of previously edited files marks
--   < - Maximum number of lines saved for each register
--   @ - Maximum number of items in the input-line history to be
--   s - Maximum size of an item contents in KiB
--   h - Disable the effect of 'hlsearch' when loading the shada
opt("o", "shada", "!,'300,<50,@100,s10,h")

-- Tabs and Indents
opt("o", "textwidth", 100) -- Text width maximum chars before wrapping
opt("o", "expandtab", true) -- Expand tabs to spaces.
opt("o", "tabstop", 4) -- The number of spaces a tab is
opt("o", "shiftwidth", 4) -- Number of spaces to use in auto(indent)
opt("o", "softtabstop", -1) -- Number of spaces to use in auto(indent)
opt("o", "smarttab", true) -- Tab insert blanks according to 'shiftwidth'
opt("o", "autoindent", true) -- Use same indenting on new lines
opt("o", "shiftround", false) -- Round indent to multiple of 'shiftwidth'
opt("o", "cindent", true) -- Increase indent on line after opening brace
opt("b", "smartindent", true) -- Insert indents automatically
opt("o", "breakindentopt", "shift:2,min:20") -- Settingf for breakindent

-- Timing
opt("o", "timeout", true)
opt("o", "ttimeout", true)
opt("o", "timeoutlen", 500) -- Time out on mappings
opt("o", "ttimeoutlen", 10) -- Time out on key codes
opt("o", "updatetime", 100) -- Idle time to write swap and trigger CursorHold
opt("o", "redrawtime", 1500) -- Time in milliseconds for stopping display redraw

-- Searching
opt("o", "ignorecase", true) -- Search ignoring case
opt("o", "smartcase", true) -- Keep case when searching with *
opt("o", "infercase", true) -- Adjust case in insert completion mode
opt("o", "incsearch", true) -- Incremental search
opt("o", "hlsearch", true) -- Highlight search results
opt("o", "wrapscan", true) -- Searches wrap around the end of the file
opt("o", "showmatch", true) -- Jump to matching bracket
opt("o", "matchpairs", "(:),{:},[:],<:>") -- Add HTML brackets to pair matching
opt("o", "matchtime", 1) -- Tenths of a second to show the matching paren
opt("o", "grepformat", "%f:%l:%c:%m")
opt("o", "grepprg", "rg --hidden --vimgrep --smart-case --")

-- Behavior
opt("o", "wrap", true) -- No wrap by default
opt("o", "linebreak", true) -- Break long lines at 'breakat'
opt("o", "breakat", [[\ \	;:,!?]]) -- Long lines break chars
opt("o", "startofline", false) -- Cursor in same column for few commands
opt("o", "whichwrap", "h,l,<,>,[,],~") -- Move to following line on certain keys
opt("o", "shell", "/bin/zsh") -- Use zsh shell in terminal
opt("o", "splitbelow", true) -- Splits open bottom
opt("o", "splitright", true) -- Splits open right
opt("o", "switchbuf", "useopen,usetab,vsplit") -- Jump to the first open window in any tab & switch buffer behavior to vsplit
opt("o", "backspace", "indent,eol,start") -- Intuitive backspacing in insert mode
opt("o", "diffopt", "filler,iwhite,internal,algorithm:patience") -- Diff mode: show fillers, ignore whitespace, use internal patience diff library,
opt("o", "showfulltag", true) -- Show tag and tidy search in completion
opt("o", "complete", ".,w,b,k") -- No wins, buffs, tags, include scanning
opt("o", "inccommand", "nosplit")
opt("o", "completeopt", "menu,menuone,noselect,noinsert") -- Set completeopt to have a better completion experience
opt("o", "joinspaces", false) -- Insert only one space when joining lines that contain sentence-terminating punctuation like `.`.
opt("o", "jumpoptions", "stack") -- list of words that change the behavior of the jumplist

-- Editor UI Appearance
opt("o", "showmode", false) -- Don't show mode in cmd window
opt("o", "shortmess", "filnxtToOFc") -- Don't pass messages to |ins-completion-menu|.
opt("o", "scrolloff", 3) -- Keep at least 3 lines above/below
opt("o", "sidescrolloff", 5) -- Keep at least 5 lines left/right
opt("w", "number", true) -- Print line number
opt("o", "relativenumber", true) -- Show line number relative to current line
opt("o", "numberwidth", 4) -- The width of the number column
opt("o", "ruler", false) -- Disable default status ruler
opt("o", "list", true) -- Show hidden characters
opt("o", "listchars", "tab:»·,nbsp:+,trail:·,extends:→,precedes:←")
opt("o", "cursorcolumn", false) -- Highlight the current column
opt("o", "cursorline", false) -- Highlight the current line

opt("o", "signcolumn", "yes") -- Always show signcolumns
opt("o", "laststatus", 2) -- Always show a status line
--opt('o', 'showtabline', 2)    -- Always show the tabs line
opt("o", "winwidth", 30)
opt("o", "winminwidth", 10)
opt("o", "pumheight", 15) -- Pop-up menu's line height
opt("o", "helpheight", 12) -- Minimum help window height
opt("o", "previewheight", 12) -- Completion preview height

opt("o", "showcmd", false) -- Don't show command in status line
opt("o", "cmdheight", 2) -- Height of the command line
opt("o", "cmdwinheight", 5) -- Command-line lines
opt("o", "equalalways", false) -- Don't resize windows on split or close
opt("o", "colorcolumn", "100") -- Highlight the 100th character limit
opt("o", "display", "lastline")
if env["TERM"] == "linux" then
    opt("o", "termguicolors", false)
else
    opt("o", "termguicolors", true)
    g["dusk_til_dawn_light_theme"] = "space-nvim"
    g["dusk_til_dawn_dark_theme"] = "space-nvim"
end

opt("o", "pumblend", 10)
opt("o", "showbreak", "↳  ")
opt("o", "conceallevel", 2)
opt("o", "concealcursor", "niv")

-- fold
opt("o", "foldenable", true)
opt("o", "foldmethod", "indent")
opt("o", "foldlevelstart", 99)
-------------------- COMMANDS ------------------------------
--  Install all packages
command(
    "PaqInstall",
    "lua require('plug_paq').install()"
)

-- Update all packages 
command(
    "PaqClean",
    "lua require('plug_paq').clean()"
)

-- Remove all packages
command(
    "PaqUpdate",
    "lua require('plug_paq').update()"
)

-- Get highlight group name and it's
-- foreground and background color
command("GetHi", "lua require('utils').GetHi()")
--[[
--- Only install missing plugins
command(
    "PlugInstall",
    "execute 'luafile ' . stdpath('config') . '/lua/plug_packer.lua' | packadd packer.nvim | lua require('plug_packer').install()"
)
--- Update and install plugins
command(
    "PlugUpdate",
    "execute 'luafile ' . stdpath('config') . '/lua/plug_packer.lua' | packadd packer.nvim | lua require('plug_packer').update()"
)
--- Remove any disabled or unused plugins
command(
    "PlugClean",
    "execute 'luafile ' . stdpath('config') . '/lua/plug_packer.lua' | packadd packer.nvim | lua require('plug_packer').clean()"
)
--- Recompiles lazy loaded plugins
command(
    "PlugCompile",
    "execute 'luafile ' . stdpath('config') . '/lua/plug_packer.lua' | packadd packer.nvim | lua require('plug_packer').compile()"
)
--- Performs `PlugClean` and then `PlugUpdate`
command(
    "PlugSync",
    "execute 'luafile ' . stdpath('config') . '/lua/plug_packer.lua' | packadd packer.nvim | lua require('plug_packer').sync()"
)
--]]

-- Plugins and stuff
require "autocmd"
require "typing"
require "mapping"
require "plugins"
