require'nvim-treesitter.configs'.setup {
    ensure_installed = {"lua","vim","python","rust","haskell","c","java", "bash","go"},
    sync_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
