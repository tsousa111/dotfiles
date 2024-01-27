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
    use("stevearc/dressing.nvim")
    use({
        "folke/todo-comments.nvim",
        requires = { "nvim-lua/plenary.nvim" }
    })

    -- fidget change when rewrite version comes out
    use("j-hui/fidget.nvim")

    use("norcalli/nvim-colorizer.lua")

    use("lervag/vimtex")

    use({
        "hrsh7th/nvim-cmp",
        requires = {
            'hrsh7th/cmp-nvim-lsp',                -- lsp
            'hrsh7th/cmp-nvim-lua',                -- Nvim API completions
            'hrsh7th/cmp-nvim-lsp-signature-help', -- Show function signatures
            'hrsh7th/cmp-buffer',                  --buffer completions
            'hrsh7th/cmp-path',                    --path completions
            'hrsh7th/cmp-cmdline',                 --cmdline completions
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
            'saadparwaiz1/cmp_luasnip',
        },
    })

    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig")
    use("nvimtools/none-ls.nvim")

    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })


    use("nvim-orgmode/orgmode")
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons" }
    })

    use("nvim-treesitter/playground")
    use("romgrk/nvim-treesitter-context")

    use("runoshun/vim-alloy")
    -- Colorscheme section
    use("catppuccin/nvim")
    use("ellisonleao/gruvbox.nvim")
end)
