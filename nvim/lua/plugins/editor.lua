-- ============ telescope =============
local telescope_conf = {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "debugloop/telescope-undo.nvim" },
    { "nvim-notify" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        file_ignore_patterns = { "node_modules", "dist" },
        prompt_prefix = "  ",
        selection_caret = "  ",
        path_display = { "truncate" },
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },

        mappings = {
          i = {
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,

            ["<C-j>"] = actions.cycle_history_next,
            ["<C-k>"] = actions.cycle_history_prev,

            ["<C-c>"] = actions.close,

            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,
          },

          n = {
            ["<esc>"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["H"] = actions.move_to_top,
            ["M"] = actions.move_to_middle,
            ["L"] = actions.move_to_bottom,

            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
          },
        },
      },
      pickers = {},
      extensions = {
        undo = {
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("undo")
    telescope.load_extension("notify")
    telescope.load_extension("noice")
  end
}


-- ============ which-key =============
local which_key_conf = {
  "folke/which-key.nvim",
  keys = {
    { "<leader>", mode = { "n", "v" } },
  },
  config = function()
    local which_key = require("which-key")
    which_key.setup({
      plugins = {
        spelling = { enabled = true },
        presets = { operators = false },
      },
      window = {
        border = "rounded",
        padding = { 2, 2, 2, 2 },
      },
    })

    which_key.register({
      mode = { "n", "v" },
      ["<leader>f"] = { name = "File" },
      ["<leader>l"] = { name = "LSP" },
      ["<leader>e"] = { name = "Neotree" },
      ["<leader>g"] = { name = "Git" },
      ["<leader>s"] = { name = "Search" },
      ["<leader>t"] = { name = "Terminal" },
      ["<leader>h"] = { name = "Harpoon" },
      ["<leader>n"] = { name = "Neorg" },
      ["<leader>o"] = { name = "Open" },
      ["<leader>y"] = { name = "Yank" },
    })
  end
}

local git_conf = {
  "lewis6991/gitsigns.nvim",
  event = { 'BufRead', 'BufNewFile' },
  keys = "<leader>g",
  opts = {
    signs = {
      add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
      delete = { hl = "GitSignsDelete", text = "▎", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      topdelete = {
        hl = "GitSignsDelete",
        text = "契",
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      changedelete = {
        hl = "GitSignsChange",
        text = "▎",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter_opts = {
      relative_time = false,
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    yadm = {
      enable = false,
    },
  }
}

local hydra_conf = {
  'anuvyklack/hydra.nvim',
  dependencies = {
    "sindrets/winshift.nvim",
  },
  keys = "M",
  config = function()
    local hydra = require('hydra')
    local splits = require('smart-splits')
    local cmd = vim.cmd
    local window_hint = [[
   ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
   ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
   ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally 
   _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
   ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _c_: close
   focus^^^^^^  window^^^^^^  ^_=_: equalize^   _o_: remain only
   ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   
  ]]

    hydra({
      name = 'Windows',
      hint = window_hint,
      config = {
        invoke_on_body = true,
        hint = {
          border = 'rounded',
          offset = -1
        }
      },
      mode = 'n',
      body = 'M',
      heads = {
        { 'h', '<C-w>h' },
        { 'j', '<C-w>j' },
        { 'k', cmd [[try | wincmd k | catch /^Vim\%((\a\+)\)\=:E11:/ | close | endtry]] },
        { 'l', '<C-w>l' },

        { 'H', cmd 'WinShift left' },
        { 'J', cmd 'WinShift down' },
        { 'K', cmd 'WinShift up' },
        { 'L', cmd 'WinShift right' },

        { '<C-h>', function() splits.resize_left(2) end },
        { '<C-j>', function() splits.resize_down(2) end },
        { '<C-k>', function() splits.resize_up(2) end },
        { '<C-l>', function() splits.resize_right(2) end },
        { '=', '<C-w>=', { desc = 'equalize' } },

        { 's', '<C-w>s' }, { '<C-s>', '<C-w><C-s>', { desc = false } },
        { 'v', '<C-w>v' }, { '<C-v>', '<C-w><C-v>', { desc = false } },

        { 'w', '<C-w>w', { exit = true, desc = false } },
        { '<C-w>', '<C-w>w', { exit = true, desc = false } },

        { 'o', '<C-w>o', { exit = true, desc = 'remain only' } },
        { '<C-o>', '<C-w>o', { exit = true, desc = false } },


        { 'c', cmd [[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]], { desc = 'close window' } },
        { '<C-q>', cmd [[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]], { desc = false } },
        { '<C-c>', cmd [[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]], { desc = false } },

        { 'q', nil, { exit = true, desc = false } },
        { '<Esc>', nil, { exit = true, desc = false } }
      }
    })

  end
}

local filetree_conf = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  cmd = "Neotree",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    source_selector = {
      winbar = true,
      statusline = false
    },
    use_default_mappings = false,
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = false,
    default_component_configs = {
      container = {
        enable_character_fade = true
      },
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        default = "",
        highlight = "NeoTreeFileIcon"
      },
      modified = {
        symbol = "[+]",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          added = "",
          modified = "",
          deleted = "ﮖ",
          renamed = "",
          untracked = "",
          ignored = "◌",
          unstaged = "",
          staged = "",
          conflict = "",
        },
      },
    },
    window = {
      position = "left",
      width = 40,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["e"] = function() vim.api.nvim_exec("Neotree focus filesystem left", true) end,
        ["b"] = function() vim.api.nvim_exec("Neotree focus buffers left", true) end,
        ["g"] = function() vim.api.nvim_exec("Neotree focus git_status left", true) end,
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        ["t"] = "open_tabnew",
        ["o"] = "open_with_window_picker",
        ["C"] = "close_node",
        ["a"] = {
          "add",
          -- some commands may take optional config options, see `:h neo-tree-mappings` for details
          config = {
            show_path = "none" -- "none", "relative", "absolute"
          }
        },
        ["A"] = "add_directory", -- also accepts the config.show_path option.
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy", -- takes text input for destination
        ["m"] = "move", -- takes text input for destination
        ["q"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
      }
    },
    nesting_rules = {},
    filesystem = {
      window = {
        mappings = {
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["f"] = "filter_on_submit",
          ["<c-x>"] = "clear_filter",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
        }
      },
      filtered_items = {
        visible = true,
        hide_dotfiles = true,
        hide_gitignored = false,
        hide_by_name = {
          ".DS_Store",
          "thumbs.db",
          "node_modules",
          "__pycache__",
        },
      },
      follow_current_file = false,
      group_empty_dirs = false, -- when true, empty folders will be grouped together
      hijack_netrw_behavior = "open_default",
      use_libuv_file_watcher = true,
    },
    buffers = {
      follow_current_file = true, -- This will find and focus the file in the active buffer every
      -- time the current file is changed while the tree is open.
      group_empty_dirs = true, -- when true, empty folders will be grouped together
      show_unloaded = true,
      window = {
        mappings = {
          ["bd"] = "buffer_delete",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
        }
      },
    },
    git_status = {
      window = {
        position = "float",
        mappings = {
          ["A"] = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
        },
      },
    },
    event_handlers = {
      {
        event = "vim_buffer_enter",
        handler = function(_)
          if vim.bo.filetype == "neo-tree" then
            vim.wo.signcolumn = "auto"
          end
        end,
      },
    },
  }
}

local term_conf = {
  "akinsho/nvim-toggleterm.lua",
  cmd = "ToggleTerm",
  opts = {
    size = 10,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  },
}

local split_conf = {
  "mrjones2014/smart-splits.nvim",
  event = { 'WinNew', 'TabNew' },
  opts = {
    -- Ignored filetypes (only while resizing)
    ignored_filetypes = {
      "nofile",
      "quickfix",
      "qf",
      "prompt",
      "neorg",
      "norg",
    },
    -- Ignored buffer types (only while resizing)
    ignored_buftypes = { "nofile" },
    -- when moving cursor between splits left or right,
    -- place the cursor on the same row of the *screen*
    -- regardless of line numbers.
    -- Can be overridden via function parameter, see Usage.
    move_cursor_same_row = false,
  }
}

local winshift_conf = {
  "sindrets/winshift.nvim",
  event = { 'WinNew', 'TabNew' },
}


-- Better buffer closing
local buf_conf = {
  "famiu/bufdelete.nvim",
  cmd = 'Bdelete',
}

local mason_conf = {
  "williamboman/mason.nvim",
  cmd = "Mason",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "jayp0521/mason-nvim-dap.nvim",
  },
  opts = {
    ui = {
      icons = {
        package_installed = "",
        package_pending = "",
        package_uninstalled = ""
      },
      keymaps = {
        -- Keymap to expand a package
        toggle_package_expand = "<CR>",
        -- Keymap to install the package under the current cursor position
        install_package = "i",
        -- Keymap to reinstall/update the package under the current cursor position
        update_package = "u",
        -- Keymap to check for new version for the package under the current cursor position
        check_package_version = "c",
        -- Keymap to update all installed packages
        update_all_packages = "U",
        -- Keymap to check which installed packages are outdated
        check_outdated_packages = "C",
        -- Keymap to uninstall a package
        uninstall_package = "X",
        -- Keymap to cancel a package installation
        cancel_installation = "<C-c>",
        -- Keymap to apply language filter
        apply_language_filter = "<C-x>",
      },
    },
  }
}

local yank_conf = {
  'in-a-day/nvim-osc52',
  keys = "<leader>y",
}

return {
  { "nvim-lua/plenary.nvim" },
  telescope_conf,
  which_key_conf,
  git_conf,
  hydra_conf,
  filetree_conf,
  term_conf,
  split_conf,
  winshift_conf,
  buf_conf,
  mason_conf,
  yank_conf,
}
