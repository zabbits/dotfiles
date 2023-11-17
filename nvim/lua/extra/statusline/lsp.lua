local colors = require("extra.statusline.colors")
local hl = colors.highlight
local conditions = require("heirline.conditions")

local lsp = {
    condition = conditions.lsp_attached,
    update = { "LspAttach", "LspDetach" },
    provider = function()
        local names = {}
        for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
            table.insert(names, server.name)
        end
        return " [" .. table.concat(names, " ") .. "]"
    end,

    hl = hl.LspServer,
}

return lsp
