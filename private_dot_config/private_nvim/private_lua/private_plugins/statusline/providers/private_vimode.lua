local vim = vim
local i = require("plugins.statusline.icons")
local u = require("plugins.statusline.utils")

local M = {}

local num = {
    "❶",
    "❷",
    "❸",
    "❹",
    "❺",
    "❻",
    "❼",
    "❽",
    "❾",
    "❿",
    "⓫",
    "⓬",
    "⓭",
    "⓮",
    "⓯",
    "⓰",
    "⓱",
    "⓲",
    "⓳",
    "⓴"
}

function M.get_mode()
    local mode = {
        c = {i.mode.c, 'plum3'},
        ce = {i.mode.c, 'plum3'},
        cv = {i.mode.c, 'plum3'},
        i = {i.mode.i, 'chartreuse3'},
        ic = {i.mode.i, 'chartreuse3'},
        n = {i.mode.n, 'DarkGoldenrod2'},
        no = {i.mode.n, 'DarkGoldenrod2'},
        r = {i.mode.r, 'chocolate'},
        rm = {i.mode.r, 'chocolate'},
        R = {i.mode.r, 'purple'},
        Rv = {i.mode.r, 'purple'},
        s = {i.mode.s, 'SkyBlue2'},
        S = {i.mode.s, 'SkyBlue2'},
        t = {i.mode.t, 'gray'},
        V = {i.mode.v, 'gray'},
        v = {i.mode.v, 'gray'},
        ["r?"] = {i.mode.r, 'chocolate'},
        [""] = {"🅢 ", 'SkyBlue2'},
        [""] = {" ", 'gray'},
        ["!"] = {"! ", 'plum3'}
    }

    local n = (function()
        if num[vim.fn.bufnr("%")] ~= nil then
            return num[vim.fn.bufnr("%")]
        else
            return vim.fn.bufnr("%")
        end
    end)()

    local vimMode = mode[vim.fn.mode()]
    u.GalaxyBG("ViMode", vimMode[2])
    return vimMode[1] .. " | " .. n .. " "
end

function M.seperator()
    local mode_color = {
        n = 'DarkGoldenrod2',
        i = 'chartreuse3',
        v = 'gray',
        [""] = 'gray',
        V = 'gray',
        c = 'plum3',
        no = 'DarkGoldenrod2',
        s = 'SkyBlue2',
        S = 'SkyBlue2',
        [""] = 'SkyBlue2',
        ic = 'chartreuse3',
        R = 'purple',
        Rv = 'purple',
        cv = 'plum3',
        ce = 'plum3',
        r = 'chocolate',
        rm = 'chocolate',
        ["r?"] = 'chocolate',
        ["!"] = 'plum3',
        t = 'plum3'
    }

    u.GalaxyFG("ViModeSeperator", mode_color[vim.fn.mode()])
    return i.slant.Right
end
return M
