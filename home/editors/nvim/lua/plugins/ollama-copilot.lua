return {
	"jacob411/Ollama-Copilot",
	opts = {
		model_name = "codegemma:2b",
		ollama_url = "http://localhost:11434",
		stream_suggestion = true,
		python_command = "nvim-python3",
		filetypes = { "lua", "markdown", "c", "nix", "json", "vim", "python", "cmake", "yaml" },
	},
}
