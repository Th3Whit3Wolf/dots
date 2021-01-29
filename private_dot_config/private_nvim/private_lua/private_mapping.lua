local vim, api, fn = vim, vim.api, vim.fn
local mappings = require('utils.map')
local npairs = require('nvim-autopairs')

local nnoremap, inoremap, vnoremap, xnoremap, cnoremap, nmap, imap, vmap = mappings.nnoremap, mappings.inoremap, mappings.vnoremap, mappings.xnoremap, mappings.cnoremap, mappings.nmap, mappings.imap, mappings.vmap

_G.MUtils = {}

MUtils.completion_confirm=function()
    if vim.fn.pumvisible() ~= 0  then
      if vim.fn.complete_info()["selected"] ~= -1 then
        vim.fn["compe#complete"]("<CR>")
        return npairs.esc("<c-y>")
      else
        vim.fn.nvim_select_popupmenu_item(0 , false , false ,{})
        vim.fn["compe#complete"]("<CR>")
        return npairs.esc("<c-n><c-y>")
      end
    else
      return npairs.check_break_line_char()
    end
end

MUtils.tab=function()
    if vim.fn.pumvisible() ~= 0  then
        return npairs.esc("<C-n>")
    else
        if vim.fn["vsnip#available"](1) ~= 0 then
            return fn.feedkeys(string.format('%c%c%c(vsnip-expand-or-jump)', 0x80, 253, 83))
        else
            return npairs.esc("<Tab>")
        end
    end
end

MUtils.s_tab=function()
    if vim.fn.pumvisible() ~= 0  then
        return npairs.esc("<C-p>")
    else
        if vim.fn["vsnip#jumpable"](-1) ~= 0 then
            return fn.feedkeys(string.format('%c%c%c(vsnip-jump-prev)', 0x80, 253, 83))
        else
            return npairs.esc("<C-h>")
        end
    end
end

local function cnoreabbrev(command)
    api.nvim_command("cnoreabbrev " .. command)
end

local function iabbrev(command)
    api.nvim_command("iabbrev " .. command)
end

-- Start an external command with a single bang
nnoremap('!', ':!')

-- Allow misspellings
cnoreabbrev "Qa qa"
cnoreabbrev "Q q"
cnoreabbrev "Qall qall"
cnoreabbrev "Q! q!"
cnoreabbrev "Qall! qall!"
cnoreabbrev "qQ q@"
cnoreabbrev "Bd bd"
cnoreabbrev "bD bd"
cnoreabbrev "qw wq"
cnoreabbrev "Wq wq"
cnoreabbrev "WQ wq"
cnoreabbrev "Wq wq"
cnoreabbrev "Wa wa"
cnoreabbrev "wQ wq"
cnoreabbrev "W w"
cnoreabbrev "W! w!"

-- Abbrev
iabbrev "btw by the way"
iabbrev "atm at the moment"
imap(";date", "%d %b %Y")

-- Folds
nnoremap("<CR>", "za")
nnoremap("<S-Return>", "zMzvzt")

-- Start new line from any cursor position
inoremap("<S-Return>", "<C-o>o")

-- Easier line-wise movement
nnoremap("gh", "g^")
nnoremap("gl", "g$")

-- Yank from cursor position to end-of-line
nnoremap('Y', 'y$')

-- Window control
nnoremap("<C-q>", "<C-w>")
nmap("<C-x>", ":BufferClose<CR>")
nnoremap("<C-w>z", ":vert resize<CR>:resize<CR>:normal! ze<CR>")

-- switch windw
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- smart move
nnoremap("j", "gj")
nnoremap("k", "gk")
vnoremap("j", "gj")
vnoremap("k", "gk")

-- Select blocks after indenting
xnoremap("<", "<gv")
xnoremap(">", ">gv|")

-- Use tab for indenting
nnoremap("<Tab>", ">>_")
nnoremap("<S-Tab>", "<<_")
vnoremap("<Tab>", ">gv")
vnoremap("<S-Tab>", "<gv")

-- Exit insert mode and save just by hitting CTRL-s
nnoremap("<C-s>", ":<C-u>write<CR>")
vnoremap("<C-s>", ":<C-u>write<CR>")
cnoremap("<C-s>", ":<C-u>write<CR>")
inoremap("<C-s>", "<Esc>:write<CR>")

-- I like to :quit with 'q', shrug.
nnoremap("q", "<C-u>:quit<CR>")
nnoremap("<C-q>", "<Esc>:wq<CR>")

