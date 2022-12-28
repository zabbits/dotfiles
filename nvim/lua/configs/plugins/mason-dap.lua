local M = {
  "jayp0521/mason-nvim-dap.nvim",
  event = { 'BufRead', 'BufNewFile' },
  dependencies = { "mason.nvim" },
}

function M.config()
  local mason_nvim_dap = safe_require("mason-nvim-dap")
  if not mason_nvim_dap then
    return
  end

  mason_nvim_dap.setup({
    automatic_setup = false,
  })

  mason_nvim_dap.setup_handlers()
end

return M
