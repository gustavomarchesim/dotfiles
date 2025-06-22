vim.keymap.set("i", "jj", "<ESC>", { noremap = false })

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", opts)
vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", opts)
vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", opts)
vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", opts)
vim.keymap.set("n", "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", opts)
vim.keymap.set("n", "<C-Space>", "<Cmd>NvimTmuxNavigateNext<CR>", opts)

vim.keymap.set("n", "<Tab>", "<Cmd>bnext<CR>", { desc = "Próximo buffer", silent = true })
vim.keymap.set("n", "<S-Tab>", "<Cmd>bprevious<CR>", { desc = "Buffer anterior", silent = true })
