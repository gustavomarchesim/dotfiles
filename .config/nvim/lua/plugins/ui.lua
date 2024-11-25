return {
	{
		"nvchad/ui",
		lazy = false,
		priority = 1000,
		config = function()
			require("nvchad")
		end,
	},

	{
		"nvchad/base46",
		lazy = false,
		priority = 1000,
		build = function()
			require("base46").load_all_highlights()
		end,
	},
	{
		"nvchad/volt",
	},
}
