return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.rustfmt,
                null_ls.builtins.formatting.blue,
                null_ls.builtins.formatting.shfmt,
                null_ls.builtins.formatting.prettierd.with({
                    filetypes = { "html", "json", "yaml", "markdown" },
                }),
            }
        })
    end
}
