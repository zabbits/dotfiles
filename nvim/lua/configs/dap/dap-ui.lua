local M = {}

function M.config()
  local dapui = safe_require("dapui")
  local dap = safe_require("dap")
  if not dapui or not dap then
    return
  end

  dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
  dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
  dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

  dapui.setup({
    floating = { border = "rounded" }
  })
end

return M
