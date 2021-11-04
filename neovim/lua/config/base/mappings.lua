local M = {}

function M.setup()
  local function map(mode, lhs, rhs, opts)
      local options = {noremap = true, silent = true}
      if opts then
          options = vim.tbl_extend("force", options, opts)
      end
      vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  end

  local opt = {}

  -- 移除space移动光标
  map("n", "<Space>", "<NOP>", opt)

  -- nvimtree
  map("n", "<C-n>", ":NvimTreeToggle<CR>", opt)

  -- use ESC to turn off search highlighting
  map("n", "<Esc>", ":noh<CR>", opt)
end

return M

