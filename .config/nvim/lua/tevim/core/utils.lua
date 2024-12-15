local M = {}

function M.is_available(plugin)
	local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
	return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

function M.replaceword(middle, old, new, file)
	local lines = vim.fn.readfile(file)
	local new_lines = {}
	local found = false
	for _, line in ipairs(lines) do
		if line:find(middle) then
			if line:find(old) then
				table.insert(new_lines, middle .. " = " .. new)
			else
				table.insert(new_lines, middle .. " = " .. old)
			end
			found = true
		else
			table.insert(new_lines, line)
		end
	end
	if not found then
		table.insert(new_lines, middle .. " = " .. new)
	end
	vim.fn.writefile(new_lines, file)
end

function M.toggle_option(option)
	local value = not vim.api.nvim_get_option_value(option, {})
	vim.opt[option] = value
	M.replaceword(
		"vim.opt." .. option,
		tostring(not value),
		tostring(value),
		vim.fn.stdpath("config") .. "/lua/custom/options.lua"
	)
	vim.notify(option .. " set to " .. tostring(value))
end

function M.build_run()
	local filetype = vim.bo.filetype
	if filetype == "c" then
		vim.cmd(
			"TermExec cmd='gcc "
			.. vim.fn.expand("%")
			.. " -o "
			.. vim.fn.expand("%:r")
			.. " && "
			.. vim.fn.expand("%:r")
			.. "'"
		)
	elseif filetype == "cpp" then
		vim.cmd(
			"TermExec cmd='g++ "
			.. vim.fn.expand("%")
			.. " -o "
			.. vim.fn.expand("%:r")
			.. " && "
			.. vim.fn.expand("%:r")
			.. "'"
		)
	elseif filetype == "python" then
		vim.cmd("TermExec cmd='python3 " .. vim.fn.expand("%") .. "'")
	elseif filetype == "javascript" then
		vim.cmd("TermExec cmd='node " .. vim.fn.expand("%") .. "'")
	elseif filetype == "typescript" then
		vim.cmd("TermExec cmd='ts-node " .. vim.fn.expand("%") .. "'")
	elseif filetype == "php" then
		vim.cmd("TermExec cmd='php " .. vim.fn.expand("%") .. "'")
	elseif filetype == "java" then
		vim.cmd("TermExec cmd='javac " .. vim.fn.expand("%") .. " && java " .. vim.fn.expand("%:r") .. "'")
	elseif filetype == "cs" then
		vim.cmd("TermExec cmd='mcs " .. vim.fn.expand("%") .. "'")
	elseif filetype == "rust" then
		vim.cmd("TermExec cmd='cargo run'")
	elseif filetype == "go" then
		vim.cmd("TermExec cmd='go run " .. vim.fn.expand("%") .. "'")
	elseif filetype == "lua" then
		vim.cmd("TermExec cmd='lua " .. vim.fn.expand("%") .. "'")
	elseif filetype == "sh" then
		vim.cmd("TermExec cmd='bash " .. vim.fn.expand("%") .. "'")
	elseif filetype == "dart" then
		vim.cmd("TermExec cmd='dart " .. vim.fn.expand("%") .. "'")
	elseif not M.is_available("markdown-preview.nvim") and filetype == "markdown" then
		vim.notify("You can install plugins support for markdown like markdown-preview.nvim ^^")
	elseif filetype == "html" and vim.fn.executable("live-server") ~= 1 then
		vim.notify("You can install live-server by npm ^^")
	elseif filetype == "html" then
		vim.cmd("TermExec cmd='live-server " .. vim.fn.expand("%:p:h") .. "'")
	elseif filetype == "markdown" then
		vim.cmd("MarkdownPreview")
	end
end

function M.LazyGit()
	local status_ok, _ = pcall(require, "toggleterm")
	if not status_ok then
		return vim.notify("toggleterm.nvim isn't installed!")
	end
	if vim.fn.executable("lazygit") == 0 then
		return vim.notify("lazygit isn't installed")
	end
	local lazygit = require("toggleterm.terminal").Terminal:new({
		cmd = "lazygit",
		dir = "git_dir",
		direction = "float",
		on_open = function(term)
			vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
		end,
	})
	lazygit:toggle()
end

