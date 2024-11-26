local map = vim.keymap.set

-- Função auxiliar para as opções
local function opts(desc)
	return { desc = "LSP " .. desc }
end

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
map("n", "<leader>h", ":sp<CR>", { desc = "Split terminal horizontally" })
map("n", "<leader>v", ":vsp<CR>", { desc = "Split terminal vertically" })

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

map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
map("n", "<leader>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts("List workspace folders"))
map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
map("n", "<leader>ra", vim.lsp.buf.rename, opts("Rename"))
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
map("n", "gr", vim.lsp.buf.references, opts("Show references"))

-- LazyGit
map("n", "<leader>gl", "<cmd>LazyGit<cr>", { desc = "Git: Open LazyGit" })

-- Aviso ao usar teclas de seta no modo normal
map({ "n", "i", "v" }, "<Up>", function()
	vim.cmd("echo 'Use as teclas h, j, k, l para navegar!'")
end, { desc = "Warn to use hjkl instead of Up arrow" })

map({ "n", "i", "v" }, "<Down>", function()
	vim.cmd("echo 'Use as teclas h, j, k, l para navegar!'")
end, { desc = "Warn to use hjkl instead of Down arrow" })

map({ "n", "i", "v" }, "<Left>", function()
	vim.cmd("echo 'Use as teclas h, j, k, l para navegar!'")
end, { desc = "Warn to use hjkl instead of Left arrow" })

map({ "n", "i", "v" }, "<Right>", function()
	vim.cmd("echo 'Use as teclas h, j, k, l para navegar!'")
end, { desc = "Warn to use hjkl instead of Right arrow" })
