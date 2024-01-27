return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',                -- lsp
            'hrsh7th/cmp-nvim-lua',                -- Nvim API completions
            'hrsh7th/cmp-nvim-lsp-signature-help', -- Show function signatures
            'hrsh7th/cmp-buffer',                  --buffer completions
            'hrsh7th/cmp-path',                    --path completions
            'hrsh7th/cmp-cmdline',                 --cmdline completions
            'L3MON4D3/LuaSnip',
        },
        config = function()
            local cmp_status_ok, cmp = pcall(require, "cmp")
            if not cmp_status_ok then
                return
            end

            local snip_status_ok, luasnip = pcall(require, "luasnip")
            if not snip_status_ok then
                return
            end

            require("luasnip/loaders/from_vscode").lazy_load()

            local check_backspace = function()
                local col = vim.fn.col "." - 1
                return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
            end

            -- 󰃐 󰆩 󰙅 󰛡  󰅲 some other good icons
            local kind_icons = {
                Text = "󰉿",
                Method = "m",
                Function = "󰊕",
                Constructor = "",
                Field = "",
                Variable = "󰆧",
                Class = "󰌗",
                Interface = "",
                Module = "",
                Property = "",
                Unit = "",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰇽",
                Struct = "",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰊄",
            }

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = {
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ["<C-e>"] = cmp.mapping {
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    },
                    -- Accept currently selected item. If none selected, do nothing.
                    ["<CR>"] = cmp.mapping.confirm { select = false },
                    ["<C-k>"] = cmp.mapping(function(fallback)
                        if luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.expand_or_jumpable() then
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
                    ["<C-n>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, {
                        "i",
                        "s",
                    }),
                    ["<C-p>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, {
                        "i",
                        "s",
                    }),
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        -- Kind icons
                        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                        -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                        vim_item.menu = ({
                            nvim_lsp = "(LSP)",
                            luasnip = "(Snippet)",
                            buffer = "(Text)",
                            nvim_lsp_signature_help = "(Signature)",
                            nvim_lua = "(Nvim LSP)",
                            path = "(Path)",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                sources = cmp.config.sources(
                    {
                        {
                            name = "nvim_lsp",
                            entry_filter = function(entry, context)
                                local kind = entry:get_kind()
                                local line = context.cursor_line
                                local col = context.cursor.col
                                local char_before_cursor = string.sub(line, col - 1, col - 1)

                                if char_before_cursor == "." then
                                    if kind == 2 or kind == 5 then
                                        return true
                                    else
                                        return false
                                    end
                                elseif string.match(line, "^%s*%w*$") then
                                    if kind == 3 or kind == 6 then
                                        return true
                                    else
                                        return false
                                    end
                                end
                                return true
                            end

                        },
                        { name = 'nvim_lua' },
                        { name = 'luasnip' },
                        { name = 'nvim_lsp_signature_help' },
                        { name = 'path' },
                        { name = 'orgmode' }
                    },
                    {
                        --This sources will only show up if there aren't any sources from the other list
                        { name = "buffer", keyword_length = 5 },
                    }
                ),
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                window = {
                    documentation = cmp.config.window.bordered(),
                    completion = cmp.config.window.bordered({
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None"
                    })

                },
                experimental = {
                    ghost_text = true,
                    native_menu = false,
                },
            }
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "williamboman/mason.nvim",
        },
        config = function()
            vim.api.nvim_create_augroup("_mason", { clear = true })
            require("mason").setup({
                PATH = "skip",
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    },
                },
                max_concurrent_installers = 10,
            })

            local mason_lspconfig = require "mason-lspconfig"

            mason_lspconfig.setup({
                ensure_installed = {},
                automatic_installation = true
            })


            local opts = { noremap = true, silent = true }
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(client, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
                vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, bufopts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
                vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
                vim.keymap.set('n', '<space>ge', function() vim.diagnostic.goto_next() end, bufopts)
                vim.keymap.set('n', '<space>gE', function() vim.diagnostic.goto_prev() end, bufopts)
                vim.keymap.set('n', '<space>fo', function() vim.lsp.buf.format { async = true } end, bufopts)
            end

            local lspconfig = require "lspconfig"

            -- ADD NVIM CMP AS A CAPABILITY
            local lsp_defaults = lspconfig.util.default_config

            local capabilities = vim.tbl_deep_extend(
                'force',
                lsp_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            mason_lspconfig.setup_handlers {

                -- This is a default handler that will be called for each installed server (also for new servers that are installed during a session)
                function(server_name)
                    lspconfig[server_name].setup {
                        on_attach = on_attach,
                        on_init = on_init,
                        flags = lsp_flags,
                        capabilities = capabilities,
                    }
                end,
            }
        end
    }
}
