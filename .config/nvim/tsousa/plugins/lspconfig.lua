local present, mason = pcall(require, "mason")

vim.api.nvim_create_augroup("_mason", { clear = true })

local options = {
  PATH = "skip",

  ui = {
    icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },

  max_concurrent_installers = 10,
}

mason.setup(options)

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