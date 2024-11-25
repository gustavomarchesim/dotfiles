local map = vim.keymap.set
local opts = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}
-- Modo normal: comandos gerais
map("n", ";", ":", { desc = "CMD enter command mode" }) -- entrar no modo de comando

-- Modo de inserção: movimentos do cursor
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" }) -- início da linha
map("i", "<C-e>", "<End>", { desc = "move end of line" }) -- fim da linha
map("i", "<C-h>", "<Left>", { desc = "move left" }) -- esquerda
map("i", "<C-l>", "<Right>", { desc = "move right" }) -- direita
map("i", "<C-j>", "<Down>", { desc = "move down" }) -- baixo
map("i", "<C-k>", "<Up>", { desc = "move up" }) -- cima

-- Modo normal: navegação entre janelas
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" }) -- janela à esquerda
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" }) -- janela à direita
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" }) -- janela abaixo
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" }) -- janela acima

-- Modo normal: salvar arquivo
map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" }) -- salvar arquivo

-- Modo normal e visual: comentários
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true }) -- alternar comentário na linha
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true }) -- alternar comentário na seleção

-- NvimTree: gerenciamento de arquivos
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" }) -- abrir/fechar
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" }) -- focar

-- Tabufline: gerenciamento de buffers
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" }) -- novo buffer
map("n", "<tab>", function()
	require("nvchad.tabufline").next()
end, { desc = "buffer goto next" }) -- próximo buffer
map("n", "<S-tab>", function()
	require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" }) -- buffer anterior
map("n", "<leader>x", function()
	require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" }) -- fechar buffer

-- Terminais novos
map("n", "<leader>h", function()
	require("nvchad.term").new({ pos = "sp" })
end, { desc = "terminal new horizontal term" }) -- terminal horizontal
map("n", "<leader>v", function()
	require("nvchad.term").new({ pos = "vsp" })
end, { desc = "terminal new vertical term" }) -- terminal vertical

-- Terminais alternáveis
map({ "n", "t" }, "<A-v>", function()
	require("nvchad.term").toggle({ pos = "vsp", id = "vtoggleTerm" })
end, { desc = "terminal toggleable vertical term" }) -- alternar terminal vertical
map({ "n", "t" }, "<A-h>", function()
	require("nvchad.term").toggle({ pos = "sp", id = "htoggleTerm" })
end, { desc = "terminal toggleable horizontal term" }) -- alternar terminal horizontal
map({ "n", "t" }, "<A-i>", function()
	require("nvchad.term").toggle({ pos = "float", id = "floatTerm" })
end, { desc = "terminal toggle floating term" }) -- alternar terminal flutuante

-- Navegação Tmux
map("n", "<C-h>", ":TmuxNavigateLeft<CR>", opts)
map("n", "<C-j>", ":TmuxNavigateDown<CR>", opts)
map("n", "<C-k>", ":TmuxNavigateUp<CR>", opts)
map("n", "<C-l>", ":TmuxNavigateRight<CR>", opts)
map("n", "<C-\\>", ":TmuxNavigatePrevious<CR>", opts)
