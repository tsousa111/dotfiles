require'nvim-treesitter.configs'.setup {
    ensure_installed = {"vim","help","python","rust","lua","haskell","c","java", "bash"},
    sync_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
