vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead', }, {
    pattern = { "*.frag", "*.vert", "*.glsl", "*.comp" },
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_option(buf, "filetype", "glsl")
    end
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead', }, {
    pattern = { "*.svelte" },
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_option(buf, "filetype", "svelte")
    end
})
