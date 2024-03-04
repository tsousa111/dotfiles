return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("todo-comments").setup({
            signs = true,  -- show icons in the signs column
            sign_priority = 8, -- sign priority
            -- keywords recognized as todo comments
            keywords = {
                FIX = {
                    icon = " ", -- icon used for the sign, and in search results
                    color = "error", -- can be a hex color, or a named color (see below)
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "fix" }, -- a set of other keywords that all map to this FIX keywords
                    -- signs = false, -- configure signs for some keywords individually
                },
                TODO = { icon = " ", color = "info", alt = { "todo" } },
                HACK = { icon = " ", color = "warning", alt = { "hack" } },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "warn" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "perf" } },
                NOTE = { icon = " ", color = "hint", alt = { "INFO", "info", "note" } },
                TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED", "test" } },
            },
            merge_keywords = true, -- when true, custom keywords will be merged with the defaults
            -- highlighting of the line containing the todo comment
            -- * before: highlights before the keyword (typically comment characters)
            -- * keyword: highlights of the keyword
            -- * after: highlights after the keyword (todo text)
            highlight = {
                multiline = true,            -- enable multine todo comments
                multiline_pattern = "^.",    -- lua pattern to match the next multiline from the start of the matched keyword
                multiline_context = 10,      -- extra lines that will be re-evaluated when changing a line
                before = "",                 -- "fg" or "bg" or empty
                keyword = "wide",            -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                after = "fg",                -- "fg" or "bg" or empty
                pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
                comments_only = true,        -- uses treesitter to match keywords in comments only
                max_line_len = 400,          -- ignore lines longer than this
                exclude = {},                -- list of file types to exclude highlighting
            },
        })
    end
}
