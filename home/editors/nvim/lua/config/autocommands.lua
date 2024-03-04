vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead', }, {
    pattern = { "*.frag", "*.vert", "*.glsl" },
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_option(buf, "filetype", "glsl")
    end
})
