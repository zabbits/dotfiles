-- this file can be loaded by calling `lua require('plugins')` from your init.vim
-- packer logs in stdpath(cache)/packer.nvim.log

local safe_load = function(plugin, opt)
  local ok, p pcall(require, plugin)
  if not ok then
    return
  end
  local options = {}
  if opt then
    options = opt
  end
  p.setup(options)
end

return require('packer').startup({
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'nvim-lua/plenary.nvim'

    -- treesitter相关
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = {
          'nvim-treesitter/nvim-treesitter-refactor',
          "nvim-treesitter/nvim-treesitter-textobjects",
          'p00f/nvim-ts-rainbow',
          'windwp/nvim-ts-autotag',
          'nvim-lua/plenary.nvim',
        },
        config = function()
          require("config.treesitter").setup()
        end,
    }

    -- lsp相关
    use {
        "neovim/nvim-lspconfig",
        requires = {
          "williamboman/nvim-lsp-installer",
          "onsails/lspkind-nvim",
          "glepnir/lspsaga.nvim",
          "RRethy/vim-illuminate",
          "ray-x/lsp_signature.nvim",
        },
        config = function()
          require("config.lsp").setup()
        end,
    }

    -- 补全相关
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
            'hrsh7th/vim-vsnip-integ',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-emoji",
            "ray-x/cmp-treesitter",
            'windwp/nvim-autopairs',  -- 用于补全函数参数括号
        },
        config = function()
          require("config.cmp").setup()
        end,
    }

    use {
        'windwp/nvim-autopairs',
        config = function()
            require("nvim-autopairs").setup {}
        end,
    }

    -- 目录树
    use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require("config.nvimtree").setup()
      end,
    }

    -- wsl copy
    use {
      'christianfosli/wsl-copy'
    }

    -- UI相关
    use {
        'kyazdani42/nvim-web-devicons'
    }

    use {
        'akinsho/nvim-bufferline.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
          require('config.bufferline').setup()
        end,
    }

    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function()
          require('config.lualine').setup()
        end,
    }

    use {
        "SmiteshP/nvim-gps",
        config = function()
          require('nvim-gps').setup()
        end,
    }

    use {
        'navarasu/onedark.nvim',
        config = function()
          require('onedark').setup()
        end,
    }

    use {
      'folke/lsp-colors.nvim',
      config = function()
        require("lsp-colors").setup()
      end,
    }

    use {
      "jbyuki/venn.nvim"
    }
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
})

