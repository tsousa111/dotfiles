return {
    "nvim-orgmode/orgmode",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "akinsho/org-bullets.nvim",
    },
    config = function()
        -- -- Load custom treesitter grammar for org filetype
        require("org-bullets").setup({
            symbols = {
                headlines = { "◉", "○", "●", "✸" },
                checkboxes = false,
            },
        })
        -- require('orgmode').setup_ts_grammar()
        -- -- Treesitter configuration
        -- require('nvim-treesitter.configs').setup {
        --     -- If TS highlights are not enabled at all, or disabled via `disable` prop,
        --     -- highlighting will fallback to default Vim syntax highlighting
        --     highlight = {
        --         enable = true,
        --         -- Required for spellcheck, some LaTex highlights and
        --         -- code block highlights that do not have ts grammar
        --         additional_vim_regex_highlighting = { 'org' },
        --     },
        --     ensure_installed = { 'org' }, -- Or run :TSUpdate org
        -- }
        require('orgmode').setup({
            org_agenda_files = { '~/Nextcloud/org/**/*', '~/Nextcloud/Documents/uni/**/*' },
            org_default_notes_file = '~/Nextcloud/org/refile.org',
        })
    end
}
