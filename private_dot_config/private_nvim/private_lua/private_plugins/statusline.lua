local gl = require("galaxyline")
local gls = gl.section
gl.short_line_list = {"LuaTree", "vista", "dbui"}

local colors = {
  bg = "#282c34",
  bg2 = "#212026",
  base = "#b2b2b2",
  comp = "#c56ec3",
  act1 = "#222226",
  DarkGoldenrod2 = "#eead0e", -- normal / unmodified
  chartreuse3 = "#66cd00", --insert
  SkyBlue2 = "#7ec0ee", -- modified
  chocolate = "#d2691e", -- replace
  gray = "#bebebe", -- visual
  plum3 = "#cd96cd", -- read-only / motion
  yellow = "#fabd2f",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#afd700",
  orange = "#FF8800",
  purple = "#5d4d7a",
  magenta = "#d16d9e",
  grey = "#c0c0c0",
  blue = "#0087d7",
  red = "#ec5f67",
  comments = "#2aa1ae",
  head1 = "#4f97d7"
}

--[[
spaceline flycheck
error   #FC5C94
warning #F3EA98
info    #8DE6F7
--]]
local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
    return true
  end
  return false
end

gls.left[1] = {
  ViMode = {
    provider = function()
      local mode = {
        c = {"🅒 ", colors.plum3},
        ce = {"🅒 ", colors.plum3},
        cv = {"🅒 ", colors.plum3},
        i = {"🅘 ", colors.chartreuse3},
        ic = {"🅘 ", colors.chartreuse3},
        n = {"🅝 ", colors.DarkGoldenrod2},
        no = {"🅝 ", colors.DarkGoldenrod2},
        r = {"🅡  ", colors.chocolate},
        rm = {"🅡  ", colors.chocolate},
        R = {"🅡  ", colors.purple},
        Rv = {"🅡  ", colors.purple},
        s = {"🅢 ", colors.SkyBlue2},
        S = {"🅢 ", colors.SkyBlue2},
        t = {"🅣  ", colors.gray},
        V = {"🅥 ", colors.gray},
        v = {"🅥 ", colors.gray},
        ["r?"] = {"🅡  ", colors.chocolate},
        [""] = {"🅢 ", colors.SkyBlue2},
        [""] = {" ", colors.gray},
        ["!"] = {"! ", colors.plum3}
      }

      local vimMode = mode[vim.fn.mode()]

      vim.api.nvim_command("hi GalaxyViMode guibg=" .. vimMode[2])
      return vimMode[1] .. "| " .. vim.fn.bufnr("%") .. " "
    end,
    highlight = {colors.act1, colors.DarkGoldenrod2}
  }
}
gls.left[2] = {
  FileIcon = {
    provider = function()
      local mode_color = {
        n = colors.DarkGoldenrod2,
        i = colors.chartreuse3,
        v = colors.gray,
        [""] = colors.gray,
        V = colors.gray,
        c = colors.plum3,
        no = colors.DarkGoldenrod2,
        s = colors.SkyBlue2,
        S = colors.SkyBlue2,
        [""] = colors.SkyBlue2,
        ic = colors.chartreuse3,
        R = colors.purple,
        Rv = colors.purple,
        cv = colors.plum3,
        ce = colors.plum3,
        r = colors.chocolate,
        rm = colors.chocolate,
        ["r?"] = colors.chocolate,
        ["!"] = colors.plum3,
        t = colors.plum3
      }
      if not buffer_not_empty() then
        vim.api.nvim_command("hi GalaxyFileIcon guifg=" .. colors.purple)
      else
        vim.api.nvim_command("hi GalaxyFileIcon guifg=" .. mode_color[vim.fn.mode()])
      end
      return ""
    end,
    condition = buffer_not_empty,
    highlight = {
      colors.comments,
      function()
        if not buffer_not_empty() then
          return colors.purple
        end
        return colors.bg2
      end
    }
  }
}
gls.left[3] = {
  FileName = {
    provider = {"FileName", "FileSize"},
    condition = buffer_not_empty,
    separator = "",
    separator_highlight = {colors.purple, colors.bg2},
    highlight = {colors.comp, colors.bg2, "bold"}
  }
}

gls.left[4] = {
  GitIcon = {
    provider = function()
      return "  "
    end,
    condition = buffer_not_empty,
    highlight = {colors.orange, colors.purple}
  }
}
gls.left[5] = {
  GitBranch = {
    provider = "GitBranch",
    condition = buffer_not_empty,
    highlight = {colors.base, colors.purple}
  }
}

local checkwidth = function()
  local squeeze_width = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

gls.left[6] = {
  DiffAdd = {
    provider = "DiffAdd",
    condition = checkwidth,
    icon = " ",
    highlight = {colors.green, colors.purple}
  }
}
gls.left[7] = {
  DiffModified = {
    provider = "DiffModified",
    condition = checkwidth,
    icon = " ",
    highlight = {colors.orange, colors.purple}
  }
}
gls.left[8] = {
  DiffRemove = {
    provider = "DiffRemove",
    condition = checkwidth,
    icon = " ",
    highlight = {colors.red, colors.purple}
  }
}
gls.left[9] = {
  LeftEnd = {
    provider = function()
      return ""
    end,
    separator = "",
    separator_highlight = {colors.purple, colors.bg},
    highlight = {colors.purple, colors.purple}
  }
}
gls.left[10] = {
  DiagnosticError = {
    provider = "DiagnosticError",
    icon = "  ",
    highlight = {colors.red, colors.bg}
  }
}
gls.left[11] = {
  Space = {
    provider = function()
      return " "
    end
  }
}
gls.left[12] = {
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    icon = "  ",
    highlight = {colors.blue, colors.bg}
  }
}
gls.right[1] = {
  FileFormat = {
    provider = "FileFormat",
    separator = "",
    separator_highlight = {colors.bg, colors.purple},
    highlight = {colors.base, colors.purple}
  }
}
gls.right[2] = {
  LineInfo = {
    provider = "LineColumn",
    separator = " | ",
    separator_highlight = {colors.bg2, colors.purple},
    highlight = {colors.base, colors.purple}
  }
}
gls.right[3] = {
  PerCent = {
    provider = "LinePercent",
    separator = "",
    separator_highlight = {colors.bg2, colors.purple},
    highlight = {colors.base, colors.bg2}
  }
}
gls.right[4] = {
  ScrollBar = {
    provider = "ScrollBar",
    highlight = {colors.yellow, colors.purple}
  }
}

gls.short_line_left[1] = {
  BufferType = {
    provider = "FileTypeName",
    separator = "",
    separator_highlight = {colors.purple, colors.bg},
    highlight = {colors.base, colors.purple}
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider = "BufferIcon",
    separator = "",
    separator_highlight = {colors.purple, colors.bg},
    highlight = {colors.base, colors.purple}
  }
}
