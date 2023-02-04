return {
  'jedrzejboczar/possession.nvim',
  dependencies = { 'telescope.nvim' },
  opts = {
    autosave = {
      current = false,
      tmp = true,
      on_load = false,
      on_quit = true,
    },
    plugins = {
      nvim_tree = false,
      tabby = false,
    }
  },
  config = function(_, opts)
    require('possession').setup(opts)
    require('telescope').load_extension('possession')
  end
}
