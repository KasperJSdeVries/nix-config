return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup()

			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():add()
			end, { desc = "[a]dd file to harpoon" })
			vim.keymap.set("n", "<leader>h", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "open [h]arpoon window" })
			vim.keymap.set("n", "<C-p>", function()
				harpoon:list():prev()
			end)
			vim.keymap.set("n", "<C-n>", function()
				harpoon:list():next()
			end)
		end,
	},
}
