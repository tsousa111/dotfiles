return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp', -- lsp
            'hrsh7th/cmp-nvim-lua', -- Nvim API completions
            'hrsh7th/cmp-buffer',   --buffer completions
            'hrsh7th/cmp-path',     --path completions
            'hrsh7th/cmp-cmdline',  --cmdline completions
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
            'onsails/lspkind.nvim',
            -- 'zbirenbaum/copilot-cmp',
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")

            -- require("copilot_cmp").setup()

            lspkind.init {
                symbol_map = {
                    Copilot = "",
                },
            }
            vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

            require("luasnip.loaders.from_vscode").lazy_load()

            local check_backspace = function()
                local col = vim.fn.col "." - 1
                return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
            end

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = {
                    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-y>"] = cmp.mapping.confirm({
                            behavior = cmp.ConfirmBehavior.Insert,
                            select = true
                        },
                        { "i", "c" }
                    ),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

                    ["<C-k>"] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif check_backspace() then
                            fallback()
                        else
                            fallback()
                        end
                    end),
                    ["<C-j>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end
                    ),
                },
                formatting = {
                    -- fields = { "kind", "abbr", "menu" },
                    format = lspkind.cmp_format {
                        with_text = true,
                        menu = {
                            buffer = "[buf]",
                            nvim_lsp = "[lsp]",
                            copilot = "[cop]",
                            luasnip = "[snip]",
                            nvim_lsp_signature_help = "[sig]",
                            nvim_lua = "[lua]",
                            path = "[path]",
                        },
                    },
                },
                sources = cmp.config.sources(
                    {
                        { name = "nvim_lua" },
                        { name = "nvim_lsp", },
                        { name = "luasnip" },
                        --{ name = "nvim_lsp_signature_help" },
                        { name = "path" },
                        { name = "copilot" },
                        { name = "orgmode" },
                    },
                    {
                        --This sources will only show up if there aren't any sources from the other list
                        { name = "buffer", keyword_length = 5 },
                    }
                ),
                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,

                        -- copied from cmp-under, but I don't think I need the plugin for this.
                        -- I might add some more of my own.
                        function(entry1, entry2)
                            local _, entry1_under = entry1.completion_item.label:find "^_+"
                            local _, entry2_under = entry2.completion_item.label:find "^_+"
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
            }
        end,
    },
    {
        'zbirenbaum/copilot.lua',
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    keymap = { accept = "<C-q>" },
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "williamboman/mason-lspconfig.nvim",
            "williamboman/mason.nvim",
            "j-hui/fidget.nvim",
        },
        config = function()
            require("fidget").setup({
                notification = {
                    window = {
                        winblend = 0,
                    }
                }
            })

            vim.api.nvim_create_augroup("_mason", { clear = true })
            require("mason").setup({
                PATH = "skip",
                ui = {
                    icons = {
                        package_installed = "",
                        package_pending = "󱥸",
                        package_uninstalled = ""
                    }
                },
                max_concurrent_installers = 10,
            })

            local mason_lspconfig = require("mason-lspconfig")

            local lspconfig = require("lspconfig")

            -- ADD NVIM CMP AS A CAPABILITY
            local lsp_defaults = lspconfig.util.default_config

            local capabilities = vim.tbl_deep_extend(
                'force',
                lsp_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            -- keybinds for diagnostics
            vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

            -- external (non mason) lsps
            lspconfig.rust_analyzer.setup({
                on_init = on_init,
                flags = lsp_flags,
                capabilities = capabilities,
                cmd = {
                    "rustup", "run", "stable", "rust-analyzer",
                }
            })

            mason_lspconfig.setup({
                ensure_installed = {
                    lua_ls,
                },
                automatic_installation = true,
                handlers = {
                    function(server_name)
                        lspconfig[server_name].setup({
                            on_init = on_init,
                            flags = lsp_flags,
                            capabilities = capabilities,
                        })
                    end,
                    -- add here other custom overrides
                    ["lua_ls"] = function()
                        lspconfig.lua_ls.setup({
                            settings = {
                                Lua = {
                                    diagnostics = { globals = { "vim" } }
                                }
                            }
                        })
                    end,
                }
            })
        end
    },
}
