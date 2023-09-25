require("lazy").setup({
	{
		import = "plugins.base",
	},
	{
		import = "plugins.extra",
	}
}, {
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "kanagawa" },

  },

})
