-- This file can be loaded by calling `lua require('plugins')` from your init.vim

return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

    use 'nvim-lua/plenary.nvim'



    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use {
        "hrsh7th/nvim-compe"
    }

    use {
        "neovim/nvim-lspconfig",
    }

    use {
        "kabouzeid/nvim-lspinstall",
    }

    use {
        "onsails/lspkind-nvim",
    }

    use {
        "terrortylor/nvim-comment",
    }



	-- norg
	use { 
		"vhyrro/neorg",
		requires = "nvim-lua/plenary.nvim"
	}



    use {
        'kyazdani42/nvim-web-devicons'
    }

    use {
        'akinsho/nvim-bufferline.lua', 
        requires = 'kyazdani42/nvim-web-devicons'
    }

    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    use {
        "lukas-reineke/indent-blankline.nvim"
    }

    use {
        'windwp/nvim-autopairs'
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }

    use {
        'navarasu/onedark.nvim'
    }

    -- markdown preview, 建议手动安装命令行的glow后再安装该插件, 而不是用内置的GlowInstall命令安装
    use {
        "npxbr/glow.nvim", 
    }

end)