function M.Ranger()
	local status_ok, _ = pcall(require, "toggleterm")
	if not status_ok then
		return vim.notify("toggleterm.nvim isn't installed!")
	end
	if vim.fn.executable("ranger") == 0 then
		return vim.notify("ranger isn't installed")
	end
	local ranger = require("toggleterm.terminal").Terminal:new({
		cmd = "ranger",
		direction = "float",
		on_open = function(term)
			vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
		end,
	})
	ranger:toggle()
end

M.checkMason = function()
	local status_ok, _ = pcall(require, "mason")
	if not status_ok then
		return vim.notify("mason.nvim isn't installed!")
	end
	local mason_packages = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/*", 0, 1)
	local mason_installed = {}
	for _, package in ipairs(mason_packages) do
		table.insert(mason_installed, vim.fn.fnamemodify(package, ":t"))
	end
	local ensure_installed = require("custom.configs.overrides").mason.ensure_installed
	local default_mason = { "lua-language-server", "stylua" }
	for _, package in ipairs(default_mason) do
		table.insert(ensure_installed, package)
	end
	local missing = {}
	for _, package in ipairs(ensure_installed) do
		if not vim.tbl_contains(mason_installed, package) then
			table.insert(missing, package)
		end
	end
	local remove = {}
	for _, package in ipairs(mason_installed) do
		if not vim.tbl_contains(ensure_installed, package) then
			table.insert(remove, package)
		end
	end
	if #remove > 0 then
		vim.cmd("MasonUninstall " .. table.concat(remove, " "))
		vim.notify("Uninstalled " .. table.concat(remove, ", "))
	end
	if #missing > 0 then
		vim.cmd("MasonInstall " .. table.concat(missing, " "))
	end
	if #missing == 0 and #remove == 0 then
		vim.notify("Nothing to install or uninstall")
	end
end

M.CreateCustom = function()
	local path = vim.fn.stdpath("config") .. "/lua/custom"
	if vim.fn.isdirectory(path) ~= 1 then
		vim.fn.mkdir(path, "p")
		io.open(path .. "/init.lua", "w"):write(
			'require("custom.keymaps")\nrequire("custom.options")'
		)
		io.open(path .. "/plugins.lua", "w"):write(
			'local overrides = require("custom.configs.overrides")\n\nreturn {\n\t-- add plugins or override my plugins in here\n}'
		)
		io.open(path .. "/options.lua", "w"):write("-- add options or override my options in here")
		io.open(path .. "/keymaps.lua", "w"):write("-- add your custom keymaps in here")
		vim.fn.mkdir(path .. "/configs", "p")
		io.open(path .. "/configs/overrides.lua", "w"):write(
			"local M = {}\n\n-- add overrides in here(eg: mason.nvim)\nM.mason = {\n\tensure_installed = {}\n}\n\nreturn M"
		)
		vim.fn.mkdir(path .. "/themes/schemes", "p")
		io.open(path .. "/themes/integrations.lua", "w"):write(
			'local colors = require("tevim.themes").getCurrentTheme()\n\nreturn {\n\t-- add your custom highlights in here\n}'
		)
		vim.notify("Created custom folder. Please read the docs!")
	end
end

M.TeVimUpdate = function()
	local output = vim.fn.system("git -C " .. vim.fn.stdpath("config") .. " pull")
	if output == "Already up to date.\n" then
		vim.notify("Nothing to update!")
	else
		vim.notify("TeVim updated! Please restart Neovim! If you have any problem, please report to me!")
	end
end

------------------------------------ FOR THEMES ------------------------------------------
-- Thanks NvChad for this function

local hex2rgb = function(hex)
	local hash = string.sub(hex, 1, 1) == "#"
	if string.len(hex) ~= (7 - (hash and 0 or 1)) then
		return nil
	end

	local r = tonumber(hex:sub(2 - (hash and 0 or 1), 3 - (hash and 0 or 1)), 16)
	local g = tonumber(hex:sub(4 - (hash and 0 or 1), 5 - (hash and 0 or 1)), 16)
	local b = tonumber(hex:sub(6 - (hash and 0 or 1), 7 - (hash and 0 or 1)), 16)
	return r, g, b
end

local rgb2hex = function(r, g, b)
	return string.format("#%02x%02x%02x", math.floor(r), math.floor(g), math.floor(b))
end

local hsl2rgb_helper = function(p, q, a)
	if a < 0 then
		a = a + 6
	end
	if a >= 6 then
		a = a - 6
	end
	if a < 1 then
		return (q - p) * a + p
	elseif a < 3 then
		return q
	elseif a < 4 then
		return (q - p) * (4 - a) + p
	else
		return p
	end
end

local hsl2rgb = function(h, s, l)
	local t1, t2, r, g, b

	h = h / 60
	if l <= 0.5 then
		t2 = l * (s + 1)
	else
		t2 = l + s - (l * s)
	end

	t1 = l * 2 - t2
	r = hsl2rgb_helper(t1, t2, h + 2) * 255
	g = hsl2rgb_helper(t1, t2, h) * 255
	b = hsl2rgb_helper(t1, t2, h - 2) * 255

	return r, g, b
end

local rgb2hsl = function(r, g, b)
	local min, max, l, s, maxcolor, h
	r, g, b = r / 255, g / 255, b / 255

	min = math.min(r, g, b)
	max = math.max(r, g, b)
	maxcolor = 1 + (max == b and 2 or (max == g and 1 or 0))

	if maxcolor == 1 then
		h = (g - b) / (max - min)
	elseif maxcolor == 2 then
		h = 2 + (b - r) / (max - min)
	elseif maxcolor == 3 then
		h = 4 + (r - g) / (max - min)
	end

	if not rawequal(type(h), "number") then
		h = 0
	end

	h = h * 60

	if h < 0 then
		h = h + 360
	end

	l = (min + max) / 2

	if min == max then
		s = 0
	else
		if l < 0.5 then
			s = (max - min) / (max + min)
		else
			s = (max - min) / (2 - max - min)
		end
	end

	return h, s, l
end

local hex2hsl = function(hex)
	local r, g, b = hex2rgb(hex)
	return rgb2hsl(r, g, b)
end

local hsl2hex = function(h, s, l)
	local r, g, b = hsl2rgb(h, s, l)
	return rgb2hex(r, g, b)
end

-- Change the hue of a color by a given amount
-- @param hex The hex color value
-- @param amount The amount to change the hue.
--               Negative values decrease the hue, positive values increase it.
-- @return The hex color value
M.change_hex_hue = function(hex, percent)
	local h, s, l = M.hex2hsl(hex)
	h = h + (percent / 100)
	if h > 360 then
		h = 360
	end
	if h < 0 then
		h = 0
	end
	return M.hsl2hex(h, s, l)
end

-- Desaturate or saturate a color by a given percentage
-- @param hex The hex color value
-- @param percent The percentage to desaturate or saturate the color.
--                Negative values desaturate the color, positive values saturate it
-- @return The hex color value
M.change_hex_saturation = function(hex, percent)
	local h, s, l = hex2hsl(hex)
	s = s + (percent / 100)
	if s > 1 then
		s = 1
	end
	if s < 0 then
		s = 0
	end
	return hsl2hex(h, s, l)
end

-- Lighten or darken a color by a given percentage
-- @param hex The hex color value
-- @param percent The percentage to lighten or darken the color.
--                Negative values darken the color, positive values lighten it
-- @return The hex color value
M.change_hex_lightness = function(hex, percent)
	local h, s, l = hex2hsl(hex)
	l = l + (percent / 100)
	if l > 1 then
		l = 1
	end
	if l < 0 then
		l = 0
	end
	return hsl2hex(h, s, l)
end

M.blend = function(foreground, background, alpha)
	local function hexToRgb(c)
		c = string.lower(c)
		return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
	end
	alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
	local bg = hexToRgb(background)
	local fg = hexToRgb(foreground)
	local blendChannel = function(i)
		local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end

	return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

M.mix = function(c1, c2, wt)
	local r1 = tonumber(string.sub(c1, 2, 3), 16)
	local g1 = tonumber(string.sub(c1, 4, 5), 16)
	local b1 = tonumber(string.sub(c1, 6, 7), 16)

	local r2 = tonumber(string.sub(c2, 2, 3), 16)
	local g2 = tonumber(string.sub(c2, 4, 5), 16)
	local b2 = tonumber(string.sub(c2, 6, 7), 16)

	wt = math.min(1, math.max(0, wt))

	local nr = math.floor((1 - wt) * r1 + wt * r2)
	local ng = math.floor((1 - wt) * g1 + wt * g2)
	local nb = math.floor((1 - wt) * b1 + wt * b2)

	return string.format("#%02X%02X%02X", nr, ng, nb)
end

return M
