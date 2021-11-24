local M = {}

M.setup = function ()
  local g = vim.g
  g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
  g.nvim_tree_gitignore = 0
  g.nvim_tree_git_hl = 1
  g.nvim_tree_highlight_opened_files = 1
  g.nvim_tree_indent_markers = 1
  g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
  g.nvim_tree_quit_on_open = 0 -- closes tree when file's opened
  g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }
  g.nvim_tree_window_picker_exclude = {
    filetype = { 'notify', 'packer', 'qf' },
    buftype = {'terminal' },
  }

  --
  g.nvim_tree_show_icons = {
    folders = 1,
    -- folder_arrows= 1
    files = 1,
    git = 1,
  }

  g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        deleted = "",
        ignored = "◌",
        renamed = "➜",
        staged = "✓",
        unmerged = "",
        unstaged = "✗",
        untracked = "★",
    },
    folder = {
        -- disable indent_markers option to get arrows working or if you want both arrows and indent then just add the arrow icons in front            ofthe default and opened folders below!
        -- arrow_open = "",
        -- arrow_closed = "",
        default = "",
        empty = "", -- 
        empty_open = "",
        open = "",
        symlink = "",
        symlink_open = "",
    },
  }

  require('nvim-tree').setup {
    diagnostics = {
        enable = false,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
    },
    filters = {
        dotfiles = false,
    },
    disable_netrw = true,
    hijack_netrw = true,
    ignore_ft_on_setup = { "dashboard" },
    auto_close = false,
    open_on_tab = false,
    hijack_cursor = true,
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = false,
    },
    view = {
        allow_resize = true,
        side = "left",
        width = 25,
    },
  }
  -- 注册event
  local events = require('nvim-tree.events')
  local notify = function (msg)
    local log_lv = vim.lsp.log_levels.INFO
    local log_opts = {
      title = 'Nvim Tree',
      timeout = 2000,
    }
    vim.notify(msg, log_lv, log_opts)
  end

  events.on_node_renamed(function (data)
    local msg = 'rename\nfrom:' .. data.old_name .. '\nto:' .. data.new_name
    notify(msg)
  end)
  -- nvim-tree的file created事件与folder created事件会一起调用, 所以不注册改事件
  -- events.on_file_created(function (data)
  --   local msg = 'create file: ' .. data.fname
  --   notify(msg)
  -- end)
  events.on_file_removed(function (data)
    local msg = 'remove file: ' .. data.fname
    notify(msg)
  end)
  events.on_folder_created(function (data)
    local msg = 'created : ' .. data.folder_name
    notify(msg)
  end)
  events.on_folder_removed(function (data)
    local msg = 'remove folder: ' .. data.folder_name
    notify(msg)
  end)
end

return M
