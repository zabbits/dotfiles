return {
  'cryptomilk/nightcity.nvim',
  config = function()
	  require("nightcity").setup({})
	  vim.cmd.colorscheme("nightcity")
  end
}
