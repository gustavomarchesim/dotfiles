require "nvchad.mappings"

local map = vim.keymap.set
local opts = {
  noremap = true, -- non-recursive
  silent = true, -- do not show message
}

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<C-h>", ":TmuxNavigateLeft<CR>", opts)
map("n", "<C-j>", ":TmuxNavigateDown<CR>", opts)
map("n", "<C-k>", ":TmuxNavigateUp<CR>", opts)
map("n", "<C-l>", ":TmuxNavigateRight<CR>", opts)
map("n", "<C-\\>", ":TmuxNavigatePrevious<CR>", opts)

map("n", "<leader>lt", function()
  require("live-server-nvim").toggle()
end, { desc = "Toggle Live Server" })

map("n", "<left>", '<cmd>echo "Use h para se mover!"<CR>')
map("n", "<right>", '<cmd>echo "Use l para se mover!"<CR>')
map("n", "<up>", '<cmd>echo "Use k  para se mover!!!"<CR>')
map("n", "<down>", '<cmd>echo "Use j para se mover!!"<CR>')

map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>")
map("n", "<leader>gc", ":Gitsigns toggle_current_line_blame<CR>")
