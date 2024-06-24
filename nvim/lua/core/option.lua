vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local options = {
    laststatus = 0,
    belloff = "all",
    fileencoding = "utf-8",                             -- File content encoding for the buffer
    spelllang = "en",                                   -- Support US english
    clipboard = "unnamedplus",                          -- Connection to the system clipboard
    mouse = "a",                                        -- Enable mouse support
    signcolumn = "auto:1",                              -- Hide the sign column

    completeopt = { "menuone", "noselect", "menuone" }, -- Options for insert mode completion
    colorcolumn = "99999",                              -- Fix for the indentline problem
    backup = false,                                     -- Disable making a backup file
    hidden = true,                                      -- Ignore unsaved buffers
    hlsearch = true,                                    -- Highlight all the matches of search pattern
    ignorecase = true,                                  -- Case insensitive searching
    smartcase = true,                                   -- Case sensitivie searching
    spell = false,                                      -- Disable spelling checking and highlighting
    showmode = false,                                   -- Disable showing modes in command line

    -- indent
    smartindent = true,
    autoindent = true,
    expandtab = true,
    shiftwidth = 4,
    softtabstop = 4,
    tabstop = 4,

    confirm = true,
    splitbelow = true,         -- Splitting a new window below the current one
    splitright = true,         -- Splitting a new window at the right of the current one
    swapfile = false,          -- Disable use of swapfile for the buffer
    termguicolors = true,      -- Enable 24-bit RGB color in the TUI
    undofile = true,           -- Enable persistent undo
    writebackup = false,       -- Disable making a backup before overwriting a file
    cursorline = true,         -- Highlight the text line of the cursor
    cursorlineopt = "number",  -- only Highlight line number
    number = true,             -- Show numberline
    relativenumber = true,     -- Show relative numberline
    wrap = false,              -- Disable wrapping of lines longer than the width of window
    cmdheight = 1,             -- Number of screen lines to use for the command line
    scrolloff = 2,             -- Number of lines to keep above and below the cursor
    sidescrolloff = 2,         -- Number of columns to keep at the sides of the cursor
    pumheight = 10,            -- Height of the pop up menu
    history = 100,             -- Number of commands to remember in a history table
    timeoutlen = 300,          -- Length of time to wait for a mapped sequence
    updatetime = 200,          -- Length of time to wait before triggering the plugin
    fillchars = { eob = " " }, -- Disable `~` on nonexistent lines

    conceallevel = 3,          -- Hide all text
    concealcursor = "",        -- show all
    mousemoveevent = true,

    smoothscroll = true,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.opt.shortmess:append({ c = true })
vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.opt.fillchars:append({
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    vert = "┃",
    vertleft = "┨",
    vertright = "┣",
    verthoriz = "╋",
})

if vim.g.neovide then
    vim.o.guifont = "Maple Mono SC NF:h12"
end

-- TODO: fix paste error ssh copy using osc52
-- local has_tty = vim.fn.getenv('SSH_TTY')
-- if has_tty and has_tty ~= vim.NIL then
--     vim.g.clipboard = {
--         name = 'OSC 52',
--         copy = {
--             ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--             ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
--         },
--         paste = {
--             ['+'] = function()
--                 return vim.fn.getreg('+')
--             end,
--             ['*'] = function()
--                 return vim.fn.getreg('*')
--             end,
--         }
--     }
-- end
