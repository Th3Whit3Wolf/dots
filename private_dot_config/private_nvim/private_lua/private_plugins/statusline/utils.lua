local vim = vim
local M = {}

function M.GalaxyHi(item, colorfg, colorbg)
    vim.api.nvim_command("hi Galaxy" .. item .. " guifg=" .. colorfg)
    vim.api.nvim_command("hi Galaxy" .. item .. " guibg=" .. colorbg)
end

function M.GalaxyFG(item, color)
    vim.api.nvim_command("hi Galaxy" .. item .. " guifg=" .. color)
end
function M.GalaxyBG(item, color)
    vim.api.nvim_command("hi Galaxy" .. item .. " guibg=" .. color)
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
