return {
  {
    "ahmedkhalf/project.nvim",
    event = function()
      return {}
    end,
  },
  {
    "echasnovski/mini.ai",
    event = function()
      return { "BufReadPre", "BufNewFile" }
    end,
  },
  {
    "echasnovski/mini.pairs",
    event = function()
      return { "BufReadPre", "BufNewFile" }
    end,
  },
  {
    "echasnovski/mini.comment",
    event = function()
      return { "BufReadPre", "BufNewFile" }
    end,
  },
  {
    "williamboman/mason.nvim",
    keys = function()
      return {}
    end,
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        diagnostics = false,
      },
    },
  },
}
