local color = "catppuccin"
local background = "dark"
function SetColor()
    vim.cmd.colorscheme(color)
    vim.opt.background = background
end

return {
    {
        "catppuccin/nvim",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                -- flavour = "macchiato", -- latte, frappe, macchiato, mocha
                background = {
                    dark = "macchiato",
                    light = "mocha",
                },
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
                SetColor()
            })
        end
    },

    {
        "sainnhe/gruvbox-material",
        priority = 1000,
        config = function()
            local contrast = "hard"
            if background == "light" then
                contrast = "soft"
            end
            vim.g.gruvbox_material_background = contrast
            vim.g.gruvbox_material_foreground = "material"
            SetColor()
        end
    },
}
