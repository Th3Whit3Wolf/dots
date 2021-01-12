local vim = vim
local c = require("plugins.statusline.colors")

local M = {}

function M.GalaxyFG(item, col)
    vim.api.nvim_command("hi Galaxy" .. item .. " guifg=" .. c.color(col))
end
function M.GalaxyBG(item, col)
    vim.api.nvim_command("hi Galaxy" .. item .. " guibg=" .. c.color(col))
end
function M.GalaxyHi(item, colorfg, colorbg)
    vim.api.nvim_command(
        "hi Galaxy" .. item .. " guifg=" .. c.color(colorfg) .. " guibg=" .. c.color(colorbg)
    )
end

function M.GalaxyHiB(item, colorfg, colorbg)
    vim.api.nvim_command(
        "hi Galaxy" .. item .. " guifg=" .. c.color(colorfg) .. " guibg=" .. c.color(colorbg) .. " gui=bold"
    )
end

function M.space()
    return " "
end

function M.buffer_not_empty()
    if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
        return true
    end
    return false
end

function M.checkwidth()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

return M
