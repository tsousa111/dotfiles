return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false, -- o branch main não suporta lazy-loading
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"toml",
				"vim",
				"vimdoc",
				"yaml",
				"dockerfile",
				"go",
				"haskell",
				"rust",
			},
		},
		config = function(_, opts)
			require("nvim-treesitter").install(opts.ensure_installed)

			-- highlight + indent para qualquer filetype com parser instalado
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("tsousa_treesitter", { clear = true }),
				callback = function(ev)
					if pcall(vim.treesitter.start, ev.buf) then
						vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		lazy = false,
		config = function()
			require("nvim-treesitter-textobjects").setup({
				move = { set_jumps = true },
			})

			local move = require("nvim-treesitter-textobjects.move")
			local maps = {
				["]f"] = { move.goto_next_start, "@function.outer" },
				["]c"] = { move.goto_next_start, "@class.outer" },
				["]F"] = { move.goto_next_end, "@function.outer" },
				["]C"] = { move.goto_next_end, "@class.outer" },
				["[f"] = { move.goto_previous_start, "@function.outer" },
				["[c"] = { move.goto_previous_start, "@class.outer" },
				["[F"] = { move.goto_previous_end, "@function.outer" },
				["[C"] = { move.goto_previous_end, "@class.outer" },
			}
			for lhs, m in pairs(maps) do
				vim.keymap.set({ "n", "x", "o" }, lhs, function()
					m[1](m[2], "textobjects")
				end)
			end
		end,
	},
	{
		"romgrk/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				throttle = true, -- Throttles plugin updates (may improve performance)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				show_all_context = false,
				patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
					-- For all filetypes
					-- Note that setting an entry here replaces all other patterns for this entry.
					-- By setting the 'default' entry below, you can control which nodes you want to
					-- appear in the context window.
					default = {
						"function",
						"method",
						"for",
						"while",
						"if",
						"switch",
						"case",
					},

					rust = {
						"loop_expression",
						"impl_item",
					},

					typescript = {
						"class_declaration",
						"abstract_class_declaration",
						"else_clause",
					},
				},
			})
		end,
	},
}
