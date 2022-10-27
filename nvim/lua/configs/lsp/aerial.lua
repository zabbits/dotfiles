local M = {}

function M.config()
  local aerial = _G.safe_require('aerial')
  if not aerial then
    return
  end
  aerial.setup({
    on_attach = function (bufnr)
      vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
    end,
    layout = {
      min_width = 0.2,
    },
  })

  local telescope = _G.safe_require('telescope')
  if telescope then
    telescope.load_extension('aerial')
  end
end

return M
