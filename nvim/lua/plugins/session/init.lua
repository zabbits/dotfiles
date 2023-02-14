return {
	"jedrzejboczar/possession.nvim",
	dependencies = { "telescope.nvim" },
	opts = {
		plugins = {
      close_windows = false,
      delete_hidden_buffers = false,
			nvim_tree = false,
			tabby = false,
		},
	},
	config = function(_, opts)
		require("possession").setup(opts)
		require("telescope").load_extension("possession")
	end,
}
