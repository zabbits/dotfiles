local M = {
  'tamton-aquib/staline.nvim',
  enabled = false,
  event = { 'BufRead', 'BufNewFile' },
}

function M.config()
  require 'staline'.setup {
    sections = {
      left  = {
        ' ', 'right_sep_double', '-mode', 'left_sep_double', ' ',
        'right_sep_double', '-branch', 'left_sep_double', ' ',
      },
      mid   = { 'right_sep', '-file_name', 'left_sep' },
      right = {
        'right_sep', '-cool_symbol', 'left_sep', ' ',
        'right_sep', '- ', '-lsp_name', '- ', 'left_sep',
        'right_sep_double', '-line_column', 'left_sep_double', ' ',
      }
    },
    defaults = {
      fg = "#000000",
      left_separator = "",
      right_separator = "",
      true_colors = true,
      line_column = "[%l:%c] 並%p%% ",
      branch_symbol = require("core.icons").git.base .. ' ',
    },
    mode_colors = {
      n = "#2bbb4f",
      i = "#986fec",
      c = "#e27d60",
      v = "#4799eb",
    },
    special_table = {
      NvimTree = { 'NvimTree', ' ' },
      ['neo-tree'] = { 'Neo-tree', ' ' },
      packer = { 'Packer', ' ' }, -- etc
      Trouble = {'Trouble', ''},
      harpoon = { 'Harpoon', ''},
      ['neo-tree-popup'] = { 'Neo-tree', ''},
      ['lazy'] = { 'lazy', ''},
    },
  }

  local normal = vim.api.nvim_get_hl_by_name('Normal', true)
  require('stabline').setup {
    style = "bubble",
    bg = "#986fec",
    fg = "black",
    inactive_bg = normal.background,
    inactive_fg = normal.foreground,
    exclude_fts = { 'NvimTree', 'dashboard', 'lir', 'Trouble', 'Outline', 'neo-tree' },
  }
end

return M
