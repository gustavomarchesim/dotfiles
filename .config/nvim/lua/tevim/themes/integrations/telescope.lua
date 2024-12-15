local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

return {
	TelescopeNormal = { bg = colors.darker },
	TelescopeBorder = { fg = colors.darker, bg = colors.darker },

	TelescopePromptTitle = { fg = colors.background, bg = colors.red },
	TelescopePromptBorder = { fg = colors.lighter, bg = colors.lighter },
	TelescopePromptNormal = { fg = colors.foreground, bg = colors.lighter },

	TelescopePreviewTitle = { fg = colors.background, bg = colors.blue },
	TelescopePreviewBorder = { bg = colors.darker, fg = colors.darker },

	TelescopeResultsTitle = { fg = colors.background, bg = colors.green },
	TelescopeResultsBorder = { bg = colors.darker, fg = colors.darker },

	TelescopeMatching = { bold = true },
	TelescopeSelection = { bg = colors.lighter, fg = colors.blue, bold = true },
	TelescopeResultsDiffAdd = { fg = colors.green },
	TelescopeResultsDiffChange = { fg = colors.blue },
	TelescopeResultsDiffDelete = { fg = colors.red },
}
