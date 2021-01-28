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

-- this is my mapping with completion-nvim
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

-- skip it, if you use another global object
_G.MUtils= {}

vim.g.completion_confirm_key = ""

MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      require'completion'.confirmCompletion()
      return npairs.esc("<c-y>")
    else
      vim.fn.nvim_select_popupmenu_item(0 , false , false ,{})
      require'completion'.confirmCompletion()
      return npairs.esc("<c-n><c-y>")
    end
  else
    return npairs.check_break_line_char()
  end
end

function mapping:load_plugin_define()
    self.plugin = {
        -- Autocompletion and snippets
        ["i|<TAB>"] = Map_cmd(
            [[pumvisible() ? "\<C-n>" : vsnip#available(1) ?"\<Plug>(vsnip-expand-or-jump)" : v:lua.check_back_space() ? "\<TAB>" : completion#trigger_completion()]]
        ):with_expr():with_silent(),
        ["i|<S-TAB>"]         = Map_cmd([[pumvisible() ? "\<C-p>" : "\<C-h>"]]):with_noremap():with_expr(),
        ["i|<CR>"]            = Map_cmd("v:lua.MUtils.completion_confirm()"):with_noremap():with_expr(),
        -- Barbar
        ["n|<Leader>bd"]       = Map_cr("BufferOrderByDirectory"):with_noremap():with_expr(),
        ["n|<Leader>bl"]       = Map_cr("BufferOrderByLanguage"):with_noremap():with_expr(),
        ["n|<A-,>"]            = Map_cr("BufferPrevious"):with_noremap():with_expr(),
        ["n|<A-.>"]            = Map_cr("BufferNext"):with_noremap():with_expr(),
        ["n|<A-1>"]            = Map_cr("BufferGoto 1"):with_noremap():with_expr(),
        ["n|<A-2>"]            = Map_cr("BufferGoto 2"):with_noremap():with_expr(),
        ["n|<A-3>"]            = Map_cr("BufferGoto 3"):with_noremap():with_expr(),
        ["n|<A-4>"]            = Map_cr("BufferGoto 4"):with_noremap():with_expr(),
        ["n|<A-5>"]            = Map_cr("BufferGoto 5"):with_noremap():with_expr(),
        ["n|<A-6>"]            = Map_cr("BufferGoto 6"):with_noremap():with_expr(),
        ["n|<A-7>"]            = Map_cr("BufferGoto 7"):with_noremap():with_expr(),
        ["n|<A-8>"]            = Map_cr("BufferGoto 8"):with_noremap():with_expr(),
        ["n|<A-9>"]            = Map_cr("BufferLast"):with_noremap():with_expr(),
        ["n|<C-x>"]            = Map_cr("BufferClose"):with_noremap():with_expr(),

        -- Plugin vim-operator-surround
        ["n|sa"]             = Map_cmd("<Plug>(operator-surround-append)"):with_silent(),
        ["n|sd"]             = Map_cmd("<Plug>(operator-surround-delete)"):with_silent(),
        ["n|sr"]             = Map_cmd("<Plug>(operator-surround-replace)"):with_silent(),
        -- kyazdani42/nvim-tree.lua
        ["n|<leader>tf"]     = Map_cr("NvimTreeToggle"):with_noremap():with_silent(),
        ["n|<leader>rf"]     = Map_cr("NvimTreeRefresh"):with_noremap():with_silent(),
        ["n|<leader>ff"]     = Map_cr("NvimTreeFindFile"):with_noremap():with_silent(),
        -- Plugin Vista
        ["n|<space>tv"] = Map_cmd("<cmd>Vista!!<CR>"):with_noremap():with_silent(),
        -- Vim Easy Align
        ["n|<leader>a"] = Map_cmd("<Plug>(EasyAlign)"):with_silent(),
        ["v|<leader>a"] = Map_cmd("<Plug>(EasyAlign)"):with_silent(),
        -- Plugin DadbodUI
        ["n|<Leader>od"] = Map_cr("DBUIToggle"):with_noremap():with_silent(),
        -- Telescope
        ["n|<Leader>bb"] = Map_cu("Telescope buffers"):with_noremap():with_silent(),
        ["n|<Leader>fa"] = Map_cu("DashboardFindWord"):with_noremap():with_silent(),
        ["n|<Leader>fb"] = Map_cu("DashboardJumpMark"):with_noremap():with_silent(),
        ["n|<Leader>ff"] = Map_cu("DashboardFindFile"):with_noremap():with_silent(),
        ["n|<Leader>fg"] = Map_cu("Telescope git_files"):with_noremap():with_silent(),
        ["n|<Leader>fw"] = Map_cu("Telescope grep_string"):with_noremap():with_silent(),
        ["n|<Leader>fh"] = Map_cu("DashboardFindHistory"):with_noremap():with_silent(),
        ["n|<Leader>fl"] = Map_cu("Telescope loclist"):with_noremap():with_silent(),
        ["n|<Leader>fc"] = Map_cu("Telescope git_commits"):with_noremap():with_silent(),
        ["n|<C-p>"] = Map_cu("Telescope fd"):with_noremap():with_silent()
    }
end

local function load_mapping()
    require('nvim-autopairs').setup()
    mapping:load_vim_define()
    mapping:load_plugin_define()
    Load_mapping(mapping.vim)
    Load_mapping(mapping.plugin)
end

load_mapping()
