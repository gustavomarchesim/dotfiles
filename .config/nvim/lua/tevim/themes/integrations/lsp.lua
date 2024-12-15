local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

return {
	LspReferenceText = { fg = colors.darker, bg = colors.foreground },
	LspReferenceRead = { fg = colors.darker, bg = colors.foreground },
	LspReferenceWrite = { fg = colors.darker, bg = colors.foreground },

	DiagnosticError = { fg = colors.red },
	DiagnosticWarn = { fg = utils.mix(colors.red, colors.green, 0.5) },
	DiagnosticInfo = { fg = colors.blue },
	DiagnosticHint = { fg = utils.mix(colors.red, colors.blue, 0.5) },

	LspInlayHint = { fg = utils.blend(colors.foreground, colors.background, 0.25), bg = utils.blend(colors.background, colors.foreground, 0.95) },
	LspSignatureActiveParameter = { fg = colors.background, bg = colors.blue },

	SymbolUsageText = { fg = utils.blend(colors.foreground, colors.background, 0.4), italic = true },
}
