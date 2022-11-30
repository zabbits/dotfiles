M = {}

local packer_status_ok, packer = pcall(require, "packer")
if not packer_status_ok then
  return
end

local cfg = require('core.configs')

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

  -- startuptime
  -- {
  --   'dstein64/vim-startuptime'
  -- },

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
      require("configs.ui.notify").config()
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

  {
    "folke/noice.nvim",
    event = "VimEnter",
    disable = not cfg.noice,
    config = function()
      require('configs.ui.noice').config()
    end,
  },

  -- Icons
  {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("configs.ui.icons").config()
    end,
  },

  {
    'onsails/lspkind.nvim',
    config = function()
      require('configs.lsp.lsp-kind').config()
    end
  },

  -- Colorscheme
  {
    'rktjmp/lush.nvim',
  },
  {
    "catppuccin/nvim",
    as = "catppuccin",
  },
  {
    'tiagovla/tokyodark.nvim',
  },
  {
    'rebelot/kanagawa.nvim',
    config = function()
      require("configs.ui.theme").config()
    end
  },


  -- UI Dressing
  {
    "stevearc/dressing.nvim",
    event = 'BufEnter',
    config = function()
      require("configs.ui.dressing").config()
    end
  },


  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    after = "nvim-web-devicons",
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require("configs.ui.bufferline").config()
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
      require('configs.ui.feline').config()
    end
  },

  -- winbar
  {
    'b0o/incline.nvim',
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('configs.ui.incline').config()
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
      require("configs.syntax.treesitter").config()
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
      require('configs.syntax.treesitter-context').config()
    end
  },
  -- textobject
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = "nvim-treesitter",
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
      require("configs.edit.luasnip").config()
    end,
  },

  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    after = "LuaSnip",
    -- event = { "BufRead", "BufNewFile" },
    config = function()
      require("configs.edit.cmp").config()
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
      require("configs.edit.autopairs").config()
    end,
  },

  -- ====================
  --         LSP
  -- ====================

  {
    "williamboman/mason.nvim",
    event = { 'BufNewFile', 'BufRead' },
    config = function()
      require('configs.lsp.mason').config()
    end
  },

  {
    "williamboman/mason-lspconfig.nvim",
    after = "mason.nvim",
    config = function()
      require('configs.lsp.mason-lspconfig').config()
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
      require('configs.lsp.aerial').config()
    end
  },

  -- Formatting and linting
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   after = 'nvim-lspconfig',
  --   config = function()
  --     -- TODO
  --   end,
  -- },

  -- misc of lsp
  {
    "glepnir/lspsaga.nvim",
    after = 'nvim-lspconfig',
    config = function()
      require("configs.lsp.lspsaga").config()
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
    config = function()
      require("configs.lsp.lsp-signature").config()
    end
  },

  -- lsp trouble
  {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    after = 'nvim-lspconfig',
    config = function()
      require('configs.lsp.lsp-trouble').config()
    end
  },

  -- lsp preview
  {
    'rmagatti/goto-preview',
    after = 'nvim-lspconfig',
    config = function()
      require('configs.lsp.lsp-preview').config()
    end
  },

  -- lsp loading info
  {
    'j-hui/fidget.nvim',
    after = 'nvim-lspconfig',
    config = function()
      require("fidget").setup {
        text = {
          done = "",
        },
      }
    end
  },

  -- inlay hint
  {
    'lvimuser/lsp-inlayhints.nvim',
    after = 'nvim-lspconfig',
    disable = true,
    config = function ()
      require("lsp-inlayhints").setup()
      vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
      vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end

          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, bufnr)
        end,
      })
    end
  },

  -- rust tools
  {
    'simrat39/rust-tools.nvim',
    after = 'nvim-lspconfig',
    config = function()
      require("configs.syntax.rust-tools").config()
    end
  },

  {
    'saecki/crates.nvim',
    event = { "BufRead Cargo.toml" },
    config = function()
      local crates = safe_require('crates')
      if crates then
        crates.setup()
      end
    end,
  },


  -- ====================
  --      Debug
  -- ====================
  {
    'mfussenegger/nvim-dap',
    disable = true,
    config = function()
      require('configs.dap').config()
    end
  },

  {
    "rcarriga/nvim-dap-ui",
    after = "nvim-dap",
    disable = true,
    config = function()
      require('configs.dap.dap-ui').config()
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
      require('configs.ui.alpha').config()
    end
  },

  -- color picker and highlighting
  {
    'uga-rosa/ccc.nvim',
    event = { "BufRead", "BufNewFile" },
    config = function()
      local ccc = safe_require('ccc')
      if ccc then
        ccc.setup({})
        vim.cmd [["CccHighlighterEnable"]]
      end
    end
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
      require("configs.edit.comment").config()
    end,
  },

  -- Indentation
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("configs.ui.indent-line").config()
    end,
  },

  -- Keymaps popup
  {
    "folke/which-key.nvim",
    event = "BufEnter",
    config = function()
      require("configs.keymap.which-key").config()
    end,
  },

  {
    'anuvyklack/hydra.nvim',
    event = { "BufRead", "BufNewFile" },
    config = function()
      require('configs.keymap.hydra').config()
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
      require('configs.project.harpoon').config()
    end
  },

  -- manage project
  {
    'ahmedkhalf/project.nvim',
    after = 'telescope.nvim',
    config = function()
      require('configs.project.project').config()
    end
  },

  -- manage session
  {
    'jedrzejboczar/possession.nvim',
    after = 'telescope.nvim',
    config = function()
      require('configs.project.session').config()
    end
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
      require('configs.win.window-picker').config()
    end,
  },
  -- Smarter Splits
  {
    "mrjones2014/smart-splits.nvim",
    module = "smart-splits",
    event = { 'WinNew', 'TabNew' },
    config = function()
      require("configs.win.smart-splits").config()
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
      require("configs.edit.ufo").config()
    end
  },

  -- ssh yank
  {
    'ojroques/vim-oscyank',
    event = { "BufRead", "BufNewFile" },
    branch = 'main',
  }
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
