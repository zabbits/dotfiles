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

    use {
      'ms-jpq/coq_nvim',
      event = 'BufEnter',
      branch = 'coq',
    }

    use {
      'ms-jpq/coq.artifacts',
      event = 'BufEnter',
      branch = 'artifacts',
    }

    use {
      'ms-jpq/coq.thirdparty',
      event = 'BufEnter',
      branch = '3p'
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

