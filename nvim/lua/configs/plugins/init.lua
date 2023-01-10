return {
  -- Lua functions
  { "nvim-lua/plenary.nvim" },

  -- Neovim UI Enhancer
  {
    "MunifTanjim/nui.nvim",
  },

  -- Better buffer closing
  {
    "famiu/bufdelete.nvim",
    cmd = 'Bdelete',
  },


  -- ====================
  --         LSP
  -- ====================

  -- lsp diagnostic
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      vim.diagnostic.config({ virtual_lines = false })
      require("lsp_lines").setup()
    end,
  },


  -- lsp loading info
  {
    'j-hui/fidget.nvim',
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
    dependencies = {'nvim-lspconfig'},
    enabled = false,
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

  -- Get extra JSON schemas
  {
    "b0o/SchemaStore.nvim",
    event = { "BufRead", "BufNewFile" },
  },

  -- better marks
  {
    'chentoast/marks.nvim',
    event = { "BufRead", "BufNewFile" },
    config = function()
      require('marks').setup({})
    end
  },

  -- ====================
  --    Window manager
  -- ====================
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

  -- yank did not work
  {
    'in-a-day/nvim-osc52',
    keys = "<leader>y",
  },

  -- undo tree
  {
    'mbbill/undotree',
    enabled = false,
    event = { "BufRead", "BufNewFile" },
  }
}
