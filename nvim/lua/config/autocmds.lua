local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

cmd("FileType", {
  command = "set formatoptions-=cro",
})

-- Highlight on yank
cmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual" })
  end,
})

-- close some filetypes with <q>
cmd("FileType", {
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
    "notify",
    "sagahover",
    "sagarename",
    "neotest-summary",
    "neotest-output",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- fix telescope cannot use <C-R>, which-key hiject it.
augroup("_telescope", {})
cmd("FileType", {
  group = "_telescope",
  pattern = "TelescopePrompt",
  command = "inoremap <buffer> <silent> <C-r> <C-r>",
})

cmd("User", {
  pattern = "AlphaReady",
  callback = function()
    -- vim.opt.showtabline = 0
    vim.opt.laststatus = 0
  end,
})

cmd("BufUnload", {
  pattern = "<buffer>",
  callback = function()
    -- vim.opt.showtabline = 2
    vim.opt.laststatus = 3
  end,
})
