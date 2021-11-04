local M = {}

function M.setup()
  local ok, cmp = pcall(require, "cmp")
  if not ok then
    return
  end

  local has_any_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
      return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
  end

  local press = function(key)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
  end


  -- 弹出框format
  local formatting = {
      format = function(entry, vim_item)
        -- fancy icons and a name of kind
        vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
        -- set a name for each source
        vim_item.menu = ({
          vsnip = "[VSnip]",
          nvim_lsp = "[LSP]",
          buffer = "[Buffer]",
          nvim_lua = "[Lua]",
          cmp_tabnine = "[TabNine]",
          path = "[Path]",
          spell = "[Spell]",
          calc = "[Calc]",
          emoji = "[Emoji]",
          treesitter = "[treesitter]",
        })[entry.source.name]
        return vim_item
      end
  }

  -- 快捷键
  local mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
  }

  -- 指定snippet engine
  local snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
  }

  local sources = {
      { name = "buffer" },
      { name = "nvim_lsp" },
      { name = "vsnip" },
      { name = "path" },
      { name = "emoji" },
      { name = "treesitter" },
      { name = "nvim_lua" },
  }

  local completion = { completeopt = "menu,menuone,noinsert" }

  cmp.setup {
    formatting = formatting,
    mapping = mapping,
    snippet = snippet,
    sources = sources,
    completion = completion,
  }
  
  -- 补全函数后插入()或函数参数
  local pair_ok, pair = pcall(require, 'nvim-autopairs.completion.cmp')
  if not pair_ok then
    return
  end
  cmp.event:on("confirm_done", pair.on_confirm_done { map_char = { tex = "" } })  

end

return M
