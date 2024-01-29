local colour = "catppuccin"
function SetColour()
    vim.cmd.colorscheme(colour)
end

return {
    {
        "catppuccin/nvim",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "macchiato", -- latte, frappe, macchiato, mocha
                transparent_background = true,
                term_colors = false,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    telescope = true,
                    treesitter = true,
                    treesitter_context = true,
                    fidget = true,
                },
                SetColour()
            })
        end
    },

    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("gruvbox").setup({
                italic = {
                    strings = false,
                    comments = true,
                    operators = false,
                    folds = true,
                },
                transparent_mode = true,
            })
            SetColour()
        end
    },
}
