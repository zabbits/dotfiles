local M = {}

local options = {
  belloff = "all",
  fileencoding = "utf-8",                     -- File content encoding for the buffer
  spelllang = "en",                           -- Support US english
  clipboard = "unnamedplus",                  -- Connection to the system clipboard
  mouse = "a",                                -- Enable mouse support
  signcolumn = "no",                          -- Hide the sign column

  foldmethod = "expr",                        -- Treesitter fold
  foldexpr = "nvim_treesitter#foldexpr()",
  foldlevel = 99,
  foldlevelstart = 99,

  completeopt = { "menuone", "noselect", "menuone" },    -- Options for insert mode completion
  colorcolumn = "99999",                      -- Fix for the indentline problem
  backup = false,                             -- Disable making a backup file
  hidden = true,                              -- Ignore unsaved buffers
  hlsearch = true,                            -- Highlight all the matches of search pattern
  ignorecase = true,                          -- Case insensitive searching
  smartcase = true,                           -- Case sensitivie searching
  spell = false,                              -- Disable spelling checking and highlighting
  showmode = false,                           -- Disable showing modes in command line

  -- indent
  autoindent = true,
  expandtab = true,
  shiftwidth = 2,
  smartindent = true,
  softtabstop = 2,
  tabstop = 2,

  splitbelow = true,                          -- Splitting a new window below the current one
  splitright = true,                          -- Splitting a new window at the right of the current one
  swapfile = false,                           -- Disable use of swapfile for the buffer
  termguicolors = true,                       -- Enable 24-bit RGB color in the TUI
  undofile = true,                            -- Enable persistent undo
  writebackup = false,                        -- Disable making a backup before overwriting a file
  cursorline = true,                          -- Highlight the text line of the cursor
  number = true,                              -- Show numberline
  relativenumber = true,                      -- Show relative numberline
  wrap = false,                               -- Disable wrapping of lines longer than the width of window
  conceallevel = 0,                           -- Show text normally
  cmdheight = 1,                              -- Number of screen lines to use for the command line
  scrolloff = 2,                              -- Number of lines to keep above and below the cursor
  sidescrolloff = 2,                          -- Number of columns to keep at the sides of the cursor
  pumheight = 10,                             -- Height of the pop up menu
  history = 100,                              -- Number of commands to remember in a history table
  timeoutlen = 300,                           -- Length of time to wait for a mapped sequence
  updatetime = 300,                           -- Length of time to wait before triggering the plugin
  fillchars = { eob = " " },                  -- Disable `~` on nonexistent lines
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append "c"
vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]

return M
