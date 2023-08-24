return {
  "neovim/nvim-lspconfig",
  init = function()
    local format = function()
      require("lazyvim.plugins.lsp.format").format({ force = true })
    end
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "gI", "<cmd>Trouble lsp_implementations<CR>", desc = "Goto implementation" }
    keys[#keys + 1] = { "gt", "<cmd>Trouble lsp_type_definitions<CR>", desc = "Goto type" }
    keys[#keys + 1] = { "gd", "<cmd>Trouble lsp_definitions<CR>", desc = "Goto definition" }
    keys[#keys + 1] = { "gr", "<cmd>Trouble lsp_references<CR>", desc = "Goto references" }
    keys[#keys + 1] = { "gq", format, desc = "Format Document", has = "formatting" }
    keys[#keys + 1] = { "gq", format, desc = "Format Range", mode = "v", has = "rangeFormatting" }
    keys[#keys + 1] = { "ga", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" }
    keys[#keys + 1] = { "ga", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" }
    -- disable
    keys[#keys + 1] = { "<leader>cd", false }
    keys[#keys + 1] = { "<leader>cl", false }
    keys[#keys + 1] = { "<leader>cf", false }
    keys[#keys + 1] = { "<leader>ca", mode = { "n", "v" }, false }
    keys[#keys + 1] = { "<leader>cA", false }
    keys[#keys + 1] = { "<leader>cr", false }
  end,
}
