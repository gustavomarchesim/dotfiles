return {
	"marko-cerovac/material.nvim",
	lazy = false,
	name = "material",
	priority = 1000,
	config = function()
		vim.g.material_style = "darker"
		vim.cmd.colorscheme("material")
		require("material").setup({
			lualine_style = "default",
		})
	end,
}
