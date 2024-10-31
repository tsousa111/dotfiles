return {
	{
		"stevearc/dressing.nvim",
		opts = {
			select = {
				enable = false,
			},
		},
	},
	"nvim-lua/plenary.nvim",
	"tpope/vim-surround",
	"tpope/vim-repeat",
	{
		"laytan/cloak.nvim",
		config = function()
			require("cloak").setup({
				enabled = true,
				cloak_character = "*",
				highlight_group = "Comment",
				cloak_length = nil, -- Provide a number if you want to hide the true length of the value.
				try_all_patterns = true,
				cloak_telescope = true,
				cloak_on_leave = false,
				patterns = {
					{
						file_pattern = ".env*",
						cloak_pattern = "=.+",
						replace = nil,
					},
				},
			})
		end,
	},
	{
		"ThePrimeagen/vim-be-good",
		disabled = false,
	},
	{
		"jbyuki/instant.nvim",
		disabled = true,
		config = function()
			vim.g.instant_username = "tsousa"
		end,
	},
}
