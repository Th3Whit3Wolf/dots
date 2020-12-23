-- bind options
function bind_option(options)
    for k, v in pairs(options) do
        if v == true or v == false then
            vim.api.nvim_command("set " .. k)
        else
            vim.api.nvim_command("set " .. k .. "=" .. v)
        end
    end
end

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

function rhs_options:map_cmd(cmd_string)
    self.cmd = cmd_string
    return self
end

function rhs_options:map_cr(cmd_string)
    self.cmd = (":%s<CR>"):format(cmd_string)
    return self
end

function rhs_options:map_args(cmd_string)
    self.cmd = (":%s<Space>"):format(cmd_string)
    return self
end

function rhs_options:map_cu(cmd_string)
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

function map_cr(cmd_string)
    local ro = rhs_options:new()
    return ro:map_cr(cmd_string)
end

function map_cmd(cmd_string)
    local ro = rhs_options:new()
    return ro:map_cmd(cmd_string)
end

function map_cu(cmd_string)
    local ro = rhs_options:new()
    return ro:map_cu(cmd_string)
end

function map_args(cmd_string)
    local ro = rhs_options:new()
    return ro:map_args(cmd_string)
end

function nvim_load_mapping(mapping)
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

local mapping = setmetatable({}, { __index = { vim = {},plugin = {} } })

function mapping:load_vim_define()
    self.vim = {
        ["i|<TAB>"] = map_cmd(
            [[pumvisible() ? "\<C-n>" : vsnip#available(1) ?"\<Plug>(vsnip-expand-or-jump)" : v:lua.check_back_space() ? "\<TAB>" : completion#trigger_completion()]]
        ):with_expr():with_silent(),
        ["i|<S-TAB>"] = map_cmd([[pumvisible() ? "\<C-p>" : "\<C-h>"]]):with_noremap():with_expr(),
        ["i|<CR>"] = map_cmd(
            [[pumvisible() ? complete_info()["selected"] != "-1" ?"\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>": "\<CR>"]]
        ):with_expr(),
    }
end

function mapping:load_plugin_define()
    self.plugin = {
        -- Plugin vim-operator-surround
        ["n|sa"] = map_cmd("<Plug>(operator-surround-append)"):with_silent(),
        ["n|sd"] = map_cmd("<Plug>(operator-surround-delete)"):with_silent(),
        ["n|sr"] = map_cmd("<Plug>(operator-surround-replace)"):with_silent(),

    }
end

local function load_mapping()
    mapping:load_vim_define()
    mapping:load_plugin_define()
    nvim_load_mapping(mapping.vim)
    nvim_load_mapping(mapping.plugin)
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
