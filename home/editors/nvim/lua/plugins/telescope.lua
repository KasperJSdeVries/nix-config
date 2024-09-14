return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "find in [f]iles" })
		vim.keymap.set("n", "<leader><leader>", function()
			if require("utils.git").is_inside_git_repo() then
				builtin.git_files()
			else
				builtin.find_files()
			end
		end)
		vim.keymap.set("n", "<leader>ps", function()
			vim.ui.input({ prompt = "Grep: " }, function(input)
				if input and input ~= "" then
					builtin.grep_string({ search = input })
				end
			end)
		end, { desc = "[s]earch with grep" })
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "show [h]elp tags" })
	end,
}
