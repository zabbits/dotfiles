M = {}

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
    config = function()
      vim.g.cursorhold_updatetime = 200
    end,
  },

  -- Icons
  {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("configs.icons").config()
    end,
  },

  {
    'onsails/lspkind.nvim',
    config = function()
      require('configs.lsp-kind').config()
    end
  },

  -- Colorscheme
  {
    'glepnir/zephyr-nvim',
    before = 'kanagawa.nvim',
  },
  {
    'rebelot/kanagawa.nvim',
    config = function()
      require("configs.theme").config()
    end
  },


  -- UI Dressing
  {
    "stevearc/dressing.nvim",
    event = 'BufEnter',
    config = function()
      require("configs.dressing").config()
    end
  },


  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    after = "nvim-web-devicons",
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require("configs.bufferline").config()
    end,
  },

  -- Better buffer closing
  {
    "famiu/bufdelete.nvim",
    event = 'BufRead',
  },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    module = "neo-tree",
    cmd = "Neotree",
    requires = "MunifTanjim/nui.nvim",
    config = function()
      require("configs.neo-tree").config()
    end,
  },

  {
    'feline-nvim/feline.nvim',
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('configs.feline').config()
    end
  },

  -- ====================
  --      Treesitter
  -- ====================
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("configs.treesitter").config()
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
  -- show match context
  {
    "nvim-treesitter/nvim-treesitter-context",
    after = "nvim-treesitter",
    config = function()
      require('configs.treesitter-context').config()
    end
  },

  -- ====================
  --      Completion
  -- ====================
  -- Snippet collection
  {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
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
    after = "LuaSnip",
    -- event = { "BufRead", "BufNewFile" },
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

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("configs.autopairs").config()
    end,
  },

  -- ====================
  --         LSP
  -- ====================

  {
    "williamboman/mason.nvim",
    event = { 'BufNewFile', 'BufRead' },
    config = function()
      require('configs.mason').config()
    end
  },

  {
    "williamboman/mason-lspconfig.nvim",
    after = "mason.nvim",
    config = function()
      require('configs.mason-lspconfig').config()
    end
  },

  -- Built-in LSP
  {
    "neovim/nvim-lspconfig",
    after = "mason-lspconfig.nvim",
    config = function()
      require "configs.lsp"
    end
  },

  -- Lua dev
  {
    "folke/lua-dev.nvim",
    after = 'nvim-lspconfig',
  },

  -- Symbols outline
  {
    'stevearc/aerial.nvim',
    after = 'nvim-lspconfig',
    config = function()
      require('configs.aerial').config()
    end
  },

  -- Formatting and linting
  {
    "jose-elias-alvarez/null-ls.nvim",
    after = 'nvim-lspconfig',
    config = function()
      -- TODO
    end,
  },

  -- misc of lsp
  {
    "glepnir/lspsaga.nvim",
    after = 'nvim-lspconfig',
    config = function()
      require("configs.lspsaga").config()
    end
  },

  -- lsp diagnostic
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    after = 'nvim-lspconfig',
    config = function()
      vim.diagnostic.config({ virtual_lines = false })
      require("lsp_lines").setup()
    end,
  },


  {
    "ray-x/lsp_signature.nvim",
    after = 'nvim-lspconfig',
    config = function ()
      require("configs.lsp-signature").config()
    end
  },

  -- lsp trouble
  {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    after = 'nvim-lspconfig',
    config = function()
      require('configs.lsp-trouble').config()
    end
  },

  -- lsp preview
  {
    'rmagatti/goto-preview',
    after = 'nvim-lspconfig',
    config = function()
      require('configs.lsp-preview').config()
    end
  },

  -- lsp loading info
  {
    'j-hui/fidget.nvim',
    after = 'nvim-lspconfig',
    config = function()
      require("fidget").setup {}
    end
  },

  -- rust amend
  {
    'simrat39/rust-tools.nvim',
    after = 'nvim-lspconfig',
    config = function()
      require("configs.rust-tools").config()
    end
  },

  -- ====================
  --      Telescope
  -- ====================
  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
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

  -- Diff View
  {
    'sindrets/diffview.nvim',
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("configs.diffview").config()
    end
  },

  -- Start screen
  {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('configs.alpha').config()
    end
  },

  -- Color highlighting
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("configs.colorizer").config()
    end,
  },

  -- Terminal
  {
    "akinsho/nvim-toggleterm.lua",
    event = { "BufRead", "BufNewFile" },
    -- cmd = "ToggleTerm",
    -- module = { "toggleterm", "toggleterm.terminal" },
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
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("configs.indent-line").config()
    end,
  },

  -- Keymaps popup
  {
    "folke/which-key.nvim",
    event = "BufEnter",
    config = function()
      require("configs.which-key").config()
    end,
  },

  {
    'anuvyklack/hydra.nvim',
    event = { "BufRead", "BufNewFile" },
    config = function()
      require('configs.hydra').config()
    end
  },

  -- Get extra JSON schemas
  {
    "b0o/SchemaStore.nvim",
    event = { "BufRead", "BufNewFile" },
  },


  -- neorg for note
  {
    "nvim-neorg/neorg",
    cmd = "NeorgStart",
    ft = 'norg',
    after = "nvim-treesitter",
    config = function()
      require('configs.neorg').config()
    end,
  },

  {
    "ziontee113/icon-picker.nvim",
    event = { 'BufNewFile', 'BufRead' },
    config = function()
      require("icon-picker")
    end
  },

  {
    "nvim-neorg/neorg-telescope",
    after = 'neorg',
  },

  {
    'michaelb/sniprun',
    after = 'neorg',
    run = 'bash ./install.sh',
    config = function()
      require('configs.sniprun').config()
    end
  },

  -- draw table
  {
    'dhruvasagar/vim-table-mode',
    after = 'neorg',
    config = function()
      vim.g.table_mode_corner = '|'
    end
  },

  -- better marks
  {
    'chentoast/marks.nvim',
    event = { "BufRead", "BufNewFile" },
    config = function()
      require('marks').setup({})
    end
  },

  -- harpoon
  {
    'ThePrimeagen/harpoon',
    -- event = { "BufRead", "BufNewFile" },
    after = 'telescope.nvim',
    config = function()
      require('configs.harpoon').config()
    end
  },

  -- manage project
  {
    'ahmedkhalf/project.nvim',
    after = 'telescope.nvim',
    config = function()
      require('configs.project').config()
    end
  },

  -- manage session
  {
    'jedrzejboczar/possession.nvim',
    after = 'telescope.nvim',
    config = function()
      require('configs.session').config()
    end
  },

  -- plugin browser
  {
    "axieax/urlview.nvim",
    after = "dressing.nvim",
  },

  -- ====================
  --    Window manager
  -- ====================
  -- Window picker
  {
    's1n7ax/nvim-window-picker',
    tag = 'v1.*',
    after = 'neo-tree.nvim',
    config = function()
      require('configs.window-picker').config()
    end,
  },
  -- Smarter Splits
  {
    "mrjones2014/smart-splits.nvim",
    module = "smart-splits",
    event = { 'WinNew', 'TabNew' },
    config = function()
      require("configs.smart-splits").config()
    end,
  },
  -- rearrange window location
  {
    "sindrets/winshift.nvim",
    event = { 'WinNew', 'TabNew' },
    config = function()
      require('winshift').setup()
    end
  },

  -- ====================
  --     Edit enhance
  -- ====================
  {
    "tpope/vim-surround",
    event = { "BufRead", "BufNewFile" },
  },

  -- jump
  {
    'phaazon/hop.nvim',
    event = { "BufRead", "BufNewFile" },
    branch = 'v2', -- optional but strongly recommended
    config = function()
      require('configs.hop').config()
    end
  },


  {
    "in-a-day/command-palette",
    -- "~/github/command-palette",
    after = "telescope.nvim",
    config = function()
      require("configs.command-palette").config()
    end
  },

  {
    'kevinhwang91/promise-async',
    after = 'nvim-lspconfig',
  },

  -- fold
  {
    'kevinhwang91/nvim-ufo',
    after = 'promise-async',
    config = function()
      require("configs.ufo").config()
    end
  },

}

packer.startup {
  function(use)
    -- Load plugins!
    for _, plugin in pairs(plgins) do
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
