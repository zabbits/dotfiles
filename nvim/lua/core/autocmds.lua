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

if utils.is_available "alpha-nvim" then
  local as_id = augroup("alpha_settings", {})
  cmd("User", {
    desc = "",
    group = as_id,
    pattern = "AlphaReady",
    callback = function()
      vim.opt.showtabline = 0
      vim.opt.laststatus = 0
    end
  })
  cmd("BufEnter", {
    desc = "Disable tabline and statusline in alpha",
    group = as_id,
    pattern = "*",
    callback = function()
      if vim.bo.filetype == 'alpha' then
        vim.opt.showtabline = 0
        vim.opt.laststatus = 0
        cmd("BufUnload", {
          desc = "Reset",
          group = "alpha_settings",
          pattern = "<buffer>",
          callback = function()
            vim.opt.showtabline = 2
            vim.opt.laststatus = 2
          end
        })
      end
    end
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
local exclude_filetype = {
  "NvimTree", "neo-tree", "neo-tree-popup", "dashboard",
  "Outline", "Trouble",
}
local function disable_number()
  local ft = vim.bo.filetype
  if vim.tbl_contains(exclude_filetype, ft) then
    vim.opt.number = false
    vim.opt.relativenumber = false
    return true
  end
  return false
end

augroup("_relative_number", {})
cmd({ "InsertEnter", }, {
  desc = "Disable Relative Number",
  group = "_relative_number",
  callback = function()
    if not disable_number() then
      vim.opt.number = true
      vim.opt.relativenumber = false
    end
  end,
})
cmd({ "InsertLeave", }, {
  desc = "Enable Relative Number",
  group = "_relative_number",
  callback = function()
    if not disable_number() then
      vim.opt.number = true
      vim.opt.relativenumber = true
    end
  end,
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


-- open file in last edit place
augroup("_last_edit", {})
cmd('BufReadPost', {
  desc = "Return to last edit position when opening files",
  group = "_last_edit",
  pattern = '*',
  command = [[if line("'\"") > 0 && line("'\"") <= line("$") && expand('%:t') != 'COMMIT_EDITMSG' | exe "normal! g`\"" | endif]],
})

return M
