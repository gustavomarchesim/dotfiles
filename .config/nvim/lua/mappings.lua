require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true })
map("n", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true })
map("n", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true })
map("n", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true })
map("n", "<C-\\>", ":TmuxNavigatePrevious<CR>", { silent = true })
map("n", "<leader>lt", function()
  require("live-server-nvim").toggle()
end, { desc = "Toggle Live Server" })
map("n", "<leader>fs", "<cmd>Telescope file_browser<CR>", { desc = "Telescope file browser" })
