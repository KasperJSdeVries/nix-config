local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("config.options")
require("config.keymaps")
require("config.autocommands")

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

-- Install Plugins
return lazy.setup("plugins", {
	change_detection = {
		notify = false,
	},
	dev = {
		path = "~/.local/share/nvim/nix",
		fallback = false,
	},
	performance = {
		reset_packpath = false,
		rtp = {
			reset = false,
		},
	},
})
