local M = {}

local map = function (mode, key, cmd, opt)
  vim.api.nvim_set_keymap(mode, key, cmd, opt)
end

function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end

-- 插件是否已安装
function M.exist(plugins)
  for key, value in pairs(plugins) do
    local ok, _ = pcall(require, value)
    if not ok then
      return false
    end
  end
  return true
end

function M.normal_map(key, cmd, opt)
  M.map('n', key, cmd, opt)
end

function M.visual_map(key, cmd, opt)
  M.map('v', key, cmd, opt)
end

function M.nvo_map(key, cmd, opt)
  M.map('', key, cmd, opt)
end

function M.map(mode, key, cmd, opt)
  map(mode, key, cmd, opt)
end

return M

