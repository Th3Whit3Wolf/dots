local vim = vim
local i = require("plugins.statusline.icons")
local c = require("plugins.statusline.colors")
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
        c = {i.mode.c, c.plum3},
        ce = {i.mode.c, c.plum3},
        cv = {i.mode.c, c.plum3},
        i = {i.mode.i, c.chartreuse3},
        ic = {i.mode.i, c.chartreuse3},
        n = {i.mode.n, c.DarkGoldenrod2},
        no = {i.mode.n, c.DarkGoldenrod2},
        r = {i.mode.r, c.chocolate},
        rm = {i.mode.r, c.chocolate},
        R = {i.mode.r, c.purple},
        Rv = {i.mode.r, c.purple},
        s = {i.mode.s, c.SkyBlue2},
        S = {i.mode.s, c.SkyBlue2},
        t = {i.mode.t, c.gray},
        V = {i.mode.v, c.gray},
        v = {i.mode.v, c.gray},
        ["r?"] = {i.mode.r, c.chocolate},
        [""] = {"🅢 ", c.SkyBlue2},
        [""] = {" ", c.gray},
        ["!"] = {"! ", c.plum3}
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
        n = c.DarkGoldenrod2,
        i = c.chartreuse3,
        v = c.gray,
        [""] = c.gray,
        V = c.gray,
        c = c.plum3,
        no = c.DarkGoldenrod2,
        s = c.SkyBlue2,
        S = c.SkyBlue2,
        [""] = c.SkyBlue2,
        ic = c.chartreuse3,
        R = c.purple,
        Rv = c.purple,
        cv = c.plum3,
        ce = c.plum3,
        r = c.chocolate,
        rm = c.chocolate,
        ["r?"] = c.chocolate,
        ["!"] = c.plum3,
        t = c.plum3
    }

    u.GalaxyFG("ViModeSeperator", mode_color[vim.fn.mode()])

    return i.slant.Right
end
return M