-- Undo / Redo
nnoremap("<C-z>", "<C-u>:undo<CR>")
nnoremap("<A-z>", "<C-u>:redo<CR>")
inoremap("<C-z>", "<Esc>:undo<CR>")
inoremap("<A-z>", "<Esc>:redo<CR>")
vnoremap("<C-z>", "<C-u>:undo<CR>")
vnoremap("<A-z>", "<C-u>:redo<CR>")

-- :: Splits
nnoremap("<leader>sv", ":vsplit<CR>")
nnoremap("<leader>sh", ":split<CR>")
nnoremap("<leader>sq", ":close<CR>")

-- :: Toggle
nnoremap("<leader>ts", "<C-u>:setlocal spell!<CR>")
nnoremap("<leader>tn", "<C-u>:setlocal nonumber!<CR>")
nnoremap("<leader>tl", "<C-u>:setlocal nolist!<CR>")
-- tf toggles files
-- tv toggles vista

-- :: Session Management
nnoremap("<leader>ss", ":SessionSave<CR>")
nnoremap("<leader>sl", ":SessionLoad<CR>")

-- Switch Buffers ()
nmap("<Leader>bd", ":BufferOrderByDirectory<CR>")
nmap("<Leader>bl", ":BufferOrderByLanguage<CR>")
nmap("<Leader>bp", ":BufferPrevious<CR>")
nmap("<Leader>bn", ":BufferNext<CR>")
nmap("<Leader>1", ":BufferGoto 1<CR>")
nmap("<Leader>2", ":BufferGoto 2<CR>")
nmap("<Leader>3", ":BufferGoto 3<CR>")
nmap("<Leader>4", ":BufferGoto 4<CR>")
nmap("<Leader>5", ":BufferGoto 5<CR>")
nmap("<Leader>6", ":BufferGoto 6<CR>")
nmap("<Leader>7", ":BufferGoto 7<CR>")
nmap("<Leader>8", ":BufferGoto 8<CR>")
nmap("<Leader>9", ":BufferLast<CR>")

-- Autocompletion and snippets
imap("<CR>", "v:lua.MUtils.completion_confirm()", {expr = true , noremap = true})
imap("<Tab>", "v:lua.MUtils.tab()", {expr = true , noremap = true})
imap("<S-Tab>", "v:lua.MUtils.s_tab()", {expr = true , noremap = true})

--imap("<Tab>", [[pumvisible() ? "\<C-n>" : vsnip#available(1) ?"\<Plug>(vsnip-expand-or-jump)" : v:lua.check_back_space() ? "\<TAB>" : completion#trigger_completion()]])

-- Plugin vim-operator-surround
nmap("sa", "<Plug>(operator-surround-append)")
nmap("sd", "<Plug>(operator-surround-delete)")
nmap("sr", "<Plug>(operator-surround-replace)")

-- File Tree (nvim-tree.lua)
nnoremap("<leader>tf", "<C-u>:NvimTreeToggle<CR>")
--nnoremap("<leader>rf", "<C-u>:NvimTreeRefresh<CR>")
--nnoremap("<leader>sf", "<C-u>:NvimTreeFindFile<CR>")

-- Plugin Vista
nnoremap("<leader>tv", "<cmd>Vista!!<CR>")

-- Vim Easy Align
nmap("<leader>a", "<Plug>(EasyAlign)")
vmap("<leader>a", "<Plug>(EasyAlign)")

-- Plugin DadbodUI
nnoremap("<leader>td", ":DBUIToggle<CR>")

-- Telescope
nnoremap("<Leader>bs", "<C-u>:Telescope buffers<CR>")
nnoremap("<Leader>fg", "<C-u>:Telescope git_files<CR>")
nnoremap("<Leader>fs", "<C-u>:Telescope grep_string<CR>")
nnoremap("<Leader>fl", "<C-u>:Telescope loclist<CR>")
nnoremap("<Leader>fc", "<C-u>:Telescope git_commits<CR>")
nnoremap("<C-p>",      "<C-u>:Telescope fd<CR>")
nnoremap("<Leader>fw", "<C-u>:DashboardFindWord<CR>")
nnoremap("<Leader>fb", "<C-u>:DashboardJumpMark<CR>")
nnoremap("<Leader>ff", "<C-u>:DashboardFindFile<CR>")
nnoremap("<Leader>fh", "<C-u>:DashboardFindHistory<CR>")
