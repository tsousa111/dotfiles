return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        require('telescope').setup({
            defaults = require('telescope.themes').get_ivy({
                file_ignore_patterns = { "node_modules" },
            }),
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}
