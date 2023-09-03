-- You can simply override any internal plugins using Lazy, here are some example operations:
return {
  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "███╗   ██╗██╗ ██████╗██╗  ██╗██╗     ██╗ ██████╗ ██╗   ██╗",
        "████╗  ██║██║██╔════╝██║  ██║██║     ██║██╔═══██╗██║   ██║",
        "██╔██╗ ██║██║██║     ███████║██║     ██║██║   ██║██║   ██║",
        "██║╚██╗██║██║██║     ██╔══██║██║██   ██║██║   ██║██║   ██║",
        "██║ ╚████║██║╚██████╗██║  ██║██║╚█████╔╝╚██████╔╝╚██████╔╝",
        "╚═╝  ╚═══╝╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝ ╚════╝  ╚═════╝  ╚═════╝ ",
      }

      local get_icon = require("astroui").get_icon
      opts.section.buttons.val = {
        opts.button("n", get_icon("FileNew", 2, true) .. "New File  ", ":ene <BAR> startinsert <CR>"),
        opts.button(
          "f",
          get_icon("Search", 2, true) .. "Find File  ",
          ':lua require("telescope.builtin").find_files() <CR>'
        ),
        opts.button(
          "o",
          get_icon("DefaultFile", 2, true) .. "Recents  ",
          ':lua require("telescope.builtin").oldfiles() <CR>'
        ),
        opts.button(
          "w",
          get_icon("WordFile", 2, true) .. "Find Word  ",
          ':lua require("telescope.builtin").live_grep() <CR>'
        ),
        opts.button("s", get_icon("Refresh", 2, true) .. "Last Session  ", "<cmd>lua require('resession').load()<cr>"),
        opts.button(
          "  c",
          "  Configurations",
          ':lua require("telescope.builtin").find_files({cwd=vim.fn.stdpath("config")}) <CR>'
        ),
        opts.button("  l", "󰒲  Lazy", ":Lazy <CR>"),
        opts.button("  q", "󰿅  Quit", ":qa <CR>"),
      }

      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults.file_ignore_patterns = { "node_modules", "dist", "build" }
      opts.defaults.prompt_prefix = "  "
      opts.defaults.selection_caret = "󰈺 "

      return opts
    end,
  },
}
