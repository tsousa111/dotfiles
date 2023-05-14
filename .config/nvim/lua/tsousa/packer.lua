return require('packer').startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")
    use("tpope/vim-surround")
    use("tpope/vim-fugitive")
    use("theprimeagen/harpoon")
    use("mbbill/undotree")
    use("j-hui/fidget.nvim")

    use("norcalli/nvim-colorizer.lua")

    use("nvim-orgmode/orgmode")
    use("lervag/vimtex")

    use({"hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp", -- lsp
            "hrsh7th/cmp-buffer", --buffer completions
            "hrsh7th/cmp-path", --path completions
            "hrsh7th/cmp-cmdline" --cmdline completions
        },
    })

    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("hrsh7th/cmp-nvim-lsp")
    use("neovim/nvim-lspconfig")
    use("mfussenegger/nvim-jdtls")
    use("jose-elias-alvarez/null-ls.nvim")
    use({"L3MON4D3/LuaSnip",
			requires = {
				"saadparwaiz1/cmp_luasnip"
			},
		})

    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })
    use('nvim-lualine/lualine.nvim')

    use("nvim-treesitter/playground")
    use("romgrk/nvim-treesitter-context")

    -- Colorscheme section
    use("catppuccin/nvim")
    use("folke/tokyonight.nvim")
end)
