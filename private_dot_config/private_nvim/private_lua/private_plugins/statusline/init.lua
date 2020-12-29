local gl = require("galaxyline")
local gls = gl.section
gl.short_line_list = {"LuaTree", "vista", "dbui"}
local diagnostic = require("plugins.statusline.providers.diagnostic")
local vcs = require("plugins.statusline.providers.vcs")

local i = require("plugins.statusline.icons")
local c = require("plugins.statusline.colors")

local fg, bg = "fg", "bg"
DiagnosticError = diagnostic.get_diagnostic_error
DiagnosticWarn = diagnostic.get_diagnostic_warn
DiagnosticInfo = diagnostic.get_diagnostic_info
GitBranch = vcs.get_git_branch
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
        return "Python 3"
    elseif b:sub(-7) == "python2" then
        return "Python 2"
    else
        return os.capture("python --version")
    end
end

local shellbang = function()
    local b = (function()
        if vim.fn.getline(1):sub(-2) == "sh" then
            return os.capture("readlink /usr/bin/sh")
        else
            return vim.fn.getline(1)
        end
    end)()
    if b:sub(-4) == "bash" then
        return "Bourne Again SHell"
    elseif b:sub(-4) == "dash" then
        return "Debian Almquist SHell"
    elseif b:sub(-3) == "csh" or b:sub(-4) == "tcsh" then
        return "C SHell"
    elseif b:sub(-3) == "ksh" or b:sub(-4) == "mksh" or b:sub(-5) == "pdksh" then
        return "Korn SHell"
    elseif b:sub(-3) == "zsh" then
        return "Z SHell"
    elseif b:sub(-3) == "ash" then
        return "Almquist SHell"
    else
        return "Shell"
    end
end

function GalaxyHi(item, g, color)
    vim.api.nvim_command("hi Galaxy" .. item .. " gui" .. g .. "=" .. color)
end

local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
        return true
    end
    return false
end

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

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
            GalaxyHi("ViMode", "bg", vimMode[2])
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

            GalaxyHi("FileIcon", fg, mode_color[vim.fn.mode()])

            return i.slant.Right
        end,
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
    FileType = {
        provider = function()
            local ft = vim.bo.filetype
            local filetype = (function()
                if ft == "python" then
                    return pybang()
                elseif ft == "sh" then
                    return shellbang()
                else
                    return (ft:gsub("^%l", string.upper))
                end
            end)()
            return " " .. filetype .. " "
        end,
        condition = buffer_not_empty,
        highlight = {c.white, c.purple}
    }
}

gls.left[6] = {
    FiletTypeSeperatorRight = {
        provider = function()
            if not diagnostic.has_diagnostics() and not vcs.check_git_workspace() then
                return ""
            else
                return i.slant.Right
            end
        end,
        condition = buffer_not_empty,
        highlight = {c.purple, c.bg2}
    }
}

gls.left[8] = {
    DiagnosticError = {
        provider = DiagnosticError,
        icon = " " .. i.diagnostic.error,
        highlight = {c.error, c.bg2}
    }
}

gls.left[9] = {
    DiagnosticWarn = {
        provider = DiagnosticWarn,
        icon = " " .. i.diagnostic.warn,
        highlight = {c.warning, c.bg2}
    }
}

gls.left[10] = {
    DiagnosticInfo = {
        provider = DiagnosticInfo,
        icon = " " .. i.diagnostic.info,
        highlight = {c.info, c.bg2}
    }
}

gls.left[11] = {
    DiagnosticEndSpace = {
        provider = function()
            if not diagnostic.has_diagnostics() then
                return ""
            else
                return " "
            end
        end,
        highlight = {c.bg2, c.bg2}
    }
}

gls.left[12] = {
    DiagnosticSeperatorRight = {
        provider = function()
            if not diagnostic.has_diagnostics() then
                return ""
            else
                return i.slant.Left
            end
        end,
        highlight = {c.purple, c.bg2}
    }
}

gls.left[13] = {
    GitBranch = {
        provider = function()
            if diagnostic.has_diagnostics() then
                GalaxyHi("GitBranch", bg, c.purple)
            else
                GalaxyHi("GitBranch", bg, c.bg2)
            end
            return vcs.get_git_branch()
        end,
        icon = " " .. i.git .. " ",
        condition = buffer_not_empty,
        highlight = {c.base, c.purple}
    }
}

gls.left[14] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = i.diff.Add,
        highlight = {c.green, c.purple}
    }
}
gls.left[15] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = i.diff.Modified,
        highlight = {c.orange, c.purple}
    }
}
gls.left[16] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = i.diff.Remove,
        highlight = {c.red, c.purple}
    }
}

gls.left[17] = {
    GiteSeperatorRight = {
        provider = function()
            if not diagnostic.has_diagnostics() then
                return i.slant.Left
            else
                return ""
            end
        end,
        condition = buffer_not_empty,
        highlight = {c.purple, c.bg2}
    }
}

gls.left[18] = {
    Space = {
        provider = function()
            return " "
        end,
        highlight = {c.blue, c.purple}
    }
}

gls.right[1] = {
    FileFormat = {
        provider = "FileFormat",
        highlight = {c.base, c.purple}
    }
}
gls.right[2] = {
    LineInfo = {
        provider = "LineColumn",
        separator = " | ",
        separator_highlight = {c.base, c.purple},
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
