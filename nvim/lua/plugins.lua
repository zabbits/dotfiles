-- this file can be loaded by calling `lua require('plugins')` from your init.vim
-- packer logs in stdpath(cache)/packer.nvim.log
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- auto compile after write
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup({
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    -- notify
    use {
      'rcarriga/nvim-notify',
      config = function ()
        -- set notify to vim default notify, let other plugin use it.
        vim.notify = require("notify")
      end

    }

    -- color highlight
    use {
      'norcalli/nvim-colorizer.lua',
      event = 'BufEnter',
      config = function()
        require'colorizer'.setup({})
        vim.cmd [[au BufEnter * ColorizerAttachToBuffer]]
      end
    }

    -- 主题
    use {
      'folke/tokyonight.nvim',
      event = 'BufEnter',
      config = function()
        vim.cmd [[colorscheme tokyonight]]
      end
    }
    -- status line
    use {
      'famiu/feline.nvim',
      event = 'BufEnter',
      config = function()
        require('feline').setup()
      end
    }
    -- buffer line
    use {
      'akinsho/bufferline.nvim',
      event = 'BufEnter',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require("config.bufferline").setup()
      end
    }


    -- git
    use {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
      config = function()
        require('gitsigns').setup()
      end
    }


    -- 缩进
    use {
      "lukas-reineke/indent-blankline.nvim",
      after = 'tokyonight.nvim',
      config = function ()
        require('config.indentline').setup()
      end
    }

    -- better % match, 使用BufEnter在首次进入不生效
    use {
      'andymass/vim-matchup',
      event = 'VimEnter',
      config = function()
        vim.g.matchup_matchparen_offscreen = {method = 'popup'}
        vim.g.matchup_delim_noskips = 1 -- 仅在注释中匹配符号
        vim.cmd[[NoMatchParen]]
        vim.cmd[[DoMatchParen]]
      end
    }


    -- terminal
    use {
      "akinsho/toggleterm.nvim",
      event = 'BufEnter',
      config = function()
        require("toggleterm").setup{}
      end
    }

    -- treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      event = 'BufEnter',
      config = function ()
        require('config.treesitter').setup()
      end
    }


    -- telescope
    use {
      'nvim-telescope/telescope-fzf-native.nvim',
      event = 'BufEnter',
      run = 'make'
    }
    use {
      'nvim-telescope/telescope.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      after = 'telescope-fzf-native.nvim',
      config = function()
        require('config.telescope').setup()
      end
    }



    -- 目录树
    use {
      'kyazdani42/nvim-tree.lua',
      event = 'BufEnter',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require('config.tree').setup()
      end
    }


    -- 补全
    use {
      'hrsh7th/vim-vsnip',
      event = 'InsertEnter',
    }
    -- 提供了类似vscode补全的类型图标
    use {
      'onsails/lspkind-nvim',
      event = 'InsertEnter',
    }
    use {
      'hrsh7th/nvim-cmp',
      after = {'vim-vsnip', 'lspkind-nvim'},
      config = function()
        require('config.completion').setup()
      end
    }
    use {
      'hrsh7th/cmp-vsnip',
      after = 'nvim-cmp',
    }
    -- 用于lsp, 所以提前加载
    use {
      'hrsh7th/cmp-nvim-lsp',
      event = 'BufEnter',
      -- after = 'nvim-cmp',
    }
    use {
      'hrsh7th/cmp-buffer',
      after = 'nvim-cmp',
    }
    -- 默认定义了大量snippets
    use {
      "rafamadriz/friendly-snippets",
      after = 'nvim-cmp',
    }
    -- 括号补全
    use {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = function()
        require('nvim-autopairs').setup({})
      end
    }
    -- 符号补全
    use {
      'tpope/vim-surround',
      event = 'BufEnter',
    }


    -- 注释
    use {
      'numToStr/Comment.nvim',
      event = 'BufEnter',
      config = function()
        require('Comment').setup()
      end
    }


    -- lsp
    use {
      'neovim/nvim-lspconfig',
      event = 'BufEnter',
    }
    use {
      'williamboman/nvim-lsp-installer',
      after = {'nvim-lspconfig', 'cmp-nvim-lsp'},
      requires = {
        'neovim/nvim-lspconfig'
      },
      config = function ()
        require('config.lsp').setup()
      end
    }


    -- TODO插件, 需要安装ripgrep, https://github.com/BurntSushi/ripgrep#installation
    use {
      "folke/todo-comments.nvim",
      -- event = 'BufEnter',
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("config.todo-comment").setup()
      end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
})

