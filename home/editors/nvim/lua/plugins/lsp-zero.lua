---@globals vim
return {
    "VonHeikemen/lsp-zero.nvim",
    branch = 'v3.x',
    --lazy = true,
    dependencies = {
        -- LSP Support
        'neovim/nvim-lspconfig',

        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',

        -- Snippets
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
    },
    config = function()
        local lsp = require("lsp-zero").preset("recommended")

        lsp.on_attach(function(_, bufnr)
            ---@param description string
            ---@return table
            local opts = function(description)
                return { buffer = bufnr, remap = false, desc = description }
            end

            vim.keymap.set("n", "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end,
                opts("Goto Definition"))
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Goto Declaration"))

            vim.keymap.set("n", "gI",
                function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end,
                opts("Goto Implementation"))
            vim.keymap.set("n", "gy",
                function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end,
                opts("Goto T[y]pe Definition"))

            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts(""))

            vim.keymap.set("n", "<leader>vws",
                function() require("telescope.builtin").lsp_workspace_symbols({ reuse_win = true }) end,
                opts("find [w]orkspace [s]ymbol"))

            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end,
                opts("open [d]iagnostics window"))
            vim.keymap.set("n", "<leader>[d", function() vim.diagnostic.goto_next() end, opts("Next diagnostic"))
            vim.keymap.set("n", "<leader>]d", function() vim.diagnostic.goto_prev() end, opts("Previous diagnostic"))

            vim.keymap.set({ "n", "v" }, "<leader>vca", function() vim.lsp.buf.code_action() end, opts("Code Action"))
            vim.keymap.set("n", "<leader>vrr",
                function() require("telescope.builtin").lsp_references({ reuse_win = true }) end, opts("Find References"))
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts("Rename"))
            vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts(""))
        end)

        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'luasnip', keyword_length = 2 },
                { name = 'buffer',  keyword_length = 3 },
            },
            formatting = lsp.cmp_format(),
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-space>'] = cmp.mapping.complete(),
            })
        })

        require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

        lsp.setup_servers({
            'clangd',
            'cssls',
            'docker_compose_language_service',
            'dockerls',
            'gdscript',
            'gdshader_lsp',
            'glslls',
            'gopls',
            'html',
            'jsonls',
            'neocmake',
            'nil_ls',
            'rust_analyzer',
            'svelte',
            'tsserver',
            'yamlls',
            'zls',
        })
    end
}
