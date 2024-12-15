local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

return {
	-- For ibl version
	IblScope = { fg = utils.blend(colors.foreground, colors.background, 0.03) },
	IblIndent = { fg = utils.blend(colors.foreground, colors.background, 0.03) },
	IblWhitespace = { fg = utils.blend(colors.foreground, colors.background, 0.03) },
	["@ibl.scope.underline.1"] = { fg = utils.blend(colors.foreground, colors.background, 0.03) },

	-- Mini Indent (mini.nvim)
	MiniIndentscopeSymbol = { fg = utils.blend(colors.foreground, colors.background, 0.1) },
}
