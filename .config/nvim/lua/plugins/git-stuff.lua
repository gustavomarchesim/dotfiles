return {
	{
		"tpope/vim-fugitive",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					delete = { text = "󰍵" },
					changedelete = { text = "󱕖" },
				},
			})
		end,
	},
}
