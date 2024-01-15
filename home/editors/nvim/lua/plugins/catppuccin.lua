return {
    "catppuccin/nvim", name = "catppuccin", priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            transparent_background = true,
            integrations = {
                cmp = true,
                treesitter = true,
                telescope = {
                    enabled = true,
                    -- style = "nvchad"
                },
                which_key = true,
            },
        })

        vim.cmd.colorscheme "catppuccin"
    end
}
