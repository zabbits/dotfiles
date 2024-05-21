local colors = require("extra.statusline.colors")
local hl = colors.highlight
local conditions = require("heirline.conditions")
local icons = require("core.icons")

local diagnostics = {
    condition = conditions.has_diagnostics,
    static = {
        error_icon = icons.lsp.error .. ' ',
        warn_icon = icons.lsp.warn .. ' ',
        info_icon = icons.lsp.info .. ' ',
        hint_icon = icons.lsp.hint .. ' ',
    },
    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,
    update = { "DiagnosticChanged", "BufEnter" },
    {
        provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.errors > 0 and (self.error_icon .. self.errors .. " ")
        end,
        hl = hl.Diagnostic.error,
    },
    {
        provider = function(self)
            return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
        end,
        hl = hl.Diagnostic.warn,
    },
    {
        provider = function(self)
            return self.info > 0 and (self.info_icon .. self.info .. " ")
        end,
        hl = hl.Diagnostic.info,
    },
    {
        provider = function(self)
            return self.hints > 0 and (self.hint_icon .. self.hints)
        end,
        hl = hl.Diagnostic.hint,
    },
}

return diagnostics
