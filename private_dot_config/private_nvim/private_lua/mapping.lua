local rhs_options = {}

function rhs_options:new()
    local instance = {
        cmd = "",
        options = {
            noremap = false,
            silent = false,
            expr = false
        }
    }
    setmetatable(instance, self)
    self.__index = self
    return instance
end

function rhs_options:Map_cmd(cmd_string)
    self.cmd = cmd_string
    return self
end

function rhs_options:Map_cr(cmd_string)
    self.cmd = (":%s<CR>"):format(cmd_string)
    return self
end

function rhs_options:Map_args(cmd_string)
    self.cmd = (":%s<Space>"):format(cmd_string)
    return self
end

function rhs_options:Map_cu(cmd_string)
    self.cmd = (":<C-u>%s<CR>"):format(cmd_string)
    return self
end

function rhs_options:with_silent()
    self.options.silent = true
    return self
end

function rhs_options:with_noremap()
    self.options.noremap = true
    return self
end

function rhs_options:with_expr()
    self.options.expr = true
    return self
end

function Map_cr(cmd_string)
    local ro = rhs_options:new()
    return ro:Map_cr(cmd_string)
end

function Map_cmd(cmd_string)
    local ro = rhs_options:new()
    return ro:Map_cmd(cmd_string)
end

function Map_cu(cmd_string)
    local ro = rhs_options:new()
    return ro:Map_cu(cmd_string)
end

function Map_args(cmd_string)
    local ro = rhs_options:new()
    return ro:Map_args(cmd_string)
end

function Load_mapping(mapping)
    for key, value in pairs(mapping) do
        local mode, keymap = key:match("([^|]*)|?(.*)")
        if type(value) == "table" then
            local rhs = value.cmd
            local options = value.options
            vim.fn.nvim_set_keymap(mode, keymap, rhs, options)
        end
    end
end

function _G.check_back_space()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

local mapping = setmetatable({}, {__index = {vim = {}, plugin = {}}})

function mapping:load_vim_define()
    self.vim = {
        -- Vim map
        ["n|<C-x>"] = Map_cr("bd!"):with_noremap(),
        ["n|<C-s>"] = Map_cu("write"):with_noremap(),
        ["n|<C-z>"] = Map_cu("undo"):with_noremap(),
        ["n|<M-z>"] = Map_cu("redo"):with_noremap(),
        ["n|Y"] = Map_cmd("y$"),
        ["n|q"] = Map_cu("quit"),
        ["n|Q"] = Map_cmd("q"):with_noremap(),
        ["n|qQ"] = Map_cmd("@q"):with_noremap(),
        ["n|<Tab>"] = Map_cmd(">>_"):with_noremap(),
        ["n|<S-Tab>"] = Map_cmd("<<_"):with_noremap(),
        ["n|<C-h>"] = Map_cmd("<C-w>h"):with_noremap(),
        ["n|<C-l>"] = Map_cmd("<C-w>l"):with_noremap(),
        ["n|<C-j>"] = Map_cmd("<C-w>j"):with_noremap(),
        ["n|<C-k>"] = Map_cmd("<C-w>k"):with_noremap(),
        ["n|j"] = Map_cmd("gk"):with_noremap(),
        ["n|k"] = Map_cmd("gk"):with_noremap(),
        ["n|g"] = Map_cmd("g^"):with_noremap(),
        ["n|h"] = Map_cmd("g$"):with_noremap(),
        -- :: Start an external command with a single bang
        ["n|!"] = Map_cmd(":!"):with_noremap(),
        ["n|<CR>"] = Map_cmd("za"):with_noremap(),
        ["n|<S-Return>"] = Map_cmd("zMzvzt"):with_noremap(),
        -- Insert
        ["i|<C-s>"] = Map_cmd("<Esc>:w<CR>"),
        ["i|<C-z>"] = Map_cu("<Esc>:undo<CR>"):with_noremap(),
        ["i|<M-z>"] = Map_cu("<Esc>:redo<CR>"):with_noremap(),
        ["i|<C-q>"] = Map_cmd("<Esc>:wq<CR>"),
        -- Visual
        ["v|j"] = Map_cmd("gk"):with_noremap(),
        ["v|k"] = Map_cmd("gk"):with_noremap(),
        ["v|<Tab>"] = Map_cmd(">gv"):with_noremap(),
        ["v|<S-Tab>"] = Map_cmd("<gv"):with_noremap(),
        ["v|<C-s>"] = Map_cu("write"):with_noremap(),
        ["v|<C-z>"] = Map_cu("undo"):with_noremap(),
        ["v|<M-z>"] = Map_cu("redo"):with_noremap(),
        -- Leader
        -- :: Splits
        ["n|<leader>sv"] = Map_cr("vsplit"):with_noremap(),
        ["n|<leader>sh"] = Map_cr("split"):with_noremap(),
        ["n|<leader>sq"] = Map_cr("close"):with_noremap(),
        -- :: Toggle
        ["n|<leader>ts"] = Map_cr("setlocal spell!"):with_noremap(),
        ["n|<leader>tn"] = Map_cr("setlocal nonumber!"):with_noremap(),
        ["n|<leader>tl"] = Map_cr("setlocal nolist!"):with_noremap(),
        -- tf toggles files
        -- tv toggles vista
        -- :: Session Management
        ["n|<Leader>ss"] = Map_cu("SessionSave"):with_noremap(),
        ["n|<Leader>sl"] = Map_cu("SessionLoad"):with_noremap()
    }
