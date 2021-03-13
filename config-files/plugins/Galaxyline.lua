local gl = require("galaxyline")
local section = gl.section
-- gl.short_line_list = {"NvimTree"}

-- COLORS [BEGIN]
local color = {
    bg = "#2e3440",
    fg = "#81a1c1",
    yellow = "#fabd2f",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#608B4E",
    orange = "#FF9900",
    purple = "#5d4d7a",
    magenta = "#d16d9e",
    grey = "#c0c0c0",
    blue = "#569CD6",
    red = "#F04123"
}
-- COLORS [END]

-- FUNCTIONS [BEGIN]
local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
        return true
    end
    return false
end
-- FUNCTIONS [END]

-- LEFT [BEGIN]
section.left[1] = {
    FirstElement = {
        provider = function() return "▊ 👺  " end,
        highlight = {color.red, color.bg, "bold"}
    }
}

section.left[10] = {
    FileIcon = {
        provider = "FileIcon",
        condition = buffer_not_empty,
        highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, color.bg}
    }
}

section.left[20] = {
    FileName = {
        provider = "FileName",
        condition = buffer_not_empty,
        separator = " ",
        separator_highlight = {"NONE", color.bg},
        highlight = {color.white, color.bg, "bold"}
    }
}
-- LEFT [END]

-- RIGHT [BEGIN]
section.right[1] = {
    GitIcon = {
        provider = function() return " " end,
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {color.orange, color.bg}
    }
}

section.right[5] = {
    GitBranch = {
        provider = "GitBranch",
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {color.orange, color.bg, "bold"}
    }
}

section.right[6] = {
    DiffAdd = {
        provider = "DiffAdd",
        icon = " ",
        highlight = {color.green, color.bg}
    }
}
section.right[7] = {
    DiffModified = {
        provider = "DiffModified",
        icon = "柳",
        highlight = {color.yellow, color.bg}
    }
}
section.right[8] = {
    DiffRemove = {
        provider = "DiffRemove",
        icon = " ",
        highlight = {color.red, color.bg}
    }
}

section.right[21] = {
    LineInfo = {
        provider = "LineColumn",
        separator = " ",
        separator_highlight = {"NONE", color.bg},
        highlight = {color.gray, color.bg}
    }
}

section.right[25] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        separator = " ",
        icon = " ",
        highlight = {color.red, color.bg},
        separator_highlight = {color.bg, color.bg}
    }
}

section.right[29] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = " ",
        highlight = {color.yellow, color.bg},
        separator_highlight = {color.bg, color.bg}
    }
}

section.right[33] = {
    DiagnosticInfo = {
        provider = "DiagnosticInfo",
        icon = " ",
        highlight = {color.green, color.bg},
        separator_highlight = {color.bg, color.bg}
    }
}

section.right[37] = {
    DiagnosticHint = {
        provider = "DiagnosticHint",
        icon = " ",
        highlight = {color.red, color.bg},
        separator_highlight = {color.bg, color.bg}
    }
}

-- section.right[40] = {
--     LastElement = {
--         provider = function() return ' ' end,
--         highlight = {"NONE", color.bg}
--     }
-- }
-- RIGHT [END]

-- LEFT inactive [BEGIN]
section.short_line_left[1] = {
    SFirstElement = {
        provider = function() return '▊ ' end,
        highlight = {color.blue, color.bg}
    }
}

section.short_line_left[10] = {
    SBufferType = {
        provider = "FileIcon",
        highlight = {color.blue, color.bg, "bold"}
    }
}

section.short_line_left[20] = {
    SFileName = {
        provider = "FileName",
        highlight = {color.blue, color.bg}
    }
}
-- LEFT inactive [END]

-- RIGHT inactive [BEGIN]
section.short_line_right[1] = {
    SBufferIcon = {
        provider = "BufferIcon",
        highlight = {color.blue, color.bg}
    }
}

section.short_line_right[5] = {
    SLastElement = {
        provider = function() return " " end,
        highlight = {color.blue, color.bg}
    }
}
-- RIGHT inactive [END]
