return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	dev = true,
	opts = function(_, opts)
		opts.auto_install = false
		opts.sync_install = false
		opts.autopairs = {
			enable = true,
		}
		opts.highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		}
		opts.indent = {
			enable = true,
		}
	end,
}
