local M = {}

function M.config()
  local utils = require("core.utils")
  local alpha = utils.safe_require('alpha')
  if not alpha then
    return
  end
  local dashboard = require('alpha.themes.dashboard')

  local headers = require('configs.alpha-header').ascii_art

  local leader = '<space>'

  local function button(sc, txt)
    local opts = {
      position = 'center',
      shortcut = sc,
      cursor = 5,
      width = 50,
      align_shortcut = 'right',
      hl_shortcut = 'Keyword',
    }

    return {
      type = 'button',
      val = txt,
      -- on_press = on_press,
      opts = opts,
    }
  end

  math.randomseed(os.time())
  dashboard.section.header.val = headers[math.random(1, #headers)]

  dashboard.section.buttons.val = {
    dashboard.button('  e', 'ﱐ  New file', ':ene <BAR> startinsert <CR>'),
    dashboard.button('  f', '  Find files', ':lua require("telescope.builtin").find_files() <CR>'),
    dashboard.button('  o', '  Find old files', ':lua require("telescope.builtin").oldfiles() <CR>'),
    dashboard.button('  w', 'ﭨ  Live grep', ':lua require("telescope.builtin").live_grep() <CR>'),
    dashboard.button('  p', '  Find Projects', ':lua require("telescope._extensions").manager.projects.projects() <CR>'),
    dashboard.button('  c', '  Configurations', ':lua require("telescope.builtin").find_files({cwd="$HOME/.config/nvim/"}) <CR>'),
    dashboard.button('  s', '  Sync plugins', ':PackerSync <CR>'),
    dashboard.button('  q', '  Quit', ':qa <CR>')
  }

  -- Foot must be a table so that its height is correctly measured
  local num_plugins_loaded = #vim.fn.globpath(vim.fn.stdpath('data') .. '/site/pack/packer/start', '*', 0, 1)
  local num_plugins_tot = #vim.tbl_keys(packer_plugins)
  if num_plugins_tot <= 1 then
    dashboard.section.footer.val = { num_plugins_loaded .. ' / ' .. num_plugins_tot .. ' plugin ﮣ loaded' }
  else
    dashboard.section.footer.val = { num_plugins_loaded .. ' / ' .. num_plugins_tot .. ' plugins ﮣ loaded' }
  end
  dashboard.section.footer.opts.hl = 'Comment'


  -- ┌──────────────────────────────────────────────────────────┐
  -- │                  /                                       │
  -- │    header_padding                                        │
  -- │                  \  ┌──────────────┐ ____                │
  -- │                     │    header    │     \               │
  -- │                  /  └──────────────┘      \              │
  -- │ head_butt_padding                          \             │
  -- │                  \                          occu_        │
  -- │                  ┌────────────────────┐     height       │
  -- │                  │       button       │    /             │
  -- │                  │       button       │   /              │
  -- │                  │       button       │  /               │
  -- │                  └────────────────────┘‾‾                │
  -- │                  /                                       │
  -- │ foot_butt_padding                                        │
  -- │                  \  ┌──────────────┐                     │
  -- │                     │    footer    │                     │
  -- │                     └──────────────┘                     │
  -- │                                                          │
  -- └──────────────────────────────────────────────────────────┘

  local head_butt_padding = 4
  local occu_height = #dashboard.section.header.val + 2 * #dashboard.section.buttons.val + head_butt_padding
  local header_padding = math.max(0, math.ceil((vim.fn.winheight('$') - occu_height) * 0.25))
  local foot_butt_padding_ub = vim.o.lines - header_padding - occu_height - #dashboard.section.footer.val - 3
  local foot_butt_padding = math.floor((vim.fn.winheight('$') - 2 * header_padding - occu_height))
  foot_butt_padding = math.max(0, math.max(math.min(0, foot_butt_padding), math.min(math.max(0, foot_butt_padding), foot_butt_padding_ub)))

  dashboard.config.layout = {
    { type = 'padding', val = header_padding },
    dashboard.section.header,
    { type = 'padding', val = head_butt_padding },
    dashboard.section.buttons,
    { type = 'padding', val = foot_butt_padding },
    dashboard.section.footer
  }

  alpha.setup(dashboard.opts)
end

return M
