-- this file can be loaded by calling `lua require('plugins')` from your init.vim

local safe_load = function(plugin, hook)

end

return require('packer').startup(function()
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
        },
        config = {
          require("config.treesitter").setup() 
        },
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
        config = {
          require("config.lsp").setup()
        },
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
        config = {
          require("config.cmp").setup()
        }
    }

    use {
        'windwp/nvim-autopairs',
        config = {
            require("nvim-autopairs").setup {}
        }
    }

    -- 目录树
    use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      config = {
        require("config.nvimtree").setup()
      }
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
        config = {
          require('config.bufferline').setup()
        }
    }

    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = {
          require('config.lualine').setup()
        }
    }

    use {
        "SmiteshP/nvim-gps",
        config = {
          require('nvim-gps').setup()
        },
    }

    use {
        'navarasu/onedark.nvim',
        config = {
          require('onedark').setup()
        },
    }

    use {
      'folke/lsp-colors.nvim',
      config = {
        require("lsp-colors").setup({})
      },
    }

    use {
      "ahmedkhalf/project.nvim",
      config = function()
        require("project_nvim").setup {}
      end,
    }

    use {
      "jbyuki/venn.nvim"
    }

end)

