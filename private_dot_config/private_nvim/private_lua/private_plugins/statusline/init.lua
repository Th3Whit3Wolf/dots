local gl = require("galaxyline")
local gls = gl.section
gl.short_line_list = {"LuaTree", "vista", "dbui"}
local i = require("plugins.statusline.icons")
local c = require("plugins.statusline.colors")
local u = require("plugins.statusline.utils")
local diagnostic = require("plugins.statusline.providers.diagnostic")
local vcs = require("plugins.statusline.providers.vcs")
local fileinfo = require("plugins.statusline.providers.fileinfo")
local extension = require("plugins.statusline.providers.extension")
local buffer = require("plugins.statusline.providers.buffer")
local vimode = require("plugins.statusline.providers.vimode")

BufferIcon = buffer.get_buffer_type_icon
BufferNumber = buffer.get_buffer_number
DiagnosticError = diagnostic.get_diagnostic_error
DiagnosticWarn = diagnostic.get_diagnostic_warn
DiagnosticInfo = diagnostic.get_diagnostic_info
DiagnosticEndSpace = diagnostic.end_space
DiagnosticSeperator = diagnostic.seperator
DiffAdd = vcs.diff_add
DiffModified = vcs.diff_modified
DiffRemove = vcs.diff_remove
FileFormat = fileinfo.get_file_format
FileEncode = fileinfo.get_file_encode
FileSize = fileinfo.get_file_size
FileIcon = fileinfo.get_file_icon
FileName = fileinfo.get_current_file_name
FileType = fileinfo.get_file_type
FileTypeName = buffer.get_buffer_filetype
FiletTypeSeperator = fileinfo.filetype_seperator
GitBranch = vcs.get_git_branch_formatted
GitSeperator = vcs.seperator
LineColumn = fileinfo.line_column
LinePercent = fileinfo.current_line_percent
ScrollBar = extension.scrollbar_instance
Space = u.space
ViMode = vimode.get_mode
ViModeSeperator = vimode.seperator

gls.left[1] = {
    ViMode = {
        provider = ViMode,
        highlight = {c.color('act1'), c.color('DarkGoldenrod2')}
    }
}

gls.left[2] = {
    ViModeSeperator = {
        provider = ViModeSeperator,
        highlight = {
            c.color('comments'),
            function()
                if not u.buffer_not_empty() or vim.bo.filetype == 'dashboard' then
                    return c.color('purple')
                end
                return c.color('bg2')
            end
        }
    }
}

gls.left[3] = {
    FileSize = {
        provider = FileSize,
        condition = u.buffer_not_empty,
        highlight = {c.color('white'), c.color('bg2')}
    }
}

gls.left[4] = {
    FileName = {
        provider = FileName,
        condition = u.buffer_not_empty,
        separator = i.slant.Left,
        separator_highlight = {c.color('purple'), c.color('bg2')},
        highlight = {c.color('comp'), c.color('bg2'), "bold"}
    }
}

gls.left[5] = {
    FileType = {
        provider = FileType,
        condition = u.buffer_not_empty,
        highlight = {c.color('white'), c.color('purple')}
    }
}

gls.left[6] = {
    FiletTypeSeperator = {
        provider = FiletTypeSeperator
    }
}

gls.left[8] = {
    DiagnosticError = {
        provider = DiagnosticError,
        icon = " " .. i.bullet,
        highlight = {c.color('error'), c.color('bg2')}
    }
}

gls.left[9] = {
    DiagnosticWarn = {
        provider = DiagnosticWarn,
        icon = " " .. i.bullet,
        highlight = {c.color('warning'), c.color('bg2')}
    }
}

gls.left[10] = {
    DiagnosticInfo = {
        provider = DiagnosticInfo,
        icon = " " .. i.bullet,
        highlight = {c.color('info'), c.color('bg2')}
    }
}

gls.left[11] = {
    DiagnosticEndSpace = {
        provider = DiagnosticEndSpace,
        highlight = {c.color('bg2'), c.color('bg2')}
    }
}

gls.left[12] = {
    DiagnosticSeperator = {
        provider = DiagnosticSeperator,
        highlight = {c.color('purple'), c.color('bg2')}
    }
}

gls.left[13] = {
    GitBranch = {
        provider = GitBranch,
        icon = " " .. i.git .. " ",
        condition = u.buffer_not_empty,
        highlight = {c.color('base'), c.color('purple')}
    }
}

gls.left[14] = {
    DiffAdd = {
        provider = DiffAdd,
        condition = u.checkwidth,
        icon = i.diff.Add,
        highlight = {c.color('green'), c.color('purple')}
    }
}
gls.left[15] = {
    DiffModified = {
        provider = DiffModified,
        condition = u.checkwidth,
        icon = i.diff.Modified,
        highlight = {c.color('orange'), c.color('purple')}
    }
}
gls.left[16] = {
    DiffRemove = {
        provider = DiffRemove,
        condition = u.checkwidth,
        icon = i.diff.Remove,
        highlight = {c.color('red'), c.color('purple')}
    }
}

gls.left[17] = {
    GitSeperator = {
        provider = GitSeperator,
        condition = u.buffer_not_empty,
        highlight = {c.color('purple'), c.color('bg2')}
    }
}

gls.left[18] = {
    Space = {
        provider = Space,
        highlight = {c.color('blue'), c.color('purple')}
    }
}

gls.right[1] = {
    FileFormat = {
        provider = FileFormat,
        highlight = {c.color('base'), c.color('purple')}
    }
}
gls.right[2] = {
    LineInfo = {
        provider = LineColumn,
        separator = " | ",
        separator_highlight = {c.color('base'), c.color('purple')},
        highlight = {c.color('base'), c.color('purple')}
    }
}
gls.right[3] = {
    PerCent = {
        provider = LinePercent,
        separator = i.slant.Left,
        separator_highlight = {c.color('bg2'), c.color('purple')},
        highlight = {c.color('base'), c.color('bg2')}
    }
}
gls.right[4] = {
    ScrollBar = {
        provider = ScrollBar,
        highlight = {c.color('yellow'), c.color('purple')}
    }
}

gls.short_line_left[1] = {
    BufferType = {
        provider = FileTypeName,
        separator = i.slant.Right,
        separator_highlight = {c.color('purple'), c.color('bg')},
        highlight = {c.color('base'), c.color('purple')}
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = BufferIcon,
        separator = i.slant.Left,
        separator_highlight = {c.color('purple'), c.color('bg')},
        highlight = {c.color('base'), c.color('purple')}
    }
}
