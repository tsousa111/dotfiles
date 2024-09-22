return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- lsp
			"hrsh7th/cmp-nvim-lua", -- Nvim API completions
			"hrsh7th/cmp-buffer", --buffer completions
			"hrsh7th/cmp-path", --path completions
			"hrsh7th/cmp-cmdline", --cmdline completions
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
			-- 'zbirenbaum/copilot-cmp',
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			-- require("copilot_cmp").setup()

			lspkind.init({
				symbol_map = {
					Copilot = "",
				},
			})
			vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				mapping = {
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-y>"] = cmp.mapping(
						cmp.mapping.confirm({
							behavior = cmp.ConfirmBehavior.Insert,
							select = true,
						}),
						{ "i", "c" }
					),
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						end
					end),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						end
					end),
					["<C-Space>"] = cmp.mapping({
						i = cmp.mapping.complete(),
						c = function(
							_ --[[fallback]]
						)
							if cmp.visible() then
								if not cmp.confirm({ select = true }) then
									return
								end
							else
								cmp.complete()
							end
						end,
					}),
				},

				formatting = {
					expandable_indicator = true,
					fields = { "abbr", "kind", "menu" },
					format = lspkind.cmp_format({
						with_text = true,
						menu = {
							buffer = "[buf]",
							nvim_lsp = "[lsp]",
							copilot = "[cop]",
							orgmode = "[org]",
							luasnip = "[snip]",
							nvim_lsp_signature_help = "[sig]",
							nvim_lua = "[lua]",
							path = "[path]",
						},
					}),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lua" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					--{ name = "nvim_lsp_signature_help" },
					{ name = "path" },
					{ name = "copilot" },
					{ name = "orgmode" },
				}, {
					--This sources will only show up if there aren't any sources from the other list
					{ name = "buffer", keyword_length = 5 },
				}),
				sorting = {
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,

						-- copied from cmp-under, but I don't think I need the plugin for this.
						-- I might add some more of my own.
						function(entry1, entry2)
							local _, entry1_under = entry1.completion_item.label:find("^_+")
							local _, entry2_under = entry2.completion_item.label:find("^_+")
							entry1_under = entry1_under or 0
							entry2_under = entry2_under or 0
							if entry1_under > entry2_under then
								return false
							elseif entry1_under < entry2_under then
								return true
							end
						end,

						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				experimental = {
					ghost_text = true,
					native_menu = false,
				},
			})
		end,
	},

	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("copilot").setup({
	-- 			suggestion = {
	-- 				enabled = true,
	-- 				auto_trigger = true,
	-- 				keymap = {
	-- 					accept = "<C-q>",
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
			"folke/neodev.nvim",
			{
				"j-hui/fidget.nvim",
				opts = {
					notification = {
						window = {
							winblend = 0,
						},
					},
				},
			},
		},
		config = function()
			require("neodev").setup({})

			require("mason").setup({
				PATH = "skip",
				ui = {
					icons = {
						package_installed = "",
						package_pending = "󱥸",
						package_uninstalled = "",
					},
				},
			})

			-- keybinds for diagnostics
			vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<leader>ve", vim.diagnostic.setloclist)

			-- autocmd LSP keybinds
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("TsousaLspConfig", {}),
				callback = function(e)
					local bufopts = { buffer = e.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, bufopts)
					vim.keymap.set("n", "<leader>wss", vim.lsp.buf.workspace_symbol, bufopts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
					-- vim.keymap.set('n', '<leader>fo', function() vim.lsp.buf.format { async = true } end, bufopts)
					vim.keymap.set({ "n", "v" }, "<leader>fo", function()
						require("conform").format({ lsp_fallback = true })
					end, bufopts)
					vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, bufopts)
				end,
			})

			local lspconfig = require("lspconfig")
			-- ADD NVIM CMP AS A CAPABILITY
			local lsp_defaults = lspconfig.util.default_config

			local capabilities =
				vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())
			-- external (non mason) lsps
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				cmd = {
					"rustup",
					"run",
					"stable",
					"rust-analyzer",
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
				},
				automatic_installation = true,
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({
							capabilities = capabilities,
						})
					end,
					-- add here other custom overrides
					["hls"] = function()
						lspconfig.hls.setup({
							settings = {
								haskell = {
									formattingProvider = "fourmolu",
									plugin = {
										stan = { globalOn = false },
										hlint = { config = { flags = { "--ignore=Eta reduce" } } },
									},
								},
							},
						})
					end,
					["lua_ls"] = function()
						lspconfig.lua_ls.setup({
							settings = {
								Lua = {
									telemetry = { enable = false },
								},
							},
						})
					end,
				},
			})
		end,
	},
}
