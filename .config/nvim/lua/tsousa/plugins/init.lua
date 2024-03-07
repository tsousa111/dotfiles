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
	"laytan/cloak.nvim",
	{
		"jbyuki/instant.nvim",
		config = function()
			vim.g.instant_username = "tsousa"
		end,
	},
}
