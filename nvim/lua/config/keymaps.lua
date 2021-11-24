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
local bufferline_keymap = function()
  -- goto previous buffer
  map('n', '<leader>b', ':BufferLineCyclePrev<CR>', opt)
  -- goto next buffer
  map('n', '<leader>n', ':BufferLineCycleNext<CR>', opt)
  -- goto buffer specified number
  map('n', '<leader>1', ':BufferLineGoToBuffer 1<CR>', opt)
  map('n', '<leader>2', ':BufferLineGoToBuffer 2<CR>', opt)
  map('n', '<leader>3', ':BufferLineGoToBuffer 3<CR>', opt)
  map('n', '<leader>4', ':BufferLineGoToBuffer 4<CR>', opt)
  map('n', '<leader>5', ':BufferLineGoToBuffer 5<CR>', opt)
  map('n', '<leader>6', ':BufferLineGoToBuffer 6<CR>', opt)
  map('n', '<leader>7', ':BufferLineGoToBuffer 7<CR>', opt)
  map('n', '<leader>8', ':BufferLineGoToBuffer 8<CR>', opt)
  map('n', '<leader>9', ':BufferLineGoToBuffer 9<CR>', opt)
end

local lspsaga_keymap = function()
  -- find the cursor word definition and reference
  map('n', '<leader>ph', ':Lspsaga lsp_finder<CR>', opt)
  -- preview definition
  map('n', '<leader>pd', ':Lspsaga preview_definition<CR>', opt)
  -- show diagnostics
  map('n', '<leader>pe', ':Lspsaga show_line_diagnostics<CR>', opt)
  -- jump diagnostics
  map('n', '[e', ':Lspsaga diagnostic_jump_prev<CR>', opt)
  map('n', ']e', ':Lspsaga diagnostic_jump_next<CR>', opt)
  -- show doc, can not copy the doc so do not use
  -- map('n', 'K', ':Lspsaga hover_doc<CR>', opt)
  -- code action
  map('n', '<leader>ca', ':Lspsaga code_action<CR>', opt)
  map('v', '<leader>ca', ':<C-U>Lspsaga range_code_action<CR>', opt)
  -- rename
  map('n', '<leader>cr', ':Lspsaga rename<CR>', opt)
end

local trouble_keymap = function()
  vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", {silent = true, noremap = true}
)
  map("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", opt)
  map("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", opt)
  map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opt)
  map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opt)
  map("n", "<leader>xr", "<cmd>Trouble lsp_references<cr>", opt)

end

-- nvimtree
local tree_keymap = function()
  map("n", "<C-n>", ":NvimTreeToggle<CR>", opt)
end


local telescope_keymap = function ()
  map('n', '<leader><space>', '<cmd>Telescope find_files<cr>', opt)
  map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opt)
  map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opt)
  map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opt)
  map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opt)
end

local misc_keymap = function ()
  map('', '<Space>', '<Nop>', opt)
  -- use ESC to turn off search highlighting
  map("n", "<Esc>", ":noh<CR>", opt)

  -- insert new line below currentline and keep cursor in currentline
  map('n', 'zj', 'o<ESC>k', opt)
  -- insert new line above currentline and keep cursor in currentline
  map('n', 'zk', 'O<ESC>j', opt)

  -- let cursor in next line with insert mode
  map('i', '<C-j>', '<ESC>ja', opt)
  -- let cursor in next line with insert mode
  map('i', '<C-k>', '<ESC>ka', opt)

  --Remap for dealing with word wrap
  map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
  map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

  -- Y yank until the end of line  (note: this is now a default on master)
  map('n', 'Y', 'y$', { noremap = true })
end


function M.setup()
  misc_keymap()
  bufferline_keymap()
  lspsaga_keymap()
  trouble_keymap()
  tree_keymap()
  telescope_keymap()
end

return M

