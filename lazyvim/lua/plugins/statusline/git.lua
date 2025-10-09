local conditions = require("heirline.conditions")
local colors = require("plugins.statusline.colors")
local icons = LazyVim.config.icons.git

local git = {
    condition = conditions.is_git_repo,

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = (self.status_dict.added ~= nil and self.status_dict.added ~= 0)
            or (self.status_dict.removed ~= nil and self.status_dict.removed ~= 0)
            or (self.status_dict.changed ~= nil and self.status_dict.changed ~= 0)
    end,

    hl = { fg = "orange" },

    { -- git branch name
        provider = function(self)
            return " " .. self.status_dict.head .. " "
        end,
        hl = { bold = true },
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and (icons.added .. count) .. " "
        end,
        hl = { fg = colors.highlight.Git.added.fg },
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and (icons.removed .. count) .. " "
        end,
        hl = { fg = colors.highlight.Git.removed.fg },
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and (icons.modified .. count)
        end,
        hl = { fg = colors.highlight.Git.changed.fg },
    },
}

return git
