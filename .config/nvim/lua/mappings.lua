local map = vim.keymap.set

-- Comandos gerais no modo normal
map("n", ";", ":", { desc = "Enter command mode (CMD)" })
map({ "n", "v" }, "H", "^", { desc = "Move to start of line" })
map({ "n", "v" }, "L", "$", { desc = "Move to end of line" })
map({ "i", "v" }, "jk", "<ESC>", { desc = "Exit insert/visual mode" })
map("n", "<C-a>", "ggVG", { desc = "Select entire file" })

-- Movimentos do cursor no modo de inserção
map("i", "<C-h>", "<Left>", { desc = "Move cursor left" })
map("i", "<C-l>", "<Right>", { desc = "Move cursor right" })
map("i", "<C-j>", "<Down>", { desc = "Move cursor down" })
map("i", "<C-k>", "<Up>", { desc = "Move cursor up" })

-- Navegação entre janelas no modo normal
map("n", "<C-h>", "<C-w>h", { desc = "Focus window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus window below" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus window above" })

-- Salvar arquivo
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save current file" })

-- Comentários no modo normal e visual
map("n", "<leader>/", "gcc", { desc = "Toggle line comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle selection comment", remap = true })

-- Gerenciamento de arquivos com NvimTree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Focus on NvimTree window" })

-- Gerenciamento de buffers
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "Create a new buffer" })
map("n", "<tab>", function()
	require("nvchad.tabufline").next()
end, { desc = "Switch to next buffer" })
map("n", "<S-tab>", function()
	require("nvchad.tabufline").prev()
end, { desc = "Switch to previous buffer" })
map("n", "<leader>x", function()
	require("nvchad.tabufline").close_buffer()
end, { desc = "Close current buffer" })

-- Abrir terminais novos
map("n", "<leader>h", function()
	require("nvchad.term").new({ pos = "sp" })
end, { desc = "Open horizontal terminal" })
map("n", "<leader>v", function()
	require("nvchad.term").new({ pos = "vsp" })
end, { desc = "Open vertical terminal" })

-- Alternar entre terminais
map({ "n", "t" }, "<A-v>", function()
	require("nvchad.term").toggle({ pos = "vsp", id = "vtoggleTerm" })
end, { desc = "Toggle vertical terminal" })
map({ "n", "t" }, "<A-h>", function()
	require("nvchad.term").toggle({ pos = "sp", id = "htoggleTerm" })
end, { desc = "Toggle horizontal terminal" })
map({ "n", "t" }, "<A-i>", function()
	require("nvchad.term").toggle({ pos = "float", id = "floatTerm" })
end, { desc = "Toggle floating terminal" })

-- Navegação Tmux
map("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "Move to Tmux pane (left)", silent = true })
map("n", "<C-j>", ":TmuxNavigateDown<CR>", { desc = "Move to Tmux pane (down)", silent = true })
map("n", "<C-k>", ":TmuxNavigateUp<CR>", { desc = "Move to Tmux pane (up)", silent = true })
map("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "Move to Tmux pane (right)", silent = true })
map("n", "<C-\\>", ":TmuxNavigatePrevious<CR>", { desc = "Move to previous Tmux pane", silent = true })

-- Gitsigns
map("n", "<leader>gp", function()
	require("gitsigns").preview_hunk()
end, { desc = "Git: Preview hunk" })
map("n", "<leader>gb", function()
	require("gitsigns").toggle_current_line_blame()
end, { desc = "Git: Toggle inline blame" })

-- Mapeamentos para Yazi
map("n", "<leader>yf", "<cmd>Yazi<cr>", { desc = "Open yazi at current file" })
map("n", "<leader>yw", "<cmd>Yazi cwd<cr>", { desc = "Open Yazi in working directory" })
map("n", "<c-up>", "<cmd>Yazi toggle<cr>", { desc = "Resume last Yazi session" })

-- LSP: Mapeamentos
map("n", "K", vim.lsp.buf.hover, { desc = "Show hover information" })
map("n", "<leader>cd", vim.lsp.buf.definition, { desc = "Go to code definition" })
map("n", "<leader>cr", vim.lsp.buf.references, { desc = "Go to code references" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions" })

-- LazyGit
map("n", "<leader>gl", "<cmd>LazyGit<cr>", { desc = "Git: Open LazyGit" })

-- Aviso ao usar teclas de seta no modo normal
map("n", "<Up>", function()
	vim.cmd("echo 'Use as teclas h, j, k, l para navegar!'")
end, { desc = "Warn to use hjkl instead of Up arrow" })

map("n", "<Down>", function()
	vim.cmd("echo 'Use as teclas h, j, k, l para navegar!'")
end, { desc = "Warn to use hjkl instead of Down arrow" })

map("n", "<Left>", function()
	vim.cmd("echo 'Use as teclas h, j, k, l para navegar!'")
end, { desc = "Warn to use hjkl instead of Left arrow" })

map("n", "<Right>", function()
	vim.cmd("echo 'Use as teclas h, j, k, l para navegar!'")
end, { desc = "Warn to use hjkl instead of Right arrow" })
