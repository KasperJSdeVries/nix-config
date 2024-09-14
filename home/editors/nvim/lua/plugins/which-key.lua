return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
		local which_key = require("which-key")

		which_key.setup({
			plugins = {
				spelling = false,
			},
			presets = {
				operators = false,
				motions = false,
				text_objects = false,
				windows = false,
				nav = false,
				z = false,
				g = false,
			},
			window = {
				border = "single",
			},
		})
	end,
}
