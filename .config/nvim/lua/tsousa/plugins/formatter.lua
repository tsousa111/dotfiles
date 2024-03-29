return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
			},
		})
		-- vim.api.nvim_create_autocmd("BufWritePre", {
		--     pattern = "*",
		--     callback = function(args)
		--         require("conform").format { bufnr = args.buf, lsp_fallback = true }
		--     end,
		-- })
		-- local null_ls = require("null-ls")
		-- null_ls.setup({
		--     sources = {
		--         null_ls.builtins.formatting.rustfmt,
		--         null_ls.builtins.formatting.blue,
		--         null_ls.builtins.formatting.shfmt,
		--         null_ls.builtins.formatting.prettierd.with({
		--             filetypes = { "html", "json", "yaml", "markdown" },
		--         }),
		--     }
		-- })
	end,
}
