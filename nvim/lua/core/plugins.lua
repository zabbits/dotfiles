local M = {}

local packer_status_ok, packer = pcall(require, "packer")
if not packer_status_ok then
  return
end

local plgins = {
  -- Plugin manager
  {
    "wbthomason/packer.nvim",
  },

  -- Optimiser
  { "lewis6991/impatient.nvim" },

  -- Lua functions
  { "nvim-lua/plenary.nvim" },

  -- Popup API
  { "nvim-lua/popup.nvim" },

  -- Boost startup time
  {
    "nathom/filetype.nvim",
    config = function()
      require("configs.filetype").config()
    end,
  },
  -- Indent detection
  {
    "Darazaki/indent-o-matic",
    event = "BufRead",
    config = function()
      require("configs.indent-o-matic").config()
    end,
  },

  -- Notification Enhancer
  {
    "rcarriga/nvim-notify",
    config = function()
      require("configs.notify").config()
    end,
  },

  -- Neovim UI Enhancer
  {
    "MunifTanjim/nui.nvim",
    module = "nui",
  },

  -- Cursorhold fix
  {
    "antoinemadec/FixCursorHold.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      vim.g.cursorhold_updatetime = 100
    end,
  },

  -- Smarter Splits
  {
    "mrjones2014/smart-splits.nvim",
    module = "smart-splits",
    config = function()
      require("configs.smart-splits").config()
    end,
  },

  -- Icons
  {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("configs.icons").config()
    end,
  },

  -- Colorscheme
  {
    'EdenEast/nightfox.nvim',
    requires = {
      'rebelot/kanagawa.nvim',
      'Yagua/nebulous.nvim',
    },
    config = function ()
      require("configs.theme").config()
    end
  },


  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require("configs.bufferline").config()
    end,
  },

  -- Better buffer closing
  {
    "moll/vim-bbye",
  },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    module = "neo-tree",
    cmd = "Neotree",
    requires = "MunifTanjim/nui.nvim",
    config = function()
      require("configs.neo-tree").config()
    end,
  },

  -- Window picker
  {
    's1n7ax/nvim-window-picker',
    tag = 'v1.*',
    after = 'neo-tree.nvim',
    config = function()
      require('configs.window-picker').config()
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    after = 'nightfox.nvim',
    config = function()
      require("configs.lualine").config()
    end,
  },

  -- Parenthesis highlighting
  {
    "p00f/nvim-ts-rainbow",
    after = "nvim-treesitter",
  },

  -- Autoclose tags
  {
    "windwp/nvim-ts-autotag",
    after = "nvim-treesitter",
  },

  -- Context based commenting
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    after = "nvim-treesitter",
  },

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("configs.treesitter").config()
    end,
  },

  -- Snippet collection
  {
    "rafamadriz/friendly-snippets",
    after = "nvim-cmp",
  },

  -- Snippet engine
  {
    "L3MON4D3/LuaSnip",
    after = "friendly-snippets",
    config = function()
      require("configs.luasnip").config()
    end,
  },

  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("configs.cmp").config()
    end,
  },

  -- Snippet completion source
  {
    "saadparwaiz1/cmp_luasnip",
    after = "nvim-cmp",
  },

  -- Buffer completion source
  {
    "hrsh7th/cmp-buffer",
    after = "nvim-cmp",
  },

  -- Path completion source
  {
    "hrsh7th/cmp-path",
    after = "nvim-cmp",
  },

  -- LSP completion source
  {
    "hrsh7th/cmp-nvim-lsp",
    after = "nvim-cmp",
  },

  -- LSP manager
  {
    "williamboman/nvim-lsp-installer",
  },

  -- Built-in LSP
  {
    "neovim/nvim-lspconfig",
    after = "cmp-nvim-lsp",
    config = function()
      require "configs.lsp"
    end,
  },

  -- LSP symbols
  {
    "simrat39/symbols-outline.nvim",
    after = "cmp-nvim-lsp",
    cmd = "SymbolsOutline",
    setup = function()
      require("configs.symbols-outline").setup()
    end,
  },

  -- lsp trouble
  {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require('configs.lsp-trouble').config()
    end
  },

  -- lsp signature
  {
    "ray-x/lsp_signature.nvim",
    after = 'nvim-lspconfig',
    config = function ()
      require('configs.lsp-signature').config()
    end
  },

  -- lsp code action menu
  {
    'weilbith/nvim-code-action-menu',
    after = 'nvim-lspconfig',
    cmd = 'CodeActionMenu',
  },
  -- lsp show code action hint
  {
    'kosayoda/nvim-lightbulb',
    after = 'nvim-lspconfig',
    config = function ()
      require('configs.lightbulb').config()
    end
  },

  -- lsp preview
  {
    'rmagatti/goto-preview',
    -- after = 'nvim-lspconfig',
    config = function()
      require('configs.lsp-preview').config()
    end
  },

  -- lsp loading info
  {
    'j-hui/fidget.nvim',
    config = function ()
      require("fidget").setup{}
    end
  },


  -- Formatting and linting
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      local null_ls = require("core.utils").user_plugin_opts "null-ls"
      if type(null_ls) == "function" then
        null_ls()
      end
    end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    after = 'trouble.nvim', -- use trouble show something
    module = "telescope",
    config = function()
      require("configs.telescope").config()
    end,
  },

  -- Fuzzy finder syntax support
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    after = "telescope.nvim",
    run = "make",
    config = function()
      require("telescope").load_extension "fzf"
    end,
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("configs.gitsigns").config()
    end,
  },

  -- Start screen
  {
    "glepnir/dashboard-nvim",
    config = function()
      require("configs.dashboard").config()
    end,
  },

  -- Color highlighting
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("configs.colorizer").config()
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    -- event = "InsertEnter",  -- use this events, sometimes will insert more than excpeted pairs.
    after = "nvim-cmp",
    config = function()
      require("configs.autopairs").config()
    end,
  },

  -- Terminal
  {
    "akinsho/nvim-toggleterm.lua",
    cmd = "ToggleTerm",
    module = { "toggleterm", "toggleterm.terminal" },
    config = function()
      require("configs.toggleterm").config()
    end,
  },

  -- Commenting
  {
    "numToStr/Comment.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("configs.comment").config()
    end,
  },

  -- Indentation
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("configs.indent-line").config()
    end,
  },

  -- Keymaps popup
  {
    "folke/which-key.nvim",
    config = function()
      require("configs.which-key").config()
    end,
  },

  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("configs.neoscroll").config()
    end,
    disable = true,
  },

  -- Smooth escaping
  {
    "max397574/better-escape.nvim",
    event = { "InsertEnter" },
    config = function()
      require("configs.better_escape").config()
    end,
  },

  -- Get extra JSON schemas
  { "b0o/SchemaStore.nvim" },

  -- neorg for note
  {
    "nvim-neorg/neorg",
    config = function()
      require('configs.norg').config()
    end,
  },

  -- better marks
  {
    'chentau/marks.nvim',
    event = { "BufRead", "BufNewFile" },
    config = function ()
      require('marks').setup({})
    end
  },
}

packer.startup {
  function(use)
    -- Load plugins!
    for _, plugin in pairs(plgins)
    do
      use(plugin)
    end
  end,
  config = {
    compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
    profile = {
      enable = true,
      threshold = 0.0001,
    },
    git = {
      clone_timeout = 300,
      subcommands = {
        update = "pull --ff-only --progress --rebase=true",
      },
    },
    auto_clean = true,
    compile_on_sync = true,
  },
}

return M
