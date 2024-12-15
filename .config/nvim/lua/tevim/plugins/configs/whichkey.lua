return {
	preset = "classic",
	delay = function(ctx)
		return ctx.plugin and 0 or 200
	end,
	filter = function(mapping)
		return true
	end,
	spec = {},
	notify = false,
	triggers = { { "<auto>", mode = "nixsotc" } },
	defer = function(ctx)
		return ctx.mode == "V" or ctx.mode == "<C-V>"
	end,
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		presets = {
			operators = true, -- adds help for operators like d, y, ...
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true,   -- bindings for folds, spelling and others prefixed with z
			g = true,   -- bindings for prefixed with g
		},
	},
	win = {
		no_overlap = true,
		height = { min = 3, max = 20 },
		border = "none",
		padding = { 1, 1 },
	},
	layout = {
		width = { min = 20, max = 50 },
		spacing = 15,
	},
	keys = {
		scroll_down = "<c-d>",
		scroll_up = "<c-u>",
	},
	sort = { "local", "order", "group", "alphanum", "mod" },
	expand = 0,
	icons = {
		breadcrumb = "",
		separator = "",
		group = " ",
		ellipsis = "…",
		mappings = true,
		rules = {},
		colors = true,
		keys = {
			Up = " ",
			Down = " ",
			Left = " ",
			Right = " ",
			C = "󰘴 ",
			M = "󰘵 ",
			D = "󰘳 ",
			S = "󰘶 ",
			CR = "󰌑 ",
			Esc = "󱊷 ",
			ScrollWheelDown = "󱕐 ",
			ScrollWheelUp = "󱕑 ",
			NL = "󰌑 ",
			BS = "󰁮",
			Space = "󱁐 ",
			Tab = "󰌒 ",
			F1 = "󱊫",
			F2 = "󱊬",
			F3 = "󱊭",
			F4 = "󱊮",
			F5 = "󱊯",
			F6 = "󱊰",
			F7 = "󱊱",
			F8 = "󱊲",
			F9 = "󱊳",
			F10 = "󱊴",
			F11 = "󱊵",
			F12 = "󱊶",
		},
	},
	show_help = true,
	show_keys = false,
	disable = {
		ft = {},
		bt = {},
	},
	debug = false,
}
