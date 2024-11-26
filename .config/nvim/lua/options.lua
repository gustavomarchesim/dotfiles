local opt = vim.opt
local o = vim.o
local g = vim.g

-- Configurações gerais
o.laststatus = 3            -- status global para a barra de status
o.showmode = false          -- desativa a exibição do modo atual (ex.: --INSERT--)
o.clipboard = "unnamedplus" -- usa o clipboard do sistema
o.cursorline = true         -- ativa a linha de cursor
o.cursorlineopt = "number"  -- realça apenas o número da linha do cursor

-- Indentação
o.expandtab = true   -- usa espaços ao invés de tabulações
o.shiftwidth = 2     -- número de espaços para o recuo
o.smartindent = true -- indentação inteligente
o.tabstop = 2        -- número de espaços para uma tabulação
o.softtabstop = 2    -- número de espaços ao pressionar tab

-- Aparência
opt.fillchars = { eob = " " } -- remove os caracteres "~" nas linhas vazias
o.signcolumn = "yes"          -- exibe a coluna de sinais sempre
o.splitbelow = true           -- novas divisões horizontais abaixo
o.splitright = true           -- novas divisões verticais à direita

-- Pesquisa
o.ignorecase = true -- ignora maiúsculas/minúsculas na busca
o.smartcase = true  -- ativa busca sensível a maiúsculas se houver caracteres maiúsculos

-- Mouse
o.mouse = "a" -- habilita o uso do mouse em todos os modos

-- Números
o.number = true         -- exibe números nas linhas
o.numberwidth = 2       -- largura mínima para números de linha
o.relativenumber = true -- exibe números relativos às linhas
o.ruler = false         -- desativa a exibição da posição do cursor na barra de status

-- Desativa a introdução do Neovim
opt.shortmess:append("sI")

-- Tempo e desempenho
o.timeoutlen = 400 -- tempo de espera para mapas de tecla (em ms)
o.undofile = true  -- ativa o histórico de desfazer persistente
o.updatetime = 250 -- reduz o intervalo para gravar arquivos swap (melhora integração com plugins como gitsigns)

-- Movimentos do cursor
opt.whichwrap:append("<>[]hl") -- permite navegação contínua nas bordas da linha

-- Desativa provedores padrão
g.loaded_node_provider = 0    -- desativa suporte ao Node.js
g.loaded_python3_provider = 0 -- desativa suporte ao Python 3
g.loaded_perl_provider = 0    -- desativa suporte ao Perl
g.loaded_ruby_provider = 0    -- desativa suporte ao Ruby

local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath "data" .. "/mason/bin"

vim.api.nvim_set_hl(0, "IndentLine", { link = "Comment" })
