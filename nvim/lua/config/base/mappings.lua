local M = {}

local opt = {}
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


-- bufferline key map
local bufferline = function()
  map('n', '<leader>b', '<cmd>BufferLineCyclePrev<CR>', opt)
  map('n', '<leader>n', '<cmd>BufferLineCycleNext<CR>', opt)
  map('n', '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>', opt)
  map('n', '<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>', opt)
  map('n', '<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>', opt)
  map('n', '<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>', opt)
  map('n', '<leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>', opt)
  map('n', '<leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>', opt)
  map('n', '<leader>7', '<Cmd>BufferLineGoToBuffer 7<CR>', opt)
  map('n', '<leader>8', '<Cmd>BufferLineGoToBuffer 8<CR>', opt)
  map('n', '<leader>9', '<Cmd>BufferLineGoToBuffer 9<CR>', opt)
end


function M.setup()


  -- 移除space移动光标
  map("n", "<Space>", "<NOP>", opt)

  -- nvimtree
  map("n", "<C-n>", ":NvimTreeToggle<CR>", opt)

  -- use ESC to turn off search highlighting
  map("n", "<Esc>", ":noh<CR>", opt)

  bufferline()
end
return M

