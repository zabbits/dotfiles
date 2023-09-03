-- AstroCore provides a central place to modify mappings set up as well as which-key menu titles
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs with `H` and `L`
        L = {
          "<cmd>bn<cr>",
          desc = "Next buffer",
        },
        H = {
          "<cmd>bp<cr>",
          desc = "Previous buffer",
        },
        ["<leader>L"] = {
          "<cmd>Lazy<cr>",
          desc = "󰒲 Lazy",
        },
        ["<leader>M"] = {
          "<cmd>Mason<cr>",
          desc = " Mason",
        },

        -- session
        ["<leader>s"] = { desc = "Session" },
        ["<Leader>sl"] = { function() require("resession").load "Last Session" end, desc = "Load last session" },
        ["<Leader>ss"] = { function() require("resession").save() end, desc = "Save this session" },
        ["<Leader>st"] = { function() require("resession").save_tab() end, desc = "Save this tab's session" },
        ["<Leader>sd"] = { function() require("resession").delete() end, desc = "Delete a session" },
        ["<Leader>sf"] = { function() require("resession").load() end, desc = "Load a session" },
        ["<Leader>s."] = {
          function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
          desc = "Load current directory session",
        },
        -- for telescope find session
        ["<Leader>fs"] = { function() require("resession").load() end, desc = "Load a session" },

        -- disable astro session keys
        ["<leader>S"] = false,
        ["<Leader>Sl"] = false,
        ["<Leader>Ss"] = false,
        ["<Leader>St"] = false,
        ["<Leader>Sd"] = false,
        ["<Leader>Sf"] = false,
        ["<Leader>S."] = false,
      },
    },
  },
}
