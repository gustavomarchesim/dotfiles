local map = vim.keymap.set
local builtin = require("telescope.builtin")

-- Função auxiliar para as opções
local function opts(desc)
  return { desc = "LSP " .. desc }
end

-- ========== 1. Comandos Gerais ==========
map("n", ";", ":", { desc = "Enter command mode (CMD)" })
map({ "n", "v" }, "H", "^", { desc = "Move to start of line" })
map({ "n", "v" }, "L", "$", { desc = "Move to end of line" })
map({ "i", "v" }, "jk", "<ESC>", { desc = "Exit insert/visual mode" })
map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- ========== 2. Movimentos do Cursor ==========
-- Modo de inserção
map("i", "<C-h>", "<Left>", { desc = "Move cursor left" })
map("i", "<C-l>", "<Right>", { desc = "Move cursor right" })
map("i", "<C-j>", "<Down>", { desc = "Move cursor down" })
map("i", "<C-k>", "<Up>", { desc = "Move cursor up" })

-- Navegação entre janelas
map("n", "<C-h>", "<C-w>h", { desc = "Focus window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus window below" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus window above" })

-- ========== 3. Gerenciamento de Arquivos ==========
-- NvimTree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Focus on NvimTree window" })

-- Criação de buffer e navegação
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

-- ========== 4. Terminais ==========
-- Abrir terminais
map("n", "<leader>h", ":sp<CR>", { desc = "Split terminal horizontally" })
map("n", "<leader>v", ":vsp<CR>", { desc = "Split terminal vertically" })

-- Alternar entre terminais
map({ "n", "t" }, "<leader>tv", function()
  require("nvchad.term").toggle({ pos = "vsp", id = "vtoggleTerm" })
end, { desc = "Toggle vertical terminal" })
map({ "n", "t" }, "<leader>th", function()
  require("nvchad.term").toggle({ pos = "sp", id = "htoggleTerm" })
end, { desc = "Toggle horizontal terminal" })
map({ "n", "t" }, "<leader>tf", function()
  require("nvchad.term").toggle({ pos = "float", id = "floatTerm" })
end, { desc = "Toggle floating terminal" })

-- ========== 5. Git ==========
-- Gitsigns
map("n", "<leader>gp", function()
  require("gitsigns").preview_hunk()
end, { desc = "Git: Preview hunk" })
map("n", "<leader>gb", function()
  require("gitsigns").toggle_current_line_blame()
end, { desc = "Git: Toggle inline blame" })

-- LazyGit
map("n", "<leader>gl", "<cmd>LazyGit<cr>", { desc = "Git: Open LazyGit" })

-- ========== 6. LSP ==========
map("n", "<leader>cK", vim.lsp.buf.hover, { desc = "Show hover information" })
map("n", "<leader>cD", vim.lsp.buf.declaration, opts("Go to declaration"))
map("n", "<leader>cd", vim.lsp.buf.definition, opts("Go to definition"))
map("n", "<leader>ci", vim.lsp.buf.implementation, opts("Go to implementation"))
map("n", "<leader>cs", vim.lsp.buf.signature_help, opts("Show signature help"))
map("n", "<leader>ca", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
map("n", "<leader>cr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
map("n", "<leader>cl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts("List workspace folders"))
map("n", "<leader>ct", vim.lsp.buf.type_definition, opts("Go to type definition"))
map("n", "<leader>cn", vim.lsp.buf.rename, opts("Rename"))
map({ "n", "v" }, "<leader>cc", vim.lsp.buf.code_action, opts("Code action"))
map("n", "<leader>cf", vim.lsp.buf.references, opts("Show references"))

-- ========== 7. Telescope ==========
map("n", "<C-p>", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
map("n", "<leader>ff", ":Telescope file_browser<CR>", { desc = "Telescope file browser" })

-- ========== 8. Avisos e Navegação ==========
-- Aviso ao usar teclas de seta
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
