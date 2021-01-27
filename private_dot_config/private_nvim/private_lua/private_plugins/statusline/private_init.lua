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

bufferIcon = buffer.get_buffer_type_icon
bufferNumber = buffer.get_buffer_number
diagnosticError = diagnostic.get_diagnostic_error
diagnosticWarn = diagnostic.get_diagnostic_warn
diagnosticInfo = diagnostic.get_diagnostic_info
diagnosticEndSpace = diagnostic.end_space
diagnosticSeperator = diagnostic.seperator
diffAdd = vcs.diff_add
diffModified = vcs.diff_modified
diffRemove = vcs.diff_remove
fileFormat = fileinfo.get_file_format
fileEncode = fileinfo.get_file_encode
fileSize = fileinfo.get_file_size
fileIcon = fileinfo.get_file_icon
fileName = fileinfo.get_current_file_name
fileType = fileinfo.get_file_type
fileTypeName = buffer.get_buffer_filetype
filetTypeSeperator = fileinfo.filetype_seperator
gitBranch = vcs.get_git_branch_formatted
gitSeperator = vcs.seperator
lineColumn = fileinfo.line_column
linePercent = fileinfo.current_line_percent
scrollBar = extension.scrollbar_instance
space = u.space
viMode = vimode.get_mode
viModeSeperator = vimode.seperator

gls.left[1] = {
    ViMode = {
        provider = viMode,
        highlight = {c.color('act1'), c.color('DarkGoldenrod2')}
    }
}

gls.left[2] = {
    ViModeSeperator = {
        provider = viModeSeperator,
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
        provider = fileSize,
        condition = u.buffer_not_empty,
        highlight = {c.color('white'), c.color('bg2')}
    }
}

gls.left[4] = {
    FileName = {
        provider = fileName,
        condition = u.buffer_not_empty,
        separator = i.slant.Left,
        separator_highlight = {c.color('purple'), c.color('bg2')},
        highlight = {c.color('comp'), c.color('bg2'), "bold"}
    }
}

gls.left[5] = {
    FileType = {
        provider = fileType,
        condition = u.buffer_not_empty,
        highlight = {c.color('white'), c.color('purple')}
    }
}

gls.left[6] = {
    FiletTypeSeperator = {
        provider = filetTypeSeperator
    }
}

gls.left[7] = {
    DiagnosticError = {
        provider = diagnosticError,
        icon = " " .. i.bullet,
        highlight = {c.color('error'), c.color('bg2')}
    }
}

gls.left[8] = {
    DiagnosticWarn = {
        provider = diagnosticWarn,
        icon = " " .. i.bullet,
        highlight = {c.color('warning'), c.color('bg2')}
    }
}

gls.left[9] = {
    DiagnosticInfo = {
        provider = diagnosticInfo,
        icon = " " .. i.bullet,
        highlight = {c.color('info'), c.color('bg2')}
    }
}

gls.left[10] = {
    DiagnosticEndSpace = {
        provider = diagnosticEndSpace,
        highlight = {c.color('bg2'), c.color('bg2')}
    }
}

gls.left[11] = {
    DiagnosticSeperator = {
        provider = diagnosticSeperator,
        highlight = {c.color('purple'), c.color('bg2')}
    }
}

gls.left[12] = {
    GitBranch = {
        provider = gitBranch,
        icon = " " .. i.git .. " ",
        condition = u.buffer_not_empty,
        highlight = {c.color('base'), c.color('purple')}
    }
}

gls.left[13] = {
    DiffAdd = {
        provider = diffAdd,
        condition = u.checkwidth,
        icon = i.diff.Add,
        highlight = {c.color('green'), c.color('purple')}
    }
}

gls.left[14] = {
    DiffModified = {
        provider = diffModified,
        condition = u.checkwidth,
        icon = i.diff.Modified,
        highlight = {c.color('orange'), c.color('purple')}
    }
}
gls.left[15] = {
    DiffRemove = {
        provider = diffRemove,
        condition = u.checkwidth,
        icon = i.diff.Remove,
        highlight = {c.color('red'), c.color('purple')}
    }
}

gls.left[16] = {
    GitSeperator = {
        provider = gitSeperator,
        condition = u.buffer_not_empty,
        highlight = {c.color('purple'), c.color('bg2')}
    }
}

gls.left[17] = {
    Space = {
        provider = space,
        highlight = {c.color('blue'), c.color('purple')}
    }
}

gls.right[1] = {
    FileFormat = {
        provider = fileFormat,
        highlight = {c.color('base'), c.color('purple')}
    }
}
gls.right[2] = {
    LineInfo = {
        provider = lineColumn,
        separator = " | ",
        separator_highlight = {c.color('base'), c.color('purple')},
        highlight = {c.color('base'), c.color('purple')}
    }
}
gls.right[3] = {
    PerCent = {
        provider = linePercent,
        separator = i.slant.Left,
        separator_highlight = {c.color('bg2'), c.color('purple')},
        highlight = {c.color('base'), c.color('bg2')}
    }
}
gls.right[4] = {
    ScrollBar = {
        provider = scrollBar,
        highlight = {c.color('yellow'), c.color('purple')}
    }
}

gls.short_line_left[1] = {
    BufferType = {
        provider = fileTypeName,
        separator = i.slant.Right,
        separator_highlight = {c.color('purple'), c.color('bg')},
        highlight = {c.color('base'), c.color('purple')}
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = bufferIcon,
        separator = i.slant.Left,
        separator_highlight = {c.color('purple'), c.color('bg')},
        highlight = {c.color('base'), c.color('purple')}
    }
}
