local color = "gruvbox-material"
local background = "dark"
local transparency = false
function SetColor()
	vim.cmd.colorscheme(color)
	vim.opt.background = background
	-- transparency
	if transparency then
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end
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
					light = "latte",
				},
				transparent_background = false,
				term_colors = false,
				integrations = {
					cmp = true,
					gitsigns = true,
					telescope = true,
					treesitter = true,
					treesitter_context = true,
					fidget = true,
				},
				SetColor(),
			})
		end,
	},

	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		config = function()
			local contrast = "medium"
			if background == "light" then
				contrast = "soft"
			end
			vim.g.gruvbox_material_background = contrast
			vim.g.gruvbox_material_foreground = "material"
			SetColor()
		end,
	},
}