end

function mapping:load_plugin_define()
    self.plugin = {
        -- Autocompletion and snippets
        ["i|<TAB>"]      = Map_cmd([[pumvisible() ? "\<C-n>" : vsnip#available(1) ?"\<Plug>(vsnip-expand-or-jump)" : v:lua.check_back_space() ? "\<TAB>" : completion#trigger_completion()<Plug>DiscretionaryEnd]]):with_expr():with_silent(),
        ["i|<S-TAB>"]    = Map_cmd([[pumvisible() ? "\<C-p>" : "\<C-h>"]]):with_noremap():with_expr(),
        ["i|<CR>"]       = Map_cmd([[pumvisible() ? complete_info()["selected"] != "-1" ?"\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>":(delimitMate#WithinEmptyPair() ? "\<Plug>delimitMateCR" : "\<CR>")]]):with_expr(),
        -- Plugin vim-operator-surround
        ["n|sa"] = Map_cmd("<Plug>(operator-surround-append)"):with_silent(),
        ["n|sd"] = Map_cmd("<Plug>(operator-surround-delete)"):with_silent(),
        ["n|sr"] = Map_cmd("<Plug>(operator-surround-replace)"):with_silent(),
        -- kyazdani42/nvim-tree.lua
        ["n|<space>tf"] = Map_cr("NvimTreeToggle"):with_noremap():with_silent(),
        ["n|<space>rf"] = Map_cr("NvimTreeRefresh"):with_noremap():with_silent(),
        ["n|<space>ff"] = Map_cr("NvimTreeFindFile"):with_noremap():with_silent(),
        -- Plugin Vista
        ["n|<space>tv"] = Map_cmd('<cmd>Vista!!<CR>'):with_noremap():with_silent(),
        -- Vim Easy Align
        ["n|<space>a"] = Map_cmd("<Plug>(EasyAlign)"):with_silent(),
        ["v|<space>a"] = Map_cmd("<Plug>(EasyAlign)"):with_silent(),
    }
end

local function load_mapping()
    mapping:load_vim_define()
    mapping:load_plugin_define()
    Load_mapping(mapping.vim)
    Load_mapping(mapping.plugin)
end

load_mapping()

vim.g.completion_confirm_key = ""

-- <Tab> to navigate the completion menu
--map("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
--map("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
--map(
--    "i",
--    "<Nop>",
--    [[pumvisible() ? complete_info()["selected"] != "-1" ? "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<CR>"]],
--    {expr = true, silent = true, noremap = false}
--)
-- Expand
--map("i", "<CR>", [[vsnip#jumpable() ? "\<Plug>(vsnip-jump-next)" : "\<CR>"]], {expr = true})
--map("i", "<Tab>", [[pumvisible() ? "\<C-n>" : vsnip#available(1) ?"\<Plug>(vsnip-expand-or-jump)" : v:lua.check_back_space() ? "\<TAB>" : completion#trigger_completion()]], {expr = true, silent = true })
--map("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<C-h>"]], {expr = true })
--map("i", "<CR>", [[pumvisible() ? complete_info()["selected"] != "-1" ?"\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>":(delimitMate#WithinEmptyPair() ? "\<Plug>delimitMateCR" : "\<CR>")]], {expr = true})

--map("", "<leader>c", '"+y') -- Copy to clipboard in normal, visual, select and operator modes
--map("i", "<C-u>", "<C-g>u<C-u>") -- Make <C-u> undoable
--map("i", "<C-w>", "<C-g>u<C-w>") -- Make <C-w> undoable
--map("n", "<C-l>", "<cmd>noh<CR>") -- Clear highlights
--map("n", "<leader>o", "m`o<Esc>``") -- Insert a newline in normal mode
