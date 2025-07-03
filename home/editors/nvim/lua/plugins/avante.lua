return {
	"yetone/avante.nvim",
	build = function()
		if vim.fn.has("win32") == 1 then
			return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		else
			return "make BUILD_FROM_SOURCE=true"
		end
	end,
	event = "VeryLazy",
	version = false,
	---@module 'avante'
	---@type avante.Config
	opts = {
		provider = "ollama",
		providers = {
			ollama = {
				endpoint = "http://localhost:11434",
				model = "qwen2.5-coder:32b",
			},
		},
		rag_service = {
			enabled = true,
			host_mount = os.getenv("HOME"),
			runner = "nix",
			llm = {
				provider = "ollama",
				endpoint = "http://localhost:11434",
				api_key = "",
				model = "qwen2.5-coder:32b",
				extra = nil,
			},
			embed = {
				provider = "ollama",
				endpoint = "http://localhost:11434",
				api_key = "",
				model = "nomic-embed-text",
				extra = {
					embed_patch_size = 10,
				},
			},
		},
		web_search_engine = {
			provider = "searxng",
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-telescope/telescope.nvim",
		"hrsh7th/nvim-cmp",
		"stevearc/dressing.nvim",
		"folke/snacks.nvim",
		"nvim-tree/nvim-web-devicons",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_tyes = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
