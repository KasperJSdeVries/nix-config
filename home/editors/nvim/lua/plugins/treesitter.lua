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
        if type(opts.ensure_installed) == "table" then
            vim.list_extend(opts.ensure_installed, { "bibtex", "latex" })
        end
        if type(opts.highlight.disable) == "table" then
            vim.list_extend(opts.highlight.disable, { "latex", "typescript", "javascript" })
        else
            opts.highlight.disable = { "latex", "typescript", "javascript" }
        end
        if type(opts.highlight.disable) == "table" then
            vim.list_extend(opts.highlight.disable, { "svelte", "typescript" })
        else
            opts.highlight.disable = { "svelte", "typescript" }
        end
    end
}
