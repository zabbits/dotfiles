local M = {}

function M.config()
  local mason_nvim_dap = safe_require("mason-nvim-dap")
  if not mason_nvim_dap then
    return
  end

  mason_nvim_dap.setup({
    automatic_setup = true,
  })

  mason_nvim_dap.setup_handlers {
    function(source_name)
      require('mason-nvim-dap.automatic_setup')(source_name)
    end,
  }
end

return M
