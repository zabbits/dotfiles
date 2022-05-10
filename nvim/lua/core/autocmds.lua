-- augroup("_luasnip", {})

local utils = require "core.utils"

-- see h: api-autocmd
local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local gs_id = augroup("_general_settings", {})
cmd("TextYankPost", {
  desc = "Highlight on yank",
  group = gs_id,
  callback = function()
    require('vim.highlight').on_yank({ higroup = 'Visual', timeout = 200 })
  end,
})
cmd("BufWinEnter", {
  desc = "Change formatoptions",
  group = gs_id,
  command = "set formatoptions-=cro",
})
cmd("FileType", {
  desc = "Use 'q' close in qf, help, man, lspinfo, notify",
  pattern = {
    "qf", "help", "man", "lspinfo", "notify",
  },
  group = gs_id,
  command = "nnoremap <silent> <buffer> q :close<cr>",
})


augroup("packer_user_config", {})
cmd("BufWritePost", {
  desc = "Auto Compile plugins.lua file",
  group = "packer_user_config",
  command = "source <afile> | PackerCompile",
  pattern = "plugins.lua",
})

augroup("cursor_off", {})
cmd("WinLeave", {
  desc = "No cursorline",
  group = "cursor_off",
  command = "set nocursorline",
})
cmd("WinEnter", {
  desc = "No cursorline",
  group = "cursor_off",
  command = "set cursorline",
})

if utils.is_available "dashboard-nvim" and utils.is_available "bufferline.nvim" then
  augroup("dashboard_settings", {})
  cmd("FileType", {
    desc = "Disable tabline for dashboard",
    group = "dashboard_settings",
    pattern = "dashboard",
    command = "set showtabline=0",
  })
  cmd("BufWinLeave", {
    desc = "Reenable tabline when leaving dashboard",
    group = "dashboard_settings",
    pattern = "<buffer>",
    command = "set showtabline=2",
  })
  cmd("BufEnter", {
    desc = "No cursorline on dashboard",
    group = "dashboard_settings",
    pattern = "*",
    command = "if &ft is 'dashboard' | set nocursorline | endif",
  })
end

-- fix telescope cannot use <C-R>, which-key hiject it.
augroup("_telescope", {})
cmd("FileType", {
  group = "_telescope",
  pattern = "TelescopePrompt",
  command = "inoremap <buffer> <silent> <C-r> <C-r>"
})


-- relative number
augroup("_relative_number", {})
cmd("InsertEnter", {
  group = "_relative_number",
  command = "set norelativenumber"
})
cmd("InsertLeave", {
  group = "_relative_number",
  command = "set relativenumber"
})

-- fix luasnip use tab go to history
augroup("_luasnip", {})
cmd("ModeChanged", {
  group = "_luasnip",
  callback = function()
    local luasnip = utils.safe_require('luasnip')
    if not luasnip then
      return
    end

    if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
        and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
        and not luasnip.session.jump_active
    then
      luasnip.unlink_current()
    end
  end
})

return M
