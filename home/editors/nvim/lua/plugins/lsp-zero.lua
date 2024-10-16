---@globals vim
return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v4.x",
	dependencies = {
		"neovim/nvim-lspconfig",
		"nvim-telescope/telescope.nvim",
		"L3MON4D3/LuaSnip",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local lsp_zero = require("lsp-zero")

		local lsp_attach = function(_, bufnr)
			---@param description string
			---@return table
			local opts = function(description)
				return { buffer = bufnr, remap = false, desc = description }
			end

			local telescope = require("telescope.builtin")

			vim.keymap.set("n", "gd", function()
				telescope.lsp_definitions({ reuse_win = true })
			end, opts("Goto Definition"))
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Goto Declaration"))
			vim.keymap.set("n", "gr", function()
				telescope.lsp_references({ reuse_win = true })
			end, opts("Goto References"))
			vim.keymap.set("n", "gI", function()
				telescope.lsp_implementations({ reuse_win = true })
			end, opts("Goto Implementation"))
			vim.keymap.set("n", "gy", function()
				telescope.lsp_type_definitions({ reuse_win = true })
			end, opts("Goto T[y]pe Definition"))

			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, opts(""))

			vim.keymap.set("n", "<leader>vws", function()
				telescope.lsp_workspace_symbols({ reuse_win = true })
			end, opts("find [w]orkspace [s]ymbol"))

			vim.keymap.set("n", "<leader>vd", function()
				vim.diagnostic.open_float()
			end, opts("open [d]iagnostics window"))
			vim.keymap.set("n", "<leader>[d", function()
				vim.diagnostic.goto_next()
			end, opts("Next diagnostic"))
			vim.keymap.set("n", "<leader>]d", function()
				vim.diagnostic.goto_prev()
			end, opts("Previous diagnostic"))

			vim.keymap.set({ "n", "v" }, "<leader>vca", function()
				vim.lsp.buf.code_action()
			end, opts("Code Action"))
			vim.keymap.set("n", "<leader>vrn", function()
				vim.lsp.buf.rename()
			end, opts("Rename"))
			vim.keymap.set("n", "<C-h>", function()
				vim.lsp.buf.signature_help()
			end, opts(""))
		end

		lsp_zero.extend_lspconfig({
			sign_text = true,
			lsp_attach = lsp_attach,
			float_boarder = "rounded",
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})

		local cmp = require("cmp")
		local cmp_action = lsp_zero.cmp_action()
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			sources = {
				{ name = "path" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "luasnip", keyword_length = 2 },
				{ name = "buffer", keyword_length = 3 },
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-y>"] = cmp.mapping.confirm({ select = true }),

				["<C-space>"] = cmp.mapping.complete(),

				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),

				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
			}),
			formatting = lsp_zero.cmp_format({ details = true }),
		})

		require("lspconfig").lua_ls.setup(lsp_zero.nvim_lua_ls())

		lsp_zero.setup_servers({
			"clangd",
			"cssls",
			"docker_compose_language_service",
			"dockerls",
			"gdscript",
			"gdshader_lsp",
			"glslls",
			"gopls",
			"html",
			"jsonls",
			"neocmake",
			"nil_ls",
			"rust_analyzer",
			"svelte",
			"ts_ls",
			"yamlls",
			"zls",
		})
	end,
}
