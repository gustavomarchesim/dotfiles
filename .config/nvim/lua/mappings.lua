require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "kj", "<ESC>")

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move Lines
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Editing Keymaps
map("n", "<leader>q", ":q<cr>", { desc = "Quit File", noremap = true, silent = true })
map("n", "<leader>w", ":w<cr>", { desc = "Write File", noremap = true, silent = true })

-- Splits and Panes
map("n", "<leader>pv", "<C-w>v", { desc = "Split Vertically", noremap = true, silent = false })
map("n", "<leader>ph", "<C-w>s", { desc = "Split Horizontally", noremap = true, silent = false })
map("n", "<leader>pe", "<C-w>=", { desc = "Equal Split", noremap = true, silent = false })
map("n", "<leader>px", ":close<CR>", { desc = "Close split", noremap = true, silent = false })
map("n", "<leader>po", ":only<CR>", { desc = "Single Pane", noremap = true, silent = false })

-- Telescope
map("n", "<C-p>", ":Telescope find_files<cr>", { desc = "Fuzzy Find", noremap = true, silent = true })
