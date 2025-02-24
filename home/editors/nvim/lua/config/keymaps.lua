vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "open directory listing" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "[p]aste without changing pastebuffer" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[y]ank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank line to system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "[d]elete without changing pastebuffer" })

vim.keymap.set("n", "Q", "<nop>")
