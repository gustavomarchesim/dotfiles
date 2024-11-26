return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_pending = " ",
						package_installed = " ",
						package_uninstalled = " ",
					},
				},
				max_concurrent_installers = 10,
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "html", "cssls", "lua_ls", "ts_ls", "jsonls" },
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Função para configuração padrão de on_attach, on_init e capabilities
			local function setup_lsp(lsp)
				lspconfig[lsp].setup({
					on_attach = function(_, _)
						-- A função on_attach não contém mais os mapeamentos de teclas.
					end,

					on_init = function(client, _)
						-- Desabilitar semanticTokens, se o servidor suportar
						if client.supports_method("textDocument/semanticTokens") then
							client.server_capabilities.semanticTokensProvider = nil
						end
					end,

					capabilities = capabilities,
				})
			end

			-- Configuração para todos os servidores listados
			local servers = { "html", "cssls", "ts_ls", "jsonls", "lua_ls" }

			for _, server in ipairs(servers) do
				setup_lsp(server)
			end
		end,
	},
}
