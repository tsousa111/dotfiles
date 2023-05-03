require("catppuccin").setup({
    flavour = "frappe", -- latte, frappe, macchiato, mocha
    transparent_background = false,
    term_colors = false,

    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = {"italic"},
        conditionals = {"italic"},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
    },
})

function ColorMyPencils(color)
    color = color or "catppuccin"

    vim.cmd.colorscheme(color)
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
