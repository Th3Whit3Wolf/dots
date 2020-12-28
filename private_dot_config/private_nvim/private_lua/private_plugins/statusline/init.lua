local gl = require("galaxyline")
local gls = gl.section
gl.short_line_list = {"LuaTree", "vista", "dbui"}

local i = require("plugins.statusline.icons")
local c = require("plugins.statusline.colors")

local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
        return true
    end
    return false
end

function os.capture(cmd, raw)
    local f = assert(io.popen(cmd, "r"))
    local s = assert(f:read("*a"))
    f:close()
    if raw then
        return s
    end
    s = string.gsub(s, "^%s+", "")
    s = string.gsub(s, "%s+$", "")
    s = string.gsub(s, "[\n\r]+", " ")
    return s
end

local pybang = function()
    local b = vim.fn.getline(1)
    if b:sub(-7) == "python3" then
        return "Python3"
    elseif b:sub(-7) == "python2" then
        return "Python2"
    else
        return os.capture("python --version")
    end
end

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

gls.left[1] = {
    ViMode = {
        provider = function()
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
            vim.api.nvim_command("hi GalaxyViMode guibg=" .. vimMode[2])
            return vimMode[1] .. " | " .. n .. " "
        end,
        highlight = {c.act1, c.DarkGoldenrod2}
    }
}
gls.left[2] = {
    FileIcon = {
        provider = function()
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
            if not buffer_not_empty() then
                vim.api.nvim_command("hi GalaxyFileIcon guifg=" .. c.purple)
            else
                vim.api.nvim_command("hi GalaxyFileIcon guifg=" .. mode_color[vim.fn.mode()])
            end
            return i.slant.Right
        end,
        condition = buffer_not_empty,
        highlight = {
            c.comments,
            function()
                if not buffer_not_empty() then
                    return c.purple
                end
                return c.bg2
            end
        }
    }
}

gls.left[3] = {
    FileSize = {
        provider = function()
            local file = vim.fn.expand("%:p")
            if string.len(file) == 0 then
                return ""
            end
            local size = vim.fn.getfsize(file)
            if size == 0 or size == -1 or size == -2 then
                return ""
            end
            if size < 1024 then
                size = size .. "b"
            elseif size < 1024 * 1024 then
                size = string.format("%.1f", size / 1024) .. "k"
            elseif size < 1024 * 1024 * 1024 then
                size = string.format("%.1f", size / 1024 / 1024) .. "m"
            else
                size = string.format("%.1f", size / 1024 / 1024 / 1024) .. "g"
            end
            return "  - " .. size .. " "
        end,
        condition = buffer_not_empty,
        highlight = {c.white, c.bg2}
    }
}

gls.left[4] = {
    FileName = {
        provider = "FileName",
        condition = buffer_not_empty,
        separator = i.slant.Left,
        separator_highlight = {c.purple, c.bg2},
        highlight = {c.comp, c.bg2, "bold"}
    }
}

gls.left[5] = {
    GitIcon = {
        provider = function()
            local ft = vim.bo.filetype
            if ft == "python" then
                return pybang()
            else
                return (ft:gsub("^%l", string.upper))
            end
        end,
        condition = buffer_not_empty,
        highlight = {c.white, c.purple}
    }
}

--[[
gls.left[5] = {
    GitIcon = {
        provider = function()
            return i.git
        end,
        condition = buffer_not_empty,
        highlight = {c.orange, c.purple}
    }
}
--]]
gls.left[6] = {
    GitBranch = {
        provider = "GitBranch",
        condition = buffer_not_empty,
        highlight = {c.base, c.purple}
    }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

gls.left[7] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = i.diff.Add,
        highlight = {c.green, c.purple}
    }
}
gls.left[8] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = i.diff.Modified,
        highlight = {c.orange, c.purple}
    }
}
gls.left[9] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = i.diff.Remove,
        highlight = {c.red, c.purple}
    }
}
gls.left[10] = {
    LeftEnd = {
        provider = function()
            return i.slant.Right
        end,
        separator = i.slant.Right,
        separator_highlight = {c.purple, c.bg},
        highlight = {c.purple, c.purple}
    }
}
gls.left[11] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = i.diagnostic.error,
        highlight = {c.red, c.bg}
    }
}
gls.left[12] = {
    Space = {
        provider = function()
            return " "
        end
    }
}
gls.left[13] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = i.diagnostic.warn,
        highlight = {c.blue, c.bg}
    }
}
gls.right[1] = {
    FileFormat = {
        provider = "FileFormat",
        separator = i.slant.Right,
        separator_highlight = {c.bg, c.purple},
        highlight = {c.base, c.purple}
    }
}
gls.right[2] = {
    LineInfo = {
        provider = "LineColumn",
        separator = " | ",
        separator_highlight = {c.bg2, c.purple},
        highlight = {c.base, c.purple}
    }
}
gls.right[3] = {
    PerCent = {
        provider = "LinePercent",
        separator = i.slant.Left,
        separator_highlight = {c.bg2, c.purple},
        highlight = {c.base, c.bg2}
    }
}
gls.right[4] = {
    ScrollBar = {
        provider = "ScrollBar",
        highlight = {c.yellow, c.purple}
    }
}

gls.short_line_left[1] = {
    BufferType = {
        provider = "FileTypeName",
        separator = i.slant.Right,
        separator_highlight = {c.purple, c.bg},
        highlight = {c.base, c.purple}
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = "BufferIcon",
        separator = i.slant.Left,
        separator_highlight = {c.purple, c.bg},
        highlight = {c.base, c.purple}
    }
}
