local M = {}

function M.config()
  local dap = safe_require("dap")
  if not dap then
    return
  end
  vim.fn.sign_define('DapBreakpoint', { text = '', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapBreakpointRejected ', { text = '', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapLogPoint', { text = '.>', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapStopped ', { text = '', texthl = '', linehl = '', numhl = '' })
end

return M
