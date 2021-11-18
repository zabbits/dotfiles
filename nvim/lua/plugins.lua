-- this file can be loaded by calling `lua require('plugins')` from your init.vim
-- packer logs in stdpath(cache)/packer.nvim.log

return require('packer').startup({
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    -- color highlight
    use {
      'norcalli/nvim-colorizer.lua',
      event = 'BufEnter',
      config = function() 
        require'colorizer'.setup({
        })
      end
    }

    use {
      'folke/tokyonight.nvim',
      event = 'BufEnter',
      config = function()
        vim.cmd[[colorscheme tokyonight]]
      end
    }

    use {
      'ms-jpq/chadtree',
      branch = 'chad',
      run = 'python3 -m chadtree deps',
    }


    -- 补全
    use {
      'hrsh7th/vim-vsnip',
      event = 'BufEnter',
    }
    use { 
      'hrsh7th/nvim-cmp',
      after = 'vim-vsnip',
      config = function()
        require('config.completion').setup()
      end
    }
    use {
      'hrsh7th/cmp-vsnip',
      after = 'nvim-cmp',
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


  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
})

