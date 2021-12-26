local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_config_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]


-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  -- Speed up
  use {
    "lewis6991/impatient.nvim",
    config = function ()
      require('config.impatient')
    end
  }
  -- use { --  Easily speed up your neovim startup time!. A faster version of filetype.vim
  --   'nathom/filetype.nvim'
  -- }
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "kyazdani42/nvim-web-devicons"


  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "lunarvim/darkplus.nvim"
  use 'folke/tokyonight.nvim'
  use 'rebelot/kanagawa.nvim'
  use {
    'norcalli/nvim-colorizer.lua',
    config = function ()
      require('colorizer').setup()
    end
  }


  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    config = function ()
      require('config.telescope')
    end
  }

  -- Session manager
  use {
    'rmagatti/auto-session',
    requires = {'nvim-telescope/telescope.nvim'},
    config = function()
      require('config.autosession')
    end
  }
  use {
    'rmagatti/session-lens',
    requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
    config = function()
      require('session-lens').setup({--[[your custom config--]]})
    end
  }


  -- LSP
  use {
    "neovim/nvim-lspconfig", -- enable LSP
    requires = {
      "williamboman/nvim-lsp-installer", -- simple to use language server installer
      "tamago324/nlsp-settings.nvim", -- language server settings defined in json for
      "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
      "antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function ()
      require('config.lsp')
    end
  }
  use { -- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
    'folke/trouble.nvim',
    config = function()
      require('config.trouble')
    end
  }
  use { -- Preview native LSP's goto definition calls in floating windows.
    'rmagatti/goto-preview',
    config = function ()
      require('config.lsp-preview')
    end
  }


  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    "JoosepAlviste/nvim-ts-context-commentstring",
    run = ":TSUpdate",
    config = function ()
      require('config.treesitter')
    end
  }


  -- Edit
  use {  -- better marks
    'chentau/marks.nvim',
    config = function ()
      require('marks').setup({})
    end
  }
  use {
    "windwp/nvim-autopairs",
    config = function ()
      require('config.autopairs')
    end
  }
  use {
    "numToStr/Comment.nvim",
    config = function ()
      require('config.comment')
    end
  }
  use {
    "kyazdani42/nvim-tree.lua",
    config = function ()
      require('config.nvim-tree')
    end
  }
  use {
    "akinsho/bufferline.nvim",
    config = function ()
      require('config.bufferline')
    end
  }
  use {
    "nvim-lualine/lualine.nvim",
    requires = {
      "auto-session",
    },
    config = function ()
      require('config.lualine')
    end
  }
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function ()
      require('config.indentline')
    end
  }


  -- buf del
  use "moll/vim-bbye"
  use {
    "akinsho/toggleterm.nvim",
    config = function ()
      require('config.toggleterm')
    end
  }
  use {
    "ahmedkhalf/project.nvim",
    config = function ()
      require('config.project')
    end
  }
  -- use {
  --   "goolord/alpha-nvim",
  --   config = function ()
  --     require('config.alpha')
  --   end
  -- }
  use {
    "folke/which-key.nvim",
    config = function ()
      require('config.whichkey')
    end
  }


  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
  -- cmp plugins
  use {
    "hrsh7th/nvim-cmp", -- The completion plugin
    requires = {
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer", -- buffer completions
      "hrsh7th/cmp-path", -- path completions
      "hrsh7th/cmp-calc", -- nvim-cmp source for math calculation.
      "hrsh7th/cmp-cmdline", -- cmdline completions
      "saadparwaiz1/cmp_luasnip", -- snippet completions
    },
    config = function()
      require('config.cmp')
    end
  }

  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    config = function ()
      require('config.gitsigns')
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
