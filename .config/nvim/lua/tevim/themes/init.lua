local M = {}

M.getCurrentTheme = function()
	local check1, default_theme = pcall(require, "tevim.themes.schemes." .. vim.g.TeVimTheme)
	local check2, custom_theme = pcall(require, "custom.themes.schemes." .. vim.g.TeVimTheme)
	if check1 then
		local precent = default_theme.type == "light" and -5 or 3
		default_theme.lighter = require("tevim.core.utils").change_hex_lightness(default_theme.background, precent)
		default_theme.darker = require("tevim.core.utils").change_hex_lightness(default_theme.background, -3)
		return default_theme
	elseif check2 then
		local precent = custom_theme.type == "light" and -5 or 3
		custom_theme.lighter = require("tevim.core.utils").change_hex_lightness(custom_theme.background, precent)
		custom_theme.darker = require("tevim.core.utils").change_hex_lightness(custom_theme.background, -3)
		return custom_theme
	end
end

M.loadTb = function(g)
	g = require("tevim.themes.integrations." .. g)
	return g
end

M.loadCustomTb = function(g)
	local check, _ = pcall(require, "custom.themes.integrations")
	g = check and require("custom.themes.integrations") or {}
	return g
end

local merge_tb = function(...)
	return vim.tbl_deep_extend("force", ...)
end

local tableToStr = function(tb)
	local result = ""
	if vim.g.transparency then
		local glassy = require("tevim.themes.transparency")
		for key, value in pairs(glassy) do
			if tb[key] then
				tb[key] = merge_tb(tb[key], value)
			end
		end
	end
	for hlgroupName, hlgroup_vals in pairs(tb) do
		local hlname = "'" .. hlgroupName .. "',"
		local opts = ""
		for optName, optVal in pairs(hlgroup_vals) do
			local valueInStr = ((type(optVal)) == "boolean" or type(optVal) == "number") and tostring(optVal)
				or '"' .. optVal .. '"'
			opts = opts .. optName .. "=" .. valueInStr .. ","
		end
		result = result .. "vim.api.nvim_set_hl(0," .. hlname .. "{" .. opts .. "})"
	end
	return result
end

local toCache = function(filename, tb)
	local lines = "return string.dump(function()" .. tableToStr(tb) .. "end, true)"
	local file = io.open(vim.g.themeCache .. filename, "wb")
	if file then
		---@diagnostic disable-next-line: deprecated
		file:write(loadstring(lines)())
		file:close()
	end
end

local function indexOf(array, value)
	for i, v in ipairs(array) do
		if v == value then
			return i
		end
	end
	return nil
end

local compile = function()
	if not vim.loop.fs_stat(vim.g.themeCache) then
		vim.fn.mkdir(vim.g.themeCache, "p")
	end
	local allThemes = {}
	for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/tevim/themes/integrations")) do
		for k, f in pairs(M.loadTb(vim.fn.fnamemodify(file, ":r"))) do
			allThemes[k] = f
		end
	end
	for k, f in
	pairs(M.loadCustomTb(vim.fn.fnamemodify(vim.fn.stdpath("config") .. "/lua/custom/themes/integrations", ":r")))
	do
		for _, i in pairs(allThemes) do
			if i == f then
				table.remove(allThemes, indexOf(allThemes, i))
				break
			end
		end
		allThemes[k] = f
	end
	toCache("allThemes", allThemes)
end

M.load = function()
	compile()
	dofile(vim.g.themeCache .. "allThemes")
	pcall(function()
		require("ibl").update()
	end)
end

M.setTermColors = function(colors)
	vim.g.terminal_color_0 = colors.base01
	vim.g.terminal_color_1 = colors.base08
	vim.g.terminal_color_2 = colors.base0B
	vim.g.terminal_color_3 = colors.base0A
	vim.g.terminal_color_4 = colors.base0D
	vim.g.terminal_color_5 = colors.base0E
	vim.g.terminal_color_6 = colors.base0C
	vim.g.terminal_color_7 = colors.base05
	vim.g.terminal_color_8 = colors.base03
	vim.g.terminal_color_9 = colors.base08
	vim.g.terminal_color_10 = colors.base0B
	vim.g.terminal_color_11 = colors.base0A
	vim.g.terminal_color_12 = colors.base0D
	vim.g.terminal_color_13 = colors.base0E
	vim.g.terminal_color_14 = colors.base0C
	vim.g.terminal_color_15 = colors.base07
end

return M
